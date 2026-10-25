#!/usr/bin/env bash
# Check a short list of macOS security settings. The only thing it changes is
# the firewall: off by default on macOS, so it is turned on (with stealth mode)
# unless an MDM profile manages it. Everything else is reported, because fixing
# it needs a decision or a password prompt in System Settings.
#
#   macos/security-check.sh          check, and turn the firewall on (asks for sudo)
#   macos/security-check.sh --check  report only
set -euo pipefail

FIX=1
[ "${1:-}" = "--check" ] && FIX=0

MANAGED="/Library/Managed Preferences"
FW=/usr/libexec/ApplicationFirewall/socketfilterfw

ok()   { printf '  ok    %s\n' "$*"; }
warn() { printf '  WARN  %s\n' "$*"; }
managed() { [ -e "$MANAGED/$1.plist" ]; }

if profiles status -type enrollment 2>/dev/null | grep -q "MDM enrollment: Yes"; then
    echo "  This Mac is MDM-managed: settings the MDM controls are reported, not changed."
fi

if fdesetup status | grep -q "FileVault is On"; then
    ok "FileVault on"
else
    warn "FileVault off: System Settings > Privacy & Security > FileVault"
fi

# Stealth mode: no replies to pings or probes of closed ports.
if "$FW" --getglobalstate | grep -q "enabled" && "$FW" --getstealthmode | grep -q "is on"; then
    ok "firewall and stealth mode on"
elif managed com.apple.security.firewall; then
    warn "firewall or stealth mode off, set by MDM"
elif [ "$FIX" = 1 ]; then
    sudo "$FW" --setglobalstate on >/dev/null
    sudo "$FW" --setstealthmode on >/dev/null
    ok "firewall and stealth mode turned on"
else
    warn "firewall or stealth mode off: run macos/security-check.sh to turn them on"
fi

if spctl --status 2>/dev/null | grep -q "assessments enabled"; then
    ok "Gatekeeper on"
elif managed com.apple.systempolicy.control; then
    warn "Gatekeeper off, set by MDM"
else
    warn "Gatekeeper off: sudo spctl --global-enable"
fi

if csrutil status | grep -q "enabled"; then
    ok "System Integrity Protection on"
else
    warn "System Integrity Protection off: re-enable it from Recovery (csrutil enable)"
fi

# Security responses and XProtect/malware definitions. Unset means the macOS
# default, which is on.
for key in AutomaticCheckEnabled CriticalUpdateInstall ConfigDataInstall; do
    value=$(defaults read "$MANAGED/com.apple.SoftwareUpdate" "$key" 2>/dev/null ||
            defaults read /Library/Preferences/com.apple.SoftwareUpdate "$key" 2>/dev/null ||
            echo default)
    if [ "$value" = 0 ]; then
        warn "software update $key off: System Settings > General > Software Update > Automatic Updates"
    else
        ok "software update $key on"
    fi
done

lock=$(sysadminctl -screenLock status 2>&1 | sed -n 's/.*screenLock delay is //p')
if [ "$lock" = "immediate" ]; then
    ok "password required immediately after sleep or screen saver"
elif managed com.apple.screensaver; then
    warn "password required after: ${lock:-unknown}, set by MDM"
else
    warn "password required after: ${lock:-unknown}. Immediately is safer: System Settings > Lock Screen"
fi

#!/usr/bin/env bash
# ============================================================================
# netprivacy — macOS network privacy / VPN sanity check
# ----------------------------------------------------------------------------
# Paste this whole block into ~/.zshrc, ~/.bashrc, or a file you source from
# them, then open a new terminal and run:   netprivacy
# (Or save it as netprivacy.sh and run:     bash netprivacy.sh  — see bottom.)
#
# macOS only. Read-only: it inspects config, changes nothing.
#
# WHAT EACH CHECK MEANS AND WHAT TO EXPECT:
#
#   1. PUBLIC IDENTITY   Who the internet thinks you are.
#        GOOD (on VPN): "org" is a hosting/datacenter company (e.g. Datacamp,
#          M247, Proton) and the IP is NOT your home connection.
#        CONCERN: it shows your real ISP -> your traffic is not tunneled.
#
#   2. DNS               Which resolver actually answers your lookups.
#        GOOD (on VPN): a private 10.x resolver (Proton uses 10.2.0.1).
#        CONCERN: your router (192.168.x.x) or ISP resolver is answering
#          -> DNS leak, even if your IP is tunneled. Leftover entries in the
#          "configured" list are usually harmless; the "answering" line is
#          what actually matters.
#
#   3. PROXY             Whether traffic is forced through an intercepting proxy.
#        GOOD: nothing set (only the default *.local / 169.254 exceptions exist).
#        CONCERN: an HTTPProxy / HTTPSProxy / PAC URL you didn't configure
#          -> someone may be positioned to inspect your traffic.
#
#   4. VPN TUNNEL        Whether a tunnel is up and is the default route.
#        GOOD: a utunN interface has an inet (IPv4) address, and the primary
#          default route points through it. A second, interface-scoped default
#          via en0 is normal — that's how the encrypted packets reach the server.
#        CONCERN: no tunnel interface, or the only default route is via en0.
#
#   5. DEVICE MANAGEMENT Whether anything centrally manages this Mac.
#        GOOD (personal machine): both lines say "No".
#        CONCERN: "Yes" -> MDM can see and do a great deal regardless of any VPN.
#
#   6. CUSTOM TRUSTED ROOTS  Admin-installed roots that could decrypt your HTTPS.
#        GOOD: "no custom trust settings".
#        CONCERN: a trusted cert named after an employer or a security vendor
#          (Zscaler, Netskope, Palo Alto, Fortinet, Cisco Umbrella, etc.)
#          -> HTTPS interception is possible.
#
#   7. IPv6              A routable IPv6 address can leak around a v4-only tunnel.
#        Finish at https://ipleak.net while connected: it should show NO IPv6
#        and NO DNS tracing back to your ISP.
# ============================================================================

netprivacy() {
  echo
  echo "== 1. PUBLIC IDENTITY (who the internet sees) ============================"
  curl -s --max-time 8 https://ipinfo.io/json \
    | grep -E '"(ip|city|region|country|org)"' \
    | sed 's/^/  /' \
    || echo "  (no response — if your kill switch is ON and the VPN is down, this SHOULD fail)"

  echo
  echo "== 2. DNS (which resolver actually answers) =============================="
  if command -v dig >/dev/null 2>&1; then
    dig example.com 2>/dev/null \
      | awk -F'[()]' '/SERVER:/ {print "  answering resolver: " $2}'
  fi
  echo "  configured resolvers:"
  scutil --dns 2>/dev/null | awk '/nameserver\[/ {print "   " $3}' | sort -u

  echo
  echo "== 3. PROXY (forced traffic interception) ==============================="
  proxy=$(scutil --proxy 2>/dev/null \
    | grep -Ei 'HTTPProxy|HTTPSProxy|ProxyAutoConfigURLString|SOCKSProxy')
  if [ -z "$proxy" ]; then
    echo "  none set (good)"
  else
    echo "$proxy" | sed 's/^/  /'
    echo "  ^ a proxy is configured — investigate if you did not set this"
  fi

  echo
  echo "== 4. VPN TUNNEL + ROUTING =============================================="
  ifconfig 2>/dev/null | awk '
    /^[a-z]/      { iface=$1; isutun=($1 ~ /^utun/) }
    /inet / && isutun { print "  tunnel " iface " addr " $2 }'
  echo "  default route(s):"
  netstat -rn -f inet 2>/dev/null | awk '/^default/ {print "   via " $2 "  (iface " $NF ")"}'

  echo
  echo "== 5. DEVICE MANAGEMENT (MDM) ==========================================="
  profiles status -type enrollment 2>/dev/null | sed 's/^/  /' \
    || echo "  unable to read enrollment status"

  echo
  echo "== 6. CUSTOM TRUSTED ROOTS (HTTPS interception) ========================="
  trust=$( { security dump-trust-settings -d 2>/dev/null; \
             security dump-trust-settings    2>/dev/null; } \
           | grep -v "No Trust Settings" )
  if [ -z "$trust" ]; then
    echo "  no custom trust settings (good)"
  else
    echo "$trust" | sed 's/^/  /'
    echo "  ^ a cert has been explicitly trusted — recognize it? vendor/employer names = red flag"
  fi

  echo
  echo "== 7. IPv6 =============================================================="
  echo "  Final visual check: load https://ipleak.net while connected."
  echo "  Expect NO IPv6 address and NO DNS entry tracing to your ISP."
  echo
}

# Run the report immediately. Because the function above is also left defined,
# `source netprivacy.sh` prints the report now, and you can re-run it any time
# afterward by just typing:  netprivacy
netprivacy

OS-agnostic files are located in the root directory, OS-specific files
are located in the designated directories.

# OS-agnostic

What can stay default, stays default, custom configuration only in case when the pros outweight the cons.

General colorscheme guide: light theme tuned for long reading sessions
— slightly off-white background `#EEEEEE` (238,238,238) paired with
slightly off-black foreground `#303030` (48,48,48). Pure (255,255,255)
on (0,0,0) maximises luminance and contrast, which is fatiguing over
hours; the small step away from the extremes keeps the page legible
without burning the eyes. Various display modes (neutral, warm,
truetone, etc) come as the wrappers. Ready-to-import iTerm2 presets
(light + dark) live in `macos/iterm/`.

### Color palette (apply across apps)

Both modes sit at ~11:1 contrast — above WCAG AAA (7:1) for legibility,
short of pure black-on-white (21:1) to avoid glare/halation over long
sessions. Use these codes anywhere (editor themes, terminals, notes apps).

**Light**

| Role            | Hex       | RGB           |
| --------------- | --------- | ------------- |
| Background      | `#EEEEEE` | 238, 238, 238 |
| Foreground      | `#303030` | 48, 48, 48    |
| Bold / emphasis | `#000000` | 0, 0, 0       |

**Dark**

| Role            | Hex       | RGB           |
| --------------- | --------- | ------------- |
| Background      | `#1E1E1E` | 30, 30, 30    |
| Foreground      | `#D0D0D0` | 208, 208, 208 |
| Bold / emphasis | `#EEEEEE` | 238, 238, 238 |
| ANSI black (0)  | `#3A3A3A` | 58, 58, 58    |

Full 16-color ANSI sets for both modes are in the `macos/iterm/*.itermcolors`
presets.

`vifm` uses this same light palette, expressed as xterm-256 indices in its
inline colorscheme (`vifmrc`): `ctermbg=255` → `#EEEEEE` and `ctermfg=236`
→ `#303030` map one-to-one to the background/foreground above, and its
accents line up too (`CurrLine` `ctermbg=27` → `#005FFF` selection,
`Link` `ctermfg=39` → `#00AFFF`). Note it is hardcoded light-only, so it
stays light even when the terminal switches to the dark theme.

## Keyboard remappings

-   *Tab* TO *left\_shift*

-   *left\_shift* TO *Tab*

-   *CapsLock* TO *Backspace*

-   *§* TO *Escape*

-   *right\_alt/right\_command* TO *right\_shift*

-   *right\_shift* + *backspace* TO *delete*

-   *right\_shift* + *m* TO *Enter*

-   *right\_shift* + *a* TO *-* (hyphen)

-   *right\_shift* + *s* TO *=* (equal\_sign)

-   *right\_shift* + *d* TO *Escape*

-   *right\_shift* + *f* TO *Tab*

-   *right\_shift* + *g* TO *left\_command/left\_alt* + *Tab*

-   *right\_shift* + *c* TO *left\_shift* + *-* (underscore)

-   *right\_shift* + *v* TO *left\_shift* + *=* (plus)

-   *right\_shift* + *hjkl* TO *arrow keys*

-   *right\_shift* + *q/w/e/r/t/y/u/i/o/p* TO *left\_shift* +
    *1/2/3/4/5/6/7/8/9/0*

-   *right\_shift* + *z* TO *left\_shift* + *\`*

-   *right\_shift* + *1* TO *Launch Firefox*

-   *right\_shift* + *2* TO *Launch Eclipse*

-   *right\_shift* + *3* TO *Launch Finder/File Explorer*

-   *right\_shift* + *4* TO *Launch Terminal*

-   *right\_shift* + *5* TO *Launch Visual Studio Code*

-   *right\_shift* + *6* TO *Launch TextEdit/Notepad++*

-   *right\_shift* + *7* TO *Launch Microsoft Teams*

-   *right\_shift* + *8* TO *Launch Google Chrome*

-   *right\_shift* + *9* TO *Launch Outlook*

-   *right\_shift* + *0* TO *Launch Reminders/Microsoft To Do*

-   *right\_shift* + *ctrl* + *4* TO *Open New Terminal Tab at Folder*

-   *right\_shift* + *n* TO *Launch Notes*

## Applications

### Google Chrome browser

#### Extensions

-   Vimium C Chrome:

    -   Import the configuration file *sf/vimium-c.json* to the
        extension.

    -   In the Vimium C Options in the section "Optional permissions"
        enabling the `#extensions-on-chrome-urls` is not necessary to be
        able to use Vimium C to view PDF files in Google Chrome browser.

    -   Global marks:

        -   outlook to o

        -   microsoft to do to t

        -   whatsapp to w

        -   cambridge dictionary to c

-   PDF Viewer for Vimium C

-   uBlock Origin (adblocker). Don’t forget to import the
    `whitelist-adblocker.txt`.

-   1Password

-   Google dictionary (by Google)

-   Eye Dropper (color picker)

- pdf viewer (pdf.js), >1m users, pdfjs.robwu.nl

- Instagram Auto Logout (custom, unpacked): clears Instagram session
    cookies every 8 minutes to add friction against compulsive
    checking. Load unpacked from `chrome-extensions/instagram-auto-logout/`
    via `chrome://extensions` → Developer mode → Load unpacked.

#### Bookmarks

softdoc  
comprehensive software documentation

read-later  
topics that could be read later

organizational  
administrative, etc.

### IntelliJ IDEA

### VS Code

### Sublime Text

Near-default light setup — built-in **Celeste** color scheme plus a small
recommended package set. Config and install steps in `sublime/`.

### 1Password

### Office Suite

# Microsoft Windows OS

## Keyboard remappings and shortcuts

To make Apple Magic keyboard work with Windows download *Magic Keyboard
Utilities* software (it is important to remap right\_alt to right\_shift
in the application before using PowerToys keyboard manager).

Download and use United Kingdom (Magic Utilities) layout. Neither the US
International (unhandy quotes autocompletion), nor the standard US
layout (I like keyboards with the vertical Enter key, not the horizontal
one like in the US standard keyboard).

-   right\_shift + 1234567890 to windows key + 1234567890 (switch to the
    application from the taskbar)

-   right\_shift + spacebar to windows key + spacebar (to invoke
    PowerToys Run)

-   right\_shift + e to right\_alt + 3 (British English Magic Keyboard
    remap to be able to type \#)

-   left\_alt + q to left\_alt + F4 (to quit the focused application)

### Shortcuts

## Applications

-   PowerToys (Fancy Zones, Powertoys Run, Keyboard manager). Set to run
    PowerToys as administrator.

-   Windows Terminal. Appearance configurations: One Half Light theme;
    Download font face *Monoid*, set cursor to non-blinking purple
    block)

-   Notepad++

-   voidtools: Everything (better search)

-   Git for Windows (with the option of implementing bash functionality
    into command prompt)

-   Magic Keyboard Utilities (to use Apple Magic Keyboard with Windows)

-   AutoHotKey

## Operating system settings

-   Enable multiple clipboards (1000 items history).

-   Set taskbar location on screen to left.

-   Show taskbar on all displays.

-   Never combine taskbar items.

-   Show taskbar items on main taskbar and taskbar where window is open.

# macOS

## Operating system settings

Enhance the performance of your mac keyboard  
Enable repeating keys  
`defaults write -g ApplePressAndHoldEnabled -bool false`

Change key repeat rate to 1 from 2 (normal minimum)  
`defaults write -g KeyRepeat -int 1`

Change initial key repeat rate from **15** (standard minimum) to **10** (lower than 10 is too fast, error prone and laggy)  
`defaults write -g InitialKeyRepeat -int 10`

Use column view in all Finder windows by default  
open a finder window → view options → always column view, also browse in
column view

Show only active apps in dock  
`defaults write com.apple.dock static-only -bool true; killall Dock`

Apple shortcuts (preferences→shortcuts)  
`"open "http://www.google.com/search?q=$(ruby -rcgi -e 'print CGI.escape $<.read.chomp')"`

## Applications

-   Karabiner Elements (keyboard remapping). To make this repo the single
    source of truth, symlink the live config to the repo copy:

    ```
    ln -sf ~/sf/macos/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
    ```

    **A `git pull` or an edit to the repo copy is not applied instantly.**
    Karabiner watches `~/.config/karabiner/` for filesystem events, and writes
    that land on the symlink *target* in `~/sf/` generate no event in the
    watched directory, so nothing reloads — it keeps running the config it read
    at startup, silently, with no error anywhere. Force a reload after every
    change:

    ```
    launchctl kickstart -k gui/$(id -u)/org.pqrs.service.agent.karabiner_console_user_server
    ```

    Confirm it took by checking for a fresh `Load .../karabiner.json` line:

    ```
    tail -5 ~/.local/share/karabiner/log/console_user_server.log
    ```

    That log is the place to look whenever a binding behaves like an older
    version of itself: if the newest `Load` line predates your edit, the edit is
    not live and the key is running old code.

    Second caveat: Karabiner rewrites `karabiner.json` (atomic replace) whenever
    you change a setting in its **GUI**, which replaces the symlink with a plain
    file and forks the repo and live copies. Prefer editing the repo file and
    reloading with the command above; if you do use the GUI, copy the file back
    into the repo and re-run the `ln -sf` command.

    The `option + m` binding runs `macos/mouse-speed/toggle-mouse-speed.sh`,
    which flips pointer tracking speed (trackpad and mouse) between fast (UI
    max, 3.0) and a demo-stable 0.7, and slows scrolling alongside it. Pointer
    speed is applied live via the `mousespeed` IOKit helper (and mirrored to
    `defaults`). Scroll is handled by a separate `scrollslow` helper that
    installs a `CGEventTap` and scales scroll deltas to `0.3` — this is used
    instead of the HID scroll-acceleration curve because that curve slows the
    trackpad but is ignored by hi-res mice (e.g. Logitech MX), whereas the tap
    slows both uniformly. Demo mode launches the tap and fast mode kills it, so
    nothing runs during normal use. The tap needs a one-time **Accessibility**
    grant (System Settings → Privacy & Security → Accessibility → enable
    `scrollslow`); until then the toggle notifies you and scroll stays at full
    speed. Both helpers build automatically on first run (needs the Command
    Line Tools — `xcode-select --install`), so no manual build step is
    required.

-   hammerspoon (macOS automation tool).

-   amphetamine (keep-awake software).

-   WhichSpace (to see the current screen in the menubar).

-   yabai (powerful macOS window manager, the SIP should be disabled to
    use all the features).

-   skhd.

-   stackline (visualize window stacks).

-   Flycut (multiple clipboard manager).


### Essential terminal packages, applications

- vifm (during the first setup of vifm: simply type ":view" and it will set up the tree preview of files. See where you can integrate this command not to forget.)

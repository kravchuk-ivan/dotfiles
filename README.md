OS-agnostic files are located in the root directory, OS-specific files
are located in the designated directories.

# OS-agnostic

General colorscheme guide: background is white (255,255,255), foreground
is black (0,0,0) to ensure the best readability on the fundamental
level. Various display modes (neutral, warm, truetone, etc) come as the
wrappers.

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

#### Bookmarks

softdoc  
comprehensive software documentation

read-later  
topics that could be read later

organizational  
administrative, etc.

### IntelliJ IDEA

### VS Code

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

-   Karabiner Elements (keyboard remapping).

-   hammerspoon (macOS automation tool).

-   amphetamine (keep-awake software).

-   WhichSpace (to see the current screen in the menubar).

-   yabai (powerful macOS window manager, the SIP should be disabled to
    use all the features).

-   skhd.

-   stackline (visualize window stacks).

-   Flycut (multiple clipboard manager).

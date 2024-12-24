#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;KeyHistory

; TODO hardcode switching or launching to the active application with RAlt + numbers row. While holding RAlt press 1, 2, 3 and it would have the same behaviour as win + numbers. While RAlt down 
; TODO Is there a way to allow any optional modifier (wildcard modifier)?
; TODO backtick tilde should work with special modifier key
; TODO <^>!jk::PgDn/PgUp AND add Shift functionality
; TODO <!>!jk::PgDn/PgUp AND add Shift functionality
; TODO <^>!hl::Home/End AND add Shift functionality
; TODO <!>!hl::Home/End AND add Shift functionality
; TOOD Is "disabling" RAlt with RShift good enough?

;SINGLE KEY REMAPPINGS
CapsLock::Backspace
`::Escape

; CROSS-PLATFORMABILITY
>!f:: Send {Tab}
>!g:: Send !{Tab}

; USE TILDE PREFIX?
; RAlt::RShift

;COMPLEX REMAPPINGS
RAlt & m:: Send {Enter}
RAlt & d:: Send {Escape}
RAlt & Backspace::Send {Delete}
RAlt & CapsLock::Send {Delete}

;PROGRAMMER'S ROW
RAlt & a:: Send {-}
RAlt & s:: Send {=}
RAlt & c:: Send {_}
RAlt & v:: Send {+}
RAlt & `;:: Send {:}
RAlt & ':: Send {"}
RAlt & \:: Send {|}
RAlt & ,:: Send {<}
RAlt & .:: Send {>}
RAlt & /:: Send {?}

;QWERTY ROW (NO RELEASE OF RAlt because I want the non-breaking sequence
RAlt & q:: Send {!}
RAlt & w:: Send {@}
RAlt & e:: Send {#}
RAlt & r:: Send {$}
RAlt & t:: Send {`%}
RAlt & y:: Send {^}
RAlt & u:: Send {&}
RAlt & i:: Send {*}
RAlt & o:: Send {(}
RAlt & p:: Send {)}
RAlt & [:: Send {{}
RAlt & ]:: Send {}}

; CTRL + ralt + hjlk works with UK keyboard, why
;ARROW KEYS UK Keyboard allows ctlr hjkl
RAlt & h:: Send {Left}
RAlt & j:: Send {Down}
RAlt & k:: Send {Up}
RAlt & l:: Send {Right}

;WHEN ctrl q/e is triggered it cancels out any other modifiers and this only remapping is being triggered
LCtrl & q:: Send {Home}						; Home
LCtrl & e:: Send {End}						; End
<^;::send {Ctrl Up}+{Home}                  ; Shift-Home
<^'::send {Ctrl Up}+{End}                   ; Shift-End
<^.::send {Ctrl Up}^{Home}                  ; Ctrl-Home
<^/::send {Ctrl Up}^{End}                   ; Ctrl-End

<^Up::send {Ctrl Up}{PgUp}                  ; PgUp
<^Down::send {Ctrl Up}{PgDn}                ; PgDn

; CURRENTLY ISN'T WORKING WITH MULTIPLE WINDOWS
; BEHAVIOUR EXTREMELY PECULIAR, PASSES SPACEBAR AS AN INPUT

>!n::
	Run Notepad++
return
;>!0:: Send {>! Up} #6
;>!1:: Send {>! Up} #1
;>!2:: Send {>! Up} #2
;>!3:: Send {>! Up} #3
;>!4:: Send {>! Up} #4
;>!5:: Send {>! Up} #5
;>!6:: Send {>! Up} #6
;>!7:: Send {>! Up} #7
;>!8:: Send {>! Up} #8
;>!9:: Send {>! Up} #9

;SWITCH TO THE CURRENT INSTANCE OR LAUNCH AN APPLICATION
;ActivateOrOpen(window, program)
;{
;	; check if window exists
;	if WinExist(window)
;	{
;		WinActivate  ; Uses the last found window.
; 	}
;	else
;	{   ; else start requested program
;		 Run cmd /c "start ^"^" ^"%program%^"",, Hide ;use cmd in hidden mode to launch requested program
;		 WinWait, %window%,,5		; wait up to 5 seconds for window to exist
;		 IfWinNotActive, %window%, , WinActivate, %window%
;		 {
;			  WinActivate  ; Uses the last found window.
;		 }
;	}
;	return
;}

;#0::something that could be useful

;>!n::ActivateOrOpen("- Notepad++", "notepad++.exe")

;CTRL + Alt + c = command prompt
;^!c::ActivateOrOpen("ahk_exe cmd.exe", "cmd")

;CTRL + Alt + i = chrome (internet)
;^!i::ActivateOrOpen("- Google Chrome", "chrome.exe")

;CTRL + Alt + w = Word
;^!w::ActivateOrOpen("- Word", "WINWORD")

;CTRL + Alt + e = Excel
;^!e::ActivateOrOpen("- Excel", "excel.exe")

;CTRL + Alt + v = Visual Studio
;^!v::ActivateOrOpen("Visual Studio", "devenv.exe")

;CTRL + Alt + p = putty
;^!p::ActivateOrOpen("ahk_exe putty.exe", "C:\Program Files (x86)\PuTTY\putty.exe")

; CONFLICTS WITH <^q/e
;<^+q::send {Ctrl Up}{Shift Up}+{Home}       ; Shift-Home
;<^+e::send {Ctrl Up}{Shift Up}+{End}        ; Shift-End

; CTRL ALT Q/E to ctrl home ctrl end
;<^+Up::send {Ctrl Up}{Shift Up}+{PgUp}      ; Shift-PgUp
;<^+Down::send {Ctrl Up}{Shift Up}+{PgDn}    ; Shift-PgDn
;<^<+q::send {Ctrl Up}{Shift Up}+{Home}       ; Shift-Home
;<^<+q::send {Ctrl Up}{Shift Up}+{Home}       ; Shift-Home
;<^<+q::send {Ctrl Up}{Shift Up}+{Home}       ; Shift-Home
;<^+e::send {Ctrl Up}{Shift Up}+{End}        ; Shift-End

;<^<!q::send {LCtrl Up}{LAlt Up}{LCtrl Down}{Home}       ; Ctrl-Home
;<^+e::send {Ctrl Up}{Shift Up}+{End}        ; Ctrl-End

;LCtrl & RAlt s:: Send LShift & =

;RAlt & 8:: Run(EnvGet("LOCALAPPDATA") "\Program Files\Firefox\firefox.exe)
;"C:\Program Files\Mozilla Firefox\firefox.exe"

; ## SF
; ### TASKBAR APP POSITIONS
; 1 - Firefox Private Browsing, 2 - Firefox 3 - Google Chrome 4 - Microsoft Edge 5 - File Explorer 9 - Notepad++
; EMBRACE THE WINDOWS NATIVE SHORTCUTS, USUALLY IT'S JUST A MATTER OF HABIT THAT CAUSES SO MUCH FRICTION

; ### ESSENTIAL BROWSER EXTENSIONS
; vimium c (chrome://flags/#extensions-on-chrome-urls)
; ublock origin
; i don't care about cookies

;; Custom Windows Modifier shortcuts
;#o:: Run(EnvGet("LOCALAPPDATA") "\Programs\Obsidian\Obsidian.exe")          ; Obsidian
;#c:: Run(EnvGet("LOCALAPPDATA") "\Programs\Microsoft VS Code\Code.exe")     ; VS Code
;#t:: Run("wt.exe")                                                          ; Windows Terminal
;#+d:: Run(EnvGet("USERPROFILE") "\Downloads")                               ; Open Downloads folder
;#+e:: Run(EnvGet("PROGRAMFILES") "\Everything\Everything.exe")              ; Everything Search
;#+g:: Run("https://github.com")                                             ; GitHub
;#+h:: Run(EnvGet("JSKHOME"))                                                ; Open Windows Explorer to "Home"
;#+p:: Run(EnvGet("USERPROFILE") "\Pictures\Screenshots")                    ; Open Screenshots folder
;#+t:: Run(EnvGet("APPDATA") "\Telegram Desktop\Telegram.exe")               ; Telegram

; ; Remap Insert as the Hyper key: Ctrl + Alt + Shift + Win
; ~Ins:: {
;     Send "{Ctrl DownTemp}{Shift DownTemp}{Alt DownTemp}{LWin DownTemp}"
;     KeyWait "Ins"
;     Send "{Ctrl Up}{Shift Up}{Alt Up}{LWin Up}"
; }

; ; Remap Insert as the Hyper key: Ctrl + Alt + Shift + Win
; ~Ins:: {
;     Send "{Ctrl DownTemp}{Shift DownTemp}{Alt DownTemp}{LWin DownTemp}"
;     KeyWait "Ins"
;     Send "{Ctrl Up}{Shift Up}{Alt Up}{LWin Up}"
; }

; This is how you would remap a modifier key and use it in a more complex combinations.
; *LWin::Send {LControl down}: When the left Windows key is pressed down, it sends the signal to press down ; the left Control key. The * before LWin means that this hotkey will work even if other modifier keys (like ; Shift, Alt, etc.) are held down.
; *LWin Up::Send {LControl up}: When the left Windows key is released, it sends the signal to release the left Control key.

;Scope: If you only need this remapping in specific applications, you can limit its scope by using #IfWinActive to apply the remapping only when certain windows are active.
;Here’s an example of limiting the scope to a specific application (e.g., Notepad):

; TIPS AND TRICKS
; Embrace the default system shortcuts first. Only remap when it's worth it
; GetKeyState
; MsgBox

; MODIFIER KEYS
;LShift <+
;RAlt >!
;LWin <#
;LCtrl <^
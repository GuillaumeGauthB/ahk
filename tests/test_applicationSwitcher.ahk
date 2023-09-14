#SingleInstance Force

; ^j::
; Send, My First Script {Enter}
; return

; ^k::
; Run notepad.exe
; Send, suck my cock bitch ;i hate it here
; return

^u::
Send, test info
return

^+r::
if Run "C:\Users\guill\OneDrive\Documents\AutoHotkey\test_applicationSwitcher.ahk" {
    TrayTip Refresh, Script has refreshed, 10
}
return

^!t::
WinGetTitle, title, A
MsgBox, Active window is %title%
return
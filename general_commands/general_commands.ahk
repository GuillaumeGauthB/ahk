#Requires AutoHotkey v2.0
#SingleInstance Force
#include ../json/general_commands.ahk

; boot all work apps
^+w::
{
    Run "C:\Program Files (x86)\Rapid PHP 2018\rapidphp.exe"
    Run "Skype"
    Run "C:\Program Files\Firefox Developer Edition\firefox.exe"
    Run "C:\Users\guill\AppData\Local\Programs\Microsoft VS Code\Code.exe"
    Run "C:\Program Files\Microsoft VS Code Insiders\Code - Insiders.exe"
    Run "C:\xampp\xampp-control.exe"
    ; Run "C:\Program Files\Google\Chrome\Application\chrome.exe https://teams.live.com/"
    ; Run "C:\Program Files\WindowsApps\MicrosoftTeams_23335.242.2641.4129_x64__8wekyb3d8bbwe\msteams.exe"
}

; check for ip
^+i::
{
    global configMap

    winTitle := WinGetTitle("A")

    Send "{Text}if ( $_SERVER['REMOTE_ADDR'] == '" . configMap['ipAddress'] . "') { `recho'<pre>'.print_r($_POST, true).'</pre>'; `r}"
    
    ; move bracket
    SendInput "{LShift down}{tab}{LShift up}"

    SendInput "{Right}"

    SendInput "{Enter}"

    ; delete content past the bracket
    SendInput "{LShift down}{End}{LShift up}"
    
    SendInput "{Backspace}{Backspace}"

    if(InStr(winTitle, 'VSCodium', false) || InStr(winTitle, 'Visual Studio Code', false))
        SendInput "{Backspace}"
}

; lastpass
!^LButton::
{
    Send "{Text}UsCD*R:Nu5pW~S!"
}

^+m::
{
    ; SendInput "{TAB}"

    
    ; SendInput "{TAB down}"
    ; sleep 500
    ; SendInput "{TAB up}"
    
    ; SendInput "{LShift up}"
    
    winTitle := WinGetTitle("A")
    MsgBox(winTitle)

}



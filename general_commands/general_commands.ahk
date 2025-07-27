#Requires AutoHotkey v2.0
#SingleInstance Force
#include configs.ahk

#include work.ahk
#include random.ahk

; Tooltip title for the hotkey list GUI
hotkey_list_tooltip := "Hotkeys List - general_commands.ahk"

; Reload script
; This hotkey reloads the script and displays a tray notification.
^+R::
{
    Reload
    TrayTip "The script has been reloaded.", "general_commands.ahk", "Iconi"
}

; Display a list of hotkeys in a GUI window
^+K::
{
    global hotkey_list_tooltip
    ; Declare variables
    GUIName := hotkey_list_tooltip ; Name of the GUI window

    ; If the tooltip window already exists, close it
    if(WinExist(GUIName)) {
        WinClose(GUIName)
        return
    }

    ; Define tabs and hotkeys
    tabs := Array() ; Array to store tab names
    hotkeys := Map( ; Map containing hotkey categories and their respective hotkeys
        "Emojis", Map(
            "Discord Skull Emoji", "Ctrl + Alt + S",
            "Discord peo_denial Emoji", "Ctrl + Alt + P",
            "Nodding Emoji", "Ctrl + Alt + N",
        ),
        "General", Map(
            "Reload script", "Ctrl + Shift + R",
            "List Hotkeys", "Ctrl + Shift + K",
        ),
        "Toggles", Map(
            "Lock Wheel Up", "Ctrl + Shift + M",
            "Lock Wheel Down", "Ctrl + Shift + N",
            "Auto Clicker", "Ctrl + Shift + Enter",
        ),
        "Work", Map(
            "Boot All Work Apps", "Ctrl + Shift + W",
            "Add IP Check", "Ctrl + Shift + I",
            "Lastpass", "Ctrl + Alt + Left Click",
        )
    ) ; End of hotkeys map

    ; Create a GUI window that is always on top
    GUIAP := Gui("AlwaysOnTop ToolWindow -Caption", GUIName) 

    ; Populate the tabs array with the names of the hotkey categories
    for title in hotkeys 
        tabs.Push title

    ; Add tabs to the GUI
    GUIAP_tabs := GUIAP.Add("Tab3",, tabs) 

    ; Add content to each tab
    for tab in tabs {
        hotkeys_list := "" ; Initialize the hotkeys list for the current tab

        ; Skip to the next iteration if the tab does not exist in the hotkeys map
        if (!hotkeys.Has(tab))
            continue

        ; Build the hotkeys list for the current tab
        for name, hotkey in hotkeys.Get(tab) {
            hotkeys_list := hotkeys_list . name . ": " . hotkey . "`n"
        }

        ; Display the hotkeys in the current tab
        GUIAP_tabs.UseTab(tab)
        GUIAP.Add("Text", "w300 v" . tab, hotkeys_list)
    }

    ; Show the GUI window at the top-right corner of the screen
    GUIAP.Show("NoActivate X" (A_ScreenWidth - 350) " w350 Y0 h" A_ScreenHeight )
}

; Close the hotkey list window using various mouse buttons
#HotIf WinExist(hotkey_list_tooltip)
Esc:: 
RButton::
MButton:: WinClose(hotkey_list_tooltip)
#HotIf

; Close the hotkey list window if the mouse is outside the window and the window is active
#HotIf WinExist(hotkey_list_tooltip) and !mouseInWindow(hotkey_list_tooltip) and WinActive(hotkey_list_tooltip)
LButton:: WinClose(hotkey_list_tooltip)   
#HotIf

; Function to check if the mouse is inside a specified window
mouseInWindow(win_name) {
    WinGetPos &window_x, &window_y, &window_width, &window_height, win_name

    MouseGetPos &xpos, &ypos 

    ; Store mouse position in a map
    ClickInfo := Map("x", xpos, "y", ypos) ; Coordinates are relative to the active window

    xpos := ""
    ypos := ""

    ; Check if the mouse is within the window's boundaries
    if(
        (
            ClickInfo['x'] >= 0 &&
            ClickInfo['x'] <= window_width
        )
        &&
        (
            ClickInfo['y'] >= 0 &&
            ClickInfo['y'] <= window_height
        )
    )
    {
        return true
    }

    return false
}
#Requires AutoHotkey v2.0
#include ../functions/_functions.ahk

; if searchBar exists..
#HotIf WinExist(GUIName)

	; Closing interface

	Esc::
	RButton::
	MButton::
	; WheelDown::
	; WheelUp::
	{
		CloseSearchWindow()
	}

	LButton::
	{
		global GUIName

		WindowInfo := GetWindowPositionInfo(GUIName)

		MouseGetPos &xpos, &ypos 

		ClickInfo := Map("x", xpos, "y", ypos) ; is relative to the active window

		xpos := ""
		ypos := ""

		if(
			(
				ClickInfo['x'] >= 0 &&
				ClickInfo['x'] <= WindowInfo['width']
			)
			&&
			(
				ClickInfo['y'] >= 0 &&
				ClickInfo['y'] <= WindowInfo['height']
			)
		)
		{
			exit
		}
			
		CloseSearchWindow()
	}

#HotIf

; Change GUI state, whether or not it can be activated
; trigger: Shift + Ctrl + Space
+^Space::
{
	global active_state

	active_state := !active_state

	; handle notification message
	state_message := "Press the hotkeys again to reactivate it."
	state_title := "The search bar has been deactivated"

	if(active_state){
		state_message := "Press the hotkeys again to deactivate it."
		state_title := "The search bar has been activated"
	}

	; sending notification
	TrayTip state_message, state_title, "Iconi"
	Sleep 5000   ; Let it display for 8 seconds.
	HideTrayTip
}
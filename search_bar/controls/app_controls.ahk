#Requires AutoHotkey v2.0

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

	; MsgBox(active_state)
}
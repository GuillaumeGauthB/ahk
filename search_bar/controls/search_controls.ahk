#Requires AutoHotkey v2.0

; if app is open...
#HotIf WinExist(GUIName)
	; choose an app
	^r::
	{
		GUIAP['SearchContent'].Text := "app:: " GUIAP['SearchContent'].value	

		Send "{End}"
	}

	; select browser
	^b::
	^c::
	^f::
	{
		PressedKey := ""

		; if(GetKeyState("b", "P"))
		; 	PressedKey("b")

		; ListOfBrowserKeys

		for index in ListOfBrowserKeys
		{
			if(GetKeyState(index, "P"))
			{
				PressedKey := index
				break
			}
		}

		if(PressedKey == "")
			exit

		; global GUIName

		HWND := WinGetID(GUIName)

		GuiOBJ := GuiFromHwnd(HWND)

		SearchContent := GuiObj['SearchContent'].value

		SearchModeText := SubStr(SearchContent, 1, 5)


		for key in ListOfBrowsers
		{
			if(key != SearchModeText)
				continue

			SearchContent := SubStr(SearchContent, 5)
			break
		}
		
		; Ctrl_Change(GuiCtrlObj, Info)
		; MsgBox(searchContent)
		GuiObj['SearchContent'].Text := PressedKey ":: " SearchContent

		Send "{End}"
	}

	; sending search
	Enter::
	{
		global GUIName
		global ListOfBrowsers

		HWND := WinGetID(GUIName)

		GuiOBJ := GuiFromHwnd(HWND)

		SearchContent := GuiObj['SearchContent'].value

		SearchMode := "f:: "

		SearchModeText := SubStr(SearchContent, 1, 4)


		for key, name in ListOfBrowsers
		{
			if(key != SearchModeText)
				continue

			SearchMode := key
			SearchContent := SubStr(SearchContent, 4)
			break
		}

		Run ListOfBrowsers[SearchMode] " https://www.google.com/search?q=" UrlEncode(searchContent)

		CloseSearchWindow()
	}
#HotIf
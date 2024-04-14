#Requires AutoHotkey v2.0

; Closes the search window
CloseSearchWindow()
{
	global GUIAP

    GUIAP.Hide
}

; Gets the window position
GetWindowPositionInfo(ApplicationParameter) {
	WinGetPos &x, &y, &width, &height, ApplicationParameter

	info := Map(
		"x", x,
		"y", y,
		"width", width,
		"height", height
	)

	return info
}

; Callback when edit is inputted into
CallbackEditSearchBar(*) 
{
	SearchContent := GUIAP["SearchContent"].value ; the search content

	sleep 1000 ; wait for one second

	; if the search content has changed during the wait time,
	; call the function again and stop it here
	if(SearchContent != GUIAP["SearchContent"].value){
		CallbackEditSearchBar()
		return
	}

	; get the type of search
	TypeOfSearch := GetTypeOfSearch()

	; if the type is app, continue
	if(TypeOfSearch["type"] != "app")
	{
		return
	}

	; call the app search function
	AppSearchResult(TypeOfSearch["value"])
}

; Get the type of search (app or web)
; if web, sends the browser name
GetTypeOfSearch()
{
	ReturnMap := Map(
		"type", "",
		"value", ""
	)
	SearchContent := GUIAP['SearchContent'].value

	SearchModeText := SubStr(SearchContent, 1, 6)

	; MsgBox(SearchContent)

	if(SearchModeText == "app:: ") {
		ReturnMap["type"] := "app"
		ReturnMap["value"] := SubStr(SearchContent, 7)
		return ReturnMap
	}

	; if(ReturnMap["type"] != "")
	; 	Return ReturnMap


	SearchModeText := SubStr(SearchContent, 1, 5)

	for key in ListOfBrowsers
	{
		if(key != SearchModeText)
			continue

		SearchContent := SubStr(SearchContent, 5)
		break
	}
	
	Return ReturnMap
}

; Gets the results on App search
AppSearchResult(SearchContent)
{
	global GUIAP

	Result := Array()

	GUIAP["AppResults"].Delete()

	Loop Files, A_ProgramFiles "\*.exe", "R"  ; Recurse into subfolders.
	{
		if(RegExMatch(A_LoopFileName, SearchContent)) ; if(InStr(A_LoopFilePath, SearchContent, false, 1, 2))
			;Result.Push("Filename = " A_LoopFilePath)
			; Result.Push("Filename = " A_LoopFileName)
			GUIAP["AppResults"].Add(, "hicon: " A_LoopFileName, A_LoopFilePath) 
	}
}
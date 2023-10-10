#Requires AutoHotkey v2.0
#SingleInstance Off

; Variables for SearchBar
GUIName := "Search Bar"
GUIAP := ""

ListOfBrowsers := Map(
	"f:: ", "C:\Program Files\Mozilla Firefox\firefox.exe",
	"b:: ", "brave.exe",
	"c:: ", "chrome.exe"
)

ListOfBrowserKeys := Array(
	"f",
	"b",
	"c"
)


#HotIf !WinExist(GUIName)
; Show GUI APP window for searchBar
^Space::
{
    global GUIName
    global GUIAP

    GUIAP := Gui(" -Caption", GUIName) 
    
    GUIAP.Add("Edit", "r1 vSearchContent w1200").onEvent("Change", CallbackEditSearchBar)

	GUIAP.Add("ListView", "w1200 vAppResults", ["Icon", "Filename"])

    GUIAP.Show

	info := GetWindowPositionInfo(GUIName)

}
#HotIf

; if searchBar exists..
#HotIf WinExist(GUIName)

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









; FROM --- https://www.autohotkey.com/boards/viewtopic.php?style=1&t=116056
UrlEncode(str, sExcepts := "-_.", enc := "UTF-8")
{
	hex := "00", func := "msvcrt\swprintf"
	buff := Buffer(StrPut(str, enc)), StrPut(str, buff, enc)   ;转码
	encoded := ""
	Loop {
		if (!b := NumGet(buff, A_Index - 1, "UChar"))
			break
		ch := Chr(b)
		; "is alnum" is not used because it is locale dependent.
		if (b >= 0x41 && b <= 0x5A ; A-Z
			|| b >= 0x61 && b <= 0x7A ; a-z
			|| b >= 0x30 && b <= 0x39 ; 0-9
			|| InStr(sExcepts, Chr(b), true))
			encoded .= Chr(b)
		else {
			DllCall(func, "Str", hex, "Str", "%%%02X", "UChar", b, "Cdecl")
			encoded .= hex
		}
	}
	return encoded
}

; !^q::
; {
;     WinKill(WinGetID())
; }

#Requires AutoHotkey v2.0
#SingleInstance Off

#include ./var/_var.ahk
#include ./functions/_functions.ahk
#include ./controls/_controls.ahk

; if search is not active
#HotIf !WinExist(GUIName)
; Show GUI APP window for searchBar
^Space::
{
    global GUIName
    global GUIAP
	global active_state

	; if we have deactivated the search bar, return
	if(!active_state)
		return


    GUIAP := Gui(" -Caption", GUIName) 
    
    GUIAP.Add("Edit", "r1 vSearchContent w1200").onEvent("Change", CallbackEditSearchBar)

	GUIAP.Add("ListView", "w1200 vAppResults", ["Icon", "Filename"])

    GUIAP.Show

	info := GetWindowPositionInfo(GUIName)

}
#HotIf
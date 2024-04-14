#Requires AutoHotkey v2.0

; Variables for SearchBar
GUIName := "Search Bar"
GUIAP := ""
active_state := true

; list of available functions
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
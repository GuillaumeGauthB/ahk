#Requires AutoHotkey v2.0
#SingleInstance Force

GUIName := "APPLICATION SWITCHER AHK"
ProcessObject := Map() ; called associative array, not object
PositionIndex := 1
ApplicationPositionList := []
ProcessNamesArray := []
GUIAP := ""

!p:: ; alt + P
{
    global ApplicationPositionList
    global GUIName
    global ProcessNamesArray

    processNames := "" ; Names of processes~~~

    Windows := WinGetList(,, "Program Manager") ; List all open windows~~~

    for ID in Windows
    {
        ; WinActivate ID
        WT := WinGetTitle(ID)

        if ( WT != "" && WT != GUIName)
        {
            ; dunno if it works uwu~~~
            if not WinExist(WT)
                continue
            ; MsgBox WT
            ProcessName := WinGetProcessName(WT)  ; Gets the process name~~~
            processNames .= ProcessName . "`n" ; Prints it to final string~~~

            ProcessObject[ProcessName] := WinGetPID(WT)
        }
    }

    if(processNames == "")
        return

    ; Wipe variables to save memory ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ProcessName := ""
    WT := ""
    ID := ""
    Windows := ""

    processNames := Sort(processNames, "C0 U")	
                ; sorts alphabetically (case-insensitive) and deletes duplicates
                ; owo

    ; MsgBox(processNames) ; ~~~ prints result ~~~
    ProcessNamesArray := StrSplit(processNames, "`n")

    processNames := ""

    ; LV := GUIAP.Add("ListView", "r10 w700")

    DrawApplicationSwitcher()
    
    ; KeyWait "Alt"
    ; GUIAP.Hide

}

;
; APPLICATION SWITCHER WINDOW
;

DrawApplicationSwitcher(i := 1) 
{
    global GUIAP
    global ApplicationPositionList
    ApplicationPositionList := []
    GUIAP := Gui("AlwaysOnTop -Caption -SysMenu", GUIName)

    index := 1
    for ApplicationName in ProcessNamesArray
    {
        if(ApplicationName == "")
            continue

        ; MsgBox(ApplicationName)
        ; If (ProcessExist(ApplicationName))
        if(ProcessObject[ApplicationName] != "")
        {
            Path := ProcessGetPath(ProcessObject[ApplicationName])

            if (Path)
            {
                GUIAP.Add("Picture", "w30 h-1 x+m ym10 vApplication" index " " (index == i ? "border" : ("")), Path)
                ; makes images side by side, width of 30, and have a margin of 10
                ; px on the top side

                ApplicationPositionList.Push(Map("PID", ProcessObject[ApplicationName], "Name", ApplicationName))
                index++
            }
        }

        ; processNames .= ApplicationName . ", "
    }
    ; MsgBox(ApplicationPositionList.length)
    ; MsgBox(processNames)

    ; GUIAP.Add("Text", "vTest" , processNames)
    
    GUIAP.Show

    ; KeyWait "Control"  ; Wait for both Control and Alt to be released.
    ; KeyWait "Alt"
    ; GUIAP.Hide
}

ChangePosition(changeIndex)
{
    global ApplicationPositionList
    global PositionIndex

    PositionIndex := PositionIndex + changeIndex

    ; MsgBox PositionIndex

    if(PositionIndex > ApplicationPositionList.length)
        PositionIndex := 1
    else if (PositionIndex < 1)
        PositionIndex := ApplicationPositionList.length
    ; MsgBox PositionIndex

    

    GUIAP.hide
    DrawApplicationSwitcher(PositionIndex)   
}

#HotIf WinExist(GUIName)
Esc::
{
    global GUIAP

    GUIAP.hide
}
; !LButton::
; {
;     ; WinClose(GUIName)

;     HWND := WinGetID(GUIName)

;     HWNDControl := WinGetControlsHwnd(GUIName)

;     ; MsgBox HWNDControl.length

;     GuiOBJ := GuiFromHwnd(HWND)

;     GuiCtrl := GuiCtrlFromHwnd(HWND)

;     ; GuiCtrl.Add("Text", ,"test")

;     GuiObj['Application5'].style("border")

;     GuiOBJ.Show
;     ; MsgBox(GuiOBJ.Title)
;     ; MsgBox("Instructions, Stop editing!")
; }

Left::
{
    ChangePosition(-1)
}

Right::
{
    ; global ApplicationPositionList
    ; global PositionIndex


    ChangePosition(1)
    ; GUIAP.hide
    ; DrawApplicationSwitcher(2)
    
    ; HWND := WinGetID(GUIName)
    ; GuiOBJ := GuiFromHwnd(HWND)
    ; GuiOBJ.Add("Text", "vFML" , "fml")
    ; MsgBox GuiOBJ["Application1"].visible
    ; GuiOBJ['Test'].SetFont("underline")

    ; MsgBox GuiOBJ['Application5'].Visible

    ; GuiOBJ['Application5'].Opt("+E0x20")
    ; GuiOBJ['Test'].Opt("cRed")

    ; r := ""

    ; for element in ApplicationPositionList
    ; {
    ;     r .= " PID: " element["PID"] ", name: " element["Name"] "`n"
    ; }

    ; MsgBox(r)
}
#HotIf 



; index de position rn
; tableau de tous les emplacements (index, nom de l'app)



; fonction (GuiFromHWND, -1/+1)

; focusedControl (proc) {
;     Return WinExist("APPLICATION SWITCHER AHK") ? True : False
; }

; https://www.autohotkey.com/docs/v2/lib/Gui.htm#Opt 
; UI tests
!g::
{
    MyGUI := Gui("AlwaysOnTop ToolWindow -Caption -SysMenu", "APPLICATION SWITCHER AHK")
    ; MyGui.Add("Edit", "w600")
    MyGUI.Add("Text",, "test text")
    MyGUI.Show
}


#Requires AutoHotkey v2.0
#SingleInstance Force

!p:: ; alt + P
{
    
    processNames := "" ; Names of processes~~~

    Windows := WinGetList(,, "Program Manager") ; List all open windows~~~
    for ID in Windows
    {
        ; WinActivate ID
        WT := WinGetTitle(ID)

        if ( WT != "" )
        {
            ; dunno if it works uwu~~~
            if not WinExist(WT)
                continue

            ProcessName := WinGetProcessName(WT)  ; Gets the process name~~~
            processNames .= ProcessName . "`n" ; Prints it to final string~~~
        }
    }

    ; Wipe variables to save memory ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ProcessName := ""
    WT := ""
    ID := ""
    Windows := ""

    processNames := Sort(processNames, "C0 U")	
                ; sorts alphabetically (case-insensitive) and deletes duplicates
                ; owo

    MsgBox(processNames) ; ~~~ prints result ~~~
}
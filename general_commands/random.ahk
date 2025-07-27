#Requires AutoHotkey v2.0

#HotIf configMap['activeModules']['random']
; emojis

!^s::
{
    Send "{Text}:skull:"
}

!^p::
{
    Send "{Text}:peo_denial:"
}

!^n::
{
    Send "{Text}🙂‍↕️"
}



/* 
   ========================== Hold down button START ==========================
*/
; buttonHeld := false
; #HotIf buttonHeld
;     ^+m::
;     {
;         global buttonHeld

;         buttonHeld := true
;         ; MsgBox("true")

;         ; Send "{w up}"
;         ; Send "{LControl up}"
;         Send "{e up}"
;     }
; #HotIf

; #HotIf !buttonHeld
;     ^+m::
;     {
;         global buttonHeld

;         buttonHeld := false
;         ; MsgBox("false")

;         ; Send "{w down}"
;         ; Send "{LControl down}"
;         Send "{e down}"
;     }
; #HotIf

/* 
   ========================== Hold down button END ==========================
*/

/* 
   ========================== Lock Wheel Scroll START ==========================
*/

/*
Lock Wheel Scroll Up
*/
toggleWheelUp := false
toggleWheelDown := false

^+m::
{
    global toggleWheelUp
    global toggleWheelDown

    toggleWheelUp := !toggleWheelUp ; flip toggle

    if toggleWheelUp {
        ; if scrolling down, stop it
        if(toggleWheelDown) {
            toggleWheelDown := false
            SetTimer(WheelDownLoop, 0)   
        }

        ; scroll up
        SetTimer(WheelUpLoop, 20)
    }
    else {
        ; stop scrolling up
        SetTimer(WheelUpLoop, 0)
    }
}

WheelUpLoop()
{
    Send '{WheelUp}'
}

/*
Lock Wheel Scroll Down
*/
^+n::
{
    global toggleWheelUp
    global toggleWheelDown

    toggleWheelDown := !toggleWheelDown ; flip toggle

    if toggleWheelDown {
        ; if scrolling up, stop it
        if(toggleWheelUp) {
            toggleWheelUp := false
            SetTimer(WheelUpLoop, 0)
        }

        ; start scrolling down
        SetTimer(WheelDownLoop, 20)
    }
    else {
        ; stop scrolling down
        SetTimer(WheelDownLoop, 0)
    }
}

WheelDownLoop()
{
    Send '{WheelDown}'
}

/* 
   ========================== Lock Wheel Scroll END ==========================
*/

/*
Auto Clicker
*/
^+Enter::
{
    static toggleClicker := false

    toggleClicker := !toggleClicker ; flip toggle

    if toggleClicker {

        ; start scrolling down
        SetTimer(ClickLoop, 2)
    }
    else {
        ; stop scrolling down
        SetTimer(ClickLoop, 0)
    }
}

ClickLoop()
{
    Click
}

/* 
   ========================== Lock Wheel Scroll END ==========================
*/
#HotIf
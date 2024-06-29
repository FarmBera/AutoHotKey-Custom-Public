#NoEnv
#SingleInstance force
; SendMode, Input
SetCapsLockState, AlwaysOff
CoordMode, Mouse, Screen


; --------------------
; global variables
global Offset = 50 ; mouse movement offset value
global OffsetSlow := Offset/3 ; slow mouse movement
global RepeatTime := 5 ; mouse autoclock repeat rate


; --------------------
; function define

MouseClickRepeat(button) {
    While GetKeyState("LShift", "P") && GetKeyState(button, "P") {
        if (button = "u") {
            MouseClick, Left
        } else if (button = "o") {
            MouseClick, Right
        }
        Sleep, %RepeatTime%
    }
}

; check key pressed (for condition)
IsDirectionPressed(modifier, key) {
    return GetKeyState(modifier, "P") && GetKeyState(key, "P")
}

MoveMouseFast(direction) {
    While IsDirectionPressed("LCtrl", direction) {
        Switch direction {
            Case "i":
                MouseMove, 0, (Offset * -1), 0, R
            Case "k":
                MouseMove, 0, Offset, 0, R
            Case "j":
                MouseMove, (Offset * -1), 0, 0, R
            Case "l":
                MouseMove, Offset, 0, 0, R
        }
        Sleep, 10
    }
}

MoveMouseSlow(direction) {
    global OffsetSlow
    While IsDirectionPressed("Tab", direction) {
        Switch direction {
            Case "i":
                MouseMove, 0, (OffsetSlow * -1), 0, R
            Case "k":
                MouseMove, 0, OffsetSlow, 0, R
            Case "j":
                MouseMove, (OffsetSlow * -1), 0, 0, R
            Case "l":
                MouseMove, OffsetSlow, 0, 0, R
        }
        Sleep, 10
    }
}


#if GetKeyState("Capslock","P")
    ; capslock toggle
    q::CapsLock


    ; ijkl arrow
    i::Up
    j::Left
    k::Down
    l::Right
    ; wasd arrow
    w::Up
    a::Left
    s::Down
    d::Right


    ; mouse control
    e::WheelDown
    r::WheelUp
    t::MButton

    y::WheelUp
    h::WheelDown

    u::LButton
    o::RButton


    ; special named keys
    Esc::`

    p::PrintScreen
    [::Home
    ]::End

    `;::PgUp
    '::PgDn

    .::Insert
    /::Del
    ; ,::ScrollLock
    ; \::Pause


    ; media control
    f::Media_Play_Pause
    z::Volume_Mute
    x::Volume_Down
    c::Volume_Up
    v::Media_Prev
    b::Media_Next


    ; function keys
    1::F1
    2::F2
    3::F3
    4::F4
    5::F5
    6::F6
    7::F7
    8::F8
    9::F9
    0::F10
    -::F11
    =::F12


    ; mouse click repeat (left & right)
    LShift & u::MouseClickRepeat("u")
    LShift & o::MouseClickRepeat("o")

    ; mouse move FAST
    LCtrl & i::MoveMouseFast("i")
    LCtrl & k::MoveMouseFast("k")
    LCtrl & j::MoveMouseFast("j")
    LCtrl & l::MoveMouseFast("l")

    ; mouse move SLOW
    Tab & i::MoveMouseSlow("i")
    Tab & k::MoveMouseSlow("k")
    Tab & j::MoveMouseSlow("j")
    Tab & l::MoveMouseSlow("l")


; capslock stand-alone (switch language)
#if
*CapsLock::
KeyWait, CapsLock
if A_ThisHotkey = *CapsLock
    Send, {vk15}
Return

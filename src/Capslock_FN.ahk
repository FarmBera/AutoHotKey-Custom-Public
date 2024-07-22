#Requires AutoHotkey >=v2.0.12
; #Warn ; for Debugging
#SingleInstance Force
SendMode "Input"
CoordMode "Mouse", "Screen"
SetCapsLockState "AlwaysOff"
SetScrollLockState 0
SetNumLockState 0

; include modulized function
#Include module\GUI_Terminal.ahk

#Include function\ToggleKey.ahk
#Include function\ShowTooltip.ahk
#Include function\TrayTips.ahk
#Include function\AddToPlaylist.ahk
#Include function\MovingMouse.ahk
#Include function\MouseClickRepeat.ahk
#Include function\PenToolClick.ahk
#Include function\SetPenCoord.ahk
#Include function\ReleaseAllKeys.ahk


; --------------------
; global variables

global OffsetFast := 40
global OffsetSlow := 15 ; slow mouse movement
global Offset := OffsetFast ; mouse movement offset value
global RepeatTime := 5 ; mouse autoclick repeat rate

; monitor resolution
global screenWidth := 0
global screenHeight := 0

; powerpoint pen tool position
global NumPenX := [185, 230, 280, 380, 430, 480, 30, 80, 130] ; FHD
global NumPenY := [100, 100, 100, 100, 100, 100, 100, 100, 100] ; FHD


; --------------------
; script configuring & initial settings

OnExit(ReleaseFunctionKeys)

; 주요 기능 키를 release하는 함수
ReleaseFunctionKeys(ExitReason, ExitCode) {
    ReleaseAllKeys()
}


Initialize() {
    ; get screen resolution
    global screenWidth := SysGet(78)
    global screenHeight := SysGet(79)

    result := SetPenCoord(screenWidth, NumPenX, NumPenY)
    global NumPenX := result.x
    global NumPenY := result.y

    return screenWidth "x" screenHeight
}
MsgBox "Capslock_FN v0.8.5.3-rc`nscript configuring & initialized settings`n" . Initialize(), "Initialized", "0x0 T2"


; --------------------
; toggle key actions

NumLock::ToggleKey("NumLock")
ScrollLock::ToggleKey("ScrollLock")


; --------------------
; nunpad actions (for Clicking)

NumpadAdd::{
    if (GetKeyState("NumLock", "T")) {
        Send "{+}"
    } else {
        Send "^s"
    }
}
NumpadIns::^z ; 0
NumpadDel::^y ; . (dot)
NumpadEnd::PenToolClick(1, NumPenX, NumPenY) ; pen 1
NumpadDown::PenToolClick(2, NumPenX, NumPenY) ; pen 2
NumpadPgDn::PenToolClick(3, NumPenX, NumPenY) ; pen 3
NumpadLeft::PenToolClick(4, NumPenX, NumPenY) ; highlighter 1
NumpadClear::PenToolClick(5, NumPenX, NumPenY) ; highlighter 2
NumpadRight::PenToolClick(6, NumPenX, NumPenY) ; highlighter 3
NumpadHome::PenToolClick(7, NumPenX, NumPenY) ; cursor
NumpadUp::PenToolClick(8, NumPenX, NumPenY) ; lasso selector
NumpadPgUp::PenToolClick(9, NumPenX, NumPenY) ; eraser


; --------------------
; capslock actions

#HotIf GetKeyState("Capslock", "P")
    BackSpace::{
        ReleaseAllKeys()
    }

    ; capslock toggle
    q::ToggleKey("Capslock")

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
    \::CtrlBreak

    `;::PgUp
    '::PgDn

    ,::ToggleKey("ScrollLock")
    .::Insert
    /::Del

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


    ; tidal playlist add macro
    LButton::AddToPlaylist(4) ; currently playing
    RButton::AddToPlaylist(15) ; remove from playlist

    ; mouse movement
    i::MovingMouse("i", Offset)
    k::MovingMouse("k", Offset)
    j::MovingMouse("j", Offset)
    l::MovingMouse("l", Offset)

    LWin::{
        previous := Offset
        global Offset := OffsetFast
        TrayTips(previous . " to " . Offset,  "Offset Changed", 0x1)
    }
    Tab::{
        previous := Offset
        global Offset := OffsetSlow
        TrayTips(previous . " to " . Offset, "Offset Changed", 0x1)
    }

    ; mouse click repeat (left & right)
    LShift & u::MouseClickRepeat("u", RepeatTime)
    LShift & o::MouseClickRepeat("o", RepeatTime)


    ; open command gui
    Enter::CreateGUI("Terminal", "_", NumPenX, NumPenY)


; --------------------
; capslock stand-alone (switch language)
#HotIf
*CapsLock::{
    KeyWait "CapsLock"
    if A_ThisHotkey == "*CapsLock"
        Send "{vk15}"
}


; --------------------
; scrollLock ON action

; set custom click position
#HotIf GetKeyState("ScrollLock", "T")
    global NumPenX, NumPenY

    SetCoord(idx) {
        MouseGetPos(&tempX, &tempY)

        NumPenX[idx] := tempX
        NumPenY[idx] := tempY

        MsgBox "Position Set : (" . NumPenX[idx] . ", " . NumPenY[idx] . ")", "Testing", "0x0 T1"
    }

    F1::SetCoord(1)
    F2::SetCoord(2)
    F3::SetCoord(3)
    F4::SetCoord(4)
    F5::SetCoord(5)
    F6::SetCoord(6)
    F7::SetCoord(7)
    F8::SetCoord(8)
    F9::SetCoord(9)


; --------------------
; function define

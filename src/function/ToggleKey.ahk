#Include TrayTips.ahk

; for toggle action (NumLock, Capslock, ScrollLock)
ToggleKey(key) {
    state := GetKeyState(key, "T") ? "OFF" : "ON"
    if (key = "NumLock") {
        SetNumLockState state
    }
    else if (key = "ScrollLock") {
        SetScrollLockState state
    }
    else if (key = "Capslock") {
        SetCapsLockState state
    }
    TrayTips(state, key . " State", 0x1)
    ; MsgBox state, "NumLock State", "0x0 T0.5"
}
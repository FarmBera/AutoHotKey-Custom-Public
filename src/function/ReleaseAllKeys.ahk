#Include TrayTips.ahk

ReleaseAllKeys() {
    TrayTips("Releasing All keys", "Releasing", 0x2, 1000)

    ; 주요 기능 키 목록
    functionKeys := [
        "LCtrl", "RCtrl",
        "LShift", "RShift",
        "LAlt", "RAlt",
        "LWin", "RWin",
        "CapsLock", "ScrollLock", "NumLock",
        "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", 
        "LButton", "RButton",
        "Left", "Right", "Up", "Down",
        "BackSpace"
    ]

    ; 모든 기능 키에 대해 KeyUp 실행
    for key in functionKeys {
        Send("{" . key . " up}")
    }
    ; Send "{}"
}
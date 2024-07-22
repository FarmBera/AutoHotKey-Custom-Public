; include dependency
#Include ..\function\TrayTips.ahk
#Include ..\function\SetPenCoord.ahk

; --------------------
; GUIs
KeyState(key) {
    return GetKeyState(key, "T") ? "O" : "X"
}

CreateGUI(title, body, NumPenX, NumPenY)
{
    MyGuiT := Gui()
    MyGuiT.Add("Text", "x10 y10 w200", body)
    MyGuiT.Add("Edit", "x10 y40 w200 vUserInput")

    submitBtn := MyGuiT.Add("Button", "x10 w100", "Submit")
    submitBtn.OnEvent("Click", (*) => HandleSubmit(MyGuiT, NumPenX, NumPenY))
    offsetBtn := MyGuiT.Add("Button", "x+10 w100", "Set Offset")
    offsetBtn.OnEvent("Click", (*) => HandleOffset(MyGuiT))
    repeatBtn := MyGuiT.Add("Button", "x10 y+10 w100", "Set Repeat Rate")
    repeatBtn.OnEvent("Click", (*) => HandleRepeatRate(MyGuiT))

    ; onPress Escape or Close (X button)
    MyGuiT.OnEvent("Escape", (*) => MyGuiT.Destroy())
    MyGuiT.OnEvent("Close", (*) => MyGuiT.Destroy())

    MyGuiT.Title := title
    MyGuiT.Show()

    ; When the GUI is active, pressing the Enter key will execute the submit action
    HotIfWinactive("ahk_id " . MyGuiT.Hwnd)
    Hotkey("Enter", (*) => HandleSubmit(MyGuiT, NumPenX, NumPenY))
}

; onSubmit action
HandleSubmit(obj, NumPenX, NumPenY) {
    cmd := obj['UserInput'].Value
    obj.Destroy()
    ; terminate current script
    if (cmd == "exit") {
        TrayTips("Process Terminated", "Exiting 'Capslock_FN'", 0x1)
        ExitApp
    }
    ; reload current script
    else if (cmd == "reload") {
        TrayTips("Process will Reload", "Reloading", 0x2)
        Reload
    }
    ; Alt + F4 action
    else if (cmd == "close") {
        activeTitle := WinGetTitle("A")
        Send "!{F4}"
        TrayTips("Closed App", activeTitle, 0x4)
    }
    ; notify all toggle key state
    else if (cmd == "state" || cmd == "getstate") {
        TrayTips("Capslock: " KeyState("Capslock") "`nNumLock: " KeyState("NumLock") "`nScrollLock: " KeyState("ScrollLock"), "Current ToggleKey State", 0x1)
    }
    ; toggle capslock
    else if (cmd == "capslock" || cmd == "caps" || cmd == "CAPS") {
        ToggleKey("Capslock")
    }
    ; toggle NumLock
    else if (cmd == "numlock" || cmd == "num") {
        ToggleKey("NumLock")
    }
    ; toggle ScrollLock
    else if (cmd == "scrolllock" || cmd == "scroll") {
        ToggleKey("ScrollLock")
    }
    ; set PPT pen coordinate FHD position
    else if (cmd == 1920) {
        SetPenCoord(cmd, NumPenX, NumPenY)
    }
    ; set PPT pen coordinate QHD position
    else if (cmd == 2560) {
        SetPenCoord(cmd, NumPenX, NumPenY)
    }
    ; command not exist
    else {
        MsgBox "Unknown Command: " cmd, "ERROR", "OK Icon! T5"
    }
    obj.Destroy()
}

; onClick 'Set Offset' button: offset value set
HandleOffset(obj) {
    userInput := obj['UserInput'].Value
    obj.Destroy()
    previous := Offset
    global Offset := userInput
    TrayTips(previous . " to " . Offset, "Mouse Speed Changed", 0x1)
}

HandleRepeatRate(obj) {
    userInput := obj['UserInput'].Value
    obj.Destroy()
    previous := RepeatTime
    global RepeatTime := userInput
    TrayTips(previous . " to " . RepeatTime, "Key RepeatRate Changed", 0x1)
}

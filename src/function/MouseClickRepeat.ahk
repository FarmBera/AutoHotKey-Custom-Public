MouseClickRepeat(button, RepeatTime) {
    while GetKeyState("LShift", "P") && GetKeyState(button, "P") {
        if (button == "u") {
            MouseClick "Left"
        }
        else if (button == "o") {
            MouseClick "Right"
        }
        Sleep RepeatTime
    }
}
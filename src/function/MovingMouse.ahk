MovingMouse(key, Offset) {
    While GetKeyState(key, "P") {
        Switch key {
            Case "i":
                MouseMove 0, (Offset * -1), 0, "R"
            Case "k":
                MouseMove 0, Offset, 0, "R"
            Case "j":
                MouseMove (Offset * -1), 0, 0, "R"
            Case "l":
                MouseMove Offset, 0, 0, "R"
        }
        Sleep 10
    }
}
#Include ShowTooltip.ahk

; tidal playlist add macro
AddToPlaylist(loopCount, delay:=75) {
    MouseGetPos &xPos, &yPos
    MouseClick "Left", xPos, yPos, 1
    Sleep delay
    loop loopCount {
        Send "{Tab}"
        Sleep delay
    }
    Send "{Enter}"               
    ShowTooltip("Tidal Playlist Added")
}
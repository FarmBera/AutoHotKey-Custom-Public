#Include ShowTooltip.ahk

; NUMPAD Action
PenToolClick(idx, NumPenX, NumPenY) {    
    ; global NumPenX, NumPenY

    xPos := NumPenX[idx]
    yPos := NumPenY[idx]

    MouseClick "Left", xPos, yPos, 1, 0
    ShowTooltip("Mouse Clicked " . xPos . ", " . yPos)

    return {x: NumPenX, y: NumPenY}
}
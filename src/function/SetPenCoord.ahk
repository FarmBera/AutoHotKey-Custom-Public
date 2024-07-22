#Include TrayTips.ahk

; set pentool 
SetPenCoord(res, NumPenX, NumPenY) {
    ; global NumPenX, NumPenY

    NumPenFHD := [185, 230, 280, 380, 430, 480, 30, 80, 130, 100]

    if (res == 1920) {
        ; [FHD] set default position
        NumPenX := NumPenFHD
    }
    else if (res == 2560) {
        ; set QHD position
        NumPenQHD := [220, 280, 340, 460, 520, 580, 36, 100, 160, 140]
        NumPenX := NumPenQHD
    }
    else {
        MsgBox "Will setup Default value (FHD value)", "Resolution Exception", "0x10 T1"
        ; [FHD] set default position
        NumPenX := NumPenFHD
    }

    ; set Y coordinate
    i := 1
    loop 9 {
        NumPenY[i] := NumPenX[10]
        i := i + 1
    }

    TrayTips("PPT PenTool setup complete!`nfor " . res . " Resolution", "Task Complete", "0x1")

    return {x: NumPenX, y: NumPenY}
}

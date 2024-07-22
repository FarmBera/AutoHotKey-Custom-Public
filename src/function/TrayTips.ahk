; notify information + timeout
TrayTips(body, title, option, time:=1500) {
    TrayTip body, title, option
    SetTimer () => TrayTip(), -time
    ; close notification after 'time'
}
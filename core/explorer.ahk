#IfWinActive ahk_exe explorer.exe

$j::
    Send {Down}
return

$k::
    Send {Up}
return

$h::
    Send !{Left}
return

$l::
    Send !{Right}
return

$g::
    GetKeyState, CapLck, CapsLock, T
    if ( CapLck == "D" ) {
        Send {End}
    } else if (A_TimeSincePriorHotkey < 400) and ( A_PriorHotkey = "g" ) {
        Send {Home}
    }
return

$+g::
    Send {End}
return

$o::
    Send {AppsKey}
return

$p::
    OpenTerminal("cmd")
return

#IfWinActive

$#p::
    OpenTerminal("powershell")
return

OpenTerminal(shellType)
{
    explorePath := GetExplorerPath()
    
    if (explorePath) {
        if (shellType = "powershell") {
            Run, pwsh.exe -NoExit -Command "cd ""%explorePath%"""
        } else if (shellType = "cmd") {
            Run, cmd.exe /k "cd /d ""%explorePath%"""
        }        
    }    
}

GetExplorerPath()
{
    hwnd := WinActive("A")
    
    if(hwnd==0) {
        explorerHwnd := WinActive("ahk_class CabinetWClass")
        if(explorerHwnd==0) {
            explorerHwnd := WinExist("ahk_class CabinetWClass")
        }
    } else {
        explorerHwnd := WinExist("ahk_class CabinetWClass ahk_id " . hwnd)
    }
    
    if (explorerHwnd) {
        for window in ComObjCreate("Shell.Application").Windows{
            try {
                if (window && window.hwnd && window.hwnd==explorerHwnd) {
                    return window.Document.Folder.Self.Path
                }
            }
        }
    }
    return "C:/Program Files"
}

$#=::
    !=:: ;; alt-=
    WinGet, ow, id, A
    WinTransplus(ow)
return

$#-::
    !-:: ;; alt--
    WinGet, ow, id, A
    WinTransMinus(ow)
return
; WinTransplus WinTransMinus 对ahk_id为w的窗口
; 进行透明度增减，每次幅度为10
WinTransplus(w)
{
    
    WinGet, transparent, Transparent, ahk_id %w%
    if transparent < 255
        transparent := transparent+10
    else
        transparent =
    if transparent
        WinSet, Transparent, %transparent%, ahk_id %w%
    else
        WinSet, Transparent, off, ahk_id %w%
    return
}
WinTransMinus(w)
{
    
    WinGet, transparent, Transparent, ahk_id %w%
    if transparent
        transparent := transparent-10
    else
        transparent := 240
    WinSet, Transparent, %transparent%, ahk_id %w%
    return
}

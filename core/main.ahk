; docs  https://ahkcn.github.io/docs/misc/Clipboard.htm
; WIN   的符号是  #
; Ctrl  的符号是  ^
; Alt   的符号是  !
; Shift 的符号是  +
GroupAdd OneNoteGroup, ahk_exe onenote.exe
GroupAdd VsCodeGroup, ahk_exe Code.exe

; dev
$^s::
    Send ^{s}
    sleep 100
    reload
return

#IfWinNotActive ahk_exe League of Legends.exe

$!c::
    ClipSaved := ClipboardAll
    ClipBoard := ""
    Send ^{c}
    ClipWait
    Send {End}
    Send {Enter}
    ; Clipboard := "printf(""" . Clipboard . " -> %d\n" """, " . Clipboard . ");"
    Clipboard := "console.log(""" . Clipboard . """, " . Clipboard . ");"
    Send ^{v}
    ClipBoard := ClipSaved
return


; ctrl + right -> alt + left  返回
$^RButton::
    Send !{Left}
return

; ctrl + 滚轮 -> alt + right  前进
$^MButton::
    Send !{Right}
return

; https://www.reddit.com/r/AutoHotkey/comments/180ssuw/comment/ka91ser/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
$F8::
    startTime := A_TickCount
    while GetKeyState("F8", "P") {
        if A_TickCount - startTime > 500 {
            Click
        }
    }
    Send {F8}
return

ReverseStringByPairs(str)
{
    length := StrLen(str)  ; 获取字符串长度
    arr := []              ; 用于存储分割后的字符串数组
    
    ; 从字符串末尾开始，将每两个字符分割并存入数组
    while (length > 0) {
        ; 如果剩余字符只有1个，前面补0
        if (length = 1) {
            part := "0" . SubStr(str, length, 1)
        } else {
            part := SubStr(str, length - 1, 2)
        }
        arr.Push(part)
        length -= 2  ; 向前移动2个字符
    }
    reversedStr := ""  ; 用于存储翻转后的字符串
    for idx, element in arr {
        reversedStr .= element
    }
    return reversedStr  ; 返回翻转后的字符串
}

$F7::
    startTime := A_TickCount
    while GetKeyState("F7", "P") {
        ; 按下时间超过500毫秒
        if A_TickCount - startTime > 500 {
            v := ReverseStringByPairs(clipboard)
            ; MsgBox, % "Original String: " clipboard "`nReversed String: " v
            ClipBoard := v
            Send ^{v}
            break
        }
        Sleep, 200
    }
    Send {F7}
return

$#s::
    Search("google")
    
return

$#d::
    Search("baidu")
return

; 选择路径, Win + o 打开文件或目录
; 复制路径, Win + o 打开文件或目录
$#o::
    ;                                             C:\ | C:/
    FoundPos := RegExMatch(ClipBoard, "(^[A-Za-z]:\\.*|^[A-Za-z]:/.*)", Match)
    if (Match) {
        Run powershell -Command "start '%ClipBoard%'"
    } else {
        oCB := ClipBoardAll
        ClipBoard =
        Send ^c
        FoundPos := RegExMatch(ClipBoard, "(^[A-Za-z]:\\.*|^[A-Za-z]:/.*)", Match)
        if (Match) {
            Run powershell -Command "start '%ClipBoard%'"
            ; Run powershell -NoExit -Command "start '%ClipBoard%'"
        }
    }
return

$!d::
    Send ^{d}
return

; 光标左移
$^b::
    Send {Left}
return

; 光标右移
$^f::
    Send {Right}
return

; 光标上移
; OneNote中无法直接映射上下, 改成^Up
$^p::
    if WinActive("ahk_group OneNoteGroup") {
        Send ^{Up}
    } else {
        Send, {Up}
    }
return

; 光标下移
; OneNote中无法直接映射上下, 改成^D
$^n::
    if WinActive("ahk_group OneNoteGroup") {
        Send ^{Down}
    } else {
        Send, {Down}
    }
return

; 光标移动到下个单词
$^#f::
    Send ^{Right}
return

; 光标移动到上个单词
$^#b::
    Send ^{Left}
return

; 光标移动到行首
$^a::
    Send {Home}
return

; 光标移动到行末
$^e::
    Send {End}
return

; 删除
; 向左删除
$^h::
    Send {Backspace}
return

; 向右删除
$^d::
    Send {Del}
return

; 向左删除单词
$^#h::
    Send ^{Backspace}
return

; 向右删除单词
$^#d::
    Send ^{Del}
return

; 删除当前位置到行尾
$^k::
    Send +{End}
    Send {Del}
return

; 删除当前位置到行首
$^u::
    Send +{Home}
    Send {Backspace}
return

; 重新利用被占用热键
; win+f代替C-f（查找）
$#f::
    Send ^{f}
return

; win+f代替C-f（全局查找）
$#j::
    Send ^{j}
return

; win+n代替C-n（新建）
$#n::
    Send ^{n}
return

; win+a代替C-a（全选）
$#a::
    Send ^{a}
return

; win+h代替C-h（chrome查看历史记录）
$#h::
    Send ^{h}
return

; vscoede 向上移动一行
$!p::
    Send !{Up}
return

; vscoede 向下移动一行
$!n::
    Send !{Down}
return

; 换行
$^o::
    Send {End}
    Send {Enter}
return

; 向左选择一行
$^+u::
    Send +{Home}
return

; 向右选择一行
$^+k::
    Send +{End}
return

; 向左选择一个单词
$^+b::
    Send +^{Left}
return

; 向右选择一个单词
$^+f::
    Send +^{Right}
return

; alt + b 输出 alt + Left
$!b::
    Send !{Left}
return

; alt + f 输出 alt + Right
$!f::
    Send !{Right}
return

#IfWinNotActive

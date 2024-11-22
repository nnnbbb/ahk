GetClipboard()
{
    ClipSaved := ClipboardAll
    ClipBoard := ""
    Send ^c
    ClipWait
    s := ClipBoard
    ClipBoard := ClipSaved
    return s
}

Search(website)
{
    ca := GetClipboard()
    FoundPos := RegExMatch(ca, "\t?(https?:\/\/|www\.)", Match)

    if (website = "google") {
        if (FoundPos) {
            run, chrome.exe "%ca%"
        } else {
            run, chrome.exe "https://www.google.com/search?q=%ca%"
        }
    } else {
        if (FoundPos) {
            run, chrome.exe "%ClipBoard%"
        } else {
            run, chrome.exe "https://www.baidu.com/s?wd=%ClipBoard%"
        }
    }    
}

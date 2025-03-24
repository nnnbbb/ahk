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
    found := RegExMatch(ca, "\t?(https?:\/\/|www\.)", Match)

    if (found) {
        run, chrome.exe "%ca%"
    } else if (website = "google") {
        run, chrome.exe "https://www.google.com/search?q=%ca%"
    } else {
        run, chrome.exe "https://www.baidu.com/s?wd=%ca%"
    }
}

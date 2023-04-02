#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

; query box
MyGui := Gui(, "Search")
MyGui.SetFont("s14")
MyGui.Add("Text", "vInfo w300", "Hľadaný výraz:")
MyGui.Add("Edit", "vSearVar w300")
MyGui.Add("Button", "w100 h40 Default", "OK").OnEvent("Click", QueryFun)
MyGui.OnEvent("Close", Closing)
MyGui.OnEvent("Escape", Closing)
MyGui.Show()

; list box
MyList := Gui("+Resize", "Found")
MyList.SetFont("s13 bold")
InfoText := MyList.Add("Text", ,)
MyList.SetFont("s14 norm")
LB := MyList.Add("ListBox", "r5 Sort vItems w700 HScroll500",)
; insert text on double click or press enter
LB.OnEvent("DoubleClick", Sender)
FormatDot := MyList.Add("Radio", "vFormatOpt xp Checked", "dot")
FormatDash := MyList.Add("Radio", "yp", "dash")
FormatRaw := MyList.Add("Radio", "yp", "raw")

MyList.Add("Button", "Default w100 h40 xp+400", "OK").OnEvent("Click", Sender)
MyList.OnEvent("Close", Closing)
MyList.OnEvent("Escape", Closing)


QueryFun(*)
{
  ArrayOfLines := Array()
  Saved := MyGui.Submit()
  MyWord := Saved.SearVar
  HorizBar := false
  loop read "my_phrases.txt"
  {
    if InStr(A_LoopReadLine, MyWord)
    {
      ArrayOfLines.Push(A_LoopReadLine)
      ; if line is longer than 50 chars, apply horizontal bar
      if (StrLen(A_LoopReadLine) > 79)
      {
        HorizBar := true
      }
    }
  }
  if (ArrayOfLines.Length = 0)
  {
    MsgBox("Tento výraz nie je v databáze!")
    ExitApp
  } else
  {
    LB.Add(ArrayOfLines)
    InfoText.Value := "Počet nájdených výrazov: " . ArrayOfLines.Length
    ;widen the control, width is third value
    InfoText.Move(, , 250,)
    if (HorizBar)
    {
      LB.Opt("+HScroll2200")
    }
    MyList.Show()
  }
}

; this works when Multi option is NOT enabled in the listbox
Sender(*)
{
  Saved := MyList.Submit()
  OutFormat := Saved.FormatOpt
  Report := Saved.Items

  switch OutFormat {
    ; dot format
    case 1:
      FirstLetter := SubStr(Report, 1, 1)
      CapFirstLetter := StrUpper(FirstLetter)
      ; Report := RegExReplace(Report, "^.(.*)", CapFirstLetter . "$1.")
      Report := RegExReplace(Report, "^.", CapFirstLetter)
      ; if there is no dot at the end, add dot
      if (!RegExMatch(Report, "\.$"))
      {
        Report .= "."
      }
      ; dash format
    case 2:
      FirstLetter := SubStr(Report, 1, 1)
      LowFirstLetter := StrLower(FirstLetter)
      Report := RegExReplace(Report, "^.", "- " . LowFirstLetter)
      Report := RegExReplace(Report, "\.$", "")
      ; raw format
    case 3:
      Report := StrLower(Report)
      Report := RegExReplace(Report, "\.$", "")
  }

  A_Clipboard := Report
  If !ClipWait(5)
  {
    MsgBox("Adding to clipboard failed!")
    Return
  }
  Send "^v"
  Sleep 500
  A_Clipboard := ""
  ExitApp
}

; this works with arrays, when Multi option is enabled in the listbox
; Sender(*)
; {
;   Report := ""
;   Saved := MyList.Submit()
;   SavedArr := Saved.Items
;   loop SavedArr.Length
;   {
;     Report .= SavedArr[A_Index] . "`n"
;   }

;   Send(Report)
;   Send("{Backspace}")
; }

Closing(*)
{
  answer := MsgBox("Naozaj si želáte opustiť aplikáciu?", "Pozor!", "y/n 48")
  If (answer = "Yes")
  {
    ExitApp
  } Else
  {
    Return 1
  }
}
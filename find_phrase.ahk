#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

; query box
MyGui := Gui(, "Search")
MyGui.SetFont("s14")
MyGui.Add("Text", "vInfo w300", "Hľadaný výraz:")
MyGui.Add("Edit", "vSearVar w300")
MyGui.Add("Button", "w100 h40 Default", "OK").OnEvent("Click", MainFun)
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
MyList.Add("Button", "Default w100 h40", "OK").OnEvent("Click", Sender)
MyList.OnEvent("Close", Closing)
MyList.OnEvent("Escape", Closing)

MainFun(*)
{
  ArrayOfLines := Array()
  Saved := MyGui.Submit()
  MyWord := Saved.SearVar
  horizBar := false
  loop read "my_phrases.txt"
  {
    if InStr(A_LoopReadLine, MyWord)
    {
      ArrayOfLines.Push(A_LoopReadLine)
      ; if line is longer than 50 chars, apply horizontal bar
      if (StrLen(A_LoopReadLine) > 79)
      {
        horizBar := true
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
    if (horizBar)
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
  report := Saved.Items
  A_Clipboard := report
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
;   report := ""
;   Saved := MyList.Submit()
;   SavedArr := Saved.Items
;   loop SavedArr.Length
;   {
;     report .= SavedArr[A_Index] . "`n"
;   }

;   Send(report)
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
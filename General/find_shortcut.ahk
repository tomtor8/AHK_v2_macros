#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

; create arrays of phrases and their respective shortcuts
ConfigFile := ".\list_of_shortcuts.txt"
; PhrasesArr := Array()
; ShortcutsArr := Array()
WholeLineArr := Array()

; read in lines that don't start with #, i.e. non-comment lines
loop read ConfigFile
{
  if RegExMatch(A_LoopReadLine, "^([^#].*)", &WholeLines)
    WholeLineArr.Push(WholeLines[1])
  ; if RegExMatch(A_LoopReadLine, "^([^#].*)<(\w+)>$", &MatchedDg)
  ; {
  ;   PhrasesArr.Push(MatchedDg[1])
  ;   ShortcutsArr.Push(MatchedDg[2])
  ; }
}

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

MyList.Add("Button", "Default w100 h40", "OK").OnEvent("Click", Sender)
MyList.OnEvent("Close", Closing)
MyList.OnEvent("Escape", Closing)


QueryFun(*)
{
  ArrayOfLines := Array()
  Saved := MyGui.Submit()
  MyWord := Saved.SearVar
  HorizBar := false

  loop WholeLineArr.Length
  {
    if InStr(WholeLineArr[A_Index], MyWord)
    {
      ArrayOfLines.Push(WholeLineArr[A_Index])
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
  Line := Saved.Items
  if RegExMatch(Line, "<(\w+)>", &Shortcut)
  {
    ShortCutToSend := Shortcut[1]
    Sleep 500
    Send(ShortCutToSend)
    Sleep 200
    Send("{Tab}")
  }
  Sleep 500
}

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
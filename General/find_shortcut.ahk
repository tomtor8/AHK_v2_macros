#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

; create arrays of phrases and their respective shortcuts
ConfigFile := "..\Other\list_of_shortcuts.txt"
WholeLineArr := []

; read in lines that don't start with #, i.e. non-comment lines
loop read ConfigFile
{
  if RegExMatch(A_LoopReadLine, "^([^#].*)", &WholeLines)
    WholeLineArr.Push(WholeLines[1])
}

; query box
MyGui := Gui(, "Vyhľadávač skratiek")
MyGui.BackColor := "abb2bf"
; MyGui.Opt("-Caption")
MyGui.SetFont("s14 bold")
MyGui.Add("Text", "vInfo w300 c282c34", "Hľadaný výraz:")
MyGui.SetFont("s15 norm")
SearchBar := MyGui.Add("Edit", "vSearVar w700 c282c34")
SearchBar.OnEvent("Change", QueryFun)
; listbox
MyGui.SetFont("s13 bold")
InfoText := MyGui.Add("Text", "c5c6370",)
MyGui.SetFont("s14 norm")
LB := MyGui.Add("ListBox", "Sort vItems w700 HScroll500 c282c34",)
; insert text on double click or press enter
LB.OnEvent("DoubleClick", Sender)

MyGui.Add("Button", "Default w100 h35 Backgroundd19a66", "OK").OnEvent("Click", Sender)
;;;
MyGui.OnEvent("Close", Closing)
MyGui.OnEvent("Escape", Closing)
MyGui.Show()

QueryFun(*)
{
  ; ArrayOfLines := []
  ArrayOfWords := []
  LB.Delete()
  ; ArrayOfWords := Array()
  Saved := MyGui.Submit(0)
  MyPhrase := Saved.SearVar
  InfoText.Value := ""

  HorizBar := false

  if RegExMatch(MyPhrase, "\w\s\w")
  {
    loop parse MyPhrase, A_Space
    {
      ArrayOfWords.Push(A_LoopField)
    }
  } else {
    ArrayOfWords.Push(MyPhrase)
  }
  ; if MyPhrase is not empty, do the following loop
  if MyPhrase
  {
    loop ArrayOfWords.Length
    {
      if A_Index = 1
        LinesToPrint := Looper(ArrayOfWords[A_Index], WholeLineArr)
      else
        LinesToPrint := Looper(ArrayOfWords[A_Index], LinesToPrint)
    }

    LB.Add(LinesToPrint)

    InfoText.Value := "Počet nájdených výrazov: " . LinesToPrint.Length
    ;widen the control, width is third value
    InfoText.Move(, , 250,)
  }

  ; loop through arrays of lines
  ; first loop through every line
  ; next loops through the filtered arrays
  Looper(phrase, ArrayToLoop) {
    ArrayOfLines := []
    Counter := 1
    if phrase
    {
      loop ArrayToLoop.Length
      {
        if InStr(ArrayToLoop[Counter], phrase)
        {
          ArrayOfLines.Push(ArrayToLoop[Counter])

          if (HorizBar)
          {
            LB.Opt("+HScroll2200")
          }
          ; CheckIfInArrayOfLines(WholeLineArr[Counter])
          ; if line is longer than 50 chars, apply horizontal bar
          if (StrLen(A_LoopReadLine) > 79)
          {
            HorizBar := true
          }
        }
        Counter++
      }
    }
    return ArrayOfLines
  }
}

; this works when Multi option is NOT enabled in the listbox
Sender(*)
{
  Saved := MyGui.Submit()
  Line := Saved.Items
  ; micro shortcuts expansion after a Tab
  if RegExMatch(Line, "<(\w+)>", &Shortcut)
  {
    ShortCutToSend := Shortcut[1]
    Sleep 500
    ; sendlevel 1 enables hotstring execution from another script
    SendLevel 1
    Send ShortCutToSend "{Tab}"
  }
  ; macro shortcuts expansion after a comma
  else if RegExMatch(Line, "<(\w+),>", &Shortcut)
  {
    ShortCutToSend := Shortcut[1]
    Sleep 500
    SendLevel 1
    Send ShortCutToSend ","
  }
  else
  {
    ExitApp
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
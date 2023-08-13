﻿#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

; create arrays of phrases and their respective shortcuts
ConfigFile := "..\Other\list_of_shortcuts.txt"
; PhrasesArr := Array()
; ShortcutsArr := Array()
WholeLineArr := []

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
MyGui := Gui(, "Search Shortcuts")
MyGui.SetFont("s14")
MyGui.Add("Text", "vInfo w300", "Hľadaný výraz:")
SearchBar := MyGui.Add("Edit", "vSearVar w300")
SearchBar.OnEvent("Change", QueryFun)
; MyGui.Add("Button", "w100 h40 Default", "OK").OnEvent("Click", QueryFun)
; listbox
MyGui.SetFont("s13 bold")
InfoText := MyGui.Add("Text", ,)
MyGui.SetFont("s14 norm")
LB := MyGui.Add("ListBox", "r5 Sort vItems w700 HScroll500",)
; insert text on double click or press enter
LB.OnEvent("DoubleClick", Sender)

MyGui.Add("Button", "Default w100 h40", "OK").OnEvent("Click", Sender)
;;;
MyGui.OnEvent("Close", Closing)
MyGui.OnEvent("Escape", Closing)
MyGui.Show()

; list box
; MyList := Gui("+Resize", "Found Shortcuts")
; MyList.SetFont("s13 bold")
; InfoText := MyList.Add("Text", ,)
; MyList.SetFont("s14 norm")
; LB := MyList.Add("ListBox", "r5 Sort vItems w700 HScroll500",)
; ; insert text on double click or press enter
; LB.OnEvent("DoubleClick", Sender)

; MyList.Add("Button", "Default w100 h40", "OK").OnEvent("Click", Sender)
; MyList.OnEvent("Close", Closing)
; MyList.OnEvent("Escape", Closing)


QueryFun(*)
{
  ; ArrayOfLines := []
  ArrayOfWords := []
  LB.Delete()
  ; ArrayOfWords := Array()
  Saved := MyGui.Submit(0)
  MyPhrase := Saved.SearVar

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
    ; two words separated by space

  }


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

  ; loop parse MyPhrase, A_Space
  ; {
  ;   ArrayOfWords.Push(A_LoopField)
  ; }

  ; loop ArrayOfWords.Length
  ; {
  ;   InnerCounter := 1
  ;   loop WholeLineArr.Length
  ;   {
  ;     if InStr(WholeLineArr[InnerCounter], ArrayOfWords[OuterCounter])
  ;     {
  ;       CheckIfInArrayOfLines(WholeLineArr[InnerCounter])
  ;       ; if line is longer than 50 chars, apply horizontal bar
  ;       if (StrLen(A_LoopReadLine) > 79)
  ;       {
  ;         HorizBar := true
  ;       }
  ;     }
  ;     InnerCounter++
  ;   }
  ;   OuterCounter++
  ; }

  ; CheckIfInArrayOfLines(item)
  ; {
  ;   loop ArrayOfLines.Length
  ;   {
  ;     if item = ArrayOfLines[A_Index]
  ;       return
  ;   }
  ;   ArrayOfLines.Push(item)
  ; }


  ; if (ArrayOfLines.Length = 0)
  ; {
  ;   MsgBox("Tento výraz nie je v databáze!")
  ;   ExitApp
  ; } else
  ; {
  ;   LB.Add(ArrayOfLines)
  ;   InfoText.Value := "Počet nájdených výrazov: " . ArrayOfLines.Length
  ;   ;widen the control, width is third value
  ;   InfoText.Move(, , 250,)
  ;   if (HorizBar)
  ;   {
  ;     LB.Opt("+HScroll2200")
  ;   }
  ;   ; MyList.Show()
  ; }
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
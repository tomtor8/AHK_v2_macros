#SingleInstance Force
; #NoTrayIcon
SetWorkingDir A_ScriptDir

A_Clipboard := ""
Sleep 200
Send("^c")
If !ClipWait(5)
{
  MsgBox("Adding to clipboard failed!")
  ExitApp
}

; ******************************** GUI building **************************
MyGui := Gui("+Resize", "Text Manipulations",)
MyGui.SetFont("s13")
; lower or uppercase group
MyGui.SetFont("bold")
MyGui.Add("GroupBox", "r3", "Change Case")
MyGui.SetFont("norm")
CaseNone := MyGui.Add("Radio", "vCase Checked xp+20 yp+25", "no")
CaseUp := MyGui.Add("Radio", "", "upper")
CaseDn := MyGui.Add("Radio", "", "lower")

; tags
MyGui.SetFont("bold")
MyGui.Add("GroupBox", "ym r4", "Tags")
MyGui.SetFont("norm")
TagNone := MyGui.Add("Radio", "vTags Checked xp+20 yp+25", "none")
TagBold := MyGui.Add("Radio", , "bold")
TagItal := MyGui.Add("Radio", , "italic")
TagUnd := MyGui.Add("Radio", , "underline")

; append to phrases
MyGui.SetFont("bold")
MyGui.Add("GroupBox", "ym r2", "Append to Phrases")
MyGui.SetFont("norm")
AppNone := MyGui.Add("Radio", "vAppend Checked xp+20 yp+25", "no")
AppYes := MyGui.Add("Radio", , "yes")

; OK Button
OkButton := MyGui.Add("Button", "Default w100 h40 xp+100 yp+50", "OK")
OkButton.OnEvent("Click", MainFun)
MyGui.OnEvent("Close", Closing)
MyGui.OnEvent("Escape", Closing)
; show window
MyGui.Show()

; ******************************* main function ************************
MainFun(*)
{
  FileName := "my_phrases.txt"
  output := A_Clipboard
  Saved := MyGui.Submit() ; zero is NOHIDE
  CaseSel := Saved.Case
  TagSel := Saved.Tags
  AppendSel := Saved.Append

  switch CaseSel {
    case 2:
      output := StrUpper(output)
    case 3:
      output := StrLower(output)
  }

  switch TagSel {
    case 2:
      output := RegExReplace(output, "(.+)", "[B]$1[/B]")
    case 3:
      output := RegExReplace(output, "(.+)", "[I]$1[/I]")
    case 4:
      output := RegExReplace(output, "(.+)", "[U]$1[/U]")
  }
  ; append text to file using File object
  switch AppendSel {
    case 1:
      Sender(output)
    case 2:
      try
      {
        FileObj := FileOpen(FileName, "a")
      } catch as Err
      {
        MsgBox("Cannot open " . FileName . " for appending."
          . "`n" . Type(Err) . ": " . Err.Message)
        ExitApp
      }
      ; remove spaces around the phrase
      output := RegExReplace(output, "^\s*(\S[\w\s]*\S)\s*$", "$1")
      output .= "`r`n"
      FileObj.Write(output)
      FileObj.Close()
      MsgBox("Phrase written to " . FileName)
      ExitApp
  }
}
; ****************** send output ***********************
Sender(output)
{
  Sleep 300
  A_Clipboard := output
  If !ClipWait(5)
  {
    MsgBox("Adding to clipboard failed!")
    Return
  }
  Send("^v")
  Sleep 500
  A_Clipboard := ""
  ExitApp
}

; ******************************* closing ***************************
; return 1 prevents the app from closing
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
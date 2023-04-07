#SingleInstance Force
#NoTrayIcon
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
CaseNone := MyGui.Add("Radio", "vCase xp+20 yp+25", "no")
CaseUp := MyGui.Add("Radio", "Checked", "upper")
CaseDn := MyGui.Add("Radio", , "lower")

; tags
MyGui.SetFont("bold")
MyGui.Add("GroupBox", "ym r4", "Tags")
MyGui.SetFont("norm")
TagNone := MyGui.Add("Radio", "vTags xp+20 yp+25", "none")
TagBold := MyGui.Add("Radio", "Checked", "bold")
TagItal := MyGui.Add("Radio", , "italic")
TagUnd := MyGui.Add("Radio", , "underline")

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
  output := A_Clipboard
  Saved := MyGui.Submit() ; zero is NOHIDE
  CaseSel := Saved.Case
  TagSel := Saved.Tags

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
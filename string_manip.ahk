#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

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

; MyGui.Add("Text", "ym", "Ložiskové zmeny")
; FocalYes := MyGui.Add("Radio", "vFocPla", "áno")
; FocalYes.OnEvent("Click", Extent_Toggler)
; FocalNo := MyGui.Add("Radio", "Checked", "nie")
; FocalNo.OnEvent("Click", Extent_Toggler)
; OK button
OkButton := MyGui.Add("Button", "Default w100 h40 xp+100 yp+50", "OK")
OkButton.OnEvent("Click", MainFun)
MyGui.OnEvent("Close", Closing)
MyGui.OnEvent("Escape", Closing)
; show window
MyGui.Show()


; FocalYes.Value = 1 means Checked, 0 is Unchecked
; Extent_Toggler(*)
; {
;   if (Extent.Enabled = false and FocalYes.Value = 1
;     or Extent.Enabled = true and FocalYes.Value = 1)
;   {
;     Extent.Opt("-Disabled")
;   } else
;   {
;     Extent.Opt("+Disabled")
;     Extent.Value := 0
;   }
;   Return
; }

; main function
MainFun(*)
{
  Saved := MyGui.Submit() ; zero is NOHIDE

}
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
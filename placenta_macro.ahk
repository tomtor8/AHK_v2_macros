#SingleInstance Force
SetWorkingDir A_ScriptDir

PlaG := Gui("+Resize", "Placenta Makro",)
PlaG.SetFont("s13")
; size
PlaG.Add("Text", , "Rozmery placenty")
PlaG.Add("Edit", "vSizPla Section", "16x15x3")
PlaG.Add("Text", "ys", "cm")
; weight
PlaG.Add("Text", "xs", "Hmotnosť")
PlaG.Add("Edit", "vWeiPla Section", "450")
PlaG.Add("Text", "ys", "g")
; umbilical cord length
PlaG.Add("Text", "xs", "Dĺžka pupočníka")
PlaG.Add("Edit", "vLenUmb Section", "20")
PlaG.Add("Text", "ys", "cm")
; umbilical cord thickness
PlaG.Add("Text", "xs", "Hrúbka pupočníka")
PlaG.Add("Edit", "vThiUmb Section", "10")
PlaG.Add("Text", "ys", "mm")
; umbilical cord insertion, DDL is dropdown list
PlaG.Add("Text", "xs", "Inzercia pupočníka")
PlaG.Add("DDL", "vInsUmb Choose2 w150", ["centrálne", "excentricky", "marginálne", "velamentózne"])
; pathological changes
PlaG.Add("Text", "ym", "Ložiskové zmeny")
PlaG.Add("Radio", "vFocPla", "áno")
PlaG.Add("Radio", "Checked", "nie")
; extent of pathological changes
Plag.Add("Text", "", "Rozsah zmien")
PlaG.Add("Edit", "vFocPer Section", "10")
Plag.Add("Text", "ys", "%")
; location of pathological changes
PlaG.Add("Text", "xs", "Lokalita zmien")
PlaG.Add("DDL", "vLocPla Choose2 w180", ["centrálne", "marginálne", "marginálne i centrálne"])

OkButton := PlaG.Add("Button", "Default w150 h50 xs+15 y+40", "OK")
OkButton.OnEvent("Click", Placenta)
PlaG.OnEvent("Close", Placenta_Close)
PlaG.OnEvent("Escape", Placenta_Close)

PlaG.Show()

Placenta(*)
{
  Saved := PlaG.Submit()

  PlaG.Destroy()
}
; return 1 prevents the app from closing
Placenta_Close(*)
{
  answer := MsgBox("Naozaj si želáte opustiť aplikáciu?", "Pozor!", "y/n 48")
  If (answer = "Yes")
  {
    ExitApp
  } else
  {
    return 1
  }
}
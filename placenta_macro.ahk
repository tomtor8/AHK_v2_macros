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
; umbilical cord insertion
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
;

PlaG.Add("Button", "w150 h50", "OK").OnEvent("Click", MyFun)
;PlaG.Opt("+AlwaysOnTop")
PlaG.Show()

MyFun(*)
{
  Saved := PlaG.Submit()
  MsgBox("You entered " . Saved.YourName . " in the box.")
  ;  PlaG.Destroy()
}
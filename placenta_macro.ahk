#SingleInstance Force
SetWorkingDir A_ScriptDir

PlaG := Gui("+Resize", "Placenta Makro",)
PlaG.SetFont("s13")
PlaG.Add("Text", , "VEĽKOSŤ V CM")
PlaG.Add("Edit", "vYourName")
PlaG.Add("Button", "w200 h100", "BigBut").OnEvent("Click", MyFun)
;PlaG.Opt("+AlwaysOnTop")
PlaG.Show()

MyFun(*)
{
  Saved := PlaG.Submit()
  MsgBox("You entered " . Saved.YourName . " in the box.")
  ;  PlaG.Destroy()
}
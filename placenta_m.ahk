#SingleInstance Force
SetWorkingDir A_ScriptDir

MyGui := Gui()
MyGui.Add("Text", , "Enter your name")
MyGui.Add("Edit", "vYourName")
MyGui.Add("Button", "w200 h100", "BigBut").OnEvent("Click", MyFun)
;MyGui.Opt("+AlwaysOnTop")
MyGui.Show()

MyFun(*)
{
  Saved := MyGui.Submit()
  MsgBox("You entered " . Saved.YourName . " in the box.")
  ;  MyGui.Destroy()
}
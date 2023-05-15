#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

MyGui := Gui(, "TNM",)
MyGui.SetFont("s13")
;
MyGui.SetFont("bold")
MyGui.Add("Text", , "Skin")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vSkin AltSubmit", ["SCC Head Neck", "SCC Other", "SCC Eyelid", "Melanoma", "Merkel cell carcinoma"])
;
MyGui.SetFont("bold")
MyGui.Add("Text", , "Gyn")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vGyn AltSubmit", ["Endometrium", "Cervix", "Ovary"])


; OK button
MyGui.Add("Text", , "")
OkButton := MyGui.Add("Button", "Default w150 h50 xm+120", "OK")
OkButton.OnEvent("Click", TnmFun)
MyGui.OnEvent("Close", Closing)
MyGui.OnEvent("Escape", Closing)
MyGui.Show()


TnmFun(*)
{
  message := ""
  Saved := MyGui.Submit()
  if (Saved.Skin = 1)
  {
    message .= "T1`ttumor 2 cm or less in greatest dimension`n"
    message .= "T2`ttumor > 2cm and <=4 cm in greatest dimension"
  }


  MsgBox(message, "Skin")
}


#Include "..\Other\closing.ahk"
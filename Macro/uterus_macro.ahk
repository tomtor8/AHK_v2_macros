#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

MyGui := Gui(, "Uterus makro",)
MyGui.SetFont("s13")
; veľkosť uteru
MyGui.SetFont("bold")
MyGui.Add("Text", , "Veľkosť uteru:")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vSize w130", "90 × 60 × 50")
MyGui.Add("Text", "yp", "mm")
; tvar uteru
MyGui.SetFont("bold")
MyGui.Add("Text", "xm", "Tvar uteru:")
MyGui.SetFont("norm")
MyGui.Add("Radio", "vShape Checked", "primeraný")
MyGui.Add("Radio", , "deformovaný")
; farba portia
MyGui.SetFont("bold")
MyGui.Add("Text", , "Portio:")
MyGui.SetFont("norm")
MyGui.Add("ComboBox", "vPortCol Choose1", ["belavé", "ružovobelavé", "červenohnedasté"])
; endocervikálny polyp
MyGui.SetFont("bold")
MyGui.Add("Text", , "Polyp endocervikálny:")
MyGui.SetFont("norm")
MyGui.Add("Radio", "vEndocPol Checked", "prítomný")
MyGui.Add("Radio", , "neprítomný")
; veľkosť polypu endocervixu
MyGui.SetFont("bold")
MyGui.Add("Text", , "Veľkosť polypu:")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vEndocPolSiz", "10 × 5")
MyGui.Add("Text", "yp", "mm")
; výška endometria
MyGui.SetFont("bold")
MyGui.Add("Text", "ym", "Endometrium výška:")
MyGui.SetFont("norm")
MyGui.Add("ComboBox", "vEndomHeig Choose1", ["primeranej výšky", "nízke", "kypré", "zrnité"])
; farba endometria
MyGui.SetFont("bold")
MyGui.Add("Text", , "Endometrium farby:")
MyGui.SetFont("norm")
MyGui.Add("ComboBox", "vEndomCol Choose1", ["žltobelavej", "ružovobelavej", "hnedastej", "červenej"])
; tumor endometria
MyGui.SetFont("bold")
MyGui.Add("Text", , "Tumor endometria:")
MyGui.SetFont("norm")
MyGui.Add("Radio", "vEndomCa Checked", "prítomný")
MyGui.Add("Radio", , "neprítomný")
; veľkosť tumoru
MyGui.SetFont("bold")
MyGui.Add("Text", , "Veľkosť tumoru:")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vTumorSize Section", "40 × 30")
MyGui.Add("Text", "yp", "mm")
; hĺbka invázie
MyGui.SetFont("bold")
MyGui.Add("Text", "xs", "Hĺbka invázie")
MyGui.SetFont("norm")
MyGui.Add("Radio", "vInvDepth", "sliznica")
MyGui.Add("Radio", "Checked", "< 1/2 myometria")
MyGui.Add("Radio", , "> 1/2 myometria")
; polyp endometria
MyGui.SetFont("bold")
MyGui.Add("Text", "ym", "Polyp endometria:")
MyGui.SetFont("norm")
MyGui.Add("Radio", "vEndomPol Checked", "prítomný")
MyGui.Add("Radio", , "neprítomný")
; veľkosť polypu endometria
MyGui.SetFont("bold")
MyGui.Add("Text", , "Veľkosť polypu:")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vEndomPolSiz Section", "15 × 10")
MyGui.Add("Text", "yp", "mm")
; myómy
MyGui.SetFont("bold")
MyGui.Add("Text", "xs", "Myómy:")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vMyoma Choose1", ["neprítomné", "prítomné"])
; počet myómov
MyGui.SetFont("bold")
MyGui.Add("Text", , "Počet myómov:")
MyGui.SetFont("norm")
MyGui.Add("ComboBox", "vMyomaNum Choose1", ["viaceré", "jeden", "dva", "početné"])
; veľkosť myómov
MyGui.SetFont("bold")
MyGui.Add("Text", , "Veľkosť myómov:")
MyGui.SetFont("norm")
MyGui.Add("ComboBox", "vMyomaSize Choose1", ["od 10 mm do 50 mm", "10 mm a 40 mm", "50 mm"])

; OK button
MyGui.Add("Text", , "")
OkButton := MyGui.Add("Button", "Default w150 h50 xp+20 yp+40", "OK")
OkButton.OnEvent("Click", UtMacFun)
MyGui.OnEvent("Close", Closing)
MyGui.OnEvent("Escape", Closing)
MyGui.Show() ; show window


; main function
UtMacFun(*)
{
  Saved := MyGui.Submit(0) ; zero is NOHIDE
  ; CheckedValueNames := ["Periférny okraj", "Spodina"]
  ; ValuesToCheck := [Saved.PerifernyOkraj, Saved.HlbokyOkraj]

  ; if (PeriphCheck.Value = 0 and DeepCheck.Value = 0 and CompCheck.Value = 0)
  ; {
  ;   MsgBox("Chýbajúce údaje o extirpácii! ", "Upozornenie", 48)
  ;   Return
  ; }

  ; check fields, if function returns 1, return, else go on
  ; CheckPoint := RegexCheckFields(CheckedValueNames, ValuesToCheck)
  ; if (CheckPoint = 1)
  ;   Return

  MyGui.Hide()
  report := ""

  PrintReport(report)

}

#Include "..\Other\my_funs.ahk"
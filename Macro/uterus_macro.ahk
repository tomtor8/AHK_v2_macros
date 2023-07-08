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
MyGui.Add("Radio", "vEndocPol Checked", "neprítomný")
MyGui.Add("Radio", , "prítomný")
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
MyGui.Add("ComboBox", "vEndomHeight Choose1", ["primeranej výšky", "nízke", "kypré", "zrnité"])
; farba endometria
MyGui.SetFont("bold")
MyGui.Add("Text", , "Endometrium farby:")
MyGui.SetFont("norm")
MyGui.Add("ComboBox", "vEndomCol Choose1", ["žltobelavej", "ružovobelavej", "hnedastej", "červenej"])
; tumor endometria
MyGui.SetFont("bold")
MyGui.Add("Text", , "Tumor endometria:")
MyGui.SetFont("norm")
MyGui.Add("Radio", "vEndomCa Checked", "neprítomný")
MyGui.Add("Radio", , "prítomný")
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
MyGui.Add("Radio", "vEndomPol Checked", "neprítomný")
MyGui.Add("Radio", , "prítomný")
; veľkosť polypu endometria
MyGui.SetFont("bold")
MyGui.Add("Text", , "Veľkosť polypu:")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vEndomPolSize Section", "15 × 10")
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
  report := "Uterus veľkosti cca " . Saved.Size . " mm, "
  report .= (Saved.Shape = 1) ? "primeraného" : "deformovaného"
  report .= " tvaru, seróza hnedá, hladká. Portio " . Saved.PortCol . ", hladké, "
  report .= "endocervikálny kanál "
  report .= (Saved.EndocPol = 1) ? "voľný. " : " s prítomným polypom žltobelavej farby, veľkosti cca " . Saved.EndocPolSiz . " mm. "
  if (Saved.EndomCa = 1)
  {
    report .= "Endometrium " . Saved.EndomHeight . ", " . Saved.EndomCol . " farby, "
    report .= (Saved.EndomPol = 1) ? "bez ložiskových zmien. " : " s prítomným polypom hnedastej farby, veľkosti cca " . Saved.EndomPolSize . " mm. "
  }
  else
  {
    report .= "Endometrium v oblasti tela a fundu s prítomným tumorom " . Saved.EndomCol . " farby, mäkkej konzistencie, "
    if (Saved.InvDepth = 1)
      report .= "lokalizovaným v sliznici, bez makroskopickej infiltrácie myometria. "
    else if (Saved.InvDepth = 2)
      report .= "infiltrujúcim makroskopicky do menej ako 1/2 hrúbky myometria. "
    else
      report .= "infiltrujúcim makroskopicky do viac ako 1/2 hrúbky myometria. "
  }

  if (Saved.Myoma = 1)
    report .= "Myometrium bez ložiskových zmien."
  else
  {
    if (Saved.MyomaNum = "jeden")
      report .= "V myometriu prítomný jeden dobre ohraničený belavý solídny uzol"
    else
      report .= "V myometriu prítomné " . Saved.MyomaNum . " dobre ohraničené belavé solídne uzly"
    report .= " priemeru " . Saved.MyomaSize . "."
  }

  PrintReport(report)

}

#Include "..\Other\my_funs.ahk"
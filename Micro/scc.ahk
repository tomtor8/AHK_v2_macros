#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

MyGui := Gui(, "SCC mikro",)
MyGui.SetFont("s13")
; grade
MyGui.SetFont("bold")
MyGui.Add("Text", , "Grade")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vGrade Choose1", ["1", "2", "3"])
; diameter
MyGui.SetFont("bold")
MyGui.Add("Text", , "Horizont. rozmer")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vHorizont", "10")
; thickness
MyGui.SetFont("bold")
MyGui.Add("Text", , "Hrúbka")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vThickness", "10")
; hĺbka invázie
MyGui.SetFont("bold")
MyGui.Add("Text", , "Hĺbka invázie")
MyGui.SetFont("norm")
MyGui.Add("Radio", "vDepth Checked", "papilárne kórium")
MyGui.Add("Radio", , "retikulárne kórium")
MyGui.Add("Radio", , "subcutis")
; angioinvázia
MyGui.SetFont("bold")
MyGui.Add("Text", , "Angioinvázia")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vAngio Choose1", ["neprítomná", "prítomná"])
; perineurálna invázia
MyGui.SetFont("bold")
MyGui.Add("Text", , "Perineur. invázia")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vPerineur Choose1", ["neprítomná", "prítomná"])
; extirpácia
MyGui.SetFont("bold")
MyGui.Add("Text", , "Extirpácia")
MyGui.SetFont("norm")
MyGui.Add("Radio", "vExtirp Checked", "kompletná")
MyGui.Add("Radio", , "prítomný na periférii")
MyGui.Add("Radio", , "prítomný na spodine")
; vzdialenosť od okrajov
MyGui.SetFont("bold")
MyGui.Add("Text", , "Vzd. od okrajov")
MyGui.SetFont("norm")
MyGui.Add("Text", , "Periférny okraj:")
MyGui.Add("Edit", "vPerif", "5")
MyGui.Add("Text", , "Spodina:")
MyGui.Add("Edit", "vDeep", "5")


; OK button
MyGui.Add("Text", , "")
OkButton := MyGui.Add("Button", "Default w150 h50 xm+120", "OK")
OkButton.OnEvent("Click", SccFun)
MyGui.OnEvent("Close", Closing)
MyGui.OnEvent("Escape", Closing)
MyGui.Show() ; show window

; main function
SccFun(*)
{
  Saved := MyGui.Submit() ; zero is NOHIDE

  report := "[B]"

  if (Saved.Nevus = 7)
  {
    report .= "LENTIGO SIMPLEX"
  }
  else
  {
    switch Saved.Nevus {
      case 1:
        report .= "INTRADERMÁLNY"
      case 2:
        report .= "ZMIEŠANÝ"
      case 3:
        report .= "JUNKČNÝ"
      case 4:
        report .= "LENTIGINÓZNE JUNKČNÝ"
      case 5:
        report .= "LENTIGINÓZNE ZMIEŠANÝ"
      case 6:
        report .= "DYSPLASTICKÝ"
      case 8:
        report .= "MODRÝ"
    }
    report .= " MELANOCYTOVÝ NÉVUS"
  }

  report .= "[/B]`n"

  switch Saved.Extirp {
    case 1:
      report .= "Kompletná extirpácia lézie.`n "
    case 2:
      report .= "Nekompletná extirpácia lézie, ktorej štruktúry sú prítomné aj v oblasti periférneho okraja materiálu.`n "
    case 3:
      report .= "Nekompletná extirpácia lézie, ktorej štruktúry sú prítomné aj v oblasti spodiny materiálu.`n "
  }

  PrintReport(report)

}

#Include "..\Other\print_report.ahk"
#Include "..\Other\closing.ahk"
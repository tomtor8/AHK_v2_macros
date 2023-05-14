#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

MyGui := Gui(, "SCC mikro",)
MyGui.SetFont("s13")
; grade
MyGui.SetFont("bold")
MyGui.Add("Text", "Section", "Grade")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vGrade Choose1 ys w50", ["1", "2", "3"])
; diameter
MyGui.SetFont("bold")
MyGui.Add("Text", "xs", "Horizont. rozmer")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vHorizont yp", "10")
MyGui.Add("Text", "yp", "mm")
; thickness
MyGui.SetFont("bold")
MyGui.Add("Text", "xs", "Hrúbka")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vThickness yp", "4")
MyGui.Add("Text", "yp", "mm")
; hĺbka invázie
MyGui.SetFont("bold")
MyGui.Add("Text", "xs", "Hĺbka invázie")
MyGui.SetFont("norm")
MyGui.Add("Radio", "vDepth", "papilárne kórium")
MyGui.Add("Radio", "Checked", "retikulárne kórium")
MyGui.Add("Radio", , "subcutis")
; angioinvázia
MyGui.SetFont("bold")
MyGui.Add("Text", , "Angioinvázia")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vAngio Choose1 AltSubmit", ["neprítomná", "prítomná"])
; perineurálna invázia
MyGui.SetFont("bold")
MyGui.Add("Text", "ys Section", "Perineurálna invázia")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vPerineur Choose1 AltSubmit", ["neprítomná", "prítomná"])
; extirpácia
MyGui.SetFont("bold")
MyGui.Add("Text", , "Extirpácia")
MyGui.SetFont("norm")
CompCheck := MyGui.Add("Checkbox", "vComplete Checked", "kompletná")
PeriphCheck := MyGui.Add("Checkbox", "vPeriphery", "prítomný na periférii")
DeepCheck := MyGui.Add("Checkbox", "vDeepMargin", "prítomný na spodine")
; vzdialenosť od okrajov
MyGui.SetFont("bold")
MyGui.Add("Text", , "Vzdialenosť od okrajov")
MyGui.SetFont("norm")
MyGui.Add("Text", , "Periférny okraj:")
MyGui.Add("Edit", "vPerif yp", "5")
MyGui.Add("Text", "yp", "mm")
MyGui.Add("Text", "xs", "Spodina:")
MyGui.Add("Edit", "vDeep yp", "5")
MyGui.Add("Text", "yp", "mm")
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
  NegatPeriph := "Periférne okraje`n- bez nádorových zmien, najbližší okraj je vzdialený " . Saved.Perif . " mm.`n"
  NegatDeep := "Spodina`n- bez nádorových zmien, najbližší okraj je vzdialený " . Saved.Deep . " mm.`n "

  report := "[B]SKVAMOCELULÁRNY KARCINÓM[/B]`nGrade " . Saved.Grade . ".`n"
  report .= "Maximálny horizontálny rozmer novotvaru " . Saved.Horizont . " mm.`n"
  report .= "Maximálna hrúbka novotvaru " . Saved.Thickness . " mm.`n"
  report .= "Novotvar infiltruje do "

  switch Saved.Depth {
    case 1:
      report .= "papilárneho kória"
    case 2:
      report .= "retikulárneho kória"
    case 3:
      report .= "subcutis"

  }
  report .= ".`n"

  report .= (Saved.Angio = 1) ? "Bez zachytenej angioinvázie.`n" : "Fokálne prítomná angioinvázia.`n"
  report .= (Saved.Perineur = 1) ? "Bez zachytenej perineurálnej invázie.`n" : "Fokálne prítomná perineurálna invázia.`n"

  report .= "[I]Resekčné okraje:[/I]`n"
  ; complete excision
  if (CompCheck.Value = 1 and PeriphCheck.Value = 0 and DeepCheck.Value = 0)
  {
    report .= NegatPeriph
    report .= NegatDeep
  }
  ; positive periphery
  if (CompCheck.Value = 0 and PeriphCheck.Value = 1 and DeepCheck.Value = 0)
  {
    report .= "- štruktúry novotvaru sú fokálne prítomné v oblasti periférneho resekčného okraja.`n"
    report .= NegatDeep
  }
  ; positive deep margin
  if (CompCheck.Value = 0 and PeriphCheck.Value = 0 and DeepCheck.Value = 1)
  {
    report .= NegatPeriph
    report .= "Spodina`n- bez nádorových zmien, najbližší okraj je vzdialený" . Saved.Deep . " mm.`n "
  }
  ; positive both periphery and deep margin
  if (CompCheck.Value = 0 and PeriphCheck.Value = 1 and DeepCheck.Value = 1)
  {
    report .= "- štruktúry novotvaru sú fokálne prítomné v oblasti periférneho resekčného okraja aj spodiny materiálu.`n "
  }

  PrintReport(report)

}

#Include "..\Other\print_report.ahk"
#Include "..\Other\closing.ahk"
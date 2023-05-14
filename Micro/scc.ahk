#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

MyGui := Gui(, "SCC mikro",)
MyGui.SetFont("s13")
; grade
MyGui.SetFont("bold")
MyGui.Add("Text", "Section", "Grade")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vGrade Choose1 ys w40", ["1", "2", "3"])
; diameter
MyGui.SetFont("bold")
MyGui.Add("Text", "xs", "Horizont. rozmer")
MyGui.SetFont("norm")
HorizCtrl := MyGui.Add("Edit", "vHorizontalRozmer yp w40", "10")
MyGui.Add("Text", "yp", "mm")
; thickness
MyGui.SetFont("bold")
MyGui.Add("Text", "xs", "Hrúbka")
MyGui.SetFont("norm")
ThickCtrl := MyGui.Add("Edit", "vHrubka yp w40", "4")
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
MyGui.Add("DDL", "vAngio Choose1 AltSubmit w120", ["neprítomná", "prítomná"])
; perineurálna invázia
MyGui.SetFont("bold")
MyGui.Add("Text", "ys Section", "Perineurálna invázia")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vPerineur Choose1 AltSubmit w120", ["neprítomná", "prítomná"])
; extirpácia
MyGui.SetFont("bold")
MyGui.Add("Text", , "Extirpácia")
MyGui.SetFont("norm")
CompCheck := MyGui.Add("Checkbox", "vComplete Checked", "kompletná")
CompCheck.OnEvent("click", Toggler)
PeriphCheck := MyGui.Add("Checkbox", "vPeriphery", "prítomný na periférii")
PeriphCheck.OnEvent("click", Toggler)
DeepCheck := MyGui.Add("Checkbox", "vDeepMargin", "prítomný na spodine")
DeepCheck.OnEvent("click", Toggler)
; vzdialenosť od okrajov
MyGui.SetFont("bold")
MyGui.Add("Text", , "Vzdialenosť od okrajov")
MyGui.SetFont("norm")
MyGui.Add("Text", , "Periférny okraj:")
PeriphCtrl := MyGui.Add("Edit", "vPerifernyOkraj yp w40", "5")
MyGui.Add("Text", "yp", "mm")
MyGui.Add("Text", "xs", "Spodina:")
DeepCtrl := MyGui.Add("Edit", "vHlbokyOkraj yp w40", "5")
MyGui.Add("Text", "yp", "mm")
; OK button
MyGui.Add("Text", , "")
OkButton := MyGui.Add("Button", "Default w150 h50 xm+120", "OK")
OkButton.OnEvent("Click", SccFun)
MyGui.OnEvent("Close", Closing)
MyGui.OnEvent("Escape", Closing)
MyGui.Show() ; show window

; control toggler
Toggler(*)
{
  ; uncheck complete when positive margins
  if (PeriphCheck.Value = 1 or DeepCheck.Value = 1)
    CompCheck.Value := 0

  Return
}

; main function
SccFun(*)
{
  Saved := MyGui.Submit(0) ; zero is NOHIDE
  ArrOfNames := ["Horizontálny rozmer", "Hrúbka", "Periférny okraj", "Spodina"]
  ArrOfValues := [HorizCtrl.Value, ThickCtrl.Value, PeriphCtrl.Value, DeepCtrl.Value]


  if (PeriphCheck.Value = 0 and DeepCheck.Value = 0 and CompCheck.Value = 0)
  {
    MsgBox("Chýbajúce údaje o extirpácii! ", "Upozornenie", 48)
    Return
  }

  ; validation of fields, field with zero and invalid characters are not allowed
  ZeroCounter := 0
  RegexCounter := 0
  ZeroNames := ""
  RegexNames := ""

  loop ArrOfValues.Length
  {
    if (ArrOfValues[A_Index] = 0)
    {
      ZeroCounter++
      ZeroNames .= ArrOfNames[A_Index] . "`n"
    }
    If RegExMatch(ArrOfValues[A_Index], "^\d{1,2}(,\d)?$") = 0
    {
      RegexCounter++
      RegexNames .= ArrOfNames[A_Index] . "`n"
    }
  }

  if (ZeroCounter = 0 and RegexCounter = 0)
  {
    MyGui.Hide()
  }
  else
  {
    if (ZeroCounter > 0)
    {
      MsgBox("Počet parametrov s nulovou hodnotou: " . ZeroCounter . "`n" . ZeroNames, "Upozornenie", 48)
      Sleep 500
    }
    if (RegexCounter > 0)
    {
      MsgBox("Počet parametrov s nesprávnou hodnotou: " . RegexCounter . "`n" . RegexNames, "Upozornenie", 48)
    }
    Return
  }

  NegatPeriph := "Periférne okraje`n- bez nádorových zmien, najbližší okraj je vzdialený " . Saved.PerifernyOkraj . " mm.`n"
  NegatDeep := "Spodina`n- bez nádorových zmien, najbližší okraj je vzdialený " . Saved.HlbokyOkraj . " mm.`n "

  report := "[B]SKVAMOCELULÁRNY KARCINÓM[/B]`nGrade " . Saved.Grade . ".`n"
  report .= "Maximálny horizontálny rozmer novotvaru " . Saved.HorizontalRozmer . " mm.`n"
  report .= "Maximálna hrúbka novotvaru " . Saved.Hrubka . " mm.`n"
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
    report .= "- štruktúry novotvaru sú prítomné v oblasti periférneho resekčného okraja aj spodiny materiálu.`n "
  }

  PrintReport(report)

}

#Include "..\Other\print_report.ahk"
#Include "..\Other\closing.ahk"
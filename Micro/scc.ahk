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
MyGui.Add("Edit", "vHorizontalRozmer yp w40", "10")
MyGui.Add("Text", "yp", "mm")
; thickness
MyGui.SetFont("bold")
MyGui.Add("Text", "xs", "Hrúbka")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vHrubka yp w40", "4")
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
PeriphCheck.OnEvent("click", Disabler1)
DeepCheck := MyGui.Add("Checkbox", "vDeepMargin", "prítomný na spodine")
DeepCheck.OnEvent("click", Toggler)
DeepCheck.OnEvent("click", Disabler2)
; vzdialenosť od okrajov
MyGui.SetFont("bold")
MyGui.Add("Text", , "Vzdialenosť od okrajov")
MyGui.SetFont("norm")
MyGui.Add("Text", , "Periférny okraj:")
PeriphMarVal := MyGui.Add("Edit", "vPerifernyOkraj yp w40", "5")
MyGui.Add("Text", "yp", "mm")
MyGui.Add("Text", "xs", "Spodina:")
DeepMarVal := MyGui.Add("Edit", "vHlbokyOkraj yp w40", "5")
MyGui.Add("Text", "yp", "mm")
; OK button
MyGui.Add("Text", , "")
OkButton := MyGui.Add("Button", "Default w150 h50 xm+140", "OK")
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

; disable values in case of positive margins
Disabler1(*)
{
  if (PeriphCheck.Value = 1)
  {
    PeriphMarVal.Opt("+Disabled")
    PeriphMarVal.Value := "X"
  }
  else
  {
    PeriphMarVal.Opt("-Disabled")
    PeriphMarVal.Value := ""
  }
}

Disabler2(*)
{
  if (DeepCheck.Value = 1)
  {
    DeepMarVal.Opt("+Disabled")
    DeepMarVal.Value := "X"
  }
  else
  {
    DeepMarVal.Opt("-Disabled")
    DeepMarVal.Value := ""
  }
}

; main function
SccFun(*)
{
  Saved := MyGui.Submit(0) ; zero is NOHIDE
  CheckedValueNames := ["Horizontálny rozmer", "Hrúbka", "Periférny okraj", "Spodina"]
  ValuesToCheck := [Saved.HorizontalRozmer, Saved.Hrubka, Saved.PerifernyOkraj, Saved.HlbokyOkraj]

  if (PeriphCheck.Value = 0 and DeepCheck.Value = 0 and CompCheck.Value = 0)
  {
    MsgBox("Chýbajúce údaje o extirpácii! ", "Upozornenie", 48)
    Return
  }
  ; check fields, if function returns 1, return, else go on
  CheckPoint := RegexCheckFields(CheckedValueNames, ValuesToCheck)
  if (CheckPoint = 1)
    Return

  MyGui.Hide()

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
    report .= "Periférne okraje`n- štruktúry novotvaru sú fokálne prítomné v oblasti periférneho resekčného okraja.`n"
    report .= NegatDeep
  }
  ; positive deep margin
  if (CompCheck.Value = 0 and PeriphCheck.Value = 0 and DeepCheck.Value = 1)
  {
    report .= NegatPeriph
    report .= "Spodina`n- štruktúry novotvaru sú fokálne prítomné v oblasti spodiny materiálu.`n"
  }
  ; positive both periphery and deep margin
  if (CompCheck.Value = 0 and PeriphCheck.Value = 1 and DeepCheck.Value = 1)
  {
    report .= "- štruktúry novotvaru sú prítomné v oblasti periférneho resekčného okraja aj spodiny materiálu.`n "
  }

  PrintReport(report)
}

#Include "..\Other\my_funs.ahk"
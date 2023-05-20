#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

MyGui := Gui(, "BCC mikro",)
MyGui.SetFont("s13")
; grade
MyGui.SetFont("bold")
MyGui.Add("Text", "Section", "Subtyp")
MyGui.SetFont("norm")
MyGui.Add("ComboBox", "vSubtyp Choose1 ys w130", ["nodulárny", "superficiálny", "mikronodulárny"])
; hĺbka invázie
MyGui.SetFont("bold")
MyGui.Add("Text", "xs", "Hĺbka invázie")
MyGui.SetFont("norm")
MyGui.Add("Radio", "vDepth", "papilárne kórium")
MyGui.Add("Radio", "Checked", "retikulárne kórium")
MyGui.Add("Radio", , "subcutis")
; extirpácia
MyGui.SetFont("bold")
MyGui.Add("Text", "ys Section", "Extirpácia")
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
MyGui.Add("Edit", "vPerifernyOkraj yp w40", "5")
MyGui.Add("Text", "yp", "mm")
MyGui.Add("Text", "xs", "Spodina:")
MyGui.Add("Edit", "vHlbokyOkraj yp w40", "5")
MyGui.Add("Text", "yp", "mm")
; OK button
MyGui.Add("Text", , "")
OkButton := MyGui.Add("Button", "Default w150 h50 xm+20", "OK")
OkButton.OnEvent("Click", BccFun)
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
BccFun(*)
{
  Saved := MyGui.Submit(0) ; zero is NOHIDE
  CheckedValueNames := ["Periférny okraj", "Spodina"]
  ValuesToCheck := [Saved.PerifernyOkraj, Saved.HlbokyOkraj]

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

  report := "[B]BAZOCELULÁRNY KARCINÓM[/B]`n"
  report .= "- " . Saved.Subtyp . " subtyp`n"
  report .= "- infiltruje do "

  switch Saved.Depth {
    case 1:
      report .= "papilárneho kória"
    case 2:
      report .= "retikulárneho kória"
    case 3:
      report .= "subcutis"

  }
  report .= ".`n"


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

#Include "..\Other\my_funs.ahk"
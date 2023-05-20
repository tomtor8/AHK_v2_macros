#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

MyGui := Gui(, "Prostate Carcinoma",)
; lateralita
MyGui.SetFont("s13")
MyGui.SetFont("bold")
MyGui.Add("Text", "Section", "Lateralita")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vLateral Choose1", ["Pravý lalok", "Ľavý lalok"])
; number of cylinders with ca
MyGui.SetFont("s13")
MyGui.SetFont("bold")
MyGui.Add("Text", , "Počet valčekov s Ca")
MyGui.SetFont("norm")
MyGui.Add("Edit")
MyGui.Add("UpDown", "vNumCores Range1-10", 1)
; primary pattern
MyGui.SetFont("s13")
MyGui.SetFont("bold")
MyGui.Add("Text", , "Primary pattern")
MyGui.SetFont("norm")
MyGui.Add("Edit")
MyPrimPat := MyGui.Add("UpDown", "vPrimPat Range3-5", 3)
MyPrimPat.OnEvent("change", Toggler)
; secondary pattern
MyGui.SetFont("s13")
MyGui.SetFont("bold")
MyGui.Add("Text", , "Secondary pattern")
MyGui.SetFont("norm")
MyGui.Add("Edit")
MySecPat := MyGui.Add("UpDown", "vSecPat Range3-5", 3)
MySecPat.OnEvent("change", Toggler)
; perineural invasion
MyGui.SetFont("s13")
MyGui.SetFont("bold")
MyGui.Add("Text", , "Perineurálna invázia")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vPerineur Choose1", ["nezachytená", "prítomná"])
; length of cylinders
MyGui.SetFont("bold")
MyGui.Add("Text", "ys Section", "Dĺžka valčekov")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vLengthAll",)
; length of carcinoma
MyGui.SetFont("bold")
MyGui.Add("Text", , "Dĺžka karcinómu")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vLengthCa",)
; percent pattern 4
MyGui.SetFont("bold")
MyGui.Add("Text", , "Percento pattern 4")
MyGui.SetFont("norm")
MyPatFour := MyGui.Add("Edit", "vPatFour Number Disabled w40", 0)
; kribriform
MyGui.SetFont("bold")
MyGui.Add("Text", , "Kribriformná architektonika")
MyGui.SetFont("norm")
MyKribri1 := MyGui.Add("Radio", "vKribri Checked Disabled", "neprítomná")
MyKribri2 := MyGui.Add("Radio", "Disabled", "prítomná")
; EPE
MyGui.SetFont("bold")
MyGui.Add("Text", , "Extraprostatická extenzia")
MyGui.SetFont("norm")
MyGui.Add("Radio", "vEpe Checked", "neprítomná")
MyGui.Add("Radio", "", "prítomná")
; OK button
MyGui.Add("Text", , "")
OkButton := MyGui.Add("Button", "Default w150 h50 xm+20", "OK")
OkButton.OnEvent("Click", ProstateFun)
MyGui.OnEvent("Close", Closing)
MyGui.OnEvent("Escape", Closing)
MyGui.Show()

; toggle controls
Toggler(*)
{
  if (MyPrimPat.Value = 4 or MySecPat.Value = 4)
  {
    MyPatFour.Opt("-Disabled")
    MyKribri1.Opt("-Disabled")
    MyKribri2.Opt("-Disabled")
  }
  else
  {
    MyPatFour.Opt("+Disabled")
    MyKribri1.Opt("+Disabled")
    MyKribri2.Opt("+Disabled")
    MyPatFour.Value := 0
  }
  Return
}
; main function
ProstateFun(*)
{
  Saved := MyGui.Submit(0)

  ReportTotLen := GetTotalLength(Saved.LengthAll, "dĺžky valčekov")
  if (ReportTotLen = 0)
  {
    MsgBox("Dĺžka valčekov nemôže byť nula alebo prázdna hodnota!", "Upozornenie", 48)
    Return
  }

  ReportTotLenCa := GetTotalLength(Saved.LengthCa, "dĺžky karcinómu")
  if (ReportTotLenCa = 0)
  {
    MsgBox("Dĺžka karcinómu nemôže byť nula alebo prázdna hodnota!", "Upozornenie", 48)
    Return
  }

  if (ReportTotLen = "" or ReportTotLenCa = "")
    Return

  try {
    if (Saved.PatFour > 100)
    {
      MsgBox("Percento pattern 4 nemôže byť viac ako 100", "Upozornenie", 48)
      MyPatFour.Value := 0
      Return
    }
  } catch Error as e {
    MsgBox("Missing value in Pattern four percentage!", "Upozornenie", 48)
    Return
  }

  try {
    if (ReportTotLen < ReportTotLenCa)
    {
      MsgBox("Dĺžka karcinómu nemôže byť väčšia ako dĺžka valčekov!", "Upozornenie", 48)
      Return
    }
  }

  try {
    PercentCa := Round((ReportTotLenCa / ReportTotLen) * 100)
  } catch Error as e {
    MsgBox("Nie je možné vypočítať percento karcinómu!`nNesprávne alebo chýbajúce hodnoty!", "Upozornenie", 48)
    Return
  }

  ; variables
  strana := (Saved.Lateral = "Pravý lalok") ? "pravej" : "ľavej"
  valceky := (Saved.NumCores = 1) ? "valčeku" : "valčekoch"
  GleasScore := Saved.PrimPat + Saved.SecPat

  switch GleasScore {
    case 6:
      GradeGroup := "1"
    case 7:
      if (Saved.PrimPat = 3)
        GradeGroup := "2"
      if (Saved.PrimPat = 4)
        GradeGroup := "3"
    case 8:
      GradeGroup := "4"
    default:
      GradeGroup := "5"
  }

  MyGui.Hide()

  ; LET'S GO
  report := ""

  report := Format(
    "
    (
    [I]{1} prostaty:[/I]
    - v {2} {3} prítomný [B]ACINÁRNY ADENOKARCINÓM PROSTATY[/B]
    - Gleason score {4} ({5}+{6}), grade group {7} (WHO)
    )",
  Saved.Lateral, Saved.NumCores, valceky, GleasScore, Saved.PrimPat, Saved.SecPat, GradeGroup
  )

  report .= (Saved.PatFour = 0 or Saved.PatFour = "") ? "" : "`n- Gleason pattern 4 tvorí " . Saved.PatFour . "% objemu karcinómu"
  report .= (Saved.Kribri = 1) ? "`n- bez prítomnosti kribriformnej architektoniky v invazívnom karcinóme" : "`n- prítomná kribriformná architektonika v teréne invazívneho karcinómu"
  report .= "`n- perineurálna nádorová invázia " . Saved.Perineur
  report .= "`n- bez intravaskulárnej nádorovej propagácie"
  report .= "`n- celková mikroskopická dĺžka valčekov tkaniva prostaty z " . strana . " strany je " . ReportTotLen . " mm"
  report .= "`n- celková lineárna dĺžka nádorovej infiltrácie je " . ReportTotLenCa . " mm"
  report .= "`n- malígna nádorová infiltrácia predstavuje " . PercentCa . "% objemu valčekov z " . strana . " strany`n"
  report .= (Saved.Epe = 1) ? "- bez evidentnej extraprostatickej nádorovej extenzie.`n " : "- ložiskovo prítomná extraprostatická nádorová extenzia.`n "

  PrintReport(report)
}

GetTotalLength(lengths, field)
{
  TotalLength := 0
  try {
    loop parse lengths, ","
    {
      if (RegExMatch(A_LoopField, "^\d{1,2}$"))
        TotalLength := TotalLength + A_LoopField
      else
      {
        MsgBox("Nesprávny formát v poli " . field . "!`nHodnoty oddeľujte čiarkou bez medzery.`nPoužívajte iba jednociferné alebo dvojciferné celé čísla.", "Upozornenie", 48)
        Sleep 500
        return
      }
    }
    Return TotalLength
  } catch Error as e {
    MsgBox("Chyba v poli " . field "!`n" . e.message)
    Return
  }
}

#Include "..\Other\my_funs.ahk"
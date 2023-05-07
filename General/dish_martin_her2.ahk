#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

; ******************************** GUI building **************************
MyGui := Gui("+Resize", "DISH HER2",)
MyGui.SetFont("s13")
; počet signálov
MyGui.Add("Text", "Section", "Priemerný počet signálov HER2:")
HerSigs := MyGui.Add("Edit", "vHerS ys", "2,35")
MyGui.Add("Text", "Section xs", "Priemerný počet signálov CEN17:")
CenSigs := MyGui.Add("Edit", "vCenS ys", "2,05")
; amplifikácia
MyGui.Add("Text", "Section xs", "Stav aplifikácie:")
Amp := MyGui.Add("ComboBox", "vAmplif ys Choose1", ["bez amplifikácie", "s amplifikáciou"])
; stav HER2
MyGui.Add("Text", "Section xs", "Stav HER2:")
Stat := MyGui.Add("ComboBox", "vStatus ys Choose1", ["negatívny", "pozitívny"])
; vyšetrili
MyGui.Add("Text", "Section xs", "Vyšetrili:")
Exam1 := MyGui.Add("ComboBox", "vExamined1 ys Choose1 w230", ["MUDr. J. Gumančík", "prof. MUDr. L. Plank, CSc."])
Exam2 := MyGui.Add("ComboBox", "vExamined2 Choose1 w230", ["MVDr. K. Scheerová", "RNDr. A. Farkašová, PhD."])

; OK Button
OkButton := MyGui.Add("Button", "Default w100 h40 xp+100 yp+50", "OK")
OkButton.OnEvent("Click", MainFun)
MyGui.OnEvent("Close", Closing)
MyGui.OnEvent("Escape", Closing)
; show window
MyGui.Show()

; ******************************* main function ************************
MainFun(*)
{
  output := ""
  Saved := MyGui.Submit() ; zero is NOHIDE
  HerSignals := Saved.HerS
  HerSignals := StrReplace(HerSignals, ".", ",")
  HerSignalsDot := StrReplace(HerSignals, ",", ".")
  CenSignals := Saved.CenS
  CenSignals := StrReplace(CenSignals, ".", ",")
  CenSignalsDot := StrReplace(CenSignals, ",", ".")

  try {
    Ratio := HerSignalsDot / CenSignalsDot
  } catch as Err {
    MsgBox(
      "
      (
        Vložili ste nesprávne údaje ohľadne počtu signálov.
        Všetky údaje meníme na nulu.
        Prosím zmeňte si údaje manuálne.
      )", , 16)
  HerSignals := 0
    CenSignals := 0
    Ratio := 0
  }
  Ratio := Round(Ratio, 2)
  RatioComma := StrReplace(Ratio, ".", ",")

  output := Format(
    "
    (
      Nález z Martinského bioptického centra s.r.o.:
      {8}
      DISH analýza amplifikácie génu HER2 (použitá sonda Ventana, parafínový rez):
      - priemerný počet signálov HER2 v bunke: {1}
      - priemerný počet signálov CEN-17 v bunke: {2}
      - pomer HER2/CEN17: {3} = {4} HER2 génu.
      {8}
      [B]Záver: {5} stav HER2.[/B]
      {8}
      Vyšetrili: {6}, {7}
    )",
  HerSignals, CenSignals, RatioComma, Amp.Text, Stat.Text, Exam1.Text, Exam2.Text, " "
  )

  Sleep 300
  A_Clipboard := output
  If !ClipWait(5)
  {
    MsgBox("Adding to clipboard failed!")
    Return
  }
  Send("^v")
  Sleep 500
  A_Clipboard := ""
  ExitApp
}

; ******************************* closing ***************************
; return 1 prevents the app from closing
Closing(*)
{
  answer := MsgBox("Naozaj si želáte opustiť aplikáciu?", "Pozor!", "y/n 48")
  If (answer = "Yes")
  {
    ExitApp
  } Else
  {
    Return 1
  }
}
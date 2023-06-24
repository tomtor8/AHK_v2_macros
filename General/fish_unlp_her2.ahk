#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

; ******************************** GUI building **************************
MyGui := Gui("+Resize", "FISH HER2",)
MyGui.SetFont("s13")
; počet signálov
MyGui.Add("Text", "Section", "Priemerný počet signálov HER2:")
HerSigs := MyGui.Add("Edit", "vHerS ys", "2,5")
MyGui.Add("Text", "Section xs", "Priemerný počet signálov CEP17:")
CenSigs := MyGui.Add("Edit", "vCenS ys", "2,3")
; amplifikácia
MyGui.Add("Text", "Section xs", "Stav aplifikácie:")
Amp := MyGui.Add("ComboBox", "vAmplif ys Choose1", ["Neamplifikovaný", "Amplifikovaný"])
; stav HER2
MyGui.Add("Text", "Section xs", "Stav HER2:")
Stat := MyGui.Add("ComboBox", "vStatus ys Choose1", ["negatívny", "pozitívny"])
; vyšetrili
MyGui.Add("Text", "Section xs", "Vyšetril:")
Exam1 := MyGui.Add("ComboBox", "vExamined1 ys Choose1 w230", ["RNDr. Lucia Fröhlichová, PhD."])
; Exam2 := MyGui.Add("ComboBox", "vExamined2 Choose1 w230", ["MVDr. K. Scheerová", "RNDr. A. Farkašová, PhD."])

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
  negation := (Saved.Amplif = "Neamplifikovaný") ? "ne" : ""

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

  ;less than or greater than
  ltgt := (Ratio < 2) ? "<" : ">="

  output := Format(
    "
    (
      Vyšetrenie amplifikácie génu HER2 fluorescenčnou in situ hybridizáciou (FISH) / Oddelenie patológie UNLP, Košice:
      {6}
      Použitá sonda: Poseidon Repeat Free ERBB2, Her-2/Neu (17q12) / SE 17 Control probe (Kreatech, N1)
      {6}
      Reprezentatívnosť vzorky: prítomné je adekvátne množstvo invazívnych nádorových buniek
      Kontrolná vzorka: interná kontrola
      Počet vyšetrených nádorových buniek: 20 + 20
      Priemerný počet HER2 signálov: {1}
      Priemerný počet CEP 17 signálov: {2}
      {6}
      Interpretácia:
      Vo vyšetrenej vzorke {8}dokazujeme amplifikáciu HER2 génu (pomer HER2/CEP 17 je {3} {9} 2,0) - {4} HER2 status.
      {6}
      Záver:
      {7} HER2 gén - {4} HER2 status.
      {6}
      Vyšetrila: {5}
    )",
  HerSignals, CenSignals, RatioComma, Stat.Text, Exam1.Text, " ", Amp.Text, negation, ltgt
  )

  PrintReport(output)
}

#Include "..\Other\my_funs.ahk"
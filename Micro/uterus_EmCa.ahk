﻿#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

; tasks: if umbilical cord length is zero, disable thickness and recompose the sentence with the umbilical cord
; if patological changes are checked yes, the extent value cannot be zero

Ute := Gui(, "Endometrial carcinoma",)
Ute.SetFont("s13")
; cervix zapal
Ute.SetFont("bold")
Ute.Add("Text", , "Cervix zápal")
Ute.SetFont("norm")
Ute.Add("Radio", "vCerZap Checked", "áno")
Ute.Add("Radio", , "nie")
; cervix hsil
Ute.SetFont("bold")
Ute.Add("Text", , "Cervix HSIL")
Ute.SetFont("norm")
Ute.Add("Radio", "vCerHsil", "áno")
Ute.Add("Radio", "Checked", "nie")
; cervix polyp
Ute.SetFont("bold")
Ute.Add("Text", , "Cervix polyp")
Ute.SetFont("norm")
Ute.Add("Radio", "vCerPol", "áno")
Ute.Add("Radio", "Checked", "nie")
; cervix infiltrácia
Ute.SetFont("bold")
Ute.Add("Text", , "Infiltrácia cervixu")
Ute.SetFont("norm")
CerInfCheck := Ute.Add("DDL", "vCerInf Choose1 AltSubmit", ["bez infiltrácie", "iba sliznica", "cervikálna stróma"])
CerInfCheck.OnEvent("Change", Disabler)
; cervikálne okraje
Ute.SetFont("bold")
Ute.Add("Text", , "Vzd. od paracervik. okraja")
Ute.SetFont("norm")
DistParacerCheck := Ute.Add("Edit", "vDistParacer Hidden", "10")
Ute.Add("Text", "yp", "mm")
Ute.SetFont("bold")
Ute.Add("Text", "xm", "Vzd. od vagin. okraja")
Ute.SetFont("norm")
DistVaginCheck := Ute.Add("Edit", "vDistVagin Hidden", "10")
Ute.Add("Text", "yp", "mm")
; istmus
Ute.SetFont("bold")
Ute.Add("Text", "xm", "Istmus")
Ute.SetFont("norm")
Ute.Add("DDL", "vIstInf Choose1 AltSubmit", ["bez infiltrácie", "iba sliznica", "sliznica a myometrium"])
; typ novotvaru
Ute.SetFont("bold")
Ute.Add("Text", "ym", "Typ karcinómu")
Ute.SetFont("norm")
CaTypeCheck := Ute.Add("ComboBox", "vCaType Choose1 AltSubmit", ["endometrioidný", "serózny", "clear cell", "karcinosarkóm", "nediferencovaný"])
CaTypeCheck.OnEvent("Change", Disabler3)
; grade
Ute.SetFont("bold")
Ute.Add("Text", "xp", "Grade")
Ute.SetFont("norm")
CaGradeCheck := Ute.Add("DDL", "vCaGrade Choose1", ["1", "2", "3", "X"])
; depth of invasion
Ute.SetFont("bold")
Ute.Add("Text", "xp", "Infiltrácia")
Ute.SetFont("norm")
CaInfCheck := Ute.Add("DDL", "vCaInf Choose2 AltSubmit", ["endometria", "<1/2 myometria", ">1/2 myometria"])
CaInfCheck.OnEvent("Change", Disabler2)
Ute.SetFont("bold")
Ute.Add("Text", "xp", "Hĺbka invázie")
Ute.SetFont("norm")
MyomDepthCheck := Ute.Add("Edit", "Section vMyomDepth Number w30", "5")
Ute.Add("Text", "yp", "mm")
Ute.SetFont("bold")
Ute.Add("Text", "xs", "Hrúbka myometria")
Ute.SetFont("norm")
MyomThickCheck := Ute.Add("Edit", "vMyomThick Number", "15")
Ute.Add("Text", "yp", "mm")
; Ute.Add("Text", "xs", "Vzdialenosť od serózy")
; Ute.SetFont("norm")
; DistSerCheck := Ute.Add("Edit", "vDistSer", "10")
; Ute.Add("Text", "yp", "mm")
; seróza
Ute.SetFont("bold")
Ute.Add("Text", "xs", "Infiltrácia serózy")
Ute.SetFont("norm")
Ute.Add("Radio", "vSerInf", "áno")
Ute.Add("Radio", "Checked", "nie")
; cievna invázia
Ute.SetFont("bold")
Ute.Add("Text", "ym", "Cievna invázia")
Ute.SetFont("norm")
Ute.Add("DDL", "vAngioInv Choose1 AltSubmit", ["nezachytená", "fokálna (<3)", "extenzívna(>=3)"])
; parametriá
Ute.SetFont("bold")
Ute.Add("Text", "xp", "Infiltrácia parametrií")
Ute.SetFont("norm")
Ute.Add("DDL", "vParamInf Choose1 AltSubmit", ["nezachytená", "vpravo", "vľavo", "obojstranne"])
; endometrium
Ute.SetFont("bold")
Ute.Add("Text", , "Okolité endometrium")
Ute.SetFont("norm")
Ute.Add("DDL", "vEndom Choose8 AltSubmit", ["proliferačné", "sekrečné", "atrofické", "dysfunkčné proliferačné", "dysfunkčné sekrečné", "simplexná hyperplázia", "komplexná hyperplázia", "nezachytené"])
; endometriálny polyp
Ute.SetFont("bold")
Ute.Add("Text", , "Endometriálny polyp")
Ute.SetFont("norm")
Ute.Add("DDL", "vEndomPol Choose3 AltSubmit", ["jeden", "viacero", "nie"])
; leiomyómy
Ute.SetFont("bold")
Ute.Add("Text", , "Myómy")
Ute.SetFont("norm")
Ute.Add("DDL", "vMyom Choose3 AltSubmit", ["jeden", "viacero", "nie"])
; adenomyóza
Ute.SetFont("bold")
Ute.Add("Text", , "Adenomyóza")
Ute.SetFont("norm")
Ute.Add("Radio", "vAdenom", "áno")
Ute.Add("Radio", "Checked", "nie")
; OK button
Ute.SetFont("bold")
Ute.Add("Text", , "")
OkButton := Ute.Add("Button", "Default w150 h50 x+10 y+20", "OK")
OkButton.OnEvent("Click", UterusFun)
Ute.OnEvent("Close", Closing)
Ute.OnEvent("Escape", Closing)
Ute.Show() ; show window

; disable infiltration fields
Disabler(*)
{
  if (CerInfCheck.Value = 3)
  {
    DistParacerCheck.Opt("-Hidden")
    DistVaginCheck.Opt("-Hidden")
  }
  else if (CerInfCheck.Value = 2)
  {
    DistVaginCheck.Opt("-Hidden")
    DistParacerCheck.Opt("+Hidden")
  }
  else
  {
    DistParacerCheck.Opt("+Hidden")
    DistVaginCheck.Opt("+Hidden")
  }
}

Disabler2(*)
{
  if (CaInfCheck.Value = 1)
  {
    MyomDepthCheck.Opt("+Hidden")
    MyomThickCheck.Opt("+Hidden")
    ; DistSerCheck.Opt("+Hidden")
  }
  else
  {
    MyomDepthCheck.Opt("-Hidden")
    MyomThickCheck.Opt("-Hidden")
    ; DistSerCheck.Opt("-Hidden")
  }
}

Disabler3(*)
{
  if (CaTypeCheck.Value != 1)
  {
    CaGradeCheck.Opt("+Hidden")
    CaGradeCheck.Value := 4
  }
  else
  {
    CaGradeCheck.Opt("-Hidden")
  }
}

; main function
UterusFun(*)
{
  Saved := Ute.Submit(0) ; zero is NOHIDE
  CheckedValueNames := ["Vzdialenosť od paracervikálneho okraja", "Vzdialenosť od vaginálneho okraja", "Hĺbka invázie", "Hrúbka myometria"]
  ValuesToCheck := [Saved.DistParacer, Saved.DistVagin, Saved.MyomDepth, Saved.MyomThick]

  ; percent of myometrial infiltration
  InfPercent := Round((Saved.MyomDepth / Saved.MyomThick) * 100, 0)
  ; distance from seroza
  DistSerNum := Saved.MyomThick - Saved.MyomDepth


  if (Saved.CaType = 1 and Saved.CaGrade = "X")
  {
    MsgBox("Endometrioidný adenokarcinóm musím mať uvedený grade!", "Upozornenie", 48)
    Return
  }

  if (Saved.MyomDepth > Saved.MyomThick)
  {
    MsgBox("Hĺbka invázie nesmie byť väčšia ako hrúbka myometria!", "Upozornenie", 48)
    Return
  }

  if (InfPercent > 50 and Saved.CaInf != 3)
  {
    MsgBox("Hĺbka invázie by mala byť viac ako 1/2 hrúbky myometria!", "Upozornenie", 48)
    Return
  }

  if (InfPercent < 50 and Saved.CaInf = 3)
  {
    MsgBox("Hĺbka invázie by mala byť menej ako 1/2 hrúbky myometria!", "Upozornenie", 48)
    Return
  }

  if (DistSerNum > 0 and Saved.SerInf = 1)
  {
    MsgBox("Nesúlad medzi infiltráciou serózy a `nvzdialenosťou novotvaru od serózy!", "Upozornenie", 48)
    Return
  }

  if (DistSerNum = 0 and Saved.SerInf = 2)
  {
    MsgBox("Pravdepodobne by mala byť prítomná infiltrácia serózy!`nVzdialenosť novotvaru od serózy je 0 mm!", "Upozornenie", 48)
    Return
  }

  ; check fields, if function returns 1, return, else go on
  CheckPoint := RegexCheckFields(CheckedValueNames, ValuesToCheck)
  if (CheckPoint = 1)
    Return

  Ute.Hide()


  report := "[I]Uterus:[/I]`nPortio vyšetrené cirkumferentne v 4 kvadrantoch"

  report .= (Saved.CerZap = 1)
    ? "`n- epidermizované ektrópium cervikálnej sliznice s chronickými nešpecifickými zápalovými zmenami"
    : "`n- epidermizované ektrópium cervikálnej sliznice"

  report .= (Saved.CerHsil = 1)
    ? "`n- cervikálny skvamózny epitel fokálne s prejavmi HIGH-GRADE SKVAMÓZNEJ INTRAEPITELOVEJ LÉZIE (HSIL)`n- vaginálny resekčný okraj bez dysplázie`n- bez invazívnych nádorových zmien."
    : "`n- bez dysplázie."

  report .= "`nEndocervikálny kanál"

  report .= (Saved.CerPol = 1)
    ? "`n- ENDOCERVIKÁLNY POLYP bez atypií" : ""

  CerDistReport1 := "`n- vzdialenosť novotvaru od vaginálneho resekčného okraja je " . Saved.DistVagin . " mm"
  CerDistReport2 := "`n- vzdialenosť novotvaru od paracervikálneho resekčného okraja je " . Saved.DistParacer . " mm"

  switch Saved.CerInf {
    case 1:
      report .= "`n- bez nádorových a iných podstatnejších histologických zmien."
    case 2:
      report .= "`n- prítomné prejavy povrchovej nádorovej invázie endocervikálnej sliznice štruktúrami nižšie uvedeného endometriálneho karcinómu, avšak bez nádorovej invázie cervikálnej strómy" . CerDistReport1 . "."
    case 3:
      report .= "`n- prítomné prejavy nádorovej invázie cervikálnej strómy štruktúrami nižšie uvedeného endometriálneho karcinómu" . CerDistReport1 . CerDistReport2 . "."

  }

  report .= "`nIsthmus"

  switch Saved.IstInf {
    case 1:
      report .= "`n- bez nádorových a iných podstatnejších histologických zmien."
    case 2:
      report .= "`n- prítomná povrchová nádorová infiltrácia sliznice štruktúrami nižšie uvedeného endometriálneho karcinómu."
    case 3:
      report .= "`n- prítomná povrchová nádorová infiltrácia sliznice a priľahlého myometria štruktúrami nižšie uvedeného endometriálneho karcinómu."
  }

  report .= "`nCorpus et fundus`n- [B]"

  switch Saved.CaType {
    case 1:
      report .= "ENDOMETRIÁLNY ENDOMETRIOIDNÝ ADENOKARCINÓM"
    case 2:
      report .= "ENDOMETRIÁLNY SERÓZNY ADENOKARCINÓM"
    case 3:
      report .= "ENDOMETRIÁLNY CLEAR CELL ADENOKARCINÓM"
    case 4:
      report .= "KARCINOSARKÓM"
    case 5:
      report .= "ENDOMETRIÁLNY NEDIFERENCOVANÝ KARCINÓM"
  }

  if (Saved.CaGrade = "X")
    report .= "[/B]`n- grade neaplikovateľný"
  else
    report .= "[/B]`n- grade " . Saved.CaGrade


  if (Saved.CaInf = 1)
  {
    report .= "`n- novotvar je lokalizovaný intramukozálne"
  }
  else
  {
    switch Saved.CaInf {
      case 2:
        report .= "`n- novotvar infiltruje do menej ako 1/2 hrúbky myometria (do " . InfPercent . "% hrúbky myometria)"
      case 3:
        report .= "`n- novotvar infiltruje do viac ako 1/2 hrúbky myometria (do " . InfPercent . "% hrúbky myometria)"
    }
    report .= "`n- hĺbka myometriálnej invázie je " . Saved.MyomDepth . " mm"
    report .= "`n- hrúbka myometria je " . Saved.MyomThick . " mm"
    report .= "`n- vzdialenosť novotvaru od serózy je " . DistSerNum . " mm"
  }

  switch Saved.AngioInv {
    case 1:
      report .= "`n- lymfovaskulárna invázia nezachytená"
    case 2:
      report .= "`n- prítomná fokálna lymfovaskulárna invázia (menej ako 3 cievy)"
    case 3:
      report .= "`n- prítomná extenzívna lymfovaskulárna invázia (3 a viac ciev)"
  }

  report .= (Saved.SerInf = 2) ? "`n- seróza bez nádorovej infiltrácie" : "`n- fokálne prítomná nádorová infiltrácia serózy"

  switch Saved.EndomPol {
    case 1:
      report .= "`n- taktiež prítomný ENDOMETRIÁLNY POLYP"
    case 2:
      report .= "`n- taktiež prítomné ENDOMETRIÁLNE POLYPY"
  }

  if (Saved.Endom = 6)
  {
    report .= "`n- okolité endometrium s obrazom SIMPLEXNEJ HYPERPLÁZIE bez atypií"
  }
  else if (Saved.Endom = 7)
  {
    report .= "`n- okolité endometrium fokálne s obrazom ATYPICKEJ HYPERPLÁZIE (komplexnej atypickej hyperplázie)"
  }
  else if (Saved.Endom = 8)
  {
    report .= ""
  }
  else
  {
    switch Saved.Endom {
      case 1:
        phase := "proliferačného"
      case 2:
        phase := "sekrečného"
      case 3:
        phase := "atrofického"
      case 4:
        phase := "dysfunkčného proliferačného"
      case 5:
        phase := "dysfunkčného sekrečného"
    }
    report .= "`n- okolité endometrium " . phase . " charakteru"
  }

  if (Saved.Myom = 3 and Saved.Adenom = 2)
  {
    report .= "`n- myometrium bez podstatnejších histologických zmien."
  }

  if (Saved.Myom = 3 and Saved.Adenom = 1)
  {
    report .= "`n- v myometriu prítomné známky ADENOMYÓZY."
  }

  switch Saved.Myom {
    case 1:
      if (Saved.Adenom = 1)
        report .= "`n- v myometriu prítomný LEIOMYÓM a ADENOMYÓZA."
      else
        report .= "`n- v myometriu prítomný LEIOMYÓM."
    case 2:
      if (Saved.Adenom = 1)
        report .= "`n- v myometriu prítomné LEIOMYÓMY a ADENOMYÓZA."
      else
        report .= "`n- v myometriu prítomné LEIOMYÓMY."
  }

  ; parametria
  switch Saved.ParamInf {
    case 1:
      report .= "`nParametriá obojstranne bez nádorových zmien."
    case 2:
      report .= "`nPrítomná nádorová infiltrácia parametrií vpravo."
    case 3:
      report .= "`nPrítomná nádorová infiltrácia parametrií vľavo."
    case 4:
      report .= "`nPrítomná obojstranná nádorová infiltrácia parametrií."

  }

  report .= "`n `n[I]Imunohistochemická analýza:[/I]"
  report .= "`nEstrogen receptor: pozitívna expresia v % nádorových buniek"
  report .= "`nProgesteron receptor: pozitívna expresia v % nádorových buniek"
  report .= "`np53: bez aberantnej expresie"
  report .= "`nMismatch repair proteíny (MLH1, PMS2, MSH2, MSH6) so zachovanou normálnou expresiou vo všetkých 4 vyšetrených proteínoch."


  report .= "`n `nStaging hodnotený podľa: Protocol for the Examination of Specimens From Patients With Carcinoma and Carcinosarcoma of the Endometrium, verzia 4.4.0.0, December 2022. (https://www.cap.org/protocols-and-guidelines/cancer-reporting-tools/cancer-protocol-templates)"

  PrintReport(report)
}

#Include "..\Other\my_funs.ahk"
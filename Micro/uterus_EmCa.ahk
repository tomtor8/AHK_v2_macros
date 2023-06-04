#SingleInstance Force
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
Ute.Add("DDL", "vCerInf Choose1 AltSubmit", ["bez infiltrácie", "iba sliznica", "cervikálna stróma"])
; cervikálne okraje
Ute.SetFont("bold")
Ute.Add("Text", , "Vzd. od paracervik. okraja")
Ute.SetFont("norm")
Ute.Add("Edit", "vDistParacer", "10")
Ute.Add("Text", "yp", "mm")
Ute.SetFont("bold")
Ute.Add("Text", "xm", "Vzd. od vagin. okraja")
Ute.SetFont("norm")
Ute.Add("Edit", "vDistVagin", "10")
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
Ute.Add("ComboBox", "vCaType Choose1 AltSubmit", ["endometrioidný", "serózny", "clear cell", "karcinosarkóm", "nediferencovaný"])
; grade
Ute.SetFont("bold")
Ute.Add("Text", "xp", "Grade")
Ute.SetFont("norm")
Ute.Add("DDL", "vCaGrade Choose1", ["1", "2", "3", "X"])
; depth of invasion
Ute.SetFont("bold")
Ute.Add("Text", "xp", "Infiltrácia")
Ute.SetFont("norm")
Ute.Add("DDL", "vCaInf Choose1", ["sliznice", "<1/2 myometria", ">1/2 myometria"])
Ute.SetFont("bold")
Ute.Add("Text", "xp", "Hĺbka invázie")
Ute.SetFont("norm")
Ute.Add("Edit", "Section vMyomDepth w30", "5")
Ute.Add("Text", "yp", "mm")
Ute.SetFont("bold")
Ute.Add("Text", "xs", "Hrúbka myometria")
Ute.SetFont("norm")
Ute.Add("Edit", "vMyomThick", "15")
Ute.Add("Text", "yp", "mm")
Ute.Add("Text", "xs", "Vzdialenosť od serózy")
Ute.SetFont("norm")
Ute.Add("Edit", "vDistSer", "10")
Ute.Add("Text", "yp", "mm")
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
Ute.Add("DDL", "vEndom AltSubmit", ["proliferačné", "sekrečné", "atrofické", "dysfunkčné proliferačné", "dysfunkčné sekrečné", "simplexná hyperplázia", "komplexná hyperplázia"])
; endometriálny polyp
Ute.SetFont("bold")
Ute.Add("Text", , "Endometriálny polyp")
Ute.SetFont("norm")
Ute.Add("DDL", "vEndomPol Choose1 AltSubmit", ["nie", "jeden", "viacero"])
; leiomyómy
Ute.SetFont("bold")
Ute.Add("Text", , "Myómy")
Ute.SetFont("norm")
Ute.Add("DDL", "vMyom Choose1 AltSubmit", ["nie", "jeden", "viacero"])
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

; main function
UterusFun(*)
{
  Saved := Ute.Submit() ; zero is NOHIDE

  report := "[I]Uterus:[/I]`nPortio vyšetrené cirkumferentne v 4 kvadrantoch`n"

  report .= (Saved.CerZap = 1)
    ? "- epidermizované ektrópium cervikálnej sliznice s chronickými nešpecifickými zápalovými zmenami`n"
    : "- epidermizované ektrópium cervikálnej sliznice`n"

  report .= (Saved.CerHsil = 1)
    ? "- cervikálny skvamózny epitel fokálne s prejavmi HIGH-GRADE SKVAMÓZNEJ INTRAEPITELOVEJ LÉZIE (HSIL)`n- vaginálny resekčný okraj bez dysplázie`n- bez invazívnych nádorových zmien.`n"
    : "- bez dysplázie.`n"

  report .= "Endocervikálny kanál`n"

  report .= (Saved.CerPol = 1)
    ? "- ENDOCERVIKÁLNY POLYP bez atypií`n- bez iných podstatnejších zmien.`n"
    : "- bez podstatnejších histologických zmien.`n"

  report .= "Isthmus`n- bez podstatnejších histologických zmien.`nCorpus et fundus`n"

  switch Saved.EndomPol {
    case 1:
      report .= "- ENDOMETRIÁLNY POLYP bez atypií`n"
    case 2:
      report .= "- ENDOMETRIÁLNE POLYPY bez atypií`n"
  }

  if (Saved.Endom = 6)
  {
    report .= "- endometrium s obrazom SIMPLEXNEJ HYPERPLÁZIE bez atypií`n- bez malígnych nádorových zmien`n"
  }
  else if (Saved.Endom = 7)
  {
    report .= "- endometrium fokálne s obrazom ATYPICKEJ HYPERPLÁZIE (komplexnej atypickej hyperplázie)`n- bez malígnych nádorových zmien`n"
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
    report .= "- endometrium " . phase . " charakteru`n- bez atypií, bez hyperplázie`n"
  }

  if (Saved.Myom = 3 and Saved.Adenom = 2)
  {
    report .= "- myometrium bez podstatnejších histologických zmien."
  }

  if (Saved.Myom = 3 and Saved.Adenom = 1)
  {
    report .= "- v myometriu prítomné známky ADENOMYÓZY, bez iných podstatnejších zmien."
  }

  switch Saved.Myom {
    case 1:
      if (Saved.Adenom = 1)
        report .= "- v myometriu prítomný LEIOMYÓM a ADENOMYÓZA."
      else
        report .= "- v myometriu prítomný LEIOMYÓM."
    case 2:
      if (Saved.Adenom = 1)
        report .= "- v myometriu prítomné LEIOMYÓMY a ADENOMYÓZA."
      else
        report .= "- v myometriu prítomné LEIOMYÓMY."
    default:

  }

  PrintReport(report)
}

#Include "..\Other\my_funs.ahk"
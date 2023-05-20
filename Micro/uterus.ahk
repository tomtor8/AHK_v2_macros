#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

; tasks: if umbilical cord length is zero, disable thickness and recompose the sentence with the umbilical cord
; if patological changes are checked yes, the extent value cannot be zero

Ute := Gui(, "Uterus mikro",)
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
; endometrium
Ute.SetFont("bold")
Ute.Add("Text", , "Endometrium")
Ute.SetFont("norm")
Ute.Add("DDL", "vEndom Choose1 AltSubmit", ["proliferačné", "sekrečné", "atrofické", "dysfunkčné proliferačné", "dysfunkčné sekrečné", "simplexná hyperplázia", "komplexná hyperplázia"])
; endometriálny polyp
Ute.SetFont("bold")
Ute.Add("Text", "ys", "Endometriálny polyp")
Ute.SetFont("norm")
Ute.Add("Radio", "vEndomPol", "jeden")
Ute.Add("Radio", , "viacero")
Ute.Add("Radio", "Checked", "nie")

; leiomyómy
Ute.SetFont("bold")
Ute.Add("Text", , "Myómy")
Ute.SetFont("norm")
Ute.Add("Radio", "vMyom", "jeden")
Ute.Add("Radio", "Checked", "viacero")
Ute.Add("Radio", , "nie")
; adenomyóza
Ute.SetFont("bold")
Ute.Add("Text", , "Adenomyóza")
Ute.SetFont("norm")
Ute.Add("Radio", "vAdenom", "áno")
Ute.Add("Radio", "Checked", "nie")
; OK button
Ute.Add("Text", , "")
OkButton := Ute.Add("Button", "Default w150 h50 xm+100", "OK")
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
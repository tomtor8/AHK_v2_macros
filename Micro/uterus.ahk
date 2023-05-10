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
Ute.Add("DDL", "vEndom Choose1", ["proliferačné", "sekrečné", "atrofické", "dysfunkčné proliferačné", "dysfunkčné sekrečné", "simplexná hyperplázia", "komplexná hyperplázia"])
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
; show window
Ute.Show()

; check if the entered number is valid, if not set red background
; Num_Checker(Ctrl)
; {
;   Saved := Ute.Submit("NoHide")

;   if RegExMatch(RetrievedVal, "^\d{0,2}(\b,\b)?\d$") = 0
;   {
;     Weight.Opt("Backgroundred")
;   } else ; restore original background
;   {
;     Weight.Opt("-Background")
;   }
; }

; FocalYes.Value = 1 means Checked, 0 is Unchecked
; Extent_Toggler(*)
; {
;   if (Extent.Enabled = false and FocalYes.Value = 1
;     or Extent.Enabled = true and FocalYes.Value = 1)
;   {
;     Extent.Opt("-Disabled")
;   } else
;   {
;     Extent.Opt("+Disabled")
;     Extent.Value := 0
;   }
;   Return
; }

; main function
UterusFun(*)
{
  Saved := Ute.Submit(0) ; zero is NOHIDE
  If RegExMatch(Saved.SizPla, "^\d{1,2}x\d{1,2}x\d{1,2}$") = 0
  {
    MsgBox(
      "
      (
      Veľkosť placenty je zadaná v nesprávnom formáte.
      Správny formát je napr. 15x10x3.
      )", "Upozornenie", 48
  )
    Return
  }

  counter := 0 ; counts empty values in the Saved object
  For Name, Val in Saved.OwnProps()
    if (Val = "")
    {
      counter++

    }

  switch counter
  {
    case 0:
      Ute.Hide()
    case 1:
      MsgBox("Chýba jeden parameter!")
      Return
    default:
      MsgBox("Chýba viac parametrov!")
      Return
  }

  report := Format("Placenta primeraného tvaru, veľkosti {1} cm, hmotnosti {2} g. Pupočník inzeruje {3}, dĺžky {4} cm, hrúbky {5} mm, primerane špiralizovaný, bez pravých uzlov. Plodové obaly svetlohnedasté, polotransparentné, odstupujú od okraja placenty. Choriová platnička fialovohnedastej farby, bez ložiskových zmien. Bazálna platnička nenarušená, bez impresií. Tkanivo placenty na reznej ploche bordovej farby,",
    Saved.SizPla, Saved.WeiPla, Saved.InsUmb, Saved.LenUmb, Saved.ThiUmb)
  ; ternary operator ... adding to report
  report .= (Saved.FocPla = 1)
    ? Format(" s viacerými sivobelavými ložiskami tuhšej konzistencie, lokalizovanými {1}, zaberajúcimi cca {2}% objemu placenty.", Saved.LocPla, Saved.FocPer)
    : " bez ložiskových zmien."

  A_Clipboard := report
  If !ClipWait(5)
  {
    MsgBox("Adding to clipboard failed!")
    Return
  }
  Send "^v"
  Sleep 500
  A_Clipboard := ""
  ExitApp
}
; return 1 prevents the app from closing
Closing(*)
{
  answer := MsgBox("Naozaj si želáte opustiť aplikáciu?", "Pozor!", "y/n 48")
  If (answer = "Yes")
  {
    ExitApp
  } else
  {
    return 1
  }
}
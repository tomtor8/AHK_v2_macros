#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

; tasks: if umbilical cord length is zero, disable thickness and recompose the sentence with the umbilical cord
; if patological changes are checked yes, the extent value cannot be zero

PlaG := Gui("+Resize", "Placenta Makro",)
PlaG.SetFont("s13")
; size
PlaG.Add("Text", , "Rozmery placenty")
Size := PlaG.Add("Edit", "vSizPla Section", "16x15x3")
PlaG.Add("Text", "ys", "cm")
; weight
PlaG.Add("Text", "xs", "Hmotnosť")
Weight := PlaG.Add("Edit", "vWeiPla Section Number", "450")
PlaG.Add("Text", "ys", "g")
; umbilical cord length
PlaG.Add("Text", "xs", "Dĺžka pupočníka")
Length := PlaG.Add("Edit", "vLenUmb Section Number", "20")
PlaG.Add("Text", "ys", "cm")
; umbilical cord thickness
PlaG.Add("Text", "xs", "Hrúbka pupočníka")
Thickness := PlaG.Add("Edit", "vThiUmb Section Number", "10")
PlaG.Add("Text", "ys", "mm")
; umbilical cord insertion, DDL is dropdown list
PlaG.Add("Text", "xs", "Inzercia pupočníka")
PlaG.Add("DDL", "vInsUmb Choose2 w150", ["centrálne", "excentricky", "marginálne", "velamentózne"])
; pathological changes
PlaG.Add("Text", "ym", "Ložiskové zmeny")
FocalYes := PlaG.Add("Radio", "vFocPla", "áno")
FocalYes.OnEvent("Click", Extent_Toggler)
FocalNo := PlaG.Add("Radio", "Checked", "nie")
FocalNo.OnEvent("Click", Extent_Toggler)
; extent of pathological changes
Plag.Add("Text", , "Rozsah zmien")
Extent := PlaG.Add("Edit", "vFocPer Section Number Disabled w30", "0")
Plag.Add("Text", "ys", "%")
; location of pathological changes
PlaG.Add("Text", "xs", "Lokalita zmien")
PlaG.Add("DDL", "vLocPla Choose2 w180", ["centrálne", "marginálne", "marginálne i centrálne"])
; OK button
OkButton := PlaG.Add("Button", "Default w150 h50 xs+15 y+40", "OK")
OkButton.OnEvent("Click", Placenta)
PlaG.OnEvent("Close", Placenta_Close)
PlaG.OnEvent("Escape", Placenta_Close)
; show window
PlaG.Show()

; FocalYes.Value = 1 means Checked, 0 is Unchecked
Extent_Toggler(*)
{
  if (Extent.Enabled = false and FocalYes.Value = 1
    or Extent.Enabled = true and FocalYes.Value = 1)
  {
    Extent.Opt("-Disabled")
  } else
  {
    Extent.Opt("+Disabled")
    Extent.Value := 0
  }
  Return
}

; main function
Placenta(*)
{
  Saved := PlaG.Submit(0) ; zero is NOHIDE
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
      PlaG.Hide()
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
Placenta_Close(*)
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
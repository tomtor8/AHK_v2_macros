#SingleInstance Force
SetWorkingDir A_ScriptDir

PlaG := Gui("+Resize", "Placenta Makro",)
PlaG.SetFont("s13")
; size
PlaG.Add("Text", , "Rozmery placenty")
PlaG.Add("Edit", "vSizPla Section", "16x15x3")
PlaG.Add("Text", "ys", "cm")
; weight
PlaG.Add("Text", "xs", "Hmotnosť")
PlaG.Add("Edit", "vWeiPla Section", "450")
PlaG.Add("Text", "ys", "g")
; umbilical cord length
PlaG.Add("Text", "xs", "Dĺžka pupočníka")
PlaG.Add("Edit", "vLenUmb Section", "20")
PlaG.Add("Text", "ys", "cm")
; umbilical cord thickness
PlaG.Add("Text", "xs", "Hrúbka pupočníka")
PlaG.Add("Edit", "vThiUmb Section", "10")
PlaG.Add("Text", "ys", "mm")
; umbilical cord insertion, DDL is dropdown list
PlaG.Add("Text", "xs", "Inzercia pupočníka")
PlaG.Add("DDL", "vInsUmb Choose2 w150", ["centrálne", "excentricky", "marginálne", "velamentózne"])
; pathological changes
PlaG.Add("Text", "ym", "Ložiskové zmeny")
PlaG.Add("Radio", "vFocPla", "áno")
PlaG.Add("Radio", "Checked", "nie")
; extent of pathological changes
Plag.Add("Text", "", "Rozsah zmien")
PlaG.Add("Edit", "vFocPer Section", "10")
Plag.Add("Text", "ys", "%")
; location of pathological changes
PlaG.Add("Text", "xs", "Lokalita zmien")
PlaG.Add("DDL", "vLocPla Choose2 w180", ["centrálne", "marginálne", "marginálne i centrálne"])

OkButton := PlaG.Add("Button", "Default w150 h50 xs+15 y+40", "OK")
OkButton.OnEvent("Click", Placenta)
PlaG.OnEvent("Close", Placenta_Close)
PlaG.OnEvent("Escape", Placenta_Close)

PlaG.Show()

Placenta(*)
{
  Saved := PlaG.Submit()
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
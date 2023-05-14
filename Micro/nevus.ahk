#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

Nev := Gui(, "Nevus mikro",)
Nev.SetFont("s13")
; typ névu
Nev.SetFont("bold")
Nev.Add("Text", , "Typ névu")
Nev.SetFont("norm")
Nev.Add("Radio", "vNevus Checked", "intradermálny")
Nev.Add("Radio", , "zmiešaný")
Nev.Add("Radio", , "junkčný")
Nev.Add("Radio", , "lentiginózne junkčný")
Nev.Add("Radio", , "lentiginózne zmiešaný")
Nev.Add("Radio", , "dysplastický")
Nev.Add("Radio", , "lentigo simplex")
Nev.Add("Radio", , "modrý")
; extirpácia
Nev.SetFont("bold")
Nev.Add("Text", "ym", "Extirpácia")
Nev.SetFont("norm")
Nev.Add("Radio", "vExtirp Checked", "kompletná")
Nev.Add("Radio", , "prítomný na periférii")
Nev.Add("Radio", , "prítomný na spodine")
; OK button
Nev.Add("Text", , "")
OkButton := Nev.Add("Button", "Default w150 h50 xm+120", "OK")
OkButton.OnEvent("Click", NevusFun)
Nev.OnEvent("Close", Closing)
Nev.OnEvent("Escape", Closing)
Nev.Show() ; show window

; main function
NevusFun(*)
{
  Saved := Nev.Submit() ; zero is NOHIDE

  report := "[B]"

  if (Saved.Nevus = 7)
  {
    report .= "LENTIGO SIMPLEX"
  }
  else
  {
    switch Saved.Nevus {
      case 1:
        report .= "INTRADERMÁLNY"
      case 2:
        report .= "ZMIEŠANÝ"
      case 3:
        report .= "JUNKČNÝ"
      case 4:
        report .= "LENTIGINÓZNE JUNKČNÝ"
      case 5:
        report .= "LENTIGINÓZNE ZMIEŠANÝ"
      case 6:
        report .= "DYSPLASTICKÝ"
      case 8:
        report .= "MODRÝ"
    }
    report .= " MELANOCYTOVÝ NÉVUS"
  }

  report .= "[/B]`n"

  switch Saved.Extirp {
    case 1:
      report .= "Kompletná extirpácia lézie.`n "
    case 2:
      report .= "Nekompletná extirpácia lézie, ktorej štruktúry sú prítomné aj v oblasti periférneho okraja materiálu.`n "
    case 3:
      report .= "Nekompletná extirpácia lézie, ktorej štruktúry sú prítomné aj v oblasti spodiny materiálu.`n "
  }

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
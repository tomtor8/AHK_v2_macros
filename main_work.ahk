#SingleInstance Force
#Hotstring EndChars `t
SetWorkingDir A_ScriptDir

^+!u:: {
  try {
    Run("string_manip.ahk")
  } catch as Err {
    MsgBox("The script for string manipulation was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
  Return
}

; toggle always on top active window
^+!t:: {
  WinSetAlwaysOnTop(-1, "A")
  Return
}

; find phrase
:O:phr:: {
  try {
    Run("find_phrase.ahk")
  } catch as Err {
    MsgBox("The script for string manipulation was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
  Return
}

; text shortcuts
:*?:ooo::ó

:*?:ddd::ď

:*c:bez1::- bez iného podstatnejšieho nálezu.{Enter}{Space}
:*c:Bez1::Bez iného podstatnejšieho nálezu.{Enter}{Space}
:*c:bez2::- bez nádorových a iných podstatnejších zmien.{Enter}{Space}
:*c:Bez2::Bez nádorových a iných podstatnejších zmien.{Enter}{Space}
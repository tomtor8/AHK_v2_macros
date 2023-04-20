#SingleInstance Force
#Hotstring EndChars `t
SetWorkingDir A_ScriptDir

; toggle always on top active window
^+!t:: {
  WinSetAlwaysOnTop(-1, "A")
}

; find phrase
; :O:phr:: {
;   try {
;     Run("General\find_phrase.ahk")
;   } catch as Err {
;     MsgBox("The script for string manipulation was not found!"
;       . "`n" Type(Err) . ":`n" . Err.Message, , 16)
;   }
; }

; text shortcuts
:*?:ooo::ó

:*?:ddd::ď

:*c:bez1::- bez iného podstatnejšieho nálezu.{Enter}{Space}
:*c:Bez1::Bez iného podstatnejšieho nálezu.{Enter}{Space}
:*c:bez2::- bez nádorových a iných podstatnejších zmien.{Enter}{Space}
:*c:Bez2::Bez nádorových a iných podstatnejších zmien.{Enter}{Space}

; Uppercase, lowercase, and tags manipulation
^+!u:: {
  try {
    Run("General\change_case_tags.exe")
  } catch as Err {
    MsgBox("The script for string manipulation was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

; accented characters picker
^+!z:: {
  try {
    Run("General\Spec_Chars.exe")
  } catch as Err {
    MsgBox("The script for special characters was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

; tags picker
^+!b:: {
  try {
    Run("General\Tags.exe")
  } catch as Err {
    MsgBox("The script for tag picker was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

; expand tags
:O:bb:: {
  Send("{Raw}[B][/B]")
  Send("{Left 4}")
}

:O:ii:: {
  Send("{Raw}[I][/I]")
  Send("{Left 4}")
}

:O:uu:: {
  Send("{Raw}[U][/U]")
  Send("{Left 4}")
}
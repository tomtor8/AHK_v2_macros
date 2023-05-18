#SingleInstance Force
#Hotstring EndChars `t
SetWorkingDir A_ScriptDir

; remap shift capclock to capslock
+CapsLock::Capslock
; remap capslock to End
CapsLock::End

; toggle always on top active window
^+t:: {
  WinSetAlwaysOnTop(-1, "A")
}

; text shortcuts
:*?:ooo::ó

:*?:ddd::ď

:*?:(::(){Left}

; close and save windows in excidovna
^+q:: {
  Sleep 500
  Send("{Tab}")
  Sleep 500
  Send("{Enter}")
  Sleep 500
  Send("^s")
  Sleep 500
}

; Uppercase, lowercase, and tags manipulation
^+u:: {
  try {
    Run("General\change_case_tags.ahk")
  } catch as Err {
    MsgBox("The script for string manipulation was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

; accented characters picker
^+z:: {
  try {
    Run("General\Spec_Chars.exe")
  } catch as Err {
    MsgBox("The script for special characters was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

; tags picker
^+b:: {
  try {
    Run("General\Tags.exe")
  } catch as Err {
    MsgBox("The script for tag picker was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

; find shortcut
:O:fs:: {
  try {
    Run("General\find_shortcut.ahk")
  } catch as Err {
    MsgBox("The script for finding shortcuts was not found!"
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
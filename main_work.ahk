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
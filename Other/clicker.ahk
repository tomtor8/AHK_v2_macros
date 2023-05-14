#SingleInstance Force
#Hotstring EndChars `t
SetWorkingDir A_ScriptDir

; ********* customizable clicker ****************
ClickConfFile := "click_config.txt"

Coord := {
  x1: {
    val: "",
    patt: "^x1axis:\s*(\d+)\s*$"
  },
  y1: {
    val: "",
    patt: "^y1axis:\s*(\d+)\s*$"
  },
  x2: {
    val: "",
    patt: "^x2axis:\s*(\d+)\s*$"
  },
  y2: {
    val: "",
    patt: "^y2axis:\s*(\d+)\s*$"
  },
}

; find x and y coordinates in the config file
for coordin, params in Coord.OwnProps()
  loop read ClickConfFile
  {
    if RegExMatch(A_LoopReadLine, params.patt, &Coordinate)
    {
      params.val := Coordinate[1]
      Break
    }
  }


if (Coord.x1.val = "" or Coord.y1.val = ""
  or Coord.x2.val = "" or Coord.y2.val = "")
{
  answer := MsgBox("Coordinates error! Check your click config file!"
    . "`nDon't use the clicker functionality!"
    . "`nDo you want to exit the app?", "Error", 20)
  if (answer = "Yes")
  {
    MsgBox("Exiting the app in 4 seconds!", "Goodbye", "T4")
    ExitApp
  }
}

; click
^+!j:: {
  Sleep 1000
  try {
    Click Coord.x1.val, Coord.y1.val
  } catch {
    MsgBox("Incorrect coordinates!"
      . "`nCheck your click config file.", , 16)
  }
  Sleep 1000
  try {
    Click Coord.x2.val, Coord.y2.val
  } catch {
    MsgBox("Incorrect coordinates!"
      . "`nCheck your click config file.", , 16)
  }
}
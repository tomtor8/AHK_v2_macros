#SingleInstance Force
SetWorkingDir A_ScriptDir

; ********* customizable clicker ****************
ClickConfFile := "click_config.txt"

; array of coordinate names
CoorArr := Array()
; read the config coordinates to array CoorArr
; use positive lookahead, enables spaces
loop read ClickConfFile
{
  if RegExMatch(A_LoopReadLine, "^\s*(\w+)\s*(?=:)", &ItemToPush)
    CoorArr.Push(ItemToPush[1])
}

; number of click repeats
if Mod(CoorArr.Length, 2) = 0
  ClickRepeats := CoorArr.Length / 2
else
{
  ClickRepeats := 0
  MsgBox("Odd number of coordinates in CoorArray on line 8!"
    . "`nDoing nothing!", , 16)
}

; create array of regex patterns
PattArr := Array()
; populate the pattern array
loop CoorArr.Length
{
  PattArr.Push("^" . CoorArr[A_Index] . ":\s*(\d+)\s*$")
}
; create object of coordinates with their respective values and patterns
Coord := Object()
loop CoorArr.Length
{
  Coord.DefineProp(CoorArr[A_Index], { value: {
    val: "",
    patt: PattArr[A_Index]
  }
  })
}

; find x and y coordinates in the config file
for coordin, params in Coord.OwnProps()
{
  loop read ClickConfFile
  {
    if RegExMatch(A_LoopReadLine, params.patt, &Coordinate)
    {
      params.val := Coordinate[1]
      Continue 2
    }
  }
  if (params.val = "")
  {
    answer := MsgBox("Coordinates error!"
      . "`nCheck your click_config.txt file or the coordinates array!"
      . "`nDon't use the clicker functionality!"
      . "`nDo you want to exit the app?", "Error", 20)
    if (answer = "Yes")
    {
      MsgBox("Exiting the app in 4 seconds!", "Goodbye", "T4")
      ExitApp
    }
  }
}

; click
^+!g:: {
  index1 := 1
  loop ClickRepeats
  {
    Sleep 1000
    ; get the values of the coordinates in pairs 1,2 3,4 5,6
    goX := Coord.GetOwnPropDesc(CoorArr[index1]).Value.val
    goY := Coord.GetOwnPropDesc(CoorArr[index1 + 1]).Value.val
    ; jump to the next pair of coordinates
    index1 := index1 + 2

    try {
      Click goX, goY
    } catch {
      MsgBox("Incorrect coordinates!"
        . "`nCheck your click config file.", , 16)
    }
  }
}
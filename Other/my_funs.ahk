; paste report
PrintReport(report)
{
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

; validation of fields, field with zero and invalid characters are not allowed, X means disabled field
RegexCheckFields(names, values)
{
  RegexCounter := 0
  RegexNames := ""

  ; regex catches integers from 1-99 and decimals from 0,1 to 99,9 except digit,0
  loop values.Length
  {
    If RegExMatch(values[A_Index], "(^([1-9][0-9]?|[1-9]?[0-9],[1-9])$|^X$)") = 0
    {
      RegexCounter++
      RegexNames .= names[A_Index] . "`n"
    }
  }

  if (RegexCounter > 0)
  {
    MsgBox("Počet parametrov s nesprávnou hodnotou: " . RegexCounter . "`n" . RegexNames, "Upozornenie", 48)
    Return 1
  }
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
; validation of fields, field with zero and invalid characters are not allowed
RegexCheckFields(names, values)
{
  RegexCounter := 0
  RegexNames := ""

  ; regex catches integers from 1-99 and decimals from 0,1 to 99,9 except digit,0
  loop values.Length
  {
    If RegExMatch(values[A_Index], "^([1-9][0-9]?|[1-9]?[0-9],[1-9])$") = 0
    {
      RegexCounter++
      RegexNames .= names[A_Index] . "`n"
    }
  }

  if (RegexCounter > 0)
  {
    MsgBox("Počet parametrov s nesprávnou hodnotou: " . RegexCounter . "`n" . RegexNames, "Upozornenie", 48)
    Return
  }
}
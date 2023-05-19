#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

MyGui := Gui(, "Prostate Carcinoma",)
; lateralita
MyGui.SetFont("s13")
MyGui.SetFont("bold")
MyGui.Add("Text", "Section", "Lateralita")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vLateral Choose1", ["Pravý lalok", "Ľavý lalok"])
; number of cylinders with ca
MyGui.SetFont("s13")
MyGui.SetFont("bold")
MyGui.Add("Text", , "Počet valčekov s Ca")
MyGui.SetFont("norm")
MyGui.Add("Edit")
MyGui.Add("UpDown", "vNumCores Range1-10", 1)
; primary pattern
MyGui.SetFont("s13")
MyGui.SetFont("bold")
MyGui.Add("Text", , "Primary pattern")
MyGui.SetFont("norm")
MyGui.Add("Edit")
MyGui.Add("UpDown", "vPrimPat Range3-5", 3)
; secondary pattern
MyGui.SetFont("s13")
MyGui.SetFont("bold")
MyGui.Add("Text", , "Secondary pattern")
MyGui.SetFont("norm")
MyGui.Add("Edit")
MyGui.Add("UpDown", "vSecPat Range3-5", 3)
; perineural invasion
MyGui.SetFont("s13")
MyGui.SetFont("bold")
MyGui.Add("Text", , "Perineurálna invázia")
MyGui.SetFont("norm")
MyGui.Add("DDL", "vPerineur Choose1", ["nezachytená", "prítomná"])
; length of cylinders
MyGui.SetFont("bold")
MyGui.Add("Text", "ys Section", "Dĺžka valčekov")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vLengthAll",)
; length of carcinoma
MyGui.SetFont("bold")
MyGui.Add("Text", , "Dĺžka karcinómu")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vLengthCa",)
; percent pattern 4
MyGui.SetFont("bold")
MyGui.Add("Text", , "Percento pattern 4")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vPatFour",)
; kribriform
MyGui.SetFont("bold")
MyGui.Add("Text", , "Kribriformná architektonika")
MyGui.SetFont("norm")
MyGui.Add("Radio", "vKribri Checked", "neprítomná")
MyGui.Add("Radio", "", "prítomná")
; EPE
MyGui.SetFont("bold")
MyGui.Add("Text", , "Extraprostatická extenzia")
MyGui.SetFont("norm")
MyGui.Add("Radio", "vEpe Checked", "neprítomná")
MyGui.Add("Radio", "", "prítomná")
; OK button
MyGui.Add("Text", , "")
OkButton := MyGui.Add("Button", "Default w150 h50 xm+20", "OK")
OkButton.OnEvent("Click", ProstateFun)
MyGui.OnEvent("Close", Closing)
MyGui.OnEvent("Escape", Closing)
MyGui.Show()

ProstateFun(*)
{
  Saved := MyGui.Submit(0)
  report := ""

  report .= "Celková dĺžka valčekov je " . GetTotalLength(Saved.LengthAll)
  report .= "`nCelková dĺžka karcinómu je " . GetTotalLength(Saved.LengthCa)

  PrintReport(report)

}


GetTotalLength(lengths)
{
  TotalLength := 0
  try {
    loop parse lengths, ","
    {
      if (RegExMatch(A_LoopField, "^\d{1,2}$"))
        TotalLength := TotalLength + A_LoopField
      else
      {
        MsgBox("Incorrect length value or delimiter")
        return
      }
    }
    Return TotalLength
  } catch Error as e {
    MsgBox("Error in the prostate length field`n" . e.message)
    Return
  }
}

#Include "..\Other\print_report.ahk"
#Include "..\Other\closing.ahk"
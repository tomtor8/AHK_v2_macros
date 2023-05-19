#SingleInstance Force
#NoTrayIcon
SetWorkingDir A_ScriptDir

MyGui := Gui(, "BCC mikro",)
MyGui.SetFont("s13")
; grade
MyGui.SetFont("bold")
MyGui.Add("Text", "Section", "Dlzka valcekov")
MyGui.SetFont("norm")
MyGui.Add("Edit", "vLengths ys w130",)
; OK button
MyGui.Add("Text", , "")
OkButton := MyGui.Add("Button", "Default w150 h50 xm+20", "OK")
OkButton.OnEvent("Click", BccFun)
MyGui.OnEvent("Close", Closing)
MyGui.OnEvent("Escape", Closing)
MyGui.Show()

BccFun(*)
{
  Saved := MyGui.Submit(0)
  TotalLength := 0
  ; check length values
  try {
    loop parse Saved.Lengths, ","
    {
      if (RegExMatch(A_LoopField, "^\d{1,2}$"))
        TotalLength := TotalLength + A_LoopField
      else
      {
        MsgBox("Incorrect value or delimiter")
        return
      }
    }
    MsgBox("The total length is " . TotalLength . " mm.")
  } catch Error as e {
    MsgBox("Error in the prostate length field`n" . e.message)
    Return
  }

  PrintReport(report)

}


#Include "..\Other\print_report.ahk"
#Include "..\Other\closing.ahk"
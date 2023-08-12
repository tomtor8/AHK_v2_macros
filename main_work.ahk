#SingleInstance Force
#Hotstring EndChars `t
SetWorkingDir A_ScriptDir

; keyremaps
SetCapsLockState "AlwaysOff"
; basic arrow navigation
CapsLock & l:: {
  Send("{Right}")
}
CapsLock & h:: {
  Send("{Left}")
}
CapsLock & k:: {
  Send("{Up}")
}
CapsLock & j:: {
  Send("{Down}")
}
; jump to beginning of end of a line
CapsLock & e:: {
  Send("{End}")
}
CapsLock & a:: {
  Send("{Home}")
}
; jump to the beginning or end of a document
CapsLock & i:: {
  Send("^{Home}")
}
CapsLock & m:: {
  Send("^{End}")
}
; jump to next or previous word
CapsLock & w:: {
  Send("^{Right}")
}
CapsLock & b:: {
  Send("^{Left}")
}
; select text forward and backward word by word
CapsLock & q:: {
  Send("^+{Right}")
}
CapsLock & v:: {
  Send("^+{Left}")
}
; forward delete and backspace
CapsLock & d:: {
  Send("{Delete}")
}
CapsLock & s:: {
  Send("{BackSpace}")
}
; delete a line
CapsLock & x:: {
  Send("{Home}")
  Send("+{End}")
  Send("^x")
}
; select a line
CapsLock & c:: {
  Send("{Home}")
  Send("+{End}")
}

; toggle always on top active window
F8:: {
  WinSetAlwaysOnTop(-1, "A")
}

; text shortcuts
:*?:ooo::ó

:*?:ddd::ď

:*?:(::(){Left}

; close and save windows in excidovna
F2:: {
  Sleep 500
  Send("{Tab}")
  Sleep 500
  Send("{Enter}")
  Sleep 500
  Send("^s")
  Sleep 500
}

; Uppercase, lowercase, and tags manipulation
F3:: {
  try {
    Run("General\change_case_tags.ahk")
  } catch as Err {
    MsgBox("The script for string manipulation was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

; accented characters picker
F4:: {
  try {
    Run("General\Spec_Chars.exe")
  } catch as Err {
    MsgBox("The script for special characters was not found!"
      . "`n" Type(Err) . ":`n" . Err.Message, , 16)
  }
}

:Oc:H2:: {
  try {
    Run("General\fish_unlp_her2.ahk")
  } catch as Err {
    MsgBox("The script for FISH HER2 UNLP was not found!"
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

; center window and adjust proportions
; A stands for active window
F9:: {
  MonitorGetWorkArea 1, &WL, &WT, &WR, &WB
  WinMove (WR * 0.15), (WB * 0.1), (WR * 0.7), (WB * 0.8), "A"
}

; center window and leave proportions
F10:: {
  ; get original width and height of the active window
  WinGetPos , , &Width, &Height, "A"
  MonitorGetWorkArea 1, &WL, &WT, &WR, &WB
  WinMove (WR / 2) - (Width / 2), (WB / 2) - (Height / 2), , , "A"
}

; cleanup script
F7::
{
  oldClipboard := ClipboardAll()
  ; ; empty the current clipboard
  A_Clipboard := ""
  Send "^c"
  ; if wait is longer than 2 seconds, false
  If !ClipWait(2) {
    MsgBox("The attempt to copy text onto the clipboard failed.")
    Return
  }

  replacement := A_Clipboard
  ; change 4x5 or 4 x 5... to 4 × 5
  Loop
  {
    replacement := RegExReplace(replacement, "(\d)\s*x\s*(\d)", "$1 × $2", &Count)
    ; count the number of current matches in this loop, if zero, break out
    if (Count = 0)
      break
  }

  ; check double spaces
  Loop
  {
    replacement := StrReplace(replacement, "  ", " ", , &Countofspaces)
    ; Count the number of current matches in this loop, if zero, break out
    if (Countofspaces = 0)
      break
  }

  ; remove spaces before commas and dots
  Loop
  {
    replacement := RegExReplace(replacement, "\s+(\.|,)", "$1", &Count)
    ; count the number of current matches in this loop, if zero, break out
    if (Count = 0)
      break
  }

  A_Clipboard := replacement
  Sleep 500
  Send "^v"
  Sleep 500
  ; restore the old clipboard
  A_Clipboard := oldClipboard
}

; turn blocks of sentences to unordered lists
F5::
{
  oldClipboard := ClipboardAll()
  ; ; empty the current clipboard
  A_Clipboard := ""
  Send "^c"
  ; if wait is longer than 2 seconds, false
  If !ClipWait(2) {
    MsgBox("The attempt to copy text onto the clipboard failed.")
    Return
  }

  finalversion := ""
  ; get the sentences from a block
  loop parse, A_Clipboard, "`n", "`r"
  {
    ;remove spaces in front of the sentence
    sentence := RegExReplace(A_LoopField, "^\s+", "")
    ; make lowercase the first letter, $L1 means lowercase the captured text
    sentence := RegExReplace(sentence, "^(\w)", "$L1")
    ;remove dot at the end
    sentence := RegExReplace(sentence, "\.$", "")
    finalversion .= "`n- " . sentence
  }

  ; remove the first newline character, the last 1 is the limit (only the first occurence is deleted)
  finalversion := StrReplace(finalversion, "`n", "", , , 1)

  A_Clipboard := finalversion
  Sleep 500
  Send "^v"
  Sleep 500
  ; restore the old clipboard
  A_Clipboard := oldClipboard
}

; turn lists to block of sentences
F6::
{
  oldClipboard := ClipboardAll()
  ; ; empty the current clipboard
  A_Clipboard := ""
  Send "^c"
  ; if wait is longer than 2 seconds, false
  If !ClipWait(2) {
    MsgBox("The attempt to copy text onto the clipboard failed.")
    Return
  }

  finalversion := ""
  ; get the sentences from a block
  loop parse, A_Clipboard, "`n", "`r"
  {
    ;remove nonword characters in front of the sentence
    sentence := RegExReplace(A_LoopField, "^\W+", "")
    ; make uppercase the first letter, $U1 means uppercase the captured text
    sentence := RegExReplace(sentence, "^(\w)", "$U1")
    ; add dot only if not present
    if (SubStr(sentence, -1) = ".")
      finalversion .= "`n" . sentence
    else
      finalversion .= "`n" . sentence . "."
  }

  ; remove the first newline character, the last 1 is the limit (only the first occurence is deleted)
  finalversion := StrReplace(finalversion, "`n", "", , , 1)

  A_Clipboard := finalversion
  Sleep 500
  Send "^v"
  Sleep 500
  ; restore the old clipboard
  A_Clipboard := oldClipboard
}
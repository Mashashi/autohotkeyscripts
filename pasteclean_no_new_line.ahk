^#n::                           ; Text–only paste from ClipBoard
   Clip0 = %ClipBoardAll%
   StringReplace, clipboard, clipboard, `r`n, %A_SPACE%, All
   ClipBoard = %ClipBoard%		 ; Convert to text
   Send ^v                       ; For best compatibility: SendPlay
   Sleep 50                      ; Don't change clipboard while it is pasted! (Sleep > 0)
   ClipBoard = %Clip0%           ; Restore original ClipBoard
   VarSetCapacity(Clip0, 0)      ; Free memory
Return

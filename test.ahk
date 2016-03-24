;!F12::
;MaxIdx := 10
;CurrentGroup := 5
;n := -5

;offset := MaxIdx - CurrentGroup
;MsgBox, %offset%
;n := Mod(Abs(n), MaxIdx)
;MsgBox, %n%
;n := offset+CurrentGroup-n
;MsgBox, %n%

;res := Mod(n+CurrentGroup, MaxIdx)
;MsgBox, %res%
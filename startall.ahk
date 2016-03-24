;file := "startall.ahk"
Loop, *.ahk
If (A_LoopFileName!=A_ScriptName )
	Run, %A_LoopFileFullPath%
	;MsgBox, "%A_LoopFileName%%file%"
ExitApp
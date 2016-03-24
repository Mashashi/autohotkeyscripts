;https://autohotkey.com/board/topic/54584-how-to-complie-a-list-of-all-window-names/
;https://autohotkey.com/board/topic/77403-show-text-during-program/





#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

OSDColour2 = EAAA99  ; Can be any RGB color (it will be made transparent below).
Gui, 2: +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, 2:Font, s128, Times New Roman  ; Set a large font size (32-point).
Gui, 2:Add, Text, vOSDControl cBlue x60 y200, XXXXXXYYYYYY ; XX & YY serve to auto-size the window; add some random letters to enable a longer string of text (but it might not fit on the screen).
Gui, 2:Color, %OSDColour2%
WinSet, TransColor, %OSDColour2% 110 ; Make all pixels of this color transparent and make the text itself translucent (150)
Gui, 2:Show, NoActivate, OSDGui
Gui, 2:Show, Hide

GroupName =
CurrentGroup = 
Groups := Object() ; starts at 1

OSD(Text="OSD",Colour="Blue",Duration="300",Font="Times New Roman",Size="128")
{   
	; Displays an On-Screen Display, a text in the middle of the screen.
	Gui, 2:Font, c%Colour% s%Size%, %Font%  ; If desired, use a line like this to set a new default font for the window.
	GuiControl, 2:Font, OSDControl  ; Put the above font into effect for a control.
	GuiControl, 2:, OSDControl, %Text%
	Gui, 2:Show, NoActivate, OSDGui ; NoActivate avoids deactivating the currently active window; add "X600 Y800" to put the text at some specific place on the screen instead of centred.
	SetTimer, OSDTimer, %Duration%
	Return 
}
Mini(){
	WinGet, list, List,,, Program Manager
	Loop, %list% {
		; exclude task bar this could 
		; possibly be included in WinGet
		if list%A_Index% != Shell_TrayWnd 
			WinGet, minmax, MinMax, % "ahk_id " list%A_Index%
			; if it is not minimized minimize it
			if minmax != -1
				WinMinimize % "ahk_id " list%A_Index%
	}
}
wrap(val,n,lim){
	ret := val
	if (val == 0){
		ret := n < 0 ? lim : 1
	}
	return ret
}
Move(n, Groups, CurrentGroup)
{

	;sig := n<0 ? "neg" : "pos"
	;convert subtraction into sum
	;if (n<0){
	;	offset := MaxIdx - CurrentGroup
	;	n := Mod(Abs(n), MaxIdx)
	;	n := offset+CurrentGroup-n
	;}
	;MsgBox, % MaxIdx
	;MsgBox, %CurrentGroup%
	;MsgBox, %n%
	;MsgBox, %CurrentGroup%
	;CurrentGroup := Mod(CurrentGroup,MaxIdx+(sig=="pos"?1:0))
	;MsgBox, %CurrentGroup%
	;MsgBox, %CurrentGroup%
	;MsgBox, %target%

    MaxIdx := Groups.MaxIndex()
	if (MaxIdx) {
			
		OldCurrentGroup = %CurrentGroup%

		CurrentGroup := CurrentGroup+n
		CurrentGroup := Mod(CurrentGroup,MaxIdx+1)
		CurrentGroup := wrap(CurrentGroup,n,MaxIdx)
		
		target := Groups[CurrentGroup]
		
		if (OldCurrentGroup != CurrentGroup){
			Mini()
			WinRestore ahk_group %target%
		}
		
	}

	return CurrentGroup
}





!F9::

	CurrentGroup := Move(-1, Groups, CurrentGroup)
	Return 





!F10::

	CurrentGroup := Move(1, Groups, CurrentGroup)
	Return





!F11::

	;label = Group%CurrentGroup%
	label = %CurrentGroup%
	OSD(label, "Black", "300", "Courier New", "20")
	Return





!F12::

	Groups := Object()
	CurrentGroup = 
	Return





!F5::

	;WinGet, title, ProcessName, % "ahk_id " list%A_Index%
	;MsgBox, %title%
	;MsgBox, % "ahk_id " list%A_Index%
	;GroupAdd test, AllWindows
	;MsgBox, yup
	;WinGet, toremove, ID, ahk_group test
	;Loop, %toremove% {
	;	GroupClose, test, % "ahk_id " toremove%A_Index%
	;	MsgBox, rem toremove%A_Index%
	;}

	TypeLib := ComObjCreate("Scriptlet.TypeLib")
	GroupName := TypeLib.Guid
	StringReplace, GroupName, GroupName, -, , All
	StringReplace, GroupName, GroupName, }, , All
	StringReplace, GroupName, GroupName, {, , All

	CurrentGroup := Groups.MaxIndex()
	if !CurrentGroup{
		CurrentGroup := 1
	}else{
		CurrentGroup := CurrentGroup+1
	}
	;MsgBox, % CurrentGroup

	Groups.insert(GroupName)


	WinGet, list, List,,, Program Manager
	Loop, %list% {
		if list%A_Index% != Shell_TrayWnd
			WinGet, minmax, MinMax, % "ahk_id " list%A_Index%
			if minmax != -1
				GroupAdd, %GroupName%, % "ahk_id " list%A_Index%
	}
	Return





!F6::

	;GroupActivate, test
	;WinHide % "ahk_id " . WinExist("ahk_group test")
	;WinHide ahk_group test
	;WinGetTitle, list, ahk_group test
	;WinGet, list, List, ahk_group test
	;Loop, %list% {
	;	MsgBox, % "ahk_id " list%A_Index%
	;}
	;WinHide ahk_group test
	;WinShow ahk_class Shell_TrayWnd
	;MsgBox, done

	WinMinimize ahk_group %GroupName%
	Return





!F7::

	Mini()
	WinRestore ahk_group %GroupName%
	Return





OSDTimer:

	Gui, 2:Show, Hide
	Return
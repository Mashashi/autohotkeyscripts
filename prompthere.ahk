^!d::
SetTitleMatchMode, 2
ifwinactive, ahk_class CabinetWClass
  ControlGetText, address , edit1, ahk_class CabinetWClass
else
  address =

; Exclude specific windows

ifwinactive, My Computer
  address =
ifwinactive, My Documents
  address =

if (address <> "") 
  Run, cmd.exe, %address%
else 
  Run, cmd.exe, C:\
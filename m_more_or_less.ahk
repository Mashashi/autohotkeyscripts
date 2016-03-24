^>!m::
if GetkeyState("l", "P") ; key, mode
	Send +{Left 1} ; delete typed l
	Send, ±
;GetKeyState, state, l, P
;if state = D
Return
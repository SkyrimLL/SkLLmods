Scriptname SL_Dibella_AnwenLetter extends ObjectReference  

Quest property DibellaCleansingQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	if (DibellaCleansingQuest.IsStageDone(61)) && !(DibellaCleansingQuest.IsStageDone(62))
		DibellaCleansingQuest.SetStage(62)
	endif
	; Debug.Messagebox("I found a letter")

EndEvent
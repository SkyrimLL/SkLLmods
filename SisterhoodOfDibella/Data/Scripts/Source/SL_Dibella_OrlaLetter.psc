Scriptname SL_Dibella_OrlaLetter extends ObjectReference  


Quest property DibellaCleansingQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	if (DibellaCleansingQuest.IsStageDone(50)) && !(DibellaCleansingQuest.IsStageDone(55))
		DibellaCleansingQuest.SetStage(55)
	endif

	; Debug.Messagebox("I found a letter")

EndEvent
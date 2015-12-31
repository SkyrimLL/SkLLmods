Scriptname SL_Dibella_OrlaLetter extends ObjectReference  


Quest property DibellaCleansingQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	DibellaCleansingQuest.SetStage(55)
	; Debug.Messagebox("I found a letter")

EndEvent
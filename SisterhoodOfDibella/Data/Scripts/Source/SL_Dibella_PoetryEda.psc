Scriptname SL_Dibella_PoetryEda extends ObjectReference  

Quest property DibellaCleansingQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	DibellaCleansingQuest.SetStage(75)
	; Debug.Messagebox("I found a letter")

EndEvent
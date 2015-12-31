Scriptname SL_Dibella_MenaJournal extends ObjectReference  


Quest property DibellaCleansingQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	DibellaCleansingQuest.SetStage(49)
	; Debug.Messagebox("I found a letter")

EndEvent
Scriptname SL_Dibella_MenaJournal extends ObjectReference  


Quest property DibellaCleansingQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	if (DibellaCleansingQuest.IsStageDone(40)) && !(DibellaCleansingQuest.IsStageDone(49))
		DibellaCleansingQuest.SetStage(49)
	endif

	; Debug.Messagebox("I found a letter")

EndEvent
Scriptname SL_Dibella_RorlundJournal extends ObjectReference  

Quest property DibellaCorruptionQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	if (DibellaCorruptionQuest.IsStageDone(31)) && !(DibellaCorruptionQuest.IsStageDone(38))
		DibellaCorruptionQuest.SetStage(38)
	endif

	; Debug.Messagebox("I found a letter")

EndEvent
Scriptname SL_Dibella_DeadSisterLetter extends ObjectReference  

Quest property DibellaJoinQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	if (DibellaJoinQuest.IsStageDone(20)) && !(DibellaJoinQuest.IsStageDone(21))
		DibellaJoinQuest.SetStage(21)
	endif

	; Debug.Messagebox("I found a letter")

EndEvent

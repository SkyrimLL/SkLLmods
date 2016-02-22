Scriptname SL_Dibella_DeadSisterNote extends ObjectReference  


Quest property DibellaJoinQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	if (DibellaJoinQuest.IsStageDone(20)) && !(DibellaJoinQuest.IsStageDone(22))
		DibellaJoinQuest.SetStage(22)
	endif
	; Debug.Messagebox("I found a note")

EndEvent

Scriptname SL_Dibella_DeadSisterNote extends ObjectReference  


Quest property DibellaJoinQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	DibellaJoinQuest.SetStage(22)
	; Debug.Messagebox("I found a note")

EndEvent

Scriptname SL_Dibella_PoetryEda extends ObjectReference  

Quest property DibellaCleansingQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	if (DibellaCleansingQuest.IsStageDone(70)) && !(DibellaCleansingQuest.IsStageDone(75))
		DibellaCleansingQuest.SetStage(75)
	Endif

	; Debug.Messagebox("I found a letter")

EndEvent
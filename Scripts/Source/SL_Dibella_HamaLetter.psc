Scriptname SL_Dibella_HamaLetter extends ObjectReference  

Quest property DibellaInitiationQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	DibellaCorruptionQuest.SetStage(50)
	DibellaInitiationQuest.SetStage(25)

EndEvent

Quest Property DibellaCorruptionQuest  Auto  

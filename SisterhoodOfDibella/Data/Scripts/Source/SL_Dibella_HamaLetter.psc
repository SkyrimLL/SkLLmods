Scriptname SL_Dibella_HamaLetter extends ObjectReference  

Quest property DibellaInitiationQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	if (DibellaInitiationQuest.IsStageDone(24)) && !(DibellaInitiationQuest.IsStageDone(25))
		; Why was Corruption quest set to 50 in this letter?
		; DibellaCorruptionQuest.SetStage(50)
		DibellaInitiationQuest.SetStage(25)
		(SennaRef as Actor).SendModEvent("SLSDEquipOutfit","SisterCorrupted")
	endif


EndEvent

Quest Property DibellaCorruptionQuest  Auto  

ObjectReference Property SennaRef  Auto  

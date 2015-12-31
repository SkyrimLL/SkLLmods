Scriptname SL_Dibella_HamaLetter extends ObjectReference  

Quest property DibellaInitiationQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	DibellaCorruptionQuest.SetStage(50)
	DibellaInitiationQuest.SetStage(25)
	(SennaRef as Actor).SendModEvent("SLSDEquipOutfit","SisterCorrupted")

EndEvent

Quest Property DibellaCorruptionQuest  Auto  

ObjectReference Property SennaRef  Auto  

Scriptname Alicia_TRG_NPCVictimEscapeAlarm extends ObjectReference  

Faction Property CrimeFactionWindhelm Auto
ObjectReference Property NPCVictim Auto

GlobalVariable Property AliciaInit  Auto  
ReferenceAlias Property Alias_Alicia  Auto  
DialogueFollowerScript Property DialogueFollower Auto

Quest Property Alicia_BackStory_Quest Auto


Event  OnTriggerEnter(ObjectReference akActionRef)
	ObjectReference AliciaREF = Alias_Alicia.GetReference()
	Actor AliciaActor= AliciaREF as Actor

	if  (akActionRef == NPCVictim )
	    ; Debug.Notification("Alicia rises")
		Debug.MessageBox("Alicia's prey has excaped!")
		CrimeFactionWindhelm.SetCrimeGoldViolent(Utility.RandomInt(1000,2000))
		(akActionRef as Actor).SendAssaultAlarm()
		; akActor.RemoveFromFaction(WindhelmGuards)
    ElseIf ( (akActionRef == Game.GetPlayer())  && (AliciaInit.Getvalue() == 0)) ; First time player walks in
 	   (DialogueFollower as DialogueFollowerScript).SetFollower(AliciaREF)
 	   if ((Alicia_BackStory_Quest.IsStageDone(1)) || (Alicia_BackStory_Quest.IsStageDone(2)) || (Alicia_BackStory_Quest.IsStageDone(3)) || (Alicia_BackStory_Quest.IsStageDone(4)))
 	   		Debug.MessageBox("Muffled moans of pain or pleasure seem to be coming from under the house...")
 	   	EndIf
 	   	
 	   StorageUtil.SetIntValue(AliciaActor, "_SD_iRelationshipType" , 5 )
	EndIf

EndEvent
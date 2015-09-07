Scriptname Alicia_SC_Welcome extends ObjectReference  

Quest Property AliciaQuest Auto
Scene property AliciaWelcome auto
GlobalVariable Property NPCVictimDays  Auto  
GlobalVariable Property NPCVictimActive  Auto  
Actor Property AliciaNPCVictim  Auto  
GlobalVariable Property GameDaysPassed  Auto  
ReferenceAlias Property Alias_Alicia  Auto  

GlobalVariable Property AliciaInit  Auto  


Event OnTriggerEnter(ObjectReference akActionRef)
	; Debug.Notification("Alicia: Someone enters basement")
	Actor AliciaActor= Alias_Alicia.GetReference() as Actor
	Float GameDaysPassedValue = GameDaysPassed.Getvalue() as Float
	Float  NPCVictimDaysValue = NPCVictimDays.Getvalue() as Float
	Int daysSinceLastVictim

     if ( (akActionRef == Game.GetPlayer())  && (AliciaInit.Getvalue() == 0)) ; First time player walks in
        ; Debug.Notification("Alicia: Start quest ")
        ; AliciaQuest.Start()
		Utility.Wait(1)

		If (AliciaQuest.GetStage()!= 5)
			; Debug.Notification("Alicia: Set running stage")
          	AliciaQuest.SetStage(5)
			Utility.Wait(1)
 		EndIf

		If (!AliciaQuest.IsObjectiveDisplayed(5))
		   AliciaQuest.SetObjectiveDisplayed(5)
		EndIf
		Utility.Wait(1)

		; Debug.Notification("Alicia: Start welcome scene")
		AliciaWelcome.forcestart()
		Utility.Wait(1)

		AliciaInit.Setvalue(1)
     endif

EndEvent



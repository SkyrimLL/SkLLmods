Scriptname Alicia_SC_RemoveClothing extends ObjectReference  

ReferenceAlias Property Alias_Alicia  Auto  
GlobalVariable Property NPCVictimDays  Auto  
GlobalVariable Property NPCVictimActive  Auto  
Actor Property AliciaNPCVictim  Auto  

Armor  Property AliciaClothingToken  Auto  

function OnTriggerEnter(ObjectReference akActionRef)
	Actor AliciaActor= Alias_Alicia.GetReference() as Actor
	Float  NPCVictimDaysValue = NPCVictimDays.Getvalue() as Float
	Int daysSinceLastVictim
	
	if akActionRef == (Alias_Alicia.GetReference()) 
		; Debug.Notification("Alicia undresses and displays her cuts proudly")
		AliciaActor.unequipall()
	ElseIf (akActionRef == Game.GetPlayer()) ; If player wakes up to Alicia's present
	 	; compare to previous day count - if difference >0 reduce number of cut counts
		If (NPCVictimDaysValue == 0) 
			NPCVictimDaysValue = Game.QueryStat("Days Passed")  
		EndIf

		daysSinceLastVictim= (Game.QueryStat("Days Passed") - NPCVictimDaysValue ) as Int
		; Debug.Notification("Days since last visit:" + daysSinceLastVictim)

		if  ((NPCVictimActive.GetValue()==1) && (AliciaNPCVictim.IsDisabled()) )  
			AliciaNPCVictim.Enable()

			if (AliciaNPCVictim.IsDead())
				AliciaNPCVictim.Resurrect()
			EndIf

			(AliciaNPCVictim as ObjectReference).additem(AliciaClothingToken)
			utility.wait(0.5)
			(AliciaNPCVictim as ObjectReference).removeitem(AliciaClothingToken)

			; AliciaNPCVictim.SetRestrained(true)
			AliciaNPCVictim.EvaluatePackage()
			AliciaNPCVictim.SetAlert(true)
			AliciaNPCVictim.SetIntimidated(true)
			AliciaNPCVictim.SetAV("Health", Utility.RandomInt(100,200))
 
		ElseIf  (((NPCVictimActive.GetValue()==1) && (!AliciaNPCVictim.IsDisabled()) ))
			; Do nothing... victim is in world

		ElseIf ((daysSinceLastVictim > 5) && (AliciaNPCVictim.IsDead()))
			Debug.Notification("Days since last visit:" + daysSinceLastVictim)
			; Disable victim after a while
			AliciaNPCVictim.Disable()
			NPCVictimActive.SetValue(0)

			NPCVictimDays.Setvalue( Game.QueryStat("Days Passed")  )
		EndIf


     endif

endFunction
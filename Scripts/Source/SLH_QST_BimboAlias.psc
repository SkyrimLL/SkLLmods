Scriptname SLH_QST_BimboAlias extends ReferenceAlias  

ReferenceAlias Property BimboAliasRef  Auto  

int daysSinceEnslavement

;how much gold hypnosis victim earns each day
Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	Actor akActor= BimboAliasRef.GetReference() as Actor

	; debug.Notification("[SLH] Bimbo changing location")
endEvent

Event OnUpdateGameTime()
	Actor akActor= BimboAliasRef.GetReference() as Actor

	; debug.Notification("[SLH] Bimbo update game time")

EndEvent


Event OnInit()
	Actor akActor= BimboAliasRef.GetReference() as Actor

	; debug.Notification("[SLH] Bimbo init")

EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	Actor akActor= BimboAliasRef.GetReference() as Actor

	; debug.Notification("[SLH] Bimbo in combat")

	If (akTarget == Game.GetPlayer())

	    if (aeCombatState == 0)
	      	; Debug.Trace("We have left combat with the player!")

	    elseif (aeCombatState == 1)
	      	; Debug.Trace("We have entered combat with the player!")

	    elseif (aeCombatState == 2)
	      	; Debug.Trace("We are searching for the player...")

	    endIf
	Else
	    if (aeCombatState == 0)
	      	; Debug.Trace("We have left combat with the NPC!")
			;
			If (akActor.IsUnconscious())
			;	akActor.SetUnconscious(false)
			EndIf	
	    elseif (aeCombatState == 1)
	      	; Debug.Trace("We have entered combat with the NPC!")

			; akActor.SetActorValue("Aggression", 1.0)
			; akActor.SetActorValue("Confidence", 3.0)
			; akActor.SetActorValue("Assistance", 2.0)

			; If (akActor.GetActorValue("Confidence") <= 1) ; NPC still a coward
			; 	CourageSpell.Cast(Game.GetPlayer(),akActorREF)
			; EndIf

			; Debug.Notification("Actor: " + akActor)
			; Debug.Notification("Aggression: " + akActor.GetActorValue("Aggression"))
			; Debug.Notification("Confidence: " + akActor.GetActorValue("Confidence"))
			; Debug.Notification("Assistance: " + akActor.GetActorValue("Assistance"))

	    EndIf
	EndIf


EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	Actor akActor= BimboAliasRef.GetReference() as Actor

	If (akAggressor == Game.GetPlayer())
		;
		If (akActor.IsUnconscious())
		;	akActor.SetUnconscious(false)
		EndIf	

	ElseIf (akAggressor != None)
		;  Debug.Trace("We were hit by " + akAggressor)
		; debug.Notification("[SLH] Bimbo is hit")
		Int randomNum = Utility.RandomInt(0,100)

		daysSinceEnslavement = (Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(akActor, "_SLH_bimboTransformDate") ) as Int
	    StorageUtil.SetIntValue(akActor, "_SLH_bimboTransformGameDays", daysSinceEnslavement)	

	      	If ((randomNum>80) && (akActor.GetActorValuePercentage("health")<0.2)) ; && (!(akAggressor as Actor).IsInFaction(pCreatureFaction)))
 				;
  			EndIf

	EndIf

EndEvent


Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Actor akActor= BimboAliasRef.GetReference() as Actor

	; debug.Notification("[SLH] Bimbo received something")

      ; If ( (akBaseItem as Armor) == HypnosisCircletArmor  )
      ;  akActor.Equipitem(HypnosisCirclet)
      ; EndIf
EndEvent


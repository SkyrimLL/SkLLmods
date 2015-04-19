Scriptname SL_Hypnosis_VictimAlias extends ReferenceAlias  

DialogueFollowerScript Property DialogueFollower Auto
ReferenceAlias Property Alias_HypnosisVictimREF  Auto  
Armor Property HypnosisCircletArmor  Auto  

Faction Property pCreatureFaction Auto

LocationAlias Property CurrentMarriageHouse Auto
Spell Property MarriageSleepAbility Auto
Spell Property HeatSleepAbility Auto
Faction Property JobMerchantFaction Auto
MiscObject Property Gold001 Auto
GlobalVariable Property MarriageGoldEarned Auto

Spell Property CourageSpell Auto
Spell Property HealingSpell Auto
SPELL Property CircletRemovalSpell  Auto  
SPELL Property CircletFreezeSpell  Auto  


;how much gold hypnosis victim earns each day
Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	Actor akActor= Alias_HypnosisVictimREF.GetReference() as Actor
	Int daysSinceEnslavement

	daysSinceEnslavement = (Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(akActor, "_SLMC_victimDateEnslaved") ) as Int
	StorageUtil.SetIntValue(akActor, "_SLMC_victimGameDaysEnslaved", daysSinceEnslavement)
endEvent


Event OnSleepStop(bool abInterrupted)
	Actor akActor= Alias_HypnosisVictimREF.GetReference() as Actor
	Int daysSinceEnslavement

	if (akActor != None)
		if (abInterrupted == False) && (CurrentMarriageHouse.GetLocation() == Game.GetPlayer().GetCurrentLocation())
			; 	    Debug.Trace(self + "Player has slept in the same location as the spouse. Apply Bonus.")
			MarriageSleepAbility.Cast(Game.GetPlayer(), Game.GetPlayer())
		Elseif (abInterrupted == False) 
			; Sleeping somewhere else - what kind of bonus?
			; Get different spell - spell cannot be cast.
			HeatSleepAbility.Cast(Game.GetPlayer(), Game.GetPlayer())
		Else
			; 		Debug.Trace(self + "Player is married, but hasn't slept in the same location as the spouse, or was woken up by something.")
		EndIf

		daysSinceEnslavement = (Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(akActor, "_SLMC_victimDateEnslaved") ) as Int
		StorageUtil.SetIntValue(akActor, "_SLMC_victimGameDaysEnslaved", daysSinceEnslavement)
	EndIf
endEvent


Event OnUpdateGameTime()
	Actor akActor= Alias_HypnosisVictimREF.GetReference() as Actor
	Int GoldEarnedAmount = Utility.RandomInt(10,50)

	if (akActor != None)
	; 	debug.trace(self + "OnUpdate event to calculate spouse store gold")
		If Self.GetActorRef().IsInFaction(JobMerchantFaction)
	; 		debug.trace(self + "Adding gold to spouse for store")
			MarriageGoldEarned.SetValue(MarriageGoldEarned.Value + GoldEarnedAmount * 2)
	      Else
			MarriageGoldEarned.SetValue(MarriageGoldEarned.Value + GoldEarnedAmount)
		EndIf

		If (!akActor.IsEquipped(HypnosisCircletArmor))
			akActor.Equipitem(HypnosisCircletArmor)
		EndIf
	EndIf
EndEvent

Function GiveGold()

; 	debug.trace(self + "spouse gives gold")
	Game.GetPlayer().AddItem(Gold001, MarriageGoldEarned.GetValueInt())
	MarriageGoldEarned.SetValue(0)

EndFunction

Event OnInit()
	Actor akActor= Alias_HypnosisVictimREF.GetReference() as Actor

	; Register for when the player goes to sleep and wakes up
	RegisterForSleep()

	; Is puppet master available?
	; if (Keyword.GetKeyword("_puppetGuest"))
	; EndIf
EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	ObjectReference akActorREF= Alias_HypnosisVictimREF.GetReference()
	Actor akActor= Alias_HypnosisVictimREF.GetReference() as Actor
	Int daysSinceEnslavement

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
				akActor.SetUnconscious(false)
			EndIf	
	    elseif (aeCombatState == 1)
	      	; Debug.Trace("We have entered combat with the NPC!")

			akActor.SetActorValue("Aggression", 1.0)
			akActor.SetActorValue("Confidence", 3.0)
			akActor.SetActorValue("Assistance", 2.0)

			If (akActor.GetActorValue("Confidence") <= 1) ; NPC still a coward
				CourageSpell.Cast(Game.GetPlayer(),akActorREF)
			EndIf

			; Debug.Notification("Actor: " + akActor)
			; Debug.Notification("Aggression: " + akActor.GetActorValue("Aggression"))
			; Debug.Notification("Confidence: " + akActor.GetActorValue("Confidence"))
			; Debug.Notification("Assistance: " + akActor.GetActorValue("Assistance"))

	      	daysSinceEnslavement = (Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(akActor, "_SLMC_victimDateEnslaved") ) as Int
	      	StorageUtil.SetIntValue(akActor, "_SLMC_victimGameDaysEnslaved", daysSinceEnslavement)		

			If (!akActor.IsEquipped(HypnosisCircletArmor))
				akActor.Equipitem(HypnosisCircletArmor)
			EndIf	
	    EndIf
	EndIf


EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	ObjectReference akActorREF= Alias_HypnosisVictimREF.GetReference()
	Actor akActor= Alias_HypnosisVictimREF.GetReference() as Actor
	Int daysSinceEnslavement

	If (akAggressor == Game.GetPlayer())
		;
		If (akActor.IsUnconscious())
			akActor.SetUnconscious(false)
		EndIf	
	ElseIf (akAggressor != None)
		;  Debug.Trace("We were hit by " + akAggressor)
		Int randomNum = Utility.RandomInt(0,100)

		daysSinceEnslavement = (Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(akActor, "_SLMC_victimDateEnslaved") ) as Int
	    StorageUtil.SetIntValue(akActor, "_SLMC_victimGameDaysEnslaved", daysSinceEnslavement)	

	      	If ((randomNum>80) && (akActor.GetActorValuePercentage("health")<0.2)) ; && (!(akAggressor as Actor).IsInFaction(pCreatureFaction)))
	      		; transfer circlet to player first
                ; Debug.Notification("Stop old host")
	      		; Debug.SendAnimationEvent(akActor, "UnequipNoAnim")
	      		; akActor.StopCombatAlarm()
				; akActor.StopCombat()
	      		; akActorREF.removeitem(HypnosisCircletArmor,1,true,Game.GetPlayer())

	      		; transfer circlet to new host
                ; Debug.Notification("Stop new host")
	      		; Debug.SendAnimationEvent((akAggressor as Actor), "UnequipNoAnim")
	      		; (akAggressor as Actor).StopCombatAlarm()
				; (akAggressor as Actor).StopCombat()
	      		; Game.GetPlayer().removeitem(HypnosisCirclet,1,true,akAggressor)
                ; (akAggressor as Actor).equipitem(HypnosisCirclet,False,False)

                ; Debug.Notification("The circlet changed hands!")
                Int bleedoutCount = StorageUtil.GetIntValue(akActor, "_SLMC_victimBleedCount")
  				StorageUtil.SetIntValue(akActor, "_SLMC_victimBleedCount", bleedoutCount + 1)
  			EndIf

  			If ((randomNum>95) && (daysSinceEnslavement<1)) 
             	HealingSpell.Cast(akActorREF,Game.GetPlayer())
 			ElseIf ((randomNum>90) && (daysSinceEnslavement>=1) && (daysSinceEnslavement<2))
              	HealingSpell.Cast(akActorREF,Game.GetPlayer())
			ElseIf ((randomNum>80) && (daysSinceEnslavement>=2) && (daysSinceEnslavement<5))
              	HealingSpell.Cast(akActorREF,Game.GetPlayer())
              	HealingSpell.Cast(akActorREF,akActorREF)
			ElseIf ((randomNum>80) &&  (daysSinceEnslavement>=5))
            	HealingSpell.Cast(akActorREF,Game.GetPlayer())
              	HealingSpell.Cast(akActorREF,akActorREF)

				If (Utility.RandomInt(0, 100)>90)
					CircletRemovalSpell.Cast(akActorREF,akAggressor)
				EndIf
			
	      	EndIf
	EndIf

EndEvent

Event OnEnterBleedout()
	ObjectReference akActorREF= Alias_HypnosisVictimREF.GetReference()
	Actor akActor= Alias_HypnosisVictimREF.GetReference() as Actor

  	; Debug.Trace("We entered bleedout...")
  	Int victimGameDaysEnslaved = StorageUtil.GetIntValue(akActor, "_SLMC_victimGameDaysEnslaved")
  	Int bleedoutCount = StorageUtil.GetIntValue(akActor, "_SLMC_victimBleedCount") + 1

  	StorageUtil.SetIntValue(akActor, "_SLMC_victimBleedCount", bleedoutCount )

  	If (Game.GetPlayer().GetItemCount(HypnosisCircletArmor) == 0)

	  	If ((victimGameDaysEnslaved<1) && ( bleedoutCount>10) ) || ((victimGameDaysEnslaved>=1) && (victimGameDaysEnslaved<2) && (bleedoutCount>20) ) || ((victimGameDaysEnslaved>=2) && (victimGameDaysEnslaved<5) && (bleedoutCount>50) )
	  			; akActor.Unequipitem(HypnosisCirclet,False,False)
				; Utility.Wait(1.0)
				; akActorREF.removeitem(HypnosisCirclet,1,true,Game.GetPlayer())
	  			; akActorREF.DropObject(HypnosisCircletArmor,1)
				; Utility.Wait(1.0)
	  			; Debug.Notification("The circlet changed hands! ")
	  			; Debug.Notification("The circlet needs you! ")
	  			StorageUtil.SetIntValue(akActor, "_SLMC_victimFreeze",1)

	  	ElseIf (victimGameDaysEnslaved>5)
	  		; Set NPC to essential
	  		akActor.StartDeferredKill()
	  		StorageUtil.SetIntValue(akActor, "_SLMC_victimFreeze",0)
	  	EndIf

		If 	( StorageUtil.GetIntValue(akActor, "_SLMC_victimFreeze") == 1 )
			If !(akActor.IsUnconscious())
  				akActor.SetUnconscious(true)
  			EndIf
  		EndIf
	Else
		Debug.Notification("ERROR: The circlet cannot be in two places!")
	 EndIf
endEvent

Event OnDeath(Actor akKiller)
	ObjectReference akActorREF= Alias_HypnosisVictimREF.GetReference()
	Actor akActor= Alias_HypnosisVictimREF.GetReference() as Actor

; 	debug.trace(self + "Clearing the follower because the player killed him.")
	; transfer circlet to player first
	If (Game.GetPlayer().GetItemCount(HypnosisCircletArmor) == 0)
		; akActorREF.DropObject(HypnosisCirclet,1)
		; akActor.Unequipitem(HypnosisCirclet,False,False)
		; Utility.Wait(1.0)
		; akActorREF.removeitem(HypnosisCirclet,1,true,Game.GetPlayer())
		; Utility.Wait(1.0)
	Else
		Debug.Notification("ERROR: The circlet cannot be in two places!")
	EndIf

	If (akKiller != Game.GetPlayer())
		; enable after finding reliable way to stop combat
		; transfer circlet to new host 
		; Debug.SendAnimationEvent(akKiller, "UnequipNoAnim")
		; akKiller.StopCombatAlarm()
		; akKiller.StopCombat()
		; Game.GetPlayer().removeitem(HypnosisCirclet,1,true,akKiller as ObjectReference)
		; akKiller.equipitem(HypnosisCirclet,False,False)
	EndIf

	; Debug.Notification("The circlet returned to you.")
	
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	ObjectReference akActorREF= Alias_HypnosisVictimREF.GetReference()
	Actor akActor= Alias_HypnosisVictimREF.GetReference() as Actor

      If ( (akBaseItem as Armor) == HypnosisCircletArmor  )
      ;  akActor.Equipitem(HypnosisCirclet)
      EndIf
EndEvent


Scriptname SLS_TRG_MaintenanceStationSexBot extends ObjectReference  

ObjectReference Property LexiconMarkerRef  Auto  

ObjectReference Property SexBotRefRef  Auto  

GlobalVariable Property SexBotMemory  Auto  
ObjectReference Property WorkerBotRef  Auto  
Spell Property TonalAdjustmentSpell  Auto  
Spell Property TonalRaySpell  Auto  

Quest Property SexBotQuest  Auto  

MusicType Property MUSCombatBoss  Auto 

Event OnTriggerEnter(ObjectReference akActionRef)
	Actor akActor = akActionRef as Actor
	Actor SexBotActor = SexBotRefRef as Actor

	; Debug.Notification("Someone walks in Sanctum: " + akActionRef)
	; Debug.Notification("SybilREF: " + SybilREF)
	; Debug.Notification("TRG Quest: " + InitiationQuest)

	; disable button if ELLE was not found in Shimmermist cave
	if (SexBotQuest.GetStageDone(20) == 0)
		return
	endif

	; 3d will not be loaded in some situations, such as werewolf transformations.
	; Skip body update if 3d not loaded.
	If ( !(akActionRef as Actor).Is3DLoaded() )
		return
	EndIf

	If UI.IsMenuOpen("Console") || UI.IsMenuOpen("Main Menu") || UI.IsMenuOpen("Loading Menu") || UI.IsMenuOpen("MessageBoxMenu")
		return
	EndIf

	If (akActor == SexBotRefRef)  
		; Debug.Notification("Sybil  is in the Sanctum : Initiation Level " + SybilLevel.GetValue())
		; Debug.Notification("Initiation quest stage: " + InitiationQuest.GetStage() )

		; If (InitiationQuest.GetStage() == 0)
		; 	InitiationQuest.SetStage(5)
		; 	InitiationFX.Cast(akActor ,akActor )
		; EndIf

		LexiconMarkerRef.Enable()

		If (SexBotQuest.GetStageDone(55) == 0)
			SexBotMemory.SetValue(1)
			SexBotQuest.SetStage(55)

			SexBotActor.MoveTo( LexiconMarkerRef )
			; Debug.SendAnimationEvent(SexBotRefRef, "bleedOutStart")
			Utility.Wait(1.0)

			SexBotEnergy.SetValue(0)
			SexBotActor.EvaluatePackage()
			Utility.Wait(1.0)

			; MUSCombatBoss.Add()
			TonalRaySpell.cast(WorkerBotRef, SexBotRefRef)

			Debug.MessageBox("E.L.L.E suddenly stops as the console comes to life.\n'ANALYSIS: Memory core detected. Excess energy depleted. Please press the control to continue.'")
		Endif
	EndIf
EndEvent

Event OnTriggerLeave(ObjectReference akActionRef)
	Actor akActor = akActionRef as Actor

	; Debug.Notification("Someone walks in Sanctum: " + akActionRef)
	; Debug.Notification("SybilREF: " + SybilREF)
	; Debug.Notification("TRG Quest: " + InitiationQuest)

	; 3d will not be loaded in some situations, such as werewolf transformations.
	; Skip body update if 3d not loaded.
	If ( !(akActionRef as Actor).Is3DLoaded() )
		return
	EndIf

	If UI.IsMenuOpen("Console") || UI.IsMenuOpen("Main Menu") || UI.IsMenuOpen("Loading Menu") || UI.IsMenuOpen("MessageBoxMenu")
		return
	EndIf

	If (akActor == SexBotRefRef) 
		; Debug.Notification("Sybil  is in the Sanctum : Initiation Level " + SybilLevel.GetValue())
		; Debug.Notification("Initiation quest stage: " + InitiationQuest.GetStage() )

		; If (InitiationQuest.GetStage() == 0)
		; 	InitiationQuest.SetStage(5)
		; 	InitiationFX.Cast(akActor ,akActor )
		; EndIf

		LexiconMarkerRef.Disable()

	EndIf
EndEvent
GlobalVariable Property SexBotEnergy  Auto  

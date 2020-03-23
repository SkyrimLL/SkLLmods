Scriptname SLS_TRG_MuseumSexBot extends ObjectReference  

ObjectReference Property LexiconMarkerRef  Auto  

ObjectReference Property SexBotRefRef  Auto  

Quest Property SexBotQuest  Auto  

MusicType Property MUSCombatBoss  Auto 

Event OnTriggerEnter(ObjectReference akActionRef)
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

		LexiconMarkerRef.Enable()
		; MUSCombatBoss.Add()

		If (SexBotQuest.GetStageDone(49) == 0)
			SexBotQuest.SetStage(49)

			Debug.MessageBox("The pedestal comes to life as E.L.L.E approaches. An disembodied voice speaks in an ancient tongue. E.L.L.E replies 'ANALYSIS: Memory core unavailable for repair' \n A small plaque is attached to the pedestal with one word 'AVANCHNZEL'.")
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

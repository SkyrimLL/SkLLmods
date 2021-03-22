Scriptname SLSDDi_TRG_ShiveringGroveDoor extends ObjectReference  

Quest Property DivineCheeseQuest  Auto

MusicType Property MUSTrigger  Auto 

ObjectReference Property ShiveringGroveDoorMarker Auto

Potion Property DivineMilk Auto


Event OnTriggerEnter(ObjectReference akActionRef)
	Actor akActor = akActionRef as Actor
	Actor kPlayer = Game.GetPlayer()


	; 3d will not be loaded in some situations, such as werewolf transformations.
	; Skip body update if 3d not loaded.
	If ( !(akActionRef as Actor).Is3DLoaded() )
		return
	EndIf

	If UI.IsMenuOpen("Console") || UI.IsMenuOpen("Main Menu") || UI.IsMenuOpen("Loading Menu") || UI.IsMenuOpen("MessageBoxMenu")
		return
	EndIf

	If (akActor == kPlayer)  
		if (kPlayer.GetItemCount(DivineMilk)>=1) && (DivineCheeseQuest.GetStageDone(500)==1)

			ShiveringGroveDoorMarker.Enable()
			; MUSCombatBoss.Add()

			If (DivineCheeseQuest.GetStageDone(510) == 0)
				DivineCheeseQuest.SetStage(510)

			Endif
		endif
	EndIf
EndEvent

Event OnTriggerLeave(ObjectReference akActionRef)
	Actor akActor = akActionRef as Actor
	Actor kPlayer = Game.GetPlayer()


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

	If (akActor == kPlayer)  
		if (kPlayer.GetItemCount(DivineMilk)>=1)

			ShiveringGroveDoorMarker.Disable()
			; MUSCombatBoss.Add()

		endif
	EndIf
EndEvent

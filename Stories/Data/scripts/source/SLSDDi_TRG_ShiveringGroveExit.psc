Scriptname SLSDDi_TRG_ShiveringGroveExit extends ObjectReference  

Quest Property DivineCheeseQuest  Auto

MusicType Property MUSTrigger  Auto 

ObjectReference Property ShiveringGroveExitMarker Auto

Potion Property DivineMilk Auto
Potion Property DivineCheese Auto
Potion Property DivineCheeseWheel Auto


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
		if ( (kPlayer.GetItemCount(DivineCheese)>=1) || (kPlayer.GetItemCount(DivineCheeseWheel)>=1) ) && (DivineCheeseQuest.GetStageDone(510)==1)

			; Enable exit and remove planks
			ShiveringGroveExitMarker.Enable()
			; MUSCombatBoss.Add()

			If (DivineCheeseQuest.GetStageDone(530) == 0)
				DivineCheeseQuest.SetStage(530)

			Endif

		elseif ( (kPlayer.GetItemCount(DivineCheese)<1) && (kPlayer.GetItemCount(DivineCheeseWheel)<1) ) || (DivineCheeseQuest.GetStageDone(530)==1)

			; Disable exit and add planks
			ShiveringGroveExitMarker.Disable()
			; MUSCombatBoss.Add()

			If (DivineCheeseQuest.GetStageDone(520) == 0)
				DivineCheeseQuest.SetStage(520)

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
		if ( (kPlayer.GetItemCount(DivineCheese)<1) && (kPlayer.GetItemCount(DivineCheeseWheel)<1) )

			ShiveringGroveExitMarker.Disable()
			; MUSCombatBoss.Add()

		endif
	EndIf
EndEvent

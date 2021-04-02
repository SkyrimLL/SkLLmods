Scriptname SLSDDi_TRG_ShiveringGroveExit extends ObjectReference  

Quest Property DivineCheeseQuest  Auto
SLSDDi_QST_CowLife Property CowLife Auto

MusicType Property MUSTrigger  Auto 

ObjectReference Property ShiveringGroveExitMarker Auto

Potion Property DivineMilk Auto
Potion Property DivineCheese Auto
Potion Property DivineCheeseWheel Auto

ObjectReference Property SheoCow  Auto  

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
		if ( (kPlayer.GetItemCount(DivineCheese)>=1) || (kPlayer.GetItemCount(DivineCheeseWheel)>=1) )  

			if (ShiveringGroveExitMarker.IsDisabled()) 
				Debug.notification("The door responds to the cheese and opens up.")
			endif
			; Enable exit and remove planks
			ShiveringGroveExitMarker.Enable()
			; MUSCombatBoss.Add()

			
			If (DivineCheeseQuest.GetStageDone(540) == 0)
				DivineCheeseQuest.SetStage(540)

			Endif

		elseif ( (kPlayer.GetItemCount(DivineCheese)<1) && (kPlayer.GetItemCount(DivineCheeseWheel)<1) ) 


			If (DivineCheeseQuest.GetStageDone(515) == 0)
				Debug.notification("The door shuts behind you.")
				DivineCheeseQuest.SetStage(515)
				Actor kSheoCow = SheoCow as Actor
				CowLife.registerCow(kSheoCow)

			elseIf (DivineCheeseQuest.GetStageDone(528) == 1)
				if (ShiveringGroveExitMarker.IsEnabled()) 
					Debug.notification("Without Divine Cheese, the door remains shut.")
				Endif

			Endif
			
			; Disable exit and add planks
			ShiveringGroveExitMarker.Disable()
			; MUSCombatBoss.Add()
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


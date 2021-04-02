Scriptname SLSDDi_TRG_ElementalDoorTrigger extends ObjectReference  

ObjectReference Property ElementalDoorRef  Auto  

Quest Property DivineCheeseQuest  Auto



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
		if (DivineCheeseQuest.GetStageDone(528)==1)

			ElementalDoorRef.PlayAnimation("Open")
 
		endif
	EndIf
EndEvent

Event OnTriggerLeave(ObjectReference akActionRef)

EndEvent

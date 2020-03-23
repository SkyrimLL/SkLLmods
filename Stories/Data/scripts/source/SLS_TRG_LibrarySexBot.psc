Scriptname SLS_TRG_LibrarySexBot extends ObjectReference  

ObjectReference Property MuseumEntranceMarker  Auto  

ObjectReference Property SexBotRefRef  Auto  

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

		MuseumEntranceMarker.Disable()

	EndIf
EndEvent
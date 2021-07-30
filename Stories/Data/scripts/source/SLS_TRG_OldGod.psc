Scriptname SLS_TRG_OldGod extends ObjectReference  

ObjectReference Property _SLS_OldGodMarkerRef  Auto  

Weather Property BadWeather Auto
Sound Property ThunderFX Auto

Event OnTriggerEnter(ObjectReference akActionRef)
	Actor akActor = akActionRef as Actor
	Actor kPlayer = Game.getPlayer()

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

		Sound.SetInstanceVolume(ThunderFX.Play(kPlayer), 1.0)
		_SLS_OldGodMarkerRef.enable()
		BadWeather.SetActive(true)

	EndIf
EndEvent
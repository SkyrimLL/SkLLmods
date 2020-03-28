Scriptname SL_Dibella_TRG_LightControl extends ObjectReference  

Message Property LightConfigMenu  Auto  

ObjectReference Property _SLSD_NaturalLightsMarker Auto
ObjectReference Property _SLSD_DaedricLightsMarker Auto

GlobalVariable Property _SLSD_TempleNaturalLightsON Auto
GlobalVariable Property _SLSD_TempleDaedricLightsON Auto

Event OnActivate(ObjectReference akActionRef)
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	Int IButton = LightConfigMenu.Show()

	If (IButton == 0 ) 
		If (_SLSD_TempleNaturalLightsON.GetValue()==0)
			Debug.Notification("[SL Dibella] Natural lights enabled")
			_SLSD_NaturalLightsMarker.enable()
			_SLSD_TempleNaturalLightsON.SetValue(1)

		Else
			Debug.Notification("[SL Dibella] Natural lights disabled")
			_SLSD_NaturalLightsMarker.disable()
			_SLSD_TempleNaturalLightsON.SetValue(0)
		Endif

	ElseIf (IButton == 1 ) 
		If (_SLSD_TempleDaedricLightsON.GetValue()==0)
			Debug.Notification("[SL Dibella] Daedric lights enabled")
			_SLSD_DaedricLightsMarker.enable()
			_SLSD_TempleDaedricLightsON.SetValue(1)

		Else
			Debug.Notification("[SL Dibella] Daedric lights disabled")
			_SLSD_DaedricLightsMarker.disable()
			_SLSD_TempleDaedricLightsON.SetValue(0)
		Endif

	Endif

endevent
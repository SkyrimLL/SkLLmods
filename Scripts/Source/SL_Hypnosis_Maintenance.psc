Scriptname SL_Hypnosis_Maintenance extends Quest  

Quest Property _SLMC_controlQuest Auto
SL_Hypnosis_item Property _SLMC_item Auto

Float fVersion

Event OnInit()
	Maintenance() ; OnPlayerLoadGame will not fire the first time
EndEvent
 
Function Maintenance()

	If fVersion < 0.7 ; <--- Edit this value when updating
		fVersion = 0.7 ; and this
		Debug.Notification("Updating to Mind Control version: " + fVersion)
		; Update Code
		
		; Reset quest if quest already started

		_SLMC_controlQuest.Stop()
		Utility.Wait(1.0)
		_SLMC_controlQuest.Start()
		Utility.Wait(1.0)
		; _SLMC_YisraREF.ResetInventory()
		; Utility.Wait(1.0)
	EndIf

	; Other maintenance code that only needs to run once per save load
	_SLMC_item._refreshVictimShape()
EndFunction

ObjectReference Property _SLMC_YisraREF  Auto  

;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 29
Scriptname SLSDDi_QST_PetFree01 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
;
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
	Actor PetSlaveActor= _SLSD_PetSlaveREF.GetReference() as Actor
	ObjectReference PetFreeActorREF= _SLSD_PetFreeREF.GetReference() 
	Actor PetFreeActor= _SLSD_PetFreeREF.GetReference() as Actor
	string PetRaceID = MiscUtil.GetActorRaceEditorID(PetFreeActor)
	Actor kPlayer = Game.GetPlayer()

	if sslCreatureAnimationSlots.HasRaceKey("FlameAtronach") && !sslCreatureAnimationSlots.HasRaceID("FlameAtronach", PetRaceID)
		sslCreatureAnimationSlots.AddRaceID("FlameAtronach", PetRaceID)
	EndIf

	_SLSD_PetFollow.SetValue(1)
	_SLSD_PetPosition.SetValue(0)

	Debug.Trace("[SL Stories] Removing Pet Slave")
	PetFreeActorREF.MoveTo(PetSlaveActor)
	FlameAuraFX.RemoteCast( PetSlaveActor, PetSlaveActor, Game.GetPlayer())
	PetSlaveActor.Disable()

	Debug.Trace("[SL Stories] Enabling Pet Free")
	PetFreeActor.Enable()
	IsPetHuman.SetValue(0)

	if !Sexlab.IsValidActor(PetFreeActor)
		Sexlab.TreatAsFemale(PetFreeActor)
	endif

	Utility.Wait(1.0)

	PetFreeActor.EvaluatePackage()

	if (_SLSD_PetPlugFree.GetValue() == 1)
		PetFreeActor.RemoveFromFaction( WEPlayerFriend )
		PetFreeActor.AddToFaction( WEPlayerEnemy )
		PetFreeActor.IgnoreFriendlyHits(False)
		  PetFreeActor.SetRelationshipRank(kPlayer, -4)
	else
		PetFreeActor.AddToFaction( WEPlayerFriend )
		PetFreeActor.RemoveFromFaction( WEPlayerEnemy )
		PetFreeActor.IgnoreFriendlyHits()
		   PetFreeActor.SetRelationshipRank(kPlayer, 3)

EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
Actor PetSlaveActor= _SLSD_PetSlaveREF.GetReference() as Actor
Actor PetFreeActor= _SLSD_PetFreeREF.GetReference() as Actor

Debug.SendAnimationEvent( PetSlaveActor, "bleedOutStart")

; FlameShieldFX.RemoteCast( PetSlaveActor, PetSlaveActor, PetSlaveActor)
FlameAuraFX.RemoteCast( PetSlaveActor, PetSlaveActor, Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property _SLSD_PetSlaveREF  Auto  

ReferenceAlias Property _SLSD_PetFreeREF  Auto  

SPELL Property FlameBurstFX  Auto  
SPELL Property FlameAuraFX  Auto  

GlobalVariable Property _SLSD_PetFollow  Auto  

GlobalVariable Property _SLSD_PetPosition  Auto  

Armor Property AnalPlug  Auto  

Armor Property VaginalPlug  Auto  

GlobalVariable Property _SLSD_PetPlugFree  Auto  

Faction Property WEPlayerFriend  Auto  

SPELL Property FlameShieldFX  Auto  

Faction Property WEPlayerEnemy  Auto  

GlobalVariable Property IsPetHuman  Auto  

SexLabFramework Property SexLab  Auto  


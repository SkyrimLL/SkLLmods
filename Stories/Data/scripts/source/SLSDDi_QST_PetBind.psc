;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 18
Scriptname SLSDDi_QST_PetBind Extends Scene Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
ObjectReference  PetSlaveActorREF= _SLSD_PetSlaveREF.GetReference() 
	Actor PetSlaveActor= _SLSD_PetSlaveREF.GetReference() as Actor
	Actor PetFreeActor= _SLSD_PetFreeREF.GetReference() as Actor
	Actor kPlayer = Game.GetPlayer()

	_SLSD_PetFollow.SetValue(1)
	_SLSD_PetPosition.SetValue(0)

	if (_SLSD_PetPlugFree.GetValue() == 1)
		PetFreeActor.RemoveFromFaction( WEPlayerFriend )
		PetFreeActor.AddToFaction( WEPlayerEnemy )
		PetFreeActor.IgnoreFriendlyHits(False)
		  PetFreeActor.SetRelationshipRank(kPlayer , -4)
	else
		PetFreeActor.AddToFaction( WEPlayerFriend )
		PetFreeActor.RemoveFromFaction( WEPlayerEnemy )
		PetFreeActor.IgnoreFriendlyHits()
		   PetFreeActor.SetRelationshipRank(kPlayer , 3)

	EndIf

	PetSlaveActorREF.MoveTo(PetFreeActor)
	FlameAuraFX.RemoteCast( PetFreeActor, PetFreeActor, kPlayer )
	PetFreeActor.Disable()

	PetSlaveActor.Enable()
	IsPetHuman.SetValue(1)

	Utility.Wait(1.0)

	Debug.SendAnimationEvent( PetSlaveActor, "IdleHandsBehindBack")
	PetSlaveActor.EvaluatePackage()
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

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property _SLSD_PetSlaveREF  Auto  

ReferenceAlias Property _SLSD_PetFreeREF  Auto  

GlobalVariable Property _SLSD_PetFollow  Auto  

GlobalVariable Property _SLSD_PetPosition  Auto  

GlobalVariable Property _SLSD_PetPlugFree  Auto  

Faction Property WEPlayerFriend  Auto  

Faction Property WEPlayerEnemy  Auto  

SPELL Property FlameBurstFX  Auto  
SPELL Property FlameAuraFX  Auto  


GlobalVariable Property IsPetHuman  Auto  

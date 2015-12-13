;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_PKG_TravelToggle Extends Package Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(Actor akActor)
;BEGIN CODE
ObjectReference akActorRef = akActor as ObjectReference

; Debug.Notification("[SLSD] Testing sister location")

if ( (!akActor.IsInFaction(SLSD_SisterTravelFaction )) && (  akActorRef .GetParentCell() == TempleOfDibellaCell  ) )
	; Debug.Notification("[SLSD] Travelling sister in temple.. going back home")
	akActor.AddToFaction(SLSD_SisterTravelFaction )

elseif ( (akActor.IsInFaction(SLSD_SisterTravelFaction )) && (  akActorRef .GetParentCell() == HaelgaBunkhouseCell ) )
	; Debug.Notification("[SLSD] Travelling sister in home.. back to temple")
	akActor.RemoveFromFaction(SLSD_SisterTravelFaction )

endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property SLSD_SisterTravelFaction  Auto  

Cell Property HaelgaBunkhouseCell  Auto  

Cell Property TempleOfDibellaCell  Auto  

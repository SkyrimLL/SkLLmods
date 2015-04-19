;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_BroodMaiden_04 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor PlayerRef = Game.GetPlayer()

Game.ForceThirdPerson()
; Debug.SendAnimationEvent( PlayerRef , "bleedOutStart")
ChaurusSpitFX.Cast( akSpeaker ,Game.GetPlayer() )

Utility.Wait(6.0)

Game.FadeOutGame(true, true, 0.1, 15)
PlayerRef.moveTo( _SLS_BreedinggroundMarker )
Game.FadeOutGame(false, true, 0.01, 10)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SPELL Property ChaurusSpitFX  Auto  

ObjectReference Property _SLS_BreedingGroundMarker  Auto  

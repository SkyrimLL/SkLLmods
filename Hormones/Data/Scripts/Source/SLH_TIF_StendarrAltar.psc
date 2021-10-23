;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLH_TIF_StendarrAltar Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer=game.Getplayer()

Sound.SetInstanceVolume(StendarrFX.Play(kPlayer), 1.0)

LightEffect.Cast(kPlayer  as ObjectReference, kPlayer  as ObjectReference)

kPlayer.SendModEvent("SLHForceRemoveCurse", "All")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SPELL Property LightEffect  Auto  
Sound Property StendarrFX  Auto

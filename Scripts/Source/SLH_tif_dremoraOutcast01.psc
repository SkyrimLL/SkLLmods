;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLH_tif_dremoraOutcast01 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kVictim  = Game.GetPlayer() as Actor
Int IButton = _SLH_warning.Show()

If IButton == 0 ; Show the thing.

	If  (SexLab.ValidateActor( kVictim) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		SexLab.QuickStart(kVictim, akSpeaker, Victim = kVictim, AnimationTags = "Sex")
	EndIf

EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

Message Property _SLH_warning  Auto  

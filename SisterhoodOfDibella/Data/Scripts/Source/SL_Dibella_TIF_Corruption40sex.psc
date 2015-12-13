;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Corruption40sex Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If  (SexLab.ValidateActor( Game.GetPlayer() ) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 

    SexLab.QuickStart(akSpeaker ,  Game.GetPlayer(), victim=akSpeaker, AnimationTags = "Sex")
 EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

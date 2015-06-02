;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLH_TIF_BimboRelease Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If  (SexLab.ValidateActor( SexLab.PlayerREF) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		; Debug.Notification( "[Resists weakly]" )
		Actor akActor = SexLab.PlayerRef

		isBimboBound.SetVAlue(0)


		Debug.Messagebox( "As soon as her hands are free, the vixen crawls all over you with wet lips, hot tongue and a ravenous look on her face." )

		SexLab.QuickStart(SexLab.PlayerRef,  akSpeaker, AnimationTags = "Sex")



	EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

GlobalVariable Property isBimboBound  Auto  
SPELL Property PolymorphBimbo Auto
GlobalVariable      Property GV_isBimbo                 Auto

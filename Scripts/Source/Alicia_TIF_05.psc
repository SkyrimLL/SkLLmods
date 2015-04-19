;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname Alicia_TIF_05 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; Alicia on top
int avHealthLevel = (akSpeaker.GetAVPercentage("Health") * 100) as Int
int sexTrigger = 80 - (100 - avHealthLevel)

If (Utility.RandomInt(0,100)>sexTrigger)  
	If  (SexLab.ValidateActor( SexLab.PlayerRef ) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		Debug.Notification( "Alicia crawls over you with a ravenous look..." )

		SexLab.QuickStart(SexLab.PlayerRef, akSpeaker, Victim = SexLab.PlayerRef, AnimationTags = "Aggressive")
	EndIf
Else
	Debug.Notification( "Alicia's hungry look grows stronger..." )
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

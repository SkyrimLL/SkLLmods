;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_NeedSex Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int NPCSexCount = _SLS_NPCSexCount.GetValue(  ) as Int

_SLS_NPCSexCount.SetValue(  -1 )

	If  (SexLab.ValidateActor( SexLab.PlayerREF) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		; Debug.Notification( "[Resists weakly]" )
		Actor akActor = SexLab.PlayerRef

		If (NPCSexCount <=2 )
			SexLab.QuickStart(SexLab.PlayerRef,  akSpeaker, AnimationTags = "Foreplay")
		ElseIf (NPCSexCount <= 5 )
			SexLab.QuickStart(SexLab.PlayerRef,  akSpeaker, AnimationTags = "Loving")
		ElseIf (NPCSexCount <= 10 )
			SexLab.QuickStart(SexLab.PlayerRef,  akSpeaker, AnimationTags = "Rough")
		Else
			SexLab.QuickStart(SexLab.PlayerRef,  akSpeaker, AnimationTags = "Sex")
		EndIf


	EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

GlobalVariable Property _SLS_NPCSexCount  Auto  

;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_BimboRelease Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If  (SexLab.ValidateActor( SexLab.PlayerREF) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		; Debug.Notification( "[Resists weakly]" )
		Actor akActor = SexLab.PlayerRef

		isBimboBound.SetVAlue(0)

		If (Utility.RandomInt(0,100)>50)
			SexLab.QuickStart(SexLab.PlayerRef,  akSpeaker, AnimationTags = "Sex")
		Else
			Debug.Messagebox( "As soon as her hands are free, the vixen crawls all over you with wet lips, hot tongue and a ravenous look on her face." )

			sslThreadModel Thread = SexLab.NewThread()
			Thread.AddActor(akSpeaker) ; // IsVictim = true
			Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F","Estrus,Dwemer"))
			Thread.StartThread()
		EndIf


	EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

GlobalVariable Property isBimboBound  Auto  

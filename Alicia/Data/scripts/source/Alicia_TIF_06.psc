;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname Alicia_TIF_06 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; Masturbation
int avHealthLevel = (akSpeaker.GetAVPercentage("Health") * 100) as Int
int sexTrigger = 60 - (100 - avHealthLevel)

If (Utility.RandomInt(0,100)>sexTrigger) 
	If  (SexLab.ValidateActor(akSpeaker) > 0) 
		Debug.Notification( "Alicia can't hold back any longer..." )

			sslThreadModel Thread = SexLab.NewThread()
			Thread.AddActor(akSpeaker) ; // IsVictim = true
			Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F","Estrus,Dwemer"))
			Thread.StartThread()
	EndIf
Else
	Debug.Notification( "Alicia squirms and moans..." )
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

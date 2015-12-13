;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Sybil_SexEdPure Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If  (SexLab.ValidateActor( SexLab.PlayerREF) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		; Debug.Notification( "Fjotra licks her lips..." )
		Actor akActor = SexLab.PlayerRef
		
		sslThreadModel Thread = SexLab.NewThread()
		Thread.AddActor(akSpeaker) ; // IsVictim = true
		Thread.AddActor(akActor) ; // IsVictim = true

		If (akActor.GetActorBase().getSex() == 1)
			Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "Love,Lesbian", "Aggressive"))
		Else
			Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "Love,MF", "Aggressive"))
		EndIf

		Thread.StartThread()
	EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


SexLabFramework Property SexLab  Auto  

GlobalVariable Property InitiationLevelBuffer  Auto  

GlobalVariable Property SybilLevel  Auto  

GlobalVariable Property InitiationLessonCount  Auto  

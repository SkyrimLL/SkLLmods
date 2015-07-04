;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLH_TIF_BimboSexFF Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor akActor = Game.GetPlayer()
If  (SexLab.ValidateActor( akActor) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		; Debug.Notification( "[Resists weakly]" )

		ActorBase PlayerBase = akActor.GetBaseObject() as ActorBase
		Int PlayerGender = PlayerBase.GetSex() ; 0 = Male ; 1 = Female
		
		sslThreadModel Thread = SexLab.NewThread()
		Thread.AddActor(akSpeaker, IsVictim = true) ; // IsVictim = true
		Thread.AddActor(akActor) ; // IsVictim = true


		Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "Lesbian"))


		Thread.StartThread()

	EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  
SPELL Property PolymorphBimbo Auto
GlobalVariable      Property GV_isBimbo                 Auto

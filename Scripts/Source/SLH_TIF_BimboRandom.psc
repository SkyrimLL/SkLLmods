;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLH_TIF_BimboRandom Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If  (SexLab.ValidateActor( SexLab.PlayerREF) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		; Debug.Notification( "[Resists weakly]" )
		Debug.Messagebox("Honey rubs her how skin against your back shamelessly, moaning in your ear.. her hand reaching down between your legs.")

		Actor akActor = SexLab.PlayerRef
		ActorBase PlayerBase = Game.GetPlayer().GetBaseObject() as ActorBase
		Int PlayerGender = PlayerBase.GetSex() ; 0 = Male ; 1 = Female
		
		sslThreadModel Thread = SexLab.NewThread()
		Thread.AddActor(akSpeaker, IsVictim = true) ; // IsVictim = true
		Thread.AddActor(akActor) ; // IsVictim = true


		If (PlayerGender  == 1)
			Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "Sex,Lesbian"))
		Else
			Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "Sex,MF"))
		EndIf

		Thread.StartThread()

	EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

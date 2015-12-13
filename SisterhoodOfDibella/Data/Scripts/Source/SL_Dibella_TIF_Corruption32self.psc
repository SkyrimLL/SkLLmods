;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Corruption32self Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetStage(39)

if (akSpeaker.GetRelationshipRank(Game.GetPlayer()) < 3)

	akSpeaker.SetRelationshipRank(Game.GetPlayer(), 3)
	(Game.GetPlayer() as Actor).SetRelationshipRank(akSpeaker, 3)
	
	String actorName = (akSpeaker as ObjectReference).GetBaseObject().GetName()
	Debug.Notification(actorName  + " is now your Confidant")
endif

If  (SexLab.ValidateActor( Game.GetPlayer() ) > 0) 
		Actor akActor = Game.GetPlayer() as Actor
		sslThreadModel Thread = SexLab.NewThread()
		Thread.AddActor(akActor) ; // IsVictim = true

		If (akActor.GetActorBase().getSex() == 1)
			Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F","Estrus,Dwemer"))
		Else
			Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,M","Estrus,Dwemer"))
		EndIf

		Thread.StartThread()

Endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

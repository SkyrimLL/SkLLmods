;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Corruption32bj Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetStage(39)

if (akSpeaker.GetRelationshipRank(Game.GetPlayer()) < 4)
	akSpeaker.SetRelationshipRank(Game.GetPlayer(), 4)
	(Game.GetPlayer() as Actor).SetRelationshipRank(akSpeaker, 4)
	
	String actorName = (akSpeaker as ObjectReference).GetBaseObject().GetName()
	Debug.Notification(actorName  + " is now your Lover")
endif

	If  (SexLab.ValidateActor( Game.GetPlayer() ) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 

		SexLab.QuickStart( Game.GetPlayer(), akSpeaker, AnimationTags = "Oral")
	EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

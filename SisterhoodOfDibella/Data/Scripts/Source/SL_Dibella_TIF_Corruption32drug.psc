;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Corruption32drug Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetStage(39)

if (akSpeaker.GetRelationshipRank(Game.GetPlayer()) < 2)

	akSpeaker.SetRelationshipRank(Game.GetPlayer(), 2)
	(Game.GetPlayer() as Actor).SetRelationshipRank(akSpeaker, 2)

	String actorName = (akSpeaker as ObjectReference).GetBaseObject().GetName()
	Debug.Notification(actorName  + " is now your Ally")
endif

Game.GetPlayer().removeitem(skooma,1)
Game.GetPlayer().equipitem(skooma,1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property Skooma  Auto  

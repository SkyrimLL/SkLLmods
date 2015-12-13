;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Corruption32drink Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetStage(39)

if (akSpeaker.GetRelationshipRank(Game.GetPlayer()) < 1)
	akSpeaker.SetRelationshipRank(Game.GetPlayer(), 1)
	(Game.GetPlayer() as Actor).SetRelationshipRank(akSpeaker, 1)

	String actorName = (akSpeaker as ObjectReference).GetBaseObject().GetName()
	Debug.Notification(actorName  + " is now your Friend")
endif

Game.GetPlayer().removeitem(Mead,1)
Game.GetPlayer().equipitem(Mead,1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property Mead  Auto  

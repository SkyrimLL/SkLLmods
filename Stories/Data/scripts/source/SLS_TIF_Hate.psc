;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_Hate Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int iRelationshipRank = akSpeaker.GetRelationshipRank(Game.GetPlayer()) as Int

Debug.Notification("[SLS] Current relationship: " + iRelationshipRank )

iRelationshipRank = iRelationshipRank  - 1

akSpeaker.SetRelationshipRank(Game.GetPlayer(), iRelationshipRank  )
Game.GetPlayer().SetRelationshipRank(akSpeaker, iRelationshipRank  )

Debug.Notification("[SLS] New relationship: " + iRelationshipRank )

Debug.Notification("[SLS] New relationship check: " +  akSpeaker.GetRelationshipRank(Game.GetPlayer()) )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

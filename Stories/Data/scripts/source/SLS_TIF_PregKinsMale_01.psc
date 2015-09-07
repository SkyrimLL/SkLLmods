;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_PregKinsMale_01 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int relationshipRank = akSpeaker.GetRelationshipRank(Game.GetPlayer())

if ( relationshipRank  > 0 )
	akSpeaker.SetRelationshipRank(Game.GetPlayer(),   -1)
elseif ( relationshipRank  > -4 )
	akSpeaker.SetRelationshipRank(Game.GetPlayer(), relationshipRank  - 1)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

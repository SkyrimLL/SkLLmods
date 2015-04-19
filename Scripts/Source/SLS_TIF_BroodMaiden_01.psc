;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname SLS_TIF_BroodMaiden_01 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int relationshipRank = (_SLS_BroodMaiden as Actor).GetRelationshipRank(Game.GetPlayer())

if ( relationshipRank  > 0 )
	(_SLS_BroodMaiden as Actor).SetRelationshipRank(Game.GetPlayer(),   -1)
elseif ( relationshipRank  > -4 )
	(_SLS_BroodMaiden as Actor).SetRelationshipRank(Game.GetPlayer(), relationshipRank  - 1)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property _SLS_BroodMaiden  Auto  

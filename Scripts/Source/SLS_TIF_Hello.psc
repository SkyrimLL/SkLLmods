;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_Hello Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.Notification("[SLS] NPC sex count = " + SexLab.PlayerSexCount( akSpeaker ) )
Debug.Notification("[SLS] New relationship check: " +  akSpeaker.GetRelationshipRank(Game.GetPlayer()) )

_SLS_NPCSexCount.SetValue(  SexLab.PlayerSexCount( akSpeaker ) )

If (_SLS_NPCSexCount.GetValue() >= 2) && (akSpeaker.GetRelationshipRank(Game.GetPlayer())<2)
;	akSpeaker.SetRelationshipRank(Game.GetPlayer(), 2)
;	Game.GetPlayer().SetRelationshipRank(akSpeaker, 2)

ElseIf (_SLS_NPCSexCount.GetValue() >= 4) && (akSpeaker.GetRelationshipRank(Game.GetPlayer())<3) 
;	akSpeaker.SetRelationshipRank(Game.GetPlayer(), 3)
;	Game.GetPlayer().SetRelationshipRank(akSpeaker, 3)

ElseIf (_SLS_NPCSexCount.GetValue() >= 6) && (akSpeaker.GetRelationshipRank(Game.GetPlayer())<4) 
;	akSpeaker.SetRelationshipRank(Game.GetPlayer(), 4)
;	Game.GetPlayer().SetRelationshipRank(akSpeaker, 4)

EndIf

if ( (akSpeaker as ObjectReference).GetAnimationVariableInt("iDrunkVariable") == 1)
	; Debug.Notification("NPC drunk state: " + (akSpeaker as ObjectReference).GetAnimationVariableInt("iDrunkVariable"))
	_SLS_NPCdrunk.SetValue(1)
Else
	_SLS_NPCdrunk.SetValue(0)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


SexLabFramework Property SexLab  Auto  

GlobalVariable Property _SLS_NPCSexCount  Auto  



ReferenceAlias Property _SLS_speakerAlias  Auto  

GlobalVariable Property _SLS_NPCDrunk  Auto  

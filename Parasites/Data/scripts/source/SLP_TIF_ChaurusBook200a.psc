;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_ChaurusBook200a Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor akPlayer = Game.GetPlayer()
akPlayer.removeitem(_SLP_MotherSeed, 1)

self.GetOwningQuest().SetStage(200)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLP_fcts_parasites Property fctParasites  Auto
ObjectReference Property CaveChaurusRef  Auto  

MiscObject Property _SLP_MotherSeed  Auto  

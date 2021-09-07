;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Corruption35journal Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetStage(35)
Self.GetOwningQuest().SetStage(36)
Self.GetOwningQuest().SetStage(30)
(_SLSD_SisterOphelia as Actor).SendModEvent("SLSDEquipOutfit","HamalCorrupted")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property _SLSD_SisterOphelia  Auto  

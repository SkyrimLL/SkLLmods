;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Corruption10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetStage(10)

(SvanaRef as Actor).SendModEvent("SLSDEquipOutfit","FjotraNovice")
(HaelgaRef as Actor).SendModEvent("SLSDEquipOutfit","HamalCorrupted")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property SvanaRef  Auto  

ObjectReference Property HaelgaRef  Auto  

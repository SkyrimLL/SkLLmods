;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Corruption22 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().Setstage(22)
Self.GetOwningQuest().Setstage(20)

Game.GetPlayer().RemoveItem(Mead,1)

(_SLSD_SisterMoira as Actor).SendModEvent("SLSDEquipOutfit","HamalCorrupted")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property Mead  Auto  

ObjectReference Property _SLSD_SisterMoira  Auto  

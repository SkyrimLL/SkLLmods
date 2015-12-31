;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Cleansing59 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetStage(59)
Game.GetPlayer().RemoveItem(OrlaLetter1, 1)
Game.GetPlayer().RemoveItem(OrlaLetter2, 1)
Game.GetPlayer().RemoveItem(OrlaLetter3, 1)
Game.GetPlayer().RemoveItem(WolfsbaneVial, 1)

(OrlaRef as Actor).SendModEvent("SLSDEquipOutfit","SisterPure")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Book Property OrlaLetter1 Auto
Book Property OrlaLetter2 Auto
Book Property OrlaLetter3 Auto
Potion  Property WolfsbaneVial Auto

ObjectReference Property OrlaRef  Auto  

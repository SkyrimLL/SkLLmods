;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Cleansing69 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetStage(69)

Game.GetPlayer().RemoveItem( AnwenLetter, 1)
Game.GetPlayer().RemoveItem( AnwenStatue, 1)

(AnwenRef as Actor).SendModEvent("SLSDEquipOutfit","SisterPure")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property AnwenStatue  Auto  

Book Property AnwenLetter  Auto  

ObjectReference Property AnwenRef  Auto  

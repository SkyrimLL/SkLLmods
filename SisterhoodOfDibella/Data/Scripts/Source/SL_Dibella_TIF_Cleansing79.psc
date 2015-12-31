;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Cleansing79 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetStage(79)

Game.GetPlayer().RemoveItem( PoetryEda, 1)

(EdaRef as Actor).SetOutfit(TravelingSisterOutfit)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Book Property PoetryEda  Auto  

Outfit Property TravelingSisterOutfit  Auto  

ObjectReference Property EdaRef  Auto  

;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Cleansing14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetStage(14)

Game.GetPlayer().AddItem( HaelgaHood, 1 )
(SvanaCorruptedRef as Actor).SetOutfit(SisterNakedNoHood)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property HaelgaHood  Auto  

Outfit Property SisterNakedNoHood  Auto  

ObjectReference Property SvanaCorruptedRef  Auto  
;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_LastelleTasks49 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()
kPlayer.RemoveItem(ChaurusBookLocked, 1)
kPlayer.AddItem(ChaurusBook, 1)
self.GetOwningQuest().setstage(49)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Ingredient Property ChaurusEgg  Auto  

ObjectReference Property EggSackOutsideMarker  Auto  

Book Property ChaurusBook  Auto  

MiscObject Property ChaurusBookLocked  Auto  

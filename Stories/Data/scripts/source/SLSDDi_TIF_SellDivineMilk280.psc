;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLSDDi_TIF_SellDivineMilk280 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()
int milkCount = kPlayer.GetItemCount(DivineMilk) 

if (milkCount > 0)
	kPlayer.RemoveItem(DivineMilk, milkCount )
	kPlayer.AddItem(Gold, 50 * milkCount )
EndIf

Self.GetOwningQuest().Setstage(280)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property Milk  Auto  

MiscObject Property Gold  Auto  

Potion Property DivineMilk  Auto  

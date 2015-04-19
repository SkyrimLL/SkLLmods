;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLSDDi_TIF_SellMilk5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int milkCount = Game.GetPlayer().GetItemCount(Milk) 

if (milkCount > 0)
	Game.GetPlayer().RemoveItem(Milk, milkCount )
	Game.GetPlayer().AddItem(Gold, 50 * milkCount )
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property Milk  Auto  

MiscObject Property Gold  Auto  

Potion Property DivineMilk  Auto  

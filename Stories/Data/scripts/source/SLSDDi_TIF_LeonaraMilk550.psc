;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLSDDi_TIF_LeonaraMilk550 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()
int cheeseCount = kPlayer.GetItemCount(DivineCheese) 

if (cheeseCount > 0)
	kPlayer.RemoveItem(DivineCheese, cheeseCount )
	kPlayer.AddItem(Gold, 500 * cheeseCount )
EndIf

Self.GetOwningQuest().Setstage(280)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property Milk  Auto  

MiscObject Property Gold  Auto  

Potion Property DivineMilk  Auto  

Potion Property DivineCheese  Auto  

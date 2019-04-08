;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Corruption50c Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer=Game.GetPlayer()
kPlayer.AddItem(FoodHonningbrewMead, 2 )
kPlayer.EquipItem(FoodHonningbrewMead, 2 )
akSpeaker.AddItem(FoodHonningbrewMead, 1 )
akSpeaker.EquipItem(FoodHonningbrewMead, 1 )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property FoodHonningbrewMead  Auto  

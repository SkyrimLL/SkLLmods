;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Corruption50d Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer=Game.GetPlayer()
kPlayer.AddItem(Skooma, 2 )
kPlayer.EquipItem(Skooma, 2 )
akSpeaker.AddItem(Skooma, 2 )
akSpeaker.EquipItem(Skooma, 2 )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property Skooma  Auto  

MusicType Property MUSCombatBoss  Auto  

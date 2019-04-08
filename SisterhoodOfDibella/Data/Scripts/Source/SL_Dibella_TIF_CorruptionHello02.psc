;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_CorruptionHello02 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer=Game.GetPlayer()
kPlayer.AddItem(Skooma, 1 )
kPlayer.EquipItem(Skooma, 1 )
akSpeaker.AddItem(Skooma, 1 )
akSpeaker.EquipItem(Skooma, 1 )

akSpeaker.SendModEvent("PCSubEntertain", "Gangbang")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property Skooma  Auto  

;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLSDDi_TIF_CowEquipHarness Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()

kPlayer.RemoveItem(CowHarness, 1)

; akSpeaker.AddItem(CowHarness, 1)
; akSpeaker.EquipItem(CowHarness)

akSpeaker.SendModEvent("_SLSDDi_EquipMilkingDevice")

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property CowHarness  Auto  

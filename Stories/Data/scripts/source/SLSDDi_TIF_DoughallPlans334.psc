;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLSDDi_TIF_DoughallPlans334 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.getPlayer()

kPlayer.RemoveItem(MilkPlans, 1)

self.GetOwningQuest().SetStage(334)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property DivineCheeseQuest  Auto
Armor Property autoCowHarnessInventory Auto
ObjectReference Property DoughallChestContainerRef  Auto  

MiscObject Property MilkPlans  Auto  

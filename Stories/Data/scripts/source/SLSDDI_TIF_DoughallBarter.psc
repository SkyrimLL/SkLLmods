;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLSDDI_TIF_DoughallBarter Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetObjectiveDisplayed(49, false)
akSpeaker.ShowBarterMenu()
;END CODE 
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if ( DivineCheeseQuest.GetStageDone(310) )
	if (DoughallChestContainerRef.GetItemCount(autoCowHarnessInventory) == 0)
		DoughallChestContainerRef.AddItem(autoCowHarnessInventory, 1)
	endif
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property DivineCheeseQuest  Auto
Armor Property autoCowHarnessInventory Auto
ObjectReference Property DoughallChestContainerRef  Auto  

;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname Alicia_TIF_Story70cured Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetStage(70)
AliciaController.SetObjectiveDisplayed(10, false)
AliciaController.SetObjectiveDisplayed(20, false)
AliciaController.SetObjectiveDisplayed(30, false)
AliciaController.SetObjectiveDisplayed(40, false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property AliciaController  Auto  

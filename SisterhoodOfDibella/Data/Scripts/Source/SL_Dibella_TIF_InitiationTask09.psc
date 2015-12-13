;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SL_Dibella_TIF_InitiationTask09 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; DibellaPathQuest.SetStage(50)

; Self.GetOwningQuest().SetObjectiveDisplayed(30, abDisplayed = False)
Self.GetOwningQuest().SetObjectiveDisplayed(45)
; Self.GetOwningQuest().SetStage(45)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property DibellaPathQuest  Auto  
GlobalVariable Property SybilLevel  Auto  

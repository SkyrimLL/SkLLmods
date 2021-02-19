;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLSDDi_TIF_AboutBusiness Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Quest thisQuest = self.GetOwningQuest()

CowLife.UpdateBusiness()

if (thisQuest.GetStageDone(55)) && (!thisQuest.GetStageDone(100))
	; clear past objectives below 100
      thisQuest.SetStage(100)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLSDDi_QST_CowLife Property CowLife Auto

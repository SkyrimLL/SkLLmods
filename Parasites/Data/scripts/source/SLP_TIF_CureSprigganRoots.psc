;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_CureSprigganRoots Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Bool bTrigger = false
KynesBlessingQuest.SetObjectiveDisplayed(90)
	if (KynesBlessingQuest.GetStageDone(92)==1) 
		KynesBlessingQuest.setObjectiveDisplayed(90, false)
		KynesBlessingQuest.setObjectiveDisplayed(92)
		bTrigger = true
	endif
	if (KynesBlessingQuest.GetStageDone(94)==1) 
		KynesBlessingQuest.setObjectiveDisplayed(90, false)
		KynesBlessingQuest.setObjectiveDisplayed(92, false)
		KynesBlessingQuest.setObjectiveDisplayed(94)
		bTrigger = true
	endif

	if (bTrigger)
		debug.notification("You remember reading something about spriggans and Kyne..")
	endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property KynesBlessingQuest  Auto 

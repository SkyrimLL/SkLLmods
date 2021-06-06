Scriptname SLP_TRG_OnReadSprigganBook extends ObjectReference  

int Property myStage  Auto  

Quest Property myQuest  Auto  

event onRead()
	myQuest.setStage(myStage)
	if (myQuest.GetStageDone(90)==1) || (StorageUtil.GetIntValue(Game.GetPlayer(), "_SLP_toggleSprigganRoot" ) == 1)
		myQuest.setObjectiveDisplayed(90, false)
		myQuest.setObjectiveDisplayed(92)
	endif
endEvent


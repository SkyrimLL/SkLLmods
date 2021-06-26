Scriptname SLP_TRG_OnReadLastellePoster extends ObjectReference  
int Property myStage  Auto  

Quest Property myQuest  Auto  

event onRead()
 
	if (myQuest.GetStageDone(5)==1) 
		myQuest.setObjectiveDisplayed(5, false)
	else
		myQuest.setObjectiveDisplayed(5)
		myQuest.setStage(5)
	endif
endEvent
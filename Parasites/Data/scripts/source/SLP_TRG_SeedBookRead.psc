Scriptname SLP_TRG_SeedBookRead extends ObjectReference  

int Property preReqStage = -1 Auto
{OPTIONAL: If set, this stage must have been done to set the StageToSet}
int Property StageToSet Auto
{The stage to set the quest to when I've been read}
Quest property MyQuest Auto
{Quest to set the stage on.}

auto STATE ready
	;Event OnActivate(ObjectReference akActionRef)
	;	stageHandling()
	;EndEvent

	;Event OnEquipped(Actor akActor)
	;	stageHandling()
	;endEvent
	
	Event OnRead()
		stageHandling()
	EndEvent
endSTATE

STATE Done
endSTATE

;==============================================

FUNCTION stageHandling()
	;If (MyQuest.GetStage() == preReqStage || preReqStage == -1)
		; utility.wait(0.1)
	;	MyQuest.SetStage(StageToSet)	
	;	gotoState("Done")
	;Endif	

	if (MyQuest.GetStageDone(preReqStage)) && (!MyQuest.GetStageDone(StageToSet)) 
		MyQuest.SetStage(StageToSet)
		gotoState("Done")
	endif

endFUNCTION

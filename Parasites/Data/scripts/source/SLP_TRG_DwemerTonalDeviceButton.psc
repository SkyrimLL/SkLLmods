Scriptname SLP_TRG_DwemerTonalDeviceButton extends ObjectReference  

Quest Property QueenOfChaurusQuest  Auto 

SLP_fcts_parasites Property fctParasites  Auto

SPELL Property UnrelentingForceSpell Auto

ObjectReference Property DwemerTonalDeviceRef Auto
ObjectReference Property DwemerTonalDeviceEffectsRef Auto
ObjectReference Property SilentCityOrbRef Auto 
ObjectReference Property SilentCityOrbShoutTriggerRef Auto 

Actor Property ChaurusQueenDragon Auto

Quest Property dunBlackreachDragonQST  Auto  

Event OnActivate(ObjectReference akActionRef) 

	if (QueenOfChaurusQuest.GetStageDone(390)==1) && (StorageUtil.GetIntValue(none, "_SLP_toggleTonalKey")==1)
    	Debug.MessageBox("[The button blinks rapidly]")

    	DwemerTonalDeviceEffectsRef.enable()

    	utility.Wait(2.0)

    	UnrelentingForceSpell.cast(DwemerTonalDeviceRef, SilentCityOrbRef)

    	SilentCityOrbShoutTriggerRef.disable()

    	if (ChaurusQueenDragon.IsDead())
    		ChaurusQueenDragon.resurrect()
    	endif

    	if (dunBlackreachDragonQST.GetStageDone(10))
            ; Unused for now
        endif		

    	dunBlackreachDragonQST.SetStage(10)

    	DwemerTonalDeviceEffectsRef.disable()

    else
    	Debug.MessageBox("[The button flashes red]")
    endif
EndEvent
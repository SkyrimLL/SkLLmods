Scriptname SLP_TRG_DwemerTonalDeviceButton extends ObjectReference  

Quest Property QueenOfChaurusQuest  Auto 

SLP_fcts_parasites Property fctParasites  Auto
SLP_fcts_utils Property fctUtils  Auto

SPELL Property UnrelentingForceSpell Auto

ObjectReference Property DwemerTonalDeviceRef Auto
ObjectReference Property DwemerTonalDeviceEffectsRef Auto
ObjectReference Property SilentCityOrbRef Auto 
ObjectReference Property SilentCityOrbShoutTriggerRef Auto 
ObjectReference Property ChaurusQueenRift Auto 

ReferenceAlias Property ChaurusQueenInfectedAlias  Auto  
ObjectReference Property DummyAlias  Auto  

Actor Property ChaurusQueenDragon Auto

Quest Property dunBlackreachDragonQST  Auto  

Event OnActivate(ObjectReference akActionRef) 
    Actor kPlayer = Game.GetPlayer()

	if (QueenOfChaurusQuest.GetStageDone(390)==1) && (StorageUtil.GetIntValue(none, "_SLP_toggleTonalKey")==1)
    	Debug.Notification("[The button blinks rapidly]")

        ; Add shaking ground and falling debris to enabled marker

    	DwemerTonalDeviceEffectsRef.enable()

    	utility.Wait(2.0)

    	UnrelentingForceSpell.cast(DwemerTonalDeviceRef, SilentCityOrbRef)

    	SilentCityOrbShoutTriggerRef.disable()

        ChaurusQueenRift.Disable()

    	if (ChaurusQueenDragon.IsDead())
    		ChaurusQueenDragon.resurrect()
    	endif

    	if (dunBlackreachDragonQST.GetStageDone(10))
            ; Unused for now
        endif		

    	dunBlackreachDragonQST.SetStage(10)

    	DwemerTonalDeviceEffectsRef.disable()


        QueenOfChaurusQuest.SetStage(395)

        ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
        fctUtils.removeFromFriendlyFaction( kPlayer, "Chaurus" )

        ChaurusQueenDragon.StartCombat(kPlayer)


        Debug.MessageBox("The energy pulse from the device echoes through the caves. Before closing the Rift, the device briefly expands the doorway between world and lets the Queen go free. There can be only one Queen of the Chaurus. As long as you live, you will be a threat to the rightful Queen.")

    else
    	Debug.Notification("[The button turns red]")
    endif
EndEvent
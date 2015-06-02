Scriptname SLS_QST_CowLife extends Quest  

zadLibs Property libs Auto
zaddReliableForceGreet Property fg Auto

Armor Property cowHarnessInventory Auto
Armor Property cowHarnessRendered Auto
Keyword Property SLS_CowHarness Auto

Function PlayerReceivedCowharness( )
	libs.Log("PlayerReceivedCowharness ")
	
	; zaddsgBeltInexperiencedMsg.Show()
	Debug.MessageBox("The harness molds around your body, accentuating your breasts as the suction cups lock in around your nipples.")

	; EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
	libs.EquipDevice(libs.PlayerRef, cowHarnessInventory , cowHarnessRendered , SLS_CowHarness)
	StorageUtil.SetIntValue(none, "_SLH_iLactating", 1)

	; SetStage(10)
	; SetObjectiveDisplayed(10)
EndFunction

Function PlayerRemovedCowharness( )
	libs.Log("PlayerLostCowharness ")
	
	; zaddsgBeltInexperiencedMsg.Show()
	Debug.MessageBox("The harness lets go of your sore nipples with a loud pop.")

	; EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
	libs.RemoveDevice(libs.PlayerRef, cowHarnessInventory , cowHarnessRendered , SLS_CowHarness)
	StorageUtil.SetIntValue(none, "_SLH_iLactating", 0)

	; SetStage(10)
	; SetObjectiveDisplayed(10)
EndFunction


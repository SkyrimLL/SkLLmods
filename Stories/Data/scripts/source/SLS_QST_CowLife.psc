Scriptname SLS_QST_CowLife extends Quest  

zadLibs Property libs Auto
zaddReliableForceGreet Property fg Auto

Armor Property cowHarnessInventory Auto
Armor Property cowHarnessRendered Auto
Armor Property autoCowHarnessInventory Auto
Armor Property autoCowHarnessRendered Auto
Keyword Property SLS_CowHarness Auto
Keyword Property SLS_CowMilker Auto

Function PlayerReceivedCowharness(Actor kActor )
	libs.Log("PlayerReceivedCowharness ")
	
	; zaddsgBeltInexperiencedMsg.Show()
	Debug.MessageBox("The harness molds around your body, accentuating your breasts as the suction cups lock in around your nipples.")

	; EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
	libs.EquipDevice(kActor, cowHarnessInventory , cowHarnessRendered , SLS_CowHarness)
	StorageUtil.SetIntValue(none, "_SLH_iLactating", 1)

	; SetStage(10)
	; SetObjectiveDisplayed(10)
EndFunction

Function PlayerRemovedCowharness( Actor kActor )
	libs.Log("PlayerLostCowharness ")
	
	; zaddsgBeltInexperiencedMsg.Show()
	Debug.MessageBox("The harness lets go of your sore nipples with a loud pop.")

	; EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
	libs.RemoveDevice(kActor, cowHarnessInventory , cowHarnessRendered , SLS_CowHarness)
	StorageUtil.SetIntValue(none, "_SLH_iLactating", 0)

	; SetStage(10)
	; SetObjectiveDisplayed(10)
EndFunction

Function PlayerReceivedAutoCowharness( Actor kActor )
	libs.Log("PlayerReceivedAutoCowharness ")
	
	; zaddsgBeltInexperiencedMsg.Show()
	Debug.MessageBox("The harness molds around your body and starts humming, accentuating your breasts as the suction cups lock in around your nipples.")

	; EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
	libs.EquipDevice(kActor, autoCowHarnessInventory , autoCowHarnessRendered , SLS_CowMilker)
	StorageUtil.SetIntValue(none, "_SLH_iLactating", 1)

	; SetStage(10)
	; SetObjectiveDisplayed(10)
EndFunction

Function PlayerRemovedAutoCowharness( Actor kActor )
	libs.Log("PlayerLostAutoCowharness ")
	
	; zaddsgBeltInexperiencedMsg.Show()
	Debug.MessageBox("The harness lets go of your swollen nipples with a loud pop.")

	; EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
	libs.RemoveDevice(kActor, autoCowHarnessInventory , autoCowHarnessRendered , SLS_CowMilker)
	StorageUtil.SetIntValue(none, "_SLH_iLactating", 0)

	; SetStage(10)
	; SetObjectiveDisplayed(10)
EndFunction


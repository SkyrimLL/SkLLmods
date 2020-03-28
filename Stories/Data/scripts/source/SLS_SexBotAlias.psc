Scriptname SLS_SexBotAlias extends ReferenceAlias  

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
    Form SexBotForm = StorageUtil.GetFormValue(none, "_SLS_fSexBot")
    Actor SexBotActor = SexBotForm as Actor
    
    int iDaysPassed = Game.QueryStat("Days Passed")
    int iGameDateLastCheck = StorageUtil.GetIntValue(SexBotActor, "_SLS_LastSexDate")
    int iDaysSinceLastCheck = (iDaysPassed - iGameDateLastCheck )  

    debug.notification("[SLS_SexBotAlias] changing location")
    Debug.notification("[SLS_SexBotAlias] Days since sex - " + iDaysSinceLastCheck)

    ; Exit conditions
    If (iDaysSinceLastCheck >= 1) && (SLS_SexBotOnOff.GetValue() == 1)
        debug.notification("[SLS_SexBotAlias] time to update energy levels")
            StorageUtil.SetIntValue(SexBotActor, "_SLS_SexBotEnergyLevel", StorageUtil.GetIntValue(SexBotActor, "_SLS_SexBotEnergyLevel") - (iDaysSinceLastCheck * 2))
            SexBotActor.ForceAV("Health", 100 + (StorageUtil.GetIntValue(SexBotActor, "_SLS_SexBotEnergyLevel") * 2) )
            SexBotActor.ForceAV("Stamina", 10 + (StorageUtil.GetIntValue(SexBotActor, "_SLS_SexBotEnergyLevel") * 2) )
            SexBotActor.ForceAV("Magicka", 50 + (StorageUtil.GetIntValue(SexBotActor, "_SLS_SexBotEnergyLevel") * 5) )

            iGameDateLastCheck = iDaysPassed
            StorageUtil.SetIntValue(SexBotActor, "_SLS_LastSexDate", iGameDateLastCheck)

            if (StorageUtil.GetIntValue(SexBotActor, "_SLS_SexBotEnergyLevel")<=0)
    			Debug.Notification("E.L.L.E needs to be recharged.")
    			SLS_SexBotOnOff.SetValue(0)
    			SexBotActor.EvaluatePackage()
    			Utility.Wait(1.0)
            endif
	EndIf

    Debug.notification("[SLS_SexBotAlias] _SLS_SexBotEnergyLevel: " + StorageUtil.GetIntValue(SexBotActor, "_SLS_SexBotEnergyLevel"))

EndEvent

ReferenceAlias Property SexBotAlias  Auto  
SexLabFramework Property SexLab  Auto  

GlobalVariable Property SLS_SexBotOnOff  Auto  
GlobalVariable Property SLS_SexBotMemory  Auto  

GlobalVariable Property SLS_SexBotBody  Auto  

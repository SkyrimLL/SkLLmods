Scriptname SLS_SexBotAlias extends ReferenceAlias  

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	ObjectReference SexBotREF= SexBotAlias.GetReference()
	Actor SexBotActor= SexBotAlias.GetReference() as Actor

    int iDaysPassed = Game.QueryStat("Days Passed")
    int iGameDateLastCheck = StorageUtil.GetIntValue(SexBotActor, "_SLS_LastSexDate")
  
    if (iGameDateLastCheck < iDaysPassed)
        iGameDateLastCheck = iDaysPassed
        StorageUtil.GetIntValue(SexBotActor, "_SLS_LastSexDate")
    EndIf

    int iDaysSinceLastCheck = (iDaysPassed - iGameDateLastCheck )  

    ; Exit conditions
    If (iDaysSinceLastCheck >= 1) && (SLS_SexBotOnOff.GetValue() == 1)

			Debug.Notification("[SLS] Days since sex - " + iDaysSinceLastCheck)
			Debug.Notification("E.L.L.E needs to be recharged.")
			SLS_SexBotOnOff.SetValue(0)
			SexBotActor.EvaluatePackage()
			Utility.Wait(1.0)
	EndIf

EndEvent

ReferenceAlias Property SexBotAlias  Auto  
SexLabFramework Property SexLab  Auto  

GlobalVariable Property SLS_SexBotOnOff  Auto  
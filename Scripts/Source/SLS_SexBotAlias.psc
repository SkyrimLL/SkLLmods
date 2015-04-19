Scriptname SLS_SexBotAlias extends ReferenceAlias  

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	ObjectReference SexBotREF= SexBotAlias.GetReference()
	Actor SexBotActor= SexBotAlias.GetReference() as Actor

	float fDaysSinceLastSex = SexLab.DaysSinceLastSex(SexBotActor)

	If (  fDaysSinceLastSex  > 2.0 ) && (SLS_SexBotOnOff.GetValue() == 1)

			Debug.Notification("E.L.L.E needs to be recharged.")
			SLS_SexBotOnOff.SetValue(0)
			SexBotActor.EvaluatePackage()
			Utility.Wait(1.0)
	EndIf
EndEvent

ReferenceAlias Property SexBotAlias  Auto  
SexLabFramework Property SexLab  Auto  

GlobalVariable Property SLS_SexBotOnOff  Auto  
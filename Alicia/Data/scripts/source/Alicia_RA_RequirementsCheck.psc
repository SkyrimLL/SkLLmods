Scriptname Alicia_RA_RequirementsCheck extends ReferenceAlias  


SexLabFrameWork Property SexLab Auto
zbfConfig Property zbf Auto

Event OnInit()
	Maintenance() ; OnPlayerLoadGame will not fire the first time
EndEvent
 
Event OnPlayerLoadGame()
	Maintenance()
EndEvent

Function Maintenance()

	String sModName = "Alicia Painslut"

	If (SexLab == None)
		Debug.Messagebox(sModName + "\n SexLab was not found.\n This mod requires SexLab 1.6 or above to be installed AND enabled." )
	Else
		if (!SexLab.Enabled)
			Debug.Messagebox(sModName + "\n SexLab was found but not enabled yet.\n Enable SexLab first before enabling this mod." )
		else
			Debug.Trace(sModName + "\n SexLab found and enabled" )
		EndIf
	EndIf

	If (zbf == None)
		Debug.Messagebox(sModName + "\n Zaz animation pack was not found.\n This mod requires Zaz animation pack 6.0 or above to be installed AND enabled." )
	Else
		if (!zbf.ModName)
			Debug.Messagebox(sModName + "\n Zaz animation pack was found but not enabled yet.\n Enable Zaz animation pack first before enabling this mod." )
		else
			Debug.Trace(sModName + "\n Zaz animation pack found and enabled" )
		EndIf
	EndIf

EndFunction
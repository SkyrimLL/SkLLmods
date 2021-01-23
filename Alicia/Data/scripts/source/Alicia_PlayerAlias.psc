Scriptname Alicia_PlayerAlias extends ReferenceAlias  

Quest Property AliciaControllerQuest  Auto  

Alicia_QF_Maintenance Property AliciaControllerScript  Auto

Int iVersion = 3

Event OnInit()
	Maintenance() ; OnPlayerLoadGame will not fire the first time
EndEvent

Event OnPlayerLoadGame()

	Maintenance()

EndEvent

Function Maintenance()
	iVersion = StorageUtil.GetIntValue(none, "_SLA_iAliciaVersion")

	If (!StorageUtil.HasIntValue(none, "_SLA_iAlicia"))
		StorageUtil.SetIntValue(none, "_SLA_iAlicia", 1)
	EndIf
	
	If iVersion < 20210121 
		iVersion = 20210121 
		Debug.Trace("[Alicia] Alicia_PlayerAlias - reset controller quest " + iVersion)
		Debug.Notification("[Alicia] Controller Stop" )
		AliciaControllerQuest.Stop()
		Utility.wait(0.5)
		Debug.Notification("[Alicia] Controller Start" )
		AliciaControllerQuest.Start()
	endif

	If iVersion < 20210122 ; <--- Edit this value when updating
		iVersion = 20210122; and this
		Debug.Trace("[Alicia] Alicia_PlayerAlias - Updating to version : " + iVersion)
		StorageUtil.SetIntValue(none, "_SLA_iAliciaVersion", iVersion)
		; Update Code

	endif

	AliciaControllerScript.Maintenance()

EndFunction

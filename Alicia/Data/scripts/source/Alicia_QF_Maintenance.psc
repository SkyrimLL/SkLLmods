Scriptname Alicia_QF_Maintenance extends Quest  

Spell Property AliciaBanish Auto

Quest Property AliciaController Auto
Quest Property AliciaScenes Auto
Quest Property AliciaDaedricScenes Auto
Quest Property AliciaStory Auto

ReferenceAlias Property Alias_Alicia  Auto  
ReferenceAlias Property Alias_AliciaDaedric  Auto  

GlobalVariable Property AliciaInit  Auto  

GlobalVariable Property AliciaInWorld  Auto  
GlobalVariable Property AliciaDaedricInWorld  Auto  
 
Int iVersion

Event OnInit()
; Maintenance() ; OnPlayerLoadGame will not fire the first time
; Call for Init moved to new PlayerAlias script
EndEvent
 
Function Maintenance()
	ObjectReference AliciaDaedricRef = Alias_AliciaDaedric.GetReference()
	Actor AliciaDaedricActor= AliciaDaedricRef as Actor

	ObjectReference AliciaRef = Alias_Alicia.GetReference()
	Actor AliciaActor= AliciaRef as Actor
 
	Debug.Trace("[Alicia] AliciaActor : " + AliciaActor)
	Debug.Trace("[Alicia] AliciaDaedricActor : " + AliciaDaedricActor)

	If (iVersion != StorageUtil.GetIntValue(none, "_SLA_iAliciaVersion"))
		iVersion = StorageUtil.GetIntValue(none, "_SLA_iAliciaVersion")

		Debug.Notification("[Alicia] Updating to version : " + iVersion)
		Debug.Trace("[Alicia] Alicia_QF_Maintenance - Updating to version : " + iVersion)
		; Update Code

		; Disabling Alicia if welcome already happened
		if (AliciaInWorld.Getvalue() == 1)
			; AliciaBanish.RemoteCast(AliciaRef , AliciaActor ,AliciaRef )
   		EndIf

		if (AliciaDaedricInWorld.Getvalue() == 1)
			; AliciaBanish.RemoteCast(AliciaDaedricRef , AliciaDaedricActor ,AliciaDaedricRef )
		EndIf

		; AliciaInWorld.Setvalue(0)
		; AliciaDaedricInWorld.Setvalue(0)
		
		; Reset quest if quest already started
		If (AliciaStory.GetStage() != 5) 
			; AliciaStory.Start()
			; Utility.Wait(0.6)
			; AliciaStory.SetStage(5)
			; Utility.Wait(0.6)

			if (AliciaInit.GetValue() == 0)
			; 	AliciaActor.IgnoreFriendlyHits(true)
			; 	AliciaActor.AllowBleedoutDialogue(true)
			; 	AliciaActor.ForceAV("HealRate", 0.1)
			; 	AliciaActor.unequipall()
			EndIf
		ElseIf ((AliciaStory.GetStage() == 5) || (AliciaStory.GetStage() == 6))
			; TO DO: Find a better way to restart Alicia's scripts without risk of loosing her
			; AliciaScenes.Stop()
			; Utility.Wait(0.6)
			; AliciaScenes.Start()
			; Utility.Wait(0.6)
			
			If (AliciaStory.GetStage()!= 20)
				; AliciaScenes.SetStage(20)
			EndIf
		EndIf

		; Start Daedric version if not started
		If (AliciaDaedricScenes.GetStage() != 10)
			; AliciaDaedricScenes.Start()
		Else
			; AliciaDaedricScenes.Stop()
			; Utility.Wait(0.6)
			; AliciaDaedricScenes.Start()			
		EndIf
	else
		iVersion = StorageUtil.GetIntValue(none, "_SLA_iAliciaVersion")

		Debug.trace("[Alicia] Loading version : " + iVersion)

	EndIf

		; Start main story if not started
		If (AliciaScenes.GetStage() < 10)
			; AliciaStory.Start()
			; AliciaStory.SetStage(10)
		EndIf
	; Other maintenance code that only needs to run once per save load
EndFunction



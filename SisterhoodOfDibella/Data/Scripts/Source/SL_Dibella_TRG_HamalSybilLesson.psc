Scriptname SL_Dibella_TRG_HamalSybilLesson extends ObjectReference  

ReferenceAlias Property HamalAlias  Auto  
ReferenceAlias Property SybilAlias  Auto  

Quest Property DibellaCorruptionQuest Auto
Quest Property DibellaPurificationQuest Auto


Scene  Property HamalSybilLesson  Auto  

Event OnTriggerEnter(ObjectReference akActionRef)
	Actor akActor = akActionRef as Actor
	ObjectReference HamalREF= HamalAlias.GetReference()  
	ObjectReference SybilREF= SybilAlias.GetReference()  
	; Debug.Notification("Someone walks in Sanctum: " + akActionRef)
	; Debug.Notification("SybilREF: " + SybilREF)
	; Debug.Notification("TRG Quest: " + InitiationQuest)

	; 3d will not be loaded in some situations, such as werewolf transformations.
	; Skip body update if 3d not loaded.
	If ( !(akActionRef as Actor).Is3DLoaded() )
		return
	EndIf

	If UI.IsMenuOpen("Console") || UI.IsMenuOpen("Main Menu") || UI.IsMenuOpen("Loading Menu") || UI.IsMenuOpen("MessageBoxMenu")
		return
	EndIf

	If (akActor == Sybil) &&  (SybilRescueQuest.GetStage() == 200)
		; Debug.Notification("Sybil  is in the Sanctum : Initiation Level " + SybilLevel.GetValue())
		; Debug.Notification("Initiation quest stage: " + InitiationQuest.GetStage() )

		; If (InitiationQuest.GetStage() == 0)
		; 	InitiationQuest.SetStage(5)
		; 	InitiationFX.Cast(akActor ,akActor )
		; EndIf

		If (DibellaCorruptionQuest.GetStageDone(59))
			SybilLevel.SetValue(6)
			StorageUtil.SetIntValue( Game.GetPlayer() , "_SLSD_iDibellaTempleCorruption", 5)
		Endif

		If ( SybilLevel.GetValue() == 0)   ; Sybil is rescued -  Start Initiation to Novice
			InitiationStart.SetValue(Game.QueryStat("Days Passed") ) 
			InitiationQuest.SetStage(5)
			SybilLevel.SetValue(1)
			InitiationFX.Cast(akActor ,akActor )
 
 			If (DibellaPathQuest.GetStage()==0)
				DibellaPathQuest.Start()
				DibellaPathQuest.SetStage(10)
			EndIf

		ElseIf ( SybilLevel.GetValue() == 1)   ; Initiation to Accolyte
		;	InitiationQuest.SetStage(30)
		;	InitiationFX.Cast(akActor ,akActor )
		;	DibellaPathQuest.SetStage(20)
			Sybil.SendModEvent("SLSDEquipOutfit","FjotraNovice")

		ElseIf ( SybilLevel.GetValue() == 2)   ; Initiation to Accolyte
		;	InitiationQuest.SetStage(30)
		;	InitiationFX.Cast(akActor ,akActor )
		;	DibellaPathQuest.SetStage(20)
			Sybil.SendModEvent("SLSDEquipOutfit","FjotraAccolyte")

		ElseIf ( SybilLevel.GetValue() == 3)   ; Initiation to Initiate
		;	InitiationQuest.SetStage(30)
		;	InitiationFX.Cast(akActor ,akActor )
		;	DibellaPathQuest.SetStage(50)
			Sybil.SendModEvent("SLSDEquipOutfit","FjotraInitiate")

		ElseIf ( SybilLevel.GetValue() >= 4)   ; Initiation to Mother
		;	InitiationQuest.SetStage(60)
		;	InitiationFX.Cast(akActor ,akActor )
			Sybil.SendModEvent("SLSDEquipOutfit","FjotraCorrupted")
		EndIf

		StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iSybilLevel", SybilLevel.GetValue() as Int )

		; HamalSybilLesson.ForceStart()
	EndIf
EndEvent

Quest Property HamalSybilLessonQuest  Auto  



GlobalVariable Property SybilLevel  Auto  

Actor Property Sybil  Auto  

SPELL Property InitiationFX  Auto  

GlobalVariable Property InitiationStart  Auto  

Quest Property InitiationQuest  Auto  

Quest Property SybilRescueQuest  Auto  

Quest Property DibellaPathQuest  Auto  

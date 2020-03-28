Scriptname SLS_TRG_SexBotAssemblyButton extends ObjectReference  

Quest Property SexBotQuest  Auto  

ObjectReference Property SexBotRefRef  Auto  
ObjectReference Property LexiconMarkerRef  Auto  

ObjectReference Property AssemblyDoorRef  Auto  
ObjectReference Property AssemblyEngineRef  Auto  
ObjectReference Property WorkerBotRef  Auto  
ObjectReference Property AssemblyLockerRef  Auto  

Armor Property SexBotBasicSkin Auto
Armor Property SexBotMixedSkin Auto
Armor Property SexBotPleasureSkin Auto
Armor Property SexBotEvolvedSkin Auto

Outfit Property SexBotBasicOutfit Auto
Outfit Property SexBotMixedOutfit Auto
Outfit Property SexBotPleasureOutfit Auto
Outfit Property SexBotEvolvedOutfit Auto

GlobalVariable Property SexBotRepairLevel Auto

Armor Property RefreshToken Auto

Spell Property TonalAdjustmentSpell  Auto 
Spell Property SteamSpell  Auto 

Message Property AssemblyMenu  Auto  
 

Auto STATE Waiting
Event OnActivate(ObjectReference akActionRef)
	Actor akActor = akActionRef as Actor
	Actor akPlayer = Game.getPlayer() as Actor
	Actor SexBotActor = SexBotRefRef as Actor
	ActorBase akActorBase = SexBotActor.GetActorBase()
	String currentSkin = StorageUtil.GetStringValue(SexBotActor, "_SLS_SexBotSkin")
	Int iFormIndex = AssemblyLockerRef.GetNumItems()
	Int iDataCubeNum = 0
	Bool bBasicDataCube = False
	Bool bMixedDataCube = False
	Bool bPleasureDataCube = False
	Bool bEvolvedDataCube = False
	Bool bTransform = False

	If (akActor == akPlayer)  
		; Debug.Notification("Sybil  is in the Sanctum : Initiation Level " + SybilLevel.GetValue())
		; Debug.Notification("Initiation quest stage: " + InitiationQuest.GetStage() )

		; If (InitiationQuest.GetStage() == 0)
		; 	InitiationQuest.SetStage(5)
		; 	InitiationFX.Cast(akActor ,akActor )
		; EndIf
		Debug.Notification("Assembly procedure - Analysis...'")

		While ( iFormIndex > 0 )
			iFormIndex -= 1
			Form kForm = AssemblyLockerRef.GetNthForm(iFormIndex)

			if (kForm.hasKeywordString("_SLS_SexBotBasicDataCube")) 
				bBasicDataCube = true
				iDataCubeNum += 1 
				Debug.Notification("Assembly procedure - Basic model - available'")
			elseif (kForm.hasKeywordString("_SLS_SexBotMixedDataCube")) 
				bMixedDataCube = true
				iDataCubeNum += 1 
				Debug.Notification("Assembly procedure - Servant model - available'")
			elseif (kForm.hasKeywordString("_SLS_SexBotPleasureDataCube")) 
				bPleasureDataCube = true
				iDataCubeNum += 1 
				Debug.Notification("Assembly procedure - Pleasure model - available'")
			elseif (kForm.hasKeywordString("_SLS_SexBotEvolvedDataCube")) 
				bEvolvedDataCube = true
				iDataCubeNum += 1 
				Debug.Notification("Assembly procedure - Evolved model - available'")
			endif
		EndWhile

		SexBotRepairLevel.SetValue(iDataCubeNum)
		StorageUtil.SetFormValue(none, "_SLS_fSexBot", SexBotActor as Form)
		StorageUtil.SetIntValue(SexBotActor, "_SLS_iSexBotRepairLevel", iDataCubeNum)

		if (iDataCubeNum>=4)
			Debug.Notification("Assembly procedure - Main Cosmetic Menu (MCM)- unlocked'")
			If (!SexBotQuest.GetStageDone(70))
				SexBotQuest.SetStage(70)
			endif
		endif

		; New enslavement - changing ownership
		Int IButton = AssemblyMenu.Show()

		If IButton == 0 ; Basic model
			if (bBasicDataCube)
				akActorBase.SetSkin(SexBotBasicSkin)
				SexBotActor.SetOutfit(SexBotBasicOutfit, true)
				StorageUtil.SetStringValue(SexBotActor, "_SLS_SexBotSkin", "Basic")
				Debug.Notification("Assembly procedure - Basic Model selected.'")
				bTransform = true
			else
				Debug.Notification("Assembly procedure - Basic Model data unavailable.'")
			endif

		ElseIf IButton == 1 ; Mixed model
			if (bMixedDataCube)
				akActorBase.SetSkin(SexBotMixedSkin)
				SexBotActor.SetOutfit(SexBotMixedOutfit, true)
				StorageUtil.SetStringValue(SexBotActor, "_SLS_SexBotSkin", "Mixed")
				Debug.Notification("Assembly procedure - Mixed Model selected.'")
				bTransform = true
			else
				Debug.Notification("Assembly procedure - Mixed Model data unavailable.'")
			endif

		ElseIf IButton == 2 ; Pleasure model
			if (bPleasureDataCube)
				akActorBase.SetSkin(SexBotPleasureSkin)
				SexBotActor.SetOutfit(SexBotPleasureOutfit, true)
				StorageUtil.SetStringValue(SexBotActor, "_SLS_SexBotSkin", "Pleasure")
				Debug.Notification("Assembly procedure - Pleasure Model selected.'")
				bTransform = true
			else
				Debug.Notification("Assembly procedure - Pleasure Model data unavailable.'")
			endif

		ElseIf IButton == 3 ; Evolved model
			if (bEvolvedDataCube)
				akActorBase.SetSkin(SexBotEvolvedSkin)
				SexBotActor.SetOutfit(SexBotEvolvedOutfit, true)
				StorageUtil.SetStringValue(SexBotActor, "_SLS_SexBotSkin", "Evolved")
				Debug.Notification("Assembly procedure - Evolved Model selected.'")
				bTransform = true
			else
				Debug.Notification("Assembly procedure - Evolved Model data unavailable.'")
			endif

		Else ; Cancel

		EndIf

		If ( bTransform )
			LexiconMarkerRef.Enable()

			SexBotActor.MoveTo( LexiconMarkerRef )
			Debug.SendAnimationEvent(SexBotActor, "ZazAPCAO302")
			SexBotActor.SetDontMove()

			Utility.Wait(1.0)

			Debug.Notification("Assembly procedure - Initiating... Please stand clear of the doors.'")

			AssemblyDoorRef.SetOpen(false)
				
			TonalAdjustmentSpell.cast(WorkerBotRef, SexBotRefRef)
			SteamSpell.cast(AssemblyEngineRef, SexBotRefRef)
			SexBotActor.MoveTo( LexiconMarkerRef )
			Utility.Wait(1.0)

			TonalAdjustmentSpell.cast(WorkerBotRef, SexBotRefRef)
			SteamSpell.cast(AssemblyEngineRef, SexBotRefRef)
			SexBotActor.MoveTo( LexiconMarkerRef )
			Utility.Wait(2.0)

			TonalAdjustmentSpell.cast(WorkerBotRef, SexBotRefRef)
			SteamSpell.cast(AssemblyEngineRef, SexBotRefRef)
			SexBotActor.MoveTo( LexiconMarkerRef )
			Utility.Wait(1.0)

			TonalAdjustmentSpell.cast(WorkerBotRef, SexBotRefRef)
			SteamSpell.cast(AssemblyEngineRef, SexBotRefRef)
			SexBotActor.MoveTo( LexiconMarkerRef )
			Utility.Wait(1.0)

			SexBotRefRef.AddItem(RefreshToken, 1)
			SexBotActor.EquipItem(RefreshToken)

			TonalAdjustmentSpell.cast(WorkerBotRef, SexBotRefRef)
			SteamSpell.cast(AssemblyEngineRef, SexBotRefRef)
			SexBotActor.MoveTo( LexiconMarkerRef )
			Utility.Wait(1.0)

			SexBotRefRef.RemoveItem(RefreshToken)

			TonalAdjustmentSpell.cast(WorkerBotRef, SexBotRefRef)
			SteamSpell.cast(AssemblyEngineRef, SexBotRefRef)
			SexBotActor.MoveTo( LexiconMarkerRef )
			Utility.Wait(1.0)

			SexBotActor.SetDontMove(false)
			Debug.SendAnimationEvent(SexBotActor, "IdleForceDefaultState")

			LexiconMarkerRef.Disable()
		Endif

	EndIf

EndEvent
endState

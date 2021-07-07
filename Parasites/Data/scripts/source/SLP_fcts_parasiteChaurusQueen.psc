Scriptname SLP_fcts_parasiteChaurusQueen extends Quest  

zadLibs Property libs Auto

SLP_fcts_utils Property fctUtils  Auto
SLP_fcts_parasites_devious Property fctDevious  Auto

Quest Property KynesBlessingQuest  Auto 
Quest Property QueenOfChaurusQuest  Auto 

Keyword Property _SLP_ParasiteChaurusWormVag Auto  
Keyword Property _SLP_ParasiteChaurusQueenGag Auto  
Keyword Property _SLP_ParasiteChaurusQueenSkin Auto  
Keyword Property _SLP_ParasiteChaurusQueenArmor Auto  
Keyword Property _SLP_ParasiteChaurusQueenBody Auto  
Keyword Property _SLP_ParasiteChaurusQueenVag Auto  

GlobalVariable Property _SLP_GV_numInfections  Auto 

Armor Property SLP_plugChaurusQueenVagRendered Auto         ; Internal Device
Armor Property SLP_plugChaurusQueenVagInventory Auto        	       ; Inventory Device
Armor Property SLP_gagChaurusQueenRendered Auto         ; Internal Device
Armor Property SLP_gagChaurusQueenInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessChaurusQueenSkinRendered Auto         ; Internal Device
Armor Property SLP_harnessChaurusQueenSkinInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessChaurusQueenArmorRendered Auto         ; Internal Device
Armor Property SLP_harnessChaurusQueenArmorInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessChaurusQueenBodyRendered Auto         ; Internal Device
Armor Property SLP_harnessChaurusQueenBodyInventory Auto        	       ; Inventory Device
Armor Property _SLP_skinChaurusQueenNaked Auto

Actor Property EncChaurusActor Auto 
Actor Property EncChaurusSpawnActor Auto 
Actor Property EncChaurusFledgelingActor Auto 
Actor Property EncChaurusHunterActor Auto 

ReferenceAlias Property ChaurusQueenInfectedAlias  Auto  
ObjectReference Property DummyAlias  Auto  

Sound Property CritterFX  Auto
Sound Property WetFX  Auto
Sound Property SummonSoundFX  Auto

SPELL Property SeedFlare Auto

Ingredient  Property SmallSpiderEgg Auto
Ingredient Property ChaurusEgg  Auto  


;------------------------------------------------------------------------------
Armor Function getParasiteByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "ChaurusQueenGag" )  
		thisArmor = SLP_gagChaurusQueenInventory

	Elseif (deviousKeyword == "ChaurusQueenVag" )  
		thisArmor = SLP_plugChaurusQueenVagInventory

	Elseif (deviousKeyword == "ChaurusQueenSkin" )  
		thisArmor = SLP_harnessChaurusQueenSkinInventory

	Elseif (deviousKeyword == "ChaurusQueenArmor" )  
		thisArmor = SLP_harnessChaurusQueenArmorInventory

	Elseif (deviousKeyword == "ChaurusQueenBody" )  
		thisArmor = SLP_harnessChaurusQueenBodyInventory

	EndIf

	return thisArmor
EndFunction

Armor Function getParasiteRenderedByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "ChaurusQueenGag" )  
		thisArmor = SLP_gagChaurusQueenRendered

	Elseif (deviousKeyword == "ChaurusQueenVag" )  
		thisArmor = SLP_plugChaurusQueenVagRendered

	Elseif (deviousKeyword == "ChaurusQueenSkin" )  
		thisArmor = SLP_harnessChaurusQueenSkinRendered

	Elseif (deviousKeyword == "ChaurusQueenArmor" )  
		thisArmor = SLP_harnessChaurusQueenArmorRendered

	Elseif (deviousKeyword == "ChaurusQueenBody" )  
		thisArmor = SLP_harnessChaurusQueenBodyRendered

	EndIf

	return thisArmor
EndFunction

Keyword Function getDeviousKeywordByString(String deviousKeyword = ""  )
	Keyword thisKeyword = None
 
	if (deviousKeyword == "ChaurusWormVag" )  
		thisKeyword = _SLP_ParasiteChaurusWormVag
		
	elseif (deviousKeyword == "ChaurusQueenGag" )  
		thisKeyword = _SLP_ParasiteChaurusQueenGag
		
	elseif (deviousKeyword == "ChaurusQueenVag" )  
		thisKeyword = _SLP_ParasiteChaurusQueenVag
		
	elseif (deviousKeyword == "ChaurusQueenSkin" )  
		thisKeyword = _SLP_ParasiteChaurusQueenSkin
		
	elseif (deviousKeyword == "ChaurusQueenArmor" )  
		thisKeyword = _SLP_ParasiteChaurusQueenArmor
		
	elseif (deviousKeyword == "ChaurusQueenBody" )  
		thisKeyword = _SLP_ParasiteChaurusQueenBody
		
	else
		thisKeyword = fctDevious.getDeviousDeviceKeywordByString( deviousKeyword  )
	endIf

	return thisKeyword
EndFunction

Function applyBaseChaurusQueenSkin()
 	Actor PlayerActor = Game.GetPlayer()
	ActorBase pActorBase = PlayerActor.GetActorBase()
	ActorBase pLeveledActorBase = PlayerActor.GetLeveledActorBase()
	Float fWeightOrig = pActorBase.GetWeight()
	Float fWeight
	Float NeckDelta

	pLeveledActorBase.SetWeight(fWeightOrig)
	pLeveledActorBase.SetSkin(_SLP_skinChaurusQueenNaked)
	fWeight = pLeveledActorBase.GetWeight()
	NeckDelta = (fWeightOrig / 100) - (fWeight / 100)
	PlayerActor.UpdateWeight(NeckDelta) ;Apply the changes.


EndFunction


Function refreshParasite(Actor kActor, String sParasite)
 	Actor PlayerActor = Game.GetPlayer()

	If (sParasite == "ChaurusQueenGag")
		If (isInfectedByString( kActor,  "ChaurusQueenGag" )) 
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenGag", 1)
			equipParasiteNPCByString (kActor, "ChaurusQueenGag")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenGag", 0)
			clearParasiteNPCByString (kActor, "ChaurusQueenGag")
		Endif

	ElseIf (sParasite == "ChaurusQueenVag")
		If (isInfectedByString( kActor,  "ChaurusQueenVag" )) 
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenVag", 1)
			equipParasiteNPCByString (kActor, "ChaurusQueenVag")


		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenVag", 0)
			clearParasiteNPCByString (kActor, "ChaurusQueenVag")
		Endif

	ElseIf (sParasite == "ChaurusQueenSkin")
		If (isInfectedByString( kActor,  "ChaurusQueenSkin" )) 
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenSkin", 1)
			equipParasiteNPCByString (kActor, "ChaurusQueenSkin")


		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenSkin", 0)
			clearParasiteNPCByString (kActor, "ChaurusQueenSkin")
		Endif

	ElseIf (sParasite == "ChaurusQueenArmor")
		If (isInfectedByString( kActor,  "ChaurusQueenArmor" )) 
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenArmor", 1)
			equipParasiteNPCByString (kActor, "ChaurusQueenArmor")

			If (kActor == PlayerActor) && QueenOfChaurusQuest.GetStageDone(350)
				; Debug.Notification("[SLP]	Spriggan Alias attached")
				Debug.Trace("[SLP]	ChaurusQueen Alias attached")
				ChaurusQueenInfectedAlias.ForceRefTo(PlayerActor)
				fctUtils.addToFriendlyFaction( PlayerActor, "Chaurus" )
			endIf
		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenArmor", 0)
			clearParasiteNPCByString (kActor, "ChaurusQueenArmor")

			if (!(isInfectedByString( kActor,  "ChaurusQueenBody" )) )
				ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
				fctUtils.removeFromFriendlyFaction( PlayerActor, "Chaurus" )
			endif
		Endif

	ElseIf (sParasite == "ChaurusQueenBody")
		If (isInfectedByString( kActor,  "ChaurusQueenBody" )) 
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenBody", 1)
			equipParasiteNPCByString (kActor, "ChaurusQueenBody")

			If (kActor == PlayerActor) && QueenOfChaurusQuest.GetStageDone(400)
				; Debug.Notification("[SLP]	Spriggan Alias attached")
				Debug.Trace("[SLP]	ChaurusQueen Alias attached")
				ChaurusQueenInfectedAlias.ForceRefTo(PlayerActor)
				fctUtils.addToFriendlyFaction( PlayerActor, "Chaurus" )
			endIf
		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenBody", 0)
			clearParasiteNPCByString (kActor, "ChaurusQueenBody")

			if (!(isInfectedByString( kActor,  "ChaurusQueenArmor" )) )
				ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
				fctUtils.removeFromFriendlyFaction( PlayerActor, "Chaurus" )
			endif
		Endif

	Endif



EndFunction
;------------------------------------------------------------------------------
Bool Function infectChaurusQueenVag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenVag", 0 )
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenVag" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "ChaurusQueenVag" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (fctDevious.ActorHasKeywordByString( kActor, "PlugVaginal"  ))
		Debug.Trace("[SLP]	Already wearing a vaginal plug - Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif

	SeedFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
	equipParasiteNPCByString (kActor, "ChaurusQueenVag")

	Return true ; Return applyChaurusWormVag( kActor  )

EndFunction

Bool Function applyChaurusQueenVag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
	;	ChaurusQueenInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	; fctUtils.ApplyBodyChange( kActor, "ChaurusQueenVag", "Belly", 1.5, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusQueenVagInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenVagInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenVag", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenVagDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenVagInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenVagInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		; _SLP_GV_numChaurusWormVagInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenVagInfections"))
	endIf

	applyBaseChaurusQueenSkin()

	if (StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")<2)
		StorageUtil.SetIntValue(PlayerActor, "_SLP_iChaurusQueenStage",  2)
	endif

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPChaurusQueenVagInfection")

	; if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
	;	KynesBlessingQuest.SetStage(20)
	; endif
	
	Return True
EndFunction

Function cureChaurusQueenVag( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "ChaurusQueenVag" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenVag", 0)
		clearParasiteNPCByString (kActor, "ChaurusQueenVag")
		; fctUtils.ApplyBodyChange( kActor, "ChaurusQueenVag", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_plugChaurusQueenVagInventory,1)
		Endif

		If (kActor == PlayerActor)
		;	ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenVag", 0)
	EndIf
EndFunction


;------------------------------------------------------------------------------
Bool Function infectChaurusQueenGag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenGag", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenGag" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "ChaurusQueenGag" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (fctDevious.ActorHasKeywordByString( kActor, "Gag"  ))
		Debug.Trace("[SLP]	Already wearing a gag - Aborting")
		Return False
	Endif

	SeedFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
	equipParasiteNPCByString (kActor, "ChaurusQueenGag")

	Return  true; applyFaceHuggerGag( kActor )
EndFunction

Bool Function applyChaurusQueenGag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
	;	ChaurusQueenInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusQueenGagInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenGagInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenGag", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenGagDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenGagInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenGagInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		; _SLP_GV_numFaceHuggerInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenGagInfections"))
	endIf

	applyBaseChaurusQueenSkin()

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPChaurusQueenGagInfection")

	if (!QueenOfChaurusQuest.GetStageDone(350)) && (kActor == PlayerActor)
		QueenOfChaurusQuest.SetStage(350)
	endif
	
	Return True
EndFunction

Function cureChaurusQueenGag( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
  	
	If (isInfectedByString( kActor,  "ChaurusQueenGag" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenGag", 0 )
		clearParasiteNPCByString (kActor, "ChaurusQueenGag")
		; fctUtils.ApplyBodyChange( kActor, "FaceHugger", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_gagChaurusQueenInventory,1)
		Endif

		If (kActor == PlayerActor) && !(isInfectedByString( kActor,  "ChaurusQueenGag" ))
		;	ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
		endIf


	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenGag", 0)
	EndIf
EndFunction



;------------------------------------------------------------------------------
Bool Function infectChaurusQueenSkin( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenSkin", 0 )
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenSkin" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif 

	If ( (fctDevious.ActorHasKeywordByString( kActor, "Harness"  )) || (fctDevious.ActorHasKeywordByString( kActor, "Bra"  )))
		Debug.Trace("[SLP]	Already wearing a harness - Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	
	SeedFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
	equipParasiteNPCByString (kActor, "ChaurusQueenSkin")

	Return true ; Return applyChaurusQueenSkin( kActor  )

EndFunction

Bool Function applyChaurusQueenSkin( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
	;	ChaurusQueenInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusQueenSkinInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenSkinInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenSkin", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenSkinDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenSkinInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenSkinInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		; _SLP_GV_numChaurusQueenSkinInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenSkinInfections"))
	endIf

	applyBaseChaurusQueenSkin()

	if (StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")<3)
		StorageUtil.SetIntValue(PlayerActor, "_SLP_iChaurusQueenStage",  3)
	endif

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPChaurusQueenSkinInfection")

	if (!QueenOfChaurusQuest.GetStageDone(300)) && (kActor == PlayerActor)
		QueenOfChaurusQuest.SetStage(300)
	endif
	
	Return True
EndFunction

Function cureChaurusQueenSkin( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "ChaurusQueenSkin" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenSkin", 0 )
		clearParasiteNPCByString (kActor, "ChaurusQueenSkin")
		; fctUtils.ApplyBodyChange( kActor, "ChaurusQueenSkin", "Breast", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxChaurusQueenSkin" ))

		; If (bHarvestParasite)
		;	PlayerActor.AddItem(SLP_harnessChaurusQueenSkinInventory,1)
		; Endif

		; If (kActor == PlayerActor)
		;	ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
		; endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenSkin", 0)
	EndIf
EndFunction


;------------------------------------------------------------------------------
Bool Function infectChaurusQueenArmor( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenArmor", 0 )
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenArmor" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif
 

	If ( (fctDevious.ActorHasKeywordByString( kActor, "Harness"  )) || (fctDevious.ActorHasKeywordByString( kActor, "Bra"  )))
		Debug.Trace("[SLP]	Already wearing a harness- Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	
	SeedFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
	equipParasiteNPCByString (kActor, "ChaurusQueenArmor")

	Return true ; Return applyChaurusQueenArmor( kActor  )

EndFunction

Bool Function applyChaurusQueenArmor( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
		if (QueenOfChaurusQuest.GetStageDone(395)) && (!QueenOfChaurusQuest.GetStageDone(400)) 
			; Do nothing - Queen privileges are suspended
			ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
			fctUtils.removeFromFriendlyFaction( PlayerActor, "Chaurus" )
		else
			ChaurusQueenInfectedAlias.ForceRefTo(PlayerActor)
			fctUtils.addToFriendlyFaction( PlayerActor, "Chaurus" )
		endif
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusQueenArmorInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenArmorInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenArmor", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenArmorDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenArmorInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenArmorInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		; _SLP_GV_numChaurusQueenArmorInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenArmorInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	applyBaseChaurusQueenSkin()

	if (StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")<4)
		StorageUtil.SetIntValue(PlayerActor, "_SLP_iChaurusQueenStage",  4)
	endif

	SendModEvent("SLPChaurusQueenArmorInfection")

	if (!QueenOfChaurusQuest.GetStageDone(350)) && (kActor == PlayerActor)
		QueenOfChaurusQuest.SetStage(350)
	endif
	
	Return True
EndFunction

Function cureChaurusQueenArmor( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "ChaurusQueenArmor" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenArmor", 0 )
		clearParasiteNPCByString (kActor, "ChaurusQueenArmor")
		; fctUtils.ApplyBodyChange( kActor, "ChaurusQueenArmor", "Breast", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxChaurusQueenArmor" ))

		If (bHarvestParasite)
		;	PlayerActor.AddItem(SLP_harnessChaurusQueenArmorInventory,1)
		Endif

		If (kActor == PlayerActor)
			ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
			fctUtils.removeFromFriendlyFaction( PlayerActor, "Chaurus" )
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenArmor", 0)
	EndIf
EndFunction



;------------------------------------------------------------------------------
Bool Function infectChaurusQueenBody( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenBody", 0 )
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenBody" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif 

	If ( (fctDevious.ActorHasKeywordByString( kActor, "Harness"  )) || (fctDevious.ActorHasKeywordByString( kActor, "Bra"  )))
		Debug.Trace("[SLP]	Already wearing a harness- Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	
	SeedFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
	equipParasiteNPCByString (kActor, "ChaurusQueenBody")

	Return true ; Return applyChaurusQueenBody( kActor  )

EndFunction

Bool Function applyChaurusQueenBody( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()
 	ObjectReference PlayerActorRef = PlayerActor as ObjectReference
 	Potion DragonWingsPotion = None 

	If (kActor == PlayerActor)
		if (QueenOfChaurusQuest.GetStageDone(395)) && (!QueenOfChaurusQuest.GetStageDone(400)) 
			; Do nothing - Queen privileges are suspended
			ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
			fctUtils.removeFromFriendlyFaction( PlayerActor, "Chaurus" )
		else
			ChaurusQueenInfectedAlias.ForceRefTo(PlayerActor)
			fctUtils.addToFriendlyFaction( PlayerActor, "Chaurus" )
		endif
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusQueenBodyInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenBodyInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenBody", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenBodyDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenBodyInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenBodyInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		; _SLP_GV_numChaurusQueenBodyInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenBodyInfections"))
	endIf

	applyBaseChaurusQueenSkin()

	debug.trace("[SLP]   Checking for Animated Wings " )
	debug.trace("[SLP]      _SLP_autoRemoveWings: " + StorageUtil.GetIntValue(none, "_SLP_autoRemoveWings" ))
	debug.trace("[SLP]      _SLP_AnimatedWingsEquipped: " + StorageUtil.GetIntValue(none, "_SLP_AnimatedWingsEquipped" ))

	if (StorageUtil.GetIntValue(none, "_SLP_AnimatedWingsEquipped")==0)
		if (StorageUtil.GetIntValue(none, "_SLP_isAnimatedWingsUltimate")==1) 
			DragonWingsPotion = StorageUtil.GetFormValue(none, "_SLS_getAnimatedWingsUltimatePotion") as Potion
			debug.trace("[SLP]   Real Flying Potion: " + DragonWingsPotion)
			PlayerActorRef.AddItem(DragonWingsPotion, 1, true)
			PlayerActor.EquipItem(DragonWingsPotion,abPreventRemoval = false, abSilent = true)
			StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 1 )
			
		elseif (StorageUtil.GetIntValue(none, "_SLP_isRealFlying")==1) 
			DragonWingsPotion = StorageUtil.GetFormValue(none, "_SLS_getRealFlyingPotion") as Potion
			debug.trace("[SLP]   Real Flying Potion: " + DragonWingsPotion)
			PlayerActorRef.AddItem(DragonWingsPotion, 1, true)
			PlayerActor.EquipItem(DragonWingsPotion,abPreventRemoval = false, abSilent = true)
			StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 1 )
			
		elseif (StorageUtil.GetIntValue(none, "_SLP_isAnimatedDragonWings")==1) 
			DragonWingsPotion = StorageUtil.GetFormValue(none, "_SLS_getDragonWingsPotion") as Potion
			debug.trace("[SLP]   Dragon Wings Friendly Potion: " + DragonWingsPotion)
			PlayerActorRef.AddItem(DragonWingsPotion, 1, true)
			PlayerActor.EquipItem(DragonWingsPotion,abPreventRemoval = false, abSilent = true)
			StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 1 )
			
		endif
	endif

	if (StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")<5)
		StorageUtil.SetIntValue(PlayerActor, "_SLP_iChaurusQueenStage",  5)
	endif

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPChaurusQueenBodyInfection")

	if (!QueenOfChaurusQuest.GetStageDone(400)) && (kActor == PlayerActor)
		QueenOfChaurusQuest.SetStage(400)
	endif
	
	Return True
EndFunction

Function cureChaurusQueenBody( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 	ObjectReference PlayerActorRef = PlayerActor as ObjectReference
 	Potion DragonWingsCurePotion = None

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "ChaurusQueenBody" ))
		debug.trace("[SLP]   Checking for Animated Wings " )
		debug.trace("[SLP]      _SLP_autoRemoveWings: " + StorageUtil.GetIntValue(none, "_SLP_autoRemoveWings" ))
		debug.trace("[SLP]      _SLP_AnimatedWingsEquipped: " + StorageUtil.GetIntValue(none, "_SLP_AnimatedWingsEquipped" ))

		if (StorageUtil.GetIntValue(none, "_SLP_autoRemoveWings" )==1) && (StorageUtil.GetIntValue(none, "_SLP_AnimatedWingsEquipped")==1)
			
			debug.trace("[SLP]   Removing Animated Wings " )

			if (StorageUtil.GetIntValue(none, "_SLP_isAnimatedWingsUltimate")==1)
				DragonWingsCurePotion = StorageUtil.GetFormValue(none, "_SLS_getAnimatedWingsUltimateCurePotion") as Potion
				debug.trace("[SLP]   Real Flying Cure Potion: " + DragonWingsCurePotion)
				PlayerActorRef.AddItem(DragonWingsCurePotion, 1, true)
				PlayerActor.EquipItem(DragonWingsCurePotion,abPreventRemoval = false, abSilent = true)
				StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 0 )
				
			elseif (StorageUtil.GetIntValue(none, "_SLP_isRealFlying")==1)
				DragonWingsCurePotion = StorageUtil.GetFormValue(none, "_SLS_getRealFlyingCurePotion") as Potion
				debug.trace("[SLP]   Real Flying Cure Potion: " + DragonWingsCurePotion)
				PlayerActorRef.AddItem(DragonWingsCurePotion, 1, true)
				PlayerActor.EquipItem(DragonWingsCurePotion,abPreventRemoval = false, abSilent = true)
				StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 0 )
				
			elseif (StorageUtil.GetIntValue(none, "_SLP_isAnimatedDragonWings")==1) 
				DragonWingsCurePotion = StorageUtil.GetFormValue(none, "_SLS_getDragonWingsDispelPotion"  ) as Potion
				debug.trace("[SLP]   Dragon Wings Cure Potion: " + DragonWingsCurePotion)
				PlayerActorRef.AddItem(DragonWingsCurePotion, 1, true)
				PlayerActor.EquipItem(DragonWingsCurePotion,abPreventRemoval = false, abSilent = true)
				StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 0 )
				
			endif
		endif

		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenBody", 0 )
		clearParasiteNPCByString (kActor, "ChaurusQueenBody")
		; fctUtils.ApplyBodyChange( kActor, "ChaurusQueenBody", "Breast", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxChaurusQueenBody" ))

		If (bHarvestParasite)
		;	PlayerActor.AddItem(SLP_harnessChaurusQueenBodyInventory,1)
		Endif

		If (kActor == PlayerActor)
			ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
			fctUtils.removeFromFriendlyFaction( PlayerActor, "Chaurus" )
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenBody", 0)
	EndIf
EndFunction


;------------------------------------------------------------------------------
Function displayChaurusSpawnList()
	int valueCount = StorageUtil.FormListCount(none, "_SLP_lChaurusSpawnsList")
	int i = 0
	Form thisActorForm
 
 	debug.trace("[SLP] displayChaurusSpawnList (" + valueCount + " actors)")

	while(i < valueCount)
		thisActorForm = StorageUtil.FormListGet(none, "_SLP_lChaurusSpawnsList", i)

		if (thisActorForm==None)
			Debug.Trace("	Actor [" + i + "] = "+ thisActorForm )
		else
			Debug.Trace("	Actor [" + i + "] = "+ thisActorForm +" - " + thisActorForm.GetName())
		endif

		; if (StorageUtil.FormListFind( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form) <0)
		;	StorageUtil.FormListAdd( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form )
		; endif

		i += 1
	endwhile
EndFunction

Function cleanChaurusSpawnList()
	int valueCount = StorageUtil.FormListCount(none, "_SLP_lChaurusSpawnsList")
	int i = 0
	Form thisActorForm
	Actor thisActor
 	ObjectReference thisActorRef
 
 	debug.trace("[SLP] cleanChaurusSpawnList (" + valueCount + " actors)")

	while(i < valueCount)
		thisActorForm = StorageUtil.FormListGet(none, "_SLP_lChaurusSpawnsList", i)

		if (thisActorForm==None)
			Debug.Trace("	Actor [" + i + "] = "+ thisActorForm )
		else
			Debug.Trace("	Actor [" + i + "] = "+ thisActorForm +" - " + thisActorForm.GetName())

			thisActor = thisActorForm as Actor
			thisActorRef = thisActor as ObjectReference

			if (thisActor.IsDead()) || (thisActorRef.IsDisabled())
				StorageUtil.FormListSet(none, "_SLP_lChaurusSpawnsList", i, None)
			endif
		endif


		; if (StorageUtil.FormListFind( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form) <0)
		;	StorageUtil.FormListAdd( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form )
		; endif

		i += 1
	endwhile

	valueCount = StorageUtil.FormListCount(none, "_SLP_lChaurusSpawnsList")
 	debug.trace("[SLP] cleanChaurusSpawnList (" + valueCount + " actors) after clean up ")

EndFunction


Actor Function getRandomChaurusSpawn(Actor kActor)
	Actor kPlayer = Game.Getplayer()
	ObjectReference kActorRef = kPlayer as ObjectReference
	Actor kChaurusSpawn
	ActorBase ChaurusSpawnActorBase
 	Int iChaurusSpawnLevel
	Int iRandomNum = utility.randomint(0,100)
	ObjectReference arPortal  
    Float afDistance = 150.0
    Float afZOffset = 0.0

	if (iRandomNum>90)
		ChaurusSpawnActorBase = EncChaurusHunterActor.GetBaseObject() as ActorBase
		iChaurusSpawnLevel = 4
	elseif (iRandomNum>60)
		ChaurusSpawnActorBase = EncChaurusSpawnActor.GetBaseObject() as ActorBase
		iChaurusSpawnLevel = 3
	else
		ChaurusSpawnActorBase = EncChaurusFledgelingActor.GetBaseObject() as ActorBase
		iChaurusSpawnLevel = 2
	endif

	arPortal = kActorRef.PlaceAtMe(Game.GetFormFromFile(0x000EBEB5, "Skyrim.ESM")) ; FXNecroTendrilRing 

	arPortal.MoveTo(kActorRef, Math.Sin(kActorRef.GetAngleZ()) * afDistance, Math.Cos(kActorRef.GetAngleZ()) * afDistance, afZOffset)
    SummonSoundFX.Play(kPlayer as ObjectReference)
	Utility.Wait(0.6)

	kChaurusSpawn = kActorRef.PlaceActorAtMe(ChaurusSpawnActorBase, iChaurusSpawnLevel)
	Utility.Wait(0.6)

	arPortal.MoveTo(kActorRef)
	Utility.Wait(0.6)

	arPortal.disable()
	return kChaurusSpawn
EndFunction

Function getRandomChaurusEggs(Actor kActor, int iMinEggs = 0, int iMaxEggs = 20 )
	Int iRandomNum = utility.randomint(iMinEggs,iMaxEggs)

	kActor.AddItem(ChaurusEgg, iRandomNum)
EndFunction



;------------------------------------------------------------------------------
Bool Function isInfectedByString( Actor akActor,  String sParasite  )
	Bool isInfected = False

	; By order of complexity

	if (akActor && sParasite && (StorageUtil.GetIntValue(akActor, "_SLP_toggle" + sParasite)==1) )
		isInfected = True

	elseif (akActor && sParasite && (StorageUtil.GetIntValue(akActor, "_SLP_iHiddenParasite_" + sParasite)==1) )
		isInfected = True

	elseif (akActor && sParasite && akActor.WornHasKeyword(getDeviousKeywordByString(sParasite)) )
		isInfected = True
	Endif

	Return isInfected
EndFunction

Function equipParasiteNPCByString(Actor kActor, String sParasite)
	fctDevious.equipParasiteNPC (kActor, sParasite,getDeviousKeywordByString(sParasite),getParasiteByString(sParasite), getParasiteRenderedByString(sParasite) ) 
EndFunction

Function clearParasiteNPCByString(Actor kActor, String sParasite)
	fctDevious.clearParasiteNPC (kActor, sParasite,getDeviousKeywordByString(sParasite),getParasiteByString(sParasite), true, true)
EndFunction

Bool Function ActorHasKeywordByString(actor akActor, String deviousKeyword = "")
	return libs.ActorHasKeyword(akActor, getDeviousKeywordByString( deviousKeyword ))
EndFunction

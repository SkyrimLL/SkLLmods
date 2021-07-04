Scriptname SLP_fcts_parasiteSprigganRoot extends Quest  

zadLibs Property libs Auto

SLP_fcts_utils Property fctUtils  Auto
SLP_fcts_parasites_devious Property fctDevious  Auto

Quest Property KynesBlessingQuest  Auto 
Quest Property QueenOfChaurusQuest  Auto 

; Using different property names because CK/Skyrim are making tests difficult with baked properties in saved games
Keyword Property _SLP_KW_ParasiteSprigganRootGag Auto  
Keyword Property _SLP_KW_ParasiteSprigganRootArms Auto  
Keyword Property _SLP_KW_ParasiteSprigganRootFeet Auto  
Keyword Property _SLP_KW_ParasiteSprigganRootBody Auto   

Armor Property SLP_plugSprigganRootGagRendered Auto         ; Internal Device
Armor Property SLP_plugSprigganRootGagInventory Auto        	       ; Inventory Device
Armor Property SLP_plugSprigganRootArmsRendered Auto         ; Internal Device
Armor Property SLP_plugSprigganRootArmsInventory Auto        	       ; Inventory Device
Armor Property SLP_plugSprigganRootFeetRendered Auto         ; Internal Device
Armor Property SLP_plugSprigganRootFeetInventory Auto        	       ; Inventory Device
Armor Property SLP_plugSprigganRootBodyRendered Auto         ; Internal Device
Armor Property SLP_plugSprigganRootBodyInventory Auto        	       ; Inventory Device


GlobalVariable Property _SLP_GV_numInfections  Auto 

ReferenceAlias Property SprigganRootInfectedAlias  Auto  
ObjectReference Property DummyAlias  Auto  

SPELL Property SprigganFlare Auto

Sound Property CritterFX  Auto
Sound Property WetFX  Auto

;------------------------------------------------------------------------------
Armor Function getParasiteByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "SprigganRootGag" )  
		thisArmor = SLP_plugSprigganRootGagInventory

	elseif (deviousKeyword == "SprigganRootArms" ) || (deviousKeyword == "SprigganRoot" )    
		thisArmor = SLP_plugSprigganRootArmsInventory

	elseif (deviousKeyword == "SprigganRootFeet" )  
		thisArmor = SLP_plugSprigganRootFeetInventory

	elseif (deviousKeyword == "SprigganRootBody" )  
		thisArmor = SLP_plugSprigganRootBodyInventory

	EndIf

	return thisArmor
EndFunction

Armor Function getParasiteRenderedByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "SprigganRootGag" )  
		thisArmor = SLP_plugSprigganRootGagRendered

	elseif (deviousKeyword == "SprigganRootArms" ) || (deviousKeyword == "SprigganRoot" )  
		thisArmor = SLP_plugSprigganRootArmsRendered

	elseif (deviousKeyword == "SprigganRootFeet" )  
		thisArmor = SLP_plugSprigganRootFeetRendered

	elseif (deviousKeyword == "SprigganRootBody" )  
		thisArmor = SLP_plugSprigganRootBodyRendered
 
	EndIf

	return thisArmor
EndFunction

Keyword Function getDeviousKeywordByString(String deviousKeyword = ""  )
	Keyword thisKeyword = None
  

	if (deviousKeyword == "SprigganRootGag" )   
		thisKeyword = _SLP_KW_ParasiteSprigganRootGag
		
	elseif (deviousKeyword == "SprigganRootArms" ) || (deviousKeyword == "SprigganRoot" )  
		thisKeyword = _SLP_KW_ParasiteSprigganRootArms
		
	elseif (deviousKeyword == "SprigganRootFeet" )  
		thisKeyword = _SLP_KW_ParasiteSprigganRootFeet
		
	elseif (deviousKeyword == "SprigganRootBody" )  
		thisKeyword = _SLP_KW_ParasiteSprigganRootBody
		
	else
		thisKeyword = fctDevious.getDeviousDeviceKeywordByString( deviousKeyword  )
	endIf

	; debug.trace("[SLP] 		thisKeyword: " + thisKeyword)

	return thisKeyword
EndFunction

Function refreshParasite(Actor kActor, String sParasite)
 	Actor PlayerActor = Game.GetPlayer()

	If (sParasite == "SprigganRootGag")
		If (isInfectedByString( kActor,  "SprigganRootGag" )) 
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootGag", 1)
			equipParasiteNPCByString (kActor, "SprigganRootGag")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootGag", 0)
			clearParasiteNPCByString (kActor, "SprigganRootGag")
		Endif

	ElseIf (sParasite == "SprigganRootArms")
		If (isInfectedByString( kActor,  "SprigganRootArms" )) 
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootArms", 1)
			equipParasiteNPCByString (kActor, "SprigganRootArms")


		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootArms", 0)
			clearParasiteNPCByString (kActor, "SprigganRootArms")
		Endif

	ElseIf (sParasite == "SprigganRootFeet")
		If (isInfectedByString( kActor,  "SprigganRootFeet" )) 
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootFeet", 1)
			equipParasiteNPCByString (kActor, "SprigganRootFeet")


		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootFeet", 0)
			clearParasiteNPCByString (kActor, "SprigganRootFeet")
		Endif

	ElseIf (sParasite == "SprigganRootBody")
		If (isInfectedByString( kActor,  "SprigganRootBody" )) 
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootBody", 1)
			equipParasiteNPCByString (kActor, "SprigganRootBody")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootBody", 0)
			clearParasiteNPCByString (kActor, "SprigganRootBody")
		Endif

	Endif

	If (kActor == PlayerActor) && (isInfectedByString(  kActor, "SprigganRoot"  ))
		; Debug.Notification("[SLP]	Spriggan Alias attached")
		Debug.Trace("[SLP]	Spriggan Alias attached")
		SprigganRootInfectedAlias.ForceRefTo(PlayerActor)
	endIf
EndFunction
;------------------------------------------------------------------------------
Bool Function infectSprigganRoot( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()
 	Bool isInfected = false

 	Int iChaurusQueenStage = StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage") 

 	isInfected = infectSprigganRootArms(  kActor  )

	if (iChaurusQueenStage>=1) && (isInfectedByString(  kActor, "SprigganRoot"  ))
		PlayerActor.SendModEvent("SLPCureChaurusQueenGag")
		PlayerActor.SendModEvent("SLPCureChaurusQueenSkin")
		PlayerActor.SendModEvent("SLPCureChaurusQueenArmor")
		PlayerActor.SendModEvent("SLPCureChaurusQueenBody")
	endif

	Return  isInfected
EndFunction

Function cureSprigganRoot( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()

	cureSprigganRootFeet(  kActor  )
	cureSprigganRootBody(  kActor  )
	cureSprigganRootGag(  kActor  )
EndFunction

Function cureSprigganRootAll( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()

	cureSprigganRootArms(  kActor  )
	cureSprigganRootFeet(  kActor  )
	cureSprigganRootBody(  kActor  )
	cureSprigganRootGag(  kActor  )

	utility.wait(2.0)

	If (kActor == PlayerActor) && !(isInfectedByString( kActor,  "SprigganRootGag" )) && !(isInfectedByString( kActor,  "SprigganRootArms" )) && !(isInfectedByString( kActor,  "SprigganRootFeet" )) && !(isInfectedByString( kActor,  "SprigganRootBody" ))
		SprigganRootInfectedAlias.ForceRefTo(DummyAlias)
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRoot", 0 )
	endIf
EndFunction




;------------------------------------------------------------------------------
Bool Function infectSprigganRootArms( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootArms", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSprigganRootArms" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "SprigganRootArms" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (fctDevious.ActorHasKeywordByString( kActor, "ArmCuff"  ))
		Debug.Trace("[SLP]	Already wearing ArmCuffs - Aborting")
		Return False
	Endif

	SprigganFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
	equipParasiteNPCByString (kActor, "SprigganRootArms")

	Return  true; applyFaceHuggerGag( kActor )
EndFunction

Bool Function applySprigganRootArms( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If !StorageUtil.HasIntValue(kActor, "_SLP_iSprigganRootArmsInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootArmsInfections",  0)
	EndIf

	if (!(StorageUtil.GetIntValue(kActor, "_SLP_toggleSprigganRoot") == 1 ))
		; Debug.Notification("[SLP]	Spriggan Infection started")
		Debug.Trace("[SLP]	Spriggan Infection started")
		StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSprigganRootInfections") + 1)
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRoot", 1 )

		If (kActor == PlayerActor)
			; Debug.Notification("[SLP]	Spriggan Alias attached")
			Debug.Trace("[SLP]	Spriggan Alias attached")
			SprigganRootInfectedAlias.ForceRefTo(PlayerActor)
		endIf
	endif

	StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootArms", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootArmsDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1) 
	StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootArmsInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSprigganRootArmsInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		; _SLP_GV_numFaceHuggerInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iSprigganRootArmsInfections"))
	endIf

	; applyBaseChaurusQueenSkin()

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPSprigganRootArmsInfection")

	; if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
	;	KynesBlessingQuest.SetStage(20)
	; endif
	
	Return True
EndFunction

Function cureSprigganRootArms( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
  	
	If (isInfectedByString( kActor,  "SprigganRootArms" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootArms", 0 )
		clearParasiteNPCByString (kActor, "SprigganRootArms")
		; fctUtils.ApplyBodyChange( kActor, "FaceHugger", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ))

		If (bHarvestParasite)
		;	PlayerActor.AddItem(SLP_gagChaurusQueenInventory,1)
		Endif

		If (kActor == PlayerActor) && !(isInfectedByString( kActor,  "SprigganRootArms" ))
		;	ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
		endIf


	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootArms", 0)
	EndIf
EndFunction


;------------------------------------------------------------------------------
Bool Function infectSprigganRootFeet( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootFeet", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSprigganRootFeet" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "SprigganRootFeet" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (fctDevious.ActorHasKeywordByString( kActor, "Boots"  ))
		Debug.Trace("[SLP]	Already wearing a Boots - Aborting")
		Return False
	Endif

	SprigganFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
	equipParasiteNPCByString (kActor, "SprigganRootFeet")

	Return  true; applyFaceHuggerGag( kActor )
EndFunction

Bool Function applySprigganRootFeet( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If !StorageUtil.HasIntValue(kActor, "_SLP_iSprigganRootFeetInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootFeetInfections",  0)
	EndIf

	if (!(StorageUtil.GetIntValue(kActor, "_SLP_toggleSprigganRoot") == 1 ))
		StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSprigganRootInfections") + 1)
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRoot", 1 )

		If (kActor == PlayerActor)
			SprigganRootInfectedAlias.ForceRefTo(PlayerActor)
		endIf
	endif

	StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootFeet", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootFeetDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1) 
	StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootFeetInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSprigganRootFeetInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		; _SLP_GV_numFaceHuggerInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iSprigganRootFeetInfections"))
	endIf

	; applyBaseChaurusQueenSkin()

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPSprigganRootFeetInfection")

	; if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
	;	KynesBlessingQuest.SetStage(20)
	; endif
	
	Return True
EndFunction

Function cureSprigganRootFeet( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
  	
	If (isInfectedByString( kActor,  "SprigganRootFeet" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootFeet", 0 )
		clearParasiteNPCByString (kActor, "SprigganRootFeet")
		; fctUtils.ApplyBodyChange( kActor, "FaceHugger", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ))

		If (bHarvestParasite)
		;	PlayerActor.AddItem(SLP_gagChaurusQueenInventory,1)
		Endif

		If (kActor == PlayerActor) && !(isInfectedByString( kActor,  "SprigganRootFeet" ))
		;	ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
		endIf


	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootFeet", 0)
	EndIf
EndFunction


;------------------------------------------------------------------------------
Bool Function infectSprigganRootBody( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootBody", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSprigganRootBody" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "SprigganRootBody" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (fctDevious.ActorHasKeywordByString( kActor, "Harness"  ))
		Debug.Trace("[SLP]	Already wearing a Harness - Aborting")
		Return False
	Endif

	SprigganFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
	equipParasiteNPCByString (kActor, "SprigganRootBody")

	Return  true; applyFaceHuggerGag( kActor )
EndFunction

Bool Function applySprigganRootBody( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If !StorageUtil.HasIntValue(kActor, "_SLP_iSprigganRootBodyInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootBodyInfections",  0)
	EndIf

	if (!(StorageUtil.GetIntValue(kActor, "_SLP_toggleSprigganRoot") == 1 ))
		StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSprigganRootInfections") + 1)
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRoot", 1 )

		If (kActor == PlayerActor)
			SprigganRootInfectedAlias.ForceRefTo(PlayerActor)
		endIf
	endif

	StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootBody", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootBodyDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1) 
	StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootBodyInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSprigganRootBodyInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		; _SLP_GV_numFaceHuggerInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iSprigganRootBodyInfections"))
	endIf

	; applyBaseChaurusQueenSkin()
	Int iSprigganSkinColor = Math.LeftShift(255, 24) + Math.LeftShift(196, 16) + Math.LeftShift(238, 8) + 218
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", iSprigganSkinColor ) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 0.8 ) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 20.0 ) 
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iForcedHairLoss", 1) 
	PlayerActor.SendModEvent("SLHRefresh")
	PlayerActor.SendModEvent("SLHRefreshColors")

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPSprigganRootBodyInfection")

	; if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
	;	KynesBlessingQuest.SetStage(20)
	; endif
	
	Return True
EndFunction

Function cureSprigganRootBody( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
  	
	If (isInfectedByString( kActor,  "SprigganRootBody" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootBody", 0 )
		clearParasiteNPCByString (kActor, "SprigganRootBody")
		; fctUtils.ApplyBodyChange( kActor, "FaceHugger", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ))

		If (bHarvestParasite)
		;	PlayerActor.AddItem(SLP_gagChaurusQueenInventory,1)
		Endif

		If (kActor == PlayerActor) && !(isInfectedByString( kActor,  "SprigganRootBody" ))
		;	ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
		endIf


	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootBody", 0)
	EndIf
EndFunction


;------------------------------------------------------------------------------
Bool Function infectSprigganRootGag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootGag", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSprigganRootGag" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "SprigganRootGag" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (fctDevious.ActorHasKeywordByString( kActor, "Gag"  ))
		Debug.Trace("[SLP]	Already wearing a gag - Aborting")
		Return False
	Endif

	SprigganFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
	equipParasiteNPCByString (kActor, "SprigganRootGag")

	Return  true; applyFaceHuggerGag( kActor )
EndFunction

Bool Function applySprigganRootGag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()


	If !StorageUtil.HasIntValue(kActor, "_SLP_iSprigganRootGagInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootGagInfections",  0)
	EndIf

	if (!(StorageUtil.GetIntValue(kActor, "_SLP_toggleSprigganRoot") == 1 ))
		StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSprigganRootInfections") + 1)
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRoot", 1 )

		If (kActor == PlayerActor)
			SprigganRootInfectedAlias.ForceRefTo(PlayerActor)
		endIf
	endif

	StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootGag", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootGagDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSprigganRootGagInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSprigganRootGagInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		; _SLP_GV_numFaceHuggerInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iSprigganRootGagInfections"))
	endIf

	; applyBaseChaurusQueenSkin()

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPSprigganRootGagInfection")

	; if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
	;	KynesBlessingQuest.SetStage(20)
	; endif
	
	Return True
EndFunction

Function cureSprigganRootGag( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
  	
	If (isInfectedByString( kActor,  "SprigganRootGag" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootGag", 0 )
		clearParasiteNPCByString (kActor, "SprigganRootGag")
		; fctUtils.ApplyBodyChange( kActor, "FaceHugger", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ))

		If (bHarvestParasite)
		;	PlayerActor.AddItem(SLP_gagChaurusQueenInventory,1)
		Endif

		If (kActor == PlayerActor) && !(isInfectedByString( kActor,  "SprigganRootGag" ))
		;	ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
		endIf


	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSprigganRootGag", 0)
	EndIf
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


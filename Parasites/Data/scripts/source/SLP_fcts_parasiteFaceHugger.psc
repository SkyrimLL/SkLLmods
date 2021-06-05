Scriptname SLP_fcts_parasiteFaceHugger extends Quest  

zadLibs Property libs Auto

SLP_fcts_utils Property fctUtils  Auto
SLP_fcts_parasites_devious Property fctDevious  Auto

Quest Property KynesBlessingQuest  Auto 
Quest Property QueenOfChaurusQuest  Auto 

Keyword Property _SLP_ParasiteFaceHugger  Auto  
Keyword Property _SLP_ParasiteFaceHuggerGag  Auto  

GlobalVariable Property _SLP_GV_numInfections  Auto 
GlobalVariable Property _SLP_GV_numFaceHuggerInfections  Auto 

Armor Property SLP_harnessFaceHuggerRendered Auto         ; Internal Device
Armor Property SLP_harnessFaceHuggerInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessFaceHuggerGagRendered Auto         ; Internal Device
Armor Property SLP_harnessFaceHuggerGagInventory Auto        	       ; Inventory Device

ReferenceAlias Property FaceHuggerInfectedAlias  Auto  
ObjectReference Property DummyAlias  Auto  

Sound Property CritterFX  Auto
Sound Property WetFX  Auto

;------------------------------------------------------------------------------
Armor Function getParasiteByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "FaceHugger" ) 
		thisArmor = SLP_harnessFaceHuggerInventory

	Elseif (deviousKeyword == "FaceHuggerGag" ) 
		thisArmor = SLP_harnessFaceHuggerGagInventory

	EndIf

	return thisArmor
EndFunction

Armor Function getParasiteRenderedByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "FaceHugger" ) 
		thisArmor = SLP_harnessFaceHuggerRendered

	Elseif (deviousKeyword == "FaceHuggerGag" ) 
		thisArmor = SLP_harnessFaceHuggerGagRendered

	EndIf

	return thisArmor
EndFunction

Keyword Function getDeviousKeywordByString(String deviousKeyword = ""  )
	Keyword thisKeyword = None
 
	if (deviousKeyword == "FaceHugger" )  
		thisKeyword = _SLP_ParasiteFaceHugger
		
	elseif (deviousKeyword == "FaceHuggerGag" )  
		thisKeyword = _SLP_ParasiteFaceHuggerGag
		
	else
		thisKeyword = fctDevious.getDeviousDeviceKeywordByString( deviousKeyword  )
	endIf

	return thisKeyword
EndFunction

Bool Function infectFaceHugger( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHugger" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (fctDevious.ActorHasKeywordByString( kActor, "Belt"  )) || (fctDevious.ActorHasKeywordByString( kActor, "Harness"  ))
		Debug.Trace("[SLP]	Already wearing a belt - Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif

	equipParasiteNPCByString (kActor, "FaceHugger")

	Return true ; Return applyFaceHugger( kActor  )
EndFunction

Bool Function applyFaceHugger( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
		FaceHuggerInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iFaceHuggerInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numFaceHuggerInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPFaceHuggerInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureFaceHugger( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "FaceHugger" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 0 )
		clearParasiteNPCByString (kActor, "FaceHugger")
		fctUtils.ApplyBodyChange( kActor, "FaceHugger", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessFaceHuggerInventory,1)
		Endif

		If (kActor == PlayerActor) && !(isInfectedByString( kActor,  "FaceHuggerGag" ))
			FaceHuggerInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 0)
	EndIf
EndFunction

;------------------------------------------------------------------------------
Bool Function infectFaceHuggerGag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHuggerGag" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "FaceHuggerGag" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (fctDevious.ActorHasKeywordByString( kActor, "Gag"  ))
		Debug.Trace("[SLP]	Already wearing a gag - Aborting")
		Return False
	Endif

	equipParasiteNPCByString (kActor, "FaceHuggerGag")

	Return  applyFaceHuggerGag( kActor )
EndFunction

Bool Function applyFaceHuggerGag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
		FaceHuggerInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iFaceHuggerInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerGagDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerGagInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerGagInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numFaceHuggerInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerGagInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPFaceHuggerGagInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureFaceHuggerGag( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
  	
	If (isInfectedByString( kActor,  "FaceHuggerGag" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 0 )
		clearParasiteNPCByString (kActor, "FaceHuggerGag")
		fctUtils.ApplyBodyChange( kActor, "FaceHugger", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessFaceHuggerGagInventory,1)
		Endif

		If (kActor == PlayerActor) && !(isInfectedByString( kActor,  "FaceHugger" ))
			FaceHuggerInfectedAlias.ForceRefTo(DummyAlias)
		endIf


	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 0)
	EndIf
EndFunction

Function refreshParasite(Actor kActor, String sParasite)

	If (sParasite == "FaceHugger")
		If (isInfectedByString( kActor,  "FaceHugger" ))  
			StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 1)
			equipParasiteNPCByString (kActor, "FaceHugger")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 0)
			clearParasiteNPCByString (kActor, "FaceHugger")
		Endif

	ElseIf (sParasite == "FaceHuggerGag")
		If (isInfectedByString( kActor,  "FaceHuggerGag" ))  
			StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 1)
			equipParasiteNPCByString (kActor, "FaceHuggerGag")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 0)
			clearParasiteNPCByString (kActor, "FaceHuggerGag")
		Endif

	Endif

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

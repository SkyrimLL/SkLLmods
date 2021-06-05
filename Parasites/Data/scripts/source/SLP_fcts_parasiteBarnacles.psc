Scriptname SLP_fcts_parasiteBarnacles extends Quest  

zadLibs Property libs Auto

SLP_fcts_utils Property fctUtils  Auto
SLP_fcts_parasites_devious Property fctDevious  Auto

Quest Property KynesBlessingQuest  Auto 
Quest Property QueenOfChaurusQuest  Auto 

Keyword Property _SLP_ParasiteBarnacles  Auto  

GlobalVariable Property _SLP_GV_numInfections  Auto 
GlobalVariable Property _SLP_GV_numBarnaclesInfections  Auto 

Armor Property SLP_harnessBarnaclesRendered Auto         ; Internal Device
Armor Property SLP_harnessBarnaclesInventory Auto        	       ; Inventory Device

ReferenceAlias Property BarnaclesInfectedAlias  Auto  
ObjectReference Property DummyAlias  Auto  

Sound Property WetFX  Auto

;------------------------------------------------------------------------------
Armor Function getParasiteByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "Barnacles" ) 
		thisArmor = SLP_harnessBarnaclesInventory
	EndIf

	return thisArmor
EndFunction

Armor Function getParasiteRenderedByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "Barnacles" ) 
		thisArmor = SLP_harnessBarnaclesRendered
	EndIf

	return thisArmor
EndFunction

Keyword Function getDeviousKeywordByString(String deviousKeyword = ""  )
	Keyword thisKeyword = None
 
	if (deviousKeyword == "Barnacles" )  
		thisKeyword = _SLP_ParasiteBarnacles
		
	else
		thisKeyword = fctDevious.getDeviousDeviceKeywordByString( deviousKeyword  )
	endIf

	return thisKeyword
EndFunction

Bool Function infectBarnacles( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEggBarnacles", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf

	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceBarnacles" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If ((fctDevious.ActorHasKeywordByString( kActor, "Harness"  )) || (fctDevious.ActorHasKeywordByString( kActor, "Corset"  )) )
		Debug.Trace("[SLP]	Already wearing a corset - Aborting")
		Return False
	Endif


	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	

	equipParasiteNPCByString (kActor, "Barnacles")

	Return true ; Return applyBarnacles( kActor  )
EndFunction

Bool Function applyBarnacles( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
		BarnaclesInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iBarnaclesInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iBarnaclesInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleBarnacles", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iBarnaclesDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iBarnaclesInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iBarnaclesInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numBarnaclesInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iBarnaclesInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0) 
 
	SendModEvent("SLPBarnaclesInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif

	Return True
EndFunction

Function cureBarnacles( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
  	

	If (isInfectedByString( kActor,  "Barnacles" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleBarnacles", 0 )
		clearParasiteNPCByString (kActor, "Barnacles")

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessBarnaclesInventory,1)
		Endif

		If (kActor == PlayerActor)
			BarnaclesInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleBarnacles", 0)
	EndIf
EndFunction

Function refreshParasite(Actor kActor, String sParasite)

	If (sParasite == "Barnacles")
		If (isInfectedByString( kActor,  "Barnacles" ))  
			StorageUtil.SetIntValue(kActor, "_SLP_toggleBarnacles", 1)
			equipParasiteNPCByString (kActor, "Barnacles")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleBarnacles", 0)
			clearParasiteNPCByString (kActor, "Barnacles")
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

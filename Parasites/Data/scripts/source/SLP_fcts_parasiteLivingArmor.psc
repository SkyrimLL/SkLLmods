Scriptname SLP_fcts_parasiteLivingArmor extends Quest  

zadLibs Property libs Auto
SLP_fcts_parasites_devious Property fctDevious  Auto

SLP_fcts_utils Property fctUtils  Auto

Quest Property KynesBlessingQuest  Auto 
Quest Property QueenOfChaurusQuest  Auto 

Keyword Property _SLP_ParasiteLivingArmor  Auto  

GlobalVariable Property _SLP_GV_numInfections  Auto 
GlobalVariable Property _SLP_GV_numLivingArmorInfections  Auto 

Armor Property SLP_harnessLivingArmorRendered Auto         ; Internal Device
Armor Property SLP_harnessLivingArmorInventory Auto        	       ; Inventory Device

ReferenceAlias Property LivingArmorInfectedAlias  Auto  
ObjectReference Property DummyAlias  Auto  

Sound Property CritterFX  Auto
Sound Property WetFX  Auto

;------------------------------------------------------------------------------
Armor Function getParasiteByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "LivingArmor" )  
		thisArmor = SLP_harnessLivingArmorInventory

	EndIf

	return thisArmor
EndFunction

Armor Function getParasiteRenderedByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "LivingArmor" )  
		thisArmor = SLP_harnessLivingArmorRendered

	EndIf

	return thisArmor
EndFunction

Keyword Function getDeviousKeywordByString(String deviousKeyword = ""  )
	Keyword thisKeyword = None
 
	if (deviousKeyword == "LivingArmor" )  
		thisKeyword = _SLP_ParasiteLivingArmor
		
	else
		thisKeyword = fctDevious.getDeviousDeviceKeywordByString( deviousKeyword  )
	endIf

	return thisKeyword
EndFunction

Bool Function infectLivingArmor( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleLivingArmor", 0 )
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceLivingArmor" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif 

	If (fctDevious.ActorHasKeywordByString( kActor, "Harness"  ))
		Debug.Trace("[SLP]	Already wearing a corset - Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	

	equipParasiteNPCByString (kActor, "LivingArmor")

	Return true ; Return applyLivingArmor( kActor  )
EndFunction

Bool Function applyLivingArmor( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()
 
	If (kActor == PlayerActor)
		LivingArmorInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iLivingArmorInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iLivingArmorInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleLivingArmor", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iLivingArmorDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iLivingArmorInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iLivingArmorInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numLivingArmorInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iLivingArmorInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPLivingArmorInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureLivingArmor( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "LivingArmor" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleLivingArmor", 0 )
		clearParasiteNPCByString (kActor, "LivingArmor")
		fctUtils.ApplyBodyChange( kActor, "LivingArmor", "Breast", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxLivingArmor" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessLivingArmorInventory,1)
		Endif

		If (kActor == PlayerActor)
			LivingArmorInfectedAlias.ForceRefTo(DummyAlias)
		endIf
	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleLivingArmor", 0)
	EndIf
EndFunction

Function refreshParasite(Actor kActor, String sParasite)

	If (sParasite == "LivingArmor")
		If (isInfectedByString( kActor,  "LivingArmor" )) && (!fctDevious.ActorHasKeywordByString( kActor, "Harness"  )) && (!fctDevious.ActorHasKeywordByString( kActor, "Corset"  ))
			StorageUtil.SetIntValue(kActor, "_SLP_toggleLivingArmor", 1)
			equipParasiteNPCByString (kActor, "LivingArmor")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleLivingArmor", 0)
			clearParasiteNPCByString (kActor, "LivingArmor")
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

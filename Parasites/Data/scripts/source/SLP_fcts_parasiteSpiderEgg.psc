Scriptname SLP_fcts_parasiteSpiderEgg extends Quest  

zadLibs Property libs Auto

SLP_fcts_utils Property fctUtils  Auto
SLP_fcts_parasites_devious Property fctDevious  Auto

Quest Property KynesBlessingQuest  Auto 
Quest Property QueenOfChaurusQuest  Auto 

Keyword Property _SLP_ParasiteSpiderEgg  Auto  
Keyword Property _SLP_ParasiteSpiderPenis  Auto  

GlobalVariable Property _SLP_GV_numInfections  Auto 
GlobalVariable Property _SLP_GV_numSpiderEggInfections  Auto 

Armor Property SLP_plugSpiderEggRendered Auto         ; Internal Device
Armor Property SLP_plugSpiderEggInventory Auto        	       ; Inventory Device
Armor Property SLP_plugSpiderPenisRendered Auto         ; Internal Device
Armor Property SLP_plugSpiderPenisInventory Auto        	       ; Inventory Device

ReferenceAlias Property SpiderEggInfectedAlias  Auto  
ObjectReference Property DummyAlias  Auto  

SPELL Property StomachRot Auto

Sound Property CritterFX  Auto
Sound Property WetFX  Auto

Ingredient  Property SmallSpiderEgg Auto

;------------------------------------------------------------------------------
Armor Function getParasiteByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "SpiderEgg" ) 
		thisArmor = SLP_plugSpiderEggInventory

	Elseif (deviousKeyword == "SpiderPenis" )  
		thisArmor = SLP_plugSpiderPenisInventory

	EndIf

	return thisArmor
EndFunction

Armor Function getParasiteRenderedByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "SpiderEgg" ) 
		thisArmor = SLP_plugSpiderEggRendered

	Elseif (deviousKeyword == "SpiderPenis" )  
		thisArmor = SLP_plugSpiderPenisRendered

	EndIf

	return thisArmor
EndFunction

Keyword Function getDeviousKeywordByString(String deviousKeyword = ""  )
	Keyword thisKeyword = None
 
	if (deviousKeyword == "SpiderEgg" )  
		thisKeyword = _SLP_ParasiteSpiderEgg

	elseif (deviousKeyword == "SpiderPenis" )  
		thisKeyword = _SLP_ParasiteSpiderPenis

	else
		thisKeyword = fctDevious.getDeviousDeviceKeywordByString( deviousKeyword  )

	endIf

	return thisKeyword
EndFunction

Bool Function infectSpiderEgg( Actor kActor )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
 	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "SpiderEgg" ))
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

	equipParasiteNPCByString (kActor, "SpiderEgg")


	Return true ; Return applySpiderEgg( kActor )

EndFunction

Bool Function applySpiderEgg( Actor kActor )
 	Actor PlayerActor = Game.GetPlayer()
  	Int iNumSpiderEggs

	iNumSpiderEggs = Utility.RandomInt(5,10)
	If (StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount")!=0)
		iNumSpiderEggs = StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount")
	Endif

	If (kActor == PlayerActor)
		SpiderEggInfectedAlias.ForceRefTo(PlayerActor)
	endIf
	if (iNumSpiderEggs>=8)
		StomachRot.RemoteCast(kActor as ObjectReference, kActor,kActor as ObjectReference)
	endIf

	fctUtils.ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" ))

	If !StorageUtil.HasIntValue(kActor, "_SLP_iSpiderEggInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numSpiderEggInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)

	SendModEvent("SLPSpiderEggInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureSpiderEgg( Actor kActor, Bool bHarvestParasite = False   )
  	Actor PlayerActor = Game.GetPlayer()
 	Int iNumSpiderEggs
 	Int iNumSpiderEggsRemoved
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf

  	If (isInfectedByString( kActor,  "SpiderPenis" )) 
  		; The spider penis is blocking the eggs
  		return
  	endif
 
	If (isInfectedByString( kActor,  "SpiderEgg" ))
		iNumSpiderEggsRemoved = Utility.RandomInt(2,8)
		iNumSpiderEggs = StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount") - iNumSpiderEggsRemoved

		if (iNumSpiderEggs < 0) || (bHarvestParasite)
			If (kActor == PlayerActor)
				SpiderEggInfectedAlias.ForceRefTo(DummyAlias)
			endIf
			iNumSpiderEggs = 0
			StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", 0 )

			kActor.DispelSpell(StomachRot)

			StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 0)
			clearParasiteNPCByString (kActor, "SpiderEgg")

			If (bHarvestParasite)
				PlayerActor.AddItem(SLP_plugSpiderEggInventory,1)
			else
				PlayerActor.AddItem(SmallSpiderEgg,iNumSpiderEggsRemoved)
			Endif

		else
			debug.notification("Some eggs detached from the cluster... more remain inside you.")
			PlayerActor.AddItem(SmallSpiderEgg,iNumSpiderEggsRemoved)
		Endif

		fctUtils.ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" ) )
 
		StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )
		SendModEvent("SLPSpiderEggInfection")
	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 0)
	EndIf
EndFunction

Function cureSpiderEggAll( Actor kActor, Bool bHarvestParasite = False   )
  	Actor PlayerActor = Game.GetPlayer()
 	Int iNumSpiderEggs
 	Int iNumSpiderEggsRemoved
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf

  	If (isInfectedByString( kActor,  "SpiderPenis" )) 
  		; The spider penis is blocking the eggs
  		return
  	endif
 
	If (isInfectedByString( kActor,  "SpiderEgg" ))
		iNumSpiderEggsRemoved = StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount")
		; iNumSpiderEggs = StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount") - iNumSpiderEggsRemoved


		If (kActor == PlayerActor)
			SpiderEggInfectedAlias.ForceRefTo(DummyAlias)
		endIf

		iNumSpiderEggs = 0
		StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", 0 )

		kActor.DispelSpell(StomachRot)

		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 0)
		clearParasiteNPCByString (kActor, "SpiderEgg")

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_plugSpiderEggInventory,1)
		else
			PlayerActor.AddItem(SmallSpiderEgg,iNumSpiderEggsRemoved)
		Endif


		fctUtils.ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" ) )
 
		StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )
		SendModEvent("SLPSpiderEggInfection")
	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 0)
	EndIf
EndFunction


;------------------------------------------------------------------------------
Bool Function infectSpiderPenis( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderPenis" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "SpiderPenis" )) || (isInfectedByString( kActor,  "ChaurusQueenVag" )) || (isInfectedByString( kActor,  "ChaurusWormVag" )) || (isInfectedByString( kActor,  "SpiderEggs" ))
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
 
	equipParasiteNPCByString (kActor, "SpiderPenis")

	Return true ; Return applySpiderPenis( kActor  )
EndFunction

Bool Function applySpiderPenis( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()
  	Int iNumSpiderEggs

	iNumSpiderEggs = Utility.RandomInt(5,10)

	If (kActor == PlayerActor)
		SpiderEggInfectedAlias.ForceRefTo(PlayerActor)
	endIf
	if (iNumSpiderEggs>=4)
		StomachRot.RemoteCast(kActor as ObjectReference, kActor,kActor as ObjectReference)
	endIf

	fctUtils.ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" ) )

	If !StorageUtil.HasIntValue(kActor, "_SLP_iSpiderEggInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderPenisDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numSpiderEggInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPSpiderEggInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif

	
	Return True
EndFunction

Function cureSpiderPenis( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "SpiderPenis" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 0 )
		clearParasiteNPCByString (kActor, "SpiderPenis")

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_plugSpiderPenisInventory,1)
		Endif

		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 1 )
		equipParasiteNPCByString (kActor, "SpiderEgg")

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 0)
	EndIf
EndFunction

Function refreshParasite(Actor kActor, String sParasite)

	If (sParasite == "SpiderPenis")
		If (isInfectedByString( kActor,  "SpiderPenis" ))  
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 1)
			equipParasiteNPCByString (kActor, "SpiderPenis")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 0)
			clearParasiteNPCByString (kActor, "SpiderPenis")
		Endif

	ElseIf (sParasite == "SpiderEgg")
		If (isInfectedByString( kActor,  "SpiderEgg" ))  
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 1)
			equipParasiteNPCByString (kActor, "SpiderEgg")


		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 0)
			clearParasiteNPCByString (kActor, "SpiderEgg")
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

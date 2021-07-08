Scriptname SLP_fcts_parasiteChaurusWorm extends Quest  

zadLibs Property libs Auto

SLP_fcts_utils Property fctUtils  Auto
SLP_fcts_parasites_devious Property fctDevious  Auto

Quest Property KynesBlessingQuest  Auto 
Quest Property QueenOfChaurusQuest  Auto 

Keyword Property _SLP_ParasiteChaurusWorm  Auto  
Keyword Property _SLP_ParasiteChaurusWormVag Auto  

GlobalVariable Property _SLP_GV_numInfections  Auto 
GlobalVariable Property _SLP_GV_numChaurusWormInfections  Auto 
GlobalVariable Property _SLP_GV_numChaurusWormVagInfections  Auto 

Armor Property SLP_plugChaurusWormRendered Auto         ; Internal Device
Armor Property SLP_plugChaurusWormInventory Auto        	       ; Inventory Device
Armor Property SLP_plugChaurusWormVagRendered Auto         ; Internal Device
Armor Property SLP_plugChaurusWormVagInventory Auto        	       ; Inventory Device

ReferenceAlias Property ChaurusWormInfectedAlias  Auto  
ObjectReference Property DummyAlias  Auto  

Sound Property CritterFX  Auto
Sound Property WetFX  Auto

;------------------------------------------------------------------------------
Armor Function getParasiteByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "ChaurusWorm" )  
		thisArmor = SLP_plugChaurusWormInventory

	Elseif (deviousKeyword == "ChaurusWormVag" ) 
		thisArmor = SLP_plugChaurusWormVagInventory

	EndIf

	return thisArmor
EndFunction

Armor Function getParasiteRenderedByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "ChaurusWorm" )  
		thisArmor = SLP_plugChaurusWormRendered

	Elseif (deviousKeyword == "ChaurusWormVag" ) 
		thisArmor = SLP_plugChaurusWormVagRendered

	EndIf

	return thisArmor
EndFunction

Keyword Function getDeviousKeywordByString(String deviousKeyword = ""  )
	Keyword thisKeyword = None
 
	if (deviousKeyword == "ChaurusWorm" )  
		thisKeyword = _SLP_ParasiteChaurusWorm
		
	elseif (deviousKeyword == "ChaurusWormVag" )  
		thisKeyword = _SLP_ParasiteChaurusWormVag
		
		
	else
		thisKeyword = fctDevious.getDeviousDeviceKeywordByString( deviousKeyword  )
	endIf

	return thisKeyword
EndFunction

Bool Function infectChaurusWorm( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "ChaurusWorm" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (fctDevious.ActorHasKeywordByString( kActor, "PlugAnal"  ))
		Debug.Trace("[SLP]	Already wearing an anal plug - Aborting")
		Return False
	Endif

	equipParasiteNPCByString (kActor, "ChaurusWorm")

	Return true ; Return applyChaurusWorm( kActor  )

EndFunction

Bool Function applyChaurusWorm( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
		ChaurusWormInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	fctUtils.ApplyBodyChange( kActor, "ChaurusWorm", "Butt", 1.5, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusWormInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numChaurusWormInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPChaurusWormInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureChaurusWorm( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "ChaurusWorm" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 0)
		clearParasiteNPCByString (kActor, "ChaurusWorm")
		fctUtils.ApplyBodyChange( kActor, "ChaurusWorm", "Butt", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_plugChaurusWormInventory,1)
		Endif

		If (kActor == PlayerActor)
			ChaurusWormInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 0)
	EndIf
EndFunction

;------------------------------------------------------------------------------
Bool Function infectChaurusWormVag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWormVag", 0 )
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "ChaurusWormVag" ))
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
	
	equipParasiteNPCByString (kActor, "ChaurusWormVag")

	Return true ; Return applyChaurusWormVag( kActor  )

EndFunction

Bool Function applyChaurusWormVag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
		ChaurusWormInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	fctUtils.ApplyBodyChange( kActor, "ChaurusWormVag", "Belly", 1.5, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusWormVagInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormVagInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWormVag", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormVagDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormVagInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormVagInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numChaurusWormVagInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormVagInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPChaurusWormVagInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureChaurusWormVag( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "ChaurusWormVag" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWormVag", 0)
		clearParasiteNPCByString (kActor, "ChaurusWormVag")
		fctUtils.ApplyBodyChange( kActor, "ChaurusWormVag", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_plugChaurusWormVagInventory,1)
		Endif

		If (kActor == PlayerActor)
			ChaurusWormInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWormVag", 0)
	EndIf
EndFunction

Function refreshParasite(Actor kActor, String sParasite)

	If (sParasite == "ChaurusWorm")
		If (isInfectedByString( kActor,  "ChaurusWorm" ))  
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 1)
			equipParasiteNPCByString (kActor, "ChaurusWorm")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 0)
			clearParasiteNPCByString (kActor, "ChaurusWorm")
		Endif

	ElseIf (sParasite == "ChaurusWormVag")
		If (isInfectedByString( kActor,  "ChaurusWormVag" ))  
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWormVag", 1)
			equipParasiteNPCByString (kActor, "ChaurusWormVag")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWormVag", 0)
			clearParasiteNPCByString (kActor, "ChaurusWormVag")
		Endif

	Endif

EndFunction
;------------------------------------------------------------------------------
Bool Function isInfectedByString( Actor akActor,  String sParasite  )
	Bool isInfected = False

	; By order of complexity

	if (akActor && sParasite && (StorageUtil.GetIntValue(akActor, "_SLP_toggle" + sParasite)==1) )
		; debug.trace("[SLP] isInfectedByString: checking storageUtil [_SLP_toggle" + sParasite +"] : " + (StorageUtil.GetIntValue(akActor, "_SLP_toggle" + sParasite)) )
		isInfected = True

	elseif (akActor && sParasite && (StorageUtil.GetIntValue(akActor, "_SLP_iHiddenParasite_" + sParasite)==1) )
		; debug.trace("[SLP] isInfectedByString: checking storageUtil [_SLP_iHiddenParasite_" + sParasite +"] : " + (StorageUtil.GetIntValue(akActor, "_SLP_iHiddenParasite_" + sParasite)) )
		isInfected = True

	elseif (akActor && sParasite && akActor.WornHasKeyword(getDeviousKeywordByString(sParasite)) )
		; debug.trace("[SLP] isInfectedByString: worn keyword: " + akActor.WornHasKeyword(getDeviousKeywordByString(sParasite)) )
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

Scriptname SLP_fcts_parasiteTentacleMonster extends Quest  

zadLibs Property libs Auto

SLP_fcts_utils Property fctUtils  Auto
SLP_fcts_parasites_devious Property fctDevious  Auto

Quest Property KynesBlessingQuest  Auto 
Quest Property QueenOfChaurusQuest  Auto 
Quest Property TentacleMonsterQuest  Auto 

Keyword Property _SLP_ParasiteTentacleMonster  Auto  

GlobalVariable Property _SLP_GV_numInfections  Auto 
GlobalVariable Property _SLP_GV_numTentacleMonsterInfections  Auto 

Armor Property SLP_harnessTentacleMonsterRendered Auto         ; Internal Device
Armor Property SLP_harnessTentacleMonsterInventory Auto        	       ; Inventory Device

ReferenceAlias Property TentacleMonsterInfectedAlias  Auto  
ObjectReference Property DummyAlias  Auto  

Sound Property CritterFX  Auto
Sound Property WetFX  Auto

;------------------------------------------------------------------------------
Armor Function getParasiteByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "TentacleMonster" )
		thisArmor = SLP_harnessTentacleMonsterInventory

	EndIf

	return thisArmor
EndFunction

Armor Function getParasiteRenderedByString(String deviousKeyword = ""  )
	Armor thisArmor = None

	if (deviousKeyword == "TentacleMonster" )
		thisArmor = SLP_harnessTentacleMonsterRendered

	EndIf

	return thisArmor
EndFunction

Keyword Function getDeviousKeywordByString(String deviousKeyword = ""  )
	Keyword thisKeyword = None
 
	if (deviousKeyword == "TentacleMonster" )  
		thisKeyword = _SLP_ParasiteTentacleMonster
		
	else
		thisKeyword = fctDevious.getDeviousDeviceKeywordByString( deviousKeyword  )
	endIf

	return thisKeyword
EndFunction

Bool Function infectTentacleMonster( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	; StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 0 )
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceTentacleMonster" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif 

	If (fctDevious.ActorHasKeywordByString( kActor, "Harness"  ))
		Debug.Trace("[SLP]	Already wearing a harness- Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	
	equipParasiteNPCByString (kActor, "TentacleMonster")

	Return true ; Return applyTentacleMonster( kActor  )

EndFunction

Bool Function applyTentacleMonster( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
		TentacleMonsterInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iTentacleMonsterInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iTentacleMonsterInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iTentacleMonsterDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iTentacleMonsterInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iTentacleMonsterInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numTentacleMonsterInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iTentacleMonsterInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPTentacleMonsterInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureTentacleMonster( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "TentacleMonster" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 0 )
		clearParasiteNPCByString (kActor, "TentacleMonster")
		fctUtils.ApplyBodyChange( kActor, "TentacleMonster", "Breast", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxTentacleMonster" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessTentacleMonsterInventory,1)
		Endif

		If (kActor == PlayerActor)
			TentacleMonsterInfectedAlias.ForceRefTo(DummyAlias)
		endIf

		TentacleMonsterQuest.Stop()

		if (!KynesBlessingQuest.GetStageDone(60)) && (kActor == PlayerActor)
			KynesBlessingQuest.SetStage(60)
		endif

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 0)
	EndIf
EndFunction

Function refreshParasite(Actor kActor, String sParasite)
 	Actor PlayerActor = Game.GetPlayer()

	If (sParasite == "TentacleMonster")
		If (isInfectedByString( kActor,  "TentacleMonster" )) 
			StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 1)
			equipParasiteNPCByString (kActor, "TentacleMonster")

			If (kActor == PlayerActor) 
				; Debug.Notification("[SLP]	Spriggan Alias attached")
				Debug.Trace("[SLP]	TentacleMonster Alias attached")
				TentacleMonsterInfectedAlias.ForceRefTo(PlayerActor)
			endIf
		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 0)
			clearParasiteNPCByString (kActor, "TentacleMonster")

			If (kActor == PlayerActor) 
				; Debug.Notification("[SLP]	Spriggan Alias attached")
				Debug.Trace("[SLP]	TentacleMonster Alias cleared")
				TentacleMonsterInfectedAlias.ForceRefTo(DummyAlias)	
			endif		
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

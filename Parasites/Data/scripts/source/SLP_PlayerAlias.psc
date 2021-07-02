Scriptname SLP_PlayerAlias extends ReferenceAlias  

SexLabFramework     property SexLab Auto
zadLibs Property libs Auto
slaUtilScr Property slaUtil  Auto  

SLP_fcts_parasites Property fctParasites  Auto
SLP_fcts_outfits Property fctOutfits  Auto

ReferenceAlias Property PlayerAlias  Auto  
ReferenceAlias Property SpiderEggInfectedAlias  Auto  
ReferenceAlias Property ChaurusWormInfectedAlias  Auto  
ReferenceAlias Property BarnaclesInfectedAlias  Auto  
ReferenceAlias Property TentacleMonsterInfectedAlias  Auto  
ReferenceAlias Property LivingArmorInfectedAlias  Auto  
ReferenceAlias Property FaceHuggerInfectedAlias  Auto  
ReferenceAlias Property SpiderFollowerAlias  Auto  

Quest Property KynesBlessingQuest  Auto 

GlobalVariable Property _SLP_GV_numInfections  Auto 
GlobalVariable Property _SLP_GV_numSpiderEggInfections  Auto 
GlobalVariable Property _SLP_GV_numChaurusWormInfections  Auto 
GlobalVariable Property _SLP_GV_numChaurusWormVagInfections  Auto 
GlobalVariable Property _SLP_GV_numTentacleMonsterInfections  Auto 
GlobalVariable Property _SLP_GV_numLivingArmorInfections  Auto 
GlobalVariable Property _SLP_GV_numFaceHuggerInfections  Auto 
GlobalVariable Property _SLP_GV_numBarnaclesInfections  Auto 

Faction Property PlayerFollowerFaction Auto


Location Property SLP_BlackreachLocation Auto
Keyword Property SLP_DraugrCryptLocType Auto
Keyword Property SLP_MineLocType Auto
Keyword Property SLP_FalmerHiveLocType Auto
Keyword Property SLP_NordicRuinLocType Auto
Keyword Property SLP_CaveLocType Auto
Keyword Property SLP_DwarvenRuinLocType Auto
Keyword Property SLP_OutdoorLocType Auto

; SPELL Property StomachRot Auto

Container Property EggSac  Auto  

Ingredient  Property GlowingMushroom Auto
Ingredient  Property TrollFat Auto
Ingredient  Property DwarvenOil Auto
Ingredient  Property FireSalts Auto
Ingredient  Property IngredientSpiderEgg Auto
Ingredient  Property IngredientChaurusWorm Auto
Ingredient  Property IngredientChaurusEgg Auto

Potion Property SLP_CritterSemen Auto


int daysPassed
int iGameDateLastCheck = -1
int iDaysSinceLastCheck
int iNextStageTicker = 0

Int iChaurusQueenStage 
Int	iChaurusQueenDate
Int iTickerEventFrequency

Event OnInit()
	_maintenance()

EndEvent

Event OnPlayerLoadGame()
	_maintenance()

EndEvent

Function _maintenance()
 	Actor PlayerActor= Game.GetPlayer() as Actor
 	ActorBase pActorBase = PlayerActor.GetActorBase()
 	iChaurusQueenStage = StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")

	Int iCurrentVersionNumber = 20210630
	Int iVersionNumber = StorageUtil.GetIntValue(none, "_SLP_iParasitesVersion")	
	
	If (iVersionNumber != iCurrentVersionNumber)
		Debug.Notification("[SLH] Upgrading Parasites to " + iCurrentVersionNumber)

		If (iVersionNumber <= 20210531)
			StorageUtil.SetIntValue(PlayerActor, "_SLP_toggleSprigganRootGag", 0 )
			StorageUtil.SetFloatValue(PlayerActor, "_SLP_chanceSprigganRootGag", 10.0 )
			StorageUtil.SetIntValue(PlayerActor, "_SLP_toggleSprigganRootArms", 0 )
			StorageUtil.SetFloatValue(PlayerActor, "_SLP_chanceSprigganRootArms", 20.0 )
			StorageUtil.SetIntValue(PlayerActor, "_SLP_toggleSprigganRootFeet", 0 )
			StorageUtil.SetFloatValue(PlayerActor, "_SLP_chanceSprigganRootFeet", 30.0 )
			StorageUtil.SetIntValue(PlayerActor, "_SLP_toggleSprigganRootBody", 0 )
			StorageUtil.SetFloatValue(PlayerActor, "_SLP_chanceSprigganRootBody", 50.0 )
		Endif
		If (iVersionNumber <= 20210630) 
			StorageUtil.SetFloatValue(PlayerActor, "_SLP_flareDelay", 1.0 )
		endif 
		StorageUtil.SetIntValue(none, "_SLP_iParasitesVersion", iCurrentVersionNumber)	
	Endif

	fctParasites.maintenance() 

	; Set Seed Stone ritual to today if missing
	if (iChaurusQueenStage==1) && (StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenDate")==0)
		StorageUtil.SetIntValue(PlayerActor, "_SLP_iChaurusQueenDate", Game.QueryStat("Days Passed"))
	endif

	if (iChaurusQueenStage>=1)
		if (iChaurusQueenStage>=2)
			StorageUtil.SetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenVag", 100.0 )
		endif
		if (iChaurusQueenStage>=3)
			StorageUtil.SetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenSkin", 100.0 )
		endif
		if (iChaurusQueenStage>=4)
			StorageUtil.SetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenGag", 100.0 )
			StorageUtil.SetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenArmor", 100.0 )
		endif
		if (iChaurusQueenStage>=5)
			StorageUtil.SetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenBody", 100.0 )
		endif
	endif

	; Set flags about known methods to remove parasites
 	StorageUtil.SetIntValue(PlayerActor, "_SLP_iSpiderEggsKnown", KynesBlessingQuest.GetStageDone(30) as Int)
 	StorageUtil.SetIntValue(PlayerActor, "_SLP_iChaurusWormKnown", KynesBlessingQuest.GetStageDone(40) as Int)
 	StorageUtil.SetIntValue(PlayerActor, "_SLP_iHuggersKnown", KynesBlessingQuest.GetStageDone(50) as Int)
 	StorageUtil.SetIntValue(PlayerActor, "_SLP_iTentacleMonsterKnown", KynesBlessingQuest.GetStageDone(60) as Int)
 	StorageUtil.SetIntValue(PlayerActor, "_SLP_iLivingArmorKnown", KynesBlessingQuest.GetStageDone(70) as Int)
 	StorageUtil.SetIntValue(PlayerActor, "_SLP_iBarnaclesKnown", KynesBlessingQuest.GetStageDone(80) as Int)

 	; one time refresh of all parasites and related variables
	refreshAllPArasites(PlayerActor)

	UnregisterForAllModEvents()
	Debug.Trace("SexLab Parasites: Reset SexLab events")
	RegisterForModEvent("HookAnimationStart", "OnSexLabStart")
	RegisterForModEvent("HookAnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("HookOrgasmStart",    "OnSexLabOrgasm")
 	RegisterForModEvent("SexLabOrgasmSeparate",    "OnSexLabOrgasmSeparate")

	RegisterForModEvent("SLPSexCure",   "OnSLPSexCure")
	RegisterForModEvent("SLPFalmerBlue",   "OnSLPFalmerBlue")

	RegisterForModEvent("SDParasiteAn",   "OnSLPInfectSpiderEgg")
	RegisterForModEvent("SDParasiteVag",   "OnSLPInfectChaurusWorm")

	RegisterForModEvent("SLPInfectSpiderEgg",   "OnSLPInfectSpiderEgg")
	RegisterForModEvent("SLPCureSpiderEgg",   "OnSLPCureSpiderEgg")
	RegisterForModEvent("SLPInfectSpiderPenis",   "OnSLPInfectSpiderPenis")
	RegisterForModEvent("SLPCureSpiderPenis",   "OnSLPCureSpiderPenis")
	RegisterForModEvent("SLPInfectChaurusWorm",   "OnSLPInfectChaurusWorm")
	RegisterForModEvent("SLPCureChaurusWorm",   "OnSLPCureChaurusWorm")
	RegisterForModEvent("SLPInfectChaurusWormVag",   "OnSLPInfectChaurusWormVag")
	RegisterForModEvent("SLPCureChaurusWormVag",   "OnSLPCureChaurusWormVag")
	RegisterForModEvent("SLPInfectEstrusTentacles",   "OnSLPInfectEstrusTentacles")
	RegisterForModEvent("SLPInfectTentacleMonster",   "OnSLPInfectTentacleMonster")
	RegisterForModEvent("SLPCureTentacleMonster",   "OnSLPCureTentacleMonster")
	RegisterForModEvent("SLPInfectEstrusSlime",   "OnSLPInfectEstrusSlime")
	RegisterForModEvent("SLPInfectLivingArmor",   "OnSLPInfectLivingArmor")
	RegisterForModEvent("SLPCureLivingArmor",   "OnSLPCureLivingArmor")
	RegisterForModEvent("SLPInfectFaceHugger",   "OnSLPInfectFaceHugger")
	RegisterForModEvent("SLPCureFaceHugger",   "OnSLPCureFaceHugger")
	RegisterForModEvent("SLPInfectFaceHuggerGag",   "OnSLPInfectFaceHuggerGag")
	RegisterForModEvent("SLPCureFaceHuggerGag",   "OnSLPCureFaceHuggerGag")
	RegisterForModEvent("SLPInfectBarnacles",   "OnSLPInfectBarnacles")
	RegisterForModEvent("SLPCureBarnacles",   "OnSLPCureBarnacles")

	RegisterForModEvent("SLPInfectSprigganRoot",   "OnSLPInfectSprigganRoot")
	RegisterForModEvent("SLPCureSprigganRoot",   "OnSLPCureSprigganRoot")
	RegisterForModEvent("SLPInfectSprigganRootGag",   "OnSLPInfectSprigganRootGag")
	RegisterForModEvent("SLPCureSprigganRootGag",   "OnSLPCureSprigganRootGag")
	RegisterForModEvent("SLPInfectSprigganRootArms",   "OnSLPInfectSprigganRootArms")
	RegisterForModEvent("SLPCureSprigganRootArms",   "OnSLPCureSprigganRootArms")
	RegisterForModEvent("SLPInfectSprigganRootFeet",   "OnSLPInfectSprigganRootFeet")
	RegisterForModEvent("SLPCureSprigganRootFeet",   "OnSLPCureSprigganRootFeet")
	RegisterForModEvent("SLPInfectSprigganRootBody",   "OnSLPInfectSprigganRootBody")
	RegisterForModEvent("SLPCureSprigganRootBody",   "OnSLPCureSprigganRootBody")

	RegisterForModEvent("SLPInfectChaurusQueenVag",   "OnSLPInfectChaurusQueenVag")
	RegisterForModEvent("SLPCureChaurusQueenVag",   "OnSLPCureChaurusQueenVag")
	RegisterForModEvent("SLPInfectChaurusQueenGag",   "OnSLPInfectChaurusQueenGag")
	RegisterForModEvent("SLPCureChaurusQueenGag",   "OnSLPCureChaurusQueenGag")
	RegisterForModEvent("SLPInfectChaurusQueenSkin",   "OnSLPInfectChaurusQueenSkin")
	RegisterForModEvent("SLPCureChaurusQueenSkin",   "OnSLPCureChaurusQueenSkin")
	RegisterForModEvent("SLPInfectChaurusQueenArmor",   "OnSLPInfectChaurusQueenArmor")
	RegisterForModEvent("SLPCureChaurusQueenArmor",   "OnSLPCureChaurusQueenArmor")
	RegisterForModEvent("SLPInfectChaurusQueenBody",   "OnSLPInfectChaurusQueenBody")
	RegisterForModEvent("SLPCureChaurusQueenBody",   "OnSLPCureChaurusQueenBody")

	RegisterForModEvent("SLPInfectEstrusChaurusEgg",   "OnSLPInfectEstrusChaurusEgg")
	RegisterForModEvent("SLPTriggerEstrusChaurusBirth",   "OnSLPTriggerEstrusChaurusBirth")
	RegisterForModEvent("SLPTriggerFuroTub",   "OnSLPTriggerFuroTub")

	RegisterForModEvent("ArachnophobiaPlayerCaptured",   "OnArachnophobiaPlayerCaptured")
	RegisterForModEvent("ECBirthStarted",   "OnECBirthCompleted")

	RegisterForModEvent("SLPHideParasite",   "OnSLPHideParasite")
	RegisterForModEvent("SLPShowParasite",   "OnSLPShowParasite")
 
	RegisterForModEvent("SLPRefreshParasites",   "OnSLPRefreshParasites")
	RegisterForModEvent("SLPClearParasites",   "OnSLPClearParasites")

	RegisterForModEvent("SLPRefreshBodyShape",   "OnSLPRefreshBodyShape")

	RegisterForSleep()

	fctOutfits.SetPriestOutfits()

	; Detection of compatible mods
	; Reset first in case some mods have been removed
	StorageUtil.SetIntValue(none, "_SLS_isEstrusChaurusON", 0) 
	StorageUtil.SetIntValue(none, "_SLS_isBeeingFemaleON", 0) 
	StorageUtil.SetIntValue(none, "_SLS_isCagedFollowerON", 0) 
	StorageUtil.SetIntValue(none, "_SLP_isAnimatedDragonWings",  0) 
	StorageUtil.SetIntValue(none, "_SLP_isRealFlying",  0) 
	StorageUtil.SetIntValue(none, "_SLP_isAnimatedWingsUltimate", 0) 

	int idx = Game.GetModCount()
	string modName = ""
	while idx > 0
		idx -= 1
		modName = Game.GetModName(idx)
		if modName == "EstrusChaurus.esp"
			debug.trace("[SLP] 'EstrusChaurus.esp' detected")
			StorageUtil.SetIntValue(none, "_SLS_isEstrusChaurusON",  1) 
			StorageUtil.SetFormValue(none, "_SLS_getEstrusChaurusBreederSpell",  Game.GetFormFromFile(0x00019121, modName)) ; as Spell
			StorageUtil.SetFormValue(none, "_SLS_getEstrusChaurusParasiteEgg",  Game.GetFormFromFile(0x0000EA27, modName)) ; as Ingredient
			debug.trace("[SLP] 		Chaurus Parasite Eggs: " + Game.GetFormFromFile(0x0000EA27, modName))

		elseif modName == "BeeingFemale.esm"
			debug.trace("[SLP] 'BeeingFemale.esm' detected")
			StorageUtil.SetIntValue(none, "_SLS_isBeeingFemaleON",  1) 
			StorageUtil.SetFormValue(none, "_SLS_getBeeingFemalePregnancySpell",  Game.GetFormFromFile(0x000028A0, modName)) ; as Spell

		elseif modName == "CagedFollowers.esp"
			debug.trace("[SLP] 'CagedFollowers.esp' detected")
			StorageUtil.SetIntValue(none, "_SLS_isCagedFollowerON",  1) 
			StorageUtil.SetFormValue(none, "_SLS_getCagedFollowerQuestKeyword",  Game.GetFormFromFile(0x0000184d, modName)) ; as Keyword

		elseif modName == "Animated Dragon Wings.esp"
			debug.trace("[SLP] 'Animated Dragon Wings.esp' detected")
			StorageUtil.SetIntValue(none, "_SLP_isAnimatedDragonWings",  1) 
			debug.trace("[SLP] 		Friendly Wings Potion: " + Game.GetFormFromFile(0x0000388B, modName))
			debug.trace("[SLP] 		Dispel Wings Potion: " + Game.GetFormFromFile(0x000022F5, modName))
			StorageUtil.SetFormValue(none, "_SLS_getDragonWingsPotion",  Game.GetFormFromFile(0x0000388B, modName))  
			StorageUtil.SetFormValue(none, "_SLS_getDragonWingsCurePotion",  Game.GetFormFromFile(0x000022F5, modName))  

		elseif modName == "Real Flying.esp"
			debug.trace("[SLP] 'Real Flying.esp' detected")
			StorageUtil.SetIntValue(none, "_SLP_isRealFlying",  1) 
			debug.trace("[SLP] 		Real Flying Potion: " + Game.GetFormFromFile(0x00000D65, modName))
			debug.trace("[SLP] 		Real Flying Cure Potion: " + Game.GetFormFromFile(0x000022F2, modName))
			StorageUtil.SetFormValue(none, "_SLS_getRealFlyingPotion",  Game.GetFormFromFile(0x00000D65, modName))  
			StorageUtil.SetFormValue(none, "_SLS_getRealFlyingCurePotion",  Game.GetFormFromFile(0x000022F2, modName))  

		elseif modName == "Animated Wings Ultimate.esp"
			debug.trace("[SLP] 'Animated Wings Ultimate.esp' detected")
			StorageUtil.SetIntValue(none, "_SLP_isAnimatedWingsUltimate",  1) 
			debug.trace("[SLP] 		Animated Wings Ultimate Potion: " + Game.GetFormFromFile(0x00000CA2, modName))
			debug.trace("[SLP] 		Animated Wings Ultimate Cure Potion: " + Game.GetFormFromFile(0x00000B21, modName))
			StorageUtil.SetFormValue(none, "_SLS_getAnimatedWingsUltimatePotion",  Game.GetFormFromFile(0x00000CA2, modName))  
			StorageUtil.SetFormValue(none, "_SLS_getAnimatedWingsUltimateCurePotion",  Game.GetFormFromFile(0x00000B21, modName))  
		endif
	endWhile

	RegisterForSingleUpdate(10)
EndFunction

Int Function _getParasiteTickerThreshold(Actor kActor, Int _iNextStageTicker, Int _iParasiteDuration, String sParasite)
	; 1 ticker = 10 seconds realtime
	Float fThreshold = 100.0
	Float fThrottle = (_iNextStageTicker as Float) / 10.0
	Float flareDelay = StorageUtil.GetFloatValue(kActor, "_SLP_flareDelay" ) as Float

	; when flareDelay = 1.0
	; threshold below 100 after 200 ticks (+1 tick for 2 real time seconds - 400 s - about 6 minutes)
	; threshold below 100 immediately 5 days after infection
	fThreshold = (100.0 + (100.0 - ( (_iNextStageTicker as Float) / 2.0)) - ((_iParasiteDuration as Float) * 20.0) ) * flareDelay

	if ( ((fThrottle as Int) * 10) == _iNextStageTicker)
		; debug.notification(".")
		; debug.notification("[SLP] Check parasite event: " + sParasite )
		; debug.notification("[SLP] Chance of parasite event: " + ((100.0 - fThreshold) as Int) )
		debug.trace("[SLP] Check parasite event: " + sParasite + "Chance of trigger: " + ((100.0 - fThreshold) as Int) )
		debug.trace("[SLP]     _iNextStageTicker: " + _iNextStageTicker)
		debug.trace("[SLP]     _iParasiteDuration: " + _iParasiteDuration)
		debug.trace("[SLP]     fThreshold: " + fThreshold)
	else
		; debug.notification(".")
	endif



	return (fThreshold as Int)
EndFunction

Event OnUpdate()
 	Actor PlayerActor= Game.GetPlayer() as Actor
	Location kLocation = PlayerActor.GetCurrentLocation()
 	Int iParasiteDuration
 	Float fValue
 	Bool isWeatherRainy = false

 	daysPassed = Game.QueryStat("Days Passed")

 	; Initial values
 	if (iGameDateLastCheck == -1)
 		iGameDateLastCheck = daysPassed
 	endIf
 
	iDaysSinceLastCheck = (daysPassed - iGameDateLastCheck ) as Int

	If (iDaysSinceLastCheck > 0)
		; New day
		
		If (fctParasites.isInfectedByString( PlayerActor,  "SpiderPenis" ))
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerActor, "_SLP_iSpiderPenisDate")
			; Force at least 5 days with the parasite. Increase chance of expelling parasite each day after 5 days
			If (Utility.RandomInt(0,95) > (100 - (iParasiteDuration / 5) ) )
				if (fctParasites.tryParasiteNextStage(PlayerActor, "SpiderPenis"))
					iNextStageTicker = 0
				endif
			endif

		ElseIf (fctParasites.isInfectedByString( PlayerActor,  "SpiderEgg" ))
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerActor, "_SLP_iSpiderEggDate")
			If (Utility.RandomInt(0,95) > (100 - (iParasiteDuration / 5) ) )
				if (fctParasites.tryParasiteNextStage(PlayerActor, "SpiderEgg"))
					iNextStageTicker = 0
				endif
			endif

		ElseIf (fctParasites.isInfectedByString( PlayerActor,  "ChaurusWorm" ))
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusWormDate")
			If (Utility.RandomInt(0,95) > (100 - (iParasiteDuration / 5) ) )
				if (fctParasites.tryParasiteNextStage(PlayerActor, "ChaurusWorm"))
					iNextStageTicker = 0
				endif
			endif

		ElseIf (fctParasites.isInfectedByString( PlayerActor,  "ChaurusWormVag" ))
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusWormVagDate")
			If (Utility.RandomInt(0,95) > (100 - (iParasiteDuration / 5) ) )
				if (fctParasites.tryParasiteNextStage(PlayerActor, "ChaurusWormVag"))
					iNextStageTicker = 0
				endif
			endif
		Endif

		If (fctParasites.isInfectedByString( PlayerActor,  "TentacleMonster" ))
			iParasiteDuration = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(PlayerActor, "_SLP_iTentacleMonsterDate")
			If (iParasiteDuration < 10)
				Debug.MessageBox("Your breasts grow under the influence of the tentacles.")
				fValue = 1.0 + (iParasiteDuration as Float) / 10.0
				fctParasites.ApplyBodyChange( PlayerActor, "TentacleMonster", "Breast", fValue, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxTentacleMonster" ) )
			endif
			If (iParasiteDuration >= 10) && (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating")!=1)
				StorageUtil.SetIntValue(PlayerActor, "_SLH_iLactating", 1)
				PlayerActor.SendModEvent("_SLSDDi_UpdateCow")
			Endif
		Endif
		If (fctParasites.isInfectedByString( PlayerActor,  "LivingArmor" ))
			iParasiteDuration = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(PlayerActor, "_SLP_iLivingArmorDate")
			If (iParasiteDuration < 10)
				Debug.MessageBox("Your breasts grow under the influence of the tentacles.")
				fValue = 1.0 + (iParasiteDuration as Float) / 10.0
				fctParasites.ApplyBodyChange( PlayerActor, "LivingArmor", "Breast", fValue, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxLivingArmor" ) )
			endif
			If (iParasiteDuration >= 10) && (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating")!=1)
				StorageUtil.SetIntValue(PlayerActor, "_SLH_iLactating", 1)
				PlayerActor.SendModEvent("_SLSDDi_UpdateCow")
			Endif
		Endif

		If (fctParasites.isInfectedByString( PlayerActor,  "FaceHugger" )) || (fctParasites.isInfectedByString( PlayerActor,  "FaceHuggerGag" ))
			iParasiteDuration = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(PlayerActor, "_SLP_iFaceHuggerDate")
			If (iParasiteDuration < 5)
				Debug.MessageBox("Your belly grows as the critter fills it with thick fluids.")
				fValue = 1.0 + (iParasiteDuration as Float) / 5.0
				fctParasites.ApplyBodyChange( PlayerActor, "FaceHugger", "Belly", fValue, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ) )
				PlayerActor.AddItem(SLP_CritterSemen, 2)
				PlayerActor.EquipItem(SLP_CritterSemen, true,true)
				PlayerActor.EquipItem(SLP_CritterSemen, true,true)

			ElseIf (iParasiteDuration >= 5)
				Debug.MessageBox("Your belly suddenly expells copious amounts of thick fluids.")
				StorageUtil.SetIntValue(PlayerActor, "_SLP_iFaceHuggerDate", Game.QueryStat("Days Passed"))
				fValue = 1.0
				fctParasites.ApplyBodyChange( PlayerActor, "FaceHugger", "Belly", fValue, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ) )
				SexLab.AddCum(PlayerActor,  Vaginal = true,  Oral = false,  Anal = true)
			endif
		Endif

		If (fctParasites.isInfectedByString( PlayerActor,  "Barnacles" ))
			iParasiteDuration = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(PlayerActor, "_SLP_iBarnaclesDate")
			If  (iParasiteDuration > 5) && (!kLocation.IsSameLocation(SLP_BlackreachLocation)) && (!kLocation.HasKeyword(SLP_FalmerHiveLocType)) && (!kLocation.HasKeyword(SLP_CaveLocType)) && (!kLocation.HasKeyword(SLP_DwarvenRuinLocType))

	  			fctParasites.tryParasiteNextStage(PlayerActor, "Barnacles")
			endIf
		endif

		; Enable Chaurus Queen flares only if player is not Queen and not infected by Spriggan root
		if (iChaurusQueenStage>=1) && (iChaurusQueenStage<5) && (!(StorageUtil.GetIntValue(PlayerActor, "_SLP_toggleSprigganRoot") == 1 ) )
			;StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenDate")==0
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenDate")
			If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerActor, iNextStageTicker, iParasiteDuration, "ChaurusQueen") )
			 	fctParasites.tryParasiteNextStage(PlayerActor, "ChaurusQueen")
			Endif
		endif

		iNextStageTicker = iNextStageTicker + (iNextStageTicker / 2)
		iGameDateLastCheck = daysPassed

	else
		; updates during the day
		iChaurusQueenStage = StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")
		iChaurusQueenDate = StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenDate")

		; Enable Chaurus Queen flares only if player is not Queen and not infected by Spriggan root
		if (iChaurusQueenStage>=1) && (iChaurusQueenStage<5) && (!(StorageUtil.GetIntValue(PlayerActor, "_SLP_toggleSprigganRoot") == 1 ) )
			;StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenDate")==0
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenDate")
			If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerActor, iNextStageTicker, iParasiteDuration, "ChaurusQueen") )
			 	if (fctParasites.tryParasiteNextStage(PlayerActor, "ChaurusQueen"))
			 		; next stage happened - reset counter
			 		iNextStageTicker = 0
			 	else
			 		; next stage didn't happen - set back counter and try again soon
			 		
			 		if (fctParasites.isPlayerInHeat())
						iNextStageTicker = iNextStageTicker - (iNextStageTicker / 4)
					else
						; reduce frequency of flares if player isn't in heat
						iNextStageTicker = iNextStageTicker - 1
					endif
			 	endif
			 endif
		endif


		; Chance of Living Armor infection when swimming
		if (PlayerActor.IsSwimming()) 
			; debug.notification("Player is swimming...")
			if (StorageUtil.GetIntValue(PlayerActor, "_SLP_lastSwimDate")!= daysPassed)
				; Use date later to trigger 'dry tentacles' effect 
				StorageUtil.SetIntValue(PlayerActor, "_SLP_lastSwimDate", daysPassed)
			endif

			if (!PlayerActor.IsInCombat())
				if (fctParasites.tryPlayerLivingArmor())
					iNextStageTicker = 0
				Endif
			endif

			; Heal while swimming
			if (fctParasites.isInfectedByString( PlayerActor,  "SprigganRoot" )) || (fctParasites.isInfectedByString( PlayerActor,  "LivingArmor" ))
				Float playersHealth = PlayerActor.GetActorValuePercentage("health")
				if (playersHealth < 0.8)  
				  	; Debug.Trace("The player has over half their health left")
					;_SDSP_heal.RemoteCast(kPlayer, kPlayer, kPlayer)
					PlayerActor.resethealthandlimbs()
				endIf
			endif
		endif

		if (iNextStageTicker>0)

			; Chance of Spriggan Root growth when player is wet
			if (fctParasites.isInfectedByString( PlayerActor,  "SprigganRoot" ))
				Weather currentWeather = Weather.GetCurrentWeather()
				if (currentWeather.GetClassification() == 2)
				    isWeatherRainy = true
				endIf

				if (PlayerActor.IsSwimming() || isWeatherRainy) 
					; debug.notification("Player is wet...")
					if (StorageUtil.GetIntValue(PlayerActor, "_SLP_lastWetDate")!= daysPassed)
						StorageUtil.SetIntValue(PlayerActor, "_SLP_lastWetDate", daysPassed)
					endif

					iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerActor, "_SLP_iSprigganRootArmsDate")
					If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerActor, iNextStageTicker, iParasiteDuration, "SprigganRoot") )
						if (fctParasites.tryParasiteNextStage(PlayerActor, "SprigganRoot"))
							iNextStageTicker = 0
						Endif
					endif
				endif
			endif
 
			If (fctParasites.isInfectedByString( PlayerActor,  "SpiderPenis" ))
				iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerActor, "_SLP_iSpiderPenisDate")
				If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerActor, iNextStageTicker, iParasiteDuration, "SpiderPenis") )
					if (fctParasites.tryParasiteNextStage(PlayerActor, "SpiderPenis"))
						iNextStageTicker = 0
					endif
				endif

			ElseIf (fctParasites.isInfectedByString( PlayerActor,  "SpiderEgg" ))
				iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerActor, "_SLP_iSpiderEggDate")
				If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerActor, iNextStageTicker, iParasiteDuration, "SpiderEgg") )
					if (fctParasites.tryParasiteNextStage(PlayerActor, "SpiderEgg"))
						iNextStageTicker = 0
					endif

				endif

			ElseIf (fctParasites.isInfectedByString( PlayerActor,  "ChaurusWorm" )) 
				iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusWormDate")
				If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerActor, iNextStageTicker, iParasiteDuration, "ChaurusWorm") )
					if (fctParasites.tryParasiteNextStage(PlayerActor, "ChaurusWorm"))
						iNextStageTicker = 0
					endif
				endif

			ElseIf (fctParasites.isInfectedByString( PlayerActor,  "ChaurusWormVag" ))
				iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusWormVagDate")
				If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerActor, iNextStageTicker, iParasiteDuration, "ChaurusWormVag") )
					if (fctParasites.tryParasiteNextStage(PlayerActor, "ChaurusWormVag"))
						iNextStageTicker = 0
					endif
				endif 

			ElseIf (fctParasites.isInfectedByString( PlayerActor,  "FaceHugger" ))
				iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerActor, "_SLP_iFaceHuggerDate")
				If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerActor, iNextStageTicker, iParasiteDuration, "FaceHugger") )
					if (fctParasites.tryParasiteNextStage(PlayerActor, "FaceHugger"))
						iNextStageTicker = 0
					endif
				endif 

			ElseIf (fctParasites.isInfectedByString( PlayerActor,  "FaceHuggerGag" ))
				iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerActor, "_SLP_iFaceHuggerGagDate")
				If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerActor, iNextStageTicker, iParasiteDuration, "FaceHuggerGag") )
					if (fctParasites.tryParasiteNextStage(PlayerActor, "FaceHuggerGag"))
						iNextStageTicker = 0
					endif
				endif 

			ElseIf (fctParasites.isInfectedByString( PlayerActor,  "TentacleMonster" ))
				iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerActor, "_SLP_iTentacleMonsterDate")
				If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerActor, iNextStageTicker, iParasiteDuration, "TentacleMonster") )
					if (fctParasites.tryParasiteNextStage(PlayerActor, "TentacleMonster"))
						iNextStageTicker = 0
					endif
				endif
			Endif

		endif

		iNextStageTicker = iNextStageTicker + 1
 
	endIf

	iGameDateLastCheck = daysPassed  

	RegisterForSingleUpdate(10)
EndEvent


Event OnSexLabStart(int threadID, bool HasPlayer)
	If HasPlayer
		Actor PlayerActor= PlayerAlias.GetReference() as Actor
		If (fctParasites.isInfectedByString( PlayerActor,  "SpiderEgg" ))
			slaUtil.UpdateActorExposure(PlayerActor, 2, "Aroused from sex while carrying spider eggs.")
		ElseIf (fctParasites.isInfectedByString( PlayerActor,  "SpiderPenis" ))
			slaUtil.UpdateActorExposure(PlayerActor, 5, "Aroused from sex while carrying spider eggs.")
		ElseIf (fctParasites.isInfectedByString( PlayerActor,  "ChaurusWorm" )) || (fctParasites.isInfectedByString( PlayerActor,  "ChaurusWormVag" ))
			slaUtil.UpdateActorExposure(PlayerActor, 10, "Aroused from sex while carrying chaurus worm.")
		Endif
	endif
EndEvent

Event OnSexLabEnd(int threadID, bool HasPlayer)
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	sslThreadController controller = SexLab.GetController(threadID)
	sslBaseAnimation animation = controller.Animation
	Float fBreastScale
	Float fChanceChaurusWorm
	Float fChanceChaurusWormVag
	Float fChanceSpiderPenis
	Float fChanceSpiderEgg
	Actor kSexPartner

	Actor[] actors = controller.Positions

	If HasPlayer
		Debug.Trace("[SLP] OnSexLabEnd: Player in animation")

		iChaurusQueenStage = StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")
		fChanceChaurusWorm = StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm")
		fChanceChaurusWormVag = StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag")
		fChanceSpiderPenis = StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderPenis")
		fChanceSpiderEgg = StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg")

		If (fctParasites.isInfectedByString(PlayerActor,  "ChaurusQueenVag"))
			; Player is more receptive if the vaginal pincer is extended
			fChanceChaurusWorm = fChanceChaurusWorm + 50.0
			fChanceChaurusWormVag = fChanceChaurusWormVag + 50.0
			fChanceSpiderPenis = 0.0
			fChanceSpiderEgg = fChanceSpiderEgg + 50.0
			debug.Notification("The tentacle retracts inside you.")
			fctParasites.cureParasiteByString(PlayerActor, "ChaurusQueenVag")

		ElseIf (fctParasites.isInfectedByString(PlayerActor, "ChaurusQueenSkin"))
			; Player is more receptive if the breast feelers are extended
			fChanceChaurusWorm = fChanceChaurusWorm + 20.0
			fChanceChaurusWormVag = fChanceChaurusWormVag + 20.0
			fChanceSpiderPenis = 0.0
			fChanceSpiderEgg = fChanceSpiderEgg + 20.0

		elseif (iChaurusQueenStage>=3)
			; Player is a little more receptive if carrying the Seed Stone
			fChanceChaurusWorm = fChanceChaurusWorm + 10.0
			fChanceChaurusWormVag = fChanceChaurusWormVag + 10.0
			fChanceSpiderPenis = fChanceSpiderPenis / 2.0
			fChanceSpiderEgg = fChanceSpiderEgg + 10.0
		endif

		if animation.HasTag("Chaurus")
			; check if player reached the Chaurus stage of the Chaurus Queen tranformation
			fctParasites.tryPlayerChaurusStage()

			If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "PlugAnal"))
				if (Utility.RandomInt(1,100)<= (fChanceChaurusWorm as Int) )
					; PlayerActor.SendModEvent("SLPInfectChaurusWorm")
					if (fctParasites.infectParasiteByString(PlayerActor, "ChaurusWorm"))
						iNextStageTicker = 0
						Debug.MessageBox("You moan helplessly as a thick worm forces itself inside your guts.")
					Endif
				Endif
				if (Utility.RandomInt(1,100)<= (fChanceChaurusWormVag as Int) )
					; PlayerActor.SendModEvent("SLPInfectChaurusWormVag")
					if (fctParasites.infectParasiteByString(PlayerActor, "ChaurusWormVag"))
						iNextStageTicker = 0
						Debug.MessageBox("You shudder deeply as a squirming worm forces itself inside your womb.")
					Endif
				Endif
			EndIf

		EndIf
		if animation.HasTag("Spider")
			If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "PlugVaginal"))
				fctParasites.tryPlayerSpiderStage()

				if (Utility.RandomInt(1,100)<= (fChanceSpiderPenis as Int) )
					if (fctParasites.infectParasiteByString(PlayerActor, "SpiderPenis"))
						iNextStageTicker = 0
						kSexPartner = _firstNotPlayer(actors)
						SpiderFollowerAlias.ForceRefTo(kSexPartner)
						Debug.MessageBox("You gasp as the spider fills your womb with a string of slimy eggs. Unfortunately, the penis of the spider remains firmly lodged inside you after the act.")
					Endif
				elseif (Utility.RandomInt(1,100)<= (fChanceSpiderEgg as Int) )
					if (fctParasites.infectParasiteByString(PlayerActor, "SpiderEgg"))
						iNextStageTicker = 0
						Debug.MessageBox("You gasp as the spider fills your womb with a string of slimy eggs.")
					Endif
				endif
			EndIf
		EndIf
	Endif

	int idx = 0
	while idx < actors.Length
		if (actors[idx] != PlayerActor) && (actors[idx].IsInFaction(PlayerFollowerFaction))
			Debug.Trace("[SLP] Checking follower for parasites")
			if animation.HasTag("Chaurus")
				If (!fctParasites.ActorHasKeywordByString(actors[idx], "Belt")) && (!fctParasites.ActorHasKeywordByString(actors[idx], "PlugAnal"))
					if (Utility.RandomInt(1,100)< (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" ) as Int) )
						; actors[idx].SendModEvent("SLPInfectChaurusWorm")
						fctParasites.infectParasiteByString(actors[idx], "ChaurusWorm")
					Endif
					if (Utility.RandomInt(1,100)< (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" ) as Int) )
						; actors[idx].SendModEvent("SLPInfectChaurusWormVag")
						fctParasites.infectParasiteByString(actors[idx], "ChaurusWormVag")
					Endif
				EndIf
			EndIf
			if animation.HasTag("Spider")
				If (!fctParasites.ActorHasKeywordByString(actors[idx], "Belt")) && (!fctParasites.ActorHasKeywordByString(actors[idx], "PlugVaginal"))
					if (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderPenis" ) as Int) )
						; actors[idx].SendModEvent("SLPInfectSpiderPenis")
						fctParasites.infectParasiteByString(actors[idx], "SpiderPenis")
					elseif (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) as Int) )
						; actors[idx].SendModEvent("SLPInfectSpiderEgg")
						fctParasites.infectParasiteByString(actors[idx], "SpiderEgg")
					endif
				EndIf
			EndIf
		endIf
		idx += 1
	endwhile
EndEvent

Event OnSexLabOrgasm(int threadID, bool HasPlayer)
	Actor PlayerActor = PlayerAlias.GetReference() as Actor
	sslThreadController controller = SexLab.GetController(threadID)
	sslBaseAnimation animation = controller.Animation

	Actor[] actors = controller.Positions

	if HasPlayer
		if animation.HasTag("Spider")
			if (fctParasites.isInfectedByString(PlayerActor, "SpiderEgg" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) / 4))
				Debug.MessageBox("As you lay on the floor, still panting, you realize the spider extracted the fertilized eggs out of your exhausted body.")
				; PlayerActor.SendModEvent("SLPCureSpiderEgg","All")
				fctParasites.cureParasiteByString(PlayerActor, "SpiderEgg", "All" )
				PlayerActor.PlaceAtMe(EggSac)
			endIf
		EndIf

		If (fctParasites.isInfectedByString( PlayerActor, "ChaurusWorm" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" ) / 5))
			Debug.MessageBox("The power of your orgasm is enough to expel the worm from your bowels, making you nearly black out from the added stimulation.")
			; PlayerActor.SendModEvent("SLPCureChaurusWorm")
			fctParasites.cureParasiteByString(PlayerActor, "ChaurusWorm")
		EndIf
		If (fctParasites.isInfectedByString( PlayerActor, "ChaurusWormVag" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" ) / 5))
			Debug.MessageBox("The power of your orgasm is enough to expel the worm, making you nearly black out from the added stimulation.")
			; PlayerActor.SendModEvent("SLPCureChaurusWormVag")
			fctParasites.cureParasiteByString(PlayerActor, "ChaurusWormVag")
		EndIf
	endif

	int idx = 0
	while idx < actors.Length
		if (actors[idx] != PlayerActor)
			if animation.HasTag("Spider")
				if (fctParasites.isInfectedByString( actors[idx],  "SpiderEgg" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) / 4))
					; actors[idx].SendModEvent("SLPCureSpiderEgg","All")
					fctParasites.cureParasiteByString( actors[idx], "SpiderEgg", "All" )
					actors[idx].PlaceAtMe(EggSac)
				endIf
			endif

			If (fctParasites.isInfectedByString( actors[idx], "ChaurusWorm" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" ) / 5))
				; actors[idx].SendModEvent("SLPCureChaurusWorm")
				fctParasites.cureParasiteByString( actors[idx], "ChaurusWorm")
			EndIf
			If (fctParasites.isInfectedByString(actors[idx], "ChaurusWormVag" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" ) / 5))
				; actors[idx].SendModEvent("SLPCureChaurusWormVag")
				fctParasites.cureParasiteByString( actors[idx], "ChaurusWormVag")
			EndIf
		endIf
		idx += 1
	endwhile
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int Thread)
	Actor kActor = ActorRef as actor
	Actor PlayerActor = PlayerAlias.GetReference() as Actor
	sslBaseAnimation animation = SexLab.GetController(Thread).Animation

	if kActor == PlayerActor
		if animation.HasTag("Spider")
			if (fctParasites.isInfectedByString( PlayerActor, "SpiderEgg" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) / 4))
				Debug.MessageBox("As you lay on the floor, still panting, you realize the spider extracted the fertilized eggs out of your exhausted body.")
				; PlayerActor.SendModEvent("SLPCureSpiderEgg","All")
				fctParasites.cureParasiteByString( PlayerActor, "SpiderEgg", "All" )
				PlayerActor.PlaceAtMe(EggSac)
			endIf
		EndIf

		If (fctParasites.isInfectedByString( PlayerActor, "ChaurusWorm" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" ) / 5))
			Debug.MessageBox("The power of your orgasm is enough to expel the worm from your bowels, making you nearly black out from the added stimulation.")
			; PlayerActor.SendModEvent("SLPCureChaurusWorm")
			fctParasites.cureParasiteByString(PlayerActor, "ChaurusWorm")
		EndIf
		If (fctParasites.isInfectedByString( PlayerActor, "ChaurusWormVag" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" ) / 5))
			Debug.MessageBox("The power of your orgasm is enough to expel the worm, making you nearly black out from the added stimulation.")
			; PlayerActor.SendModEvent("SLPCureChaurusWormVag")
			fctParasites.cureParasiteByString(PlayerActor, "ChaurusWormVag")
		EndIf
	Else
		if animation.HasTag("Spider")
			if (fctParasites.isInfectedByString( kActor, "SpiderEgg" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) / 4))
				; kActor.SendModEvent("SLPCureSpiderEgg","All")
				fctParasites.cureParasiteByString(kActor, "SpiderEgg")
				kActor.PlaceAtMe(EggSac)
			endIf
		endif

		If (fctParasites.isInfectedByString( kActor, "ChaurusWorm" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" ) / 5))
			; kActor.SendModEvent("SLPCureChaurusWorm")
			fctParasites.cureParasiteByString(kActor, "ChaurusWorm")
		EndIf
		If (fctParasites.isInfectedByString( kActor, "ChaurusWormVag" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" ) / 5))
			; kActor.SendModEvent("SLPCureChaurusWormVag")
			fctParasites.cureParasiteByString(kActor, "ChaurusWormVag")
		EndIf
	endIf
EndEvent

Event OnArachnophobiaPlayerCaptured(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()

 	PlayerActor.SendModEvent("PCSubFree")

	If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "PlugVaginal"))

		if (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderPenis" ) as Int) )
			; PlayerActor.SendModEvent("SLPInfectSpiderPenis")
			fctParasites.infectParasiteByString(PlayerActor, "SpiderPenis")

		elseif (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) as Int) )
			; PlayerActor.SendModEvent("SLPInfectSpiderEgg")
			fctParasites.infectParasiteByString(PlayerActor, "SpiderEgg")
		endif
	EndIf
EndEvent

Event OnECBirthCompleted(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()


	If ( (fctParasites.isInfectedByString( kActor,  "ChaurusWorm" )) || (fctParasites.isInfectedByString( kActor,  "ChaurusWormVag" )) )
		Debug.MessageBox("The excruciating contractions expelling the eggs out of your body push out your chaurus worms as well.")

		fctParasites.cureParasiteByString(kActor, "ChaurusWorm")
		fctParasites.cureParasiteByString(kActor, "ChaurusWormVag")
	Endif

EndEvent
;------------------------------------------------------------------------------
Event OnSLPInfectSpiderEgg(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'infect spider egg' event - Actor: " + kActor)

	ActorBase pActorBase = kActor.GetActorBase()

	if (pActorBase.GetSex()==0)
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "SpiderEgg")
	
EndEvent

Event OnSLPCureSpiderEgg(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure spider egg' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "SpiderEgg", _args )
	
EndEvent


;------------------------------------------------------------------------------
Event OnSLPInfectSpiderPenis(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'infect spider penis' event - Actor: " + kActor)

	ActorBase pActorBase = kActor.GetActorBase()

	if (pActorBase.GetSex()==0)
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "SpiderPenis")

	
EndEvent

Event OnSLPCureSpiderPenis(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'cure spider penis' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "SpiderPenis", _args )
	
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectChaurusWorm(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()
 
 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'infect chaurus worm' event - Actor: " + kActor)

	fctParasites.infectParasiteByString(kActor, "ChaurusWorm")
	
EndEvent

Event OnSLPCureChaurusWorm(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus worm' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "ChaurusWorm", _args )

EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectChaurusWormVag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect chaurus worm vaginal' event - Actor: " + kActor)

	ActorBase pActorBase = kActor.GetActorBase()

	if (pActorBase.GetSex()==0)
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "ChaurusWormVag")
	
	
EndEvent

Event OnSLPCureChaurusWormVag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus worm vaginal' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "ChaurusWormVag", _args )


EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectEstrusTentacles(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'infect estrus tentacle' event - Actor: " + kActor)
	
	fctParasites.infectParasiteByString(kActor, "EstrusTentacles")
	
EndEvent

Event OnSLPInfectTentacleMonster(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect tentacle monster' event - Actor: " + kActor)

	ActorBase pActorBase = kActor.GetActorBase()

	if (pActorBase.GetSex()==0)
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "TentacleMonster")
	
EndEvent

Event OnSLPCureTentacleMonster(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'cure tentacle monster' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "TentacleMonster", _args )

EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectEstrusSlime(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'infect estrus slime' event - Actor: " + kActor)

	fctParasites.infectParasiteByString(kActor, "EstrusSlime")
	
EndEvent

Event OnSLPInfectLivingArmor(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect living armor' event - Actor: " + kActor)

	ActorBase pActorBase = kActor.GetActorBase()

	if (pActorBase.GetSex()==0)
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "LivingArmor")
	
EndEvent

Event OnSLPCureLivingArmor(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'cure living armor' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "LivingArmor", _args )

EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectFaceHugger(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect face hugger' event - Actor: " + kActor)

	ActorBase pActorBase = kActor.GetActorBase()

	if (pActorBase.GetSex()==0)
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "FaceHugger")
	
EndEvent

Event OnSLPCureFaceHugger(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'cure face hugger' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "FaceHugger", _args )

EndEvent

Event OnSLPInfectFaceHuggerGag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	
 
	Debug.Trace("[SLP] Receiving 'infect face hugger (gag)' event - Actor: " + kActor)

	fctParasites.infectParasiteByString(kActor, "FaceHuggerGag")
	
EndEvent

Event OnSLPCureFaceHuggerGag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'cure face hugger (gag)' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "FaceHuggerGag", _args )

EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectBarnacles(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
   	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'infect barnacles' event - Actor: " + kActor)

	ActorBase pActorBase = kActor.GetActorBase()

	if (pActorBase.GetSex()==0)
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "Barnacles")
	
EndEvent

Event OnSLPCureBarnacles(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'cure barnacles' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "Barnacles", _args )


EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectSprigganRoot(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
   	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'infect SprigganRoot' event - Actor: " + kActor)

	fctParasites.infectParasiteByString(kActor, "SprigganRoot")
	
EndEvent

Event OnSLPCureSprigganRoot(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'cure SprigganRoot' event - Actor: " + kActor)

	if (_args == "All")
		fctParasites.cureParasiteByString(kActor, "SprigganRootAll", _args )
	else
		fctParasites.cureParasiteByString(kActor, "SprigganRoot", _args )
	endif


EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectSprigganRootGag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
   	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'infect SprigganRootGag' event - Actor: " + kActor)

	fctParasites.infectParasiteByString(kActor, "SprigganRootGag")
	
EndEvent

Event OnSLPCureSprigganRootGag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'cure SprigganRootGag' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "SprigganRootGag", _args )


EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectSprigganRootArms(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
   	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'infect SprigganRootArms' event - Actor: " + kActor)

	fctParasites.infectParasiteByString(kActor, "SprigganRootArms")
	
EndEvent

Event OnSLPCureSprigganRootArms(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'cure SprigganRootArms' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "SprigganRootArms", _args )


EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectSprigganRootFeet(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
   	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'infect SprigganRootFeet' event - Actor: " + kActor)

	fctParasites.infectParasiteByString(kActor, "SprigganRootFeet")
	
EndEvent

Event OnSLPCureSprigganRootFeet(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'cure SprigganRootFeet' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "SprigganRootFeet", _args )


EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectSprigganRootBody(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
   	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'infect SprigganRootBody' event - Actor: " + kActor)

	fctParasites.infectParasiteByString(kActor, "SprigganRootBody")
	
EndEvent

Event OnSLPCureSprigganRootBody(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'cure SprigganRootBody' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "SprigganRootBody", _args )


EndEvent



;------------------------------------------------------------------------------
Event OnSLPInfectChaurusQueenVag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect chaurus queen vaginal' event - Actor: " + kActor)

	ActorBase pActorBase = kActor.GetActorBase()

	if (pActorBase.GetSex()==0)
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "ChaurusQueenVag")
	
EndEvent

Event OnSLPCureChaurusQueenVag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen vaginal' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "ChaurusQueenVag", _args )

EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectChaurusQueenGag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect chaurus queen mask' event - Actor: " + kActor)

	ActorBase pActorBase = kActor.GetActorBase()

	if (pActorBase.GetSex()==0)
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "ChaurusQueenGag")
	
EndEvent

Event OnSLPCureChaurusQueenGag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen mask' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "ChaurusQueenGag", _args )

EndEvent


;------------------------------------------------------------------------------
Event OnSLPInfectChaurusQueenSkin(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect chaurus queen skin' event - Actor: " + kActor)

	ActorBase pActorBase = kActor.GetActorBase()

	if (pActorBase.GetSex()==0)
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "ChaurusQueenSkin")
	
EndEvent

Event OnSLPCureChaurusQueenSkin(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen skin' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "ChaurusQueenSkin", _args )

EndEvent


;------------------------------------------------------------------------------
Event OnSLPInfectChaurusQueenArmor(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect chaurus queen armor' event - Actor: " + kActor)

	ActorBase pActorBase = kActor.GetActorBase()

	if (pActorBase.GetSex()==0)
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "ChaurusQueenArmor")
	
EndEvent

Event OnSLPCureChaurusQueenArmor(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen armor' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "ChaurusQueenArmor", _args )

EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectChaurusQueenBody(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect chaurus queen body' event - Actor: " + kActor)

	ActorBase pActorBase = kActor.GetActorBase()

	if (pActorBase.GetSex()==0)
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "ChaurusQueenBody")
	
EndEvent

Event OnSLPCureChaurusQueenBody(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen body' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "ChaurusQueenBody", _args )

EndEvent
;------------------------------------------------------------------------------
Event OnSLPInfectEstrusChaurusEgg(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()
  	Bool bSilent = false

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	
 	if (_argc==1.0)
 		bSilent = true
 	endif

	Debug.Trace("[SLP] Receiving 'infect estrus chaurus egg' event - Actor: " + kActor)

	ActorBase pActorBase = kActor.GetActorBase()

	if (pActorBase.GetSex()==0)
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "ChaurusEggSilent"  )
	
EndEvent

;------------------------------------------------------------------------------
Event OnSLPTriggerEstrusChaurusBirth(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()
 	String sParasite = _args
 	Int iBirthItemCount = _argc as Int

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

 	; (sParasite == "SpiderEgg")
	; (sParasite == "Barnacles")
	
	Debug.Trace("[SLP] Receiving 'trigger estrus chaurus birth' event - Actor: " + kActor)

	fctParasites.triggerEstrusChaurusBirth( kActor, sParasite, iBirthItemCount )
	
EndEvent

;------------------------------------------------------------------------------
Event OnSLPTriggerFuroTub(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()
 	String sParasite = _args
 	Int iBirthItemCount = _argc as Int

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

 	; (sParasite == "SpiderEgg")
	; (sParasite == "Barnacles")
	
	Debug.Trace("[SLP] Receiving 'trigger furo tub' event - Actor: " + PlayerActor)

	fctParasites.triggerFuroTub( PlayerActor, "" )
	
EndEvent
;------------------------------------------------------------------------------
Event OnSLPSexCure(String _eventName, String _args, Float _argc = 0.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer() as Actor
 	String sParasite = _args
 	String sTags 
 	Bool bIsPlayerHealer = _argc as Bool
 	Bool bHarvestParasite = False

 	If (kActor == None)
 		kActor = kPlayer
 	Endif

 	if (kActor == kPlayer) && (sParasite == "")
	 	If (fctParasites.isInfectedByString( kPlayer,  "SpiderEgg" ))  
			sParasite = "SpiderEgg"

		ElseIf (fctParasites.isInfectedByString( kPlayer,  "ChaurusWorm" ))
			sParasite = "ChaurusWorm"

		ElseIf (fctParasites.isInfectedByString( kPlayer,  "ChaurusWormVag" ))
			sParasite = "ChaurusWormVag"

		ElseIf (fctParasites.isInfectedByString( kPlayer,  "FaceHugger" ))
			sParasite = "FaceHugger"

		ElseIf (fctParasites.isInfectedByString( kPlayer,  "FaceHuggerGag" ))
			sParasite = "FaceHuggerGag"

		EndIf
 	endif

 	; if (KynesBlessingQuest.GetStageDone(22))
	if (kPlayer.GetItemCount(GlowingMushroom) != 0) ; && (Utility.RandomInt(0,100) <= (30 + StorageUtil.GetIntValue(kPlayer, "_SLP_iInfections") * 5) ) )
		   	bHarvestParasite = True
		   	kPlayer.RemoveItem(GlowingMushroom,1)
	endIf	
	; Endif

	; Add removal of ingredients if player is self removing

 	If (sParasite == "SpiderEgg")
		if (kPlayer.GetItemCount(DwarvenOil) == 0)
			Debug.Messagebox("Your attempt at removing the eggs is pointless without Dwarven Oil")
			return
		endif

 		sTags = "Fisting"
 		kPlayer.RemoveItem(DwarvenOil,1)

 	ElseIf (sParasite == "ChaurusWorm")
		if (kPlayer.GetItemCount(TrollFat) == 0)
			Debug.Messagebox("You can't possibly remove the worm without Troll fat")
			return
		endif

 		sTags = "Anal"
 		kPlayer.RemoveItem(TrollFat,1)

 	ElseIf (sParasite == "ChaurusWormVag")
		if (kPlayer.GetItemCount(TrollFat) == 0)
			Debug.Messagebox("You can't possibly remove the worm without Troll fat")
			return
		endif

 		sTags = "Vaginal"
 		kPlayer.RemoveItem(TrollFat,1)

 	ElseIf (sParasite == "FaceHugger")
		if (kPlayer.GetItemCount(FireSalts) == 0)
			Debug.Messagebox("The Hip Hugger will never let go without Fire Salts")
			return
		endif

 		sTags = "Anal"
 		kPlayer.RemoveItem(FireSalts,1)

 	ElseIf (sParasite == "FaceHuggerGag")
		if (kPlayer.GetItemCount(FireSalts) == 0)
			Debug.Messagebox("The Face Hugger will never let go without Fire Salts")
			return
		endif

 		sTags = "Oral"
 		kPlayer.RemoveItem(FireSalts,1)

 	ElseIf (sParasite != "")
		sTags = sParasite
 	Else
		sTags = "Sex"
  	endif

	Debug.Trace("[SLP] Parasite cure scene")

	if (kActor != kPlayer)
		; player removing parasite from actor
		If  (SexLab.ValidateActor( kPlayer ) > 0) &&  (SexLab.ValidateActor(kActor) > 0) 
			actor[] sexActors = new actor[2]
			If (bIsPlayerHealer)
				sexActors[0] = kActor
				sexActors[1] = kPlayer
			else
				sexActors[0] = kPlayer
				sexActors[1] = kActor
			endif

			sslBaseAnimation[] anims
			anims = SexLab.GetAnimationsByTags(2, sTags,"Estrus,Dwemer")

			If (anims && anims.Length > 0)
				SexLab.StartSex(sexActors, anims)
			endif
		Else
			Debug.Trace("[SLP] Actors not ready - skipping parasite cure sex scene")
		EndIf
	else
		; player removing parasite from themselves
		If  (SexLab.ValidateActor( kPlayer ) > 0) 
			bIsPlayerHealer = True

			actor[] sexActors = new actor[1]
			sexActors[0] = kPlayer

			sslBaseAnimation[] anims
			anims = SexLab.GetAnimationsByTags(1, sTags,"Estrus,Dwemer")

			If (anims && anims.Length > 0)
				SexLab.StartSex(sexActors, anims)
			endif
		Else
			Debug.Trace("[SLP] Player Actor not ready - skipping parasite cure sex scene")
		EndIf
	endif


	If (!bIsPlayerHealer)
		; kActor = kPlayer
		Debug.Trace("[SLP]  	Player is the patient")
		_afterSexCure( kPlayer, sParasite, bIsPlayerHealer, bHarvestParasite) 

		If (kActor != kPlayer) && (sParasite == "TentacleMonster")
			; Special case - if player 'removes' tentacle monster with someone else, parasite is transfered to new host
			Debug.Notification("The creature slides into a new host.")
			SexLab.AddCum(kActor,  Vaginal = true,  Oral = false,  Anal = true)
			fctParasites.infectParasiteByString(kActor, "TentacleMonster")
		endif
	Else
		Debug.Trace("[SLP]  	Player is the healer")
		_afterSexCure( kActor, sParasite, bIsPlayerHealer, bHarvestParasite) 
	Endif



EndEvent

Function _afterSexCure(Actor kActor, String sParasite, Bool bIsPlayerHealer, Bool bHarvestParasite) 
 	Actor kPlayer = Game.GetPlayer() as Actor
	Debug.Trace("[SLP]  	Curing from: " + sParasite)
	Debug.Trace("[SLP]  	Curing actor: " + kActor)

	If (sParasite == "SpiderEgg")
		SexLab.AddCum(kActor,  Vaginal = true,  Oral = false,  Anal = true)
		fctParasites.cureParasiteByString(kActor, "SpiderEgg", bHarvestParasite)

		If (!bHarvestParasite)
			kPlayer.AddItem(IngredientSpiderEgg,Utility.RandomInt(5,10))
		Endif

	ElseIf (sParasite == "ChaurusWorm")
		SexLab.AddCum(kActor,  Vaginal = true,  Oral = false,  Anal = true)
		fctParasites.cureParasiteByString(kActor, "ChaurusWorm", bHarvestParasite)

		If (!bHarvestParasite)
			kPlayer.AddItem(IngredientChaurusWorm,1)
		Endif
		
	ElseIf (sParasite == "ChaurusWormVag")
		SexLab.AddCum(kActor,  Vaginal = true,  Oral = false,  Anal = true)
		fctParasites.cureParasiteByString(kActor, "ChaurusWormVag", bHarvestParasite)

		If (!bHarvestParasite)
			kPlayer.AddItem(IngredientChaurusWorm,1)
		Endif
		
	ElseIf (sParasite == "FaceHugger")
		SexLab.AddCum(kActor,  Vaginal = true,  Oral = false,  Anal = true)
		fctParasites.cureParasiteByString(kActor, "FaceHugger", bHarvestParasite)
		
	ElseIf (sParasite == "FaceHuggerGag")
		SexLab.AddCum(kActor,  Vaginal = false,  Oral = true,  Anal = false)
		fctParasites.cureParasiteByString(kActor, "FaceHuggerGag", bHarvestParasite)
		
	ElseIf (sParasite == "TentacleMonster")
		SexLab.AddCum(kActor,  Vaginal = true,  Oral = false,  Anal = true)
		fctParasites.cureParasiteByString(kActor, "TentacleMonster", bHarvestParasite)
		
	ElseIf (sParasite == "LivingArmor")
		SexLab.AddCum(kActor,  Vaginal = true,  Oral = false,  Anal = true)
		fctParasites.cureParasiteByString(kActor, "LivingArmor", bHarvestParasite)
	Endif
EndFunction

Event OnSLPFalmerBlue(String _eventName, String _args, Float _argc = 0.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer() as Actor
 
	fctParasites.FalmerBlue(kActor,kPlayer)
EndEvent

Event OnSLPClearParasites(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()
 	Bool bHarvestParasite = False

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	
	Debug.Trace("[SLP] Receiving 'clear parasites' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "SpiderPenis", bHarvestParasite)
	fctParasites.cureParasiteByString(kActor, "SpiderEggAll", bHarvestParasite)
	fctParasites.cureParasiteByString(kActor, "ChaurusWorm", bHarvestParasite)
	fctParasites.cureParasiteByString(kActor, "ChaurusWormVag", bHarvestParasite)
	fctParasites.cureParasiteByString(kActor, "FaceHugger", bHarvestParasite)
	fctParasites.cureParasiteByString(kActor, "FaceHuggerGag", bHarvestParasite)
	fctParasites.cureParasiteByString(kActor, "TentacleMonster", bHarvestParasite)
	fctParasites.cureParasiteByString(kActor, "LivingArmor", bHarvestParasite)
	fctParasites.cureParasiteByString(kActor, "Barnacles", bHarvestParasite) 
 	fctParasites.cureParasiteByString(kActor, "ChaurusQueenGag", bHarvestParasite) 
 	fctParasites.cureParasiteByString(kActor, "ChaurusQueenVag", bHarvestParasite) 
 	fctParasites.cureParasiteByString(kActor, "ChaurusQueenSkin", bHarvestParasite) 
 	fctParasites.cureParasiteByString(kActor, "ChaurusQueenArmor", bHarvestParasite) 
 	fctParasites.cureParasiteByString(kActor, "ChaurusQueenBody", bHarvestParasite) 
 	fctParasites.cureParasiteByString(kActor, "SprigganRootGag", bHarvestParasite) 
 	; fctParasites.cureParasiteByString(kActor, "SprigganRootArms", bHarvestParasite) 
 	fctParasites.cureParasiteByString(kActor, "SprigganRootFeet", bHarvestParasite) 
 	fctParasites.cureParasiteByString(kActor, "SprigganRootBody", bHarvestParasite) 
   

EndEvent

Event OnSLPHideParasite(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()
 	String sParasite = _args
 	Bool bHarvestParasite = False

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	
	Debug.Trace("[SLP] Receiving 'hide parasite' event - Actor: " + kActor)

	fctParasites.clearParasiteNPCByString(kActor, sParasite) 
	StorageUtil.SetIntValue(kActor, "_SLP_iHiddenParasiteCount" , StorageUtil.GetIntValue(kActor, "_SLP_iHiddenParasiteCount") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iHiddenParasite_" + sParasite, 1)

	fctParasites.applyHiddenParasiteEffect(kActor, sParasite) 

EndEvent

Event OnSLPShowParasite(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()
 	String sParasite = _args
 	Bool bHarvestParasite = False

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	
	Debug.Trace("[SLP] Receiving 'show parasite' event - Actor: " + kActor)

	fctParasites.equipParasiteNPCByString(kActor, sParasite) 
	StorageUtil.SetIntValue(kActor, "_SLP_iHiddenParasiteCount" ,  StorageUtil.GetIntValue(kActor, "_SLP_iHiddenParasiteCount") - 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iHiddenParasite_" + sParasite, 0)

	fctParasites.clearHiddenParasiteEffect(kActor, sParasite) 

EndEvent


Event OnSLPRefreshParasites(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()
 	Bool bHarvestParasite = False

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	
	Debug.Trace("[SLP] Receiving 'refresh parasites' event - Actor: " + kActor)

	refreshAllPArasites(kActor)

EndEvent

Function refreshAllPArasites(Actor kActor)
	; fctParasites.cureSpiderEgg(kActor,"All", bHarvestParasite)
	; fctParasites.cureSpiderPenis(kActor,bHarvestParasite)
 	; fctParasites.cureChaurusWorm(kActor, bHarvestParasite)
 	; fctParasites.cureChaurusWormVag(kActor, bHarvestParasite) 
	fctParasites.refreshParasite(kActor, "SpiderEgg")
	fctParasites.refreshParasite(kActor, "SpiderPenis")
	fctParasites.refreshParasite(kActor, "ChaurusWorm")
	fctParasites.refreshParasite(kActor, "ChaurusWormVag")
	fctParasites.refreshParasite(kActor, "FaceHugger")
	fctParasites.refreshParasite(kActor, "FaceHuggerGag")
	fctParasites.refreshParasite(kActor, "TentacleMonster")
	fctParasites.refreshParasite(kActor, "LivingArmor") 
	fctParasites.refreshParasite(kActor, "Barnacles")
	fctParasites.refreshParasite(kActor, "SprigganRootGag")
	fctParasites.refreshParasite(kActor, "SprigganRootArms")
	; fctParasites.refreshParasite(kActor, "SprigganRootFeet")
	fctParasites.refreshParasite(kActor, "SprigganRootBody")
	fctParasites.refreshParasite(kActor, "ChaurusQueenGag") 
	fctParasites.refreshParasite(kActor, "ChaurusQueenVag") 
	fctParasites.refreshParasite(kActor, "ChaurusQueenSkin") 
	fctParasites.refreshParasite(kActor, "ChaurusQueenArmor") 
	fctParasites.refreshParasite(kActor, "ChaurusQueenBody") 
EndFunction


Event OnSLPRefreshBodyShape(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()

	Debug.Trace("[SLP] Receiving 'refresh body shape' event - Actor: " + kActor)

	If (fctParasites.isInfectedByString( kActor,  "SpiderEgg" )) || (fctParasites.isInfectedByString( kActor,  "SpiderPenis" ))
		Debug.Trace("[SLP] Refreshing belly shape (spider egg)")
		Int iNumSpiderEggs = StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount" )
		fctParasites.ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" ))
	EndIf

	If (fctParasites.isInfectedByString( kActor,  "ChaurusWorm" ))
		Debug.Trace("[SLP] Refreshing butt shape (chaurus worm)")
		fctParasites.ApplyBodyChange( kActor, "ChaurusWorm", "Butt", 1.5, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))
	EndIf

	If (fctParasites.isInfectedByString( kActor,  "ChaurusWormVag" ))
		Debug.Trace("[SLP] Refreshing butt shape (vaginal chaurus worm)")
		fctParasites.ApplyBodyChange( kActor, "ChaurusWormVag", "Belly", 1.5, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxChaurusWormVag" ))
	EndIf

	If (fctParasites.isInfectedByString( kActor,  "TentacleMonster" ))
		Debug.Trace("[SLP] Refreshing breast shape (tentacle monster)")
		Int iParasiteDuration = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(kActor, "_SLP_iTentacleMonsterDate")
		Float fValue = 1.0 + (iParasiteDuration as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxTentacleMonster" )
		fctParasites.ApplyBodyChange( kActor, "TentacleMonster", "Breast", fValue, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxTentacleMonster" ) )
	EndIf

	If (fctParasites.isInfectedByString( kActor,  "LivingArmor" ))
		Debug.Trace("[SLP] Refreshing breast shape (living armor)")
		Int iParasiteDuration = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(kActor, "_SLP_iLivingArmorDate")
		Float fValue = 1.0 + (iParasiteDuration as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxLivingArmor" )
		fctParasites.ApplyBodyChange( kActor, "LivingArmor", "Breast", fValue, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxLivingArmor" ) )
	EndIf

	If (fctParasites.isInfectedByString( kActor,  "FaceHugger" )) || (fctParasites.isInfectedByString( kActor,  "FaceHuggerGag" ))
		Debug.Trace("[SLP] Refreshing belly shape (creepy critter)")
		Int iParasiteDuration = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerDate")
		Float fValue = 1.0 + (iParasiteDuration as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" )
		fctParasites.ApplyBodyChange( kActor, "FaceHugger", "Belly", fValue, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ) )
	EndIf

EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	Actor PlayerActor = Game.GetPlayer() as Actor
	Location kLocation = PlayerActor.GetCurrentLocation()
	Bool bLocationAllowed = False
 	Cell kActorCell = PlayerActor.GetParentCell()

	If (StorageUtil.GetIntValue(PlayerActor, "_SLP_iDisableParasitesOnSleep") == 1)
		Debug.Trace("[SLP] Parasites on Sleep disabled: " + StorageUtil.GetIntValue(PlayerActor, "_SLP_iDisableParasitesOnSleep"))
		Return
	Endif

	if (kLocation)  

		If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceBarnacles" )>0.0) 
			If kLocation.IsSameLocation(SLP_BlackreachLocation) || kLocation.HasKeyword(SLP_FalmerHiveLocType) || kLocation.HasKeyword(SLP_CaveLocType) || kLocation.HasKeyword(SLP_DwarvenRuinLocType)
				Debug.Trace("[SLP] Good location for Barnacles")
				bLocationAllowed = True
			  	
			else
				Debug.Trace("[SLP] Not a good location for Barnacles")
			endIf
		endIf

		if (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHugger" )>0.0) && (kActorCell.IsInterior())
			if kLocation.IsSameLocation(SLP_BlackreachLocation) || kLocation.HasKeyword(SLP_DraugrCryptLocType) || kLocation.HasKeyword(SLP_NordicRuinLocType) || kLocation.HasKeyword(SLP_MineLocType) || kLocation.HasKeyword(SLP_CaveLocType) || kLocation.HasKeyword(SLP_OutdoorLocType)
				Debug.Trace("[SLP] Good location for Face hugger")
				bLocationAllowed = True
			else
				Debug.Trace("[SLP] Not a good location for Face hugger")
			EndIf
		endIf

		if (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHuggerGag" )>0.0) && (kActorCell.IsInterior())
			if kLocation.IsSameLocation(SLP_BlackreachLocation) || kLocation.HasKeyword(SLP_DraugrCryptLocType) || kLocation.HasKeyword(SLP_NordicRuinLocType) || kLocation.HasKeyword(SLP_MineLocType) || kLocation.HasKeyword(SLP_CaveLocType) || kLocation.HasKeyword(SLP_OutdoorLocType)
				Debug.Trace("[SLP] Good location for Face hugger (gag)")
				bLocationAllowed = True
			else
				Debug.Trace("[SLP] Not a good location for Face hugger (gag)")
			EndIf
		endif

		if kLocation.IsSameLocation(SLP_BlackreachLocation)
			PlayerActor.SendModEvent("SLHModHormone", "Immunity", -1.0 * Utility.RandomFloat(1.0,10.0))
		endif

	else
		Debug.Trace("[SLP] Sleep location is empty")
	endIf

	if (bLocationAllowed)
		If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceBarnacles" )>0.0) 
			; Sleeping naked in Blackreach -> chance of barnacles
			If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Harness")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "Barnacles")) && (fctOutfits.isActorNaked(PlayerActor)) && (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceBarnacles" ) as Int) )
				if (fctParasites.infectParasiteByString(PlayerActor, "Barnacles"))
					Debug.Trace("[SLP] Barnacle infection successful")
					Debug.MessageBox("As you wake up from an uneasy sleep, you discover your skin is covered with hard growths. They pulsate with a soft glow and burry painfully into your skin when you touch them.")
				Endif
			Else
				Debug.Trace("[SLP] Barnacle infection failed")
				Debug.Trace("[SLP]   Harness: " + fctParasites.ActorHasKeywordByString(PlayerActor, "Harness"))
				Debug.Trace("[SLP]   Is actor naked: " + fctOutfits.isActorNaked(PlayerActor))
				Debug.Trace("[SLP]   Barnacles equipped: " + fctParasites.ActorHasKeywordByString(PlayerActor, "Barnacles"))
				Debug.Trace("[SLP]   Chance infection: " + (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceBarnacles" ) as Int) )
			EndIf

		endif

		if (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHugger" )>0.0) 
			; Sleeping naked in a draugr crypt -> chance of face hugger
			If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "Harness")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "PlugVaginal")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "FaceHugger")) && (fctOutfits.isActorNaked(PlayerActor)) && (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHugger" ) as Int) )
				if (fctParasites.infectParasiteByString(PlayerActor, "FaceHugger"))
					Debug.Trace("[SLP] Creepy crawler infection successful")
					Debug.MessageBox("As you wake up from a restless sleep, you find with horror that your exposed crotch is filled with the tail of a critter, firmly wrapped around your hips. The end of that tail throbs deeply inside you.")
				Endif
			Else
				Debug.Trace("[SLP] Creepy crawler infection failed")
				Debug.Trace("[SLP]   Belt: " + fctParasites.ActorHasKeywordByString(PlayerActor, "Belt"))
				Debug.Trace("[SLP]   Harness: " + fctParasites.ActorHasKeywordByString(PlayerActor, "Harness"))
				Debug.Trace("[SLP]   PlugVaginal: " + fctParasites.ActorHasKeywordByString(PlayerActor, "PlugVaginal"))
				Debug.Trace("[SLP]   Is actor naked: " + fctOutfits.isActorNaked(PlayerActor))
				Debug.Trace("[SLP]   Face Hugger equipped: " + fctParasites.ActorHasKeywordByString(PlayerActor, "FaceHugger"))
				Debug.Trace("[SLP]   Chance infection: " + (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHugger" ) as Int) )

			EndIf

		endif

		if (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHuggerGag" )>0.0)
			; Sleeping naked in a draugr crypt -> chance of face hugger
			If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Gag")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "FaceHuggerGag")) && (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHuggerGag" ) as Int) )
				if (fctParasites.infectParasiteByString(PlayerActor, "FaceHuggerGag"))
					Debug.Trace("[SLP] Creepy crawler (face) infection successful")
					Debug.MessageBox("A suffocating sensation wakes you suddenly. You find your face wrapped in the sticky embrace of a creature as its tail squirms deeply into your throat. Surprisinly, you seem to be breathing through the creature.")
				Endif
			Else
				Debug.Trace("[SLP] Creepy crawler (face) infection failed")
				Debug.Trace("[SLP]   Gag: " + fctParasites.ActorHasKeywordByString(PlayerActor, "Gag"))
				Debug.Trace("[SLP]   Face Hugger Gag equipped: " + fctParasites.ActorHasKeywordByString(PlayerActor, "FaceHuggerGag"))
				Debug.Trace("[SLP]   Chance infection: " + (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHuggerGag" ) as Int) )

			EndIf
		else
			Debug.Trace("[SLP] Not a good location for Face hugger")
		EndIf
	endif

	; Hormones compatibility
	If (fctParasites.ActorHasKeywordByString(PlayerActor, "FaceHugger")) || (fctParasites.ActorHasKeywordByString(PlayerActor, "FaceHuggerGag")) || (fctParasites.ActorHasKeywordByString(PlayerActor, "ChaurusWorm"))
		PlayerActor.SendModEvent("SLHModHormone", "Female", 10.0 + Utility.RandomFloat(0.0,10.0))
		PlayerActor.SendModEvent("SLHModHormone", "SexDrive", 1.0 + Utility.RandomFloat(0.0,5.0))
	endif 
	
	If ( (fctParasites.ActorHasKeywordByString(PlayerActor, "SpiderEgg")) || (fctParasites.ActorHasKeywordByString(PlayerActor, "SpiderPenis")) ) 
		PlayerActor.SendModEvent("SLHModHormone", "SexDrive", 5.0 + Utility.RandomFloat(0.0,10.0))
	endif

	If (fctParasites.ActorHasKeywordByString(PlayerActor, "TentacleMonster"))
		PlayerActor.SendModEvent("SLHModHormone", "Immunity", 1.0 * Utility.RandomFloat(0.0,10.0))
		PlayerActor.SendModEvent("SLHModHormone", "Lactation", 10.0 + Utility.RandomFloat(0.0,10.0))
	endif 

	If (fctParasites.ActorHasKeywordByString(PlayerActor, "Barnacles"))
		PlayerActor.SendModEvent("SLHModHormone", "Immunity", -1.0 * Utility.RandomFloat(0.0,10.0))
		PlayerActor.SendModEvent("SLHModHormone", "Pheromones", 1.0 + Utility.RandomFloat(0.0,5.0))
	endif 

	If (fctParasites.ActorHasKeywordByString(PlayerActor, "ChaurusQueenVag"))
		PlayerActor.SendModEvent("SLHModHormone", "Pheromones", 10.0 + Utility.RandomFloat(0.0,20.0))
		PlayerActor.SendModEvent("SLHModHormone", "Lactation", -1.0 * Utility.RandomFloat(0.0,10.0))
	endif 

	If (fctParasites.ActorHasKeywordByString(PlayerActor, "SprigganRootGag")) || (fctParasites.ActorHasKeywordByString(PlayerActor, "SprigganRootArms")) || (fctParasites.ActorHasKeywordByString(PlayerActor, "SprigganRootFeet")) || (fctParasites.ActorHasKeywordByString(PlayerActor, "SprigganRootBody"))
		PlayerActor.SendModEvent("SLHModHormone", "Female", 20.0 + Utility.RandomFloat(0.0,10.0))
		PlayerActor.SendModEvent("SLHModHormone", "Male", -1.0 * (10.0 + Utility.RandomFloat(0.0,10.0)) )
		PlayerActor.SendModEvent("SLHModHormone", "Metabolism", 10.0 + Utility.RandomFloat(0.0,10.0))
	endif 

	; Clean up Quest Aliases if parasites are not equipped anymore 
	fctParasites.clearParasiteAlias(PlayerActor, "FaceHugger" )
	fctParasites.clearParasiteAlias(PlayerActor, "ChaurusWorm" )
	fctParasites.clearParasiteAlias(PlayerActor, "SpiderEgg" )
	fctParasites.clearParasiteAlias(PlayerActor, "SpiderPenis" )

	If (!fctParasites.ActorHasKeywordByString(PlayerActor, "TentacleMonster"))
		fctParasites.clearParasiteAlias(PlayerActor, "TentacleMonster" )
	endif

	If (!fctParasites.ActorHasKeywordByString(PlayerActor, "LivingArmor"))
		fctParasites.clearParasiteAlias(PlayerActor, "LivingArmor" )
	endif

	If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Barnacles"))
		fctParasites.clearParasiteAlias(PlayerActor, "Barnacles" )
	endif

	If (!fctParasites.ActorHasKeywordByString(PlayerActor, "SprigganRoot"))
		fctParasites.clearParasiteAlias(PlayerActor, "SprigganRoot" )
	endif

	; Bring Lastelle where she belongs if needed
	fctParasites.resetOnSleep()
EndEvent

Event OnSleepStop(bool abInterrupted)
	If abInterrupted

	EndIf
EndEvent
 

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)

  	if akBaseObject as Ingredient
  		Ingredient thisIngredient = akBaseObject as Ingredient

    	; Debug.Notification("This actor just ate an ingredient type: " + akBaseObject.GetType())

    	; Spider egg = type 30
    	if (thisIngredient == IngredientSpiderEgg)
    		Debug.Notification("This actor just ate a spider egg")
    		fctParasites.forceChaurusQueenStage(320)
    		fctParasites.tryPlayerSpiderStage()

    	elseif (thisIngredient == IngredientChaurusEgg)
    		Debug.Notification("This actor just ate a chaurus egg")
    		fctParasites.forceChaurusQueenStage(350)
    		fctParasites.tryPlayerChaurusStage()
    	endif

 
  	endIf
endEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	Actor kPlayer = Game.GetPlayer()
	Actor kTarget = akAggressor  as Actor

	If (kTarget != None) && (kTarget != kPlayer)
		;  Debug.Trace("We were hit by " + akAggressor)
		; Debug.Notification("." )

		if (StorageUtil.GetIntValue(kPlayer, "_SLP_iSpiderPheromoneON") == 1 )
			fctParasites.tryCharmSpider( kTarget )
		endif

		if (StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusPheromoneON") == 1 )
			fctParasites.tryCharmChaurus( kTarget )
		endif

		if (StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSprigganRootArms") > 0.0 )
			fctParasites.tryPlayerSpriggan( kTarget )
		endif
	EndIf

EndEvent


Bool Function _hasPlayer(Actor[] _actors)
	; ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerREF = Game.GetPlayer()

	int idx = 0
	while idx < _actors.Length
		if _actors[idx] == PlayerRef
			return True
		endif
		idx += 1
	endwhile
	Return False
EndFunction

Actor Function _firstNotPlayer(Actor[] _actors)
	; ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerREF = Game.GetPlayer()

	int idx = 0
	while idx < _actors.Length
		if _actors[idx] != PlayerRef
			return _actors[idx]
		endif
		idx += 1
	endwhile
	Return None
EndFunction

Bool Function _hasActor(Actor[] _actors, Actor thisActor)

	int idx = 0
	while idx < _actors.Length
		if _actors[idx] == thisActor as ObjectReference
			return True
		endif
		idx += 1
	endwhile
	Return False
EndFunction

Bool Function _hasRace(Actor[] _actors, Race thisRace)
	ActorBase aBase 
	Race aRace 

	int idx = 0
	while idx < _actors.Length
		if (_actors[idx])
			; aBase = _actors[idx].GetBaseObject() as ActorBase
			aRace = _actors[idx].GetLeveledActorBase().GetRace()
			if aRace == thisRace
				return True
			endif
		EndIf
		idx += 1
	endwhile
	Return False
EndFunction
 



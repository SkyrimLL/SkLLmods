Scriptname SLP_PlayerAlias extends ReferenceAlias  

SexLabFramework     property SexLab Auto
slaUtilScr Property slaUtil  Auto  

SLP_fcts_parasites Property fctParasites  Auto
SLP_fcts_outfits Property fctOutfits  Auto

ReferenceAlias Property SpiderFollowerAlias  Auto  

Quest Property KynesBlessingQuest  Auto 

GlobalVariable Property GameDaysPassed Auto

Location Property SLP_BlackreachLocation Auto
Keyword Property SLP_DraugrCryptLocType Auto
Keyword Property SLP_MineLocType Auto
Keyword Property SLP_FalmerHiveLocType Auto
Keyword Property SLP_NordicRuinLocType Auto
Keyword Property SLP_CaveLocType Auto
Keyword Property SLP_DwarvenRuinLocType Auto
Keyword Property SLP_OutdoorLocType Auto

Container Property EggSac  Auto  

Ingredient  Property GlowingMushroom Auto
Ingredient  Property TrollFat Auto
Ingredient  Property DwarvenOil Auto
Ingredient  Property FireSalts Auto
Ingredient  Property IngredientSpiderEgg Auto
Ingredient  Property IngredientChaurusWorm Auto
Ingredient  Property IngredientChaurusEgg Auto

Potion Property SLP_CritterSemen Auto

Actor PlayerRef
int daysPassed
int iGameDateLastCheck = -1
int iNextStageTicker = 0
Int iChaurusQueenStage

State Busy
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	EndEvent
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	EndEvent
EndState

Event OnInit()
	_maintenance()
EndEvent

Event OnPlayerLoadGame()
	_maintenance()
EndEvent

Function _maintenance()
	PlayerRef = GetReference() as Actor
	iChaurusQueenStage = StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusQueenStage")

	Int iCurrentVersionNumber = 20220417
	Int iVersionNumber = StorageUtil.GetIntValue(none, "_SLP_iParasitesVersion")

	If (iVersionNumber != iCurrentVersionNumber)
		Debug.Notification("[SLP] Upgrading Parasites to " + iCurrentVersionNumber)

		If (iVersionNumber <= 20210531)
			StorageUtil.SetIntValue(PlayerRef, "_SLP_toggleSprigganRootGag", 0 )
			StorageUtil.SetFloatValue(PlayerRef, "_SLP_chanceSprigganRootGag", 10.0 )
			StorageUtil.SetIntValue(PlayerRef, "_SLP_toggleSprigganRootArms", 0 )
			StorageUtil.SetFloatValue(PlayerRef, "_SLP_chanceSprigganRootArms", 20.0 )
			StorageUtil.SetIntValue(PlayerRef, "_SLP_toggleSprigganRootFeet", 0 )
			StorageUtil.SetFloatValue(PlayerRef, "_SLP_chanceSprigganRootFeet", 30.0 )
			StorageUtil.SetIntValue(PlayerRef, "_SLP_toggleSprigganRootBody", 0 )
			StorageUtil.SetFloatValue(PlayerRef, "_SLP_chanceSprigganRootBody", 50.0 )
		Endif
		If (iVersionNumber <= 20210630) 
			StorageUtil.SetFloatValue(PlayerRef, "_SLP_flareDelay", 1.0 )
		endif 
		If (iVersionNumber <= 20210709) 
			StorageUtil.SetIntValue(PlayerRef, "_SLP_toggleSkinColorChanges", 1 )
			StorageUtil.SetIntValue(PlayerRef, "_SLP_toggleHairloss", 1 )
			StorageUtil.SetIntValue(PlayerRef, "_SLP_toggleChaurusQueenBaseSkin", 1 )
			StorageUtil.SetIntValue(PlayerRef, "_SLP_toggleChaurusQueenInfectNPCs", 1 )
		endif
		If iVersionNumber <= 20220417
			GameDaysPassed = Game.GetFormFromFile(0x39, "Skyrim.esm") as GlobalVariable
		EndIf
		StorageUtil.SetIntValue(none, "_SLP_iParasitesVersion", iCurrentVersionNumber)	
	Endif

	; Initial values
	if (iGameDateLastCheck == -1)
		iGameDateLastCheck = GameDaysPassed.GetValue() as Int
	endIf

	fctParasites.maintenance()

	; Set Seed Stone ritual to today if missing
	if (iChaurusQueenStage==1) && (StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusQueenDate")==0)
		StorageUtil.SetIntValue(PlayerRef, "_SLP_iChaurusQueenDate", GameDaysPassed.GetValue() as Int)
	endif

	if (iChaurusQueenStage>=1)
		if (iChaurusQueenStage>=2)
			StorageUtil.SetFloatValue(PlayerRef, "_SLP_chanceChaurusQueenVag", 100.0 )
		endif
		if (iChaurusQueenStage>=3)
			StorageUtil.SetFloatValue(PlayerRef, "_SLP_chanceChaurusQueenSkin", 100.0 )
		endif
		if (iChaurusQueenStage>=4)
			StorageUtil.SetFloatValue(PlayerRef, "_SLP_chanceChaurusQueenGag", 100.0 )
			StorageUtil.SetFloatValue(PlayerRef, "_SLP_chanceChaurusQueenArmor", 100.0 )
		endif
		if (iChaurusQueenStage>=5)
			StorageUtil.SetFloatValue(PlayerRef, "_SLP_chanceChaurusQueenBody", 100.0 )
		endif
	endif

	; Set flags about known methods to remove parasites
 	StorageUtil.SetIntValue(PlayerRef, "_SLP_iSpiderEggsKnown", KynesBlessingQuest.GetStageDone(30) as Int)
 	StorageUtil.SetIntValue(PlayerRef, "_SLP_iChaurusWormKnown", KynesBlessingQuest.GetStageDone(40) as Int)
 	StorageUtil.SetIntValue(PlayerRef, "_SLP_iHuggersKnown", KynesBlessingQuest.GetStageDone(50) as Int)
 	StorageUtil.SetIntValue(PlayerRef, "_SLP_iTentacleMonsterKnown", KynesBlessingQuest.GetStageDone(60) as Int)
 	StorageUtil.SetIntValue(PlayerRef, "_SLP_iLivingArmorKnown", KynesBlessingQuest.GetStageDone(70) as Int)
 	StorageUtil.SetIntValue(PlayerRef, "_SLP_iBarnaclesKnown", KynesBlessingQuest.GetStageDone(80) as Int)

 	; one time refresh of all parasites and related variables
	refreshAllPArasites(PlayerRef)

	UnregisterForAllModEvents()
	Debug.Trace("SexLab Parasites: Reset SexLab events")
	RegisterForModEvent("PlayerTrack_Start", "OnSexLabStart")
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
	If Game.GetModByName("EstrusChaurus.esp") != 255
		debug.trace("[SLP] 'EstrusChaurus.esp' detected")
		StorageUtil.SetIntValue(none, "_SLS_isEstrusChaurusON", 1)
		StorageUtil.SetFormValue(none, "_SLS_getEstrusChaurusBreederSpell", Game.GetFormFromFile(0x019121, "EstrusChaurus.esp"))
		StorageUtil.SetFormValue(none, "_SLS_getEstrusChaurusParasiteEgg", Game.GetFormFromFile(0x00EA27, "EstrusChaurus.esp"))
	Else
		StorageUtil.SetIntValue(none, "_SLS_isEstrusChaurusON", 0)
	EndIf

	If Game.GetModByName("BeeingFemale.esm") != 255
		debug.trace("[SLP] 'BeeingFemale.esm' detected")
		StorageUtil.SetIntValue(none, "_SLS_isBeeingFemaleON", 1)
		StorageUtil.SetFormValue(none, "_SLS_getBeeingFemalePregnancySpell", Game.GetFormFromFile(0x0028A0, "BeeingFemale.esm"))
	Else
		StorageUtil.SetIntValue(none, "_SLS_isBeeingFemaleON", 0)
	EndIf

	If Game.GetModByName("CagedFollowers.esp") != 255
		debug.trace("[SLP] 'CagedFollowers.esp' detected")
		StorageUtil.SetIntValue(none, "_SLS_isCagedFollowerON", 1)
		StorageUtil.SetFormValue(none, "_SLS_getCagedFollowerQuestKeyword", Game.GetFormFromFile(0x00184D, "CagedFollowers.esp"))
	Else
		StorageUtil.SetIntValue(none, "_SLS_isCagedFollowerON", 0)
	EndIf

	If Game.GetModByName("Animated Dragon Wings.esp") != 255
		debug.trace("[SLP] 'Animated Dragon Wings.esp' detected")
		StorageUtil.SetIntValue(none, "_SLP_isAnimatedDragonWings", 1)
		StorageUtil.SetFormValue(none, "_SLP_getWingsPotion", Game.GetFormFromFile(0x00388B, "Animated Dragon Wings.esp"))
		StorageUtil.SetFormValue(none, "_SLP_getWingsCurePotion", Game.GetFormFromFile(0x0022F5, "Animated Dragon Wings.esp"))
	Else
		StorageUtil.SetIntValue(none, "_SLP_isAnimatedDragonWings", 0)
	EndIf

	If Game.GetModByName("Real Flying.esp") != 255
		debug.trace("[SLP] 'Real Flying.esp' detected")
		StorageUtil.SetIntValue(none, "_SLP_isRealFlying", 1)
		StorageUtil.SetFormValue(none, "_SLP_getWingsPotion", Game.GetFormFromFile(0x000D65, "Real Flying.esp"))
		StorageUtil.SetFormValue(none, "_SLP_getWingsCurePotion", Game.GetFormFromFile(0x0022F2, "Real Flying.esp"))
	Else
		StorageUtil.SetIntValue(none, "_SLP_isRealFlying", 0)
	EndIf

	If Game.GetModByName("Animated Wings Ultimate.esp") != 255
		debug.trace("[SLP] 'Animated Wings Ultimate.esp' detected")
		StorageUtil.SetIntValue(none, "_SLP_isAnimatedWingsUltimate", 1)
		StorageUtil.SetFormValue(none, "_SLP_getWingsPotion", Game.GetFormFromFile(0x000CA2, "Animated Wings Ultimate.esp"))
		StorageUtil.SetFormValue(none, "_SLP_getWingsCurePotion", Game.GetFormFromFile(0x000B21, "Animated Wings Ultimate.esp"))
	Else
		StorageUtil.SetIntValue(none, "_SLP_isAnimatedWingsUltimate", 0)
	EndIf

	RegisterForSingleUpdate(10)
EndFunction

Int Function _getParasiteTickerThreshold(Actor kActor, Int _iNextStageTicker, Int _iParasiteDuration, String sParasite)
	; 1 ticker = 10 seconds realtime
	Float fThreshold = 100.0
	Float fThrottle = (_iNextStageTicker as Float) / 10.0
	Float flareDelay = StorageUtil.GetFloatValue(kActor, "_SLP_flareDelay" ) as Float

	; Limit contribution of parasite duration to only 50 points to prevent rapid fire from long exposure
	if (_iParasiteDuration>5)
		_iParasiteDuration = 5
	endif

	; when flareDelay = 1.0
	; threshold below 100 after 200 ticks (+1 tick for 2 real time seconds - 400 s - about 6 minutes)
	; threshold below 100 immediately 3 days after infection

	if (flareDelay > 0)
		; fThreshold = 100.0 + (100.0 - ( ( ((_iNextStageTicker as Float) * 1.0) + ((_iParasiteDuration as Float) * 4.0) ) / flareDelay ) )
		; Testing longer delay for threshold to prevent quick ejection of parasites
		fThreshold = 100.0 + (100.0 - ( ( ((_iNextStageTicker as Float) * 0.5) + ((_iParasiteDuration as Float) * 2.0) ) / flareDelay ) )
		if ( ((fThrottle as Int) * 10) == _iNextStageTicker)
			; debug.notification(".")
			; debug.notification("[SLP] Check parasite event: " + sParasite )
			; debug.notification("[SLP] Chance of parasite event: " + ((100.0 - fThreshold) as Int) )
			debug.trace("[SLP] Check parasite event: " + sParasite + " - Chance of trigger: " + ((100.0 - fThreshold) as Int) )
			debug.trace("[SLP]     _iNextStageTicker: " + _iNextStageTicker)
			debug.trace("[SLP]     _iParasiteDuration: " + _iParasiteDuration)
			debug.trace("[SLP]     flareDelay: " + flareDelay)
			debug.trace("[SLP]     fThreshold: " + fThreshold)
		else
			; debug.notification(".")
		endif
	else
		; make sure threshold is never reached when delay = 0 -> no flares
		fThreshold = 999
	endif

	return (fThreshold as Int)
EndFunction

Event OnUpdate()
	Location kLocation = PlayerRef.GetCurrentLocation()
 	Int iParasiteDuration
 	Float fValue
 	Bool isWeatherRainy = false

 	daysPassed = GameDaysPassed.GetValue() as Int
	Int iDaysSinceLastCheck = daysPassed - iGameDateLastCheck

	If (iDaysSinceLastCheck > 0)
		; New day
		debug.trace("[SLP] New day updates")
		debug.trace("[SLP]    iDaysSinceLastCheck: " + iDaysSinceLastCheck)

		If (fctParasites.isInfectedByString( PlayerRef,  "SpiderPenis" ))
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iSpiderPenisDate")
			; Force at least 5 days with the parasite. Increase chance of expelling parasite each day after 5 days
			If (Utility.RandomInt(0,95) > (100 - (iParasiteDuration / 5) ) )
				if (fctParasites.tryParasiteNextStage(PlayerRef, "SpiderPenis"))
					iNextStageTicker = (iNextStageTicker / 2)
				endif
			endif

		ElseIf (fctParasites.isInfectedByString( PlayerRef,  "SpiderEgg" ))
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iSpiderEggDate")
			If (Utility.RandomInt(0,95) > (100 - (iParasiteDuration / 5) ) )
				if (fctParasites.tryParasiteNextStage(PlayerRef, "SpiderEgg"))
					iNextStageTicker = (iNextStageTicker / 2)
				endif
			endif

		ElseIf (fctParasites.isInfectedByString( PlayerRef,  "ChaurusWorm" ))
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusWormDate")
			If (Utility.RandomInt(0,95) > (100 - (iParasiteDuration / 5) ) )
				if (fctParasites.tryParasiteNextStage(PlayerRef, "ChaurusWorm"))
					iNextStageTicker = (iNextStageTicker / 2)
				endif
			endif

		ElseIf (fctParasites.isInfectedByString( PlayerRef,  "ChaurusWormVag" ))
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusWormVagDate")
			If (Utility.RandomInt(0,95) > (100 - (iParasiteDuration / 5) ) )
				if (fctParasites.tryParasiteNextStage(PlayerRef, "ChaurusWormVag"))
					iNextStageTicker = (iNextStageTicker / 2)
				endif
			endif
		Endif

		If (fctParasites.isInfectedByString( PlayerRef,  "TentacleMonster" ))
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iTentacleMonsterDate")
			If (iParasiteDuration < 10)
				Debug.MessageBox("Your breasts grow under the influence of the tentacles.")
				fValue = 1.0 + (iParasiteDuration as Float) / 10.0
				fctParasites.ApplyBodyChange( PlayerRef, "TentacleMonster", "Breast", fValue, StorageUtil.GetFloatValue(PlayerRef, "_SLP_breastMaxTentacleMonster" ) )
			endif
			If (iParasiteDuration >= 10) && (StorageUtil.GetIntValue(PlayerRef, "_SLH_iLactating")!=1)
				StorageUtil.SetIntValue(PlayerRef, "_SLH_iLactating", 1)
				PlayerRef.SendModEvent("_SLSDDi_UpdateCow")
			Endif
		Endif
		If (fctParasites.isInfectedByString( PlayerRef,  "LivingArmor" ))
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iLivingArmorDate")
			If (iParasiteDuration < 10)
				Debug.MessageBox("Your breasts grow under the influence of the tentacles.")
				fValue = 1.0 + (iParasiteDuration as Float) / 10.0
				fctParasites.ApplyBodyChange( PlayerRef, "LivingArmor", "Breast", fValue, StorageUtil.GetFloatValue(PlayerRef, "_SLP_breastMaxLivingArmor" ) )
			endif
			If (iParasiteDuration >= 10) && (StorageUtil.GetIntValue(PlayerRef, "_SLH_iLactating")!=1)
				StorageUtil.SetIntValue(PlayerRef, "_SLH_iLactating", 1)
				PlayerRef.SendModEvent("_SLSDDi_UpdateCow")
			Endif
		Endif

		If (fctParasites.isInfectedByString( PlayerRef,  "FaceHugger" )) || (fctParasites.isInfectedByString( PlayerRef,  "FaceHuggerGag" ))
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iFaceHuggerDate")
			If (iParasiteDuration < 5)
				Debug.MessageBox("Your belly grows as the critter fills it with thick fluids.")
				fValue = 1.5 + (iParasiteDuration as Float) / 5.0
				fctParasites.ApplyBodyChange( PlayerRef, "FaceHugger", "Belly", fValue, StorageUtil.GetFloatValue(PlayerRef, "_SLP_bellyMaxFaceHugger" ) )
				PlayerRef.AddItem(SLP_CritterSemen, 2)
				PlayerRef.EquipItem(SLP_CritterSemen, true,true)
				PlayerRef.EquipItem(SLP_CritterSemen, true,true)

			ElseIf (iParasiteDuration >= 5)
				Debug.MessageBox("Your belly suddenly expells copious amounts of thick fluids.")
				StorageUtil.SetIntValue(PlayerRef, "_SLP_iFaceHuggerDate", daysPassed)
				fValue = 1.0
				fctParasites.ApplyBodyChange( PlayerRef, "FaceHugger", "Belly", fValue, StorageUtil.GetFloatValue(PlayerRef, "_SLP_bellyMaxFaceHugger" ) )
				SexLab.AddCum(PlayerRef,  Vaginal = true,  Oral = false,  Anal = true)
			endif
		Endif

		If (fctParasites.isInfectedByString( PlayerRef,  "Barnacles" ))
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iBarnaclesDate")
			If  (iParasiteDuration > 5) && (!kLocation.IsSameLocation(SLP_BlackreachLocation)) && (!kLocation.HasKeyword(SLP_FalmerHiveLocType)) && (!kLocation.HasKeyword(SLP_CaveLocType)) && (!kLocation.HasKeyword(SLP_DwarvenRuinLocType))

	  			fctParasites.tryParasiteNextStage(PlayerRef, "Barnacles")
			endIf
		endif

		; Enable Chaurus Queen flares only if player is not Queen and not infected by Spriggan root
		if (iChaurusQueenStage>=1) && (iChaurusQueenStage<5)  
			;StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusQueenDate")==0
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusQueenDate")
			If (iParasiteDuration >= 2)
			 	fctParasites.tryParasiteNextStage(PlayerRef, "ChaurusQueen")
			Endif
		endif

		iNextStageTicker = iNextStageTicker + (iNextStageTicker / 2)
	else
		; updates during the day
		iChaurusQueenStage = StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusQueenStage")

		; Enable Chaurus Queen flares only if player is not Queen and not infected by Spriggan root
		if (iChaurusQueenStage>=1) && (iChaurusQueenStage<=5)
			;StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusQueenDate")==0
			iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusQueenDate")
			If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerRef, iNextStageTicker, iParasiteDuration, "ChaurusQueen") )
			 	if (fctParasites.tryParasiteNextStage(PlayerRef, "ChaurusQueen"))
			 		; next stage happened - reset counter
			 		iNextStageTicker = (iNextStageTicker / 2)
			 	endif
			 endif
		endif

		If (iChaurusQueenStage>=5) 
			; player is Queen and in combat, apply or remove claws automatically
			if (PlayerRef.IsInCombat()) && (StorageUtil.GetIntValue(PlayerRef, "_SLP_toggleChaurusQueenWeapon")== 0)
				If (fctParasites.isInfectedByString( PlayerRef,  "ChaurusQueenArmor" ))
					fctParasites.extendChaurusWeapon( PlayerRef,  "ChaurusBlade") 
					
				elseIf (fctParasites.isInfectedByString( PlayerRef,  "ChaurusQueenBody" ))
					fctParasites.extendChaurusWeapon( PlayerRef,  "ChaurusClaw") 
				endif
			elseif  (!PlayerRef.IsInCombat()) && (StorageUtil.GetIntValue(PlayerRef, "_SLP_toggleChaurusQueenWeapon")== 1)
				If (fctParasites.isInfectedByString( PlayerRef,  "ChaurusQueenArmor" ))
					fctParasites.retractChaurusWeapon( PlayerRef,  "ChaurusBlade")
					
				elseIf (fctParasites.isInfectedByString( PlayerRef,  "ChaurusQueenBody" ))
					fctParasites.retractChaurusWeapon( PlayerRef,  "ChaurusClaw")
				endif
			Endif
		endif

		; Chance of Living Armor infection when swimming
		if (PlayerRef.IsSwimming()) 
			; debug.notification("Player is swimming...")
			if (StorageUtil.GetIntValue(PlayerRef, "_SLP_lastSwimDate")!= daysPassed)
				; Use date later to trigger 'dry tentacles' effect 
				StorageUtil.SetIntValue(PlayerRef, "_SLP_lastSwimDate", daysPassed)
			endif

			if (!PlayerRef.IsInCombat())
				if (fctParasites.tryPlayerLivingArmor())
					iNextStageTicker = (iNextStageTicker / 2)
				Endif
			endif

			; Heal while swimming
			if (fctParasites.isInfectedByString( PlayerRef,  "SprigganRoot" )) || (fctParasites.isInfectedByString( PlayerRef,  "LivingArmor" ))
				Float playersHealth = PlayerRef.GetActorValuePercentage("health")
				if (playersHealth < 0.8)  
				  	; Debug.Trace("The player has over half their health left")
					;_SDSP_heal.RemoteCast(kPlayer, kPlayer, kPlayer)
					PlayerRef.resethealthandlimbs()
				endIf
			endif
		endif

		if (iNextStageTicker>0)
			; Chance of Spriggan Root growth when player is wet
			; Spriggan growth is stopped by Seed Stone
			if (fctParasites.isInfectedByString( PlayerRef,  "SprigganRoot" )) 
				Weather currentWeather = Weather.GetCurrentWeather()
				if (currentWeather.GetClassification() == 2)
				    isWeatherRainy = true
				endIf

				if (PlayerRef.IsSwimming() || isWeatherRainy) 
					; debug.notification("Player is wet...")
					if (StorageUtil.GetIntValue(PlayerRef, "_SLP_lastWetDate")!= daysPassed)
						StorageUtil.SetIntValue(PlayerRef, "_SLP_lastWetDate", daysPassed)
					endif

					iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iSprigganRootArmsDate")
					If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerRef, iNextStageTicker, iParasiteDuration, "SprigganRoot") )
						if (fctParasites.tryParasiteNextStage(PlayerRef, "SprigganRoot"))
							; Debug.Notification("[SLP] Next stage ticker RESET!")
							iNextStageTicker = (iNextStageTicker / 2)
						Endif
					endif
				endif
			endif
 
			If (fctParasites.isInfectedByString( PlayerRef,  "SpiderPenis" ))
				iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iSpiderPenisDate")
				If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerRef, iNextStageTicker, iParasiteDuration, "SpiderPenis") )
					if (fctParasites.tryParasiteNextStage(PlayerRef, "SpiderPenis"))
						iNextStageTicker = (iNextStageTicker / 2)
					endif
				endif

			ElseIf (fctParasites.isInfectedByString( PlayerRef,  "SpiderEgg" ))
				iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iSpiderEggDate")
				If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerRef, iNextStageTicker, iParasiteDuration, "SpiderEgg") )
					if (fctParasites.tryParasiteNextStage(PlayerRef, "SpiderEgg"))
						iNextStageTicker = (iNextStageTicker / 2)
					endif

				endif

			ElseIf (fctParasites.isInfectedByString( PlayerRef,  "ChaurusWorm" )) 
				iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusWormDate")
				If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerRef, iNextStageTicker, iParasiteDuration, "ChaurusWorm") )
					if (fctParasites.tryParasiteNextStage(PlayerRef, "ChaurusWorm"))
						iNextStageTicker = (iNextStageTicker / 2)
					endif
				endif

			ElseIf (fctParasites.isInfectedByString( PlayerRef,  "ChaurusWormVag" ))
				iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusWormVagDate")
				If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerRef, iNextStageTicker, iParasiteDuration, "ChaurusWormVag") )
					if (fctParasites.tryParasiteNextStage(PlayerRef, "ChaurusWormVag"))
						iNextStageTicker = (iNextStageTicker / 2)
					endif
				endif 

			ElseIf (fctParasites.isInfectedByString( PlayerRef,  "FaceHugger" ))
				iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iFaceHuggerDate")
				If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerRef, iNextStageTicker, iParasiteDuration, "FaceHugger") )
					if (fctParasites.tryParasiteNextStage(PlayerRef, "FaceHugger"))
						iNextStageTicker = (iNextStageTicker / 2)
					endif
				endif 

			ElseIf (fctParasites.isInfectedByString( PlayerRef,  "FaceHuggerGag" ))
				iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iFaceHuggerGagDate")
				If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerRef, iNextStageTicker, iParasiteDuration, "FaceHuggerGag") )
					if (fctParasites.tryParasiteNextStage(PlayerRef, "FaceHuggerGag"))
						iNextStageTicker = (iNextStageTicker / 2)
					endif
				endif 

			ElseIf (fctParasites.isInfectedByString( PlayerRef,  "TentacleMonster" ))
				iParasiteDuration = daysPassed - StorageUtil.GetIntValue(PlayerRef, "_SLP_iTentacleMonsterDate")
				If (Utility.RandomInt(0,100) > _getParasiteTickerThreshold(PlayerRef, iNextStageTicker, iParasiteDuration, "TentacleMonster") )
					if (fctParasites.tryParasiteNextStage(PlayerRef, "TentacleMonster"))
						iNextStageTicker = (iNextStageTicker / 2)
					endif
				endif
			Endif
		endif

		iNextStageTicker = iNextStageTicker + 1
	endIf

	iGameDateLastCheck = daysPassed  

	RegisterForSingleUpdate(10)
EndEvent

Event OnSexLabStart(Form ActorRef, Int threadID)
	sslBaseAnimation animation = SexLab.GetController(threadID).Animation

	If (fctParasites.isInfectedByString( PlayerRef,  "SpiderEgg" ))
		slaUtil.UpdateActorExposure(PlayerRef, 2, "Aroused from sex while carrying spider eggs.")
	ElseIf (fctParasites.isInfectedByString( PlayerRef,  "SpiderPenis" ))
		slaUtil.UpdateActorExposure(PlayerRef, 5, "Aroused from sex while carrying spider eggs.")
	ElseIf (fctParasites.isInfectedByString( PlayerRef,  "ChaurusWorm" )) || (fctParasites.isInfectedByString( PlayerRef,  "ChaurusWormVag" ))
		slaUtil.UpdateActorExposure(PlayerRef, 10, "Aroused from sex while carrying chaurus worm.")
	Endif

	if animation.HasTag("Chaurus")
		if (iChaurusQueenStage>=3)
			fctParasites.forceChaurusQueenStage(340,350)
		endif

		fctParasites.tryPlayerChaurusStage()
	elseif animation.HasTag("Spider")
		if (iChaurusQueenStage>=3)
			fctParasites.forceChaurusQueenStage(310, 320)
		endif

		fctParasites.tryPlayerSpiderStage()
	endif
EndEvent

Event OnSexLabEnd(int threadID, bool HasPlayer)
	sslThreadController controller = SexLab.GetController(threadID)
	sslBaseAnimation animation = controller.Animation
	Float fChanceChaurusWorm
	Float fChanceChaurusWormVag
	Float fChanceSpiderPenis
	Float fChanceSpiderEgg
	Actor kSexPartner
	Int iNumChaurusEggs = StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusEggCount" )
	Int iNumSpiderEggs = StorageUtil.GetIntValue(PlayerRef, "_SLP_iSpiderEggCount" )

	Actor[] actors = controller.Positions

	If HasPlayer
		Debug.Trace("[SLP] OnSexLabEnd: Player in animation")

		iChaurusQueenStage = StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusQueenStage")
		fChanceChaurusWorm = StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceChaurusWorm")
		fChanceChaurusWormVag = StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceChaurusWormVag")
		fChanceSpiderPenis = StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceSpiderPenis")
		fChanceSpiderEgg = StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceSpiderEgg")

		If (fctParasites.isInfectedByString(PlayerRef,  "ChaurusQueenVag"))
			; Player is more receptive if the vaginal pincer is extended
			fChanceChaurusWorm += 0.0
			fChanceChaurusWormVag += 50.0
			fChanceSpiderPenis = 0.0
			fChanceSpiderEgg += 50.0
			; debug.Notification("The tentacle retracts inside you.")
			; fctParasites.cureParasiteByString(PlayerRef, "ChaurusQueenVag")
		ElseIf (fctParasites.isInfectedByString(PlayerRef, "ChaurusQueenSkin"))
			; Player is more receptive if the breast feelers are extended
			fChanceChaurusWorm += 20.0
			fChanceChaurusWormVag += 20.0
			fChanceSpiderPenis = 0.0
			fChanceSpiderEgg += 20.0
		elseif (iChaurusQueenStage>=3)
			; Player is a little more receptive if carrying the Seed Stone
			fChanceChaurusWorm += 10.0
			fChanceChaurusWormVag += 10.0
			fChanceSpiderPenis /= 2.0
			fChanceSpiderEgg += 10.0
		endif

		if animation.HasTag("Chaurus")
			; check if player reached the Chaurus stage of the Chaurus Queen tranformation
			if (iChaurusQueenStage>=5)
				Debug.Notification("You skin turns fluids into eggs deep inside you.")
				StorageUtil.SetIntValue(PlayerRef, "_SLP_iChaurusEggCount", iNumChaurusEggs + (Utility.RandomInt(10,30) ) )
			endif

			; fctParasites.tryPlayerChaurusStage()

			If (!fctParasites.ActorHasKeywordByString(PlayerRef, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerRef, "PlugAnal"))
				if (Utility.RandomInt(1,100)<= (fChanceChaurusWorm as Int) )
					; PlayerRef.SendModEvent("SLPInfectChaurusWorm")
					if (fctParasites.infectParasiteByString(PlayerRef, "ChaurusWorm"))
						iNextStageTicker /= 2
						Debug.MessageBox("You moan helplessly as a thick worm forces itself inside your guts.")
					Endif
				Endif
				if (Utility.RandomInt(1,100)<= (fChanceChaurusWormVag as Int) )
					; PlayerRef.SendModEvent("SLPInfectChaurusWormVag")
					if (fctParasites.infectParasiteByString(PlayerRef, "ChaurusWormVag"))
						iNextStageTicker /= 2
						Debug.MessageBox("You shudder deeply as a squirming worm forces itself inside your womb.")
					Endif
				Endif
			EndIf
		elseif animation.HasTag("Spider")
			if (iChaurusQueenStage>=5)
				Debug.Notification("You skin turns fluids into eggs deep inside you.")
				StorageUtil.SetIntValue(PlayerRef, "_SLP_iSpiderEggCount", iNumSpiderEggs + (Utility.RandomInt(5,15) ) )
			endif
				
			; fctParasites.tryPlayerSpiderStage()

			If (!fctParasites.ActorHasKeywordByString(PlayerRef, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerRef, "PlugVaginal"))
				if (Utility.RandomInt(1,100)<= (fChanceSpiderPenis as Int) )
					if (fctParasites.infectParasiteByString(PlayerRef, "SpiderPenis"))
						iNextStageTicker /= 2
						kSexPartner = _firstNotPlayer(actors)
						SpiderFollowerAlias.ForceRefTo(kSexPartner)
						Debug.MessageBox("You gasp as the spider fills your womb with a string of slimy eggs. Unfortunately, the penis of the spider remains firmly lodged inside you after the act.")
					Endif
				elseif (Utility.RandomInt(1,100)<= (fChanceSpiderEgg as Int) )
					if (fctParasites.infectParasiteByString(PlayerRef, "SpiderEgg"))
						iNextStageTicker /= 2
						Debug.MessageBox("You gasp as the spider fills your womb with a string of slimy eggs.")
					Endif
				endif
			EndIf
		elseif (!animation.HasTag("Masturbation")) && (!animation.HasTag("Solo") )
			if (iChaurusQueenStage>=5)
				; Int iInventoryChaurusEggs = PlayerRef.GetItemCount(IngredientChaurusEgg)
				Int iSexLabCumLayers = SexLab.CountCum(PlayerRef,  Vaginal = true,  Oral = true,  Anal = true)

				Debug.Notification("You skin turns fluids into eggs deep inside you.")
				StorageUtil.SetIntValue(PlayerRef, "_SLP_iChaurusEggCount", iNumChaurusEggs + ((iSexLabCumLayers + 1)*5) )
			endif
		EndIf
	Endif

	int idx = 0
	while idx < actors.Length
		if (actors[idx] != PlayerRef) ; && (actors[idx].IsInFaction(PlayerFollowerFaction))
			; Debug.Trace("[SLP] Checking follower for parasites")
			if animation.HasTag("Chaurus")
				If (!fctParasites.ActorHasKeywordByString(actors[idx], "Belt")) && (!fctParasites.ActorHasKeywordByString(actors[idx], "PlugAnal"))
					if (Utility.RandomInt(1,100)< (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceChaurusWorm" ) as Int) )
						; actors[idx].SendModEvent("SLPInfectChaurusWorm")
						fctParasites.infectParasiteByString(actors[idx], "ChaurusWorm")
					Endif
					if (Utility.RandomInt(1,100)< (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceChaurusWormVag" ) as Int) )
						; actors[idx].SendModEvent("SLPInfectChaurusWormVag")
						fctParasites.infectParasiteByString(actors[idx], "ChaurusWormVag")
					Endif
				EndIf

			elseif animation.HasTag("Spider")
				If (!fctParasites.ActorHasKeywordByString(actors[idx], "Belt")) && (!fctParasites.ActorHasKeywordByString(actors[idx], "PlugVaginal"))
					if (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceSpiderPenis" ) as Int) )
						; actors[idx].SendModEvent("SLPInfectSpiderPenis")
						fctParasites.infectParasiteByString(actors[idx], "SpiderPenis")
					elseif (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceSpiderEgg" ) as Int) )
						; actors[idx].SendModEvent("SLPInfectSpiderEgg")
						fctParasites.infectParasiteByString(actors[idx], "SpiderEgg")
					endif
				EndIf
			EndIf

			if (iChaurusQueenStage>=5) && (StorageUtil.GetIntValue(PlayerRef, "_SLP_toggleChaurusQueenInfectNPCs" )==1)
				If HasPlayer && (!animation.HasTag("Chaurus")) && (!animation.HasTag("Spider")) && ( (fctParasites.ActorHasKeywordByString(PlayerRef, "ChaurusQueenVag")) || (fctParasites.ActorHasKeywordByString(PlayerRef, "ChaurusQueenArmor")) || (fctParasites.ActorHasKeywordByString(PlayerRef, "ChaurusQueenBody")) )
					Int iRandumNum = Utility.RandomInt(0,100)

					if (iRandumNum > 95) && (actors[idx].GetBaseObject() as ActorBase).GetSex() == 1
						debug.notification("You push chaurus eggs inside her.")
						fctParasites.infectParasiteByString(actors[idx], "ChaurusEggSilent")

					elseif (iRandumNum > 90) && fctParasites.ActorHasKeywordByString(PlayerRef, "ChaurusQueenArmor") && (actors[idx].GetBaseObject() as ActorBase).GetSex() == 1
						debug.notification("You push spider eggs inside her.")
						fctParasites.infectParasiteByString(actors[idx], "SpiderEgg")

					elseif (iRandumNum > 80)
						if (actors[idx].GetBaseObject() as ActorBase).GetSex() == 1
							debug.notification("A chaurus worm crawls inside her.")
						else
							debug.notification("A chaurus worm crawls inside him.")
						endif

						fctParasites.infectParasiteByString(actors[idx], "ChaurusWorm")	
					endif
				endif
			endif
		endIf
		idx += 1
	endwhile
EndEvent

Event OnSexLabOrgasm(int threadID, bool HasPlayer)
	Actor[] actors = SexLab.GetController(threadID).Positions

	int idx = 0
	while idx < actors.Length
		_doOrgasm(threadID, actors[idx])
		idx += 1
	endwhile
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int threadID)
	_doOrgasm(threadID, ActorRef as actor)
EndEvent

Function _doOrgasm(int threadID, Actor kActor)
	sslBaseAnimation animation = SexLab.GetController(threadID).Animation

	if animation.HasTag("Spider")
		if (fctParasites.isInfectedByString( kActor,  "SpiderEgg" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceSpiderEgg" ) / 2)) 
			if (kActor == PlayerRef)
				Debug.MessageBox("As you lay on the floor, still panting, you realize the spider extracted the fertilized eggs out of your exhausted body.")
			else
			Debug.Notification("The spider extracts the fertilized eggs.")
			endif

			fctParasites.cureParasiteByString( kActor, "SpiderEgg", "All" )
			kActor.PlaceAtMe(EggSac)
		endIf
	endif

	If (fctParasites.isInfectedByString( kActor, "ChaurusWorm" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceChaurusWorm" ) / 3)) 
		if (kActor == PlayerRef)
			Debug.MessageBox("The power of your orgasm is enough to expel the worm from your bowels, making you nearly black out from the added stimulation.")
		else
			Debug.Notification("The worm is expelled by a massive orgasm.")
		endif

		fctParasites.cureParasiteByString( kActor, "ChaurusWorm")
	EndIf

	If (fctParasites.isInfectedByString(kActor, "ChaurusWormVag" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceChaurusWormVag" ) / 3)) 
		if (kActor == PlayerRef)
			Debug.MessageBox("The power of your orgasm is enough to expel the worm, making you nearly black out from the added stimulation.")
		else
			Debug.Notification("The worm is expelled by a massive orgasm.")
		endif

		fctParasites.cureParasiteByString( kActor, "ChaurusWormVag")
	EndIf

	; Exclude solo animations from parasite transfer
 	if (StorageUtil.GetIntValue(PlayerRef, "_SLP_toggleChaurusQueenInfectNPCs" )==1) && (!(animation.HasTag("Masturbation") || animation.HasTag("Solo") ))  
		If (fctParasites.isInfectedByString(kActor, "TentacleMonster" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceTentacleMonster" ) / 4)) 
			if (kActor == PlayerRef)
				Debug.MessageBox("The creature slides around your partner.")
			else
				Debug.Notification("The creature slides around another host.")
			endif

			; NPC is infected -> send parasite to NPC, including player
			_transferParasiteAfterSex( threadID, kActor, "TentacleMonster", true)
		EndIf

		If (fctParasites.isInfectedByString(kActor, "LivingArmor" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerRef, "LivingArmor" ) / 5)) 
			if (kActor == PlayerRef)
				Debug.MessageBox("The creature slides around your partner.")
			else
				Debug.Notification("The creature slides around another host.")
			endif

			; NPC is infected -> send parasite to NPC, including player
			_transferParasiteAfterSex( threadID, kActor, "LivingArmor", true)
		EndIf

		If (fctParasites.isInfectedByString(kActor, "FaceHugger" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerRef, "FaceHugger" ) / 5)) 
			if (kActor == PlayerRef)
				Debug.MessageBox("The creature slides around your partner.")
			else
				Debug.Notification("The creature slides around another host.")
			endif

			; NPC is infected -> send parasite to NPC, including player
			_transferParasiteAfterSex( threadID, kActor, "FaceHugger", true)
		EndIf

		If (fctParasites.isInfectedByString(kActor, "FaceHuggerGag" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerRef, "FaceHuggerGag" ) / 5)) 
			if (kActor == PlayerRef)
				Debug.MessageBox("The creature slides around your partner.")
			else
				Debug.Notification("The creature slides around another host.")
			endif

			; NPC is infected -> send parasite to NPC, including player
			_transferParasiteAfterSex( threadID, kActor, "FaceHuggerGag", true)
		EndIf

		If (fctParasites.isInfectedByString(kActor, "Barnacles" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerRef, "Barnacles" ) / 5)) 
			if (kActor == PlayerRef)
				Debug.MessageBox("The spores spread to a new host.")
			else
				Debug.Notification("The spores spread to a new host.")
			endif

			; NPC is infected -> send parasite to NPC, including player
			_transferParasiteAfterSex( threadID, kActor, "Barnacles", false)
		EndIf

		If (fctParasites.isInfectedByString(kActor, "SprigganRoot" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerRef, "SprigganRoot" ) / 5)) 
			if (kActor == PlayerRef)
				Debug.MessageBox("The spores spread to a new host.")
			else
				Debug.Notification("The spores spread to a new host.")
			endif

			; NPC is infected -> send parasite to NPC, including player
			_transferParasiteAfterSex( threadID, kActor, "SprigganRootArms", false)
		EndIf
	EndIf
endfunction

Function _transferParasiteAfterSex(int threadID, Actor kInfectedActor, String sParasite, Bool bCureInfected)
	Actor[] actors = SexLab.GetController(threadID).Positions

	Debug.Trace("[SLP] started _transferParasiteAfterSex for " + sParasite)

	if (bCureInfected)
		Debug.Trace("[SLP] cure infected actor: " + kInfectedActor)
		fctParasites.cureParasiteByString( kInfectedActor, sParasite)
	endif

	int idx = 0
	while (idx < actors.Length)
		if (actors[idx] != kInfectedActor) 
			Debug.Trace("[SLP] found new host: " + actors[idx])
			fctParasites.infectParasiteByString( actors[idx], sParasite)
			Return
		endIf
		idx += 1
	endwhile
endfunction

Event OnArachnophobiaPlayerCaptured(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	PlayerRef.SendModEvent("PCSubFree")

	If (!fctParasites.ActorHasKeywordByString(PlayerRef, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerRef, "PlugVaginal"))
		if (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceSpiderPenis" ) as Int) )
			; PlayerRef.SendModEvent("SLPInfectSpiderPenis")
			fctParasites.infectParasiteByString(PlayerRef, "SpiderPenis")
		elseif (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceSpiderEgg" ) as Int) )
			; PlayerRef.SendModEvent("SLPInfectSpiderEgg")
			fctParasites.infectParasiteByString(PlayerRef, "SpiderEgg")
		endif
	EndIf
EndEvent

Event OnECBirthCompleted(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

	If ( (fctParasites.isInfectedByString( kActor,  "ChaurusWorm" )) || (fctParasites.isInfectedByString( kActor,  "ChaurusWormVag" )) )
		Debug.MessageBox("The excruciating contractions expelling the eggs out of your body push out your chaurus worms as well.")

		fctParasites.cureParasiteByString(kActor, "ChaurusWorm")
		fctParasites.cureParasiteByString(kActor, "ChaurusWormVag")
	Endif
EndEvent
;------------------------------------------------------------------------------
Event OnSLPInfectSpiderEgg(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'infect spider egg' event - Actor: " + kActor)

	if (kActor.GetBaseObject() as ActorBase).GetSex() == 0
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "SpiderEgg")
EndEvent

Event OnSLPCureSpiderEgg(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure spider egg' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "SpiderEgg", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectSpiderPenis(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'infect spider penis' event - Actor: " + kActor)

	if (kActor.GetBaseObject() as ActorBase).GetSex() == 0
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "SpiderPenis")
EndEvent

Event OnSLPCureSpiderPenis(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'cure spider penis' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "SpiderPenis", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectChaurusWorm(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'infect chaurus worm' event - Actor: " + kActor)
	fctParasites.infectParasiteByString(kActor, "ChaurusWorm")
EndEvent

Event OnSLPCureChaurusWorm(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus worm' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "ChaurusWorm", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectChaurusWormVag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect chaurus worm vaginal' event - Actor: " + kActor)

	if (kActor.GetBaseObject() as ActorBase).GetSex() == 0
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "ChaurusWormVag")
EndEvent

Event OnSLPCureChaurusWormVag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus worm vaginal' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "ChaurusWormVag", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectEstrusTentacles(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'infect estrus tentacle' event - Actor: " + kActor)
	fctParasites.infectParasiteByString(kActor, "EstrusTentacles")
EndEvent

Event OnSLPInfectTentacleMonster(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect tentacle monster' event - Actor: " + kActor)

	if (kActor.GetBaseObject() as ActorBase).GetSex() == 0
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "TentacleMonster")
EndEvent

Event OnSLPCureTentacleMonster(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'cure tentacle monster' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "TentacleMonster", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectEstrusSlime(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'infect estrus slime' event - Actor: " + kActor)
	fctParasites.infectParasiteByString(kActor, "EstrusSlime")
EndEvent

Event OnSLPInfectLivingArmor(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect living armor' event - Actor: " + kActor)

	if (kActor.GetBaseObject() as ActorBase).GetSex() == 0
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "LivingArmor")
EndEvent

Event OnSLPCureLivingArmor(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'cure living armor' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "LivingArmor", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectFaceHugger(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect face hugger' event - Actor: " + kActor)

	if (kActor.GetBaseObject() as ActorBase).GetSex() == 0
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "FaceHugger")
EndEvent

Event OnSLPCureFaceHugger(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'cure face hugger' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "FaceHugger", _args )
EndEvent

Event OnSLPInfectFaceHuggerGag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect face hugger (gag)' event - Actor: " + kActor)
	fctParasites.infectParasiteByString(kActor, "FaceHuggerGag")
EndEvent

Event OnSLPCureFaceHuggerGag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'cure face hugger (gag)' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "FaceHuggerGag", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectBarnacles(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'infect barnacles' event - Actor: " + kActor)

	if (kActor.GetBaseObject() as ActorBase).GetSex() == 0
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "Barnacles")
EndEvent

Event OnSLPCureBarnacles(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'cure barnacles' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "Barnacles", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectSprigganRoot(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'infect SprigganRoot' event - Actor: " + kActor)
	fctParasites.infectParasiteByString(kActor, "SprigganRoot")
EndEvent

Event OnSLPCureSprigganRoot(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
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
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'infect SprigganRootGag' event - Actor: " + kActor)
	fctParasites.infectParasiteByString(kActor, "SprigganRootGag")
EndEvent

Event OnSLPCureSprigganRootGag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'cure SprigganRootGag' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "SprigganRootGag", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectSprigganRootArms(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'infect SprigganRootArms' event - Actor: " + kActor)
	fctParasites.infectParasiteByString(kActor, "SprigganRootArms")
EndEvent

Event OnSLPCureSprigganRootArms(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'cure SprigganRootArms' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "SprigganRootArms", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectSprigganRootFeet(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'infect SprigganRootFeet' event - Actor: " + kActor)
	fctParasites.infectParasiteByString(kActor, "SprigganRootFeet")
EndEvent

Event OnSLPCureSprigganRootFeet(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'cure SprigganRootFeet' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "SprigganRootFeet", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectSprigganRootBody(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'infect SprigganRootBody' event - Actor: " + kActor)
	fctParasites.infectParasiteByString(kActor, "SprigganRootBody")
EndEvent

Event OnSLPCureSprigganRootBody(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'cure SprigganRootBody' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "SprigganRootBody", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectChaurusQueenVag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect chaurus queen vaginal' event - Actor: " + kActor)

	if (kActor.GetBaseObject() as ActorBase).GetSex() == 0
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "ChaurusQueenVag")
EndEvent

Event OnSLPCureChaurusQueenVag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen vaginal' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "ChaurusQueenVag", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectChaurusQueenGag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'infect chaurus queen mask' event - Actor: " + kActor)

	if (kActor.GetBaseObject() as ActorBase).GetSex() == 0
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "ChaurusQueenGag")
EndEvent

Event OnSLPCureChaurusQueenGag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen mask' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "ChaurusQueenGag", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectChaurusQueenSkin(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect chaurus queen skin' event - Actor: " + kActor)

	if (kActor.GetBaseObject() as ActorBase).GetSex() == 0
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "ChaurusQueenSkin")
EndEvent

Event OnSLPCureChaurusQueenSkin(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen skin' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "ChaurusQueenSkin", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectChaurusQueenArmor(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect chaurus queen armor' event - Actor: " + kActor)

	if (kActor.GetBaseObject() as ActorBase).GetSex() == 0
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "ChaurusQueenArmor")
EndEvent

Event OnSLPCureChaurusQueenArmor(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen armor' event - Actor: " + kActor)
	fctParasites.cureParasiteByString(kActor, "ChaurusQueenArmor", _args )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectChaurusQueenBody(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'infect chaurus queen body' event - Actor: " + kActor)

	if (kActor.GetBaseObject() as ActorBase).GetSex() == 0
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "ChaurusQueenBody")
EndEvent

Event OnSLPCureChaurusQueenBody(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen body' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "ChaurusQueenBody", _args )
EndEvent
;------------------------------------------------------------------------------
Event OnSLPInfectEstrusChaurusEgg(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'infect estrus chaurus egg' event - Actor: " + kActor)

	if (kActor.GetBaseObject() as ActorBase).GetSex() == 0
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectParasiteByString(kActor, "ChaurusEggSilent"  )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPTriggerEstrusChaurusBirth(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'trigger estrus chaurus birth' event - Actor: " + kActor)
	fctParasites.triggerEstrusChaurusBirth( kActor, _args, _argc as Int )
EndEvent

;------------------------------------------------------------------------------
Event OnSLPTriggerFuroTub(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'trigger furo tub' event - Actor: " + PlayerRef)
	fctParasites.triggerFuroTub( PlayerRef, "" )
EndEvent
;------------------------------------------------------------------------------
Event OnSLPSexCure(String _eventName, String sParasite, Float _argc = 0.0, Form _sender)
 	Actor kActor = _sender as Actor
 	String sTags 
 	Bool bIsPlayerHealer = _argc as Bool
 	Bool bHarvestParasite = False

 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

 	if (kActor == PlayerRef) && (sParasite == "")
	 	If (fctParasites.isInfectedByString( PlayerRef,  "SpiderEgg" ))  
			sParasite = "SpiderEgg"
		ElseIf (fctParasites.isInfectedByString( PlayerRef,  "ChaurusWorm" ))
			sParasite = "ChaurusWorm"
		ElseIf (fctParasites.isInfectedByString( PlayerRef,  "ChaurusWormVag" ))
			sParasite = "ChaurusWormVag"
		ElseIf (fctParasites.isInfectedByString( PlayerRef,  "FaceHugger" ))
			sParasite = "FaceHugger"
		ElseIf (fctParasites.isInfectedByString( PlayerRef,  "FaceHuggerGag" ))
			sParasite = "FaceHuggerGag"
		EndIf
 	endif

 	; if (KynesBlessingQuest.GetStageDone(22))
	if (PlayerRef.GetItemCount(GlowingMushroom) != 0) ; && (Utility.RandomInt(0,100) <= (30 + StorageUtil.GetIntValue(PlayerRef, "_SLP_iInfections") * 5) ) )
		   	bHarvestParasite = True
		   	PlayerRef.RemoveItem(GlowingMushroom,1)
	endIf	
	; Endif

	; Add removal of ingredients if player is self removing

 	If (sParasite == "SpiderEgg")
		if (PlayerRef.GetItemCount(DwarvenOil) == 0)
			Debug.Messagebox("Your attempt at removing the eggs is pointless without Dwarven Oil")
			return
		endif

 		sTags = "Fisting"
 		PlayerRef.RemoveItem(DwarvenOil,1)
 	ElseIf (sParasite == "ChaurusWorm")
		if (PlayerRef.GetItemCount(TrollFat) == 0)
			Debug.Messagebox("You can't possibly remove the worm without Troll fat")
			return
		endif

 		sTags = "Anal"
 		PlayerRef.RemoveItem(TrollFat,1)
 	ElseIf (sParasite == "ChaurusWormVag")
		if (PlayerRef.GetItemCount(TrollFat) == 0)
			Debug.Messagebox("You can't possibly remove the worm without Troll fat")
			return
		endif

 		sTags = "Vaginal"
 		PlayerRef.RemoveItem(TrollFat,1)
 	ElseIf (sParasite == "FaceHugger")
		if (PlayerRef.GetItemCount(FireSalts) == 0)
			Debug.Messagebox("The Hip Hugger will never let go without Fire Salts")
			return
		endif

 		sTags = "Anal"
 		PlayerRef.RemoveItem(FireSalts,1)
 	ElseIf (sParasite == "FaceHuggerGag")
		if (PlayerRef.GetItemCount(FireSalts) == 0)
			Debug.Messagebox("The Face Hugger will never let go without Fire Salts")
			return
		endif

 		sTags = "Oral"
 		PlayerRef.RemoveItem(FireSalts,1)
 	ElseIf (sParasite != "")
		sTags = sParasite
 	Else
		sTags = "Sex"
  	endif

	Debug.Trace("[SLP] Parasite cure scene")

	if (kActor != PlayerRef)
		; player removing parasite from actor
		If  (SexLab.ValidateActor( PlayerRef ) > 0) &&  (SexLab.ValidateActor(kActor) > 0) 
			actor[] sexActors = new actor[2]
			If (bIsPlayerHealer)
				sexActors[0] = kActor
				sexActors[1] = PlayerRef
			else
				sexActors[0] = PlayerRef
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
		If  (SexLab.ValidateActor( PlayerRef ) > 0) 
			bIsPlayerHealer = True

			actor[] sexActors = new actor[1]
			sexActors[0] = PlayerRef

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
		Debug.Trace("[SLP]  	Player is the patient")
		_afterSexCure( PlayerRef, sParasite, bIsPlayerHealer, bHarvestParasite) 

		If (kActor != PlayerRef) && (sParasite == "TentacleMonster")
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
	Debug.Trace("[SLP]  	Curing from: " + sParasite)
	Debug.Trace("[SLP]  	Curing actor: " + kActor)

	If (sParasite == "SpiderEgg")
		SexLab.AddCum(kActor,  Vaginal = true,  Oral = false,  Anal = true)
		fctParasites.cureParasiteByString(kActor, "SpiderEgg", bHarvestParasite)

		If (!bHarvestParasite)
			PlayerRef.AddItem(IngredientSpiderEgg,Utility.RandomInt(5,10))
		Endif
	ElseIf (sParasite == "ChaurusWorm")
		SexLab.AddCum(kActor,  Vaginal = true,  Oral = false,  Anal = true)
		fctParasites.cureParasiteByString(kActor, "ChaurusWorm", bHarvestParasite)

		If (!bHarvestParasite)
			PlayerRef.AddItem(IngredientChaurusWorm,1)
		Endif
	ElseIf (sParasite == "ChaurusWormVag")
		SexLab.AddCum(kActor,  Vaginal = true,  Oral = false,  Anal = true)
		fctParasites.cureParasiteByString(kActor, "ChaurusWormVag", bHarvestParasite)

		If (!bHarvestParasite)
			PlayerRef.AddItem(IngredientChaurusWorm,1)
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
	fctParasites.FalmerBlue(_sender as Actor,PlayerRef)
EndEvent

Event OnSLPClearParasites(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'clear parasites' event - Actor: " + kActor)

	fctParasites.cureParasiteByString(kActor, "SpiderPenis", False)
	fctParasites.cureParasiteByString(kActor, "SpiderEggAll", False)
	fctParasites.cureParasiteByString(kActor, "ChaurusWorm", False)
	fctParasites.cureParasiteByString(kActor, "ChaurusWormVag", False)
	fctParasites.cureParasiteByString(kActor, "FaceHugger", False)
	fctParasites.cureParasiteByString(kActor, "FaceHuggerGag", False)
	fctParasites.cureParasiteByString(kActor, "TentacleMonster", False)
	fctParasites.cureParasiteByString(kActor, "LivingArmor", False)
	fctParasites.cureParasiteByString(kActor, "Barnacles", False) 
 	fctParasites.cureParasiteByString(kActor, "ChaurusQueenGag", False) 
 	fctParasites.cureParasiteByString(kActor, "ChaurusQueenVag", False) 
 	fctParasites.cureParasiteByString(kActor, "ChaurusQueenSkin", False) 
 	fctParasites.cureParasiteByString(kActor, "ChaurusQueenArmor", False) 
 	fctParasites.cureParasiteByString(kActor, "ChaurusQueenBody", False) 
 	fctParasites.cureParasiteByString(kActor, "SprigganRootGag", False) 
 	; fctParasites.cureParasiteByString(kActor, "SprigganRootArms", False) 
 	fctParasites.cureParasiteByString(kActor, "SprigganRootFeet", False) 
 	fctParasites.cureParasiteByString(kActor, "SprigganRootBody", False) 
EndEvent

Event OnSLPHideParasite(String _eventName, String sParasite, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif
 	
	Debug.Trace("[SLP] Receiving 'hide parasite' event - Actor: " + kActor)

	fctParasites.clearParasiteNPCByString(kActor, sParasite) 
	StorageUtil.SetIntValue(kActor, "_SLP_iHiddenParasiteCount" , StorageUtil.GetIntValue(kActor, "_SLP_iHiddenParasiteCount") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iHiddenParasite_" + sParasite, 1)

	fctParasites.applyHiddenParasiteEffect(kActor, sParasite) 
EndEvent

Event OnSLPShowParasite(String _eventName, String sParasite, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'show parasite' event - Actor: " + kActor)

	fctParasites.equipParasiteNPCByString(kActor, sParasite) 
	StorageUtil.SetIntValue(kActor, "_SLP_iHiddenParasiteCount" ,  StorageUtil.GetIntValue(kActor, "_SLP_iHiddenParasiteCount") - 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iHiddenParasite_" + sParasite, 0)

	fctParasites.clearHiddenParasiteEffect(kActor, sParasite) 
EndEvent

Event OnSLPRefreshParasites(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	If (kActor == None)
 		kActor = PlayerRef
 	Endif

	Debug.Trace("[SLP] Receiving 'refresh parasites' event - Actor: " + kActor)
	refreshAllPArasites(kActor)
EndEvent

Function refreshAllPArasites(Actor kActor)
	debug.notification("[SLP] Refreshing parasites")
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
	debug.notification("[SLP] Refreshing parasites - done")
EndFunction

Event OnSLPRefreshBodyShape(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	iChaurusQueenStage = StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusQueenStage")

	Debug.Trace("[SLP] Receiving 'refresh body shape' event - Actor: " + kActor)

	If (fctParasites.isInfectedByString( kActor,  "SpiderEgg" )) || (fctParasites.isInfectedByString( kActor,  "SpiderPenis" ))
		Debug.Trace("[SLP] Refreshing belly shape (spider egg)")
		Int iNumSpiderEggs = StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount" )
		fctParasites.ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerRef, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerRef, "_SLP_bellyMaxSpiderEgg" ))
	EndIf

	If (fctParasites.isInfectedByString( kActor,  "ChaurusWorm" ))
		Debug.Trace("[SLP] Refreshing butt shape (chaurus worm)")
		fctParasites.ApplyBodyChange( kActor, "ChaurusWorm", "Butt", 1.5, StorageUtil.GetFloatValue(PlayerRef, "_SLP_buttMaxChaurusWorm" ))
	EndIf

	If (fctParasites.isInfectedByString( kActor,  "ChaurusWormVag" ))
		Debug.Trace("[SLP] Refreshing butt shape (vaginal chaurus worm)")
		fctParasites.ApplyBodyChange( kActor, "ChaurusWormVag", "Belly", 1.5, StorageUtil.GetFloatValue(PlayerRef, "_SLP_bellyMaxChaurusWormVag" ))
	EndIf

	If (fctParasites.isInfectedByString( kActor,  "TentacleMonster" ))
		Debug.Trace("[SLP] Refreshing breast shape (tentacle monster)")
		Int iParasiteDuration = GameDaysPassed.GetValue() as Int - StorageUtil.GetIntValue(kActor, "_SLP_iTentacleMonsterDate")
		Float fValue = 1.0 + (iParasiteDuration as Float) / StorageUtil.GetFloatValue(PlayerRef, "_SLP_breastMaxTentacleMonster" )
		fctParasites.ApplyBodyChange( kActor, "TentacleMonster", "Breast", fValue, StorageUtil.GetFloatValue(PlayerRef, "_SLP_breastMaxTentacleMonster" ) )
	EndIf

	If (fctParasites.isInfectedByString( kActor,  "LivingArmor" ))
		Debug.Trace("[SLP] Refreshing breast shape (living armor)")
		Int iParasiteDuration = GameDaysPassed.GetValue() as Int - StorageUtil.GetIntValue(kActor, "_SLP_iLivingArmorDate")
		Float fValue = 1.0 + (iParasiteDuration as Float) / StorageUtil.GetFloatValue(PlayerRef, "_SLP_breastMaxLivingArmor" )
		fctParasites.ApplyBodyChange( kActor, "LivingArmor", "Breast", fValue, StorageUtil.GetFloatValue(PlayerRef, "_SLP_breastMaxLivingArmor" ) )
	EndIf

	If (fctParasites.isInfectedByString( kActor,  "FaceHugger" )) || (fctParasites.isInfectedByString( kActor,  "FaceHuggerGag" ))
		Debug.Trace("[SLP] Refreshing belly shape (creepy critter)")
		Int iParasiteDuration = GameDaysPassed.GetValue() as Int - StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerDate")
		Float fValue = 1.0 + (iParasiteDuration as Float) / StorageUtil.GetFloatValue(PlayerRef, "_SLP_bellyMaxFaceHugger" )
		fctParasites.ApplyBodyChange( kActor, "FaceHugger", "Belly", fValue, StorageUtil.GetFloatValue(PlayerRef, "_SLP_bellyMaxFaceHugger" ) )
	EndIf

	If (iChaurusQueenStage >= 5) && (kActor == PlayerRef)
		Debug.Trace("[SLP] Refreshing belly shape (chaurus queen)")
		Int iNumChaurusEggs = StorageUtil.GetIntValue(kActor, "_SLP_iChaurusEggCount" )
		fctParasites.ApplyBodyChange( kActor, "ChaurusQueen", "Belly", 1.0 + (4.0 * (iNumChaurusEggs as Float) / StorageUtil.GetFloatValue(PlayerRef, "_SLP_bellyMaxChaurusQueen" )), StorageUtil.GetFloatValue(PlayerRef, "_SLP_bellyMaxChaurusQueen" ))
	EndIf
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	If (StorageUtil.GetIntValue(PlayerRef, "_SLP_iDisableParasitesOnSleep") == 1)
		Debug.Trace("[SLP] Parasites on Sleep disabled: " + StorageUtil.GetIntValue(PlayerRef, "_SLP_iDisableParasitesOnSleep"))
		Return
	Endif

	Location kLocation = PlayerRef.GetCurrentLocation()
	Bool bLocationAllowed = False
	Cell kActorCell = PlayerRef.GetParentCell()

	if (kLocation)
		If (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceBarnacles" )>0.0) 
			If kLocation.IsSameLocation(SLP_BlackreachLocation) || kLocation.HasKeyword(SLP_FalmerHiveLocType) || kLocation.HasKeyword(SLP_CaveLocType) || kLocation.HasKeyword(SLP_DwarvenRuinLocType)
				Debug.Trace("[SLP] Good location for Barnacles")
				bLocationAllowed = True
			else
				Debug.Trace("[SLP] Not a good location for Barnacles")
			endIf
		endIf

		if (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceFaceHugger" )>0.0) && (kActorCell.IsInterior())
			if kLocation.IsSameLocation(SLP_BlackreachLocation) || kLocation.HasKeyword(SLP_DraugrCryptLocType) || kLocation.HasKeyword(SLP_NordicRuinLocType) || kLocation.HasKeyword(SLP_MineLocType) || kLocation.HasKeyword(SLP_CaveLocType) || kLocation.HasKeyword(SLP_OutdoorLocType)
				Debug.Trace("[SLP] Good location for Face hugger")
				bLocationAllowed = True
			else
				Debug.Trace("[SLP] Not a good location for Face hugger")
			EndIf
		endIf

		if (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceFaceHuggerGag" )>0.0) && (kActorCell.IsInterior())
			if kLocation.IsSameLocation(SLP_BlackreachLocation) || kLocation.HasKeyword(SLP_DraugrCryptLocType) || kLocation.HasKeyword(SLP_NordicRuinLocType) || kLocation.HasKeyword(SLP_MineLocType) || kLocation.HasKeyword(SLP_CaveLocType) || kLocation.HasKeyword(SLP_OutdoorLocType)
				Debug.Trace("[SLP] Good location for Face hugger (gag)")
				bLocationAllowed = True
			else
				Debug.Trace("[SLP] Not a good location for Face hugger (gag)")
			EndIf
		endif

		if kLocation.IsSameLocation(SLP_BlackreachLocation)
			PlayerRef.SendModEvent("SLHModHormone", "Immunity", -1.0 * Utility.RandomFloat(1.0,10.0))
		endif
	else
		Debug.Trace("[SLP] Sleep location is empty")
	endIf

	if (bLocationAllowed)
		If (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceBarnacles" )>0.0) 
			; Sleeping naked in Blackreach -> chance of barnacles
			If (!fctParasites.ActorHasKeywordByString(PlayerRef, "Harness")) && (!fctParasites.ActorHasKeywordByString(PlayerRef, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerRef, "Barnacles")) && (fctOutfits.isActorNaked(PlayerRef)) && (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceBarnacles" ) as Int) )
				if (fctParasites.infectParasiteByString(PlayerRef, "Barnacles"))
					Debug.Trace("[SLP] Barnacle infection successful")
					Debug.MessageBox("As you wake up from an uneasy sleep, you discover your skin is covered with hard growths. They pulsate with a soft glow and burry painfully into your skin when you touch them.")
				Endif
			Else
				Debug.Trace("[SLP] Barnacle infection failed")
				Debug.Trace("[SLP]   Harness: " + fctParasites.ActorHasKeywordByString(PlayerRef, "Harness"))
				Debug.Trace("[SLP]   Is actor naked: " + fctOutfits.isActorNaked(PlayerRef))
				Debug.Trace("[SLP]   Barnacles equipped: " + fctParasites.ActorHasKeywordByString(PlayerRef, "Barnacles"))
				Debug.Trace("[SLP]   Chance infection: " + (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceBarnacles" ) as Int) )
			EndIf
		endif

		if (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceFaceHugger" )>0.0) 
			; Sleeping naked in a draugr crypt -> chance of face hugger
			If (!fctParasites.ActorHasKeywordByString(PlayerRef, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerRef, "Harness")) && (!fctParasites.ActorHasKeywordByString(PlayerRef, "PlugVaginal")) && (!fctParasites.ActorHasKeywordByString(PlayerRef, "FaceHugger")) && (fctOutfits.isActorNaked(PlayerRef)) && (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceFaceHugger" ) as Int) )
				if (fctParasites.infectParasiteByString(PlayerRef, "FaceHugger"))
					Debug.Trace("[SLP] Creepy crawler infection successful")
					Debug.MessageBox("As you wake up from a restless sleep, you find with horror that your exposed crotch is filled with the tail of a critter, firmly wrapped around your hips. The end of that tail throbs deeply inside you.")
				Endif
			Else
				Debug.Trace("[SLP] Creepy crawler infection failed")
				Debug.Trace("[SLP]   Belt: " + fctParasites.ActorHasKeywordByString(PlayerRef, "Belt"))
				Debug.Trace("[SLP]   Harness: " + fctParasites.ActorHasKeywordByString(PlayerRef, "Harness"))
				Debug.Trace("[SLP]   PlugVaginal: " + fctParasites.ActorHasKeywordByString(PlayerRef, "PlugVaginal"))
				Debug.Trace("[SLP]   Is actor naked: " + fctOutfits.isActorNaked(PlayerRef))
				Debug.Trace("[SLP]   Face Hugger equipped: " + fctParasites.ActorHasKeywordByString(PlayerRef, "FaceHugger"))
				Debug.Trace("[SLP]   Chance infection: " + (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceFaceHugger" ) as Int) )
			EndIf
		endif

		if (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceFaceHuggerGag" )>0.0)
			; Sleeping naked in a draugr crypt -> chance of face hugger
			If (!fctParasites.ActorHasKeywordByString(PlayerRef, "Gag")) && (!fctParasites.ActorHasKeywordByString(PlayerRef, "FaceHuggerGag")) && (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceFaceHuggerGag" ) as Int) )
				if (fctParasites.infectParasiteByString(PlayerRef, "FaceHuggerGag"))
					Debug.Trace("[SLP] Creepy crawler (face) infection successful")
					Debug.MessageBox("A suffocating sensation wakes you suddenly. You find your face wrapped in the sticky embrace of a creature as its tail squirms deeply into your throat. Surprisinly, you seem to be breathing through the creature.")
				Endif
			Else
				Debug.Trace("[SLP] Creepy crawler (face) infection failed")
				Debug.Trace("[SLP]   Gag: " + fctParasites.ActorHasKeywordByString(PlayerRef, "Gag"))
				Debug.Trace("[SLP]   Face Hugger Gag equipped: " + fctParasites.ActorHasKeywordByString(PlayerRef, "FaceHuggerGag"))
				Debug.Trace("[SLP]   Chance infection: " + (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceFaceHuggerGag" ) as Int) )
			EndIf
		else
			Debug.Trace("[SLP] Not a good location for Face hugger")
		EndIf
	endif

	; Hormones compatibility
	If (fctParasites.ActorHasKeywordByString(PlayerRef, "FaceHugger")) || (fctParasites.ActorHasKeywordByString(PlayerRef, "FaceHuggerGag")) || (fctParasites.ActorHasKeywordByString(PlayerRef, "ChaurusWorm"))
		PlayerRef.SendModEvent("SLHModHormone", "Female", 10.0 + Utility.RandomFloat(0.0,10.0))
		PlayerRef.SendModEvent("SLHModHormone", "SexDrive", 1.0 + Utility.RandomFloat(0.0,5.0))
	endif 
	
	If ( (fctParasites.ActorHasKeywordByString(PlayerRef, "SpiderEgg")) || (fctParasites.ActorHasKeywordByString(PlayerRef, "SpiderPenis")) ) 
		PlayerRef.SendModEvent("SLHModHormone", "SexDrive", 5.0 + Utility.RandomFloat(0.0,10.0))
	endif

	If (fctParasites.ActorHasKeywordByString(PlayerRef, "TentacleMonster"))
		PlayerRef.SendModEvent("SLHModHormone", "Immunity", 1.0 * Utility.RandomFloat(0.0,10.0))
		PlayerRef.SendModEvent("SLHModHormone", "Lactation", 10.0 + Utility.RandomFloat(0.0,10.0))
	endif 

	If (fctParasites.ActorHasKeywordByString(PlayerRef, "Barnacles"))
		PlayerRef.SendModEvent("SLHModHormone", "Immunity", -1.0 * Utility.RandomFloat(0.0,10.0))
		PlayerRef.SendModEvent("SLHModHormone", "Pheromones", 1.0 + Utility.RandomFloat(0.0,5.0))
	endif 

	If (fctParasites.ActorHasKeywordByString(PlayerRef, "ChaurusQueenVag"))
		PlayerRef.SendModEvent("SLHModHormone", "Pheromones", 10.0 + Utility.RandomFloat(0.0,20.0))
		PlayerRef.SendModEvent("SLHModHormone", "Lactation", -1.0 * Utility.RandomFloat(0.0,10.0))
	endif 

	If (fctParasites.ActorHasKeywordByString(PlayerRef, "SprigganRootGag")) || (fctParasites.ActorHasKeywordByString(PlayerRef, "SprigganRootArms")) || (fctParasites.ActorHasKeywordByString(PlayerRef, "SprigganRootFeet")) || (fctParasites.ActorHasKeywordByString(PlayerRef, "SprigganRootBody"))
		PlayerRef.SendModEvent("SLHModHormone", "Female", 20.0 + Utility.RandomFloat(0.0,10.0))
		PlayerRef.SendModEvent("SLHModHormone", "Male", -1.0 * (10.0 + Utility.RandomFloat(0.0,10.0)) )
		PlayerRef.SendModEvent("SLHModHormone", "Metabolism", 10.0 + Utility.RandomFloat(0.0,10.0))
	endif 

	; Clean up Quest Aliases if parasites are not equipped anymore 
	fctParasites.clearParasiteAlias(PlayerRef, "FaceHugger" )
	fctParasites.clearParasiteAlias(PlayerRef, "ChaurusWorm" )
	fctParasites.clearParasiteAlias(PlayerRef, "SpiderEgg" )
	fctParasites.clearParasiteAlias(PlayerRef, "SpiderPenis" )

	; If (!fctParasites.ActorHasKeywordByString(PlayerRef, "TentacleMonster"))
	;	fctParasites.clearParasiteAlias(PlayerRef, "TentacleMonster" )
	; endif

	; If (!fctParasites.ActorHasKeywordByString(PlayerRef, "LivingArmor"))
	;	fctParasites.clearParasiteAlias(PlayerRef, "LivingArmor" )
	; endif

	; If (!fctParasites.ActorHasKeywordByString(PlayerRef, "Barnacles"))
	;	fctParasites.clearParasiteAlias(PlayerRef, "Barnacles" )
	; endif

	; If (!fctParasites.ActorHasKeywordByString(PlayerRef, "SprigganRoot"))
	;	fctParasites.clearParasiteAlias(PlayerRef, "SprigganRoot" )
	; endif

	; Bring Lastelle where she belongs if needed
	fctParasites.resetOnSleep()
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	GoToState("Busy")

	if StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusQueenStage") >= 3
		if akBaseObject as Ingredient
			Ingredient thisIngredient = akBaseObject as Ingredient
			; eating
			; Debug.Notification("This actor just ate an ingredient type: " + akBaseObject.GetType())

			; Spider egg = type 30

			if (thisIngredient == IngredientSpiderEgg) || (StringUtil.Find(akBaseObject.GetName(), "Spider Egg")>=0)
				; Debug.Notification("This actor just ate a spider egg")
				fctParasites.forceChaurusQueenStage(310, 320)
				fctParasites.tryPlayerSpiderStage()
			elseif (thisIngredient == IngredientChaurusEgg) || (StringUtil.Find(akBaseObject.GetName(), "Chaurus Egg")>=0)
				; Debug.Notification("This actor just ate a chaurus egg")
				fctParasites.forceChaurusQueenStage(340,350)
				fctParasites.tryPlayerChaurusStage()
			endif
		endif
	endIf

	GoToState("")
endEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	GoToState("Busy")

	Actor kTarget = akAggressor as Actor

	If (kTarget != None) && (kTarget != PlayerRef)
		;Debug.Trace("We were hit by " + akAggressor)

		if (StorageUtil.GetIntValue(PlayerRef, "_SLP_iSpiderPheromoneON") == 1 )
			fctParasites.tryCharmSpider( kTarget )
		endif
		if (StorageUtil.GetIntValue(PlayerRef, "_SLP_iChaurusPheromoneON") == 1 )
			fctParasites.tryCharmChaurus( kTarget )
		endif
		if (StorageUtil.GetFloatValue(PlayerRef, "_SLP_chanceSprigganRootArms") > 0.0 )
			fctParasites.tryPlayerSpriggan( kTarget )
		endif
	EndIf

	GoToState("")
EndEvent

Actor Function _firstNotPlayer(Actor[] _actors)
	int idx = 0
	while idx < _actors.Length
		if _actors[idx] != PlayerRef
			return _actors[idx]
		endif
		idx += 1
	endwhile
	Return None
EndFunction

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

Potion Property SLP_CritterSemen Auto


int daysPassed
int iGameDateLastCheck = -1
int iDaysSinceLastCheck
int iNextStageThrottle = 0

Int iChaurusQueenStage 
Int	iChaurusQueenDate
Int iChaurusQueenFlaresFrequency

Event OnInit()
	_maintenance()

EndEvent

Event OnPlayerLoadGame()
	_maintenance()

EndEvent

Function _maintenance()
 	Actor PlayerActor= Game.GetPlayer() as Actor
 	ActorBase pActorBase = PlayerActor.GetActorBase()

	if (!fctParasites.isNiOInstalled)
		fctParasites.isNiOInstalled = fctParasites.CheckXPMSERequirements(PlayerActor, pActorBase.GetSex())
	EndIf

	fctParasites.isSlifInstalled = Game.GetModbyName("SexLab Inflation Framework.esp") != 255

	If (!StorageUtil.HasIntValue(none, "_SLP_iSexLabParasites"))
		StorageUtil.SetIntValue(none, "_SLP_iSexLabParasites", 1)
		fctParasites._resetParasiteSettings()
	EndIf

	; Set Seed Stone ritual to today if missing
	if (StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")==1) && (StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenDate")==0)
		StorageUtil.SetIntValue(PlayerActor, "_SLP_iChaurusQueenDate", Game.QueryStat("Days Passed"))
	endif

	; Set flags about known methods to remove parasites
 	StorageUtil.SetIntValue(PlayerActor, "_SLP_iSpiderEggsKnown", KynesBlessingQuest.GetStageDone(30) as Int)
 	StorageUtil.SetIntValue(PlayerActor, "_SLP_iChaurusWormKnown", KynesBlessingQuest.GetStageDone(40) as Int)
 	StorageUtil.SetIntValue(PlayerActor, "_SLP_iHuggersKnown", KynesBlessingQuest.GetStageDone(50) as Int)
 	StorageUtil.SetIntValue(PlayerActor, "_SLP_iTentacleMonsterKnown", KynesBlessingQuest.GetStageDone(60) as Int)
 	StorageUtil.SetIntValue(PlayerActor, "_SLP_iLivingArmorKnown", KynesBlessingQuest.GetStageDone(70) as Int)
 	StorageUtil.SetIntValue(PlayerActor, "_SLP_iBarnaclesKnown", KynesBlessingQuest.GetStageDone(80) as Int)


	UnregisterForAllModEvents()
	Debug.Trace("SexLab Parasites: Reset SexLab events")
	RegisterForModEvent("AnimationStart", "OnSexLabStart")
	RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")
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



Event OnUpdate()
 	Actor PlayerActor= Game.GetPlayer() as Actor
	Location kLocation = PlayerActor.GetCurrentLocation()
 	Int iParasiteDuration
 	Float fValue

 	daysPassed = Game.QueryStat("Days Passed")

 	; Initial values
 	if (iGameDateLastCheck == -1)
 		iGameDateLastCheck = daysPassed
 	endIf
 
	iDaysSinceLastCheck = (daysPassed - iGameDateLastCheck ) as Int

	If (iDaysSinceLastCheck > 0)
		; New day
		
		If (fctParasites.isInfectedByString( PlayerActor,  "SpiderPenis" ))
			iParasiteDuration = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(PlayerActor, "_SLP_iSpiderPenisDate")
			If (Utility.RandomInt(0,100) > (100 - (iParasiteDuration * 10) ) )
				Debug.MessageBox("The remains of the spider penis finally slide out of you.")
				; PlayerActor.SendModEvent("SLPCureSpiderPenis")
				fctParasites.cureSpiderPenis( PlayerActor   )
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
			ElseIf (iParasiteDuration >= 5)
				Debug.MessageBox("Your belly suddenly expells copious amounts of thick fluids.")
				StorageUtil.SetIntValue(PlayerActor, "_SLP_iFaceHuggerDate", Game.QueryStat("Days Passed"))
				fValue = 1.0
				PlayerActor.AddItem(SLP_CritterSemen, 1)
				fctParasites.ApplyBodyChange( PlayerActor, "FaceHugger", "Belly", fValue, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ) )
			endif
		Endif
		If (fctParasites.isInfectedByString( PlayerActor,  "Barnacles" ))
			iParasiteDuration = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(PlayerActor, "_SLP_iBarnaclesDate")
			If  (iParasiteDuration > 5) && (!kLocation.IsSameLocation(SLP_BlackreachLocation)) && (!kLocation.HasKeyword(SLP_FalmerHiveLocType)) && (!kLocation.HasKeyword(SLP_CaveLocType)) && (!kLocation.HasKeyword(SLP_DwarvenRuinLocType))
				Debug.Messagebox("The spores evaporated on their own.")
				fctParasites.cureBarnacles( PlayerActor   )
				PlayerActor.SendModEvent("SLPTriggerEstrusChaurusBirth", "Barnacles", Utility.RandomInt(1, 5))
			  	
			endIf
		endif

	else
		; updates during the day
		iChaurusQueenStage = StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")
		iChaurusQueenDate = StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenDate")

		if (iChaurusQueenStage>=1) 
			if (fctParasites.isPlayerInHeat())
				iChaurusQueenFlaresFrequency = 10 - (Game.QueryStat("Days Passed") - iChaurusQueenDate)
			else
				; reduce frequency of flares if player isn't in heat
				iChaurusQueenFlaresFrequency = 100
			endif

			(StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenDate")==0)

			if (Utility.RandomInt(0,100) < (iNextStageThrottle / iChaurusQueenFlaresFrequency))
				debug.trace("[SLP] tryParasiteNextStage")
				debug.trace("[SLP]    iChaurusQueenFlaresFrequency: " + iChaurusQueenFlaresFrequency)
				debug.trace("[SLP]    iNextStageThrottle: " + iNextStageThrottle)
				debug.trace("[SLP]    threshold: " + (iNextStageThrottle / iChaurusQueenFlaresFrequency))

			 	if (fctParasites.tryParasiteNextStage(PlayerActor, "ChaurusQueen"))
			 		; next stage happened - reset counter
			 		iNextStageThrottle = 0
			 	else
			 		; next stage didn't happen - set back counter and try again soon
			 		iNextStageThrottle = iNextStageThrottle - (iNextStageThrottle / 4)
			 	endif

			endif
		endif

		iNextStageThrottle = iNextStageThrottle + 1
 
	endIf

	iGameDateLastCheck = daysPassed  

	RegisterForSingleUpdate(10)
EndEvent


Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 
	Int iProlactinLevel 

	if !Self || !SexLab 
		Debug.Trace("SexLab Parasites: Critical error on SexLab Start")
		Return
	EndIf
	
	; Debug.Notification("[SLP] Sex start")
	; Debug.Trace("[SLP] Sex start")

	Actor[] actors = SexLab.HookActors(_args)
	Actor   victim = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim
	
	; Debug.Notification("[SLP]  Has player: " + _hasPlayer(actors))
	; Debug.Trace("[SLP]  Has player: " + _hasPlayer(actors))
	; Debug.Notification("Arousal trigger: " + (slaUtil.GetActorExposure(akRef = PlayerActor) / 3))

	If (_hasPlayer(actors))
		If (fctParasites.isInfectedByString( PlayerActor,  "SpiderEgg" ))
			slaUtil.UpdateActorExposure(akRef = PlayerActor, val = 2, debugMsg = "Aroused from sex while carrying spider eggs.")
		ElseIf (fctParasites.isInfectedByString( PlayerActor,  "SpiderPenis" ))
			slaUtil.UpdateActorExposure(akRef = PlayerActor, val = 5, debugMsg = "Aroused from sex while carrying spider eggs.")
		ElseIf (fctParasites.isInfectedByString( PlayerActor,  "ChaurusWorm" )) || (fctParasites.isInfectedByString( PlayerActor,  "ChaurusWormVag" ))
			slaUtil.UpdateActorExposure(akRef = PlayerActor, val = 10, debugMsg = "Aroused from sex while carrying chaurus worm.")
		Endif
	endif

	; Debug.Notification("SexLab Hormones: Forced refresh flag: " + StorageUtil.GetIntValue(none, "_SLH_iForcedRefresh"))
	
	If victim	;none consensual
		;

	Else        ;consensual
		;
		
	EndIf


EndEvent

Event OnSexLabEnd(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
    sslBaseAnimation animation = SexLab.HookAnimation(_args)
    Float fBreastScale 
    Float fChanceChaurusWorm
    Float fChanceChaurusWormVag
    Float fChanceSpiderPenis
    Float fChanceSpiderEgg
    Actor kSexPartner 

	if !Self || !SexLab 
		Debug.Trace("SexLab Parasites: Critical error on SexLab End")
		Return
	EndIf


	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	; Debug.Notification("[SLP] Sex end")
	; Debug.Trace("[SLP] Sex end")

	; if config.bDebugMsg
	; 	_listActors("End: ", actors)
	; EndIf

	; If (_hasPlayer(actors))
		;
	; EndIf
	If (_hasPlayer(actors))
		; Debug.Notification("[SLP] Player in animation")
		Debug.Trace("[SLP] OnSexLabEnd: Player in animation")

 		iChaurusQueenStage = StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")
    	fChanceChaurusWorm = StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" )
    	fChanceChaurusWormVag = StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" )
     	fChanceSpiderPenis = StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderPenis" )
     	fChanceSpiderEgg = StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" )

		If (fctParasites.isInfectedByString( PlayerActor,  "ChaurusQueenVag" ))  
			; Player is more receptive if the vaginal pincer is extended
	    	fChanceChaurusWorm = fChanceChaurusWorm + 50.0
	    	fChanceChaurusWormVag = fChanceChaurusWormVag + 50.0
	     	fChanceSpiderPenis = 0.0
	     	fChanceSpiderEgg = fChanceSpiderEgg + 50.0
   			debug.Notification("The tentacle retracts inside you.")
			fctParasites.cureChaurusQueenVag( PlayerActor  )

		ElseIf (fctParasites.isInfectedByString( PlayerActor,  "ChaurusQueenSkin" ))  
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

		if animation.HasTag("Chaurus") ; && (_SDGVP_enable_parasites.GetValue() == 1)
			; check if player reached the Chaurus stage of the Chaurus Queen tranformation
			fctParasites.tryPlayerChaurusStage()

			If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "PlugAnal"))

				if (Utility.RandomInt(1,100)<= (fChanceChaurusWorm as Int) )
					; PlayerActor.SendModEvent("SLPInfectChaurusWorm")
					if (fctParasites.infectChaurusWorm( PlayerActor   ))
						iNextStageThrottle = 0
						Debug.MessageBox("You moan helplessly as a thick worm forces itself inside your guts.")
					Endif
				Endif

				if (Utility.RandomInt(1,100)<= (fChanceChaurusWormVag as Int) )
					; PlayerActor.SendModEvent("SLPInfectChaurusWormVag")
					if (fctParasites.infectChaurusWormVag( PlayerActor   ))
						iNextStageThrottle = 0
						Debug.MessageBox("You shudder deeply as a squirming worm forces itself inside your womb.")
					Endif
				Endif

			EndIf

			if (StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")>=5)
				fctParasites.getRandomChaurusEggs(PlayerActor, 0, 20)
			endif
		EndIf

		if animation.HasTag("Spider") ; && (_SDGVP_enable_parasites.GetValue() == 1)
			; Debug.Notification("[SLP] Sex with spider")
			; Debug.Trace("[SLP] Sex with spider")

			If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "PlugVaginal"))
				; Debug.Notification("[SLP] Player vulnerable to spider")
				; Debug.Trace("[SLP] Player vulnerable to spider")

				if (Utility.RandomInt(1,100)<= (fChanceSpiderPenis as Int) )
					; Debug.Notification("[SLP] Receiving spider penis")
					; Debug.Trace("[SLP] Receiving spider penis")

					; PlayerActor.SendModEvent("SLPInfectSpiderPenis")
					if (fctParasites.infectSpiderPenis( PlayerActor   ))
						iNextStageThrottle = 0
						kSexPartner = _firstNotPlayer(actors)
						SpiderFollowerAlias.ForceRefTo(kSexPartner)

						Debug.MessageBox("You gasp as the spider fills your womb with a string of slimy eggs. Unfortunately, the penis of the spider remains firmly lodged inside you after the act.")
					Endif

				elseif (Utility.RandomInt(1,100)<= (fChanceSpiderEgg as Int) )
					; Debug.Notification("[SLP] Receiving spider eggs")
					; Debug.Trace("[SLP] Receiving spider eggs")
					; PlayerActor.SendModEvent("SLPInfectSpiderEgg")
					if (fctParasites.infectSpiderEgg( PlayerActor   ))
						iNextStageThrottle = 0
						Debug.MessageBox("You gasp as the spider fills your womb with a string of slimy eggs.")
					Endif

				else
					Debug.Trace("[SLP] OnSexLabEnd: Sex didn't result in eggs - better luck next time")
				endif
			Else
				Debug.Trace("[SLP] OnSexLabEnd: Player wearing a Belt or Vaginal plug - aborting")
			EndIf
		EndIf
	Else
		; Debug.Notification("[SLP] Player NOT in animation")
		Debug.Trace("[SLP] OnSexLabEnd: Player NOT in animation")
	Endif

	int idx = 0
	while idx < actors.Length
		if (actors[idx]) && ( actors[idx] != PlayerActor) && ( actors[idx].IsInFaction(PlayerFollowerFaction))
			Debug.Trace("[SLP] Checking follower for parasites")
			if animation.HasTag("Chaurus") ; && (_SDGVP_enable_parasites.GetValue() == 1)
				If (!fctParasites.ActorHasKeywordByString(actors[idx], "Belt")) && (!fctParasites.ActorHasKeywordByString(actors[idx], "PlugAnal"))

					if (Utility.RandomInt(1,100)< (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" ) as Int) )
						; actors[idx].SendModEvent("SLPInfectChaurusWorm")
						fctParasites.infectChaurusWorm( actors[idx]   )
					Endif

					if (Utility.RandomInt(1,100)< (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" ) as Int) )
						; actors[idx].SendModEvent("SLPInfectChaurusWormVag")
						fctParasites.infectChaurusWormVag( actors[idx]   )
					Endif

				EndIf
			EndIf

			if animation.HasTag("Spider") ; && (_SDGVP_enable_parasites.GetValue() == 1)
				If (!fctParasites.ActorHasKeywordByString(actors[idx], "Belt")) && (!fctParasites.ActorHasKeywordByString(actors[idx], "PlugVaginal"))

					if (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderPenis" ) as Int) )
						; actors[idx].SendModEvent("SLPInfectSpiderPenis")
						fctParasites.infectSpiderPenis( actors[idx]   )

					elseif (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) as Int) )
						; actors[idx].SendModEvent("SLPInfectSpiderEgg")
						fctParasites.infectSpiderEgg( actors[idx]   )
					endif
				EndIf
			EndIf
		endIf
		idx += 1
	endwhile
	; Debug.Trace("[SLP] Sex end - end")
EndEvent 

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
    sslBaseAnimation animation = SexLab.HookAnimation(_args)
 
	if !Self || !SexLab 
		Debug.Trace("SexLab Parasites: Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	; Debug.Notification("[SLP] Orgasm")
	; Debug.Trace("[SLP] Orgasm")
	; 
	if (_hasPlayer(actors))
		if animation.HasTag("Spider")  
	 
			if (fctParasites.isInfectedByString( PlayerActor,  "SpiderEgg" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) / 4))
				Debug.MessageBox("As you lay on the floor, still panting, you realize the spider extracted the fertilized eggs out of your exhausted body.")
				; PlayerActor.SendModEvent("SLPCureSpiderEgg","All")
				fctParasites.cureSpiderEgg( PlayerActor, "All"  )
				PlayerActor.PlaceAtMe(EggSac)
			endIf
	 
		EndIf

		If (fctParasites.isInfectedByString( PlayerActor,  "ChaurusWorm" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" ) / 5))
				Debug.MessageBox("The power of your orgasm is enough to expel the worm from your bowels, making you nearly black out from the added stimulation.")
				; PlayerActor.SendModEvent("SLPCureChaurusWorm")
				fctParasites.cureChaurusWorm( PlayerActor  )
		EndIf

		If (fctParasites.isInfectedByString( PlayerActor,  "ChaurusWormVag" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" ) / 5))
				Debug.MessageBox("The power of your orgasm is enough to expel the worm, making you nearly black out from the added stimulation.")
				; PlayerActor.SendModEvent("SLPCureChaurusWormVag")
				fctParasites.cureChaurusWormVag( PlayerActor  ) 
		EndIf
	endif

	int idx = 0
	while idx < actors.Length
		if (actors[idx]) && ( actors[idx] != PlayerActor) 
			if animation.HasTag("Spider")  
				if (fctParasites.isInfectedByString( actors[idx],  "SpiderEgg" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) / 4))
					; actors[idx].SendModEvent("SLPCureSpiderEgg","All")
					fctParasites.cureSpiderEgg( actors[idx], "All"  )
					actors[idx].PlaceAtMe(EggSac)
				endIf
			endif

			If (fctParasites.isInfectedByString( actors[idx],  "ChaurusWorm" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" ) / 5))
					; actors[idx].SendModEvent("SLPCureChaurusWorm")
					fctParasites.cureChaurusWorm( actors[idx]  ) 
			EndIf

			If (fctParasites.isInfectedByString( actors[idx],  "ChaurusWormVag" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" ) / 5))
					; actors[idx].SendModEvent("SLPCureChaurusWormVag")
					fctParasites.cureChaurusWormVag( actors[idx]  ) 
			EndIf

		endIf
		idx += 1
	endwhile
	; Debug.Trace("[SLP] Orgasm - end")
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int Thread)

    string _args = Thread as string
    actor kActor = ActorRef as actor
    ObjectReference PlayerREF= PlayerAlias.GetReference()
    Actor PlayerActor= PlayerAlias.GetReference() as Actor
    sslBaseAnimation animation = SexLab.HookAnimation(_args)
 
    if !Self || !SexLab 
        Debug.Trace("SexLab Parasites: Critical error on SexLab Orgasm")
        Return
    EndIf

    Actor[] actors  = SexLab.HookActors(_args)
    Actor   victim  = SexLab.HookVictim(_args)
    Actor[] victims = new Actor[1]
    victims[0] = victim

    ; Debug.Notification("[SLP] Orgasm")
    ; Debug.Trace("[SLP] Orgasm")
    ; 
    if (_hasPlayer(actors) && kActor == PlayerActor)
        if animation.HasTag("Spider")  
     
            if (fctParasites.isInfectedByString( PlayerActor,  "SpiderEgg" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) / 4))
                Debug.MessageBox("As you lay on the floor, still panting, you realize the spider extracted the fertilized eggs out of your exhausted body.")
                ; PlayerActor.SendModEvent("SLPCureSpiderEgg","All")
                fctParasites.cureSpiderEgg( PlayerActor, "All"  )
                PlayerActor.PlaceAtMe(EggSac)
            endIf
     
        EndIf

        If (fctParasites.isInfectedByString( PlayerActor,  "ChaurusWorm" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" ) / 5))
                Debug.MessageBox("The power of your orgasm is enough to expel the worm from your bowels, making you nearly black out from the added stimulation.")
                ; PlayerActor.SendModEvent("SLPCureChaurusWorm")
                fctParasites.cureChaurusWorm( PlayerActor  )
        EndIf

        If (fctParasites.isInfectedByString( PlayerActor,  "ChaurusWormVag" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" ) / 5))
                Debug.MessageBox("The power of your orgasm is enough to expel the worm, making you nearly black out from the added stimulation.")
                ; PlayerActor.SendModEvent("SLPCureChaurusWormVag")
                fctParasites.cureChaurusWormVag( PlayerActor  ) 
        EndIf
    endif

	if (kActor) && ( kActor != PlayerActor) 
		if animation.HasTag("Spider")  
			if (fctParasites.isInfectedByString( kActor,  "SpiderEgg" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) / 4))
				; kActor.SendModEvent("SLPCureSpiderEgg","All")
				fctParasites.cureSpiderEgg( kActor, "All"  )
				kActor.PlaceAtMe(EggSac)
			endIf
		endif

		If (fctParasites.isInfectedByString( kActor,  "ChaurusWorm" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" ) / 5))
				; kActor.SendModEvent("SLPCureChaurusWorm")
				fctParasites.cureChaurusWorm( kActor  ) 
		EndIf

		If (fctParasites.isInfectedByString( kActor,  "ChaurusWormVag" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" ) / 5))
				; kActor.SendModEvent("SLPCureChaurusWormVag")
				fctParasites.cureChaurusWormVag( kActor  ) 
		EndIf

	endIf
    ; Debug.Trace("[SLP] Orgasm - end")
EndEvent

Event OnArachnophobiaPlayerCaptured(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()

 	PlayerActor.SendModEvent("PCSubFree")

	If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "PlugVaginal"))

		if (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderPenis" ) as Int) )
			; PlayerActor.SendModEvent("SLPInfectSpiderPenis")
			fctParasites.infectSpiderPenis( PlayerActor  )

		elseif (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) as Int) )
			; PlayerActor.SendModEvent("SLPInfectSpiderEgg")
			fctParasites.infectSpiderEgg( PlayerActor  )
		endif
	EndIf
EndEvent

Event OnECBirthCompleted(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()


	If ( (fctParasites.isInfectedByString( kActor,  "ChaurusWorm" )) || (fctParasites.isInfectedByString( kActor,  "ChaurusWormVag" )) )
		Debug.MessageBox("The excruciating contractions expelling the eggs out of your body push out your chaurus worms as well.")
		fctParasites.cureChaurusWorm( kActor  ) 
		fctParasites.cureChaurusWormVag( kActor  ) 
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

	fctParasites.infectSpiderEgg( kActor   )
	
EndEvent

Event OnSLPCureSpiderEgg(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure spider egg' event - Actor: " + kActor)

	fctParasites.cureSpiderEgg( kActor, _args  )
	
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

	fctParasites.infectSpiderPenis( kActor   )

	
EndEvent

Event OnSLPCureSpiderPenis(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'cure spider penis' event - Actor: " + kActor)

	fctParasites.cureSpiderPenis( kActor   )
	
EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectChaurusWorm(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()
 
 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'infect chaurus worm' event - Actor: " + kActor)

	fctParasites.infectChaurusWorm( kActor   )
	
EndEvent

Event OnSLPCureChaurusWorm(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus worm' event - Actor: " + kActor)

	fctParasites.cureChaurusWorm( kActor   )

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

	fctParasites.infectChaurusWormVag( kActor   )
	
EndEvent

Event OnSLPCureChaurusWormVag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus worm vaginal' event - Actor: " + kActor)

	fctParasites.cureChaurusWormVag( kActor   )

EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectEstrusTentacles(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'infect estrus tentacle' event - Actor: " + kActor)
	
	fctParasites.infectEstrusTentacles( kActor   )
	
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

	fctParasites.infectTentacleMonster( kActor   )
	
EndEvent

Event OnSLPCureTentacleMonster(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'cure tentacle monster' event - Actor: " + kActor)

	fctParasites.cureTentacleMonster( kActor   )

EndEvent

;------------------------------------------------------------------------------
Event OnSLPInfectEstrusSlime(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'infect estrus slime' event - Actor: " + kActor)

	fctParasites.infectEstrusSlime( kActor   )
	
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

	fctParasites.infectLivingArmor( kActor   )
	
EndEvent

Event OnSLPCureLivingArmor(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'cure living armor' event - Actor: " + kActor)

	fctParasites.cureLivingArmor( kActor   )

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

	fctParasites.infectFaceHugger( kActor   )
	
EndEvent

Event OnSLPCureFaceHugger(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif

	Debug.Trace("[SLP] Receiving 'cure face hugger' event - Actor: " + kActor)

	fctParasites.cureFaceHugger( kActor   )

EndEvent

Event OnSLPInfectFaceHuggerGag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	
 
	Debug.Trace("[SLP] Receiving 'infect face hugger (gag)' event - Actor: " + kActor)

	fctParasites.infectFaceHuggerGag( kActor   )
	
EndEvent

Event OnSLPCureFaceHuggerGag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'cure face hugger (gag)' event - Actor: " + kActor)

	fctParasites.cureFaceHuggerGag( kActor   )

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

	fctParasites.infectBarnacles( kActor   )
	
EndEvent

Event OnSLPCureBarnacles(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'cure barnacles' event - Actor: " + kActor)

	fctParasites.cureBarnacles( kActor   )

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

	fctParasites.infectChaurusQueenVag( kActor   )
	
EndEvent

Event OnSLPCureChaurusQueenVag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen vaginal' event - Actor: " + kActor)

	fctParasites.cureChaurusQueenVag( kActor   )

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

	fctParasites.infectChaurusQueenGag( kActor   )
	
EndEvent

Event OnSLPCureChaurusQueenGag(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen mask' event - Actor: " + kActor)

	fctParasites.cureChaurusQueenGag( kActor   )

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

	fctParasites.infectChaurusQueenSkin( kActor   )
	
EndEvent

Event OnSLPCureChaurusQueenSkin(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen skin' event - Actor: " + kActor)

	fctParasites.cureChaurusQueenSkin( kActor   )

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

	fctParasites.infectChaurusQueenArmor( kActor   )
	
EndEvent

Event OnSLPCureChaurusQueenArmor(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen armor' event - Actor: " + kActor)

	fctParasites.cureChaurusQueenArmor( kActor   )

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

	fctParasites.infectChaurusQueenBody( kActor   )
	
EndEvent

Event OnSLPCureChaurusQueenBody(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 
	Debug.Trace("[SLP] Receiving 'cure chaurus queen body' event - Actor: " + kActor)

	fctParasites.cureChaurusQueenBody( kActor   )

EndEvent
;------------------------------------------------------------------------------
Event OnSLPInfectEstrusChaurusEgg(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
  	Actor PlayerActor = Game.GetPlayer()

 	If (kActor == None)
 		kActor = PlayerActor
 	Endif
 	

	Debug.Trace("[SLP] Receiving 'infect estrus chaurus egg' event - Actor: " + kActor)

	ActorBase pActorBase = kActor.GetActorBase()

	if (pActorBase.GetSex()==0)
		Debug.Trace("[SLP]  	Actor is male - aborting infection")
		return
	Endif

	fctParasites.infectEstrusChaurusEgg( kActor   )
	
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

	fctParasites.triggerEstrusChaurusBirth( kActor, sParasite, iBirthItemCount  )
	
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
			anims = new sslBaseAnimation[1]
			anims = SexLab.GetAnimationsByTags(2, sTags,"Estrus,Dwemer")

			SexLab.StartSex(sexActors, anims)
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
			anims = new sslBaseAnimation[1]
			anims = SexLab.GetAnimationsByTags(1, sTags,"Estrus,Dwemer")

			SexLab.StartSex(sexActors, anims)
		Else
			Debug.Trace("[SLP] Player Actor not ready - skipping parasite cure sex scene")
		EndIf
	endif


	If (!bIsPlayerHealer)
		kActor = kPlayer
		Debug.Trace("[SLP]  	Player is the patient")
	Else
		Debug.Trace("[SLP]  	Player is the healer")
	Endif

	Debug.Trace("[SLP]  	Curing from: " + sParasite)
	Debug.Trace("[SLP]  	Curing actor: " + kActor)

	If (sParasite == "SpiderEgg")
		fctParasites.cureSpiderEgg(kActor,"All", bHarvestParasite)

		If (!bHarvestParasite)
			kPlayer.AddItem(IngredientSpiderEgg,Utility.RandomInt(5,10))
		Endif

	ElseIf (sParasite == "ChaurusWorm")
		fctParasites.cureChaurusWorm(kActor, bHarvestParasite)

		If (!bHarvestParasite)
			kPlayer.AddItem(IngredientChaurusWorm,1)
		Endif
		
	ElseIf (sParasite == "ChaurusWormVag")
		fctParasites.cureChaurusWormVag(kActor, bHarvestParasite)

		If (!bHarvestParasite)
			kPlayer.AddItem(IngredientChaurusWorm,1)
		Endif
		
	ElseIf (sParasite == "FaceHugger")
		fctParasites.cureFaceHugger(kActor, bHarvestParasite)
		
	ElseIf (sParasite == "FaceHuggerGag")
		fctParasites.cureFaceHuggerGag(kActor, bHarvestParasite)
	Endif
EndEvent

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

	fctParasites.cureSpiderEgg(kActor,"All", bHarvestParasite)
	fctParasites.cureSpiderPenis(kActor,bHarvestParasite)
 	fctParasites.cureChaurusWorm(kActor, bHarvestParasite)
 	fctParasites.cureChaurusWormVag(kActor, bHarvestParasite)
	fctParasites.cureTentacleMonster( kActor )
	fctParasites.cureLivingArmor( kActor )
  	fctParasites.cureFaceHugger(kActor, bHarvestParasite)
	fctParasites.cureFaceHuggerGag(kActor, bHarvestParasite)
	fctParasites.cureBarnacles( kActor )

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

	; fctParasites.cureSpiderEgg(kActor,"All", bHarvestParasite)
	; fctParasites.cureSpiderPenis(kActor,bHarvestParasite)
 	; fctParasites.cureChaurusWorm(kActor, bHarvestParasite)
 	; fctParasites.cureChaurusWormVag(kActor, bHarvestParasite) 
	fctParasites.refreshParasite(kActor, "Barnacles")
	fctParasites.refreshParasite(kActor, "FaceHugger")
	fctParasites.refreshParasite(kActor, "FaceHuggerGag")
	fctParasites.refreshParasite(kActor, "TentacleMonster")
	fctParasites.refreshParasite(kActor, "LivingArmor") 


EndEvent

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
		If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceBarnacles" )>0.0) && (fctParasites.isFemale(PlayerActor)) 
			; Sleeping naked in Blackreach -> chance of barnacles
			If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Harness")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "Barnacles")) && (fctOutfits.isActorNaked(PlayerActor)) && (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceBarnacles" ) as Int) )
				if (fctParasites.infectBarnacles( PlayerActor   ))
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

		if (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHugger" )>0.0) && (fctParasites.isFemale(PlayerActor)) 
			; Sleeping naked in a draugr crypt -> chance of face hugger
			If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "Harness")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "PlugVaginal")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "FaceHugger")) && (fctOutfits.isActorNaked(PlayerActor)) && (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHugger" ) as Int) )
				if (fctParasites.infectFaceHugger( PlayerActor   ))
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
				if (fctParasites.infectFaceHuggerGag( PlayerActor   ))
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
		if (fctParasites.isMale(PlayerActor)) 
			PlayerActor.SendModEvent("SLHModHormone", "Male", 10.0 + Utility.RandomFloat(0.0,10.0))
		endif
		PlayerActor.SendModEvent("SLHModHormone", "SexDrive", 5.0 + Utility.RandomFloat(0.0,10.0))
	endif 

	If (fctParasites.ActorHasKeywordByString(PlayerActor, "LivingArmor"))
		PlayerActor.SendModEvent("SLHModHormone", "Immunity", 1.0 * Utility.RandomFloat(0.0,10.0))
		PlayerActor.SendModEvent("SLHModHormone", "Lactation", 10.0 + Utility.RandomFloat(0.0,10.0))
	endif 

	If (fctParasites.ActorHasKeywordByString(PlayerActor, "Barnacles"))
		PlayerActor.SendModEvent("SLHModHormone", "Immunity", -1.0 * Utility.RandomFloat(0.0,10.0))
		PlayerActor.SendModEvent("SLHModHormone", "Pheromones", 1.0 + Utility.RandomFloat(0.0,5.0))
	endif 

	If (fctParasites.ActorHasKeywordByString(PlayerActor, "ChaurusQueenVag"))
		PlayerActor.SendModEvent("SLHModHormone", "Pheromones", 10.0 + Utility.RandomFloat(0.0,20.0))
	endif 

	; Bring Lastelle where she belongs if needed
	fctParasites.resetLastellePosition()
EndEvent

Event OnSleepStop(bool abInterrupted)
	If abInterrupted

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
 



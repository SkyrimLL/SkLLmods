Scriptname SLH_QST_HormoneGrowth extends Quest  

Import Utility
Import Math

SexLabFramework     property SexLab Auto

SLH_fctBodyShape Property fctBodyShape Auto
SLH_fctColor Property fctColor Auto
SLH_fctPolymorph Property fctPolymorph Auto
SLH_fctUtil Property fctUtil Auto
SLH_fctHormonesLevels Property fctHormones Auto

Keyword Property ActorTypeDaedra  Auto  

ReferenceAlias Property PlayerAlias  Auto  
ReferenceAlias Property SuccubusPlayerAlias  Auto  
ObjectReference PlayerREF
Actor PlayerActor
ActorBase pActorBase 

Int iVersionNumber = 20191019

Bool	 bInit 
String[] skillList
float fRefreshAfterSleep = 0.0
float fDateSleep = 0.0
float fHoursSleep = 0.0

float DaysUntilNextAllowed = 0.04  ;about 1 "game hour" expressed in GameDaysPassed
float NextAllowed = -1.0
int daysPassed
 
Bool bExternalChangeModActive = False 

Int iOrgasmsCountToday   = 0
Int iOrgasmsCountAll   	= 0
Int iSexCountToday   	= 0
Int iSexCountAll   		= 0
Int iOralCountToday   	= 0
Int iAnalCountToday   	= 0
Int iVaginalCountToday   = 0
Int iSexCreaturesAll   	= 0
Int iSexDogAll   		= 0
Int iSexWolfAll   		= 0
Int iSexWerewolfAll   	= 0
Int iSexManAll  	 	= 0
Int iSexMerAll  	 	= 0
Int iSexTrollAll  	 	= 0
Int iSexGiantAll  	 	= 0
Int iSexFalmerAll  	 	= 0
Int iSexBugAll  	 	= 0
Int iSexHorseAll  	 	= 0
Int iSexBearAll  	 	= 0
Int iSexCatAll  	 	= 0
Int iSexGargoyleAll  	 	= 0
Int iSexVampireLordAll  	 	= 0
Int iSexDragonAll  	 	= 0
Int iSexDaedraAll  	 	= 0


Int iGameDateLastSex   = -1
Int iGameDateLastCheck   = -1
Int iDaysSinceLastSex   = 0
Int iDaysSinceLastCheck   = 0
 
Message Property _SLH_Warning Auto

SPELL Property _SLH_SexBoost  Auto  
SPELL Property _SLH_SexFocus  Auto  
SPELL Property _SLH_SexStarve  Auto  
SPELL Property _SLH_DaedricInfluence  Auto  
SPELL Property _SLH_PolymorphBimbo Auto
SPELL Property _SLH_Masturbation  Auto  
SPELL Property _SLH_Undress  Auto  

Race Property _SLH_DremoraRace  Auto  
Race Property _SLH_DremoraOutcastRace  Auto  
Race Property _SLH_BimboRace  Auto  

Quest Property _SLH_QST_Succubus  Auto  
Quest Property _SLH_QST_Bimbo  Auto  


GlobalVariable      Property GV_showStatus 				Auto
GlobalVariable      Property GV_commentsFrequency		Auto
GlobalVariable      Property GV_shapeUpdateOnCellChange	Auto
GlobalVariable      Property GV_forcedRefresh 			Auto
GlobalVariable      Property GV_shapeUpdateAfterSex		Auto
GlobalVariable      Property GV_shapeUpdateOnTimer		Auto
GlobalVariable 		Property SLH_Libido  				Auto  
GlobalVariable      Property GV_startingLibido 			Auto
GlobalVariable      Property GV_sexActivityThreshold 	Auto
GlobalVariable      Property GV_sexActivityBuffer 	 	Auto
GlobalVariable      Property GV_baseSwellFactor 		Auto
GlobalVariable      Property GV_baseShrinkFactor 		Auto
GlobalVariable      Property GV_isTG                    Auto
GlobalVariable      Property GV_isHRT 					Auto
GlobalVariable      Property GV_isBimbo 				Auto
GlobalVariable      Property GV_isSuccubus 				Auto
GlobalVariable      Property GV_allowTG                 Auto
GlobalVariable      Property GV_allowHRT 				Auto
GlobalVariable      Property GV_allowBimbo 				Auto
GlobalVariable      Property GV_allowSuccubus 			Auto
GlobalVariable      Property GV_allowSelfSpells			Auto
GlobalVariable      Property GV_resetToggle 			Auto 

GlobalVariable      Property GV_isGagEquipped		Auto 
GlobalVariable      Property GV_isPlugEquipped		Auto 
GlobalVariable      Property GV_isPregnant		Auto 

GlobalVariable      Property GV_isSuccubusFinal 				Auto
GlobalVariable      Property GV_isTGFinal                   Auto
GlobalVariable      Property GV_isHRTFinal                   Auto
GlobalVariable      Property GV_isBimboFinal                 Auto

GlobalVariable      Property GV_isSuccubusLocked 				Auto
GlobalVariable      Property GV_isTGLocked                   Auto
GlobalVariable      Property GV_isHRTLocked                   Auto
GlobalVariable      Property GV_isBimboLocked                 Auto

FormList Property VanillaHairRaceList  Auto  
FormList Property CustomHairRaceList  Auto  
FormList Property HumanRaceList  Auto  

Sound Property BimboChuckleSound Auto
Sound Property BimboMoanSound Auto
Sound Property BimboGiggleSound Auto

Event OnInit()
	doInit()
	RegisterForSleep()
	RegisterForSingleUpdate(5)
EndEvent

Function doInit()

	skillList = new String[18]
	skillList[0]  = "OneHanded"
	skillList[1]  = "TwoHanded"
	skillList[2]  = "Marksman"
	skillList[3]  = "Block"
	skillList[4]  = "Smithing"
	skillList[5]  = "HeavyArmor"
	skillList[6]  = "LightArmor"
	skillList[7]  = "Pickpocket"
	skillList[8]  = "Lockpicking"
	skillList[9]  = "Sneak"
	skillList[10] = "Alchemy"
	skillList[11] = "Speechcraft"
	skillList[12] = "Alteration"
	skillList[13] = "Conjuration"
	skillList[14] = "Destruction"
	skillList[15] = "Illusion"
	skillList[16] = "Restoration"
	skillList[17] = "Enchanting"

	NextAllowed = -1.0
	; initHormones()

	; Debug.Notification("SexLab Hormones: Init: " + bInit)
	if !bInit
		initHormones()
	EndIf
EndFunction

Function Maintenance()
	PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference()
	PlayerActor= PlayerREF as Actor
	pActorBase = PlayerActor.GetActorBase()


	; Debug.Notification("SexLab Hormones: Init: " + bInit)
	if !bInit
		debugTrace("SexLab Hormones: Init: " + bInit)
		initHormones()
	EndIf

	; Debug.Notification("[SLH] PlayerAlias: " + PlayerAlias)
	; Debug.Notification("[SLH] PlayerREF: " + PlayerREF)
	; Debug.Notification("[SLH] PlayerActor: " + PlayerActor)
	; Debug.Notification("[SLH] pActorBase: " + pActorBase)

	fctUtil.checkGender(PlayerActor)

	; If (!StorageUtil.HasIntValue(none, "_SLH_iHormones"))
		; StorageUtil.SetIntValue(none, "_SLH_iHormones", 1)
	;	Return
	; EndIf

	maintenanceVersionEvents()
	NextAllowed = -1.0

	; Loading shape and hormone state
	fctBodyShape.initShapeConstants(PlayerActor)
	; fctColor.initColorConstants(PlayerActor)

	registerNewRacesForHair( VanillaHairRaceList  )
	registerNewRacesForHair( CustomHairRaceList  )
	registerNewRacesForHair( HumanRaceList  )

	; setHormonesState(PlayerActor)	
	fctBodyShape.getShapeState(PlayerActor) 

	; fctColor.alterSkinToOrigin(PlayerActor)
	fctBodyShape.refreshBodyShape(PlayerActor) 
	fctColor.applyColorChanges(PlayerActor)

	If (GV_shapeUpdateOnCellChange.GetValue()==1)
		fctBodyShape.applyBodyShapeChanges(PlayerActor)
	EndIf

	setHormonesState(PlayerActor)
	; Debug.Notification("[Hormones] s:" + iSexCountToday + " - v:" + iVaginalCountToday + " - a:" + iAnalCountToday + " - o:" + iOralCountToday)


 	daysPassed = Game.QueryStat("Days Passed")

	If (iGameDateLastSex  == -1) 
		iGameDateLastSex = daysPassed   
	EndIf

	If (iGameDateLastCheck  == -1) 
		iGameDateLastCheck = daysPassed   
	EndIf
 
 	StorageUtil.SetIntValue(PlayerActor, "_SLH_iGameDateLastSex", iGameDateLastSex) 
	; StorageUtil.SetIntValue(PlayerActor, "_SLH_iDaysSinceLastSex", iDaysSinceLastSex)
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iDaysSinceLastCheck", iDaysSinceLastCheck)

	int idx = Game.GetModCount()
	string modName = ""
	while idx > 0
		idx -= 1
		modName = Game.GetModName(idx)
		if modName == "EstrusChaurus.esp"
			StorageUtil.SetIntValue(none, "_SLS_isEstrusChaurusON",  1) 
			StorageUtil.SetFormValue(none, "_SLS_getEstrusChaurusBreederSpell",  Game.GetFormFromFile(0x00019121, modName)) ; as Spell

		elseif modName == "BeeingFemale.esm"
			StorageUtil.SetIntValue(none, "_SLS_isBeeingFemaleON",  1) 
			StorageUtil.SetFormValue(none, "_SLS_getBeeingFemalePregnancySpell",  Game.GetFormFromFile(0x000028A0, modName)) ; as Spell

		elseif modName == "CagedFollowers.esp"
			StorageUtil.SetIntValue(none, "_SLS_isCagedFollowerON",  1) 
			StorageUtil.SetFormValue(none, "_SLS_getCagedFollowerQuestKeyword",  Game.GetFormFromFile(0x0000184d, modName)) ; as Keyword

		endif
	endWhile
EndFunction

Function maintenanceVersionEvents()
	PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference()
	PlayerActor= PlayerREF as Actor
	pActorBase = PlayerActor.GetActorBase()
	Int iBimbo = StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimbo") 

	iVersionNumber = 20191213
	
	If (StorageUtil.GetIntValue(none, "_SLH_iHormonesVersion") != iVersionNumber)
		StorageUtil.SetIntValue(none, "_SLH_iHormonesVersion", iVersionNumber)	
		Debug.Notification("[SLH] Hormones " + iVersionNumber)

		If (iVersionNumber <= 20181214)
			debug.MessageBox("[Hormones] This is a major update. Check your menu settings for changes to color swatches and NiNode updates options.")
			StorageUtil.SetIntValue(none, "_SLH_NiNodeOverrideON", 1)
			StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultSkinColor", -1)
			StorageUtil.SetIntValue(PlayerActor, "_SLH_iSexActivityThreshold",GV_sexActivityThreshold.GetValue() as Int)
			StorageUtil.SetIntValue(PlayerActor, "_SLH_iSexActivityBuffer",GV_sexActivityBuffer.GetValue() as Int)
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBaseShrinkFactor",GV_baseShrinkFactor.GetValue() as Float) 
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBaseSwellFactor",GV_baseSwellFactor.GetValue() as Float) 
			StorageUtil.SetIntValue(none, "_SLH_debugTraceON", 1)
		Endif
		If (iVersionNumber <= 20191019)
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneSuccubus", StorageUtil.GetIntValue(PlayerActor, "_SLH_iDaedricInfluence") as Float ) 
		Endif
		If (iVersionNumber <= 20191026)
			StorageUtil.SetIntValue(PlayerActor, "_SLH_iAllowBimboThoughts", iBimbo)
		endif
		If 	(StorageUtil.GetIntValue(PlayerActor, "_SLH_iHormoneLevelsInit") != 1) 
			fctHormones.initHormonesLevels(PlayerActor)
		EndIf
	Endif

	debugTrace(" Hormones " + iVersionNumber)
	
	UnregisterForAllModEvents()
	debugTrace("  Reset SexLab events")
	; RegisterForModEvent("AnimationStart", "OnSexLabStart")
	RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")
	RegisterForModEvent("SexLabOrgasmSeparate",    "OnSexLabOrgasmSeparate")


	RegisterForModEvent("SLHShaveHead",   "OnShaveHead")
	RegisterForModEvent("SLHModHormone",    "OnModHormoneEvent")
	RegisterForModEvent("SLHModHormoneRandom",    "OnModHormoneRandomEvent")
	RegisterForModEvent("SLHResetHormones",    "OnResetHormonesEvent")
	RegisterForModEvent("SLHRefresh",    "OnRefreshShapeEvent")
	RegisterForModEvent("SLHRefreshColor",    "OnRefreshColorsEvent")
	RegisterForModEvent("SLHRefreshColors",    "OnRefreshColorsEvent")
	RegisterForModEvent("SLHRefreshHairColor",    "OnRefreshHairColorEvent")
	RegisterForModEvent("SLHSetShape",    "OnSetShapeEvent")
	RegisterForModEvent("SLHResetShape",    "OnResetShapeEvent")
	RegisterForModEvent("SLHResetColors",    "OnResetColorsEvent")
	RegisterForModEvent("SLHSetSchlong",    "OnSetSchlongEvent")
	RegisterForModEvent("SLHRemoveSchlong",    "OnRemoveSchlongEvent")
	RegisterForModEvent("SLHCastSuccubusCurse",    "OnCastSuccubusCurseEvent")
	RegisterForModEvent("SLHCureSuccubusCurse",    "OnCureSuccubusCurseEvent")
	RegisterForModEvent("SLHCastBimboCurse",    "OnCastBimboCurseEvent")
	RegisterForModEvent("SLHCureBimboCurse",    "OnCureBimboCurseEvent")
	RegisterForModEvent("SLHCastHRTCurse",    "OnCastHRTCurseEvent")
	RegisterForModEvent("SLHCureHRTCurse",    "OnCureHRTCurseEvent")
	RegisterForModEvent("SLHCastTGCurse",    "OnCastTGCurseEvent")
	RegisterForModEvent("SLHCureTGCurse",    "OnCureTGCurseEvent") 
	RegisterForModEvent("SLHBimboThoughts",    "OnBimboThoughts") 

	if (GV_allowSelfSpells.GetValue() == 1)
		debugTrace("  Add spells")
		PlayerActor.AddSpell( _SLH_Masturbation )
		PlayerActor.AddSpell( _SLH_Undress )
	Else 
		debugTrace("  Remove spells")
		PlayerActor.RemoveSpell( _SLH_Masturbation )
		PlayerActor.RemoveSpell( _SLH_Undress )
	EndIf

	; Set Succubus flag if needed for users already infected by curse
	If (GV_isSuccubus.GetValue()==1) && (GV_isSuccubusFinal.GetValue()==0) && (_SLH_QST_Succubus.GetStage()>=50)
		GV_isSuccubusFinal.SetValue(1)
	endif	

	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fManualWeightChange",  -1)

	StorageUtil.SetIntValue(PlayerActor, "_SLH_allowTG", GV_allowTG.GetValue() as Int)
	StorageUtil.SetIntValue(PlayerActor, "_SLH_allowHRT", GV_allowHRT.GetValue() as Int)
	StorageUtil.SetIntValue(PlayerActor, "_SLH_allowBimbo", GV_allowBimbo.GetValue() as Int)
	StorageUtil.SetIntValue(PlayerActor, "_SLH_allowSuccubus", GV_allowSuccubus.GetValue() as Int)
	StorageUtil.SetIntValue(PlayerActor, "_SLH_allowSelfSpells", GV_allowSelfSpells.GetValue() as Int)


	RegisterForSleep()
	RegisterForSingleUpdate(5)
EndFunction


function initHormones()
	PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference()
	PlayerActor= PlayerREF as Actor
	pActorBase = PlayerActor.GetActorBase()

	bInit = True

	StorageUtil.SetIntValue(none, "_SLH_debugTraceON", 1)

	If (StorageUtil.GetIntValue(none, "_SLH_iHormones")!=1)
		StorageUtil.SetIntValue(none, "_SLH_iHormones", 1)
	EndIf

	; First time body shape

	; Debug.Notification("SexLab Hormones: Waiting for 3d to load")
	; make sure we have loaded 3d to access
	; while ( !kTarget.Is3DLoaded() )
	; 	Utility.Wait( 1.0 )
	; endWhile

 	debugTrace("  Initialization of body / MCM values")

	StorageUtil.SetIntValue(PlayerActor, "_SLH_iUseColors", 0)
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iUseHairColors", 0)
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultSkinColor", -1) 
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iRedShiftColor", -1) ; GV_redShiftColor.GetValue() as Int
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iBlueShiftColor", -1); GV_blueShiftColor.GetValue() as Int
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iBimboHairColor", -1); GV_blueShiftColor.GetValue() as Int
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusHairColor", -1); GV_blueShiftColor.GetValue() as Int

	NextAllowed = -1.0

	fctBodyShape.initShapeConstants(PlayerActor)
	fctColor.initColorConstants(PlayerActor)

	initHormonesState(PlayerActor)

	setHormonesState(PlayerActor)	; set storageUtil variables from init values
	getHormonesState(PlayerActor)	

	fctHormones.initHormonesLevels(PlayerActor)

	StorageUtil.SetIntValue(PlayerActor, "Puppet_SpellON", -1)
	StorageUtil.SetIntValue(PlayerActor, "PSQ_SpellON", -1)

	applyHormonalChanges(PlayerActor)

	iOrgasmsCountToday   = 0
	iSexCountToday   = 0
	iOralCountToday   = 0
	iAnalCountToday   = 0
	iVaginalCountToday   = 0

    StorageUtil.SetIntValue(PlayerActor, "_SLH_bimboTransformDate", -1)


	maintenanceVersionEvents()

	Debug.Notification("SexLab Hormones started")
	debugTrace("SexLab Hormones started")

Endfunction

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	fDateSleep = afSleepStartTime
	debugTrace("Player went to sleep at: " + Utility.GameTimeToString(afSleepStartTime))
	debugTrace("Player wants to wake up at: " + Utility.GameTimeToString(afDesiredSleepEndTime))

	fRefreshAfterSleep = (afDesiredSleepEndTime - afSleepStartTime)
	debugTrace("SexLab Hormones: fRefreshAfterSleep: " + fRefreshAfterSleep)
endEvent
 
Event OnSleepStop(bool abInterrupted)
	Bool bShapeChangeEvent = False
	fHoursSleep = (Utility.GetCurrentGameTime() - fDateSleep) * 24.0
	debugTrace("Player woke up at: " + Utility.GameTimeToString(Utility.GetCurrentGameTime()))
	debugTrace("Time slept: " + fHoursSleep)

	bShapeChangeEvent = fctBodyShape.tryTGEvent(PlayerActor,fHoursSleep)

	if (!bShapeChangeEvent)
		bShapeChangeEvent = fctBodyShape.tryHRTEvent(PlayerActor,fHoursSleep)
	Endif

	if (!bShapeChangeEvent)
		bShapeChangeEvent = fctBodyShape.tryBimboEvent(PlayerActor,fHoursSleep)
	Endif

	If abInterrupted
		; sleep interrupted
	EndIf
EndEvent

Function _updatePlayerState()
	PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference()
	PlayerActor= PlayerREF as Actor
	pActorBase = PlayerActor.GetActorBase()
	Form kFormGag
	Form kFormAnalPlug
	Form kFormVaginalPlug
	Float fBimboClumsyMod 
	Int iPlugCount = 0
	Int iLastPlugCount = 0

	bExternalChangeModActive = fctUtil.isExternalChangeModActive(PlayerActor)
	GV_allowTG.SetValue( StorageUtil.GetIntValue(PlayerActor, "_SLH_allowTG") as Int)
	GV_allowHRT.SetValue( StorageUtil.GetIntValue(PlayerActor, "_SLH_allowHRT") as Int)
	GV_allowBimbo.SetValue( StorageUtil.GetIntValue(PlayerActor, "_SLH_allowBimbo") as Int)
	GV_allowSuccubus.SetValue( StorageUtil.GetIntValue(PlayerActor, "_SLH_allowSuccubus") as Int)
	GV_allowSelfSpells.SetValue( StorageUtil.GetIntValue(PlayerActor, "_SLH_allowSelfSpells") as Int)

	; Detect gags from ZAP and DD
	kFormGag = PlayerActor.GetWornForm( 0x00004000 ) ; 44  DD Gags Mouthpieces

	if ((GV_isGagEquipped.GetValue() as Int) == 0) && (kFormGag != None)
		GV_isGagEquipped.SetValue(1)

	Elseif ((GV_isGagEquipped.GetValue() as Int) == 1) && (kFormGag == None)
		GV_isGagEquipped.SetValue(0)
	Endif

	; Detect plugs from ZAP and DD
	kFormAnalPlug = PlayerActor.GetWornForm( 0x00040000 ) ; 48 DD plugs 
	kFormVaginalPlug = PlayerActor.GetWornForm( 0x08000000 ) ; 57  DD plugs 

	if ((GV_isPlugEquipped.GetValue() as Int) == 0) && ((kFormAnalPlug != None) || (kFormVaginalPlug != None))
		GV_isPlugEquipped.SetValue(1)

	Elseif ((GV_isPlugEquipped.GetValue() as Int) == 1) && ((kFormAnalPlug == None) && (kFormVaginalPlug == None))
		GV_isPlugEquipped.SetValue(0)
	Endif

	if (StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBimboClumsyMod" ) ==0)
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBimboClumsyMod", 1.0 ) 
	endif 

	if (kFormGag != None)
		iPlugCount += 1
	endif
	if (kFormAnalPlug != None)
		iPlugCount += 1
	endif
	if (kFormVaginalPlug != None)
		iPlugCount += 1
	endif

	; if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimbo") == 1)
		fBimboClumsyMod = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBimboClumsyMod") 
		; debug.notification("[SLH] Player is bimbo")
		If (iPlugCount>0) ; && (iLastPlugCount != iPlugCount); && (fBimboClumsyMod==1.0)
			; If Bimbo and plugged, severely decrease chance of clumsy event
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBimboClumsyMod", 1.0 / ((iPlugCount as Float) * 2.0) ) 
			iLastPlugCount = iPlugCount
			; debug.notification("[SLH] Setting bimbo clumsiness to 0.2")
		ElseIf (iPlugCount==0) && (fBimboClumsyMod!=1.0)
			; If Bimbo and plugged, restore chance of clumsy event
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBimboClumsyMod", 1.0 ) 
			; debug.notification("[SLH] Setting bimbo clumsiness to 1.0")
		Endif
	; Else
		; debug.notification("[SLH] Player is NOT bimbo")
	; EndIf

EndFunction

Event OnUpdate()
	PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference()
	PlayerActor= PlayerREF as Actor
	pActorBase = PlayerActor.GetActorBase()
	Int RandomNum = 0
	Int rollFirstPerson 

	if !Self
		Return
	EndIf

	_updatePlayerState()
	
	; Modifiers for each part - on update in case they were modified in MCM
	; fctBodyShape.refreshGlobalValues()

 	daysPassed = Game.QueryStat("Days Passed")
 
 	; Debug.Notification("SexLab Hormones: Days Passed: " + daysPassed + " / " + iGameDateLastCheck)
	; Debug.Notification("SexLab Hormones: fRefreshAfterSleep: " + fRefreshAfterSleep )

 	; Debug.Notification("SexLab Hormones: iDaysSinceLastSex: " + iDaysSinceLastSex)
 	; Debug.Notification("SexLab Hormones: iDaysSinceLastCheck: " + iDaysSinceLastCheck)

 	iDaysSinceLastSex = (daysPassed - iGameDateLastSex ) as Int
	iDaysSinceLastCheck = (daysPassed - iGameDateLastCheck ) as Int

	StorageUtil.SetIntValue(PlayerActor, "_SLH_iDaysSinceLastSex", iDaysSinceLastSex)
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iDaysSinceLastCheck", iDaysSinceLastCheck)

 	; Debug.Notification("SexLab Hormones: - iDaysSinceLastSex: " + iDaysSinceLastSex)
 	; Debug.Notification("SexLab Hormones: - iDaysSinceLastCheck: " + iDaysSinceLastCheck)
 	
 	; Debug.Notification("SexLab Hormones: NextAllowed " + NextAllowed)

	; debugTrace("  Forced refresh flag: " + StorageUtil.GetIntValue(kActor, "_SLH_iForcedRefresh"))

	If ( StorageUtil.GetIntValue(none, "_SLH_iForcedRefresh") == 1)
		; Forced refresh from PapyrusUtils (API)
		; Repurposed as forced refresh of lobal and global variables

		debugTrace("  Forced refresh of local and global variables")	

		; PlayerActor.SendModEvent("SLHRefresh")
		fctBodyShape.getShapeState(PlayerActor) 

		GV_forcedRefresh.SetValue(0.0) 
		StorageUtil.SetIntValue(none, "_SLH_iForcedRefresh",0)

	ElseIf (iDaysSinceLastCheck > 0) || (fRefreshAfterSleep > 0.02)
		; cooldown hormone levels naturally after sleep
		if (fRefreshAfterSleep>0.0)
			Debug.Notification("[SLH] Hormones cooldown hours: " + (fHoursSleep as Int))
			fctHormones.cooldownHormoneLevels(PlayerActor, fHoursSleep)
			; Set base arousal to SexDrive value
			fctUtil.updateSexLabArousedExposure(PlayerActor, (fctHormones.getHormoneLevelsRacialAdjusted(PlayerActor, "SexDrive") as Int))
		Endif

		; Manage sex effect ==================================================
		If (iDaysSinceLastSex==0)
			debugTrace("  Sex boost cleared after rest")
			PlayerActor.DispelSpell(_SLH_SexBoost)
		EndIf

		If (iDaysSinceLastSex>=1)
			debugTrace("  Sex focus effect after a day without sex")
			_SLH_SexFocus.Cast(PlayerActor,PlayerActor)
		EndIf

		If (iDaysSinceLastSex>1)
			debugTrace("  Sex starve effect after more than a day without sex")
			_SLH_SexStarve.Cast(PlayerActor,PlayerActor)
		Endif

		fRefreshAfterSleep = 0.0
		fctUtil.checkGender(PlayerActor)

		debugTrace("  Days since Sex acts : " + iDaysSinceLastSex)
		; Check if body modifications are applicable
		if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iNodeBalancing")==1)
			_nodeBalancing()
		endIf

		fctBodyShape.getShapeState(PlayerActor) 

		If bExternalChangeModActive
			fctBodyShape.getShapeFromNodes(PlayerActor)
			fctColor.getColorFromSkin(PlayerActor)
		EndIf

		applyHormonalChanges(PlayerActor)

		iOrgasmsCountToday   = 0
		iSexCountToday   = 0
		iOralCountToday   = 0
		iAnalCountToday   = 0
		iVaginalCountToday   = 0

		If !( bExternalChangeModActive ) && (NextAllowed!= -1) && (GV_shapeUpdateOnTimer.GetValue()==1)
			fctColor.applyColorChanges(PlayerActor)
			fctBodyShape.applyBodyShapeChanges(PlayerActor)
		EndIf

	Else
		RandomNum = Utility.RandomInt(0,100)
		rollFirstPerson = Utility.RandomInt(0,100)

		; If (RandomNum>90)
			; debugTrace("  Today: Sex acts: " + iSexCountToday + " - Orgasms: " + iOrgasmsCountToday)
			; debugTrace("  Sex dates: " + Game.QueryStat("Days Passed") + " - " + iGameDateLastSex + " = " + iDaysSinceLastSex)
			; debugTrace("  Check dates: " + Game.QueryStat("Days Passed") + " - " + iGameDateLastCheck + " = " + iDaysSinceLastCheck)
		; EndIf

		; Debug.Notification("[Hormones] Next: " + NextAllowed)
		; Debug.Notification("[Hormones] Day passed stat: " +  Game.QueryStat("Days Passed"))
		; Debug.Notification("[Hormones] RandomNum: " + RandomNum)


		If (RandomNum>80) && (fctUtil.isFemale(PlayerActor))  && (iSexCountToday > 0) && (NextAllowed > 15) && (GV_showStatus.GetValue() == 1)
			; Debug.Notification("[Hormones] s:" + iSexCountToday + " - v:" + iVaginalCountToday + " - a:" + iAnalCountToday + " - o:" + iOralCountToday)

			If (rollFirstPerson <= (StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneBimbo") as Int))
				; First person thought
				playMoan(PlayerActor)
				If (iVaginalCountToday > 0) 
					If (iVaginalCountToday > 10) 
						Debug.Notification("My pussy feels so good and wet.")
					ElseIf (iVaginalCountToday > 5) 
						Debug.Notification("I love when semen runs down my leg.")
					Else
						Debug.Notification("My pussy is tingly!")
					EndIf
				EndIf
				If (iAnalCountToday > 0) 
					If (iAnalCountToday > 10) 
						Debug.Notification("My ass is burning so good!")
					ElseIf (iAnalCountToday > 5) 
						Debug.Notification("I love how my ass is wet and sticky.")
					Else
						Debug.Notification("My ass needs to be filled.")
					EndIf
				EndIf
				If (iOralCountToday > 0)
					If (iOralCountToday > 10) 
						Debug.Notification("Cum in mouth is so yummy!")
					ElseIf (iOralCountToday > 5) 
						Debug.Notification("I can feel cum between my boobs!")
					Else
						Debug.Notification("I love the taste of cum on my lips.")
					EndIf
				EndIf
				If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") > 5)
					If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") > 8) 
						Debug.Notification("My boobies need to be milked so bad!")
					ElseIf (StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") > 6) 
						Debug.Notification("My boobies are so full and bouncy!")
					Else
						Debug.Notification("My titties are moist and tingling.")
					EndIf
				EndIf
			else
				; Third person thought
				If (iVaginalCountToday > 0) 
					If (iVaginalCountToday > 10) 
						Debug.Notification("Your pussy feels sore and slippery.")
					ElseIf (iVaginalCountToday > 5) 
						Debug.Notification("Semen runs down your leg slowly.")
					Else
						Debug.Notification("Your pussy is moist and throbbing softly.")
					EndIf
				EndIf
				If (iAnalCountToday > 0) 
					If (iAnalCountToday > 10) 
						Debug.Notification("Your ass is a painful reminder of your fate.")
					ElseIf (iAnalCountToday > 5) 
						Debug.Notification("Your ass feels wet and sticky.")
					Else
						Debug.Notification("Your ass is still sore.")
					EndIf
				EndIf
				If (iOralCountToday > 0)
					If (iOralCountToday > 10) 
						Debug.Notification("The after taste of cum makes you feel dizzy.")
					ElseIf (iOralCountToday > 5) 
						Debug.Notification("Your cleavage is still sticky from dripping cum.")
					Else
						Debug.Notification("Saltiness still coats your lips.")
					EndIf
				EndIf
				If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") > 5)
					If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") > 8) 
						Debug.Notification("Your tits are dripping with milk and ache for release.")
					ElseIf (StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") > 6) 
						Debug.Notification("Your breasts are swollen with milk.")
					Else
						Debug.Notification("Your nipples are moist and tingling.")
					EndIf
				EndIf
			endIf
			
			NextAllowed = 0.0 ;  GameDaysPassed.GetValue() + DaysUntilNextAllowed


		ElseIf (RandomNum>80) && !(fctUtil.isFemale(PlayerActor)) && (iSexCountToday > 0)  && (NextAllowed > 10) && (GV_showStatus.GetValue() == 1)
			If (iSexCountToday > 10) 
				Debug.Notification("Your cock throbs painfully after what happened today.")
			ElseIf (iSexCountToday > 5) 
				Debug.Notification("Your hardon keeps you horny and warm.")
			ElseIf (iSexCountToday > 0) 
				Debug.Notification("Cum still coats the tip of your cock.")
			EndIf

			NextAllowed = 0.0 ;  GameDaysPassed.GetValue() + DaysUntilNextAllowed

		else
			; Moved random thoughts in main update loop to be enabled outside of bimbo curse

			If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iAllowBimboThoughts") == 1) 
				fctUtil.tryRandomBimboThoughts()
			endif

		EndIf

		; Detect pregnancy ==================================================

		If (NextAllowed == -1.0) 
			; First time here after loading a game - apply changes to shape
			; Refreshing values in case of any external change from other mods
			; _getShapeState(PlayerActor)
			; _refreshBodyShape(PlayerActor)
			; _setHormonesState(PlayerActor)

			; If !( fctUtil.isExternalChangeModActive(PlayerActor) )
				fctColor.applyColorChanges(PlayerActor)
				fctBodyShape.applyBodyShapeChanges(PlayerActor)
			; EndIf

			NextAllowed = 0.0

		ElseIf (fctBodyShape.detectShapeChange(PlayerActor)) 

			If ( fctUtil.isExternalChangeModActive(PlayerActor) )

				debugTrace("  Update ignored. PC is changing from another mod.")
				; GV_changeOverrideToggle.SetValue(0)

				; Refreshing values in case of any external change from other mods
				fctBodyShape.getShapeFromNodes(PlayerActor)
				fctColor.getColorFromSkin(PlayerActor)
				; refreshBodyShape(PlayerActor)
				setHormonesState(PlayerActor)

				; No need to apply changes again since other mods have already changed body shape
				; fctBodyShape.applyBodyShapeChanges()
			Else
 
				debugTrace("  Updating shape on external detection.")
				; Debug.Notification("SexLab Hormones: Before: " + fBelly + " from " + NetImmerse.GetNodeScale(PlayerActor, NINODE_BELLY, false) )

				; Refreshing values in case of any external change from other mods
				; fctBodyShape.getShapeState(bUseNodes = True)
				fctBodyShape.refreshBodyShape(PlayerActor)
				fctColor.applyColorChanges(PlayerActor)
				fctBodyShape.getShapeState(PlayerActor) 

				; fctColor.alterSkinToOrigin(PlayerActor)

				; If (GV_shapeUpdateOnCellChange.GetValue()==1)
				;	fctBodyShape.applyBodyShapeChanges(PlayerActor)
				; EndIf

				setHormonesState(PlayerActor)

				; Debug.Notification("SexLab Hormones: After: " + fBelly + " from " + NetImmerse.GetNodeScale(PlayerActor, NINODE_BELLY, false) )
			EndIf

		EndIf

		NextAllowed = NextAllowed + 1.0 ;  GameDaysPassed.GetValue() + DaysUntilNextAllowed

	EndIf

	iGameDateLastCheck = daysPassed  

	RegisterForSingleUpdate(10)
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
  	If (GV_shapeUpdateOnCellChange.GetValue()==1)
		PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference()
		PlayerActor= PlayerREF as Actor

		fctColor.applyColorChanges(PlayerActor)
		fctBodyShape.getShapeState(PlayerActor) 

		; fctBodyShape.applyBodyShapeChanges(PlayerActor)
	EndIf
endEvent
 
Event OnCastSuccubusCurseEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	
 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Cast succubus curse event" )	  
	
	If ( StorageUtil.GetIntValue(PlayerActor, "_SLH_iDaedricInfluence") <5) 
		; Most likely event was sent at a player start or from mod trying to make player a succubus
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDaedricInfluence", 50)
	Endif

	StorageUtil.SetIntValue(PlayerActor, "PSQ_SpellON", 1)
	ModEvent.Send(ModEvent.Create("HoSLDD_GivePlayerPowers"))
	_SLH_QST_Succubus.SetStage(50)
	GV_isSuccubusFinal.SetValue(1)
	setSuccubusState(PlayerActor, TRUE)

endEvent

Event OnCureSuccubusCurseEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	
 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Cure succubus curse event" )	  
	

 	if (GV_isSuccubusFinal.GetValue()==0)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDaedricInfluence", 0)
		StorageUtil.SetIntValue(PlayerActor, "PSQ_SpellON", 0)
		ModEvent.Send(ModEvent.Create("HoSLDD_TakeAwayPlayerPowers"))
		; _SLH_QST_Succubus.SetStage(90)
		GV_isSuccubusFinal.SetValue(0) 
		setSuccubusState(PlayerActor, FALSE)
	Else
		debugTrace(" Cure Succubus Curse event - Aborted. Succubus is locked." )	  
	Endif
endEvent

Event OnCastBimboCurseEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Bool isBimbo = False
 	
 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Cast Bimbo Curse event" )	  
	; PolymorphBimbo.Cast(PlayerActor,PlayerActor)
	isBimbo = fctPolymorph.bimboTransformEffectON(kActor)

	If (isBimbo)
		if (_args == "Dremora")
			_SLH_QST_Bimbo.SetStage(11)
		Elseif (_args == "Bimbo")
			_SLH_QST_Bimbo.SetStage(10)
		endif

		Game.ShowRaceMenu()
	Endif

endEvent

Event OnCureBimboCurseEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf

 	if (GV_isBimboFinal.GetValue()==0)
		debugTrace(" Cure Bimbo Curse event" )	  

	    GV_isBimboFinal.SetValue(0)
		fctPolymorph.bimboTransformEffectOFF(kActor)
	    Game.ShowRaceMenu()	
	Else
		debugTrace(" Cure Bimbo Curse event - Aborted. Bimbo is locked." )	  
	Endif

endEvent

Event OnCastHRTCurseEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Bool isHRT = False
 	
 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Cast HRT Curse event" )	  
	isHRT = fctPolymorph.HRTEffectON(kActor)

	; PolymorphBimbo.Cast(PlayerActor,PlayerActor)
	if (isHRT)
		if (_args == "Dremora")
			_SLH_QST_Bimbo.SetStage(11)
		Elseif (_args == "Bimbo")
			_SLH_QST_Bimbo.SetStage(10)
		endif

	    Game.ShowRaceMenu()
	Endif
endEvent

Event OnCureHRTCurseEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf


 	if (GV_isHRTFinal.GetValue()==0)
		debugTrace(" Cure HRT Curse event" )	  

	    GV_isHRTFinal.SetValue(0)
		fctPolymorph.HRTEffectOFF(kActor)
	     Game.ShowRaceMenu()	
	Else
		debugTrace(" Cure HRT Curse event - Aborted. HRT is locked." )	  
	Endif

endEvent

Event OnCastTGCurseEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Bool isTG = False
  	
 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Cast TG Curse event" )	  
	isTG = fctPolymorph.TGEffectON(kActor)

	if (isTG)
		; PolymorphBimbo.Cast(PlayerActor,PlayerActor)
		if (_args == "Dremora")
			_SLH_QST_Bimbo.SetStage(11)
		Elseif (_args == "Bimbo")
			_SLH_QST_Bimbo.SetStage(10)
		endif
	endif

endEvent

Event OnCureTGCurseEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf

 	if (GV_isTGFinal.GetValue()==0)
		debugTrace(" Cure TG Curse event" )	  

	    GV_isTGFinal.SetValue(0)
		fctPolymorph.TGEffectOFF(kActor)
	Else
		debugTrace(" Cure TG Curse event - Aborted. TG is locked." )	  
	Endif
 	
endEvent

Event OnBimboThoughts(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf

 	debugTrace(" Receiving 'Bimbo thought' event" )	
 	fctUtil.tryRandomBimboThoughts()

endEvent

Event OnResetHormonesEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Receiving 'reset hormones levels' event. Actor: " + kActor )

	fctHormones.initHormonesLevels(kActor)
	
EndEvent

Event OnModHormoneEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Receiving 'mod hormone level' event. Actor: " + kActor )

	fctHormones.modHormoneLevel(kActor, _args, _argc)

EndEvent

Event OnModHormoneRandomEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Receiving 'mod hormone random level' event. Actor: " + kActor )

	fctHormones.modHormoneLevel(kActor, "Pigmentation", Utility.RandomFloat(-1.0,2.0) * _argc )
	fctHormones.modHormoneLevel(kActor, "Growth", Utility.RandomFloat(5.0,10.0) * _argc )
	fctHormones.modHormoneLevel(kActor, "Metabolism", Utility.RandomFloat(5.0,20.0) * _argc )
	fctHormones.modHormoneLevel(kActor, "Sleep", Utility.RandomFloat(-1.0,2.0) * _argc )
	fctHormones.modHormoneLevel(kActor, "Hunger", Utility.RandomFloat(-1.0,2.0) * _argc )
	fctHormones.modHormoneLevel(kActor, "Immunity", Utility.RandomFloat(-1.0,2.0) * _argc )
	fctHormones.modHormoneLevel(kActor, "Stress", Utility.RandomFloat(-10.0,20.0) * _argc )
	fctHormones.modHormoneLevel(kActor, "SexDrive", Utility.RandomFloat(-10.0,20.0) * _argc )
	fctHormones.modHormoneLevel(kActor, "Pheromones", Utility.RandomFloat(-0.5,1.0) * _argc )
	fctHormones.modHormoneLevel(kActor, "Lactation", Utility.RandomFloat(-1.0,2.0) * _argc )


	if (_args == "Succubus") || (_args == "Bimbo") || (_args == "Chaurus")
		fctHormones.modHormoneLevel(kActor, "Mood", Utility.RandomFloat(-5.0,10.0) * _argc )
		fctHormones.modHormoneLevel(kActor, "Female", Utility.RandomFloat(5.0,10.0) * _argc )
		fctHormones.modHormoneLevel(kActor, "Male", Utility.RandomFloat(-5.0,-10.0) * _argc )
	Else
		fctHormones.modHormoneLevel(kActor, "Mood", Utility.RandomFloat(-1.0,2.0) * _argc )
		fctHormones.modHormoneLevel(kActor, "Female", Utility.RandomFloat(-5.0,10.0) * _argc )
		fctHormones.modHormoneLevel(kActor, "Male", Utility.RandomFloat(-5.0,-10.0) * _argc )
	endif

	if (_args == "Succubus") || (_args == "Bimbo")
		fctHormones.modHormoneLevel(kActor, "Bimbo", Utility.RandomFloat(20.0,40.0) * _argc )
	Endif

	if (_args == "Succubus")
		fctHormones.modHormoneLevel(kActor, "Succubus", Utility.RandomFloat(5.0,15.0) * _argc )
	endif
	
EndEvent


Event OnRefreshShapeEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Receiving 'refresh shape' event. Actor: " + kActor )

	refreshShape(kActor)
	
EndEvent

Event OnRefreshColorsEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 
 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Receiving 'refresh colors' event. Actor: " + kActor )

	refreshColor(kActor)
EndEvent

Event OnRefreshHairColorEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 
 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Receiving 'refresh hair color' event. Actor: " + kActor )

	If (StorageUtil.GetIntValue(kActor, "_SLH_iUseHair") == 1) && (StorageUtil.GetIntValue(kActor, "_SLH_iUseHairColor") == 1)

		If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
			; YPS Fashion override if detected
			; See - http://www.loverslab.com/topic/56627-immersive-hair-growth-and-styling-yps-devious-immersive-fashion-v5/
			debugTrace("       -> YPS Fashion override")

			If ((StorageUtil.HasStringValue(kActor, "_SLH_sHairColorName" )) && (StorageUtil.HasIntValue(kActor, "_SLH_iHairColor" )))
				if (_args == "Dye")
					StorageUtil.SetIntValue(kActor, "_SLH_iHairColorDye", 1 ) 
					SendModEvent("yps-HairColorDyeEvent", StorageUtil.GetStringValue(kActor, "_SLH_sHairColorName" ), StorageUtil.GetIntValue(kActor, "_SLH_iHairColor" ) )
				else
					StorageUtil.SetIntValue(kActor, "_SLH_iHairColorDye", 0 ) 
					SendModEvent("yps-HairColorBaseEvent", StorageUtil.GetStringValue(kActor, "_SLH_sHairColorName" ), StorageUtil.GetIntValue(kActor, "_SLH_iHairColor" ) )
				endif
			else
				debugTrace("       -> YPS Fashion hair color parameters missing - hair color change skipped")
			endif

		Else
			debugTrace("       -> YPS Fashion missing - hair color change skipped")
		Endif
	Else
		debugTrace("       -> Skipped - hair color change disabled")
	Endif
EndEvent

Event OnShaveHead(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
		
 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Detected forced hair change")

	fctBodyShape.shaveHair(kActor)		
	
EndEvent


Event OnSetShapeEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Receiving 'set shape' event" )

	setHormonesStateDefault(kActor)
	
EndEvent

Event OnResetShapeEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Receiving 'reset shape' event" )

	resetHormonesState(kActor)
	
EndEvent

Event OnResetColorsEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Receiving 'reset colors' event" )

	fctColor.resetColorState( kActor)
	fctColor.applyColorChanges(kActor)
	
EndEvent

Event OnSetSchlongEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Receiving 'set schlong' event" )

	fctBodyShape.setSchlong(kActor, _args)
	
EndEvent

Event OnRemoveSchlongEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf
	debugTrace(" Receiving 'remove schlong' event" )

	fctBodyShape.removeSchlong(kActor)
	
EndEvent


Event OnSexLabEnd(String _eventName, String _args, Float _argc, Form _sender)
	PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference()
	PlayerActor= PlayerREF as Actor
    sslBaseAnimation animation = SexLab.HookAnimation(_args)

    Bool bOral = False
    Bool bVaginal = False
    Bool bAnal = False
    float fLibido
    Int iDaedricInfluence  
	Int isPregnant = StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant")
	Int isSuccubus = StorageUtil.GetIntValue(PlayerActor, "_SLH_isSuccubus")
	Int isLactating = StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating")
	Int isBimbo = StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimbo")

	if !Self || !SexLab 
		debugTrace(" Critical error on SexLab End")
		Return
	EndIf


	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim
	
	; if config.bDebugMsg
	; 	_listActors("End: ", actors)
	; EndIf

	If (fctUtil.hasPlayer(actors))
	    debugTrace("  Sex end: " + animation.name)

		; If victim  ;none consensual
			;
	
		; Else  ;consensual
			;
	
		; EndIf

		; Manage orgasms count ==================================================
		If (iGameDateLastSex  == 0) 
			iGameDateLastSex = Game.QueryStat("Days Passed")   
		EndIf

		iDaysSinceLastSex = (Game.QueryStat("Days Passed") - iGameDateLastSex ) as Int

		iSexCountAll   = iSexCountAll + 1

		If (iDaysSinceLastSex == 0)
			iSexCountToday   = iSexCountToday + 1
		EndIf

		iGameDateLastSex = Game.QueryStat("Days Passed")   

 		StorageUtil.SetIntValue(PlayerActor, "_SLH_iGameDateLastSex", iGameDateLastSex) 
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDaysSinceLastSex", iDaysSinceLastSex) 

		; Manage sex effect ==================================================
		If (iSexCountToday>1)
			PlayerActor.DispelSpell(_SLH_SexFocus)
			_SLH_SexBoost.Cast(PlayerActor,PlayerActor)
		EndIf

		; Manage sex act count ==================================================
		if animation.HasTag("Oral") || animation.HasTag("Bestiality") || animation.HasTag("Gangbang")
	    	iOralCountToday   = iOralCountToday + 1
			bOral = True
	    EndIf

		if animation.HasTag("Anal") || animation.HasTag("Doggystyle") || animation.HasTag("Gangbang")
	 	   iAnalCountToday   = iAnalCountToday + 1
			bAnal = True
	    EndIf

		if animation.HasTag("Vaginal") || animation.HasTag("Holding") || animation.HasTag("Gangbang")
	        iVaginalCountToday   = iVaginalCountToday + 1
			bVaginal = True
	    EndIf

		debugTrace(" s:" + iSexCountToday + " - v:" + iVaginalCountToday + " - a:" + iAnalCountToday + " - o:" + iOralCountToday)

		; Manage racial act count ==================================================
		; akSpeaker.GetActorBase().GetSex() as Int
		if animation.HasTag("Bestiality")
			iSexCreaturesAll   	= iSexCreaturesAll + 1
			fctHormones.modHormoneLevel(PlayerActor, "Pheromones", 0.2)
		EndIf

		if animation.HasTag("Canine")
			iSexDogAll   	= iSexDogAll + 1
		EndIf

		if animation.HasTag("Wolf")
			iSexWolfAll   	= iSexWolfAll + 1
		EndIf

		if animation.HasTag("Troll")
			iSexTrollAll   	= iSexTrollAll + 1
		EndIf

		if animation.HasTag("Chaurus") ||  animation.HasTag("Spider")
			iSexBugAll   	= iSexBugAll + 1
		EndIf

		if animation.HasTag("Giant")
			iSexGiantAll   	= iSexGiantAll + 1
		EndIf

		if animation.HasTag("Falmer")
			iSexFalmerAll   	= iSexFalmerAll + 1
		EndIf

		if animation.HasTag("Horse")
			iSexHorseAll   	= iSexHorseAll + 1
		EndIf

		if animation.HasTag("Bear")
			iSexBearAll   	= iSexBearAll + 1
		EndIf

		if animation.HasTag("Cat")
			iSexCatAll   	= iSexCatAll + 1
		EndIf

		if animation.HasTag("Gargoyle")
			iSexGargoyleAll   	= iSexGargoyleAll + 1
		EndIf

		if animation.HasTag("Vampire Lord")
			iSexVampireLordAll   	= iSexVampireLordAll + 1
		EndIf

		if animation.HasTag("Dragon")
			iSexDragonAll   	= iSexDragonAll + 1
		EndIf

		; debugTrace(" Daedra sex count:" + iSexDaedraAll + " - race check:" + _hasRace(actors, _SLH_DremoraRace) )

		; fctHormones.modHormoneLevel(PlayerActor, "Pigmentation", 1.0)
		; fctHormones.modHormoneLevel(PlayerActor, "Growth", 1.0)
		; fctHormones.modHormoneLevel(PlayerActor, "Metabolism", 1.0)
		; fctHormones.modHormoneLevel(PlayerActor, "Sleep", 1.0)
		; fctHormones.modHormoneLevel(PlayerActor, "Hunger", 1.0)
		; fctHormones.modHormoneLevel(PlayerActor, "Immunity", 1.0)
		; fctHormones.modHormoneLevel(PlayerActor, "Stress", 1.0)
		; fctHormones.modHormoneLevel(PlayerActor, "Mood", 1.0)
		; fctHormones.modHormoneLevel(PlayerActor, "Female", 1.0)
		; fctHormones.modHormoneLevel(PlayerActor, "Male", 1.0)
		; fctHormones.modHormoneLevel(PlayerActor, "SexDrive", 1.0)
		; fctHormones.modHormoneLevel(PlayerActor, "Pheromones", 1.0)
		; fctHormones.modHormoneLevel(PlayerActor, "Lactation", 1.0)
		; fctHormones.modHormoneLevel(PlayerActor, "Bimbo", 1.0)
		; fctHormones.modHormoneLevel(PlayerActor, "Succubus", 1.0)


		fctHormones.modHormoneLevel(PlayerActor, "Pigmentation", 1.5)
		fctHormones.modHormoneLevel(PlayerActor, "SexDrive", 10.0)

		if (StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormonePheromones")>0)
			fctHormones.modHormoneLevel(PlayerActor, "Pheromones", 0.2)
		Endif

		If (isLactating)
			fctHormones.modHormoneLevel(PlayerActor, "Lactation", 0.5)
		Endif

		If (isBimbo)
			fctHormones.modHormoneLevel(PlayerActor, "Bimbo", 0.5 * (actors.Length as Float))
			; Bonus for type of sex
			If (bOral)
				fctHormones.modHormoneLevel(PlayerActor, "Bimbo", 1.0)
			endIf
			If (bAnal)
				fctHormones.modHormoneLevel(PlayerActor, "Bimbo", 2.0)
			endIf
			If (bVaginal)
				fctHormones.modHormoneLevel(PlayerActor, "Bimbo", 0.5)
			endIf

		endIf

		iDaedricInfluence = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneSuccubus" ) as Int

		if  animation.HasTag("Daedra") || fctUtil.hasFormKeyword(actors, ActorTypeDaedra) || fctUtil.hasRace(actors, _SLH_DremoraRace) || fctUtil.hasRace(actors, _SLH_DremoraOutcastRace)
			iSexDaedraAll   	= iSexDaedraAll + 1
			iDaedricInfluence   = iSexDaedraAll * 3 + Game.QueryStat("Daedric Quests Completed") * 2 + Game.QueryStat("Daedra Killed") + 1
			StorageUtil.SetIntValue(PlayerActor, "_SLH_iDaedricInfluence",  iDaedricInfluence) 

			If (isBimbo)
				fctHormones.modHormoneLevel(PlayerActor, "Bimbo", 1.0)
			endIf

			fctHormones.modHormoneLevel(PlayerActor, "Succubus", 1.0)

			debugTrace(" Daedra sex count:" + iSexDaedraAll + " - influence:" + iDaedricInfluence)

			_SLH_DaedricInfluence.Cast(PlayerActor,PlayerActor)
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fTempGrowthMod",  2.0) 

			SendModEvent("SLHModHormoneRandom","Succubus", 1.0)
			SendModEvent("SDSanguineBlessingMod", "", 1)  

			; modify succubus influence based on other daedric exposure
			if (iDaedricInfluence >1) && (GV_allowSuccubus.GetValue()==1) && (GV_isSuccubus.GetValue()==0)
				setSuccubusState(PlayerActor, TRUE)
				; _SLH_QST_Succubus.Start()
				_SLH_QST_Succubus.SetStage(10)
				StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusLevel",  1) 

			elseif (iDaedricInfluence >1) && (GV_allowSuccubus.GetValue()==1) && (GV_isSuccubus.GetValue()==1)
				if (_SLH_QST_Succubus.GetStage()<=10) && (iDaedricInfluence >=10)
					_SLH_QST_Succubus.SetStage(20)
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusLevel",  2) 

				elseif (_SLH_QST_Succubus.GetStage()<=20) && (iDaedricInfluence >=20)
					_SLH_QST_Succubus.SetStage(30)
					; ModEvent.Send(ModEvent.Create("HoSLDD_GivePlayerPowers"))
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusLevel",  3) 

				elseif (_SLH_QST_Succubus.GetStage()<=30) && (iDaedricInfluence >=30)
					_SLH_QST_Succubus.SetStage(40)
					ModEvent.Send(ModEvent.Create("HoSLDD_GivePlayerPowers"))
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusLevel",  4) 

			        ; Do not switch sex for female -> bimbo
			        If fctUtil.isMale(PlayerActor)
				        Utility.Wait(1.0)
				        fctPolymorph.HRTEffectON( PlayerActor)

				        Utility.Wait(1.0)
				        fctPolymorph.TGEffectON( PlayerActor)

				        StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight",  0.0)
				        StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast",  0.9)
				        StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButt",  0.9)
				        PlayerActor.SendModEvent("SLHRefresh")
				    Endif

				elseif (_SLH_QST_Succubus.GetStage()<=40) && (iDaedricInfluence >=40) && !fctUtil.isMale(PlayerActor)
					_SLH_QST_Succubus.SetStage(50)
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusLevel",  5) 
					SendModEvent("SLHisSuccubus")
					SendModEvent("SLHCastSuccubusCurse")
				    fctPolymorph.TGEffectOFF( PlayerActor)
					SuccubusPlayerAlias.ForceRefTo(PlayerActor as ObjectReference)

				elseif (_SLH_QST_Succubus.GetStage()>=50) && (iDaedricInfluence >=40) && !fctUtil.isMale(PlayerActor)
					; Maintenance... grant powers again if they are missing
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusLevel",  5) 

					if (GV_isSuccubusFinal.GetValue()==0)
						GV_isSuccubusFinal.SetValue(1)
						SendModEvent("SLHisSuccubus")
						SendModEvent("SLHCastSuccubusCurse")
					endIf

					SuccubusPlayerAlias.ForceRefTo(PlayerActor as ObjectReference)
				Endif

			else
				setSuccubusState(PlayerActor, FALSE)

			EndIf
			; _showStatus()
		EndIf

		setHormonesSexualState( PlayerActor)

		If (bOral || bVaginal || bAnal)
			; Refreshing values in case of any external change from other mods
			fctBodyShape.getShapeState(PlayerActor) 

			; Update after sex disabled during testing of influence of new hormone levels
	    	fctBodyShape.alterBodyAfterSex(PlayerActor, bOral, bVaginal, bAnal )
	    	fctColor.alterColorAfterSex(PlayerActor )

			setHormonesState(PlayerActor)	
			traceStatus()

			If !( fctUtil.isExternalChangeModActive(PlayerActor) ) && (GV_shapeUpdateAfterSex.GetVAlue() == 1)
				fctColor.applyColorChanges(PlayerActor)
				fctBodyShape.getShapeState(PlayerActor) 
				; fctBodyShape.applyBodyShapeChanges(PlayerActor)
			EndIf
		Else
			setHormonesState(PlayerActor)	
		EndIf


		if animation.HasTag("Masturbation") || animation.HasTag("Solo") 
			fLibido = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fLibido")
			fLibido = fctUtil.iRange( (fLibido as Int) + 1, -100, 100)
			; SLH_Libido.SetValue( fLibido )
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fLibido",  fLibido)
			debugTrace("  Set Libido to " + fLibido )	  
	    EndIf

	    ; Chance of rape if sex in public 

	    ; Test if kPervert is in actors[] - small chance of repeat from current partner

		actor kPervert = none

		If (GV_allowBimbo.GetValue()==1) || (GV_allowHRT.GetValue()==1) || (GV_allowTG.GetValue()==1) 

			If fctUtil.hasRace(actors, _SLH_BimboRace)
				debugTrace(" Sex with Bimbo - risk of bimbo/sex change curse")
				actor kBimbo = fctUtil.getRaceActor(actors, _SLH_BimboRace)
				kPervert = None ; Disable pervert when transformation occurs

				; PolymorphBimbo.Cast(PlayerActor,PlayerActor)
				; PlayerActor.DoCombatSpellApply(_SLH_PolymorphBimbo, PlayerActor)

				; _SLH_QST_Bimbo.SetStage(10)
				iDaedricInfluence   = iDaedricInfluence   + 5
				SendModEvent("SLHModHormoneRandom","Bimbo", 1.0)

			Else
				kPervert = SexLab.FindAvailableActor(PlayerActor as ObjectReference, 200.0)  
			Endif
		Else
			kPervert = SexLab.FindAvailableActor(PlayerActor as ObjectReference, 200.0)  
		Endif		

		If (kPervert) 
			Bool isCurrentPartner = fctUtil.hasActor(actors, kPervert)

			If (!kPervert.IsDead()) && (kPervert.GetAV("Morality")<=2) && ((((Utility.RandomInt(1,100)< (StorageUtil.GetFloatValue(none, "_SLH_fHornyGrab") as Int))) && !isCurrentPartner) || ( (Utility.RandomInt(1,100)< ((StorageUtil.GetFloatValue(none, "_SLH_fHornyGrab") as Int) / 2.0) ) && isCurrentPartner))

				If  (SexLab.ValidateActor( PlayerActor) > 0) && (SexLab.ValidateActor( kPervert) > 0) 
					Int IButton = _SLH_warning.Show()

					If IButton == 0 ; Show the thing.

						; Debug.MessageBox( "Someone grabs you before you are done ." )
						SexLab.QuickStart( PlayerActor, kPervert, Victim = PlayerActor, AnimationTags = "Aggressive")
					EndIf
				Else
					debugTrace("  Pervert found but not ready [SexLab not ready]" )
				EndIf
			EndIf
		Else
			debugTrace("  No pervert found " )

		EndIf


		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneSuccubus", iDaedricInfluence as Float ) 
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDaedricInfluence", iDaedricInfluence as Int ) 

	EndIf

EndEvent

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	doOrgasm(_args)
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int Thread)
	string _args = Thread as string
	actor kActor = ActorRef as actor
	PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference()
	PlayerActor= PlayerREF as Actor

	if (kActor==PlayerActor)
		doOrgasm(_args)
	endIf
	
EndEvent

Function doOrgasm(String _args)
	Int iDaedricInfluence = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneSuccubus" ) as Int
	Int iSuccubus = StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubus")
	Int isPregnant = StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant")
	Int isSuccubus = StorageUtil.GetIntValue(PlayerActor, "_SLH_isSuccubus")
	Int isLactating = StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating")
	Int isBimbo = StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimbo")
  
	PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference()
	PlayerActor= PlayerREF as Actor

	if !Self || !SexLab 
		debugTrace("  Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim
	 

	If (fctUtil.hasPlayer(actors))
		debugTrace("  Orgasm!")

		; Manage orgasms count ==================================================
		If (iGameDateLastSex  == 0) 
			iGameDateLastSex = Game.QueryStat("Days Passed")   
		EndIf

		iDaysSinceLastSex = (Game.QueryStat("Days Passed") - iGameDateLastSex ) as Int

		iOrgasmsCountAll   = iOrgasmsCountAll + 1

		If (iDaysSinceLastSex == 0)
			iOrgasmsCountToday   = iOrgasmsCountToday + 1
		EndIf

		If (iOrgasmsCountToday>=1)
			PlayerActor.DispelSpell(_SLH_SexStarve)
		EndIf

		iGameDateLastSex = Game.QueryStat("Days Passed")   
		Float AbsLibido = (Math.abs(StorageUtil.GetFloatValue(PlayerActor, "_SLH_fLibido")) as Float)
		fctUtil.updateSexLabArousedExposure(PlayerActor, (fctHormones.getHormoneLevelsRacialAdjusted(PlayerActor, "SexDrive") as Int))

 		StorageUtil.SetIntValue(PlayerActor, "_SLH_iGameDateLastSex", iGameDateLastSex) 
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDaysSinceLastSex", iDaysSinceLastSex) 

		fctHormones.modHormoneLevel(PlayerActor, "Pigmentation", 2.5)

		If (fctUtil.IsMale(PlayerActor))
			; Male - larger drop of sex drive after orgasm, small chance of multiple orgasms
			If (Utility.RandomInt(0,100) < (StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneSexDrive") as Int))
				fctHormones.modHormoneLevel(PlayerActor, "SexDrive", -30.0 - 10.0 * (Utility.RandomInt(0,3)))
			Endif
		Else
			; Female - chance of increased sex drive after orgasm, possibility of multiple orgasms
			If (Utility.RandomInt(0,100) < ((StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneSexDrive") as Int) / 2))
				fctHormones.modHormoneLevel(PlayerActor, "SexDrive", -20.0 * (Utility.RandomInt(0,2)))
			else
				fctHormones.modHormoneLevel(PlayerActor, "SexDrive", 10.0 * (Utility.RandomInt(0,2)))
			endif
		Endif

		if (StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormonePheromones")>0)
			fctHormones.modHormoneLevel(PlayerActor, "Pheromones", 0.4)
		Endif

		If (isLactating)
			fctHormones.modHormoneLevel(PlayerActor, "Lactation", 1.0)
		Endif

		If (isBimbo)
			fctHormones.modHormoneLevel(PlayerActor, "Bimbo", 0.5)
		endIf

		; Succubus effect ==================================================
		If ((iSuccubus == 1)  && (_SLH_QST_Succubus.GetStage()>=30)) && !fctUtil.isMale(PlayerActor)
			; PlayerActor.resethealthandlimbs()
			If (Utility.RandomInt(0,100) > (60.0 - (AbsLibido / 10.0) * 2.0) )
				doSoulDevour(actors)
			EndIf
		EndIf

		; Succubus effect ==================================================
		If ((iSuccubus == 1)   && (_SLH_QST_Succubus.GetStage()>=50))
			; PlayerActor.resethealthandlimbs()

			If ( AbsLibido >= 80)
				StorageUtil.SetIntValue(PlayerActor, "Puppet_SpellON", 1)
				StorageUtil.SetIntValue(PlayerActor, "_SLH_succubusMC", 1)
				SendModEvent("PMGrantControlSpells")
			Else
				if (StorageUtil.GetIntValue(PlayerActor, "_SLMC_controlDeviceON")!=1)
					StorageUtil.SetIntValue(PlayerActor, "Puppet_SpellON", -1)
				EndIf
				StorageUtil.SetIntValue(PlayerActor, "_SLH_succubusMC", 0) 
				SendModEvent("PMRemoveControlSpells")
			EndIf
		EndIf
		; _showStatus()

	EndIf
	
EndFunction

Function doSoulDevour(Actor[] _actors)
	PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference()
	PlayerActor= PlayerAlias.GetReference() as Actor

	if _actors.Length < 2
		Return
	endif
	
	if !fctUtil.hasPlayer(_actors)
		Return
	EndIf
	
	Debug.Notification("Your orgasm drains your partner's very essence.")

	_SLH_DaedricInfluence.Cast(PlayerActor,PlayerActor)

	Float Libido  = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fLibido")
	Float AbsLibido = Math.abs(Libido)
	
	Actor target
	Actor bandit
	int   idx
	int   ii
	float skillPercent
	float statValue

	; SexSkill - 2 + 18 (if grand master in all 3 skills) + 10 (if powerful succubus) -> Max is 70
	Float   sexSkill = fctUtil.fMin ( 2.0 + (SexLab.GetPlayerStatLevel("Oral") + SexLab.GetPlayerStatLevel("Anal") + SexLab.GetPlayerStatLevel("Vaginal")) + (AbsLibido / 10.0), 70.0 )

	idx = 0
	while idx < _actors.Length
		if _actors[idx] == PlayerREF
			bandit = _actors[idx]
		else 
			target = _actors[idx]
		endif
		idx += 1
	endwhile
	
	
	if (Libido<= -10.0)   ; absorb Sta
		skillPercent = fctUtil.fMin( (Utility.RandomFloat(5.0, 20.0) + sexSkill) / 100.0 , 1.0 )
		debugTrace(" S%: " + skillPercent)
		
		statValue = target.GetActorValue("Stamina")
		statValue = math.Floor(statValue * skillPercent)
		bandit.RestoreActorValue("Stamina", statValue)
		debugTrace(" Sta: " + statValue)
	endif

	if (Libido>= 10.0)  ; absorb Sta/Mag
		skillPercent = fctUtil.fMin( (Utility.RandomFloat(5.0, 20.0) + sexSkill) / 100.0 , 1.0 )
		debugTrace(" M%: " + skillPercent)
		
		statValue = target.GetActorValue("Magicka")
		statValue = math.Floor(statValue * skillPercent)
		bandit.RestoreActorValue("Magicka", statValue)
		debugTrace(" Mag: " + statValue)
	endif
	
	if (Libido<= -10.0)  ; absorb HP
		skillPercent = fctUtil.fMin( (Utility.RandomFloat(5.0, 20.0) + sexSkill) / 100.0 , 1.0 )
		debugTrace(" HP%: " + skillPercent)
		
		statValue = target.GetActorValue("Health")
		statValue = math.Floor(statValue * skillPercent)
		bandit.RestoreActorValue("Health", statValue)
		debugTrace(" HP: " + statValue)
	endif
	
	if (Libido>= 80.0)  ; skill boost
		int[] skillsDiff = new Int[18]
		int   lowCnt
		int   skillDiff
		
		lowCnt = 0
		idx = 0
		while idx < skillList.Length
			skillDiff = math.floor(target.GetBaseActorValue(skillList[idx]) - bandit.GetBaseActorValue(skillList[idx]))
			if skillDiff > 0
				skillsDiff[lowCnt] = idx
				debugTrace(" Skill+:" + skillList[idx])
				lowCnt += 1
			endif
			idx += 1
		endWhile
		
		if lowCnt > 0
			idx = Utility.RandomInt(0, lowCnt - 1)
			if sexSkill > 0.0
				ii = 1 + ((sexSkill / 10.0) as Int )
			else
				ii = 1
			endif
			Game.IncrementSkillBy(skillList[idx], ii)
			debugTrace(" Skill: " + skillList[idx])
		endif
		
		If (utility.RandomInt(0,100)>90)
			; Small chance of puppet spell cast automatically
			Debug.MessageBox("Your charm is overwhelming for your victim.")
			StorageUtil.SetIntValue(bandit, "_SD_iRelationshipType" , 5 )
			bandit.SendModEvent("PMCharmPuppet")
			SendModEvent("PMGrantControlSpells")
 		
		EndIf
	endif

	if (Libido<= -80.0)   ; spell
		int spellCnt
		int spellGot
		ActorBase akBase = target.GetActorBase()
		
		spellCnt = akBase.GetSpellCount()
		spellGot = 0
		idx = 0
		while idx < spellCnt && spellGot < 1
			Spell spl = akBase.GetNthSpell(idx)
			
			if spl && spl.GetPerk() && !bandit.HasSpell(spl)
				bandit.AddSpell(spl, true)
				debugTrace(" Spell:" + spl.GetName())
				spellGot += 1
			endif

			idx += 1
		endwhile
		
	endif

	; SexLab Warm Bodies effect from draining victim after orgasm (extra heat)
	SendModEvent("SLFFModExposure", "A burst of heat rushes through your body.", 2.0)

	; debugTrace(" Beeing Female - Healing baby event" )
	; PlayerActor.SendModEvent("BeeingFemale", "HealBaby", 100)

EndFunction

;===========================================================================
; pumping iron effect on skill improvement
;===========================================================================
Event OnStoryIncreaseSkill(string asSkill)
	if asSkill == "LightArmor" || asSkill =="Marksman"
		; PumpingIronSleep.train(0.2)	
	elseif asSkill == "Block" || asSkill == "OneHanded" || asSkill == "Smithing" 
		; PumpingIronSleep.train(0.25)
	elseif asSkill == "HeavyArmor"
		; PumpingIronSleep.train(0.33)
	elseif asSkill == "TwoHanded"
		; PumpingIronSleep.train(0.5)
	endif 
		  
	DebugTrace(" Learning a new skill: " + asSkill)
	; Stop()
EndEvent

;===========================================================================
;moan sound
;===========================================================================


function playRandomSound(actor akActor)
	Int rollMessage = Utility.RandomInt(0,100)

	if (rollMessage > 80) ;if dropped anything, play a moan sound
		playMoan(akActor)
	elseif (rollMessage > 20) 
		playGiggle(akActor)
	else
		playChuckle(akActor)
	endif
endfunction

function playMoan(actor akActor)
	; sslBaseVoice voice = SexLab.GetVoice(akActor)
	; voice.Moan(akActor, 10 + (Utility.RandomInt(0,8) * 10 ), false)
	BimboMoanSound.play(akActor) 
endFunction

function playGiggle(actor akActor)
	; sslBaseVoice voice = SexLab.GetVoice(akActor)
	; voice.Moan(akActor, 10 + (Utility.RandomInt(0,8) * 10 ), false)
	BimboGiggleSound.play(akActor) 
endFunction

function playChuckle(actor akActor)
	; sslBaseVoice voice = SexLab.GetVoice(akActor)
	; voice.Moan(akActor, 10 + (Utility.RandomInt(0,8) * 10 ), false)
	BimboChuckleSound.play(akActor) 
endFunction


;===========================================================================
; Hormone 3.0+ system
;===========================================================================
Function applyHormonalChanges(Actor kActor)
	fctHormones.updateActorLibido(kActor)
	fctHormones.updateActorSwellFactor(kActor)

	fctBodyShape.alterBodyAfterRest(kActor)
	fctColor.alterColorFromHormone(kActor)

	setHormonesState(kActor)	

	traceStatus()
endFunction

;===========================================================================
; Manage hormonal state 
;===========================================================================

Function refreshShape(Actor kActor)

	bExternalChangeModActive = fctUtil.isExternalChangeModActive(kActor)

	debugTrace(" Updating shape" )

	fctBodyShape.getShapeState(kActor)
	fctBodyShape.refreshBodyShape(kActor)

	setHormonesState(kActor)

	If !( bExternalChangeModActive ) && (NextAllowed!= -1)
		fctBodyShape.applyBodyShapeChanges(kActor)
	EndIf
	
	StorageUtil.SetIntValue(kActor, "_SLH_iForcedRefresh", 0) 
	GV_forcedRefresh.SetValue(0)

EndFunction

Function refreshColor(Actor kActor)

	debugTrace(" Updating colors only" )
	debugTrace("     bExternalChangeModActive:" + bExternalChangeModActive)
	debugTrace("     NextAllowed: " + NextAllowed)
  
	; fctBodyShape.refreshBodyShape(kActor) 
	fctColor.applyColorChanges(kActor)
	If !( bExternalChangeModActive ) && (NextAllowed!= -1)
		fctBodyShape.applyBodyShapeChanges(kActor)
	EndIf
	
EndFunction


function initHormonesState(Actor kActor)

	; Debug.Notification("SexLab Hormones: Initialization of body state")
	debugTrace("  Initialization of hormones state")

	fctBodyShape.initShapeState(kActor)
	fctColor.initColorState(kActor)

	iOrgasmsCountToday   = 1
	iSexCountToday   = 1
	iOralCountToday   = 0
	iAnalCountToday   = 0
	iVaginalCountToday   = 0

	Float fLibido = Utility.RandomInt(15,30) as Float
	; SLH_Libido.SetValue( fLibido )
	StorageUtil.SetFloatValue(kActor, "_SLH_fLibido",  fLibido) 

endFunction

function setHormonesStateDefault(Actor kActor)

	; Debug.Notification("SexLab Hormones: Initialization of body state")
	debugTrace("  Set hormones state to default")

	fctBodyShape.setShapeStateDefault(kActor)
	fctColor.initColorState(kActor)

	Float fLibido = Utility.RandomInt(15,30) as Float
	; SLH_Libido.SetValue( fLibido )
	StorageUtil.SetFloatValue(kActor, "_SLH_fLibido",  fLibido) 

	If !( fctUtil.isExternalChangeModActive(PlayerActor) ) && (NextAllowed!= -1)
		fctColor.applyColorChanges(kActor)
		fctBodyShape.applyBodyShapeChanges(kActor)
	EndIf

	If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
		fctUtil.checkGender(kActor) 
		if (fctUtil.isMale(kActor))
			SendModEvent("yps-SetPlayerGenderEvent", "male")
		Else
			SendModEvent("yps-SetPlayerGenderEvent", "female")
		Endif
	EndIf

endFunction

function resetHormonesState(Actor kActor)
	
	; Debug.Notification("SexLab Hormones: Initialization of body state")
	debugTrace("  Reset of hormones state")

	fctBodyShape.resetShapeState(kActor)
	fctColor.resetColorState(kActor)

	Float fLibido = Utility.RandomInt(15,30) as Float
	; SLH_Libido.SetValue( fLibido )
	StorageUtil.SetFloatValue(kActor, "_SLH_fLibido",  fLibido) 

	applyHormonalChanges(kActor)

	iOrgasmsCountToday   = 0
	iSexCountToday   = 0
	iOralCountToday   = 0
	iAnalCountToday   = 0
	iVaginalCountToday   = 0

	If !( fctUtil.isExternalChangeModActive(PlayerActor) ) && (NextAllowed!= -1)
		fctColor.applyColorChanges(kActor)
		fctBodyShape.applyBodyShapeChanges(kActor)
	EndIf

endFunction

function setHormonesState(Actor kActor)

	debugTrace("    :: Writing Hormones state to storage")
 
	fctBodyShape.setShapeState(kActor) 
	setHormonesSexualState( kActor)

endFunction

function setHormonesSexualState(Actor kActor)
 
	StorageUtil.SetIntValue(kActor, "_SLH_iGameDateLastSex", iGameDateLastSex) 
	StorageUtil.SetIntValue(kActor, "_SLH_iDaysSinceLastSex", iDaysSinceLastSex)
	StorageUtil.SetIntValue(kActor, "_SLH_iDaysSinceLastCheck", iDaysSinceLastCheck)

	StorageUtil.SetIntValue(kActor, "_SLH_iOrgasmsCountToday", iOrgasmsCountToday) 
	StorageUtil.SetIntValue(kActor, "_SLH_iOrgasmsCountAll", iOrgasmsCountAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexCountToday", iSexCountToday) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexCountAll", iSexCountAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iOralCountToday", iOralCountToday) 
	StorageUtil.SetIntValue(kActor, "_SLH_iAnalCountToday", iAnalCountToday) 
	StorageUtil.SetIntValue(kActor, "_SLH_iVaginalCountToday", iVaginalCountToday) 
 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexCreaturesAll", iSexCreaturesAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexDogAll", iSexDogAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexWolfAll", iSexWolfAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexWerewolfAll", iSexWerewolfAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexManAll", iSexManAll)
	StorageUtil.SetIntValue(kActor, "_SLH_iSexMerAll", iSexMerAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexTrollAll", iSexTrollAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexBugAll", iSexBugAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexGiantAll", iSexGiantAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexFalmerAll", iSexFalmerAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexHorseAll", iSexHorseAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexBearAll", iSexBearAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexCatAll", iSexCatAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexGargoyleAll", iSexGargoyleAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexVampireLordAll", iSexVampireLordAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexDragonAll", iSexDragonAll) 
	StorageUtil.SetIntValue(kActor, "_SLH_iSexDaedraAll", iSexDaedraAll) 
 
	fctUtil.checkGender(kActor) 

	if fctUtil.isMale(kActor)
		StorageUtil.SetIntValue(kActor, "_SLH_isPregnant", 0)
		StorageUtil.SetIntValue(kActor, "_SLH_iLactating", 0)
	endIf

	if 	( fctUtil.isPregnantBySoulGemOven(kActor) || fctUtil.isPregnantBySimplePregnancy(kActor) || fctUtil.isPregnantByBeeingFemale(kActor) || fctUtil.isPregnantByEstrusChaurus(kActor) || ((StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SuccubusON") == 1) && (StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SoulGemPregnancyON") == 1)) )
		StorageUtil.SetIntValue(kActor, "_SLH_isPregnant", 1)
		GV_isPregnant.SetValue(1)

	Else
		StorageUtil.SetIntValue(kActor, "_SLH_isPregnant", 0)
		GV_isPregnant.SetValue(0)
	EndIf

	if 	(GV_isSuccubus.GetValue() == 1) || ((StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SuccubusON") == 1))
		StorageUtil.SetIntValue(kActor, "_SLH_isSuccubus", 1)
	Else
		StorageUtil.SetIntValue(kActor, "_SLH_isSuccubus", 0)
	EndIf	

	; Lactation triggers - works better with SexLab Stories Devious
	if (StorageUtil.GetIntValue(kActor, "_SLH_isSuccubus") == 1) && (_SLH_QST_Succubus.GetStage()>=50)
		if (StorageUtil.GetFloatValue(kActor, "_SLH_fLibido") > 60)
			StorageUtil.SetIntValue(kActor, "_SLH_iLactating", 1)
		else
			StorageUtil.SetIntValue(kActor, "_SLH_iLactating", 0)
		endif
	endif

	if (StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") == 1)
		if (StorageUtil.GetFloatValue(kActor, "_SLH_fBreast") > 1.5)
			StorageUtil.SetIntValue(kActor, "_SLH_iLactating", 1)
		else
			StorageUtil.SetIntValue(kActor, "_SLH_iLactating", 0)
		endif
	endif

	if (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1)
		StorageUtil.SetIntValue(kActor, "_SLH_iLactating", 1)
	endif

	StorageUtil.SetIntValue(kActor, "_SLH_iShowStatus", GV_showStatus.GetValueInt() as Int) 

endFunction

function getHormonesSexualState(Actor kActor)
	; fLibido = StorageUtil.GetFloatValue(kActor, "_SLH_fLibido" ) 

	iGameDateLastSex = StorageUtil.GetIntValue(kActor, "_SLH_iGameDateLastSex") 
	iDaysSinceLastSex = StorageUtil.GetIntValue(kActor, "_SLH_iDaysSinceLastSex")
	iDaysSinceLastCheck = StorageUtil.GetIntValue(kActor, "_SLH_iDaysSinceLastCheck" )

	iOrgasmsCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iOrgasmsCountToday") 
	iOrgasmsCountAll = StorageUtil.GetIntValue(kActor, "_SLH_iOrgasmsCountAll") 
	iSexCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iSexCountToday") 
	iSexCountAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexCountAll") 
 	iOralCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iOralCountToday") 
	iAnalCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iAnalCountToday") 
	iVaginalCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iVaginalCountToday") 

	; iTG = StorageUtil.GetIntValue(kActor, "_SLH_iTG") 
	; iHRT = StorageUtil.GetIntValue(kActor, "_SLH_iHRT") 
	; iBimbo = StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") 
	; iSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_iSuccubus") 
	; iDaedricInfluence = StorageUtil.GetIntValue(kActor, "_SLH_iDaedricInfluence") 
	; iSexStage = StorageUtil.GetIntValue(kActor, "_SLH_iSexStage") 

	iSexCreaturesAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexCreaturesAll") 
	iSexDogAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexDogAll") 
	iSexWolfAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexWolfAll") 
	iSexWerewolfAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexWerewolfAll") 
	iSexManAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexManAll")
	iSexMerAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexMerAll") 
	iSexTrollAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexTrollAll") 
	iSexBugAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexBugAll") 
	iSexGiantAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexGiantAll") 
	iSexFalmerAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexFalmerAll") 
	iSexHorseAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexHorseAll") 
	iSexBearAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexBearAll") 
	iSexCatAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexCatAll") 
	iSexGargoyleAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexGargoyleAll") 
	iSexVampireLordAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexVampireLordAll") 
	iSexDragonAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexDragonAll") 
	iSexDaedraAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexDaedraAll") 

	; GV_isBimbo.SetValue(iBimbo)
	; GV_isTG.SetValue(iTG)
	; GV_isHRT.SetValue(iHRT)
	; GV_isSuccubus.SetValue(iSuccubus)
endFunction

function getHormonesState(Actor kActor)
	; Debug.Notification("SexLab Hormones: Reading state from storage")
	debugTrace("    :: Reading Hormones state from storage")
 
 	fctBodyShape.getShapeState(kActor) 
	getHormonesSexualState( kActor)

endFunction

;===========================================================================
; Compatibility functions
;===========================================================================


Function startSex(Actor kSpeaker, string sexTags="Sex", string sexMsg="")
	Actor akActor = Game.GetPlayer()
	If  (SexLab.ValidateActor( akActor) > 0) &&  (SexLab.ValidateActor(kSpeaker) > 0) 
		; Debug.Notification( "[Resists weakly]" )
		if (sexMsg!="")
			Debug.Messagebox(sexMsg)
		endif

		ActorBase PlayerBase = akActor.GetBaseObject() as ActorBase
		Int PlayerGender = PlayerBase.GetSex() ; 0 = Male ; 1 = Female
		
		sslThreadModel Thread = SexLab.NewThread()
		Thread.AddActor(akActor) ; // IsVictim = true
		Thread.AddActor(kSpeaker ) ; // IsVictim = true

		; If (PlayerGender  == 1)
		;	Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "Lesbian," + SexTags))
		; Else
			Thread.SetAnimations(SexLab.GetAnimationsByTags(2, SexTags))
		; EndIf

		Thread.StartThread()

	EndIf
endFunction

Function _nodeBalancing()
	PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference() 
	PlayerActor = PlayerREF as Actor
	pActorBase = PlayerActor.GetActorBase()
	Float fNumModBreast = 1.0
	Float fNumModButt = 1.0
	Float fNumModBelly = 1.0


	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iNodeBalancing")==1)
		; Contributions includes in init values by default (to prevent div by 0)
		; if (StorageUtil.GetIntValue(none, "_SLH_iHormones")==1)
		;	fNumModBreast += 1.0
		;	fNumModBelly += 1.0
		;	fNumModButt += 1.0
		;endif

		if (StorageUtil.GetIntValue(PlayerActor, "_SLP_toggleSpiderEgg" )==1)
			fNumModBelly += 1.0
		endif

		if (StorageUtil.GetIntValue(PlayerActor, "_SLP_toggleChaurusWorm" )==1)
			fNumModButt += 1.0
		endif

		if (StorageUtil.GetIntValue(PlayerActor, "_SLP_toggleChaurusWormVag" )==1)
			fNumModBelly += 1.0
		endif

		if (StorageUtil.GetIntValue(PlayerActor, "_SLP_toggleFaceHugger" )==1)
			fNumModBelly += 1.0
		endif

		if (StorageUtil.GetIntValue(PlayerActor, "_SLP_toggleTentacleMonster" )==1)
			fNumModBreast += 1.0
		endif

		if (StorageUtil.GetIntValue(PlayerActor, "_SLP_toggleLivingArmor" )==1)
			fNumModBreast += 1.0
		endif

	 
		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant")== 1)
			fNumModBreast += 1.0
			fNumModBelly += 1.0
		endif

		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") == 1)
			fNumModBreast += 1.0
		endif

		StorageUtil.SetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg", 1.0 + 2.0 / fNumModBelly )
		StorageUtil.SetFloatValue(PlayerActor, "_SLP_bellyMaxChaurusWormVag", 1.0 + 2.0 / fNumModBelly )
		StorageUtil.SetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger", 1.0 + 2.0 / fNumModBelly )
		StorageUtil.SetFloatValue(PlayerActor, "_SLP_breastMaxTentacleMonster", 1.0 + 2.0 / fNumModBreast )
		StorageUtil.SetFloatValue(PlayerActor, "_SLP_breastMaxLivingArmor", 1.0 + 2.0 / fNumModBreast )
		StorageUtil.SetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm", 1.0 + 1.5 / fNumModButt )
		PlayerActor.SendModEvent("SLPRefreshBodyShape")

		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_isSuccubus") == 1)
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreastMax",  1.0 + 3.0   / fNumModBreast )
		else
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreastMax",  1.0 + 2.0   / fNumModBreast )
		endif
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBellyMax",  1.0 + 2.0  / fNumModBelly ) 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButtMax",  1.0 + 1.5  / fNumModButt )

		StorageUtil.SetFloatValue(PlayerActor, "_SLS_breastMaxMilkFarm", 1.0 + 2.0 / fNumModBreast )
		PlayerActor.SendModEvent("_SLSDDi_UpdateCow")

		fctBodyShape.setShapeState(PlayerActor)
	Endif
EndFunction


Function registerNewRacesForHair(FormList HairRaceList)

    If (!HairRaceList.HasForm( _SLH_BimboRace  as Form) )
		HairRaceList.AddForm( _SLH_BimboRace  as Form) 
	Endif
 
EndFunction

function setBimboState(Actor kActor, Bool bBimboState)
	Int iBimbo = bBimboState as Int
	GV_isBimbo.SetValue(iBimbo as Int)
	StorageUtil.SetIntValue(kActor, "_SLH_iBimbo", iBimbo as Int)
endFunction

function setTGState(Actor kActor, Bool bTGState)
	Int iTG = bTGState as Int
	GV_isTG.SetValue(iTG as Int)
	StorageUtil.SetIntValue(kActor, "_SLH_iTG", iTG as Int)
endFunction

function setHRTState(Actor kActor, Bool bHRTState)
	Int iHRT = bHRTState as Int
	GV_isHRT.SetValue(iHRT as Int)
	StorageUtil.SetIntValue(kActor, "_SLH_iHRT", iHRT as Int)
endFunction

function setSuccubusState(Actor kActor, Bool bSuccubusState)
	Int iSuccubus = bSuccubusState as Int
	GV_isSuccubus.SetValue(iSuccubus as Int)
	StorageUtil.SetIntValue(kActor, "_SLH_iSuccubus", iSuccubus as Int)
endFunction


;===========================================================================
; Debug functions
;===========================================================================

function showStatus()
	PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference() 
	PlayerActor = PlayerREF as Actor
	pActorBase = PlayerActor.GetActorBase()

	string shapeMessageStatus = fctBodyShape.getMessageStatus(PlayerActor)

	Debug.MessageBox("SexLab Hormones \n Sex acts today: " + iSexCountToday + " - Total: " + iSexCountAll + " \n v: " + iVaginalCountToday  + " a: " + iAnalCountToday  + " o: " + iOralCountToday  + " \n Orgasms today: " + iOrgasmsCountToday + " - Total: " + iOrgasmsCountAll + " \n Libido: " + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fLibido")  + " \n Daedric: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iDaedricInfluence") + " Succubus: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubus") +" \n Bimbo: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimbo") + " \n Sex change: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iHRT") +" TransGender: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iTG") +" \n Pregnant: " + fctUtil.isPregnantByBeeingFemale(PlayerActor) +" Chaurus: " + fctUtil.isPregnantByEstrusChaurus(PlayerActor) + " \n Lactating: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") + " Lvl: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel")+ " Prl: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iProlactinLevel")+ shapeMessageStatus )

EndFunction

function traceStatus()
	PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference() 
	PlayerActor = PlayerREF as Actor

	debugTrace("  Status ---------------------------------" )
	debugTrace("  Libido: " + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fLibido") )
	debugTrace("  Sex acts today: " + iSexCountToday + " - Total: " + iSexCountAll)

	debugTrace("  Oral acts today: " + iOralCountToday)
	debugTrace("  Vaginal acts today: " + iVaginalCountToday)
	debugTrace("  Anal acts today: " + iAnalCountToday)

	debugTrace("  Daedric Influence: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iDaedricInfluence"))
	debugTrace("  Succubus: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubus"))
	debugTrace("  Bimbo: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimbo"))
	debugTrace("  Sex Change: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iHRT"))
	debugTrace("  TransGender: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iTG"))
	; debugTrace("  HRT Phase: " + iSexStage)
	debugTrace("  Pregnant: " + fctUtil.isPregnantByBeeingFemale(PlayerActor))
	debugTrace("  Chaurus Breeder: " + fctUtil.isPregnantByEstrusChaurus(PlayerActor))

	debugTrace("  Orgasms today: " + iOrgasmsCountToday + " - Total: " + iOrgasmsCountAll)

	fctBodyShape.traceShapeStatus(PlayerActor)

EndFunction


Function debugTrace(string traceMsg)
	if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
		Debug.Trace("[SLH_QST_HormoneGrowth]" + traceMsg)
	endif
endFunction

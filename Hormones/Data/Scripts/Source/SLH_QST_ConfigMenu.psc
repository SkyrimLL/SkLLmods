scriptname SLH_QST_ConfigMenu extends SKI_ConfigBase

; SCRIPT VERSION ----------------------------------------------------------------------------------

int function GetVersion()
	return 2021 ; Default version
endFunction

;--------------------------------------
ReferenceAlias Property PlayerAlias  Auto  

GlobalVariable      Property GV_breastValue 			Auto
GlobalVariable      Property GV_buttValue 				Auto
GlobalVariable      Property GV_bellyValue 				Auto
GlobalVariable      Property GV_schlongValue 			Auto
GlobalVariable      Property GV_weightValue 			Auto

GlobalVariable      Property GV_breastSwellMod 			Auto
GlobalVariable      Property GV_bellySwellMod 			Auto
GlobalVariable      Property GV_schlongSwellMod 		Auto
GlobalVariable      Property GV_buttSwellMod 			Auto
GlobalVariable      Property GV_weightSwellMod 			Auto

GlobalVariable      Property GV_breastMax 				Auto
GlobalVariable      Property GV_buttMax 				Auto
GlobalVariable      Property GV_bellyMax 				Auto
GlobalVariable      Property GV_schlongMax 				Auto
GlobalVariable      Property GV_weightMax 				Auto

GlobalVariable      Property GV_breastMin				Auto
GlobalVariable      Property GV_buttMin 				Auto
GlobalVariable      Property GV_bellyMin 				Auto
GlobalVariable      Property GV_schlongMin 				Auto
GlobalVariable      Property GV_weightMin 				Auto

; -----
GlobalVariable      Property GV_armorMod 				Auto
GlobalVariable      Property GV_clothMod	 			Auto

GlobalVariable      Property GV_startingLibido 			Auto

GlobalVariable      Property GV_useNodes 				Auto
GlobalVariable      Property GV_useBreastNode 			Auto
GlobalVariable      Property GV_useButtNode 			Auto
GlobalVariable      Property GV_useBellyNode 			Auto
GlobalVariable      Property GV_useSchlongNode 			Auto

GlobalVariable      Property GV_useWeight 				Auto

GlobalVariable      Property GV_allowTG 				Auto
GlobalVariable      Property GV_allowHRT 				Auto
GlobalVariable      Property GV_allowBimbo 		 		Auto
GlobalVariable      Property GV_allowBimboRace	 		Auto
GlobalVariable      Property GV_allowSuccubus 			Auto
GlobalVariable      Property GV_setshapeToggle 			Auto
GlobalVariable      Property GV_resetToggle 			Auto
GlobalVariable      Property GV_origWeight	 			Auto 

GlobalVariable      Property GV_forcedRefresh 			Auto

GlobalVariable      Property GV_showStatus 				Auto
GlobalVariable      Property GV_commentsFrequency		Auto

GlobalVariable      Property GV_changeOverrideToggle	Auto
GlobalVariable      Property GV_shapeUpdateOnCellChange	Auto
GlobalVariable      Property GV_shapeUpdateAfterSex		Auto
GlobalVariable      Property GV_shapeUpdateOnTimer		Auto
GlobalVariable      Property GV_enableNiNodeUpdate		Auto
GlobalVariable      Property GV_enableNiNodeOverride	Auto 
; GlobalVariable      Property GV_enableBodyMorphs		Auto

GlobalVariable      Property GV_allowExhibitionist		Auto
GlobalVariable      Property GV_allowSelfSpells			Auto
GlobalVariable      Property GV_bimboClumsinessMod      Auto

GlobalVariable      Property GV_hornyBegON     			Auto
GlobalVariable      Property GV_hornyBegArousal      	Auto
GlobalVariable      Property GV_bimboClumsinessDrop    	Auto

; ====================================================
; Deprecated global variables

; GlobalVariable      Property GV_sexActivityThreshold 	Auto
; GlobalVariable      Property GV_sexActivityBuffer		Auto
; GlobalVariable      Property GV_baseSwellFactor 		Auto
; GlobalVariable      Property GV_baseShrinkFactor 		Auto

; GlobalVariable      Property GV_useColors 				Auto
; GlobalVariable      Property GV_useHairColors 			Auto
; GlobalVariable      Property GV_redShiftColor  			Auto
; GlobalVariable      Property GV_redShiftColorMod 		Auto
; GlobalVariable      Property GV_blueShiftColor 			Auto
; GlobalVariable      Property GV_blueShiftColorMod 		Auto
; GlobalVariable      Property GV_bimboShiftColor 		Auto
; GlobalVariable      Property GV_bimboShiftColorMod 		Auto
; GlobalVariable      Property GV_succubusShiftColor 		Auto
; GlobalVariable      Property GV_succubusShiftColorMod 	Auto

; ====================================================

SLH_QST_HormoneGrowth 	Property SLH_Control auto

; String                   Property NINODE_SCHLONG	 	= "NPC Genitals01 [Gen01]" AutoReadOnly
String                   Property NINODE_SCHLONG	 	= "NPC GenitalsBase [GenBase]" AutoReadOnly
String                   Property NINODE_LEFT_BREAST    = "NPC L Breast" AutoReadOnly
String                   Property NINODE_LEFT_BREAST01  = "NPC L Breast01" AutoReadOnly
String                   Property NINODE_LEFT_BUTT      = "NPC L Butt" AutoReadOnly
String                   Property NINODE_RIGHT_BREAST   = "NPC R Breast" AutoReadOnly
String                   Property NINODE_RIGHT_BREAST01 = "NPC R Breast01" AutoReadOnly
String                   Property NINODE_RIGHT_BUTT     = "NPC R Butt" AutoReadOnly
String                   Property NINODE_SKIRT02        = "SkirtBBone02" AutoReadOnly
String                   Property NINODE_SKIRT03        = "SkirtBBone03" AutoReadOnly
String                   Property NINODE_BELLY          = "NPC Belly" AutoReadOnly
Float                    Property NINODE_MAX_SCALE      = 2.0 AutoReadOnly
Float                    Property NINODE_MIN_SCALE      = 0.1 AutoReadOnly

; NiOverride version data
int Property NIOVERRIDE_VERSION = 4 AutoReadOnly
int Property NIOVERRIDE_SCRIPT_VERSION = 4 AutoReadOnly

; XPMSE version data
float Property XPMSE_VERSION = 3.0 AutoReadOnly
float Property XPMSELIB_VERSION = 3.0 AutoReadOnly


; PRIVATE VARIABLES -------------------------------------------------------------------------------

; --- Version 1 ---

; State


int			_startingLibido			= 30
int			_sexActivityThreshold	= 2
int			_sexActivityBuffer		= 3
float 		_baseSwellFactor 		= 10.0
float 		_baseShrinkFactor 		= 5.0

float 		_bellySwellMod 			= 1.0; 0.1 
float 		_breastSwellMod 		= 1.0; 0.3
float 		_buttSwellMod 			= 1.0; 0.2
float 		_schlongSwellMod 		= 1.0; 0.1 
float 		_weightSwellMod 		= 1.0; 0.1  

float 		_armorMod 				= 0.5; 0.1  
float 		_clothMod 				= 0.8; 0.1  

bool 		_hornyBegON     		= false
float 		_hornyBegArousal      	= 60.0
float 		_hornyGrab      		= -1.0
bool 		_bimboClumsinessDrop    = true
float 		_bimboClumsinessMod		= 1.0; 0.1  
float 		_bimboThoughtsDelay	= 1.0; 0.1  

float 		_breastMax      		= 4.0
float 		_bellyMax       		= 8.0
float 		_buttMax       			= 4.0
float 		_schlongMax       		= 4.0

float 		_breastMin      		= 0.8
float 		_bellyMin       		= 0.9
float 		_buttMin       			= 0.9
float 		_schlongMin       		= 0.5

bool		_useNodes				= true
bool		_useBreastNode			= true
bool		_useButtNode			= true
bool		_useBellyNode			= true
bool		_useSchlongNode			= true
bool		_useWeight				= true
bool		_changeOverrideToggle	= true
bool		_shapeUpdateOnCellChange = true
bool		_shapeUpdateAfterSex 	= true
bool		_shapeUpdateOnTimer 	= true
bool 		_enableBasicNetImmerse  = false
bool		_enableNiNodeUpdate 	= false
bool		_enableSLIFOverride		= true
bool		_enableNiNodeOverride	= true
bool		_enableBodyMorphs		= false

bool		_useColors				= true
int			_defaultColor 			= 0
int			_redShiftColor 			= 0
float		_redShiftColorMod 		= 1.0
int			_blueShiftColor 		= 0
float		_blueShiftColorMod 		= 1.0

bool		_useHairColors			= true
bool		_useHair				= true
bool		_useHairLoss			= true
int	 		_bimboHairColor 		= 0
float		_bimboHairColorMod 	= 1.0
int			_succubusHairColor 	= 0
float		_succubusHairColorMod 	= 1.0

float		_pigmentationMod = 0.1 
float		_growthMod = 0.5 
float		_metabolismMod = 0.5	 
float		_sleepMod = 1.2 
float		_FertilityMod = 1.2 		 
float		_immunityMod = 0.5	 
float		_stressMod = 1.8 			 
float		_moodMod = 0.5 			 
float		_maleMod = 1.2		 
float		_femaleMod = 1.2 			 
float		_sexDriveMod = 1.1	 
float		_pheromonesMod = 1.1		 
float		_lactationMod = 1.5 		 
float		_bimboMod = 0.0 		 
float		_succubusMod = 0.0 		 


bool		_allowExhibitionist		= false
bool		_allowSelfSpells		= false

bool		_allowTG				= false
bool		_allowHRT				= false
bool		_allowBimbo				= false
bool		_allowBimboRace			= false
bool		_allowSuccubus			= false

int			_setTG					= 0
int			_setHRT					= 0
int			_setBimbo				= 0
int			_setSuccubus			= 0

bool		_statusToggle			= false
bool		_setshapeToggle			= false
bool		_resetToggle			= false

bool		_showDebug				= false

bool		_showStatus 			= true
float		_commentsFrequency 		= 80.0

float 		_weightSetValue 		= 100.0
float 		_breastSetValue 		= 1.0
float 		_bellySetValue 			= 1.0
float 		_buttSetValue 			= 1.0
float 		_schlongSetValue		= 1.0

bool		_autoRemoveDragonWings = false

bool 		_refreshToggle 			= false
bool 		_resetHormonesToggle 	= false
bool 		_resetColorsToggle 		= false
bool 		_resetSkinColorToggle 	= false
int 		_applyNodeBalancing     = 0


ObjectReference PlayerREF
Actor PlayerActor
ActorBase pActorBase 
Int PlayerGender

String tmpText

bool Function CheckXPMSERequirements(Actor akActor, bool isFemale)
	return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction

; INITIALIZATION ----------------------------------------------------------------------------------

; @overrides SKI_ConfigBase
event OnConfigInit()
	Pages = new string[2]
	Pages[0] = "$SLH_pCustomization"
	Pages[1] = "$SLH_pAddons"

endEvent

; @implements SKI_QuestBase
event OnVersionUpdate(int a_version)
	{Called when a version update of this script has been detected}

	; Version 4 specific updating code
	if (a_version >= 2021 && CurrentVersion < 2021)
		Debug.Trace(self + ": Updating script to version 2021")
		Pages = new string[5]
		Pages[0] = "$SLH_pHormonelevels"
		Pages[1] = "$SLH_pBodyChanges"
		Pages[2] = "$SLH_pTriggers"
		Pages[3] = "$SLH_pCurses"
		Pages[4] = "$SLH_pDebug"
	endIf
endEvent


; EVENTS ------------------------------------------------------------------------------------------

; @implements SKI_ConfigBase
event OnPageReset(string a_page)
	{Called when a new page is selected, including the initial empty page}

	; workaround to force a refresh for first version change
	Debug.Notification("[SLH] Updating MCM to version 2021")
	Debug.Trace(self + ": Updating script to version 2021")
	Debug.Trace(self + ": CurrentVersion = " + CurrentVersion)
	Pages = new string[5]
	Pages[0] = "$SLH_pHormonelevels"
	Pages[1] = "$SLH_pBodyChanges"
	Pages[2] = "$SLH_pTriggers"
	Pages[3] = "$SLH_pCurses"
	Pages[4] = "$SLH_pDebug"

	If (!StorageUtil.HasIntValue(none, "_SLH_iHormones"))
		SLH_Control.initHormones()
	EndIf

	; Load custom logo in DDS format
	if (a_page == "")
		; Image size 512x512
		; X offset = 376 - (height / 2) = 120
		; Y offset = 223 - (width / 2) = 0
		LoadCustomContent("SexLab_Hormones/logo.dds", 120, 0)
		return
	else
		UnloadCustomContent()
	endIf

	PlayerREF= PlayerAlias.GetReference()
	PlayerActor= PlayerAlias.GetReference() as Actor
	pActorBase = PlayerActor.GetActorBase()
	PlayerGender = pActorBase.GetSex() ; 0 = Male ; 1 = Female

	_startingLibido = GV_startingLibido.GetValue() as Int
	_sexActivityThreshold = StorageUtil.GetIntValue(PlayerActor, "_SLH_iSexActivityThreshold") 
	_sexActivityBuffer = StorageUtil.GetIntValue(PlayerActor, "_SLH_iSexActivityBuffer") 
	_baseSwellFactor = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBaseSwellFactor")
	_baseShrinkFactor = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBaseShrinkFactor")

	_breastSwellMod = GV_breastSwellMod.GetValue()   as Float
	_bellySwellMod = GV_bellySwellMod.GetValue()   as Float 
	_schlongSwellMod = GV_schlongSwellMod.GetValue()   as Float 
	_buttSwellMod = GV_buttSwellMod.GetValue()   as Float
	_weightSwellMod = GV_weightSwellMod.GetValue()    as Float    

	_armorMod = GV_armorMod.GetValue()    as Float  
	_clothMod = GV_clothMod.GetValue()    as Float   
	_bimboClumsinessMod = GV_bimboClumsinessMod.GetValue()    as Float   
	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimboThoughtsDelay")==0)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBimboThoughtsDelay", 100)
	endIf
	_bimboThoughtsDelay = StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimboThoughtsDelay")

	If (_hornyGrab==-1.0)
		StorageUtil.SetFloatValue(none, "_SLH_fHornyGrab", 30.0)
	Endif

	_hornyBegON  = GV_hornyBegON.GetValue()    as Int
	_hornyBegArousal  = GV_hornyBegArousal.GetValue()    as Float
	_hornyGrab  = StorageUtil.GetFloatValue(none, "_SLH_fHornyGrab")
	_bimboClumsinessDrop  = GV_bimboClumsinessDrop.GetValue()    as Int

	_breastMax = GV_breastMax.GetValue()  as Float
	_bellyMax = GV_bellyMax.GetValue()  as Float 
	_schlongMax = GV_schlongMax.GetValue()  as Float 
	_buttMax = GV_buttMax.GetValue()  as Float 

	_breastMin = GV_breastMin.GetValue()  as Float
	_bellyMin = GV_bellyMin.GetValue()  as Float 
	_schlongMin = GV_schlongMin.GetValue()  as Float 
	_buttMin = GV_buttMin.GetValue()  as Float 

	_weightSetValue 		= GV_weightValue.GetValue()
	_breastSetValue 		= GV_breastValue.GetValue()
	_bellySetValue 			= GV_bellyValue.GetValue()
	_buttSetValue 			= GV_buttValue.GetValue()
	_schlongSetValue		= GV_schlongValue.GetValue()

	_useNodes = GV_useNodes.GetValue()  as Int
 	_useBreastNode = GV_useBreastNode.GetValue()  as Int
	_useButtNode = GV_useButtNode.GetValue()  as Int
	_useBellyNode = GV_useBellyNode.GetValue()  as Int
	_useSchlongNode = GV_useSchlongNode.GetValue()  as Int
	_useWeight = GV_useWeight.GetValue()  as Int

	_useHair = StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHair") as Bool  
	_useHairLoss = StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHairloss") as Bool  

	_useColors = StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseColors") as Bool  
	_useHairColors = StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHairColors") as Bool

	_defaultColor 		= StorageUtil.GetIntValue(PlayerActor, "_SLH_iDefaultSkinColor")  
	_redShiftColor 		= StorageUtil.GetIntValue(PlayerActor, "_SLH_iRedShiftColor") 
	_redShiftColorMod 	= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fRedShiftColorMod")
	_blueShiftColor 	= StorageUtil.GetIntValue(PlayerActor, "_SLH_iBlueShiftColor")
	_blueShiftColorMod 	= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBlueShiftColorMod")
	_bimboHairColor 	= StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimboHairColor")
	_bimboHairColorMod 	= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBimboHairColorMod")
	_succubusHairColor 	= StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubusHairColor")
	_succubusHairColorMod 	= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fSuccubusHairColorMod")

	_pigmentationMod 	= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormonePigmentationMod" ) 
	_growthMod 			= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneGrowthMod" ) 
	_metabolismMod 		= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneMetabolismMod")	 
	_sleepMod 			= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneSleepMod" )  
	_FertilityMod 		= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneFertilityMod" )		 
	_immunityMod 		= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneImmunityMod")		 
	_stressMod 			= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneStressMod" ) 			 
	_moodMod 			= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneMoodMod" )  			 
	_maleMod 			= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneMaleMod" )		 
	_femaleMod 			= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneFemaleMod" ) 			 
	_sexDriveMod 		= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneSexDriveMod" )		 
	_pheromonesMod 		= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormonePheromonesMod" )		 
	_lactationMod 		= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneLactationMod" ) 	
	_bimboMod 			= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneBimboMod" ) 	
	_succubusMod 		= StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneSuccubusMod" ) 	

	_showStatus = GV_showStatus.GetValue() as Bool
	_commentsFrequency = GV_commentsFrequency.GetValue() as Float

	_allowExhibitionist = GV_allowExhibitionist.GetValue()  as Int
	_allowSelfSpells = GV_allowSelfSpells.GetValue()  as Int

	_allowTG = StorageUtil.GetIntValue(PlayerActor, "_SLH_allowTG")
	_allowHRT = StorageUtil.GetIntValue(PlayerActor, "_SLH_allowHRT")
	_allowBimbo = StorageUtil.GetIntValue(PlayerActor, "_SLH_allowBimbo")
	_allowBimboRace = StorageUtil.GetIntValue(PlayerActor, "_SLH_allowBimboRace")
	_allowSuccubus = StorageUtil.GetIntValue(PlayerActor, "_SLH_allowSuccubus")

	_setTG = StorageUtil.GetIntValue(PlayerActor, "_SLH_iTG")
	_setHRT = StorageUtil.GetIntValue(PlayerActor, "_SLH_iHRT")
	_setBimbo = StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimbo")
	_setSuccubus = StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubus")

	_changeOverrideToggle = GV_changeOverrideToggle.GetValue()  as Int
	_shapeUpdateOnCellChange = GV_shapeUpdateOnCellChange.GetValue()  as Int
	_shapeUpdateAfterSex = GV_shapeUpdateAfterSex.GetValue()  as Int
	_shapeUpdateOnTimer = GV_shapeUpdateOnTimer.GetValue()  as Int
	; _enableNiNodeUpdate = GV_enableNiNodeUpdate.GetValue()  as Int
	_enableBasicNetImmerse = StorageUtil.GetIntValue(none, "_SLH_BasicNetImmerseON")
	_enableNiNodeUpdate = StorageUtil.GetIntValue(none, "_SLH_NiNodeUpdateON")
	_enableSLIFOverride = StorageUtil.GetIntValue(none, "_SLH_SLIFOverrideON")
	_enableNiNodeOverride = StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")
	_enableBodyMorphs = StorageUtil.GetIntValue(none, "_SLH_BodyMorphsON")

	_setshapeToggle = GV_setshapeToggle.GetValue()  as Int
	_resetToggle = GV_resetToggle.GetValue()  as Int
	_showDebug = StorageUtil.GetIntValue(none, "_SLH_debugTraceON")

	Bool bEnableLeftBreast  = NetImmerse.HasNode(PlayerActor, NINODE_LEFT_BREAST, false)
	Bool bEnableRightBreast = NetImmerse.HasNode(PlayerActor, NINODE_RIGHT_BREAST, false)
	Bool bEnableLeftButt    = NetImmerse.HasNode(PlayerActor, NINODE_LEFT_BUTT, false)
	Bool bEnableRightButt   = NetImmerse.HasNode(PlayerActor, NINODE_RIGHT_BUTT, false)
	Bool bEnableBelly       = NetImmerse.HasNode(PlayerActor, NINODE_BELLY, false)
	Bool bEnableSchlong     = NetImmerse.HasNode(PlayerActor, NINODE_SCHLONG, false)

	Bool bBreastEnabled     = ( bEnableLeftBreast && bEnableRightBreast as bool )
	Bool bButtEnabled       = ( bEnableLeftButt && bEnableRightButt  as bool )
	Bool bBellyEnabled      = ( bEnableBelly  as bool )
	Bool bSchlongEnabled    = ( bEnableSchlong as bool )

	If (a_page == "$SLH_pHormonelevels")
		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption("$SLH_hHormonesLevelsModifiers")
		AddSliderOptionST("STATE_METABOLISM","$SLH_sMETABOLISM", _metabolismMod as Float,"{1}") 
		AddSliderOptionST("STATE_FEMALE","$SLH_sFEMALE", _femaleMod as Float,"{1}") 
		AddSliderOptionST("STATE_MALE","$SLH_sMALE", _maleMod as Float,"{1}") 
		AddSliderOptionST("STATE_SEXDRIVE","$SLH_sSEXDRIVE", _sexDriveMod as Float,"{1}") 
		AddSliderOptionST("STATE_BIMBO_HORMONE","$SLH_sBIMBO_HORMONE", _bimboMod as Float,"{1}") 
		AddSliderOptionST("STATE_SUCCUBUS_HORMONE","$SLH_sSUCCUBUS_HORMONE", _succubusMod as Float,"{1}") 
		AddSliderOptionST("STATE_GROWTH","$SLH_sGROWTH", _growthMod as Float,"{1}") 
		AddSliderOptionST("STATE_PHEROMONES","$SLH_sPHEROMONES", _pheromonesMod as Float,"{1}") 
		AddSliderOptionST("STATE_LACTATION","$SLH_sLACTATION", _lactationMod as Float,"{1}") 
		AddSliderOptionST("STATE_PIGMENTATION","$SLH_sPIGMENTATION", _pigmentationMod as Float,"{1}") 
		AddSliderOptionST("STATE_SLEEP","$SLH_sSLEEP", _sleepMod as Float,"{1}") 
		AddSliderOptionST("STATE_FERTILITY","$SLH_sFERTILITY", _fertilityMod as Float,"{1}") 
		AddSliderOptionST("STATE_IMMUNITY","$SLH_sIMMUNITY", _immunityMod as Float,"{1}") 
		AddSliderOptionST("STATE_STRESS","$SLH_sSTRESS", _stressMod as Float,"{1}") 
		AddSliderOptionST("STATE_MOOD","$SLH_sMOOD", _moodMod as Float,"{1}") 

		AddEmptyOption()
		SetCursorPosition(1)

		AddHeaderOption("$SLH_hHormoneLevels") 
		; AddTextOption("      (not used before v3.0)", "", OPTION_FLAG_DISABLED) 

		AddTextOption("$     Metabolism: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneMetabolism") as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$     Female: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneFemale") as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$     Male: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneMale") as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$     SexDrive: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneSexDrive") as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$     Bimbo: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneBimbo") as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$     Succubus: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneSuccubus") as Int +"}", "", OPTION_FLAG_DISABLED)		
		AddTextOption("$     Growth: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneGrowth") as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$     Pheromones: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormonePheromones") as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$     Lactation: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneLactation") as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$     Fertility: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneFertility") as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$     Pigmentation: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormonePigmentation") as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$     Sleep: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneSleep") as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$     Immunity: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneImmunity") as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$     Stress: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneStress") as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$     Mood: {" + StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneMood") as Int +"}", "", OPTION_FLAG_DISABLED)



	elseIf (a_page == "$SLH_pBodyChanges")
		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption("$SLH_hWeight")
		AddToggleOptionST("STATE_CHANGE_WEIGHT","$SLH_bCHANGE_WEIGHT", _useWeight as Float)
		AddSliderOptionST("STATE_WEIGHT_SWELL","$SLH_sWEIGHT_SWELL", _weightSwellMod as Float,"{1}")

		AddHeaderOption("$SLH_hSkin")
		AddToggleOptionST("STATE_CHANGE_COLOR","$SLH_bCHANGE_COLOR", _useColors as Float)

		AddColorOptionST("STATE_DEFAULT_COLOR","$SLH_cDEFAULT_COLOR", _defaultColor as Int)
		AddInputOptionST("STATE_DEFAULT_COLOR_TXT","$SLH_iDEFAULT_COLOR_TXT", IntToHex(_defaultColor) as String)

		AddColorOptionST("STATE_RED_COLOR_SHIFT","$SLH_cRED_COLOR_SHIFT", _redShiftColor as Int)
		AddInputOptionST("STATE_RED_COLOR_TXT","$SLH_iRED_COLOR_TXT", IntToHex(_redShiftColor) as String)
		AddSliderOptionST("STATE_RED_COLOR_SHIFT_MOD","$SLH_sRED_COLOR_SHIFT_MOD", _redShiftColorMod as Float,"{1}")

		AddColorOptionST("STATE_BLUE_COLOR_SHIFT","$SLH_cBLUE_COLOR_SHIFT", _blueShiftColor as Int)
		AddInputOptionST("STATE_BLUE_COLOR_TXT","$SLH_iBLUE_COLOR_TXT", IntToHex(_blueShiftColor) as String)
		AddSliderOptionST("STATE_BLUE_COLOR_SHIFT_MOD","$SLH_sBLUE_COLOR_SHIFT_MOD", _blueShiftColorMod as Float,"{1}")

		AddHeaderOption("$SLH_hHair")
		AddToggleOptionST("STATE_CHANGE_HAIR","$SLH_bCHANGE_HAIR", _useHair as Float)
		AddToggleOptionST("STATE_CHANGE_HAIRLOSS","$SLH_bCHANGE_HAIRLOSS", _useHairLoss as Float)

		AddToggleOptionST("STATE_CHANGE_HAIRCOLOR","$SLH_bCHANGE_HAIRCOLOR", _useHairColors as Float)
		AddColorOptionST("STATE_BIMBO_HAIR_COLOR_SHIFT","$SLH_cBIMBO_HAIR_COLOR_SHIFT", _bimboHairColor as Int)
		AddInputOptionST("STATE_BIMBO_HAIR_COLOR_TXT","$SLH_iBIMBO_HAIR_COLOR_TXT", IntToHex(_bimboHairColor) as String)
		AddSliderOptionST("STATE_BIMBO_HAIR_COLOR_SHIFT_MOD","$SLH_sBIMBO_HAIR_COLOR_SHIFT_MOD", _bimboHairColorMod as Float,"{1}")

		AddColorOptionST("STATE_SUCCUBUS_HAIR_COLOR_SHIFT","$SLH_cSUCCUBUS_HAIR_COLOR_SHIFT", _succubusHairColor as Int)
		AddInputOptionST("STATE_SUCCUBUS_HAIR_COLOR_TXT","$SLH_iSUCCUBUS_HAIR_COLOR_TXT", IntToHex(_succubusHairColor) as String)
		AddSliderOptionST("STATE_SUCCUBUS_HAIR_COLOR_SHIFT_MOD","$SLH_sSUCCUBUS_HAIR_COLOR_SHIFT_MOD", _succubusHairColorMod as Float,"{1}")

		SetCursorPosition(1)

		AddHeaderOption("$SLH_hShape")
		AddToggleOptionST("STATE_CHANGE_OVERRIDE","$SLH_bCHANGE_OVERRIDE", _changeOverrideToggle as Float)
		AddSliderOptionST("STATE_SWELL_FACTOR","$SLH_sSWELL_FACTOR", _baseSwellFactor as Float,"{0} %")
		AddSliderOptionST("STATE_SHRINK_FACTOR","$SLH_sSHRINK_FACTOR", _baseShrinkFactor as Float,"{0} %")

		AddHeaderOption("$SLH_hClothCompression")
		AddSliderOptionST("STATE_ARMOR_MOD","$SLH_sARMOR_MOD", _armorMod as Float,"{1}")
		AddSliderOptionST("STATE_CLOTH_MOD","$SLH_sCLOTH_MOD", _clothMod as Float,"{1}")

		AddHeaderOption("$SLH_hBRreast")
		If (bBreastEnabled)
			AddToggleOptionST("STATE_CHANGE_BREAST_NODE","$SLH_bCHANGE_BREAST_NODE", _useBreastNode as Float)	
			AddSliderOptionST("STATE_BREAST_SWELL","$SLH_sBREAST_SWELL", _breastSwellMod as Float,"{1}")
			AddSliderOptionST("STATE_BREAST_MIN","$SLH_sBREAST_MIN", _breastMin as Float,"{1}")
			AddSliderOptionST("STATE_BREAST_MAX","$SLH_sBREAST_MAX", _breastMax as Float,"{1}")
		else
			AddToggleOptionST("STATE_CHANGE_BREAST_NODE","$SLH_bCHANGE_BREAST_NODE", _useBreastNode as Float, OPTION_FLAG_DISABLED)	
			; AddSliderOptionST("STATE_BREAST_SWELL","Breast swell modifier", _breastSwellMod as Float,"{1}", OPTION_FLAG_DISABLED)
			; AddSliderOptionST("STATE_BREAST_MAX","Breast swell max", _breastMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf

		AddHeaderOption("$SLH_hBelly")
		If (bBellyEnabled)
			AddToggleOptionST("STATE_CHANGE_BELLY_NODE","$SLH_bCHANGE_BELLY_NODE", _useBellyNode as Float)	
			AddSliderOptionST("STATE_BELLY_SWELL","$SLH_sBELLY_SWELL", _bellySwellMod as Float,"{1}")
			AddSliderOptionST("STATE_BELLY_MIN","$SLH_sBELLY_MIN", _bellyMin as Float,"{1}")
			AddSliderOptionST("STATE_BELLY_MAX","$SLH_sBELLY_MAX", _bellyMax as Float,"{1}")
		else
			AddToggleOptionST("STATE_CHANGE_BELLY_NODE","$SLH_bCHANGE_BELLY_NODE", _useBellyNode as Float, OPTION_FLAG_DISABLED)	
			; AddSliderOptionST("STATE_BELLY_SWELL","Belly swell modifier", _bellySwellMod as Float,"{1}", OPTION_FLAG_DISABLED)
			; AddSliderOptionST("STATE_BELLY_MAX","Belly swell max", _bellyMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf

		AddHeaderOption("$SLH_hButt")
		If (bButtEnabled)
			AddToggleOptionST("STATE_CHANGE_BUTT_NODE","$SLH_bCHANGE_BUTT_NODE", _useButtNode as Float)		
			AddSliderOptionST("STATE_BUTT_SWELL","$SLH_sBUTT_SWELL", _buttSwellMod as Float,"{1}")
			AddSliderOptionST("STATE_BUTT_MIN","$SLH_sBUTT_MIN", _buttMin as Float,"{1}")
			AddSliderOptionST("STATE_BUTT_MAX","$SLH_sBUTT_MAX", _buttMax as Float,"{1}")
		else
			AddToggleOptionST("STATE_CHANGE_BUTT_NODE","$SLH_bCHANGE_BUTT_NODE", _useButtNode as Float, OPTION_FLAG_DISABLED)		
			; AddSliderOptionST("STATE_BUTT_SWELL","Butt swell modifier", _buttSwellMod as Float,"{1}", OPTION_FLAG_DISABLED)
			; AddSliderOptionST("STATE_BUTT_MAX","Butt swell max", _buttMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf

		AddHeaderOption("$SLH_hSchlong")
		If (bSchlongEnabled)
			AddToggleOptionST("STATE_CHANGE_SCHLONG_NODE","$SLH_bCHANGE_SCHLONG_NODE", _useSchlongNode as Float)
			AddSliderOptionST("STATE_SCHLONG_SWELL","$SLH_sSCHLONG_SWELL", _schlongSwellMod as Float,"{1}")
			AddSliderOptionST("STATE_SCHLONG_MIN","$SLH_sSCHLONG_MIN", _schlongMin as Float,"{1}")
			AddSliderOptionST("STATE_SCHLONG_MAX","$SLH_sSCHLONG_MAX", _schlongMax as Float,"{1}")
		else
			AddToggleOptionST("STATE_CHANGE_SCHLONG_NODE","$SLH_bCHANGE_SCHLONG_NODE", _useSchlongNode as Float, OPTION_FLAG_DISABLED)
			; AddSliderOptionST("STATE_SCHLONG_SWELL","Schlong swell modifier", _schlongSwellMod as Float,"{1}", OPTION_FLAG_DISABLED)
			; AddSliderOptionST("STATE_SCHLONG_MAX","Schlong swell max", _schlongMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf

	elseIf (a_page == "$SLH_pTriggers")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLH_hSexualActivityTrigger")
		; AddSliderOptionST("STATE_LIBIDO","Starting libido", _startingLibido as Float) 
		AddSliderOptionST("STATE_SEX_TRIGGER","$SLH_sSEX_TRIGGER", _sexActivityThreshold as Float)		
		AddSliderOptionST("STATE_SEX_BUFFER","$SLH_sSEX_BUFFER", _sexActivityBuffer as Float)
		AddToggleOptionST("STATE_HORNY_BEG","$SLH_bHORNY_BEG", _hornyBegON   as Bool)
		AddSliderOptionST("STATE_BEG_TRIGGER","$SLH_sBEG_TRIGGER", _hornyBegArousal  as Float,"{1}")
		AddSliderOptionST("STATE_GRAB_TRIGGER","$SLH_sGRAB_TRIGGER", _hornyGrab  as Float,"{1}")
		AddToggleOptionST("STATE_EXHIBITIONIST","$SLH_bEXHIBITIONIST", _allowExhibitionist as Float)
		AddSliderOptionST("STATE_COMMENTS_FREQUENCY","$SLH_sCOMMENTS_FREQUENCY", _commentsFrequency as Float,"{1} %")

		AddEmptyOption()
		SetCursorPosition(1)

		AddHeaderOption("$SLH_hShapeChangeTriggers")
	  	AddToggleOptionST("STATE_CHANGE_NODES","$SLH_sCHANGE_NODES", _useNodes as Float)

		AddToggleOptionST("STATE_UPDATE_ON_CELL","$SLH_sUPDATE_ON_CELL", _shapeUpdateOnCellChange as Float)
		AddToggleOptionST("STATE_UPDATE_ON_SEX","$SLH_sUPDATE_ON_SEX", _shapeUpdateAfterSex as Float)
		AddToggleOptionST("STATE_UPDATE_ON_TIMER","$SLH_bUPDATE_ON_TIMER", _shapeUpdateOnTimer as Float)

    		; AddToggleOptionST("STATE_ENABLE_NODE_UPDATE","$SLH_sENABLE_NODE_UPDATE", _enableNiNodeUpdate as Float)
		; AddToggleOptionST("STATE_ENABLE_NODE_UPDATE","Enable QueueNodeUpdate", StorageUtil.GetIntValue(none, "_SLH_NiNodeUpdateON") as Float )

		AddHeaderOption("$SLH_hShapeChangeMethod")
 		AddTextOption("$SLH_hShapeChangePickOne", "", OPTION_FLAG_DISABLED)
		AddToggleOptionST("STATE_ENABLE_BASIC_NETIMMERSE","$SLH_bENABLE_BASIC_NETIMMERSE", StorageUtil.GetIntValue(none, "_SLH_BasicNetImmerseON") as Float)
		AddToggleOptionST("STATE_ENABLE_SLIF_OVERRIDE","$SLH_bENABLE_SLIF_OVERRIDE", StorageUtil.GetIntValue(none, "_SLH_SLIFOverrideON") as Float)
		AddToggleOptionST("STATE_ENABLE_NODE_OVERRIDE","$SLH_bENABLE_NODE_OVERRIDE", StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON") as Float)
		AddToggleOptionST("STATE_ENABLE_BODYMORPHS","Enable BodyMorphs", StorageUtil.GetIntValue(none, "_SLH_BodyMorphsON") as Float)
		
		; AddToggleOptionST("STATE_BALANCE","$SLH_sBALANCE", _applyNodeBalancing  as Float)

	elseIf (a_page == "$SLH_pCurses")
		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption("$SLH_hSuccubusCurse")
		AddToggleOptionST("STATE_SUCCUBUS","$SLH_bSUCCUBUS", _allowSuccubus as Float)
 
		AddHeaderOption(" Wings")
		if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubusLevel") >=4)
			AddToggleOptionST("STATE_AUTO_REMOVE_WINGS","Auto Remove Wings", _autoRemoveDragonWings as Float)
		else
			AddToggleOptionST("STATE_AUTO_REMOVE_WINGS","Auto Remove Wings", _autoRemoveDragonWings as Float, OPTION_FLAG_DISABLED)
		endif

		if (StorageUtil.GetIntValue(none, "_SLP_isAnimatedDragonWings") ==  1) 
			AddTextOption("     Animated Dragon Wings detected", "", OPTION_FLAG_DISABLED)
		endif

		if (StorageUtil.GetIntValue(none, "_SLP_isRealFlying") ==  1) 
			AddTextOption("     Real Flying detected", "", OPTION_FLAG_DISABLED)
		endif

		if (StorageUtil.GetIntValue(none, "_SLP_isAnimatedWingsUltimate") ==  1) 
			AddTextOption("     Animated Wings Ultimate detected", "", OPTION_FLAG_DISABLED)
		endif

		AddHeaderOption("$SLH_hSexChangeCurse")
		AddToggleOptionST("STATE_SEX_CHANGE","$SLH_bSEX_CHANGE", _allowHRT as Float)
		AddToggleOptionST("STATE_TG","$SLH_bTG", _allowTG as Float)

		AddHeaderOption("$SLH_hBimboCurse")
		AddToggleOptionST("STATE_BIMBO","$SLH_bBIMBO", _allowBimbo as Float)
		AddToggleOptionST("STATE_BIMBO_RACE","$SLH_bBIMBO_RACE", _allowBimboRace as Float)
		AddSliderOptionST("STATE_BIMBO_CLUMSINESS","$SLH_sBIMBO_CLUMSINESS", _bimboClumsinessMod as Float,"{1}")
		AddToggleOptionST("STATE_BIMBO_DROP","$SLH_bBIMBO_DROP", _bimboClumsinessDrop  as Bool)
		AddSliderOptionST("STATE_BIMBO_THOUGHTS","$SLH_sBIMBO_THOUGHTS", _bimboThoughtsDelay,"{1}")


		AddEmptyOption()
		SetCursorPosition(1)
		AddHeaderOption("$SLH_hCursesManualTriggers")
		AddToggleOptionST("STATE_SET_SUCCUBUS","$SLH_bSET_SUCCUBUS", _setSuccubus as Float)
		AddToggleOptionST("STATE_SET_SEX_CHANGE","$SLH_bSET_SEX_CHANGE", _setHRT as Float)
		AddToggleOptionST("STATE_SET_TG","$SLH_sSET_TG", _setTG as Float)
		AddToggleOptionST("STATE_SET_BIMBO","$SLH_bSET_BIMBO", _setBimbo as Float)



	elseIf (a_page == "$SLH_pDebug")
		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption("$SLH_hStatus")

		If (StorageUtil.GetIntValue(none, "_SLH_iHormonesSleepInit")==0)
			; Mod Init safety - sleep first
			AddTextOption("Hormones is inactive (sleep first)", "", OPTION_FLAG_DISABLED)
		Else
			AddTextOption("Hormones is ACTIVE", "")
		Endif

		AddToggleOptionST("STATE_SELF_SPELLS","$SLH_bSELF_SPELLS", _allowSelfSpells as Float)
		AddToggleOptionST("STATE_SHOW_STATUS","$SLH_bSHOW_STATUS", _showStatus as Bool)

		AddToggleOptionST("STATE_STATUS","$SLH_bSTATUS", _statusToggle as Float)

		AddHeaderOption("$SLH_hChangeShapeValues")
		AddSliderOptionST("STATE_WEIGHT_VALUE","$SLH_sWEIGHT_VALUE", _weightSetValue as Float,"{1}")
		AddSliderOptionST("STATE_BREAST_VALUE","$SLH_sBREAST_VALUE", _breastSetValue as Float,"{1}")
		AddSliderOptionST("STATE_BELLY_VALUE","$SLH_sBELLY_VALUE", _bellySetValue as Float,"{1}")
		AddSliderOptionST("STATE_BUTT_VALUE","$SLH_sBUTT_VALUE", _buttSetValue as Float,"{1}")
		AddSliderOptionST("STATE_SCHLONG_VALUE","$SLH_sSCHLONG_VALUE", _schlongSetValue as Float,"{1}")

		AddEmptyOption()
		AddToggleOptionST("STATE_REFRESH","$SLH_bREFRESH", _refreshToggle as Float)
 
		AddEmptyOption()
		SetCursorPosition(1)

		AddToggleOptionST("STATE_SETSHAPE","$SLH_bSETSHAPE", _setshapeToggle as Float)
		AddToggleOptionST("STATE_RESET_HORMONES","$SLH_bRESET_HORMONES", _resetHormonesToggle as Float)
		AddToggleOptionST("STATE_RESET_SKIN_COLOR","$SLH_bRESET_SKIN_COLOR", _resetSkinColorToggle as Float)
		AddToggleOptionST("STATE_RESET_COLORS","$SLH_bRESET_COLORS", _resetColorsToggle as Float)
		AddToggleOptionST("STATE_RESET","$SLH_bRESET", _resetToggle as Float)
		AddToggleOptionST("STATE_DEBUG","$SLH_bDEBUG", _showDebug as Float)

		AddHeaderOption("$SLH_hPlayerStatus")
		Int iHoursSinceLastSex = GetCurrentHourOfDay() - StorageUtil.GetIntValue(PlayerActor, "_SLH_iHourOfDaySinceLastSex") 

 		AddTextOption("$ Sex count today: {" +  StorageUtil.GetIntValue(PlayerActor, "_SLH_iSexCountToday")   as Int +"}", "", OPTION_FLAG_DISABLED)
 		AddTextOption("$ Last sex (hour of day): {" +  StorageUtil.GetIntValue(PlayerActor, "_SLH_iHourOfDaySinceLastSex")   as Int +"}", "", OPTION_FLAG_DISABLED)
 		AddTextOption("$ Hours since last sex: {" +  iHoursSinceLastSex  as Int +"}", "", OPTION_FLAG_DISABLED)
 		AddTextOption("$ Days since last sex: {" +  StorageUtil.GetIntValue(PlayerActor, "_SLH_iDaysSinceLastSex")   as Int +"}", "", OPTION_FLAG_DISABLED)
 		AddTextOption("$ StaminaRate = {" + PlayerActor.GetActorValue("StaminaRate")  as Float +"}", "", OPTION_FLAG_DISABLED)
 		AddTextOption("$ HealRate = {" + PlayerActor.GetActorValue("HealRate")  as Float +"}", "", OPTION_FLAG_DISABLED)
 		AddTextOption("$ MagickaRate = {" + PlayerActor.GetActorValue("MagickaRate")  as Float +"}", "", OPTION_FLAG_DISABLED)
		AddEmptyOption()

 		AddTextOption("$ Days as a Bimbo: {" + StorageUtil.GetIntValue(PlayerActor, "_SLH_bimboTransformGameDays")  as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$ Cycles as a Bimbo: {" + StorageUtil.GetIntValue(PlayerActor, "_SLH_bimboTransformCycle")  as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$ Bimbo Level: {" + StorageUtil.GetIntValue(PlayerActor, "_SLH_bimboTransformLevel")  as Int +"}", "", OPTION_FLAG_DISABLED)		
		AddTextOption("$ Milk Level: {" + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel")  as Int +"}", "", OPTION_FLAG_DISABLED)		
		AddEmptyOption()

		AddTextOption("$ Daedric Influence: {" +  StorageUtil.GetIntValue(PlayerActor, "_SLH_iDaedricInfluence")   as Int +"}", "", OPTION_FLAG_DISABLED)
		AddTextOption("$ Succubus Level: {" +  StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubusLevel")   as Int +"}", "", OPTION_FLAG_DISABLED)

		if (StorageUtil.GetFormValue(PlayerActor, "_SLH_fOrigRace") !=  (pActorBase.GetRace() as Form)) 
			AddTextOption("$SLH_xPlayerRaceWarning", "", OPTION_FLAG_DISABLED) 
		endif
	endIf
endEvent

; AddSliderOptionST("STATE_PIGMENTATION","Pigmentation hormone", _pigmentationMod as Float) 
state STATE_PIGMENTATION ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _pigmentationMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_pigmentationMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormonePigmentationMod", _pigmentationMod) 
		SetSliderOptionValueST( _pigmentationMod, "{1}" )
	endEvent

	event OnDefaultST()
		_pigmentationMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormonePigmentationMod", _pigmentationMod) 
		SetSliderOptionValueST( _pigmentationMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sPIGMENTATION_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_GROWTH","Growth hormone", _growthMod as Float) 
state STATE_GROWTH ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _growthMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_growthMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneGrowthMod", _growthMod) 
		SetSliderOptionValueST( _growthMod, "{1}" )
	endEvent

	event OnDefaultST()
		_growthMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneGrowthMod", _growthMod) 
		SetSliderOptionValueST( _growthMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sGROWTH_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_METABOLISM","Metabolism hormone", _metabolismMod as Float) 
state STATE_METABOLISM ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _metabolismMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_metabolismMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneMetabolismMod", _metabolismMod) 
		SetSliderOptionValueST( _metabolismMod, "{1}" )
	endEvent

	event OnDefaultST()
		_metabolismMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneMetabolismMod", _metabolismMod) 
		SetSliderOptionValueST( _metabolismMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sMETABOLISM_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_SLEEP","Sleep hormone", _sleepMod as Float) 
state STATE_SLEEP ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _sleepMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_sleepMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneSleepMod", _sleepMod) 
		SetSliderOptionValueST( _sleepMod, "{1}" )
	endEvent

	event OnDefaultST()
		_sleepMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneSleepMod", _sleepMod) 
		SetSliderOptionValueST( _sleepMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sSLEEP_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_Fertility","Fertility hormone", _FertilityMod as Float) 
state STATE_Fertility ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _FertilityMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_FertilityMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneFertilityMod", _FertilityMod) 
		SetSliderOptionValueST( _FertilityMod, "{1}" )
	endEvent

	event OnDefaultST()
		_FertilityMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneFertilityMod", _FertilityMod) 
		SetSliderOptionValueST( _FertilityMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sHUNGER_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_IMMUNITY","Immunity hormone", _immunityMod as Float) 
state STATE_IMMUNITY ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _immunityMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_immunityMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneImmunityMod", _immunityMod) 
		SetSliderOptionValueST( _immunityMod, "{1}" )
	endEvent

	event OnDefaultST()
		_immunityMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneImmunityMod", _immunityMod) 
		SetSliderOptionValueST( _immunityMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sIMMUNITY_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_STRESS","Stress hormone", _stressMod as Float) 
state STATE_STRESS ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _stressMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_stressMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneStressMod", _stressMod) 
		SetSliderOptionValueST( _stressMod, "{1}" )
	endEvent

	event OnDefaultST()
		_stressMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneStressMod", _stressMod) 
		SetSliderOptionValueST( _stressMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sSTRESS_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_MOOD","Mood hormone", _moodMod as Float) 
state STATE_MOOD ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _moodMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_moodMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneMoodMod", _moodMod) 
		SetSliderOptionValueST( _moodMod, "{1}" )
	endEvent

	event OnDefaultST()
		_moodMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneMoodMod", _moodMod) 
		SetSliderOptionValueST( _moodMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sMOOD_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_MALE","Male hormone", _maleMod as Float) 
state STATE_MALE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _maleMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_maleMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneMaleMod", _maleMod) 
		SetSliderOptionValueST( _maleMod, "{1}" )
	endEvent

	event OnDefaultST()
		_maleMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneMaleMod", _maleMod) 
		SetSliderOptionValueST( _maleMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sMALE_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_FEMALE","Female hormone", _femaleMod as Float) 
state STATE_FEMALE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _femaleMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_femaleMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneFemaleMod", _femaleMod) 
		SetSliderOptionValueST( _femaleMod, "{1}" )
	endEvent

	event OnDefaultST()
		_femaleMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneFemaleMod", _femaleMod) 
		SetSliderOptionValueST( _femaleMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sFEMALE_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_SEXDRIVE","Sex Drive hormone", _sexDriveMod as Float) 
state STATE_SEXDRIVE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _sexDriveMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_sexDriveMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneSexDriveMod", _sexDriveMod) 
		SetSliderOptionValueST( _sexDriveMod, "{1}" )
	endEvent

	event OnDefaultST()
		_sexDriveMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneSexDriveMod", _sexDriveMod) 
		SetSliderOptionValueST( _sexDriveMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sSEXDRIVE_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_PHEROMONES","Pheromones", _pheromonesMod as Float) 
state STATE_PHEROMONES ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _pheromonesMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_pheromonesMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormonePheromonesMod", _pheromonesMod) 
		SetSliderOptionValueST( _pheromonesMod, "{1}" )
	endEvent

	event OnDefaultST()
		_pheromonesMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormonePheromonesMod", _pheromonesMod) 
		SetSliderOptionValueST( _pheromonesMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sPHEROMONES_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_LACTATION","Lactation hormone", _lactationMod as Float) 
state STATE_LACTATION ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _lactationMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_lactationMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneLactationMod", _lactationMod) 
		SetSliderOptionValueST( _lactationMod, "{1}" )
	endEvent

	event OnDefaultST()
		_lactationMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneLactationMod", _lactationMod) 
		SetSliderOptionValueST( _lactationMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sLACTATION_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_BIMBO_HORMONE","Bimbo hormone", _bimboMod as Float,"{1}") 
state STATE_BIMBO_HORMONE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _bimboMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_bimboMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneBimboMod", _bimboMod) 
		SetSliderOptionValueST( _bimboMod, "{1}" )
	endEvent

	event OnDefaultST()
		_bimboMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneBimboMod", _bimboMod) 
		SetSliderOptionValueST( _bimboMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBIMBO_HORMONE_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_SUCCUBUS_HORMONE","Succubus hormone", _succubusMod as Float,"{1}") 
state STATE_SUCCUBUS_HORMONE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _succubusMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_succubusMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneSuccubusMod", _succubusMod) 
		SetSliderOptionValueST( _succubusMod, "{1}" )
	endEvent

	event OnDefaultST()
		_succubusMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fHormoneSuccubusMod", _succubusMod) 
		SetSliderOptionValueST( _succubusMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sSUCCUBUS_HORMONE_DESC")
	endEvent
endState

; 	AddToggleOptionST("STATE_RESET_HORMONES","Reset hormone levels", _resetHormonesToggle as Float)
state STATE_RESET_HORMONES ; TOGGLE
	event OnSelectST()
		; SLH_Control._refreshBodyShape()

		SendModEvent("SLHResetHormones")
		
		Debug.MessageBox("Hormone levels reset")
	endEvent

	event OnDefaultST()
		; Simple button - no default state
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bRESET_HORMONES_DESC")
	endEvent
endState

; AddToggleOptionST("STATE_RESET_SKIN_COLOR","Reset skin color", _resetSkinColorToggle as Float)
state STATE_RESET_SKIN_COLOR ; TOGGLE
	event OnSelectST()
		; SLH_Control._refreshBodyShape()
		
		Debug.MessageBox("Hormone skin color reset")

		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", StorageUtil.GetIntValue(PlayerActor, "_SLH_iDefaultSkinColor"))
		SLH_Control.refreshColor(PlayerActor)
	endEvent

	event OnDefaultST()
		; Simple button - no default state
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bRESET_SKIN_COLOR_DESC")
	endEvent
endState

; AddToggleOptionST("STATE_RESET_COLORS","Reset colors", _resetColorsToggle as Float)
state STATE_RESET_COLORS ; TOGGLE
	event OnSelectST()
		; SLH_Control._refreshBodyShape()
		Debug.MessageBox("Hormone colors reset")

		SendModEvent("SLHResetColors")
		
	endEvent

	event OnDefaultST()
		; Simple button - no default state
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bRESET_COLORS_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_LIBIDO","Starting libido", _startingLibido)
state STATE_LIBIDO ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_startingLibido.GetValueInt() )
		SetSliderDialogDefaultValue( 30 )
		SetSliderDialogRange( -100, 100 )
		SetSliderDialogInterval( 10 )
	endEvent

	event OnSliderAcceptST(float value)
		int thisValue = value as int
		GV_startingLibido.SetValueInt( thisValue )
		SetSliderOptionValueST( thisValue )
	endEvent

	event OnDefaultST()
		GV_startingLibido.SetValueInt( 30 )
		SetSliderOptionValueST( 30 )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sLIBIDO_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_SEX_TRIGGER","High Sex Activity trigger", _sexActivityThreshold)
state STATE_SEX_TRIGGER ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetIntValue(PlayerActor, "_SLH_iSexActivityThreshold") )
		SetSliderDialogDefaultValue( 2 )
		SetSliderDialogRange( 2, 10 )
		SetSliderDialogInterval( 1 )
	endEvent

	event OnSliderAcceptST(float value)
		int thisValue = value as int
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSexActivityThreshold",thisValue)
		SetSliderOptionValueST( thisValue )
	endEvent

	event OnDefaultST()
		Int thisValue = 3
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSexActivityThreshold",thisValue)
		SetSliderOptionValueST( thisValue )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sSEX_TRIGGER_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_SEX_BUFFER","High Sex Activity buffer", _sexActivityBuffer)
state STATE_SEX_BUFFER ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetIntValue(PlayerActor, "_SLH_iSexActivityBuffer") )
		SetSliderDialogDefaultValue( 7 )
		SetSliderDialogRange( 0, 10 )
		SetSliderDialogInterval( 1 )
	endEvent

	event OnSliderAcceptST(float value)
		int thisValue = value as int
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSexActivityBuffer",thisValue)
		SetSliderOptionValueST( thisValue )
	endEvent

	event OnDefaultST()
		Int thisValue = 7
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSexActivityBuffer",thisValue)
		SetSliderOptionValueST( thisValue )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sSEX_BUFFER_DESC")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_NODES","Change NetImmerse Nodes", _useNodes)
state STATE_CHANGE_NODES ; TOGGLE
	event OnSelectST()
		GV_useNodes.SetValueInt( Math.LogicalXor( 1, GV_useNodes.GetValueInt() ) )
		SetToggleOptionValueST( GV_useNodes.GetValueInt() as Bool )
		StorageUtil.SetIntValue(none, "_SLH_NiNodeUpdateON", GV_useNodes.GetValueInt())
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useNodes.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sCHANGE_NODES_DESC")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_BREAST_NODE","Change Breast Node", _useBreastNode as Float)	
state STATE_CHANGE_BREAST_NODE ; TOGGLE
	event OnSelectST()
		GV_useBreastNode.SetValueInt( Math.LogicalXor( 1, GV_useBreastNode.GetValueInt() ) )
		SetToggleOptionValueST( GV_useBreastNode.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useBreastNode.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bCHANGE_BREAST_NODE_DESC")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_BUTT_NODE","Change Butt Node", _useButtNode as Float)		
state STATE_CHANGE_BUTT_NODE ; TOGGLE
	event OnSelectST()
		GV_useButtNode.SetValueInt( Math.LogicalXor( 1, GV_useButtNode.GetValueInt() ) )
		SetToggleOptionValueST( GV_useButtNode.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useButtNode.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bCHANGE_BUTT_NODE_DESC")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_BELLY_NODE","Change Belly Node", _useBellyNode as Float)		
state STATE_CHANGE_BELLY_NODE ; TOGGLE
	event OnSelectST()
		GV_useBellyNode.SetValueInt( Math.LogicalXor( 1, GV_useBellyNode.GetValueInt() ) )
		SetToggleOptionValueST( GV_useBellyNode.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useBellyNode.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bCHANGE_BELLY_NODE_DESC")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_SCHLONG_NODE","Change Schlong Node", _useSchlongNode as Float)
state STATE_CHANGE_SCHLONG_NODE ; TOGGLE
	event OnSelectST()
		GV_useSchlongNode.SetValueInt( Math.LogicalXor( 1, GV_useSchlongNode.GetValueInt() ) )
		SetToggleOptionValueST( GV_useSchlongNode.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useSchlongNode.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bCHANGE_SCHLONG_NODE_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_SWELL_FACTOR","Base swell factor", _baseSwellFactor)
state STATE_SWELL_FACTOR ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBaseSwellFactor") )
		SetSliderDialogDefaultValue( 10.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBaseSwellFactor",thisValue)
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		float thisValue = 10.0 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBaseSwellFactor",thisValue)
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sSWELL_FACTOR_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_SHRINK_FACTOR","Base shrink factor", _baseShrinkFactor)
state STATE_SHRINK_FACTOR ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBaseShrinkFactor") )
		SetSliderDialogDefaultValue( 5.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBaseShrinkFactor",thisValue)
		SetSliderOptionValueST( thisValue ,"{0} %")
	endEvent

	event OnDefaultST()
		float thisValue = 5.0 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBaseShrinkFactor",thisValue)
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sSHRINK_FACTOR_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_ARMOR_MOD","Armor shrink", _armorMod)
state STATE_ARMOR_MOD ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_armorMod.GetValue() )
		SetSliderDialogDefaultValue( 0.5 )
		SetSliderDialogRange( 0.0, 1.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_armorMod.SetValue( thisValue )
		SetSliderOptionValueST( thisValue ,"{1}")

		refreshStorageFromGlobals() 
	endEvent

	event OnDefaultST()
		GV_armorMod.SetValue( 0.5 )
		SetSliderOptionValueST( 0.5,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sARMOR_MOD_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_CLOTH_MOD","Cloth shrink", _clothMod)
state STATE_CLOTH_MOD ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_clothMod.GetValue() )
		SetSliderDialogDefaultValue( 0.8 )
		SetSliderDialogRange( 0.0, 1.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_clothMod.SetValue( thisValue )
		SetSliderOptionValueST( thisValue ,"{1}")

		refreshStorageFromGlobals() 
	endEvent

	event OnDefaultST()
		GV_clothMod.SetValue( 0.8 )
		SetSliderOptionValueST( 0.8,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sCLOTH_MOD_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BREAST_SWELL","Breast swell modifier", _breastSwellMod)
state STATE_BREAST_SWELL ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_breastSwellMod.GetValue()  )
		SetSliderDialogDefaultValue( 0.3 )
		SetSliderDialogRange( -2.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_breastSwellMod.SetValue( thisValue  )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		GV_breastSwellMod.SetValue( 0.3 )
		SetSliderOptionValueST( 0.3, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBREAST_SWELL_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BREAST_MAX","Breast swell max", _breastMax)
state STATE_BREAST_MAX ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_breastMax.GetValue() )
		SetSliderDialogDefaultValue( 2.0 )
		SetSliderDialogRange( GV_breastMin.GetValue(), 4.0 )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_breastMax.SetValue( thisValue ) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_breastMax.SetValue( 2.0 )
		SetSliderOptionValueST( 2.0, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBREAST_MAX_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BREAST_MIN","Breast swell min", _breastMin)
state STATE_BREAST_MIN ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_breastMin.GetValue() )
		SetSliderDialogDefaultValue( 0.8 )
		SetSliderDialogRange( 0.1 , GV_breastMax.GetValue() )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_breastMin.SetValue( thisValue ) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_breastMin.SetValue( 0.8 )
		SetSliderOptionValueST( 0.8, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBREAST_MIN_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BELLY_SWELL","Belly swell modifier", _bellySwellMod)
state STATE_BELLY_SWELL ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_bellySwellMod.GetValue()   )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( -2.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value  
		GV_bellySwellMod.SetValue( thisValue  )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		GV_bellySwellMod.SetValue( 1.0 )
		SetSliderOptionValueST( 1.0, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBELLY_SWELL_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BELLY_MAX","Belly swell max", _bellyMax)
state STATE_BELLY_MAX ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_bellyMax.GetValue() )
		SetSliderDialogDefaultValue( 1.2 )
		SetSliderDialogRange( GV_bellyMin.GetValue(), 10.0 )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value as float
		GV_bellyMax.SetValue( thisValue )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_bellyMax.SetValue( 1.2 )
		SetSliderOptionValueST( 1.2, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBELLY_MAX_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BELLY_MIN","Belly swell min", _bellyMin)
state STATE_BELLY_MIN ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_bellyMin.GetValue() )
		SetSliderDialogDefaultValue( 0.8 )
		SetSliderDialogRange( 0.1 , GV_bellyMax.GetValue() )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_bellyMin.SetValue( thisValue ) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_bellyMin.SetValue( 0.8 )
		SetSliderOptionValueST( 0.8, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBELLY_MIN_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BUTT_SWELL","Butt swell modifier", _buttSwellMod)
state STATE_BUTT_SWELL ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_buttSwellMod.GetValue()  )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( -2.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value
		GV_buttSwellMod.SetValue( thisValue   )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		GV_buttSwellMod.SetValue( 1.0 )
		SetSliderOptionValueST( 1.0, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBUTT_SWELL_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BUTT_MAX",("Butt swell max", _buttMax)
state STATE_BUTT_MAX ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_buttMax.GetValue() )
		SetSliderDialogDefaultValue( 2.0 )
		SetSliderDialogRange( GV_buttMin.GetValue(), 4.0 )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value as float
		GV_buttMax.SetValue( thisValue )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_buttMax.SetValue( 2.0 )
		SetSliderOptionValueST( 2.0, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBUTT_MAX_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BUTT_MIN","Butt swell min", _buttMin)
state STATE_BUTT_MIN ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_buttMin.GetValue() )
		SetSliderDialogDefaultValue( 0.8 )
		SetSliderDialogRange( 0.1 , GV_buttMax.GetValue() )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_buttMin.SetValue( thisValue ) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_buttMin.SetValue( 0.8 )
		SetSliderOptionValueST( 0.8, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBUTT_MIN_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_SCHLONG_SWELL","Schlong swell modifier", _schlongSwellMod)
state STATE_SCHLONG_SWELL ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_schlongSwellMod.GetValue()   )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( -2.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value  
		GV_schlongSwellMod.SetValue( thisValue  )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		GV_schlongSwellMod.SetValue( 1.0 )
		SetSliderOptionValueST( 1.0, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sSCHLONG_SWELL_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_SCHLONG_MAX","Belly swell max", _bellyMax)
state STATE_SCHLONG_MAX ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_schlongMax.GetValue() )
		SetSliderDialogDefaultValue( 1.2 )
		SetSliderDialogRange( GV_schlongMin.GetValue(), 2.5 )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value as float
		GV_schlongMax.SetValue( thisValue )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_schlongMax.SetValue( 1.2 )
		SetSliderOptionValueST( 1.2, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sSCHLONG_MAX_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_SCHLONG_MIN","Schlong swell min", _schlongMin)
state STATE_SCHLONG_MIN ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_schlongMin.GetValue() )
		SetSliderDialogDefaultValue( 0.5 )
		SetSliderDialogRange( 0.1 , GV_schlongMax.GetValue() )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_schlongMin.SetValue( thisValue ) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_schlongMin.SetValue( 0.5 )
		SetSliderOptionValueST( 0.5, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sSCHLONG_MIN_DESC")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_WEIGHT","Change Weight scale", _useWeight)
state STATE_CHANGE_WEIGHT ; TOGGLE
	event OnSelectST()
		GV_useWeight.SetValueInt( Math.LogicalXor( 1, GV_useWeight.GetValueInt() ) )
		SetToggleOptionValueST( GV_useWeight.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()

		if (GV_origWeight.GetValue()== -1)
			GV_origWeight.SetValue(pActorBase.GetWeight())
		EndIf

		GV_useWeight.SetValue( GV_origWeight.GetValue() )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bCHANGE_WEIGHT_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_WEIGHT_SWELL","Weight swell mod", _weightSwellMod)
state STATE_WEIGHT_SWELL ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_weightSwellMod.GetValue() )
		SetSliderDialogDefaultValue( 1.0 ) ; Get starting weight as global variable
		SetSliderDialogRange( -2.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_weightSwellMod.SetValue( thisValue )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		GV_weightSwellMod.SetValue( 1.0 )
		SetSliderOptionValueST( 1.0, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sWEIGHT_SWELL_DESC")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_COLOR","Change colors", _useColors)
state STATE_CHANGE_COLOR ; TOGGLE
	event OnSelectST()
		_useColors = Math.LogicalXor( 1, _useColors as Int )
		SetToggleOptionValueST( _useColors as Bool )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iUseColors", _useColors as Int)
		SLH_Control.refreshColor(PlayerActor)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iUseColors", 0)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bCHANGE_COLOR_DESC")
	endEvent
endState

; AddToggleOptionST("STATE_CHANGE_Hair","Change hair", _useHair)
state STATE_CHANGE_HAIR ; TOGGLE
	event OnSelectST()
		_useHair = Math.LogicalXor( 1, _useHair as Int )
		SetToggleOptionValueST( _useHair as Bool )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iUseHair", _useHair as Int)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iUseHair", 1)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bCHANGE_HAIR_DESC")
	endEvent
endState

; AddToggleOptionST("STATE_CHANGE_HairLoss","Change hair", _useHairLoss)
state STATE_CHANGE_HAIRLOSS ; TOGGLE
	event OnSelectST()
		_useHairLoss = Math.LogicalXor( 1, _useHairLoss as Int )
		SetToggleOptionValueST( _useHairLoss as Bool )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iUseHairLoss", _useHair as Int)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iUseHairLoss", 1)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bCHANGE_HAIRLOSS_DESC")
	endEvent
endState

; AddToggleOptionST("STATE_CHANGE_HairCOLOR","Change colors", _useHairColors)
state STATE_CHANGE_HAIRCOLOR ; TOGGLE
	event OnSelectST()
		_useHairColors = Math.LogicalXor( 1, _useHairColors as Int )
		SetToggleOptionValueST( _useHairColors as Bool )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iUseHairColors", _useHairColors as Int)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iUseHairColors", 0)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bCHANGE_HAIRCOLOR_DESC")
	endEvent
endState


; AddColorOptionST("STATE_DEFAULT_COLOR","Default color", _defaultColor as Int)
state STATE_DEFAULT_COLOR ; COLOR
	event OnColorOpenST()
		SetColorDialogStartColor( _defaultColor )
		SetColorDialogDefaultColor( _defaultColor )  
	endEvent

	event OnColorAcceptST(int value) 
		_defaultColor = value
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultSkinColor", _defaultColor)
		; StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", _defaultColor)
		SetColorOptionValueST( _defaultColor )
		SLH_Control.refreshColor(PlayerActor)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		_defaultColor =  Math.LeftShift(255, 16) + Math.LeftShift(255, 8) + 255
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultSkinColor", _defaultColor)
		; StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", _defaultColor)
		SetColorOptionValueST( _defaultColor )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_cDEFAULT_COLOR_DESC")
	endEvent
endState
; AddColorOptionST("STATE_DEFAULT_COLOR_TXT","Default color text", IntToHex(_defaultColor) as String)
state STATE_DEFAULT_COLOR_TXT ; COLOR
	event OnInputOpenST()
		SetInputDialogStartText( IntToHex(_defaultColor)) 
	endEvent

	event OnInputAcceptST(string inputstr)
		_defaultColor = HexToInt(inputstr)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultSkinColor", _defaultColor)
		; StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", _defaultColor)
		SetInputOptionValueST( _defaultColor )
		SLH_Control.refreshColor(PlayerActor)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		_defaultColor =  Math.LeftShift(255, 16) + Math.LeftShift(255, 8) + 255
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultSkinColor", _defaultColor)
		; StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", _defaultColor)
		SetInputOptionValueST( IntToHex(_defaultColor) )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_iDEFAULT_COLOR_TXT_DESC")
	endEvent
endState
; AddColorOptionST("STATE_RED_COLOR_SHIFT","Red color shift", _redShiftColor as Int)
state STATE_RED_COLOR_SHIFT ; COLOR
	event OnColorOpenST()
		SetColorDialogStartColor( _redShiftColor )
		SetColorDialogDefaultColor( _redShiftColor )  
	endEvent

	event OnColorAcceptST(int value) 
		_redShiftColor = value
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iRedShiftColor", _redShiftColor)
		SetColorOptionValueST( _redShiftColor )
		SLH_Control.refreshColor(PlayerActor)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		_redShiftColor = 32
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iRedShiftColor", _redShiftColor)
		SetColorOptionValueST( _redShiftColor )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_cRED_COLOR_SHIFT_DESC")
	endEvent
endState
; AddColorOptionST("STATE_RED_COLOR_TXT","Red color text", IntToHex(_redShiftColor) as String)
state STATE_RED_COLOR_TXT ; COLOR
	event OnInputOpenST()
		SetInputDialogStartText( IntToHex(_redShiftColor)) 
	endEvent

	event OnInputAcceptST(string inputstr)
		_redShiftColor = HexToInt(inputstr)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iRedShiftColor", _redShiftColor)
		SetInputOptionValueST( inputstr )
		SLH_Control.refreshColor(PlayerActor)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		_defaultColor =  Math.LeftShift(255, 16) + Math.LeftShift(255, 8) + 255
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iRedShiftColor", _redShiftColor)
		SetInputOptionValueST( IntToHex(_redShiftColor) )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_iRED_COLOR_TXT_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_RED_COLOR_SHIFT_MOD","Red color shift mod", _redShiftColorMod as Float,"{1}")
state STATE_RED_COLOR_SHIFT_MOD ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _redShiftColorMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_redShiftColorMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fRedShiftColorMod", _redShiftColorMod) 
		SetSliderOptionValueST( _redShiftColorMod, "{1}" )
	endEvent

	event OnDefaultST()
		_redShiftColorMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fRedShiftColorMod", _redShiftColorMod) 
		SetSliderOptionValueST( _redShiftColorMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sRED_COLOR_SHIFT_MOD_DESC")
	endEvent
endState

; AddColorOptionST("STATE_BLUE_COLOR_SHIFT","Blue color shift", _blueShiftColor as Int)
state STATE_BLUE_COLOR_SHIFT ; COLOR
	event OnColorOpenST()
		SetColorDialogStartColor( _blueShiftColor )
		SetColorDialogDefaultColor( _blueShiftColor)
	endEvent

	event OnColorAcceptST(int value)
		_blueShiftColor = value 
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBlueShiftColor", _blueShiftColor)  
		SetColorOptionValueST( _blueShiftColor )
		SLH_Control.refreshColor(PlayerActor)
		SLH_Control.refreshColor(PlayerActor)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		_blueShiftColor = 3
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBlueShiftColor", _blueShiftColor)
		SetColorOptionValueST( _blueShiftColor )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_cBLUE_COLOR_SHIFT_DESC")
	endEvent
endState
; AddColorOptionST("STATE_BLUE_COLOR_TXT","Blue color text", IntToHex(_blueShiftColor) as String)
state STATE_BLUE_COLOR_TXT ; COLOR
	event OnInputOpenST()
		SetInputDialogStartText( IntToHex(_blueShiftColor)) 
	endEvent

	event OnInputAcceptST(string inputstr)
		_blueShiftColor = HexToInt(inputstr)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBlueShiftColor", _blueShiftColor)
		SetInputOptionValueST( inputstr )
		SLH_Control.refreshColor(PlayerActor)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		_defaultColor =  Math.LeftShift(255, 16) + Math.LeftShift(255, 8) + 255
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBlueShiftColor", _blueShiftColor)
		SetInputOptionValueST( IntToHex(_blueShiftColor) )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_iBLUE_COLOR_TXT_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BLUE_COLOR_SHIFT_MOD","Blue color shift mod", _blueShiftColorMod as Float,"{1}")
state STATE_BLUE_COLOR_SHIFT_MOD ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _blueShiftColorMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_blueShiftColorMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBlueShiftColorMod", _blueShiftColorMod) 
		SetSliderOptionValueST( _blueShiftColorMod, "{1}" )
	endEvent

	event OnDefaultST()
		_blueShiftColorMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBlueShiftColorMod", _blueShiftColorMod) 
		SetSliderOptionValueST( _blueShiftColorMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBLUE_COLOR_SHIFT_MOD_DESC")
	endEvent
endState

; AddColorOptionST("STATE_BIMBO_HAIR_COLOR_SHIFT","Bimbo Hair color shift", _bimboHairColor as Int)
state STATE_BIMBO_HAIR_COLOR_SHIFT ; COLOR
	event OnColorOpenST()
		SetColorDialogStartColor( _bimboHairColor )
		SetColorDialogDefaultColor( _bimboHairColor)
	endEvent

	event OnColorAcceptST(int value)
		_bimboHairColor = value 
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBimboHairColor", _bimboHairColor)  
		SetColorOptionValueST( _bimboHairColor )
		SLH_Control.refreshColor(PlayerActor)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		_bimboHairColor = 3
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBimboHairColor", _bimboHairColor)
		SetColorOptionValueST( _bimboHairColor )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_cBIMBO_HAIR_COLOR_SHIFT_DESC")
	endEvent
endState
; AddColorOptionST("STATE_BIMBO_HAIR_COLOR_TXT","Bimbo color text", IntToHex(_bimboHairColor) as String)
state STATE_BIMBO_HAIR_COLOR_TXT ; COLOR
	event OnInputOpenST()
		SetInputDialogStartText( IntToHex(_bimboHairColor)) 
	endEvent

	event OnInputAcceptST(string inputstr)
		_bimboHairColor = HexToInt(inputstr)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBimboHairColor", _bimboHairColor)
		SetInputOptionValueST( inputstr )
		SLH_Control.refreshColor(PlayerActor)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		_defaultColor =  Math.LeftShift(255, 16) + Math.LeftShift(255, 8) + 255
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBimboHairColor", _bimboHairColor)
		SetInputOptionValueST( IntToHex(_bimboHairColor) )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_iBIMBO_HAIR_COLOR_TXT_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BIMBO_HAIR_COLOR_SHIFT_MOD","Bimbo Hair shift mod", _bimboHairColorMod as Float,"{1}")
state STATE_BIMBO_HAIR_COLOR_SHIFT_MOD ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _bimboHairColorMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 1.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_bimboHairColorMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBimboHairColorMod", _bimboHairColorMod) 
		SetSliderOptionValueST( _bimboHairColorMod, "{1}" )
	endEvent

	event OnDefaultST()
		_bimboHairColorMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBimboHairColorMod", _bimboHairColorMod) 
		SetSliderOptionValueST( _bimboHairColorMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBIMBO_HAIR_COLOR_SHIFT_MOD_DESC")
	endEvent
endState

; AddColorOptionST("STATE_SUCCUBUS_HAIR_COLOR_SHIFT","Succubus Hair color shift", _succubusHairColor as Int)
state STATE_SUCCUBUS_HAIR_COLOR_SHIFT ; COLOR
	event OnColorOpenST()
		SetColorDialogStartColor( _succubusHairColor )
		SetColorDialogDefaultColor( _succubusHairColor)
	endEvent

	event OnColorAcceptST(int value)
		_succubusHairColor = value 
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusHairColor", _succubusHairColor)  
		SetColorOptionValueST( _succubusHairColor )
		SLH_Control.refreshColor(PlayerActor)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		_succubusHairColor = 3
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusHairColor", _succubusHairColor)
		SetColorOptionValueST( _succubusHairColor )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_cSUCCUBUS_HAIR_COLOR_SHIFT_DESC")
	endEvent
endState
; AddColorOptionST("STATE_SUCCUBUS_HAIR_COLOR_TXT","Succubus color text", IntToHex(_succubusHairColor) as String)
state STATE_SUCCUBUS_HAIR_COLOR_TXT ; COLOR
	event OnInputOpenST()
		SetInputDialogStartText( IntToHex(_succubusHairColor)) 
	endEvent

	event OnInputAcceptST(string inputstr)
		_succubusHairColor = HexToInt(inputstr)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusHairColor", _succubusHairColor)
		SetInputOptionValueST( inputstr )
		SLH_Control.refreshColor(PlayerActor)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		_defaultColor =  Math.LeftShift(255, 16) + Math.LeftShift(255, 8) + 255
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusHairColor", _succubusHairColor)
		SetInputOptionValueST( IntToHex(_succubusHairColor) )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_iSUCCUBUS_HAIR_COLOR_TXT_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_SUCCUBUS_HAIR_COLOR_SHIFT_MOD","Succubus Hair shift mod", _succubusHairColorMod as Float,"{1}")
state STATE_SUCCUBUS_HAIR_COLOR_SHIFT_MOD ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _succubusHairColorMod )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 1.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		_succubusHairColorMod  = value 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSuccubusHairColorMod", _succubusHairColorMod) 
		SetSliderOptionValueST( _succubusHairColorMod, "{1}" )
	endEvent

	event OnDefaultST()
		_succubusHairColorMod = 1.0
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSuccubusHairColorMod", _succubusHairColorMod) 
		SetSliderOptionValueST( _succubusHairColorMod , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sSUCCUBUS_HAIR_COLOR_SHIFT_MOD_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_WEIGHT_VALUE","Weight", _weightSetValue as Float,"{1}")
state STATE_WEIGHT_VALUE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_weightValue.GetValue()  )
		SetSliderDialogDefaultValue( GV_weightValue.GetValue() ) ; Get starting weight as global variable
		SetSliderDialogRange( GV_weightMin.GetValue(), GV_weightMax.GetValue() )
		SetSliderDialogInterval( 10.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 

		float fOldWeight = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fWeight")

		GV_weightValue.SetValue( thisValue) 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight",  thisValue) 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fManualWeightChange",  fOldWeight) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		SetSliderOptionValueST( GV_weightValue.GetValue() , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sWEIGHT_VALUE_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BREAST_VALUE","Breast", _breastSetValue as Float,"{1}")
state STATE_BREAST_VALUE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_breastValue.GetValue() )
		SetSliderDialogDefaultValue( GV_breastValue.GetValue() ) ; Get starting weight as global variable
		SetSliderDialogRange( GV_breastMin.GetValue(), GV_breastMax.GetValue() )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_breastValue.SetValue(thisValue)
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast",  thisValue)
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		SetSliderOptionValueST( GV_breastValue.GetValue(), "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBREAST_VALUE_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BELLY_VALUE","Belly", _bellySetValue as Float,"{1}")
state STATE_BELLY_VALUE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_bellyValue.GetValue()  )
		SetSliderDialogDefaultValue( GV_bellyValue.GetValue() ) ; Get starting weight as global variable
		SetSliderDialogRange( GV_bellyMin.GetValue(), GV_bellyMax.GetValue() )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_bellyValue.SetValue(thisValue) 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBelly",  thisValue) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		SetSliderOptionValueST( GV_bellyValue.GetValue(), "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBELLY_VALUE_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BUTT_VALUE","Butt", _buttSetValue as Float,"{1}")
state STATE_BUTT_VALUE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_buttValue.GetValue()  )
		SetSliderDialogDefaultValue(  GV_buttValue.GetValue() ) ; Get starting weight as global variable
		SetSliderDialogRange( GV_buttMin.GetValue(), GV_buttMax.GetValue() )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_buttValue.SetValue(thisValue)
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButt",  thisValue) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		SetSliderOptionValueST( GV_buttValue.GetValue() , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBUTT_VALUE_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_SCHLONG_VALUE","Schlong", _schlongSetValue as Float,"{1}")
state STATE_SCHLONG_VALUE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_schlongValue.GetValue()  )
		SetSliderDialogDefaultValue( GV_schlongValue.GetValue() ) ; Get starting weight as global variable
		SetSliderDialogRange( GV_schlongMin.GetValue(), GV_schlongMax.GetValue() )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_schlongValue.SetValue(thisValue) 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSchlong",  thisValue) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		SetSliderOptionValueST( GV_schlongValue.GetValue(), "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sSCHLONG_VALUE_DESC")
	endEvent
endState
; AddToggleOptionST("STATE_REFRESH","Apply changes", _refreshToggle as Float)
state STATE_REFRESH ; TOGGLE
	event OnSelectST()
		; SLH_Control._refreshBodyShape()

		refreshStorageFromGlobals() 
		
		Debug.MessageBox("Exit the menu and wait a few seconds")
	endEvent

	event OnDefaultST()
		; Simple button - no default state
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bREFRESH_DESC")
	endEvent
endState


; AddToggleOptionST("STATE_SUCCUBUS","Succubus mode", _allowSuccubus)
state STATE_SUCCUBUS ; TOGGLE
	event OnSelectST()
		GV_allowSuccubus.SetValueInt( Math.LogicalXor( 1, GV_allowSuccubus.GetValueInt() ) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowSuccubus", GV_allowSuccubus.GetValue() as Int)
		SetToggleOptionValueST( GV_allowSuccubus.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowSuccubus.SetValueInt( 0 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowSuccubus", GV_allowSuccubus.GetValue() as Int)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bSUCCUBUS_DESC")
	endEvent
endState
state STATE_SET_SUCCUBUS ; TOGGLE
	event OnSelectST()
		SetToggleOptionValueST( StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubus") as Bool )

		GV_allowSuccubus.SetValueInt( 1 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowSuccubus", GV_allowSuccubus.GetValue() as Int)

		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubus") == 0)
			Debug.MessageBox("Casting the Succubus curse. Leave the menu to view the effects.")
			PlayerActor.SendModEvent("SLHCastSuccubusCurse")
		else
			; Debug.MessageBox("Unfortunately.. there is no cure for a Succubus")
			Debug.MessageBox("Curing the Succubus curse. Leave the menu to view the effects.")
			PlayerActor.SendModEvent("SLHCureSuccubusCurse")
		EndIf
		ForcePageReset()
	endEvent

	event OnDefaultST() 
		SetToggleOptionValueST( StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubus") as Bool )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bSET_SUCCUBUS_DESC")
	endEvent
endState
; AddToggleOptionST("STATE_BIMBO","Sex Change Curse", _allowBimbo)
state STATE_BIMBO ; TOGGLE
	event OnSelectST()
		GV_allowBimbo.SetValueInt( Math.LogicalXor( 1, GV_allowBimbo.GetValueInt() ) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowBimbo", GV_allowBimbo.GetValue() as Int)
		SetToggleOptionValueST( GV_allowBimbo.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowBimbo.SetValueInt( 0 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowBimbo", GV_allowBimbo.GetValue() as Int)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bBIMBO_DESC")
	endEvent
endState
state STATE_SET_BIMBO ; TOGGLE
	event OnSelectST()
		SetToggleOptionValueST( StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimbo") as Bool )

		GV_allowHRT.SetValueInt( 1 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowHRT", GV_allowHRT.GetValue() as Int)
		GV_allowBimbo.SetValueInt( 1 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowBimbo", GV_allowBimbo.GetValue() as Int)

		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimbo") == 0)
			Debug.MessageBox("Casting the Bimbo curse and forcing curse options if necessary. Leave the menu to view the effects.")
			PlayerActor.SendModEvent("SLHCastBimboCurse")
		else
			Debug.MessageBox("Curing the Bimbo curse. Leave the menu to view the effects.")
			PlayerActor.SendModEvent("SLHCureBimboCurse")
		endIf

		ForcePageReset()
	endEvent

	event OnDefaultST() 
		SetToggleOptionValueST( StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimbo") as Bool )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bSET_BIMBO_DESC")
	endEvent
endState
; AddToggleOptionST("STATE_BIMBO","Sex Change Curse", _allowBimboRace)
state STATE_BIMBO_RACE ; TOGGLE
	event OnSelectST()
		GV_allowBimboRace.SetValueInt( Math.LogicalXor( 1, GV_allowBimboRace.GetValueInt() ) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowBimboRace", GV_allowBimboRace.GetValue() as Int)
		SetToggleOptionValueST( GV_allowBimboRace.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowBimboRace.SetValueInt( 0 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowBimboRace", GV_allowBimboRace.GetValue() as Int)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bBIMBO_RACE_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BIMBO_CLUMSINESS","Bimbo clumsiness factor", _bimboClumsinessMod)
state STATE_BIMBO_CLUMSINESS ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_bimboClumsinessMod.GetValue() )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( 0.0, 1.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_bimboClumsinessMod.SetValue( thisValue )
		SetSliderOptionValueST( thisValue ,"{1}") 
	endEvent

	event OnDefaultST()
		GV_bimboClumsinessMod.SetValue( 1.0 )
		SetSliderOptionValueST( 1.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBIMBO_CLUMSINESS_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_BIMBO_THOUGHTS","Bimbo thougths delay", _bimboThoughtsDelay)
state STATE_BIMBO_THOUGHTS ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _bimboThoughtsDelay  )
		SetSliderDialogDefaultValue( 1 )
		SetSliderDialogRange( 1, 200 )
		SetSliderDialogInterval( 1 )
	endEvent

	event OnSliderAcceptST(float value)
		Int thisValue = value as Int
		_bimboThoughtsDelay = thisValue 
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBimboThoughtsDelay", thisValue)
		SetSliderOptionValueST( thisValue ,"{1}") 
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBimboThoughtsDelay", 1)
		SetSliderOptionValueST( 1,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBIMBO_THOUGHTS_DESC")
	endEvent
endState

; AddToggleOptionST("STATE_HORNY_BEG","Beg for sex", _hornyBegON   as Bool)
state STATE_HORNY_BEG ; TOGGLE
	event OnSelectST()
		GV_hornyBegON.SetValueInt( Math.LogicalXor( 1, GV_hornyBegON.GetValueInt() ) )
		SetToggleOptionValueST( GV_hornyBegON.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_hornyBegON.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bHORNY_BEG_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_BEG_TRIGGER","Beg arousal trigger", _hornyBegArousal  as Float,"{1}")
state STATE_BEG_TRIGGER ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_hornyBegArousal.GetValue() )
		SetSliderDialogDefaultValue( 60.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_hornyBegArousal.SetValue( thisValue )
		SetSliderOptionValueST( thisValue ,"{1}") 
	endEvent

	event OnDefaultST()
		GV_hornyBegArousal.SetValue( 60.0 )
		SetSliderOptionValueST( 60.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBEG_TRIGGER_DESC")
	endEvent
endState
; AddSliderOptionST("STATE_GRAB_TRIGGER","Public sex attack", _hornyGrab  as Float,"{1}")
state STATE_GRAB_TRIGGER ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _hornyGrab )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		_hornyGrab = thisValue 
		StorageUtil.SetFloatValue(none, "_SLH_fHornyGrab", _hornyGrab)
		SetSliderOptionValueST( thisValue ,"{1}") 
	endEvent

	event OnDefaultST()
		_hornyGrab = 30.0 
		StorageUtil.SetFloatValue(none, "_SLH_fHornyGrab", _hornyGrab)
		SetSliderOptionValueST( _hornyGrab,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sGRAB_TRIGGER_DESC")
	endEvent
endState
; AddToggleOptionST("STATE_BIMBO_DROP","Drop items when aroused", _bimboClumsinessDrop  as Bool)
state STATE_BIMBO_DROP ; TOGGLE
	event OnSelectST()
		GV_bimboClumsinessDrop.SetValueInt( Math.LogicalXor( 1, GV_bimboClumsinessDrop.GetValueInt() ) )
		SetToggleOptionValueST( GV_allowHRT.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_bimboClumsinessDrop.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bBIMBO_DROP_DESC")
	endEvent
endState
; AddToggleOptionST("STATE_SEX_CHANGE","Sex Change Curse", _isHRT)
state STATE_SEX_CHANGE ; TOGGLE
	event OnSelectST()
		GV_allowHRT.SetValueInt( Math.LogicalXor( 1, GV_allowHRT.GetValueInt() ) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowHRT", GV_allowHRT.GetValue() as Int)
		SetToggleOptionValueST( GV_allowHRT.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowHRT.SetValueInt( 0 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowHRT", GV_allowHRT.GetValue() as Int)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bSEX_CHANGE_DESC")
	endEvent
endState
state STATE_SET_SEX_CHANGE ; TOGGLE
	event OnSelectST()
		SetToggleOptionValueST( StorageUtil.GetIntValue(PlayerActor, "_SLH_iHRT") as Bool )

		GV_allowHRT.SetValueInt( 1 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowHRT", GV_allowHRT.GetValue() as Int)

		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iHRT") == 0)
			Debug.MessageBox("Casting the Sex Change curse and forcing curse options if necessary. Leave the menu to view the effects.")
			PlayerActor.SendModEvent("SLHCastHRTCurse")
		else
			Debug.MessageBox("Curing the Sex Change curse. Leave the menu to view the effects.")
			PlayerActor.SendModEvent("SLHCureHRTCurse")
		endIf
		ForcePageReset()
	endEvent

	event OnDefaultST() 
		SetToggleOptionValueST( StorageUtil.GetIntValue(PlayerActor, "_SLH_iHRT") as Bool )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bSET_SEX_CHANGE_DESC")
	endEvent
endState
; AddToggleOptionST("STATE_TG","Allow Transgender", _isTG)
state STATE_TG ; TOGGLE
	event OnSelectST()
		GV_allowTG.SetValueInt( Math.LogicalXor( 1, GV_allowTG.GetValueInt() ) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowTG", GV_allowTG.GetValue() as Int)
		SetToggleOptionValueST( GV_allowTG.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowTG.SetValueInt( 0 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowTG", GV_allowTG.GetValue() as Int)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bTG_DESC")
	endEvent
endState
state STATE_SET_TG ; TOGGLE
	event OnSelectST()
		SetToggleOptionValueST( StorageUtil.GetIntValue(PlayerActor, "_SLH_iTG") as Bool )

		GV_allowHRT.SetValueInt( 1 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowHRT", GV_allowHRT.GetValue() as Int)
		GV_allowTG.SetValueInt( 1 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowTG", GV_allowTG.GetValue() as Int)

		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iTG") == 0)
			Debug.MessageBox("Casting the Transgender curse and forcing curse options if necessary. Leave the menu to view the effects.")
			PlayerActor.SendModEvent("SLHCastTGCurse")
		else
			Debug.MessageBox("Curing the Transgender curse. Leave the menu to view the effects.")
			PlayerActor.SendModEvent("SLHCureTGCurse")
		endIf
		ForcePageReset()
	endEvent

	event OnDefaultST() 
		SetToggleOptionValueST( StorageUtil.GetIntValue(PlayerActor, "_SLH_iTG") as Bool )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sSET_TG_DESC")
	endEvent
endState

; AddToggleOptionST("STATE_EXHIBITIONIST","Allow Exhibitionist", _allowExhibitionist)
state STATE_EXHIBITIONIST ; TOGGLE
	event OnSelectST()
		GV_allowExhibitionist.SetValueInt( Math.LogicalXor( 1, GV_allowExhibitionist.GetValueInt() ) )
		SetToggleOptionValueST( GV_allowExhibitionist.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowExhibitionist.SetValueInt( 1 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bEXHIBITIONIST_DESC")
	endEvent
endState


; AddToggleOptionST("STATE_AUTO_REMOVE_WINGS","Clear equiped wings", _autoRemoveDragonWings, OPTION_FLAG_DISABLED)
state STATE_AUTO_REMOVE_WINGS ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(none, "_SLP_autoRemoveWings" )  )  
		_autoRemoveDragonWings = toggle
		StorageUtil.SetIntValue(none, "_SLP_autoRemoveWings", _autoRemoveDragonWings as Int )
		SetToggleOptionValueST( toggle as Bool ) 
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(none, "_SLP_autoRemoveWings", 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Automatically remove equipped wings when removing the Queen Body if a compatible mod is detected (unchecked means the wings will remain equipped after the Queen Body is removed).")
	endEvent
endState

; AddToggleOptionST("STATE_SELF_SPELLS","Allow Self Spells", _allowSelfSpells)
state STATE_SELF_SPELLS ; TOGGLE
	event OnSelectST()
		GV_allowSelfSpells.SetValueInt( Math.LogicalXor( 1, GV_allowSelfSpells.GetValueInt() ) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowSelfSpells", GV_allowTG.GetValue() as Int)
		SetToggleOptionValueST( GV_allowSelfSpells.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowSelfSpells.SetValueInt( 1 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowSelfSpells", GV_allowTG.GetValue() as Int)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bSELF_SPELLS_DESC")
	endEvent
endState
; AddToggleOptionST("STATE_STATUS","Display status", _statusToggle)
state STATE_STATUS ; TOGGLE
	event OnSelectST()
		SLH_Control.showStatus()
	endEvent

	event OnDefaultST()
		; Simple button - no default state
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bSTATUS_DESC")
	endEvent
endState

; AddToggleOptionST("STATE_SHOW_STATUS","Show Status messages", _showStatus as Bool)
state STATE_SHOW_STATUS ; TOGGLE
	event OnSelectST()
		GV_showStatus.SetValueInt( Math.LogicalXor( 1, GV_showStatus.GetValueInt() ) )
		SetToggleOptionValueST( GV_showStatus.GetValueInt() as Bool )
		StorageUtil.SetIntValue(Game.GetPlayer(), "_SLH_iShowStatus", GV_showStatus.GetValueInt() as Int) 
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_showStatus.SetValueInt( 0 )
		StorageUtil.SetIntValue(Game.GetPlayer(), "_SLH_iShowStatus", 0) 
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bSHOW_STATUS_DESC")
	endEvent
endState

; AddSliderOptionST("STATE_COMMENTS_FREQUENCY","NPC Comments Frequency ", _commentsFrequency as Float,"{1}")
state STATE_COMMENTS_FREQUENCY ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_commentsFrequency.GetValue()  )
		SetSliderDialogDefaultValue( 70.0 )  
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 10.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_commentsFrequency.SetValue(thisValue)  
		StorageUtil.SetFloatValue(Game.GetPlayer(), "_SLH_fCommentFrequency", thisValue) 

		SetSliderOptionValueST( thisValue, "{1} %" )
	endEvent

	event OnDefaultST()
		GV_commentsFrequency.SetValue(70.0)
		StorageUtil.SetFloatValue(Game.GetPlayer(), "_SLH_fCommentFrequency", 70) 
		SetSliderOptionValueST( 70.0, "{1} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sCOMMENTS_FREQUENCY_DESC")
	endEvent
endState

; AddToggleOptionST("STATE_CHANGE_OVERRIDE","Shape change override", _changeOverrideToggle)
state STATE_CHANGE_OVERRIDE ; TOGGLE
	event OnSelectST()
		GV_changeOverrideToggle.SetValueInt( Math.LogicalXor( 1, GV_changeOverrideToggle.GetValueInt() ) )
		SetToggleOptionValueST( GV_changeOverrideToggle.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_changeOverrideToggle.SetValueInt( 0 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bCHANGE_OVERRIDE_DESC")
	endEvent

endState

; AddToggleOptionST("STATE_UPDATE_ON_CELL","Update on cell change", _shapeUpdateOnCellChange as Float)
state STATE_UPDATE_ON_CELL ; TOGGLE
	event OnSelectST()
		GV_shapeUpdateOnCellChange.SetValueInt( Math.LogicalXor( 1, GV_shapeUpdateOnCellChange.GetValueInt() ) )
		SetToggleOptionValueST( GV_shapeUpdateOnCellChange.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_shapeUpdateOnCellChange.SetValueInt( 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sUPDATE_ON_CELL_DESC")
	endEvent

endState
; AddToggleOptionST("STATE_UPDATE_ON_SEX","Update after sex", _shapeUpdateAfterSex as Float)
state STATE_UPDATE_ON_SEX ; TOGGLE
	event OnSelectST()
		GV_shapeUpdateAfterSex.SetValueInt( Math.LogicalXor( 1, GV_shapeUpdateAfterSex.GetValueInt() ) )
		SetToggleOptionValueST( GV_shapeUpdateAfterSex.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_shapeUpdateAfterSex.SetValueInt( 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sUPDATE_ON_SEX_DESC")
	endEvent

endState
; AddToggleOptionST("STATE_UPDATE_ON_TIMER","Update on timer", _shapeUpdateOnTimer as Float)
state STATE_UPDATE_ON_TIMER ; TOGGLE
	event OnSelectST()
		GV_shapeUpdateOnTimer.SetValueInt( Math.LogicalXor( 1, GV_shapeUpdateOnTimer.GetValueInt() ) )
		SetToggleOptionValueST( GV_shapeUpdateOnTimer.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_shapeUpdateOnTimer.SetValueInt( 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bUPDATE_ON_TIMER_DESC")
	endEvent

endState
; AddToggleOptionST("STATE_ENABLE_NODE_UPDATE","Enable node updates", _enableNiNodeUpdate as Float)
state STATE_ENABLE_NODE_UPDATE ; TOGGLE
	event OnSelectST()
		; NiOverride and QueueNodeUpdates are mutually exclusive
		_enableNiNodeUpdate  = StorageUtil.GetIntValue(none, "_SLH_NiNodeUpdateON")
		_enableNiNodeUpdate  = Math.LogicalXor( 1, _enableNiNodeUpdate  as Int ) 

		StorageUtil.SetIntValue(none, "_SLH_NiNodeUpdateON", _enableNiNodeUpdate as Int)

		SetToggleOptionValueST( _enableNiNodeUpdate as Bool )
		refreshStorageFromGlobals()
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(none, "_SLH_NiNodeUpdateON", 1)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sENABLE_NODE_UPDATE_DESC")
	endEvent

endState

; AddToggleOptionST("STATE_ENABLE_BASIC_NETIMMERSE","Enable Basic NetImmerse", _enableBasicNetImmerse as Float)
state STATE_ENABLE_BASIC_NETIMMERSE ; TOGGLE
	event OnSelectST()
		; NiOverride and QueueNodeUpdates are mutually exclusive
		_enableBasicNetImmerse  = StorageUtil.GetIntValue(none, "_SLH_BasicNetImmerseON")
		_enableBasicNetImmerse  = Math.LogicalXor( 1, _enableBasicNetImmerse  as Int ) 

		StorageUtil.SetIntValue(none, "_SLH_BasicNetImmerseON", _enableBasicNetImmerse as Int)

		SetToggleOptionValueST( _enableBasicNetImmerse as Bool )
		refreshStorageFromGlobals()
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(none, "_SLH_BasicNetImmerseON", 1)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_ENABLE_BASIC_NETIMMERSE_DESC")
	endEvent

endState

; AddToggleOptionST("STATE_ENABLE_NODE_OVERRIDE","Enable node override", _enableNiNodeOverride as Float)
state STATE_ENABLE_NODE_OVERRIDE ; TOGGLE
	event OnSelectST()
		; NiOverride and BodyMorphs are mutually exclusive
		_enableNiNodeOverride = StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")
		_enableNiNodeOverride = Math.LogicalXor( 1, _enableNiNodeOverride as Int ) 
		StorageUtil.SetIntValue(none, "_SLH_NiNodeOverrideON", _enableNiNodeOverride as Int)

		SetToggleOptionValueST( _enableNiNodeOverride as Bool )
		refreshStorageFromGlobals()
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(none, "_SLH_NiNodeOverrideON", 1)
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bENABLE_NODE_OVERRIDE_DESC")
	endEvent

endState

; AddToggleOptionST("STATE_SLIF_NODE_OVERRIDE","Enable SLIF override", _enableSLIFOverride as Float)
state STATE_ENABLE_SLIF_OVERRIDE ; TOGGLE
	event OnSelectST()
		; NiOverride and BodyMorphs are mutually exclusive
		_enableSLIFOverride = StorageUtil.GetIntValue(none, "_SLH_SLIFOverrideON")
		_enableSLIFOverride = Math.LogicalXor( 1, _enableSLIFOverride as Int ) 
		StorageUtil.SetIntValue(none, "_SLH_SLIFOverrideON", _enableSLIFOverride as Int)

		SetToggleOptionValueST( _enableSLIFOverride as Bool )
		refreshStorageFromGlobals()
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(none, "_SLH_SLIFOverrideON", 1)
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bENABLE_SLIF_OVERRIDE_DESC")
	endEvent

endState

; AddToggleOptionST("STATE_ENABLE_BODYMORPHS","Enable BodyMorphs", StorageUtil.GetIntValue(none, "_SLH_BodyMorphsON") as Float)
state STATE_ENABLE_BODYMORPHS ; TOGGLE
	event OnSelectST() 
		; NiOverride and BodyMorphs are mutually exclusive
		_enableBodyMorphs  = StorageUtil.GetIntValue(none, "_SLH_BodyMorphsON")
		_enableBodyMorphs  = Math.LogicalXor( 1, _enableBodyMorphs  as Int ) 
		StorageUtil.SetIntValue(none, "_SLH_BodyMorphsON", _enableBodyMorphs  as Int)

		SetToggleOptionValueST( _enableBodyMorphs  as Bool )
		refreshStorageFromGlobals()
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(none, "_SLH_BodyMorphsON", 1)
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_ENABLE_BODYMORPHS_DESC")
	endEvent

endState


; AddToggleOptionST("STATE_SETSHAPE","Reset changes", _resetToggle)
state STATE_SETSHAPE ; TOGGLE
	event OnSelectST()
		; SLH_Control._resetHormonesState()
		; refreshStorageFromGlobals()
		PlayerActor.SendModEvent("SLHSetShape")

		Debug.MessageBox("Shape initialized - Exit the menu and wait a few seconds")
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bSETSHAPE_DESC")
	endEvent

endState

; AddToggleOptionST("STATE_DEBUG","Debug messages", _showDebug)
state STATE_DEBUG ; TOGGLE
	event OnSelectST()
		Int _showDebugInt = ( Math.LogicalXor( 1, _showDebug as Int ) )
		_showDebug = _showDebugInt as Bool
		StorageUtil.SetIntValue(none, "_SLH_debugTraceON", _showDebugInt)
		SetToggleOptionValueST( _showDebugInt )
		refreshStorageFromGlobals()
		ForcePageReset()
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bDEBUG_DESC")
	endEvent

endState


; AddToggleOptionST("STATE_RESET","Reset changes", _resetToggle)
state STATE_RESET ; TOGGLE
	event OnSelectST()
		; SLH_Control._resetHormonesState()
		PlayerActor.SendModEvent("SLHResetShape")

		Debug.MessageBox("Shape reset - Exit the menu and wait a few seconds")
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_bRESET_DESC")
	endEvent

endState


; AddToggleOptionST("STATE_BALANCE","Reset changes", _applyNodeBalancing  )
state STATE_BALANCE ; TOGGLE
	event OnSelectST()
		_applyNodeBalancing = Math.LogicalXor( 1, _applyNodeBalancing )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iNodeBalancing", _applyNodeBalancing)
		SLH_Control._nodeBalancing()
		ForcePageReset()
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("$SLH_sBALANCE_DESC")
	endEvent

endState


float function fMin(float  a, float b)
	if (a<=b)
		return a
	else
		return b
	EndIf
EndFunction

float function fMax(float a, float b)
	if (a<=b)
		return b
	else
		return a
	EndIf
EndFunction

Function refreshStorageFromGlobals()
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreastSwellMod",  GV_breastSwellMod.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButtSwellMod",  GV_buttSwellMod.GetValue() as Float)  
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBellySwellMod",  GV_bellySwellMod.GetValue() as Float)  
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSchlongSwellMod",  GV_schlongSwellMod.GetValue() as Float)  
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeightSwellMod",  GV_weightSwellMod.GetValue() as Float)  

	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreastMax",  GV_breastMax.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButtMax",  GV_buttMax.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBellyMax",  GV_bellyMax.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSchlongMax",  GV_schlongMax.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeightMax",  GV_weightMax.GetValue() as Float) 

	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreastMin",  GV_breastMin.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButtMin",  GV_buttMin.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBellyMin",  GV_bellyMin.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSchlongMin",  GV_schlongMin.GetValue() as Float) 

	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast",  GV_breastValue.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButt",  GV_buttValue.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBelly",  GV_bellyValue.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSchlong",  GV_schlongValue.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight",  GV_weightValue.GetValue() as Float) 

	PlayerActor.SendModEvent("SLHRefresh")

EndFunction

int Function HexToInt(string HexVal)  ; converts a 6 digit ascii hex string to integer; returns -1 in case of error
	int count=0
	int sum=0
	int DigitVal
	int SingleVal
	while (count<=5)
		DigitVal = StringUtil.AsOrd(StringUtil.GetNthChar(Hexval,count))
		if DigitVal>= 97
			DigitVal -= 32  ; switch to capitals
		endif
		if (DigitVal>=65) && (DigitVal<=70) ; A..F
			SingleVal = DigitVal - 55
		elseif (DigitVal>=48) && (DigitVal<=57) ; 0..9
			SingleVal = DigitVal - 48
		else		
			return -1
		endif
		sum = SingleVal+16*sum
		count += 1
	endwhile
	return sum
endFunction

String function IntToHex (int dec)
	String hex = ""
	int rest = dec
	while (rest > 0)
		int m16 = rest % 16
		rest = rest / 16
		String temp = ""
		if (m16 == 1)
			temp = "1"
		elseif (m16 == 2)
			temp = "2"
		elseif (m16 == 3)
			temp = "3"
		elseif (m16 == 4)
			temp = "4"
		elseif (m16 == 5)
			temp = "5"
		elseif (m16 == 6)
			temp = "6"
		elseif (m16 == 7)
			temp = "7"
		elseif (m16 == 8)
			temp = "8"
		elseif (m16 == 9)
			temp = "9"
		elseif (m16 == 10)
			temp = "A"
		elseif (m16 == 11)
			temp = "B"
		elseif (m16 == 12)
			temp = "C"
		elseif (m16 == 13)
			temp = "D"
		elseif (m16 == 14)
			temp = "E"
		elseif (m16 == 15)
			temp = "F"
		else
			temp = "0"
		endif
		hex = temp + hex
	endWhile
	return hex
endFunction


int Function GetCurrentHourOfDay() 
 
	Float fCurrentHourOfDay = Utility.GetCurrentGameTime()
	fCurrentHourOfDay -= Math.Floor(fCurrentHourOfDay) ; Remove "previous in-game days passed" bit
	fCurrentHourOfDay *= 24 ; Convert from fraction of a day to number of hours
	Return fCurrentHourOfDay as Int
 
EndFunction

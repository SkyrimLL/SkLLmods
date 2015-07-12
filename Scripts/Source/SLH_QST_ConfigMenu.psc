scriptname SLH_QST_ConfigMenu extends SKI_ConfigBase

; SCRIPT VERSION ----------------------------------------------------------------------------------
;
; NOTE:
; This is an example to show you how to update scripts after they have been deployed.
;
; History
;
; 1 - Initial version
; 2 - Added color option
; 3 - Added keymap option

int function GetVersion()
	return 3 ; Default version
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
GlobalVariable      Property GV_sexActivityThreshold 	Auto
GlobalVariable      Property GV_sexActivityBuffer		Auto
GlobalVariable      Property GV_baseSwellFactor 		Auto
GlobalVariable      Property GV_baseShrinkFactor 		Auto

GlobalVariable      Property GV_useNodes 				Auto
GlobalVariable      Property GV_useBreastNode 			Auto
GlobalVariable      Property GV_useButtNode 			Auto
GlobalVariable      Property GV_useBellyNode 			Auto
GlobalVariable      Property GV_useSchlongNode 			Auto

GlobalVariable      Property GV_useWeight 				Auto
GlobalVariable      Property GV_useColors 				Auto
GlobalVariable      Property GV_redShiftColor  			Auto
GlobalVariable      Property GV_redShiftColorMod 		Auto
GlobalVariable      Property GV_blueShiftColor 			Auto
GlobalVariable      Property GV_blueShiftColorMod 		Auto

GlobalVariable      Property GV_allowTG 				Auto
GlobalVariable      Property GV_allowHRT 				Auto
GlobalVariable      Property GV_allowBimbo 		 		Auto
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

GlobalVariable      Property GV_allowExhibitionist		Auto
GlobalVariable      Property GV_allowSelfSpells			Auto
GlobalVariable      Property GV_bimboClumsinessMod      Auto


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
float 		_bimboClumsinessMod		= 1.0; 0.1  

float 		_breastMax      		= 4.0
float 		_bellyMax       		= 8.0
float 		_buttMax       			= 4.0
float 		_schlongMax       		= 4.0

bool		_useNodes				= true
bool		_useBreastNode			= true
bool		_useButtNode			= true
bool		_useBellyNode			= true
bool		_useSchlongNode			= true
bool		_useWeight				= true
bool		_useColors				= true
bool		_changeOverrideToggle	= true
bool		_shapeUpdateOnCellChange = true
bool		_shapeUpdateAfterSex 	= true
bool		_shapeUpdateOnTimer 	= true
bool		_enableNiNodeUpdate 	= true
int			_redShiftColor 			= 0
float		_redShiftColorMod 		= 1.0
int			_blueShiftColor 		= 0
float		_blueShiftColorMod 		= 1.0

bool		_allowExhibitionist		= false
bool		_allowSelfSpells		= false

bool		_allowTG				= false
bool		_allowHRT				= false
bool		_allowBimbo				= false
bool		_allowSuccubus				= false

bool		_statusToggle			= false
bool		_setshapeToggle			= false
bool		_resetToggle			= false

bool		_showStatus 			= true
float		_commentsFrequency 		= 80.0

float 		_weightSetValue 		= 100.0
float 		_breastSetValue 		= 1.0
float 		_bellySetValue 			= 1.0
float 		_buttSetValue 			= 1.0
float 		_schlongSetValue		= 1.0

bool 		_refreshToggle 			= false

ObjectReference PlayerREF
Actor PlayerActor
ActorBase pActorBase 

; INITIALIZATION ----------------------------------------------------------------------------------

; @overrides SKI_ConfigBase
event OnConfigInit()
	Pages = new string[2]
	Pages[0] = "Customization"
	Pages[1] = "Add-ons"

endEvent

; @implements SKI_QuestBase
event OnVersionUpdate(int a_version)
	{Called when a version update of this script has been detected}

	; Version 2 specific updating code
	if (a_version >= 2 && CurrentVersion < 2)
	;	Debug.Trace(self + ": Updating script to version 2")
	;	_color = Utility.RandomInt(0x000000, 0xFFFFFF) ; Set a random color
	endIf

	; Version 3 specific updating code
	if (a_version >= 3 && CurrentVersion < 3)
	;	Debug.Trace(self + ": Updating script to version 3")
	;	_myKey = Input.GetMappedKey("Jump")
	endIf
endEvent


; EVENTS ------------------------------------------------------------------------------------------

; @implements SKI_ConfigBase
event OnPageReset(string a_page)
	{Called when a new page is selected, including the initial empty page}

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

	_startingLibido = GV_startingLibido.GetValue() as Int
	_sexActivityThreshold = GV_sexActivityThreshold.GetValue() as Int
	_sexActivityBuffer = GV_sexActivityBuffer.GetValue() as Int
	_baseSwellFactor = GV_baseSwellFactor.GetValue() as Float
	_baseShrinkFactor = GV_baseShrinkFactor.GetValue() as Float

	_breastSwellMod = GV_breastSwellMod.GetValue()   as Float
	_bellySwellMod = GV_bellySwellMod.GetValue()   as Float 
	_schlongSwellMod = GV_schlongSwellMod.GetValue()   as Float 
	_buttSwellMod = GV_buttSwellMod.GetValue()   as Float
	_weightSwellMod = GV_weightSwellMod.GetValue()    as Float    

	_armorMod = GV_armorMod.GetValue()    as Float  
	_clothMod = GV_clothMod.GetValue()    as Float   
	_bimboClumsinessMod = GV_bimboClumsinessMod.GetValue()    as Float   

	_breastMax = GV_breastMax.GetValue()  as Float
	_bellyMax = GV_bellyMax.GetValue()  as Float 
	_schlongMax = GV_schlongMax.GetValue()  as Float 
	_buttMax = GV_buttMax.GetValue()  as Float 

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
	_useColors = GV_useColors.GetValue()  as Int

	_showStatus = GV_showStatus.GetValue() as Bool
	_commentsFrequency = GV_commentsFrequency.GetValue() as Float

	_redShiftColor 			= GV_redShiftColor.GetValue() as Int
	_redShiftColorMod 		= GV_redShiftColorMod.GetValue() as Float
	_blueShiftColor 		= GV_blueShiftColor.GetValue() as Int
	_blueShiftColorMod 		= GV_blueShiftColorMod.GetValue() as Float

	_allowExhibitionist = GV_allowExhibitionist.GetValue()  as Int
	_allowSelfSpells = GV_allowSelfSpells.GetValue()  as Int

	_allowTG = GV_allowTG.GetValue()  as Int
	_allowHRT = GV_allowHRT.GetValue()  as Int
	_allowBimbo = GV_allowBimbo.GetValue()  as Int
	_allowSuccubus = GV_allowSuccubus.GetValue()  as Int

	_changeOverrideToggle = GV_changeOverrideToggle.GetValue()  as Int
	_shapeUpdateOnCellChange = GV_shapeUpdateOnCellChange.GetValue()  as Int
	_shapeUpdateAfterSex = GV_shapeUpdateAfterSex.GetValue()  as Int
	_shapeUpdateOnTimer = GV_shapeUpdateOnTimer.GetValue()  as Int
	_enableNiNodeUpdate = GV_enableNiNodeUpdate.GetValue()  as Int

	_setshapeToggle = GV_setshapeToggle.GetValue()  as Int
	_resetToggle = GV_resetToggle.GetValue()  as Int

	PlayerREF= PlayerAlias.GetReference()
	PlayerActor= PlayerAlias.GetReference() as Actor
	pActorBase = PlayerActor.GetActorBase()

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

	If (a_page == "Customization")
		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption(" Changes customization")
		AddSliderOptionST("STATE_LIBIDO","Starting libido", _startingLibido as Float) 
		AddSliderOptionST("STATE_SEX_TRIGGER","High Sex Activity trigger", _sexActivityThreshold as Float)		
		AddSliderOptionST("STATE_SEX_BUFFER","Low Sex Activity buffer", _sexActivityBuffer as Float)

		AddHeaderOption(" Weight")
		AddToggleOptionST("STATE_CHANGE_WEIGHT","Change Weight scale", _useWeight as Float)
		AddSliderOptionST("STATE_WEIGHT_SWELL","Weight swell mod", _weightSwellMod as Float,"{1}")

		AddHeaderOption(" Color")
		AddToggleOptionST("STATE_CHANGE_COLOR","Change colors", _useColors as Float)

		AddColorOptionST("STATE_RED_COLOR_SHIFT","Red color shift", _redShiftColor as Int)
		AddSliderOptionST("STATE_RED_COLOR_SHIFT_MOD","Red color shift mod", _redShiftColorMod as Float,"{1}")

		AddColorOptionST("STATE_BLUE_COLOR_SHIFT","Blue color shift", _blueShiftColor as Int)
		AddSliderOptionST("STATE_BLUE_COLOR_SHIFT_MOD","Blue color shift mod", _blueShiftColorMod as Float,"{1}")

		SetCursorPosition(1)
		AddHeaderOption(" NetImmerse Nodes")
		AddToggleOptionST("STATE_CHANGE_NODES","Change NetImmerse Nodes", _useNodes as Float)
		AddSliderOptionST("STATE_SWELL_FACTOR","Base swell factor", _baseSwellFactor as Float,"{0} %")
		AddSliderOptionST("STATE_SHRINK_FACTOR","Base shrink factor", _baseShrinkFactor as Float,"{0} %")

		AddSliderOptionST("STATE_ARMOR_MOD","Armor shrink", _armorMod as Float,"{1}")
		AddSliderOptionST("STATE_CLOTH_MOD","Cloth shrink", _clothMod as Float,"{1}")

		If (bBreastEnabled)
			AddToggleOptionST("STATE_CHANGE_BREAST_NODE","Change Breast Node", _useBreastNode as Float)	
			AddSliderOptionST("STATE_BREAST_SWELL","Breast swell modifier", _breastSwellMod as Float,"{1}")
			AddSliderOptionST("STATE_BREAST_MAX","Breast swell max", _breastMax as Float,"{1}")
		else
			AddToggleOptionST("STATE_CHANGE_BREAST_NODE","Change Breast Node", _useBreastNode as Float, OPTION_FLAG_DISABLED)	
			AddSliderOptionST("STATE_BREAST_SWELL","Breast swell modifier", _breastSwellMod as Float,"{1}", OPTION_FLAG_DISABLED)
			AddSliderOptionST("STATE_BREAST_MAX","Breast swell max", _breastMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf

		If (bBellyEnabled)
			AddToggleOptionST("STATE_CHANGE_BELLY_NODE","Change Belly Node", _useBellyNode as Float)	
			AddSliderOptionST("STATE_BELLY_SWELL","Belly swell modifier", _bellySwellMod as Float,"{1}")
			AddSliderOptionST("STATE_BELLY_MAX","Belly swell max", _bellyMax as Float,"{1}")
		else
			AddToggleOptionST("STATE_CHANGE_BELLY_NODE","Change Belly Node", _useBellyNode as Float, OPTION_FLAG_DISABLED)	
			AddSliderOptionST("STATE_BELLY_SWELL","Belly swell modifier", _bellySwellMod as Float,"{1}", OPTION_FLAG_DISABLED)
			AddSliderOptionST("STATE_BELLY_MAX","Belly swell max", _bellyMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf

		If (bButtEnabled)
			AddToggleOptionST("STATE_CHANGE_BUTT_NODE","Change Butt Node", _useButtNode as Float)		
			AddSliderOptionST("STATE_BUTT_SWELL","Butt swell modifier", _buttSwellMod as Float,"{1}")
			AddSliderOptionST("STATE_BUTT_MAX","Butt swell max", _buttMax as Float,"{1}")
		else
			AddToggleOptionST("STATE_CHANGE_BUTT_NODE","Change Butt Node", _useButtNode as Float, OPTION_FLAG_DISABLED)		
			AddSliderOptionST("STATE_BUTT_SWELL","Butt swell modifier", _buttSwellMod as Float,"{1}", OPTION_FLAG_DISABLED)
			AddSliderOptionST("STATE_BUTT_MAX","Butt swell max", _buttMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf

		If (bSchlongEnabled)
			AddToggleOptionST("STATE_CHANGE_SCHLONG_NODE","Change Schlong Node", _useSchlongNode as Float)
			AddSliderOptionST("STATE_SCHLONG_SWELL","Schlong swell modifier", _schlongSwellMod as Float,"{1}")
			AddSliderOptionST("STATE_SCHLONG_MAX","Schlong swell max", _schlongMax as Float,"{1}")
		else
			AddToggleOptionST("STATE_CHANGE_SCHLONG_NODE","Change Schlong Node", _useSchlongNode as Float, OPTION_FLAG_DISABLED)
			AddSliderOptionST("STATE_SCHLONG_SWELL","Schlong swell modifier", _schlongSwellMod as Float,"{1}", OPTION_FLAG_DISABLED)
			AddSliderOptionST("STATE_SCHLONG_MAX","Schlong swell max", _schlongMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf




	elseIf (a_page == "Add-ons")
		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption(" Optional modules")
		AddToggleOptionST("STATE_SUCCUBUS","Succubus Curse", _allowSuccubus as Float)
		AddToggleOptionST("STATE_SEX_CHANGE","Sex Change Curse", _allowHRT as Float)
		AddToggleOptionST("STATE_TG","Allow Transgender", _allowTG as Float)
		AddToggleOptionST("STATE_BIMBO","Bimbo Curse", _allowBimbo as Float)
		AddSliderOptionST("STATE_BIMBO_CLUMSINESS","Clumsiness factor", _bimboClumsinessMod as Float,"{1}")

		AddHeaderOption(" Shape refresh controls")
		AddToggleOptionST("STATE_CHANGE_OVERRIDE","Shape change override", _changeOverrideToggle as Float)
		AddToggleOptionST("STATE_UPDATE_ON_CELL","Update on cell change", _shapeUpdateOnCellChange as Float)
		AddToggleOptionST("STATE_UPDATE_ON_SEX","Update after sex", _shapeUpdateAfterSex as Float)
		AddToggleOptionST("STATE_UPDATE_ON_TIMER","Update on timer", _shapeUpdateOnTimer as Float)
		AddToggleOptionST("STATE_ENABLE_NODE_UPDATE","Enable node updates", _enableNiNodeUpdate as Float)

		AddEmptyOption()
		AddToggleOptionST("STATE_SHOW_STATUS","Show Status messages", _showStatus as Bool)
		AddSliderOptionST("STATE_COMMENTS_FREQUENCY","NPC Comments Frequency ", _commentsFrequency as Float,"{1} %")
		AddToggleOptionST("STATE_EXHIBITIONIST","Allow Exhibitionist", _allowExhibitionist as Float)
		AddToggleOptionST("STATE_SELF_SPELLS","Allow Self Spells", _allowSelfSpells as Float)

		SetCursorPosition(1)
		AddHeaderOption(" Status")
		AddToggleOptionST("STATE_STATUS","Display current status", _statusToggle as Float)

		AddHeaderOption(" Change shape values")
		AddSliderOptionST("STATE_WEIGHT_VALUE","Weight ", _weightSetValue as Float,"{1}")
		AddSliderOptionST("STATE_BREAST_VALUE","Breast", _breastSetValue as Float,"{1}")
		AddSliderOptionST("STATE_BELLY_VALUE","Belly", _bellySetValue as Float,"{1}")
		AddSliderOptionST("STATE_BUTT_VALUE","Butt", _buttSetValue as Float,"{1}")
		AddSliderOptionST("STATE_SCHLONG_VALUE","Schlong", _schlongSetValue as Float,"{1}")

		AddEmptyOption()
		AddToggleOptionST("STATE_REFRESH","Apply changes", _refreshToggle as Float)

		AddEmptyOption()
		AddToggleOptionST("STATE_SETSHAPE","Set default shape", _setshapeToggle as Float)
		AddToggleOptionST("STATE_RESET","Reset changes", _resetToggle as Float)
	endIf
endEvent

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
		SetInfoText("Starting libido - controls initial sex drive of your character.")
	endEvent
endState
; AddSliderOptionST("STATE_SEX_TRIGGER","High Sex Activity trigger", _sexActivityThreshold)
state STATE_SEX_TRIGGER ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_sexActivityThreshold.GetValueInt() )
		SetSliderDialogDefaultValue( 2 )
		SetSliderDialogRange( 2, 10 )
		SetSliderDialogInterval( 1 )
	endEvent

	event OnSliderAcceptST(float value)
		int thisValue = value as int
		GV_sexActivityThreshold.SetValueInt( thisValue )
		SetSliderOptionValueST( thisValue )
	endEvent

	event OnDefaultST()
		GV_sexActivityThreshold.SetValueInt( 2 )
		SetSliderOptionValueST( 2 )
	endEvent

	event OnHighlightST()
		SetInfoText("Number of sex acts required in a day to increase body changes.")
	endEvent
endState
; AddSliderOptionST("STATE_SEX_BUFFER","High Sex Activity buffer", _sexActivityBuffer)
state STATE_SEX_BUFFER ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_sexActivityBuffer.GetValueInt() )
		SetSliderDialogDefaultValue( 7 )
		SetSliderDialogRange( 1, 10 )
		SetSliderDialogInterval( 1 )
	endEvent

	event OnSliderAcceptST(float value)
		int thisValue = value as int
		GV_sexActivityBuffer.SetValueInt( thisValue )
		SetSliderOptionValueST( thisValue )
	endEvent

	event OnDefaultST()
		GV_sexActivityBuffer.SetValueInt( 7 )
		SetSliderOptionValueST( 7 )
	endEvent

	event OnHighlightST()
		SetInfoText("Number of days without sex before body changes decrease.")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_NODES","Change NetImmerse Nodes", _useNodes)
state STATE_CHANGE_NODES ; TOGGLE
	event OnSelectST()
		GV_useNodes.SetValueInt( Math.LogicalXor( 1, GV_useNodes.GetValueInt() ) )
		SetToggleOptionValueST( GV_useNodes.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useNodes.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allows changes to NetImmerse Nodes")
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
		SetInfoText("Allows Hormones to change breast nodes.")
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
		SetInfoText("Allows Hormones to change butt nodes.")
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
		SetInfoText("Allows Hormones to change belly nodes.")
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
		SetInfoText("Allows Hormones to change schlong nodes.")
	endEvent
endState

; AddSliderOptionST("STATE_SWELL_FACTOR","Base swell factor", _baseSwellFactor)
state STATE_SWELL_FACTOR ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_baseSwellFactor.GetValue() )
		SetSliderDialogDefaultValue( 10.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_baseSwellFactor.SetValue( thisValue  )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		GV_baseSwellFactor.SetValue( 10.0 )
		SetSliderOptionValueST( 10.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Base swell factor - Rate of growth applied to breasts, belly and butt (in % of current shape value).")
	endEvent
endState
; AddSliderOptionST("STATE_SHRINK_FACTOR","Base shrink factor", _baseShrinkFactor)
state STATE_SHRINK_FACTOR ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_baseShrinkFactor.GetValue() )
		SetSliderDialogDefaultValue( 5.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_baseShrinkFactor.SetValue( thisValue )
		SetSliderOptionValueST( thisValue ,"{0} %")
	endEvent

	event OnDefaultST()
		GV_baseShrinkFactor.SetValue( 5.0 )
		SetSliderOptionValueST( 5.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Base shrink factor - Rate of reduction applied to breasts, belly and butt (in % of current shape value).")
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
		SetInfoText("Armor shrink factor - Amount of change applied when wearing an armor. Disabled when other mods are taking over shape updates (like pregnancy mods).")
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
		SetInfoText("Armor shrink factor - Amount of change applied when wearing cloth. Disabled when other mods are taking over shape updates (like pregnancy mods).")
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
		SetInfoText("Breast swell modifier - Amount of base change applied to breasts (1 being the full amount).")
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
		SetInfoText("Maximum breast size multiplier allowed")
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
		SetInfoText("Belly swell modifier - Amount of base change applied to belly (1 being the full amount).")
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
		SetInfoText("Maximum belly size multiplier allowed")
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
		SetInfoText("Butt swell modifier - Amount of base change applied to butt (1 being the full amount).")
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
		SetInfoText("Maximum butt size multiplier allowed")
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
		SetInfoText("Schlong swell modifier - Amount of base change applied to schlong size (1 being the full amount).")
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
		SetInfoText("Maximum schlong size multiplier allowed")
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
		SetInfoText("Allow changes to Weight scale")
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
		SetInfoText("Weight swell modifier - Amount of base change applied to weight (1 being the full amount)")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_COLOR","Change colors", _useColors)
state STATE_CHANGE_COLOR ; TOGGLE
	event OnSelectST()
		GV_useColors.SetValueInt( Math.LogicalXor( 1, GV_useColors.GetValueInt() ) )
		SetToggleOptionValueST( GV_useColors.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useColors.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allow change to colors (skin, lips and eyeliner)")
	endEvent
endState

; AddColorOptionST("STATE_RED_COLOR_SHIFT","Red color shift", _redShiftColor as Int)
state STATE_RED_COLOR_SHIFT ; COLOR
	event OnColorOpenST()
		SetColorDialogStartColor( GV_redShiftColor.GetValue() as Int  )
		SetColorDialogDefaultColor( GV_redShiftColor.GetValue() as Int ) ; Get starting weight as global variable
	endEvent

	event OnColorAcceptST(int value)
		Int thisValue = value  
		GV_redShiftColor.SetValue( thisValue)   
		SetColorOptionValueST( thisValue )
	endEvent

	event OnDefaultST()
		GV_redShiftColor.SetValue( 32 )
		SetColorOptionValueST( 32 )
	endEvent

	event OnHighlightST()
		SetInfoText("Red shift color - Color for 'red' shift from current color (blushing after sex)")
	endEvent
endState
; AddSliderOptionST("STATE_RED_COLOR_SHIFT_MOD","Red color shift mod", _redShiftColorMod as Float,"{1}")
state STATE_RED_COLOR_SHIFT_MOD ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_redShiftColorMod.GetValue()  )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 1.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_redShiftColorMod.SetValue( thisValue)   
		SetSliderOptionValueST( thisValue, "{1}" )
	endEvent

	event OnDefaultST()
		GV_redShiftColorMod.SetValue( 1.0 )
		SetSliderOptionValueST( 1.0 , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Red shift color modifier - Amount of base change applied to shift to red color from current color (1 being the full amount)")
	endEvent
endState

; AddColorOptionST("STATE_BLUE_COLOR_SHIFT","Blue color shift", _blueShiftColor as Int)
state STATE_BLUE_COLOR_SHIFT ; COLOR
	event OnColorOpenST()
		SetColorDialogStartColor( GV_blueShiftColor.GetValue()  as Int )
		SetColorDialogDefaultColor( GV_blueShiftColor.GetValue()  as Int) ; Get starting weight as global variable
	endEvent

	event OnColorAcceptST(int value)
		Int thisValue = value 
		GV_blueShiftColor.SetValue( thisValue )   
		SetColorOptionValueST( thisValue )
	endEvent

	event OnDefaultST()
		GV_blueShiftColor.SetValue( 3 )
		SetColorOptionValueST( 3 )
	endEvent

	event OnHighlightST()
		SetInfoText("Blue shift color - Color for 'blue' shift from current color (sex withdrawal)")
	endEvent
endState

; AddSliderOptionST("STATE_BLUE_COLOR_SHIFT_MOD","Blue color shift mod", _blueShiftColorMod as Float,"{1}")
state STATE_BLUE_COLOR_SHIFT_MOD ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_blueShiftColorMod.GetValue()  )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 1.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_blueShiftColorMod.SetValue( thisValue)   
		SetSliderOptionValueST( thisValue, "{1}" )
	endEvent

	event OnDefaultST()
		GV_blueShiftColorMod.SetValue( 1.0 )
		SetSliderOptionValueST( 1.0 , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Blue shift color modifier - Amount of base change applied to shift to blue color from current color (1 being the full amount)")
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
		SetInfoText("Set Weight to this value.")
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
		SetInfoText("Set Breasts nodes to this value.")
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
		SetInfoText("Set Belly nodes to this value.")
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
		SetInfoText("Set Butt nodes to this value.")
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
		SetInfoText("Set Schlong nodes to this value.")
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
		SetInfoText("Apply these values to current Hormones settings.")
	endEvent
endState

; AddToggleOptionST("STATE_SUCCUBUS","Succubus mode", _allowSuccubus)
state STATE_SUCCUBUS ; TOGGLE
	event OnSelectST()
		GV_allowSuccubus.SetValueInt( Math.LogicalXor( 1, GV_allowSuccubus.GetValueInt() ) )
		SetToggleOptionValueST( GV_allowSuccubus.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowSuccubus.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Succubus curse - Caused by exposure to Daedric influence.")
	endEvent
endState
; AddToggleOptionST("STATE_SEX_CHANGE","Sex Change Curse", _allowBimbo)
state STATE_BIMBO ; TOGGLE
	event OnSelectST()
		GV_allowBimbo.SetValueInt( Math.LogicalXor( 1, GV_allowBimbo.GetValueInt() ) )
		SetToggleOptionValueST( GV_allowBimbo.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowBimbo.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Bimbo Curse - This curse could turn you into a mindless sex-starved blonde.")
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
		SetInfoText("Bimbo clunsiness factor - To throttle dropping weapons or stumbling to the ground from 0 (no effect) to 1.0 (default range of clumsiness(")
	endEvent
endState
; AddToggleOptionST("STATE_SEX_CHANGE","Sex Change Curse", _isHRT)
state STATE_SEX_CHANGE ; TOGGLE
	event OnSelectST()
		GV_allowHRT.SetValueInt( Math.LogicalXor( 1, GV_allowHRT.GetValueInt() ) )
		SetToggleOptionValueST( GV_allowHRT.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowHRT.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Sex Change Curse - This curse could turn your gender upside down.")
	endEvent
endState
; AddToggleOptionST("STATE_TG","Allow Transgender", _isTG)
state STATE_TG ; TOGGLE
	event OnSelectST()
		GV_allowTG.SetValueInt( Math.LogicalXor( 1, GV_allowTG.GetValueInt() ) )
		SetToggleOptionValueST( GV_allowTG.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowTG.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allow Transgender - This option enables smoother transitions from male to female, with an intermediate state (female with male genitals).")
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
		SetInfoText("Allow Exhibitionist - High levels of arousal will automatically make your character Exhibitionist in SexLab Arousal.")
	endEvent
endState
; AddToggleOptionST("STATE_SELF_SPELLS","Allow Self Spells", _allowSelfSpells)
state STATE_SELF_SPELLS ; TOGGLE
	event OnSelectST()
		GV_allowSelfSpells.SetValueInt( Math.LogicalXor( 1, GV_allowSelfSpells.GetValueInt() ) )
		SetToggleOptionValueST( GV_allowSelfSpells.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowSelfSpells.SetValueInt( 1 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allow Self Spells - Enable spells for Undress and Masturbation when loading your save game (quit and reload to see the change).")
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
		SetInfoText("Display full status for current hormone changes.")
	endEvent
endState

; AddToggleOptionST("STATE_SHOW_STATUS","Show Status messages", _showStatus as Bool)
state STATE_SHOW_STATUS ; TOGGLE
	event OnSelectST()
		GV_showStatus.SetValueInt( Math.LogicalXor( 1, GV_showStatus.GetValueInt() ) )
		SetToggleOptionValueST( GV_showStatus.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_showStatus.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Show Player Status messages - Display messages about the player's sexual status.")
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

		SetSliderOptionValueST( thisValue, "{1} %" )
	endEvent

	event OnDefaultST()
		GV_commentsFrequency.SetValue(70.0)
		SetSliderOptionValueST( 70.0, "{1} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("NPC Comments Frequency - Percent chance to see NPCs making comments about the Player's libido (sex reputation).")
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
		SetInfoText("Check to let Hormones refresh shape by itself. Unckech if you are using another shape modifying mod with its own refresh schedule (Pregnancy mods for example).")
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
		SetInfoText("Check to apply shape changes when player changes cell.")
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
		SetInfoText("Check to apply shape changes after sex.")
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
		SetInfoText("Check to apply shape changes on a timer (once a day or after sleep).")
	endEvent

endState
; AddToggleOptionST("STATE_ENABLE_NODE_UPDATE","Enable node updates", _enableNiNodeUpdate as Float)
state STATE_ENABLE_NODE_UPDATE ; TOGGLE
	event OnSelectST()
		GV_enableNiNodeUpdate.SetValueInt( Math.LogicalXor( 1, GV_enableNiNodeUpdate.GetValueInt() ) )
		SetToggleOptionValueST( GV_enableNiNodeUpdate.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_enableNiNodeUpdate.SetValueInt( 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Check to let Hormones apply node changes directly. Uncheck if you already have a mod making regular node changes (Bathing/Dirt mod for example).")
	endEvent

endState

; AddToggleOptionST("STATE_RESET","Reset changes", _resetToggle)
state STATE_SETSHAPE ; TOGGLE
	event OnSelectST()
		; SLH_Control._resetHormonesState()
		refreshStorageFromGlobals()

		Debug.MessageBox("Shape initialized - Exit the menu and wait a few seconds")
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("Set shape - records default shape to current values of race, weight, shape and color. Use this option if you change race during the game (vampire or other transformations)")
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
		SetInfoText("Reset changes - Resets character to original weight, shape and color.")
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

	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast",  GV_breastValue.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButt",  GV_buttValue.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBelly",  GV_bellyValue.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSchlong",  GV_schlongValue.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight",  GV_weightValue.GetValue() as Float) 

	PlayerActor.SendModEvent("SLHRefresh")

EndFunction






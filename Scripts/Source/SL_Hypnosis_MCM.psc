Scriptname SL_Hypnosis_MCM extends SKI_ConfigBase

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
	return 1 ; Default version
endFunction


; PRIVATE VARIABLES -------------------------------------------------------------------------------

; --- Version 1 ---

; State


float		_chanceOfDom			= 30.0
float 		_isHRT 					= 0.0

float 		_breastMax      		= 1.0
float 		_buttMax       			= 1.0
float 		_schlongMax       		= 1.0

bool		_useBodyChanges			= true
bool		_useEyesChanges			= false

bool		_statusToggle			= false
bool		_resetToggle			= false


; INITIALIZATION ----------------------------------------------------------------------------------

; @overrides SKI_ConfigBase
event OnConfigInit()
	Pages = new string[1]
	Pages[0] = "Settings"

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
		LoadCustomContent("SexLab_MindControl/logo.dds", 120, 0)
		return
	else
		UnloadCustomContent()
	endIf

	_chanceOfDom			= fMin( fMax( (GV_chanceOfDom.GetValue() as Float) , 0.0), 100.0 )
	_isHRT					= fMin( fMax( (GV_isHRT.GetValue() as Float) , 0.0), 100.0 )

	_useBodyChanges			= GV_useBodyChanges.GetValue() as Int
	_useEyesChanges			= GV_useEyesChanges.GetValue() as Int

	_statusToggle			= GV_statusToggle.GetValue() as Int
	_resetToggle			= GV_resetToggle.GetValue() as Int

	_breastMax = fMin( fMax( GV_breastMax.GetValue()  as Float , 0.0), 4.0 ) 
	_schlongMax = fMin( fMax( GV_schlongMax.GetValue()  as Float , 0.0), 2.5 ) 
	_buttMax = fMin( fMax( GV_buttMax.GetValue()  as Float , 0.0), 4.0 ) 

	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()

	Bool bEnableLeftBreast  = NetImmerse.HasNode(PlayerActor, NINODE_LEFT_BREAST, false)
	Bool bEnableRightBreast = NetImmerse.HasNode(PlayerActor, NINODE_RIGHT_BREAST, false)
	Bool bEnableLeftButt    = NetImmerse.HasNode(PlayerActor, NINODE_LEFT_BUTT, false)
	Bool bEnableRightButt   = NetImmerse.HasNode(PlayerActor, NINODE_RIGHT_BUTT, false)
	Bool bEnableBelly       = NetImmerse.HasNode(PlayerActor, NINODE_BELLY, false)
	Bool bEnableSchlong     = NetImmerse.HasNode(PlayerActor, NINODE_SCHLONG, false)

	Bool bBreastEnabled     = true  ; ( bEnableLeftBreast && bEnableRightBreast as bool )
	Bool bButtEnabled       = true  ; ( bEnableLeftButt && bEnableRightButt  as bool )
	Bool bBellyEnabled      = true  ; ( bEnableBelly  as bool )
	Bool bSchlongEnabled    = true  ; ( bEnableSchlong as bool )

	If (a_page == "Settings")
		SetCursorFillMode(TOP_TO_BOTTOM)
	
		AddHeaderOption(" Side effects")
		AddSliderOptionST("STATE_CHANCEOFDOM","Chance of Dom NPC", _chanceOfDom as Float,"{0} %")
		AddSliderOptionST("STATE_SEX_CHANGE","Sex Change ", _isHRT as Float,"{0} %")

		AddHeaderOption(" Body changes")
		AddToggleOptionST("STATE_CHANGE_NPCBODY","Change victim NPC body", _useBodyChanges as Float)

		If (bBreastEnabled)
			AddSliderOptionST("STATE_BREAST_MAX","Base Breast swell", _breastMax as Float,"{1}")
		else
			AddSliderOptionST("STATE_BREAST_MAX","Base Breast swell", _breastMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf

		If (bButtEnabled)
			AddSliderOptionST("STATE_BUTT_MAX","Base Butt swell", _buttMax as Float,"{1}")
		else
			AddSliderOptionST("STATE_BUTT_MAX","Base Butt swell", _buttMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf

		If (bSchlongEnabled)
			AddSliderOptionST("STATE_SCHLONG_MAX","Base Schlong swell", _schlongMax as Float,"{1}")
		else
			AddSliderOptionST("STATE_SCHLONG_MAX","Base Schlong swell", _schlongMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf

		AddHeaderOption(" Eye Color")
		AddToggleOptionST("STATE_CHANGE_NPCEYES","Change eye color", _useEyesChanges as Float)

		AddEmptyOption()
		AddToggleOptionST("STATE_STATUS","Display status", _statusToggle as Float, OPTION_FLAG_DISABLED)

		AddEmptyOption()
		AddToggleOptionST("STATE_RESET","Reset changes", _resetToggle as Float, OPTION_FLAG_DISABLED)
	endIf
endEvent


; AddSliderOptionST("STATE_CHANCEOFDOM","Chance of Dom NPC", _chanceOfDom as Float,"{0} %")
state STATE_CHANCEOFDOM ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_chanceOfDom.GetValue() )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_chanceOfDom.SetValue( thisValue  )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		GV_chanceOfDom.SetValue( 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of Dom NPC - A side effect of Mind Control is to reveal the true nature of the NPC. Sometimes that nature is Dominant.")
	endEvent
endState
; AddToggleOptionST("STATE_SEX_CHANGE","Sex Change Curse", _isHRT)
state STATE_SEX_CHANGE ; TOGGLE
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_isHRT.GetValue() )
		SetSliderDialogDefaultValue( 0.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_isHRT.SetValue( thisValue  )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		GV_isHRT.SetValue( 0.0 )
		SetSliderOptionValueST( 0.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of Sex change - Another side effect of Mind Control is to alter the gender of the victim. No visual change for Male NPCs. Female NPCs will receive Schlongs if available.")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_NPCEYES","Change eye color", _useEyesChanges as Float)
state STATE_CHANGE_NPCEYES ; TOGGLE
	event OnSelectST()
		GV_useEyesChanges.SetValueInt( Math.LogicalXor( 1, GV_useEyesChanges.GetValueInt() ) )
		SetToggleOptionValueST( GV_useEyesChanges.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useEyesChanges.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allow changes to the victim's eyes.")
	endEvent
endState

; AddToggleOptionST("STATE_CHANGE_NPCBODY","Change victim NPC body", _useBodyChanges as Float)
state STATE_CHANGE_NPCBODY ; TOGGLE
	event OnSelectST()
		GV_useBodyChanges.SetValueInt( Math.LogicalXor( 1, GV_useBodyChanges.GetValueInt() ) )
		SetToggleOptionValueST( GV_useBodyChanges.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useBodyChanges.SetValueInt( 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allow changes to the victim's body.")
	endEvent
endState

; AddSliderOptionST("STATE_BREAST_MAX","Breast swell max", _breastMax)
state STATE_BREAST_MAX ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_breastMax.GetValue() )
		SetSliderDialogDefaultValue( 2.0 )
		SetSliderDialogRange( 1.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_breastMax.SetValue( thisValue )
		SetSliderOptionValueST( thisValue, "{1}" )
	endEvent

	event OnDefaultST()
		GV_breastMax.SetValue( 2.0 )
		SetSliderOptionValueST( 2.0, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Base breast size - actual size will be random plus or minus a percentage around that value.")
	endEvent
endState
; AddSliderOptionST("STATE_BUTT_MAX",("Butt swell max", _buttMax)
state STATE_BUTT_MAX ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_buttMax.GetValue() )
		SetSliderDialogDefaultValue( 2.0 )
		SetSliderDialogRange( 1.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value as float
		GV_buttMax.SetValue( thisValue )
		SetSliderOptionValueST( thisValue, "{1}" )
	endEvent

	event OnDefaultST()
		GV_buttMax.SetValue( 2.0 )
		SetSliderOptionValueST( 2.0, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Base butt size - actual size will be random plus or minus a percentage around that value.")
	endEvent
endState
; AddSliderOptionST("STATE_SCHLONG_MAX","Belly swell max", _bellyMax)
state STATE_SCHLONG_MAX ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_schlongMax.GetValue() )
		SetSliderDialogDefaultValue( 1.2 )
		SetSliderDialogRange( 1.0, 1.5 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value as float
		GV_schlongMax.SetValue( thisValue )
		SetSliderOptionValueST( thisValue, "{1}" )
	endEvent

	event OnDefaultST()
		GV_schlongMax.SetValue( 1.2 )
		SetSliderOptionValueST( 1.2, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Base schlong size - actual size will be random plus or minus a percentage around that value.")
	endEvent
endState


; AddToggleOptionST("STATE_STATUS","Display status", _statusToggle)
state STATE_STATUS ; TOGGLE
	event OnSelectST()
		; SLMC_Control._showStatus()
	endEvent

	event OnDefaultST()
		; Simple button - no default state
	endEvent

	event OnHighlightST()
		SetInfoText("Display full status for current hormone changes.")
	endEvent
endState

; AddToggleOptionST("STATE_RESET","Reset changes", _resetToggle)
state STATE_RESET ; TOGGLE
	event OnSelectST()
		GV_resetToggle.SetValueInt( Math.LogicalXor( 1, GV_resetToggle.GetValueInt() ) )
		SetToggleOptionValueST( GV_resetToggle.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_resetToggle.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
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
;--------------------------------------
ReferenceAlias Property PlayerAlias  Auto  
SL_Hypnosis_functions Property _SLMC_Control Auto

GlobalVariable      Property GV_chanceOfDom 			Auto
GlobalVariable      Property GV_isHRT 					Auto

GlobalVariable      Property GV_breastMax      			Auto
GlobalVariable      Property GV_buttMax       	 		Auto
GlobalVariable      Property GV_schlongMax       	 	Auto

GlobalVariable      Property GV_useBodyChanges	 		Auto
GlobalVariable      Property GV_useEyesChanges	 		Auto

GlobalVariable      Property GV_statusToggle	 		Auto
GlobalVariable      Property GV_resetToggle		 		Auto


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
Scriptname SLP_QST_MCM extends SKI_ConfigBase  



; PRIVATE VARIABLES -------------------------------------------------------------------------------

; --- Version 1 ---

; State


bool		_toggleSpiderEgg
float		_chanceSpiderEgg

; bool		_parasiteWorm
; bool		_parasiteLeech
; bool		_parasiteSpine
; bool		_parasiteHip
; bool		_parasiteTentacle
; bool		_parasiteOoze
; bool		_parasiteSlime
; bool		_parasiteScaled
; bool		_parasiteFuro
; bool		_parasiteEstrus
; bool		_parasiteSpriggan

Actor kPlayer
bool toggle

; INITIALIZATION ----------------------------------------------------------------------------------

; @overrides SKI_ConfigBase
event OnConfigInit()
	Pages = new string[2]
	Pages[0] = "Parasites"
	Pages[1] = "Quests"

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
		LoadCustomContent("KyneBlessing/logo.dds", 120, 0)
		return
	else
		UnloadCustomContent()
	endIf

	kPlayer = Game.GetPlayer()
	; ObjectReference PlayerREF= PlayerAlias.GetReference()
	; Actor PlayerActor= PlayerAlias.GetReference() as Actor
	; ActorBase pActorBase = PlayerActor.GetActorBase()

	If (StorageUtil.GetIntValue(none, "_SLP_initMCM" )!=1)
		StorageUtil.SetIntValue(none, "_SLP_initMCM", 1 )
		
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSpiderEgg", 1 )
		StorageUtil.SetIntValue(kPlayer, "_SLP_chanceSpiderEgg", 100 )
	EndIf

	_toggleSpiderEgg = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSpiderEgg" )
	_chanceSpiderEgg = StorageUtil.GetIntValue(kPlayer, "_SLP_chanceSpiderEgg" )

	; _parasiteWorm
	; _parasiteLeech
	; _parasiteSpine
	; _parasiteHip
	; _parasiteTentacle
	; _parasiteOoze
	; _parasiteSlime
	; _parasiteScaled
	; _parasiteFuro
	; _parasiteEstrus
	; _parasiteSpriggan



	If (a_page == "Parasites")

		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption(" Spider Eggs")
		AddToggleOptionST("STATE_SPIDEREGG_TOGGLE","Spider Egg", _toggleSpiderEgg as Float)
		AddSliderOptionST("STATE_SPIDEREGG_CHANCE","Chance of infection", _chanceSpiderEgg,"{0} %")
		;   
		; AddToggleOptionST("STATE_PARASITE_WORM","Chaurus Worm", _parasiteWorm as Float, OPTION_FLAG_DISABLED)
		;    
		; AddToggleOptionST("STATE_PARASITE_LEECH","Chaurus Leech", _parasiteLeech as Float, OPTION_FLAG_DISABLED)
		;   
		; AddToggleOptionST("STATE_PARASITE_SPINE","Chaurus Spine", _parasiteSpine as Float, OPTION_FLAG_DISABLED)
		;   
		; AddToggleOptionST("STATE_PARASITE_HIP","Hip Hugger", _parasiteHip as Float, OPTION_FLAG_DISABLED)
		;   
		; AddToggleOptionST("STATE_PARASITE_TENTACLE","Tentacle Parasite", _parasiteTentacle as Float, OPTION_FLAG_DISABLED)
		;   
		; AddToggleOptionST("STATE_PARASITE_OOZE","Estrus Ooze", _parasiteOoze as Float, OPTION_FLAG_DISABLED)
		;   
		; AddToggleOptionST("STATE_PARASITE_SLIME","Slimy Living Armor", _parasiteSlime as Float, OPTION_FLAG_DISABLED)
		;   
		; AddToggleOptionST("STATE_PARASITE_SCALE","Scaled Living Armor", _parasiteScaled as Float, OPTION_FLAG_DISABLED)
		;   
		; AddToggleOptionST("STATE_PARASITE_FURO","Furo traps", _parasiteFuro as Float, OPTION_FLAG_DISABLED)
		;   
		; AddToggleOptionST("STATE_PARASITE_ESTRUS","Estrus Chaurus traps", _parasiteEstrus as Float, OPTION_FLAG_DISABLED)
		;   
		; AddToggleOptionST("STATE_PARASITE_SPRIGGAN","Spriggan Roots", _parasiteSpriggan as Float, OPTION_FLAG_DISABLED)

	ElseIf (a_page == "Quests")
		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption(" Placeholder - No option yet")

	endIf
endEvent


; AddToggleOptionST("STATE_SPIDEREGG_TOGGLE","Spider Egg", _toggleSpiderEgg as Float, OPTION_FLAG_DISABLED)
state STATE_SPIDEREGG_TOGGLE ; TOGGLE
	event OnSelectST() 
		toggle = Math.LogicalXor( 1, StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSpiderEgg" )   )
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSpiderEgg", toggle as Int )
		SetToggleOptionValueST( toggle )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSpiderEgg", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Enable/Disable Spider Eggs parasites.")
	endEvent

endState
; AddSliderOptionST("STATE_SPIDEREGG_CHANCE","Chance of infection", _chanceSpiderEgg,"{0} %")
state STATE_SPIDEREGG_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSpiderEgg" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSpiderEgg", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSpiderEgg", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of infection from sex with Spiders")
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
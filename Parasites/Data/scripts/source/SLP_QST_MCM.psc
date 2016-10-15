Scriptname SLP_QST_MCM extends SKI_ConfigBase  



; PRIVATE VARIABLES -------------------------------------------------------------------------------

; --- Version 1 ---

; State

bool _resetToggle

bool		_toggleSpiderEgg = true
float		_chanceSpiderEgg = -1.0
float		_bellyMaxSpiderEgg = 2.0

bool		_toggleSpiderPenis = true
float		_chanceSpiderPenis = -1.0

bool		_toggleChaurusWorm = true
float		_chanceChaurusWorm = -1.0
float		_buttMaxChaurusWorm = 1.0

bool		_toggleEstrusTentacles = true
float		_chanceEstrusTentacles = -1.0

bool		_toggleTentacleMonster = true
float		_chanceTentacleMonster = -1.0
float		_breastMaxTentacleMonster = 2.0

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
	EndIf

 	If (StorageUtil.GetIntValue(none, "_SLP_versionMCM" ) == 0) 
 		_resetParasiteSettings()
 	Endif

	_toggleSpiderEgg = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSpiderEgg" )
	_chanceSpiderEgg = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSpiderEgg" )
	_bellyMaxSpiderEgg = StorageUtil.GetFloatValue(kPlayer, "_SLP_bellyMaxSpiderEgg" )

	_toggleSpiderPenis = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSpiderPenis" )
	_chanceSpiderPenis = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSpiderPenis" )

	_toggleChaurusWorm = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusWorm" )
	_chanceChaurusWorm = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceChaurusWorm" )
	_buttMaxChaurusWorm = StorageUtil.GetFloatValue(kPlayer, "_SLP_buttMaxChaurusWorm" )

	_toggleEstrusTentacles = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleEstrusTentacles" )
	_chanceEstrusTentacles = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceEstrusTentacles" )

	_toggleTentacleMonster = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleTentacleMonster" )
	_chanceTentacleMonster = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceTentacleMonster" )
	_breastMaxTentacleMonster = StorageUtil.GetFloatValue(kPlayer, "_SLP_breastMaxTentacleMonster" )

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

		AddHeaderOption(" Spider Eggs (Vaginal plug)")
		AddSliderOptionST("STATE_SPIDEREGG_CHANCE","Chance of infection", _chanceSpiderEgg,"{0} %")
		AddToggleOptionST("STATE_SPIDEREGG_TOGGLE","Infect/Cure Spider Egg", _toggleSpiderEgg as Float)

		AddHeaderOption(" Spider Penis (Vaginal plug)")
		AddSliderOptionST("STATE_SPIDERPENIS_CHANCE","Chance of infection", _chanceSpiderPenis,"{0} %")
		AddToggleOptionST("STATE_SPIDERPENIS_TOGGLE","Infect/Cure Spider Penis", _toggleSpiderPenis as Float)

		AddHeaderOption(" Chaurus Worm (Anal plug)")
		AddSliderOptionST("STATE_CHAURUSWORM_CHANCE","Chance of infection", _chanceChaurusWorm,"{0} %")
		AddToggleOptionST("STATE_CHAURUSWORM_TOGGLE","Infect/Cure Chaurus Worm", _toggleChaurusWorm as Float)

		AddHeaderOption(" Estrus Tentacles (EC+)")
		AddSliderOptionST("STATE_ESTRUSTENTACLES_CHANCE","Chance of infection", _chanceEstrusTentacles,"{0} %")
		AddToggleOptionST("STATE_ESTRUSTENTACLES_TOGGLE","Infect/Cure Estrus Tentacles", _toggleEstrusTentacles as Float)

		AddHeaderOption(" Tentacle Monster (Harness)")
		AddSliderOptionST("STATE_TENTACLEMONSTER_CHANCE","Chance of infection", _chanceEstrusTentacles,"{0} %")
		AddToggleOptionST("STATE_TENTACLEMONSTER_TOGGLE","Infect/Cure Tentacle Monster", _toggleEstrusTentacles as Float)

		SetCursorPosition(1)
		AddHeaderOption(" NiOverride node scales")
		AddSliderOptionST("STATE_SPIDEREGG_BELLY","Max belly size (Spider egg)", _bellyMaxSpiderEgg,"{1}")
		AddSliderOptionST("STATE_CHAURUSWORM_BUTT","Max butt size (Chaurus worm)", _buttMaxChaurusWorm,"{1}")
		AddSliderOptionST("STATE_TENTACLEMONSTER_BREAST","Max breast size (Tentacle monster)", _breastMaxTentacleMonster,"{1}")

		AddHeaderOption(" ")
		AddToggleOptionST("STATE_RESET","Reset changes", _resetToggle as Float)
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
		toggle = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSpiderEgg" )   
 
		If (toggle ==1)
			kPlayer.SendModEvent("SLPInfectSpiderEgg")
		else
			kPlayer.SendModEvent("SLPCureSpiderEgg")
		Endif

		SetToggleOptionValueST( toggle )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSpiderEgg", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Spider Eggs parasites for roleplay or testing purposes.")
	endEvent

endState
; AddSliderOptionST("STATE_SPIDEREGG_BELLY","Node size", _bellyMaxSpiderEgg,"{0}")
state STATE_SPIDEREGG_BELLY ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_bellyMaxSpiderEgg" ) )
		SetSliderDialogDefaultValue( 2.0 )
		SetSliderDialogRange( 0.0, 6.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxSpiderEgg", thisValue )
		SetSliderOptionValueST( thisValue,"{1}" )
		kPlayer.SendModEvent("SLPRefreshBodyShape")
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxSpiderEgg", 2.0 )
		SetSliderOptionValueST( 2.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Max size of belly node (for NiOverride compatiblity)")
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


; AddToggleOptionST("STATE_SPIDERPENIS_TOGGLE","Spider Penis", _toggleSpiderPenis as Float, OPTION_FLAG_DISABLED)
state STATE_SPIDERPENIS_TOGGLE ; TOGGLE
	event OnSelectST() 
		toggle =  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSpiderPenis" )    

		If (toggle ==1)
			kPlayer.SendModEvent("SLPInfectSpiderPenis")
		else
			kPlayer.SendModEvent("SLPCureSpiderPenis")
		Endif

		SetToggleOptionValueST( toggle )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSpiderPenis", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure detached Spider Penis for roleplay or testing purposes.")
	endEvent

endState
; AddSliderOptionST("STATE_SPIDERPENIS_CHANCE","Chance of infection", _chanceSpiderEgg,"{0} %")
state STATE_SPIDERPENIS_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSpiderPenis" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSpiderPenis", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSpiderPenis", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of a detached penis from sex with Spiders")
	endEvent
endState

; AddToggleOptionST("STATE_CHAURUSWORM_TOGGLE","Chaurus Worm", _toggleChaurusWorm as Float, OPTION_FLAG_DISABLED)
state STATE_CHAURUSWORM_TOGGLE ; TOGGLE
	event OnSelectST() 
		toggle = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusWorm" )   
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusWorm", toggle as Int )

		If (toggle ==1)
			kPlayer.SendModEvent("SLPInfectChaurusWorm")
		else
			kPlayer.SendModEvent("SLPCureChaurusWorm")
		Endif

		SetToggleOptionValueST( toggle )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusWorm", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure detached Chaurus Worm for roleplay or testing purposes.")
	endEvent

endState
; AddSliderOptionST("STATE_CHAURUSWORM_BUTT","Node size", _buttMaxChaurusWorm,"{0}")
state STATE_CHAURUSWORM_BUTT ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_buttMaxChaurusWorm" ) )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( 0.0, 3.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_buttMaxChaurusWorm", thisValue )
		SetSliderOptionValueST( thisValue,"{1}" )
		kPlayer.SendModEvent("SLPRefreshBodyShape")
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_buttMaxChaurusWorm", 1.0 )
		SetSliderOptionValueST( 1.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Max size of butt node (for NiOverride compatiblity)")
	endEvent
endState
; AddSliderOptionST("STATE_CHAURUSWORM_CHANCE","Chance of infection", _chanceSpiderEgg,"{0} %")
state STATE_CHAURUSWORM_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceChaurusWorm" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusWorm", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusWorm", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of a chaurus worm from sex with Chaurus")
	endEvent
endState


; AddToggleOptionST("STATE_ESTRUSTENTACLES_TOGGLE","Estrus Tentacles", _toggleEstrusTentacles as Float, OPTION_FLAG_DISABLED)
state STATE_ESTRUSTENTACLES_TOGGLE ; TOGGLE
	event OnSelectST() 
		toggle =  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleEstrusTentacles" )    

		If (toggle ==1)
			kPlayer.SendModEvent("SLPInfectEstrusTentacle")
		else
			kPlayer.SendModEvent("SLPCureEstrusTentacle")
		Endif

		SetToggleOptionValueST( toggle )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleEstrusTentacles", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Estrus Tentacles for roleplay or testing purposes (will work only if Estrus Chaurus+ is installed).")
	endEvent

endState
; AddSliderOptionST("STATE_ESTRUSTENTACLES_CHANCE","Chance of infection", _chanceEstrusTentacles,"{0} %")
state STATE_ESTRUSTENTACLES_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceEstrusTentacles" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceEstrusTentacles", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceEstrusTentacles", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of attacks by Estrus Tentacles")
	endEvent
endState

; AddToggleOptionST("STATE_TENTACLEMONSTER_TOGGLE","Tentacle Monster", _toggleTentacleMonster as Float, OPTION_FLAG_DISABLED)
state STATE_TENTACLEMONSTER_TOGGLE ; TOGGLE
	event OnSelectST() 
		toggle =  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleTentacleMonster" )    

		If (toggle ==1)
			kPlayer.SendModEvent("SLPInfectTentacleMonster")
		else
			kPlayer.SendModEvent("SLPCureTentacleMonster")
		Endif

		SetToggleOptionValueST( toggle )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleTentacleMonster", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Tentacle Monster for roleplay or testing purposes.")
	endEvent

endState
; AddSliderOptionST("STATE_TENTACLEMONSTER_BREAST","Node size", _breastMaxTentacleMonster,"{0}")
state STATE_TENTACLEMONSTER_BREAST ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_breastMaxTentacleMonster" ) )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( 0.0, 4.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_breastMaxTentacleMonster", thisValue )
		SetSliderOptionValueST( thisValue,"{1}" )
		kPlayer.SendModEvent("SLPRefreshBodyShape")
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_breastMaxTentacleMonster", 1.0 )
		SetSliderOptionValueST( 1.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Max size of breast node (for NiOverride compatiblity)")
	endEvent
endState
; AddSliderOptionST("STATE_TENTACLEMONSTER_CHANCE","Chance of infection", _chanceTentacleMonster,"{0} %")
state STATE_TENTACLEMONSTER_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceTentacleMonster" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceTentacleMonster", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceTentacleMonster", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of attacks by Tentacle Monsters")
	endEvent
endState

; AddToggleOptionST("STATE_RESET","Reset changes", _resetToggle)
state STATE_RESET ; TOGGLE
	event OnSelectST()
		_resetParasiteSettings()
		kPlayer.SendModEvent("SLPRefreshBodyShape")
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("Reset settings.")
	endEvent

endState

Function _resetParasiteSettings()
	StorageUtil.SetIntValue(none, "_SLP_versionMCM", 20161014 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSpiderEgg", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSpiderEgg", 50.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxSpiderEgg", 2.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSpiderPenis", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSpiderPenis", 10.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusWorm", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusWorm", 10.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_buttMaxChaurusWorm", 2.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleEstrusTentacles", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceEstrusTentacles", 10.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleTentacleMonster", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceTentacleMonster", 30.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_breastMaxTentacleMonster", 2.0 )
EndFunction


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
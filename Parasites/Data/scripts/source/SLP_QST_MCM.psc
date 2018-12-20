Scriptname SLP_QST_MCM extends SKI_ConfigBase  

SLP_fcts_parasites Property fctParasites  Auto
Ingredient  Property IngredientSpiderEgg Auto

; PRIVATE VARIABLES -------------------------------------------------------------------------------

; --- Version 1 ---

; State

bool 		_resetToggle
bool 		_registerEventsToggle

bool		_toggleSpiderEgg = true
float		_chanceSpiderEgg = -1.0
float		_bellyMaxSpiderEgg = 2.0

bool		_toggleSpiderPenis = true
float		_chanceSpiderPenis = -1.0

bool		_toggleChaurusWorm = true
float		_chanceChaurusWorm = -1.0
float		_buttMaxChaurusWorm = 1.0

bool		_toggleChaurusWormVag = true
float		_chanceChaurusWormVag = -1.0
float		_bellyMaxChaurusWormVag = 1.0

bool		_toggleEstrusTentacles = true
float		_chanceEstrusTentacles = -1.0

bool		_toggleTentacleMonster = true
float		_chanceTentacleMonster = -1.0
float		_breastMaxTentacleMonster = 2.0

bool		_toggleEstrusSlime = true
float		_chanceEstrusSlime = -1.0

bool		_toggleLivingArmor = true
float		_chanceLivingArmor = -1.0
float		_breastMaxLivingArmor = 2.0

bool		_toggleFaceHugger = true
float		_chanceFaceHugger = -1.0 
bool		_toggleFaceHuggerGag = true
float		_chanceFaceHuggerGag = -1.0 
float		_bellyMaxFaceHugger = 1.0

bool		_toggleBarnacles = true
float		_chanceBarnacles = -1.0 

bool		_toggleRefreshAll = false
bool		_toggleClearAll = false

bool		_togglePriestOutfits = false
float  		_resetTrigger = 1.0

Actor kPlayer

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


	_resetTrigger = (0.1 + _chanceSpiderEgg) * (0.1 + _chanceSpiderPenis) * (0.1 + _chanceChaurusWorm) * (0.1 + _chanceChaurusWormVag) * (0.1 + _chanceEstrusTentacles) * (0.1 + _chanceTentacleMonster) * (0.1 + _chanceEstrusSlime) * (0.1 + _chanceLivingArmor) * (0.1 + _chanceFaceHugger) * (0.1 + _chanceBarnacles) 

	If (StorageUtil.GetIntValue(none, "_SLP_initMCM" )!=1)
		StorageUtil.SetIntValue(none, "_SLP_initMCM", 1 )
	EndIf

 	If (StorageUtil.GetIntValue(none, "_SLP_versionMCM" ) == 0) || (_resetTrigger<0.0)
 		_setParasiteSettings()
 	Endif

	StorageUtil.SetIntValue(none, "_SLP_versionMCM", 20161109 )

	_toggleSpiderEgg = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSpiderEgg" )
	_chanceSpiderEgg = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSpiderEgg" )
	_bellyMaxSpiderEgg = StorageUtil.GetFloatValue(kPlayer, "_SLP_bellyMaxSpiderEgg" )

	_toggleSpiderPenis = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSpiderPenis" )
	_chanceSpiderPenis = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSpiderPenis" )

	_toggleChaurusWorm = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusWorm" )
	_chanceChaurusWorm = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceChaurusWorm" )
	_buttMaxChaurusWorm = StorageUtil.GetFloatValue(kPlayer, "_SLP_buttMaxChaurusWorm" )

	_toggleChaurusWormVag = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusWormVag" )
	_chanceChaurusWormVag = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceChaurusWormVag" )
	_bellyMaxChaurusWormVag = StorageUtil.GetFloatValue(kPlayer, "_SLP_bellyMaxChaurusWormVag" )

	_toggleEstrusTentacles = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleEstrusTentacles" )
	_chanceEstrusTentacles = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceEstrusTentacles" )

	_toggleTentacleMonster = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleTentacleMonster" )
	_chanceTentacleMonster = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceTentacleMonster" )
	_breastMaxTentacleMonster = StorageUtil.GetFloatValue(kPlayer, "_SLP_breastMaxTentacleMonster" )

	_toggleEstrusSlime = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleEstrusSlime" )
	_chanceEstrusSlime = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceEstrusSlime" )

	_toggleLivingArmor = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleLivingArmor" )
	_chanceLivingArmor = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceLivingArmor" )
	_breastMaxLivingArmor = StorageUtil.GetFloatValue(kPlayer, "_SLP_breastMaxLivingArmor" )

	_toggleFaceHugger = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleFaceHugger" )
	_chanceFaceHugger = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceFaceHugger" )
	_toggleFaceHuggerGag = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleFaceHuggerGag" )
	_chanceFaceHuggerGag = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceFaceHuggerGag" )
	_bellyMaxFaceHugger = StorageUtil.GetFloatValue(kPlayer, "_SLP_bellyMaxFaceHugger" )

	_toggleBarnacles = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleBarnacles" )
	_chanceBarnacles = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceBarnacles" )

	_togglePriestOutfits = StorageUtil.GetIntValue(none, "_SLP_togglePriestOutfits" )



	If (a_page == "Parasites")

		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption(" Chance of infection")
		AddSliderOptionST("STATE_SPIDEREGG_CHANCE","Spider Eggs (Vaginal plug)", _chanceSpiderEgg,"{0} %")
		AddSliderOptionST("STATE_SPIDERPENIS_CHANCE","Spider Penis (Vaginal plug)", _chanceSpiderPenis,"{0} %")
		AddSliderOptionST("STATE_CHAURUSWORM_CHANCE","Chaurus Worm (Anal plug)", _chanceChaurusWorm,"{0} %")
		AddSliderOptionST("STATE_CHAURUSWORMVAG_CHANCE","Chaurus Worm (Vaginal plug)", _chanceChaurusWormVag,"{0} %")
		AddSliderOptionST("STATE_ESTRUSTENTACLES_CHANCE","Estrus Tentacles (EC+)", _chanceEstrusTentacles,"{0} %") 
		AddSliderOptionST("STATE_TENTACLEMONSTER_CHANCE","Tentacle Monster (Harness)", _chanceTentacleMonster,"{0} %") 
		AddSliderOptionST("STATE_ESTRUSSLIME_CHANCE","Estrus Slime (EC+)", _chanceEstrusSlime,"{0} %")
		AddSliderOptionST("STATE_LIVINGARMOR_CHANCE","Living Armor (Harness)", _chanceLivingArmor,"{0} %")
		AddSliderOptionST("STATE_FACEHUGGER_CHANCE","Creepy Crawler (Belt)", _chanceFaceHugger,"{0} %")
		AddSliderOptionST("STATE_FACEHUGGERGAG_CHANCE","Creepy Crawler (Gag)", _chanceFaceHuggerGag,"{0} %")
		AddSliderOptionST("STATE_BARNACLES_CHANCE","Barnacles (Harness)", _chanceBarnacles,"{0} %")

		SetCursorPosition(1)
		AddHeaderOption(" Infect/Cure")
		AddToggleOptionST("STATE_SPIDEREGG_TOGGLE","Infect/Cure Spider Egg", _toggleSpiderEgg as Float)
		AddToggleOptionST("STATE_SPIDERPENIS_TOGGLE","Infect/Cure Spider Penis", _toggleSpiderPenis as Float)
		AddToggleOptionST("STATE_CHAURUSWORM_TOGGLE","Infect/Cure Chaurus Worm", _toggleChaurusWorm as Float)
		AddToggleOptionST("STATE_CHAURUSWORMVAG_TOGGLE","Infect/Cure Vaginal Chaurus Worm", _toggleChaurusWormVag as Float)
		AddToggleOptionST("STATE_TENTACLEMONSTER_TOGGLE","Infect/Cure Tentacle Monster", _toggleTentacleMonster as Float)
		AddToggleOptionST("STATE_LIVINGARMOR_TOGGLE","Infect/Cure Living Armor", _toggleLivingArmor as Float)
		AddToggleOptionST("STATE_FACEHUGGER_TOGGLE","Infect/Cure Creepy Crawler", _toggleFaceHugger as Float)
		AddToggleOptionST("STATE_FACEHUGGERGAG_TOGGLE","Infect/Cure Creepy Crawler (face)", _toggleFaceHuggerGag as Float)
		AddToggleOptionST("STATE_BARNACLES_TOGGLE","Infect/Cure Barnacles", _toggleBarnacles as Float)

		AddHeaderOption(" NiOverride node scales")
		AddSliderOptionST("STATE_SPIDEREGG_BELLY","Max belly size (Spider egg)", _bellyMaxSpiderEgg,"{1}")
		AddSliderOptionST("STATE_CHAURUSWORMVAG_BELLY","Max belly size (Vaginal chaurus worm)", _bellyMaxChaurusWormVag,"{1}")
		AddSliderOptionST("STATE_FACEHUGGER_BELLY","Max belly size (Face Hugger)", _bellyMaxFaceHugger,"{1}")
		AddSliderOptionST("STATE_TENTACLEMONSTER_BREAST","Max breast size (Tentacle monster)", _breastMaxTentacleMonster,"{1}")
		AddSliderOptionST("STATE_LIVINGARMOR_BREAST","Max breast size (Living Armor)", _breastMaxLivingArmor,"{1}")
		AddSliderOptionST("STATE_CHAURUSWORM_BUTT","Max butt size (Chaurus worm)", _buttMaxChaurusWorm,"{1}")

		AddHeaderOption(" ")
		AddToggleOptionST("STATE_REFRESH_ALL","Refresh all equipped parasites", _toggleRefreshAll as Float)
		AddToggleOptionST("STATE_CLEAR_ALL","Clear all parasites", _toggleClearAll as Float)

		AddHeaderOption(" ")
		AddToggleOptionST("STATE_OUTFITS_TOGGLE","Custom Priest Outfits", _togglePriestOutfits as Float)
		AddToggleOptionST("STATE_REGISTER_EVENTS","Register custom device events", _registerEventsToggle as Float)
		AddToggleOptionST("STATE_RESET","Reset changes", _resetToggle as Float)
	

	ElseIf (a_page == "Quests")
		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption(" Placeholder - No option yet")


	endIf
endEvent


; AddToggleOptionST("STATE_SPIDEREGG_TOGGLE","Spider Egg", _toggleSpiderEgg as Float, OPTION_FLAG_DISABLED)
state STATE_SPIDEREGG_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSpiderEgg" )  ) 
 
		If (toggle ==1)
			Debug.MessageBox("Infecting player with Spider Eggs")
			kPlayer.SendModEvent("SLPInfectSpiderEgg")
		else
			Debug.MessageBox("Curing player from Spider Eggs")
			kPlayer.SendModEvent("SLPCureSpiderEgg","All")
		Endif

		SetToggleOptionValueST( toggle as Bool )
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
		SetSliderDialogRange( 1.0, 6.0 )
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
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSpiderPenis" )    )

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Spider Penis")
			kPlayer.SendModEvent("SLPInfectSpiderPenis")
		else
			Debug.MessageBox("Curing player from Spider Penis")
			kPlayer.SendModEvent("SLPCureSpiderPenis")
		Endif
		SetToggleOptionValueST( toggle as Bool )
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
		Int toggle = Math.LogicalXor( 1, StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusWorm" )   )
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusWorm", toggle as Int )

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Chaurus Worm")
			kPlayer.SendModEvent("SLPInfectChaurusWorm")
		else
			Debug.MessageBox("Curing player from Chaurus Worm")
			kPlayer.SendModEvent("SLPCureChaurusWorm")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusWorm", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Chaurus Worm for roleplay or testing purposes.")
	endEvent

endState
; AddSliderOptionST("STATE_CHAURUSWORM_BUTT","Node size", _buttMaxChaurusWorm,"{0}")
state STATE_CHAURUSWORM_BUTT ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_buttMaxChaurusWorm" ) )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( 1.0, 6.0 )
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
; AddSliderOptionST("STATE_CHAURUSWORM_CHANCE","Chance of infection", _chanceChaurusWorm,"{0} %")
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

; AddSliderOptionST("STATE_CHAURUSWORMVAG_CHANCE","Chance of infection", _chanceChaurusWormVag,"{0} %")
state STATE_CHAURUSWORMVAG_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceChaurusWormVag" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusWormVag", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusWormVag", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of a vaginal chaurus worm from sex with Chaurus")
	endEvent
endState

; AddToggleOptionST("STATE_CHAURUSWORMVAG_TOGGLE","Chaurus Worm Vaginal", _toggleChaurusWormVag as Float, OPTION_FLAG_DISABLED)
state STATE_CHAURUSWORMVAG_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1, StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusWormVag" )   )
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusWormVag", toggle as Int )

		If (toggle ==1)
			Debug.MessageBox("Infecting player with vaginal Chaurus Worm")
			kPlayer.SendModEvent("SLPInfectChaurusWormVag")
		else
			Debug.MessageBox("Curing player from vaginal Chaurus Worm")
			kPlayer.SendModEvent("SLPCureChaurusWormVag")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusWormVag", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure vaginal Chaurus Worm for roleplay or testing purposes.")
	endEvent

endState

; AddSliderOptionST("STATE_CHAURUSWORMVAG_BELLY","Node size", _bellyMaxChaurusWormVag,"{0}")
state STATE_CHAURUSWORMVAG_BELLY ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_bellyMaxChaurusWormVag" ) )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( 1.0, 6.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxChaurusWormVag", thisValue )
		SetSliderOptionValueST( thisValue,"{1}" )
		kPlayer.SendModEvent("SLPRefreshBodyShape")
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxChaurusWormVag", 1.0 )
		SetSliderOptionValueST( 1.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Max size of belly node (for NiOverride compatiblity)")
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
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleTentacleMonster" )  )  

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Tentacle Monster")
			kPlayer.SendModEvent("SLPInfectTentacleMonster")
		else
			Debug.MessageBox("Curing player from Tentacle Monster")
			kPlayer.SendModEvent("SLPCureTentacleMonster")
		Endif

		SetToggleOptionValueST( toggle as Bool )
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
; AddSliderOptionST("STATE_TENTACLEMONSTER_BREAST","Node size", _breastMaxTentacleMonster,"{0}")
state STATE_TENTACLEMONSTER_BREAST ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_breastMaxTentacleMonster" ) )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( 1.0, 6.0 )
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

; AddSliderOptionST("STATE_ESTRUSSLIME_CHANCE","Chance of infection", _chanceEstrusSlime,"{0} %")
state STATE_ESTRUSSLIME_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceEstrusSlime" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceEstrusSlime", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceEstrusSlime", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of attacks by Estrus Slime")
	endEvent
endState

; AddToggleOptionST("STATE_LIVINGARMOR_TOGGLE","Living Armor", _toggleLivingArmor as Float, OPTION_FLAG_DISABLED)
state STATE_LIVINGARMOR_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleLivingArmor" )  )  

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Living Armor")
			kPlayer.SendModEvent("SLPInfectLivingArmor")
		else
			Debug.MessageBox("Curing player from Living Armor")
			kPlayer.SendModEvent("SLPCureLivingArmor")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleLivingArmor", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Living Armor for roleplay or testing purposes.")
	endEvent

endState
; AddSliderOptionST("STATE_LIVINGARMOR_CHANCE","Chance of infection", _chanceLivingArmor,"{0} %")
state STATE_LIVINGARMOR_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceLivingArmor" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceLivingArmor", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceLivingArmor", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of attacks by Living Armor")
	endEvent
endState
; AddSliderOptionST("STATE_TENTACLEMONSTER_BREAST","Node size", _breastMaxLivingArmor,"{0}")
state STATE_LIVINGARMOR_BREAST ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_breastMaxLivingArmor" ) )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( 1.0, 6.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_breastMaxLivingArmor", thisValue )
		SetSliderOptionValueST( thisValue,"{1}" )
		kPlayer.SendModEvent("SLPRefreshBodyShape")
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_breastMaxLivingArmor", 1.0 )
		SetSliderOptionValueST( 1.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Max size of breast node (for NiOverride compatiblity)")
	endEvent
endState

; AddToggleOptionST("STATE_FACEHUGGER_TOGGLE","Face Hugger", _toggleFaceHugger as Float, OPTION_FLAG_DISABLED)
state STATE_FACEHUGGER_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleFaceHugger" )  )  

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Face Hugger")
			kPlayer.SendModEvent("SLPInfectFaceHugger")
		else
			Debug.MessageBox("Curing player from Face Hugger")
			kPlayer.SendModEvent("SLPCureFaceHugger")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleFaceHugger", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Face Hugger for roleplay or testing purposes.")
	endEvent

endState
; AddSliderOptionST("STATE_FACEHUGGER_CHANCE","Chance of infection", _chanceFaceHugger,"{0} %")
state STATE_FACEHUGGER_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceFaceHugger" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceFaceHugger", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceFaceHugger", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of attacks by Creepy crawlers (Hips)")
	endEvent
endState
; AddToggleOptionST("STATE_FACEHUGGERGAG_TOGGLE","Face Hugger", _toggleFaceHugger as Float, OPTION_FLAG_DISABLED)
state STATE_FACEHUGGERGAG_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleFaceHuggerGag" )  )  

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Creepy Crawler (face)")
			kPlayer.SendModEvent("SLPInfectFaceHuggerGag")
		else
			Debug.MessageBox("Curing player from Creepy Crawler (face)")
			kPlayer.SendModEvent("SLPCureFaceHuggerGag")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleFaceHuggerGag", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Creepy Crawler (face) for roleplay or testing purposes.")
	endEvent

endState

; AddSliderOptionST("STATE_FACEHUGGERGAG_CHANCE","Chance of infection", _chanceFaceHuggerGag,"{0} %")
state STATE_FACEHUGGERGAG_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceFaceHuggerGag" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceFaceHuggerGag", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceFaceHuggerGag", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of attacks by Creepy crawlers (face)")
	endEvent
endState



; AddSliderOptionST("STATE_FACEHUGGER_BELLY","Node size", _bellyMaxFaceHugger,"{0}")
state STATE_FACEHUGGER_BELLY ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_bellyMaxFaceHugger" ) )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( 1.0, 6.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxFaceHugger", thisValue )
		SetSliderOptionValueST( thisValue,"{1}" )
		kPlayer.SendModEvent("SLPRefreshBodyShape")
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxFaceHugger", 1.0 )
		SetSliderOptionValueST( 1.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Max size of belly node (for NiOverride compatiblity)")
	endEvent
endState

; AddToggleOptionST("STATE_BARNACLES_TOGGLE","Barnacles", _toggleBarnacles as Float, OPTION_FLAG_DISABLED)
state STATE_BARNACLES_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleBarnacles" )  )  

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Barnacles")
			kPlayer.SendModEvent("SLPInfectBarnacles")
		else
			Debug.MessageBox("Curing player from Barnacles")
			kPlayer.SendModEvent("SLPCureBarnacles")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleBarnacles", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Barnacles for roleplay or testing purposes.")
	endEvent
endState


; AddSliderOptionST("STATE_BARNACLES_CHANCE","Chance of infection", _chanceBarnacles,"{0} %")
state STATE_BARNACLES_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceBarnacles" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceBarnacles", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceBarnacles ", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of attacks by Barnacles")
	endEvent
endState

; AddToggleOptionST("STATE_REFRESH_ALL","Refresh equipped parasites", _toggleRefreshAll, OPTION_FLAG_DISABLED)
state STATE_REFRESH_ALL ; TOGGLE
	event OnSelectST() 
		; Force parasite equip refresh
		SendModEvent("SLPRefreshParasites")
		Debug.MessageBox("[Refreshing all equipped parasites. Wait a minute for all events to clear.]")
		ForcePageReset()
	endEvent

	event OnDefaultST()
		; No action on default
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Refresh the state of current parasites and re-equip or clean up if necessary.")
	endEvent
endState

; AddToggleOptionST("STATE_CLEAR_ALL","Clear all equipped parasites", _toggleClearAll, OPTION_FLAG_DISABLED)
state STATE_CLEAR_ALL ; TOGGLE
	event OnSelectST() 
		; Force all parasite clear
		SendModEvent("SLPClearParasites")
		Debug.MessageBox("[Clearing all equipped parasites. Wait a minute for all events to clear.]")
		ForcePageReset()
	endEvent

	event OnDefaultST()
		; No action on default
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Force clearing of all parasites (use for debug or in case of emergency).")
	endEvent
endState


; AddToggleOptionST("STATE_OUTFITS_TOGGLE","Priest outfits", _togglePriestOutfits as Float, OPTION_FLAG_DISABLED)
state STATE_OUTFITS_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(none, "_SLP_togglePriestOutfits" )  )  
		_togglePriestOutfits = toggle
		StorageUtil.SetIntValue(none, "_SLP_togglePriestOutfits", toggle )
		SetToggleOptionValueST( toggle as Bool )
		Debug.MessageBox("[Replacing priest outfits in Whiterun, Windhelm, Riften and Solitude.]")
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(none, "_SLP_togglePriestOutfits", 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Customize outfits of priests in Whiterun, Windhelm, Riften and Solitude with mesh from TERA (no Undo implemented yet).")
	endEvent
endState

; AddToggleOptionST("STATE_REGISTER_EVENTS","Reset events", _registerEventsToggle)
state STATE_REGISTER_EVENTS ; TOGGLE
	event OnSelectST()
		SendModEvent("zadRegisterEvents")
		Debug.MessageBox("[Devious Devices events registration started. Wait a minute before checking DD menu.]")

		; Test of birthing scene
		; kPlayer.SendModEvent("SLPTriggerEstrusChaurusBirth", "Barnacles", 5.0)
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("Trigger registration of new devious devices custom events.")
	endEvent

endState

; AddToggleOptionST("STATE_RESET","Reset changes", _resetToggle)
state STATE_RESET ; TOGGLE
	event OnSelectST()
		fctParasites._resetParasiteSettings()
		kPlayer.SendModEvent("SLPRefreshBodyShape")
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("Reset settings.")
	endEvent

endState


Function _setParasiteSettings()

	if (_chanceSpiderEgg==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSpiderEgg", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSpiderEgg", 50.0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxSpiderEgg", 2.0 )
	Endif
	if (_chanceSpiderPenis==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSpiderPenis", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSpiderPenis", 10.0 )
	Endif
	if (_chanceChaurusWorm==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusWorm", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusWorm", 10.0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_buttMaxChaurusWorm", 2.0 )
	Endif
	if (_chanceChaurusWormVag==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusWormVag", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusWormVag", 10.0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxChaurusWormVag", 2.0 )
	Endif
	if (_chanceEstrusTentacles==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleEstrusTentacles", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceEstrusTentacles", 10.0 )
	Endif
	if (_chanceTentacleMonster==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleTentacleMonster", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceTentacleMonster", 30.0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_breastMaxTentacleMonster", 2.0 )
	Endif
	if (_chanceEstrusSlime==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleEstrusSlime", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceEstrusSlime", 10.0 )
	Endif
	if (_chanceLivingArmor==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleLivingArmor", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceLivingArmor", 30.0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_breastMaxLivingArmor", 2.0 )
	Endif
	if (_chanceFaceHugger==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleFaceHugger", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceFaceHugger", 30.0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceFaceHuggerGag", 30.0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxFaceHugger", 2.0 )
	Endif
	if (_chanceBarnacles==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleBarnacles", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceBarnacles", 30.0 )
	Endif
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
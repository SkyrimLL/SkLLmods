Scriptname SLP_QST_MCM extends SKI_ConfigBase  

SLP_fcts_parasites Property fctParasites  Auto
SLP_fcts_utils Property fctUtils  Auto

Ingredient  Property IngredientSpiderEgg Auto

GlobalVariable      Property _SLP_GV_numChaurusEggsLastelle                   Auto

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

bool		_toggleSprigganRootGag = true
float		_chanceSprigganRootGag = -1.0
bool		_toggleSprigganRootArms = true
float		_chanceSprigganRootArms = -1.0
bool		_toggleSprigganRootFeet = true
float		_chanceSprigganRootFeet = -1.0
bool		_toggleSprigganRootBody = true
float		_chanceSprigganRootBody = -1.0

bool		_toggleSprigganRootDebug = false

bool		_toggleChaurusQueenDebug = false
bool		_toggleChaurusQueenVag = true
float		_chanceChaurusQueenVag = -1.0
bool		_toggleChaurusQueenGag = true
float		_chanceChaurusQueenGag = -1.0
bool		_toggleChaurusQueenSkin = true
float		_chanceChaurusQueenSkin = -1.0
bool		_toggleChaurusQueenArmor = true
float		_chanceChaurusQueenArmor = -1.0
bool		_toggleChaurusQueenBody = true
float		_chanceChaurusQueenBody = -1.0
float		_bellyMaxChaurusQueen = -1.0
float		_maxBroodSpawns = -1.0
bool		_autoRemoveDragonWings = false


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


	_resetTrigger = 1.0

	If (StorageUtil.GetIntValue(none, "_SLP_initMCM" )!=1)
		StorageUtil.SetIntValue(none, "_SLP_initMCM", 1 )
	EndIf

	StorageUtil.SetIntValue(none, "_SLP_versionMCM", 20210528 )

 	; If (StorageUtil.GetIntValue(none, "_SLP_versionMCM" ) == 0) || (_resetTrigger<0.0)
 		_setParasiteSettings()
 	; Endif

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

	_toggleSprigganRootArms = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSprigganRootArms" )
	_chanceSprigganRootArms = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSprigganRootArms" )
	_toggleSprigganRootFeet = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSprigganRootFeet" )
	_chanceSprigganRootFeet = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSprigganRootFeet" )
	_toggleSprigganRootBody = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSprigganRootBody" )
	_chanceSprigganRootBody = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSprigganRootBody" )
	_toggleSprigganRootGag = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSprigganRootGag" )
	_chanceSprigganRootGag = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSprigganRootGag" )

	if (StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSprigganRoot" )==1)
		_toggleSprigganRootDebug = true
	else
		_toggleSprigganRootDebug = false
	endif
	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootDebug", _toggleSprigganRootDebug as Int )

	_toggleChaurusQueenDebug = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusQueenDebug" )
	_toggleChaurusQueenVag = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusQueenVag" )
	_chanceChaurusQueenVag = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceChaurusQueenVag" )
	_toggleChaurusQueenGag = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusQueenGag" )
	_chanceChaurusQueenGag = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceChaurusQueenGag" )
	_toggleChaurusQueenSkin = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusQueenSkin" )
	_chanceChaurusQueenSkin = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceChaurusQueenSkin" )
	_toggleChaurusQueenArmor = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusQueenArmor" )
	_chanceChaurusQueenArmor = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceChaurusQueenArmor" )
	_toggleChaurusQueenBody = StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusQueenBody" )
	_chanceChaurusQueenBody = StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceChaurusQueenBody" )
	_bellyMaxChaurusQueen = StorageUtil.GetFloatValue(kPlayer, "_SLP_bellyMaxChaurusQueen" )
	_maxBroodSpawns = StorageUtil.GetIntValue(kPlayer, "_SLP_maxBroodSpawns" ) as Float

	_togglePriestOutfits = StorageUtil.GetIntValue(none, "_SLP_togglePriestOutfits" )

	Int iChaurusQueenStage = StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage")

	If (a_page == "Parasites")

		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption(" Chance of infection")
		AddSliderOptionST("STATE_SPIDEREGG_CHANCE","Spider Eggs (Vaginal plug)", _chanceSpiderEgg,"{0} %")
		AddSliderOptionST("STATE_SPIDERPENIS_CHANCE","Spider Penis (Vaginal plug)", _chanceSpiderPenis,"{0} %")
		AddSliderOptionST("STATE_CHAURUSWORM_CHANCE","Chaurus Worm (Anal plug)", _chanceChaurusWorm,"{0} %")
		AddSliderOptionST("STATE_CHAURUSWORMVAG_CHANCE","Vaginal Chaurus Worm (Vaginal plug)", _chanceChaurusWormVag,"{0} %")
		AddSliderOptionST("STATE_TENTACLEMONSTER_CHANCE","Tentacle Monster (Harness)", _chanceTentacleMonster,"{0} %") 
		AddSliderOptionST("STATE_LIVINGARMOR_CHANCE","Living Armor (Harness)", _chanceLivingArmor,"{0} %")
		AddSliderOptionST("STATE_FACEHUGGER_CHANCE","Hip Hugger (Belt)", _chanceFaceHugger,"{0} %")
		AddSliderOptionST("STATE_FACEHUGGERGAG_CHANCE","Face Hugger (Gag)", _chanceFaceHuggerGag,"{0} %")
		AddSliderOptionST("STATE_BARNACLES_CHANCE","Blackreach Spores (Harness)", _chanceBarnacles,"{0} %")

		AddSliderOptionST("STATE_SPRIGGANROOTARMS_CHANCE","Spriggan Hands (Cuffs)", _chanceSprigganRootArms,"{0} %")
		AddSliderOptionST("STATE_SPRIGGANROOTFEET_CHANCE","Spriggan Feet (Cuffs)", _chanceSprigganRootFeet,"{0} %")
		AddSliderOptionST("STATE_SPRIGGANROOTBODY_CHANCE","Spriggan Body (Harness)", _chanceSprigganRootBody,"{0} %")
		AddSliderOptionST("STATE_SPRIGGANROOTGAG_CHANCE","Spriggan Mask (Gag)", _chanceSprigganRootGag,"{0} %")

		AddSliderOptionST("STATE_ESTRUSTENTACLES_CHANCE","Estrus Tentacles (EC+)", _chanceEstrusTentacles,"{0} %") 
		AddSliderOptionST("STATE_ESTRUSSLIME_CHANCE","Estrus Slime (EC+)", _chanceEstrusSlime,"{0} %")


		SetCursorPosition(1)
		AddHeaderOption(" Infect/Cure")
		AddToggleOptionST("STATE_SPIDEREGG_TOGGLE","Infect/Cure Spider Egg", _toggleSpiderEgg as Float)
		AddToggleOptionST("STATE_SPIDERPENIS_TOGGLE","Infect/Cure Spider Penis", _toggleSpiderPenis as Float)
		AddToggleOptionST("STATE_CHAURUSWORM_TOGGLE","Infect/Cure Chaurus Worm", _toggleChaurusWorm as Float)
		AddToggleOptionST("STATE_CHAURUSWORMVAG_TOGGLE","Infect/Cure Vaginal Chaurus Worm", _toggleChaurusWormVag as Float)
		AddToggleOptionST("STATE_TENTACLEMONSTER_TOGGLE","Infect/Cure Tentacle Monster", _toggleTentacleMonster as Float)
		AddToggleOptionST("STATE_LIVINGARMOR_TOGGLE","Infect/Cure Living Armor", _toggleLivingArmor as Float)
		AddToggleOptionST("STATE_FACEHUGGER_TOGGLE","Infect/Cure Hip Hugger", _toggleFaceHugger as Float)
		AddToggleOptionST("STATE_FACEHUGGERGAG_TOGGLE","Infect/Cure Face Hugger", _toggleFaceHuggerGag as Float)
		AddToggleOptionST("STATE_BARNACLES_TOGGLE","Infect/Cure Blackreach Spores", _toggleBarnacles as Float)

		AddToggleOptionST("STATE_SPRIGGANROOTARMS_TOGGLE","Infect/Cure Spriggan Hands", _toggleSprigganRootArms as Float)
		AddToggleOptionST("STATE_SPRIGGANROOTFEET_TOGGLE","Infect/Cure Spriggan Feet", _toggleSprigganRootFeet as Float, OPTION_FLAG_DISABLED)
		AddToggleOptionST("STATE_SPRIGGANROOTBODY_TOGGLE","Infect/Cure Spriggan Body", _toggleSprigganRootBody as Float)
		AddToggleOptionST("STATE_SPRIGGANROOTGAG_TOGGLE","Infect/Cure Spriggan Mask", _toggleSprigganRootGag as Float)

		AddHeaderOption(" NiOverride node scales")
		AddSliderOptionST("STATE_SPIDEREGG_BELLY","Max belly size (Spider egg)", _bellyMaxSpiderEgg,"{1}")
		AddSliderOptionST("STATE_CHAURUSWORMVAG_BELLY","Max belly size (Vaginal chaurus worm)", _bellyMaxChaurusWormVag,"{1}")
		AddSliderOptionST("STATE_FACEHUGGER_BELLY","Max belly size (Face Hugger)", _bellyMaxFaceHugger,"{1}")
		AddSliderOptionST("STATE_TENTACLEMONSTER_BREAST","Max breast size (Tentacle monster)", _breastMaxTentacleMonster,"{1}")
		AddSliderOptionST("STATE_LIVINGARMOR_BREAST","Max breast size (Living Armor)", _breastMaxLivingArmor,"{1}")
		AddSliderOptionST("STATE_CHAURUSWORM_BUTT","Max butt size (Chaurus worm)", _buttMaxChaurusWorm,"{1}")

		AddHeaderOption(" Maintenance ")
		AddToggleOptionST("STATE_REFRESH_ALL","Refresh all equipped parasites", _toggleRefreshAll as Float)
		AddToggleOptionST("STATE_CLEAR_ALL","Clear all parasites", _toggleClearAll as Float)

		AddHeaderOption(" ")
		AddToggleOptionST("STATE_OUTFITS_TOGGLE","Custom Priest Outfits", _togglePriestOutfits as Float)
		AddToggleOptionST("STATE_REGISTER_EVENTS","Register custom device events", _registerEventsToggle as Float)
		AddToggleOptionST("STATE_RESET","Reset changes", _resetToggle as Float)
	

	ElseIf (a_page == "Quests")
		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption(" Kyne Blessing ")
		AddToggleOptionST("STATE_SPRIGGANROOTDEBUG_TOGGLE","Toggle Spriggan Root infection", _toggleSprigganRootDebug as Float)

		AddTextOption("     Total infections: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iInfections") as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Spider Egg Infections: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iSpiderEggInfections") as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Anal Chaurus Worm Infections: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusWormInfections") as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Vaginal Chaurus Worm Infections: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusWormVagInfections") as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Hip Hugger: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iFaceHuggerInfections") as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Face Hugger: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iFaceHuggerInfections") as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Blackreach Spores: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iBarnaclesInfections") as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Spriggan Roots: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iSprigganRootInfections") as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Living Armor Infections: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iLivingArmorInfections") as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Tentacle Monster Infections: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iTentacleMonsterInfections") as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Estrus Tentacles Attacks: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iEstrusTentaclesInfections") as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Estrus Eggs Infections: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iEstrusChaurusEggInfections") as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Estrus Slime Infections: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iEstrusSlimeInfections") as Int, "", OPTION_FLAG_DISABLED)

		AddHeaderOption(" Factions")
		AddTextOption("     Player in Spider Faction: " + fctUtils.CheckIfSpiderFaction(kPlayer) as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Player in Chaurus Faction: " + fctUtils.CheckIfChaurusFaction(kPlayer) as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Player in Spriggan Faction: " + fctUtils.CheckIfSprigganFaction(kPlayer) as Int, "", OPTION_FLAG_DISABLED)

		AddHeaderOption(" Long term curses")
		AddTextOption("     Chaurus Queen Infection: " + iChaurusQueenStage as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Spriggan Infection: " + StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSprigganRoot") as Int, "", OPTION_FLAG_DISABLED)

		SetCursorPosition(1)
		AddHeaderOption(" Brood Maiden ")
		AddTextOption("     Lastelle Eggs: " + _SLP_GV_numChaurusEggsLastelle.GetValue() as Int, "", OPTION_FLAG_DISABLED)

		AddHeaderOption(" Chaurus Queen ")
		if (iChaurusQueenStage==0)
			AddToggleOptionST("STATE_CHAURUSQUEENDEBUG_TOGGLE","Unlock Chaurus Queen items", _toggleChaurusQueenDebug as Float)
		else
			AddToggleOptionST("STATE_CHAURUSQUEENDEBUG_TOGGLE","Unlock Chaurus Queen items", _toggleChaurusQueenDebug as Float, OPTION_FLAG_DISABLED)
		endif
		
		if (_toggleChaurusQueenDebug) || (iChaurusQueenStage>0)
			AddSliderOptionST("STATE_CHAURUSQUEEN_BELLY","Max belly size (Chaurus Queen)", _bellyMaxChaurusQueen,"{1}")
			AddToggleOptionST("STATE_CHAURUSQUEENVAG_TOGGLE","Infect/Cure Vaginal Chaurus Queen", _toggleChaurusQueenVag as Float)
		else
			AddSliderOptionST("STATE_CHAURUSQUEEN_BELLY","Max belly size (Chaurus Queen)", _bellyMaxChaurusQueen,"{1}", OPTION_FLAG_DISABLED)
			AddToggleOptionST("STATE_CHAURUSQUEENVAG_TOGGLE","Infect/Cure Vaginal Chaurus Queen", _toggleChaurusQueenVag as Float, OPTION_FLAG_DISABLED)
		endif

		if (_toggleChaurusQueenDebug) || (iChaurusQueenStage>=3)
			AddToggleOptionST("STATE_CHAURUSQUEENSKIN_TOGGLE","Infect/Cure Chaurus Queen Skin", _toggleChaurusQueenSkin as Float)
		else
			AddToggleOptionST("STATE_CHAURUSQUEENSKIN_TOGGLE","Infect/Cure Chaurus Queen Skin", _toggleChaurusQueenSkin as Float, OPTION_FLAG_DISABLED)
		endif

		if (_toggleChaurusQueenDebug) || (iChaurusQueenStage>=4)
			AddToggleOptionST("STATE_CHAURUSQUEENGAG_TOGGLE","Infect/Cure Chaurus Queen Mask", _toggleChaurusQueenGag as Float)
			AddToggleOptionST("STATE_CHAURUSQUEENARMOR_TOGGLE","Infect/Cure Chaurus Queen Armor", _toggleChaurusQueenArmor as Float)
		else
			AddToggleOptionST("STATE_CHAURUSQUEENGAG_TOGGLE","Infect/Cure Chaurus Queen Mask", _toggleChaurusQueenGag as Float, OPTION_FLAG_DISABLED)
			AddToggleOptionST("STATE_CHAURUSQUEENARMOR_TOGGLE","Infect/Cure Chaurus Queen Armor", _toggleChaurusQueenArmor as Float, OPTION_FLAG_DISABLED)
		endif


		if (_toggleChaurusQueenDebug) || (iChaurusQueenStage>=5)
			AddToggleOptionST("STATE_CHAURUSQUEENBODY_TOGGLE","Infect/Cure Chaurus Queen Full Body", _toggleChaurusQueenBody as Float)
			AddSliderOptionST("STATE_MAX_BROODSPAWNS","Brood size", _maxBroodSpawns ,"{1}")
			AddToggleOptionST("STATE_AUTO_REMOVE_WINGS","Auto Remove Wings", _autoRemoveDragonWings as Float)
		else
			AddToggleOptionST("STATE_CHAURUSQUEENBODY_TOGGLE","Infect/Cure Chaurus Queen Full Body", _toggleChaurusQueenBody as Float, OPTION_FLAG_DISABLED)
			AddSliderOptionST("STATE_MAX_BROODSPAWNS","Brood size", _maxBroodSpawns ,"{1}", OPTION_FLAG_DISABLED)
			AddToggleOptionST("STATE_AUTO_REMOVE_WINGS","Auto Remove Wings", _autoRemoveDragonWings as Float, OPTION_FLAG_DISABLED)
		endif

		AddTextOption("     Chaurus Queen Stage: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage") as Int, "", OPTION_FLAG_DISABLED)
		AddTextOption("     Days since start: " + (Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenDate")) as Int, "", OPTION_FLAG_DISABLED)

		if (StorageUtil.GetIntValue(none, "_SLP_isAnimatedDragonWings") ==  1) 
			AddTextOption("     Animated Dragon Wings detected", "", OPTION_FLAG_DISABLED)
		endif

		if (StorageUtil.GetIntValue(none, "_SLP_isRealFlying") ==  1) 
			AddTextOption("     Real Flying detected", "", OPTION_FLAG_DISABLED)
		endif

		if (StorageUtil.GetIntValue(none, "_SLP_isAnimatedWingsUltimate") ==  1) 
			AddTextOption("     Animated Wings Ultimate detected", "", OPTION_FLAG_DISABLED)
		endif

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
			Debug.MessageBox("Infecting player with Hip Hugger")
			kPlayer.SendModEvent("SLPInfectFaceHugger")
		else
			Debug.MessageBox("Curing player from Hip Hugger")
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
		SetInfoText("Manually Infect/Cure Hip Hugger for roleplay or testing purposes.")
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
		SetInfoText("Chance of attacks by Hip Hugger")
	endEvent
endState
; AddToggleOptionST("STATE_FACEHUGGERGAG_TOGGLE","Face Hugger", _toggleFaceHugger as Float, OPTION_FLAG_DISABLED)
state STATE_FACEHUGGERGAG_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleFaceHuggerGag" )  )  

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Face Hugger")
			kPlayer.SendModEvent("SLPInfectFaceHuggerGag")
		else
			Debug.MessageBox("Curing player from Face Hugger")
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
		SetInfoText("Manually Infect/Cure Face Hugger for roleplay or testing purposes.")
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
		SetInfoText("Chance of attacks by Face Hugger")
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
		SetInfoText("Manually Infect/Cure Blackreach Spores (Barnacles) for roleplay or testing purposes.")
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

; AddToggleOptionST("STATE_SPRIGGANROOTGAG_TOGGLE","SprigganRootGag", _toggleSprigganRootGag as Float, OPTION_FLAG_DISABLED)
state STATE_SPRIGGANROOTGAG_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSprigganRootGag" )  )  

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Spriggan Mask")
			kPlayer.SendModEvent("SLPInfectSprigganRootGag")
		else
			Debug.MessageBox("Curing player from Spriggan Mask")
			kPlayer.SendModEvent("SLPCureSprigganRootGag")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootGag", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Spriggan Mask for roleplay or testing purposes.")
	endEvent
endState


; AddSliderOptionST("STATE_SPRIGGANROOTGAG_CHANCE","Chance of infection", _chanceSprigganRootGag,"{0} %")
state STATE_SPRIGGANROOTGAG_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSprigganRootGag" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootGag", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootGag ", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of infection by Spriggan Mask")
	endEvent
endState

; AddToggleOptionST("STATE_SPRIGGANROOTARMS_TOGGLE","SprigganRootArms", _toggleSprigganRootArms as Float, OPTION_FLAG_DISABLED)
state STATE_SPRIGGANROOTARMS_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSprigganRootArms" )  )  

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Spriggan Hands")
			kPlayer.SendModEvent("SLPInfectSprigganRootArms")
		else
			Debug.MessageBox("Curing player from Spriggan Hands")
			kPlayer.SendModEvent("SLPCureSprigganRootArms")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootArms", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Spriggan Hands for roleplay or testing purposes.")
	endEvent
endState


; AddSliderOptionST("STATE_SPRIGGANROOTARMS_CHANCE","Chance of infection", _chanceSprigganRootArms,"{0} %")
state STATE_SPRIGGANROOTARMS_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSprigganRootArms" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootArms", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootArms ", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of infection by Spriggan Hands")
	endEvent
endState

; AddToggleOptionST("STATE_SPRIGGANROOTFEET_TOGGLE","SprigganRootFeet", _toggleSprigganRootFeet as Float, OPTION_FLAG_DISABLED)
state STATE_SPRIGGANROOTFEET_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSprigganRootFeet" )  )  

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Spriggan Feet")
			kPlayer.SendModEvent("SLPInfectSprigganRootFeet")
		else
			Debug.MessageBox("Curing player from Spriggan Feet")
			kPlayer.SendModEvent("SLPCureSprigganRootFeet")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootFeet", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Spriggan Feet for roleplay or testing purposes.")
	endEvent
endState


; AddSliderOptionST("STATE_SPRIGGANROOTFEET_CHANCE","Chance of infection", _chanceSprigganRootFeet,"{0} %")
state STATE_SPRIGGANROOTFEET_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSprigganRootFeet" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootFeet", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootFeet ", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of infection by Spriggan Feet")
	endEvent
endState

; AddToggleOptionST("STATE_SPRIGGANROOTBODY_TOGGLE","SprigganRootBody", _toggleSprigganRootBody as Float, OPTION_FLAG_DISABLED)
state STATE_SPRIGGANROOTBODY_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSprigganRootBody" )  )  

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Spriggan Body")
			kPlayer.SendModEvent("SLPInfectSprigganRootBody")
		else
			Debug.MessageBox("Curing player from Spriggan Body")
			kPlayer.SendModEvent("SLPCureSprigganRootBody")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootBody", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Spriggan Body for roleplay or testing purposes.")
	endEvent
endState


; AddSliderOptionST("STATE_SPRIGGANROOTBODY_CHANCE","Chance of infection", _chanceSprigganRootBody,"{0} %")
state STATE_SPRIGGANROOTBODY_CHANCE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceSprigganRootBody" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootBody", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootBody ", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of infection by Spriggan Body")
	endEvent
endState

; AddToggleOptionST("STATE_SPRIGGANROOTDEBUG_TOGGLE","Spriggan Root Debug override", _toggleSprigganRootDebug as Float, OPTION_FLAG_DISABLED)
state STATE_SPRIGGANROOTDEBUG_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1, StorageUtil.GetIntValue(kPlayer, "_SLP_toggleSprigganRootDebug" )   )
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootDebug", toggle as Int )

		If (toggle ==1)
			Debug.MessageBox("Spriggan Root infection is Active") 
			kPlayer.SendModEvent("SLPInfectSprigganRoot")
		else
			Debug.MessageBox("Spriggan Root infection is Inactive") 
			kPlayer.SendModEvent("SLPCureSprigganRoot","All")

		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootDebug", 0 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually turn the Spriggan Root infection on or off for role playing or debugging purposes.")
	endEvent

endState

; AddToggleOptionST("STATE_CHAURUSQUEENDEBUG_TOGGLE","Chaurus Queen Debug override", _toggleChaurusQueenDebug as Float, OPTION_FLAG_DISABLED)
state STATE_CHAURUSQUEENDEBUG_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1, StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusQueenDebug" )   )
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenDebug", toggle as Int )

		If (toggle ==1)
			Debug.MessageBox("The options to manually add or remove the Queen of Churus armor elements should be used for testing purposes only. They may break the main quest if you use them too early.") 

			; Debug mode - allow all Chaurus Queen pieces
			StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenVag", 100.0 )
			StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenGag", 100.0 )
			StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenSkin", 100.0 )
			StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenArmor", 100.0 )
			StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenBody", 100.0 )
		else
			Debug.MessageBox("Chaurus Queen Debug override is disabled") 

			; Normal mode - recalculate probabilities based on quest stage
			Int  iChaurusQueenStage = StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage")

			StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenVag", 0.0 )
			StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenGag", 0.0 )
			StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenSkin", 0.0 )
			StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenArmor", 0.0 )
			StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenBody", 0.0 )

			if (iChaurusQueenStage>=1)
				if (iChaurusQueenStage>=2)
					StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenVag", 100.0 )
				endif
				if (iChaurusQueenStage>=3)
					StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenSkin", 100.0 )
				endif
				if (iChaurusQueenStage>=4)
					StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenGag", 100.0 )
					StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenArmor", 100.0 )
				endif
				if (iChaurusQueenStage>=5)
					StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenBody", 100.0 )
				endif
			endif
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenDebug", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Overrides the quest based locks of various armor elements for the Queen of Chaurus. Use only for testing purposes as activating the armor elements too eary may break the quest.")
	endEvent

endState


; AddToggleOptionST("STATE_CHAURUSQUEENVAG_TOGGLE","Chaurus Queen Vaginal", _toggleChaurusQueenVag as Float, OPTION_FLAG_DISABLED)
state STATE_CHAURUSQUEENVAG_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1, StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusQueenVag" )   )
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenVag", toggle as Int )

		If (toggle ==1)
			Debug.MessageBox("Infecting player with vaginal Chaurus Queen")
			kPlayer.SendModEvent("SLPInfectChaurusQueenVag")
		else
			Debug.MessageBox("Curing player from vaginal Chaurus Queen")
			kPlayer.SendModEvent("SLPCureChaurusQueenVag")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenVag", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure vaginal Chaurus Queen for roleplay or testing purposes.")
	endEvent

endState

; AddToggleOptionST("STATE_CHAURUSQUEENGAG_TOGGLE","Chaurus Queen Mask", _toggleChaurusQueenGag as Float, OPTION_FLAG_DISABLED)
state STATE_CHAURUSQUEENGAG_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1, StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusQueenGag" )   )
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenGag", toggle as Int )

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Chaurus Queen mask")
			kPlayer.SendModEvent("SLPInfectChaurusQueenGag")
		else
			Debug.MessageBox("Curing player from Chaurus Queen mask")
			kPlayer.SendModEvent("SLPCureChaurusQueenGag")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenGag", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Chaurus Queen mask for roleplay or testing purposes.")
	endEvent

endState

; AddToggleOptionST("STATE_CHAURUSQUEENSKIN_TOGGLE","Chaurus Queen Armor", _toggleChaurusQueenSkin as Float, OPTION_FLAG_DISABLED)
state STATE_CHAURUSQUEENSKIN_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1, StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusQueenSkin" )   )
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenSkin", toggle as Int )

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Chaurus Queen Skin")
			kPlayer.SendModEvent("SLPInfectChaurusQueenSkin")
		else
			Debug.MessageBox("Curing player from Chaurus Queen Skin")
			kPlayer.SendModEvent("SLPCureChaurusQueenSkin")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenSkin", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Chaurus Queen Skin for roleplay or testing purposes.")
	endEvent

endState


; AddToggleOptionST("STATE_CHAURUSQUEENARMOR_TOGGLE","Chaurus Queen Armor", _toggleChaurusQueenArmor as Float, OPTION_FLAG_DISABLED)
state STATE_CHAURUSQUEENARMOR_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1, StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusQueenArmor" )   )
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenArmor", toggle as Int )

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Chaurus Queen Armor")
			kPlayer.SendModEvent("SLPInfectChaurusQueenArmor")
		else
			Debug.MessageBox("Curing player from Chaurus Queen Armor")
			kPlayer.SendModEvent("SLPCureChaurusQueenArmor")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenArmor", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Chaurus Queen Armor for roleplay or testing purposes.")
	endEvent

endState

; AddToggleOptionST("STATE_CHAURUSQUEENBODY_TOGGLE","Chaurus Queen Body", _toggleChaurusQueenBody as Float, OPTION_FLAG_DISABLED)
state STATE_CHAURUSQUEENBODY_TOGGLE ; TOGGLE
	event OnSelectST() 
		Int toggle = Math.LogicalXor( 1, StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusQueenBody" )   )
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenBody", toggle as Int )

		If (toggle ==1)
			Debug.MessageBox("Infecting player with Chaurus Queen Body")
			kPlayer.SendModEvent("SLPInfectChaurusQueenBody")
		else
			Debug.MessageBox("Curing player from Chaurus Queen Body")
			kPlayer.SendModEvent("SLPCureChaurusQueenBody")
		Endif

		SetToggleOptionValueST( toggle as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenBody", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Manually Infect/Cure Chaurus Queen Body for roleplay or testing purposes.")
	endEvent

endState



; AddSliderOptionST("STATE_CHAURUSQUEEN_BELLY","Node size", _bellyMaxChaurusQueen,"{0}")
state STATE_CHAURUSQUEEN_BELLY ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLP_bellyMaxChaurusQueen" ) )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( 1.0, 6.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxChaurusQueen", thisValue )
		SetSliderOptionValueST( thisValue,"{1}" )
		kPlayer.SendModEvent("SLPRefreshBodyShape")
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxChaurusQueen", 1.0 )
		SetSliderOptionValueST( 1.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Max size of belly node (for NiOverride compatiblity)")
	endEvent
endState

; AddSliderOptionST("STATE_MAX_BROODSPAWNS","Max number of spawns in your brood", _maxBroodSpawns ,"{0}")
state STATE_MAX_BROODSPAWNS ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetIntValue(kPlayer, "_SLP_maxBroodSpawns" ) as Float)
		SetSliderDialogDefaultValue( 10.0 )
		SetSliderDialogRange( 1.0, 20.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetIntValue(kPlayer, "_SLP_maxBroodSpawns", thisValue as Int )
		SetSliderOptionValueST( thisValue,"{1}" ) 
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLP_maxBroodSpawns", 1 )
		SetSliderOptionValueST( 10.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Max number of spawns in your Brood. Adjust depending on your memory and script lag.")
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
		fctUtils._resetParasiteSettings()
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
		StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxFaceHugger", 2.0 )
	Endif
	if (_chanceFaceHuggerGag==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleFaceHuggerGag", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceFaceHuggerGag", 30.0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxFaceHugger", 2.0 )
	Endif
	if (_chanceBarnacles==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleBarnacles", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceBarnacles", 30.0 )
	Endif
	if (_chanceSprigganRootGag==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootGag", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootGag", 10.0 )
	Endif
	if (_chanceSprigganRootArms==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootArms", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootArms", 20.0 )
	Endif
	if (_chanceSprigganRootFeet==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootFeet", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootFeet", 30.0 )
	Endif
	if (_chanceSprigganRootBody==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootBody", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootBody", 50.0 )
	Endif
	if (_chanceChaurusQueenVag==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenVag", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenVag", 100.0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxChaurusQueen", 2.0 )
	Endif
	if (_chanceChaurusQueenGag==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenGag", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenGag", 100.0 ) 
	Endif
	if (_chanceChaurusQueenSkin==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenSkin", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenSkin", 100.0 ) 
	Endif
	if (_chanceChaurusQueenArmor==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenArmor", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenArmor", 100.0 ) 
	Endif
	if (_chanceChaurusQueenBody==-1.0)
		StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusQueenBody", 0 )
		StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenBody", 100.0 ) 
	Endif 
	if (_maxBroodSpawns==-1.0) || (StorageUtil.GetIntValue(kPlayer, "_SLP_maxBroodSpawns" ) == 0 )
		StorageUtil.SetIntValue(kPlayer, "_SLP_maxBroodSpawns", 10 ) 
		_maxBroodSpawns = 10
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
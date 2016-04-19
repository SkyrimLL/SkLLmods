Scriptname SLS_QST_MCM extends SKI_ConfigBase  



; PRIVATE VARIABLES -------------------------------------------------------------------------------

; --- Version 1 ---

; State


bool		_toggleNPCRumors
bool		_toggleCurses

bool		_toggleFetish
float		_fetishMod
bool		_fetishDoomstone
bool		_fetishStat
bool		_fetishManual

bool		_fetishNone
bool		_fetishApprentice
bool		_fetishAtronach
bool		_fetishLady
bool		_fetishLord
bool		_fetishLover
bool		_fetishMage
bool		_fetishRitual
bool		_fetishSerpent
bool		_fetishShadow
bool		_fetishSteed
bool		_fetishThief
bool		_fetishTower
bool		_fetishWarrior

bool		_parasiteEgg
bool		_parasiteWorm
bool		_parasiteLeech
bool		_parasiteSpine
bool		_parasiteHip
bool		_parasiteTentacle
bool		_parasiteOoze
bool		_parasiteSlime
bool		_parasiteScaled
bool		_parasiteFuro
bool		_parasiteEstrus
bool		_parasiteSpriggan

Actor kPlayer
bool toggle

; INITIALIZATION ----------------------------------------------------------------------------------

; @overrides SKI_ConfigBase
event OnConfigInit()
	Pages = new string[3]
	Pages[0] = "Settings"
	Pages[1] = "Stories"
	Pages[2] = "Devious Stories"

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
		LoadCustomContent("SexLab_Stories/logo.dds", 120, 0)
		return
	else
		UnloadCustomContent()
	endIf

	kPlayer = Game.GetPlayer()
	; ObjectReference PlayerREF= PlayerAlias.GetReference()
	; Actor PlayerActor= PlayerAlias.GetReference() as Actor
	; ActorBase pActorBase = PlayerActor.GetActorBase()

	; Initialization
 	If (!StorageUtil.HasIntValue(kPlayer, "_SLS_toggleNPCRumors" ))
 		StorageUtil.SetIntValue(kPlayer, "_SLS_toggleNPCRumors", 1 )

		StorageUtil.SetIntValue(kPlayer, "_SLS_toggleFetish", 1 )
		StorageUtil.SetFloatValue(kPlayer, "_SLS_fetishMod", 30 )
 	EndIf

 	_toggleNPCRumors = StorageUtil.GetIntValue(kPlayer, "_SLS_toggleNPCRumors" )
	; _toggleCurses

	_toggleFetish = StorageUtil.GetIntValue(kPlayer, "_SLS_toggleFetish" )
	_fetishMod = StorageUtil.GetFloatValue(kPlayer, "_SLS_fetishMod" )
	; _fetishDoomstone
	; _fetishStat
	; _fetishManual

	; _fetishNone
	; _fetishApprentice
	; _fetishAtronach
	; _fetishLady
	; _fetishLord
	; _fetishLover
	; _fetishMage
	; _fetishRitual
	; _fetishSerpent
	; _fetishShadow
	; _fetishSteed
	; _fetishThief
	; _fetishTower
	; _fetishWarrior

	; _parasiteEgg
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



	If (a_page == "Settings")
		SetCursorFillMode(TOP_TO_BOTTOM)
	
		AddHeaderOption(" Rumors")
		; 	
		AddToggleOptionST("STATE_NPC_RUMORS","NPC rumors ON/OFF", _toggleNPCRumors as Float)
		AddHeaderOption(" Curses")
		; 	
		; AddToggleOptionST("STATE_CURSES","Polymorph curses ON/OFF", _toggleCurses as Float, OPTION_FLAG_DISABLED)

		SetCursorPosition(1)
		AddHeaderOption(" Doomstone Fetish")

		;  
		AddToggleOptionST("STATE_FETISH","Fetish effect ON/OFF", _toggleFetish as Float)
		AddSliderOptionST("STATE_FETISH_MOD","Fetish arousal modifier", _fetishMod,"{0} %")
			
	 	AddEmptyOption()
		;   
		; AddToggleOptionST("STATE_FETISH_DOOMSTONE","Get effect from Doomstone", _fetishDoomstone as Float, OPTION_FLAG_DISABLED)
		;  
		; AddToggleOptionST("STATE_FETISH_STAT","Get effect based on stats", _fetishStat as Float, OPTION_FLAG_DISABLED)
		;  
		; AddToggleOptionST("STATE_FETISH_MANUAL","Get effect manually", _fetishManual as Float, OPTION_FLAG_DISABLED)

	 	AddEmptyOption()
		;  0- No fetish
		; AddToggleOptionST("STATE_FETISH_NONE","No Fetish", _fetishNone as Float, OPTION_FLAG_DISABLED)

		;  1- The Apprentice Stone - Craft / Hitting / Dom
		; AddToggleOptionST("STATE_FETISH_APPRENTICE","The Apprentice", _fetishApprentice as Float, OPTION_FLAG_DISABLED)

		;  2- The Atronach Stone - Killing monsters
		; AddToggleOptionST("STATE_FETISH_ATTRONACH","The Atronach", _fetishAtronach as Float, OPTION_FLAG_DISABLED)

		;  3- The Lady Stone - Wearing Jewelry
		; AddToggleOptionST("STATE_FETISH_LADY","The Lady", _fetishLady as Float, OPTION_FLAG_DISABLED)

		;  4- The Lord Stone - Wearing Armor
		; AddToggleOptionST("STATE_FETISH_LORD","The Lord", _fetishLord as Float, OPTION_FLAG_DISABLED)

		;  5- The Lover Stone - Being Nude / Sex
		; AddToggleOptionST("STATE_FETISH_LOVER","The Lover", _fetishLover as Float, OPTION_FLAG_DISABLED)

		;  6- The Mage Stone - Using magic
		; AddToggleOptionST("STATE_FETISH_MAGE","The Mage", _fetishMage as Float, OPTION_FLAG_DISABLED)

		;  7- The Ritual Stone - Specific NPC / spouse
		; AddToggleOptionST("STATE_FETISH_RITUAL","The Ritual", _fetishRitual as Float, OPTION_FLAG_DISABLED)

		;  8- The Serpent Stone - Killing animals
		; AddToggleOptionST("STATE_FETISH_SERPENT","The Serpent", _fetishSerpent as Float, OPTION_FLAG_DISABLED)

		;  9- The Shadow Stone - Killing humans
		; AddToggleOptionST("STATE_FETISH_SHADOW","The Shadow", _fetishShadow as Float, OPTION_FLAG_DISABLED)

		; 10- The Steed Stone - Bestiality
		; AddToggleOptionST("STATE_FETISH_STEED","The Steed", _fetishSteed as Float, OPTION_FLAG_DISABLED)

		; 11- The Thief Stone - Stealing
		; AddToggleOptionST("STATE_FETISH_THIEF","The Thief", _fetishThief as Float, OPTION_FLAG_DISABLED)

		; 12- The Tower Stone - Wearing leather / being hit / sub
		; AddToggleOptionST("STATE_FETISH_TOWER","The Tower", _fetishTower as Float, OPTION_FLAG_DISABLED)

		; 13- The Warrior Stone - Using weapons 
		; AddToggleOptionST("STATE_FETISH_WARRIOR","The Warrior", _fetishWarrior as Float, OPTION_FLAG_DISABLED)

	ElseIf (a_page == "Stories")
		SetCursorFillMode(TOP_TO_BOTTOM)
	
		AddHeaderOption(" The Red Wave")
		; AddToggleOptionST("STATE_START_REDWAVE","Player starting quest", _startRedWave as Float, OPTION_FLAG_DISABLED)

		AddHeaderOption(" E.L.L.E SexBot")
		; AddToggleOptionST("STATE_START_SEXBOT","Player starting quest", _startSexBot as Float, OPTION_FLAG_DISABLED)

		AddHeaderOption(" The Living Wonder")

		AddHeaderOption(" The Family")

		SetCursorPosition(1)
		AddHeaderOption(" The Twins")

		AddHeaderOption(" The Old Gods")

	ElseIf (a_page == "Devious Stories")
		SetCursorFillMode(TOP_TO_BOTTOM)
	
		AddHeaderOption(" The Milk Farm")
		; AddToggleOptionST("STATE_START_MILKFARM","Player starting quest", _startMilkFarm as Float, OPTION_FLAG_DISABLED)

		AddHeaderOption(" The Pet")
		; AddToggleOptionST("STATE_START_PET","Player starting quest", _startPet as Float, OPTION_FLAG_DISABLED)

		SetCursorPosition(1)
		AddHeaderOption(" The Brood Maiden")
		; AddToggleOptionST("STATE_START_CHAURUS","Player starting quest", _startChaurus as Float, OPTION_FLAG_DISABLED)

		AddHeaderOption(" The Chaurus Queen")

		AddHeaderOption(" Parasites")

		;   
		; AddToggleOptionST("STATE_PARASITE_EGG","Spider Egg", _parasiteEgg as Float, OPTION_FLAG_DISABLED)
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

		
 

	endIf
endEvent

; AddToggleOptionST("STATE_NPC_RUMORS","NPC rumors ON/OFF", _toggleNPCRumors as Float, OPTION_FLAG_DISABLED)
state STATE_NPC_RUMORS ; TOGGLE
	event OnSelectST() 
		toggle = Math.LogicalXor( 1, StorageUtil.GetIntValue(kPlayer, "_SLS_toggleNPCRumors" )  )
		StorageUtil.SetIntValue(kPlayer, "_SLS_toggleNPCRumors", toggle as Int )
		SetToggleOptionValueST( toggle )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLS_toggleNPCRumors", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Enable/Disable the stories/rumors topic for most NPCs (takes effect after changing location).")
	endEvent

endState
; AddToggleOptionST("STATE_FETISH","Fetish effect ON/OFF", _toggleFetish as Float, OPTION_FLAG_DISABLED)
state STATE_FETISH ; TOGGLE
	event OnSelectST() 
		toggle = Math.LogicalXor( 1, StorageUtil.GetIntValue(kPlayer, "_SLS_toggleFetish" )   )
		StorageUtil.SetIntValue(kPlayer, "_SLS_toggleFetish", toggle as Int )
		SetToggleOptionValueST( toggle )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		StorageUtil.SetIntValue(kPlayer, "_SLS_toggleFetish", 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Enable/Disable the fetish system (arousal based on certain actions.. takes effect after changing location).")
	endEvent

endState
; AddToggleOptionST("STATE_FETISH_MOD","Fetish arousal modifier", _fetishMod as Float, OPTION_FLAG_DISABLED)
state STATE_FETISH_MOD ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLS_fetishMod" ) )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLS_fetishMod", thisValue )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLS_fetishMod", 30.0 )
		SetSliderOptionValueST( 30.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Amplitude modifier for the effect of the Fetish on the player's arousal.")
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
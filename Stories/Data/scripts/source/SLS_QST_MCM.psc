Scriptname SLS_QST_MCM extends SKI_ConfigBase  

ObjectReference Property inventoryChestREF Auto
ObjectReference Property inventoryKeysREF Auto

Armor Property setInventoryCloth Auto
Armor Property setInventoryShoes Auto
Weapon Property setInventoryDagger Auto


; PRIVATE VARIABLES -------------------------------------------------------------------------------

; String                   Property NINODE_SCHLONG	 	= "NPC Genitals01 [Gen01]" AutoReadOnly
string                   Property SLS_KEY               = "SexLab-Stories.esp" AutoReadOnly
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
Float                    Property NINODE_MAX_SCALE      = 4.0 AutoReadOnly
Float                    Property NINODE_MIN_SCALE      = 0.1 AutoReadOnly

; NiOverride version data
int                      Property SKEE_VERSION  = 1 AutoReadOnly
int                      Property NIOVERRIDE_VERSION    = 4 AutoReadOnly
int                      Property NIOVERRIDE_SCRIPT_VERSION = 4 AutoReadOnly

; XPMSE version data
float                    Property XPMSE_VERSION         = 3.0 AutoReadOnly
float                    Property XPMSELIB_VERSION      = 3.0 AutoReadOnly

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

Float 		_breastSexBot
Float 		_buttSexBot
Float 		_weightSexBot

Float 		_breastMaxMilkFarm
bool 		_clearInventory
bool 		_setInventory

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

	Form SexBotForm = StorageUtil.GetFormValue(none, "_SLS_fSexBot")
	Actor SexBotActor = SexBotForm as Actor

	kPlayer = Game.GetPlayer()
	; ObjectReference PlayerREF= PlayerAlias.GetReference()
	; Actor PlayerActor= PlayerAlias.GetReference() as Actor
	; ActorBase pActorBase = PlayerActor.GetActorBase()

	; Initialization
	If (StorageUtil.GetIntValue(none, "_SLS_initMCM" )!=1)
		StorageUtil.SetIntValue(none, "_SLS_initMCM", 1 )

 		StorageUtil.SetIntValue(kPlayer, "_SLS_toggleNPCRumors", 1 )

		StorageUtil.SetIntValue(kPlayer, "_SLS_toggleFetish", 1 )
		StorageUtil.SetFloatValue(kPlayer, "_SLS_fetishMod", 30 )

		StorageUtil.SetFloatValue(kPlayer, "_SLS_breastMaxMilkFarm", 2.0  )
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

	_breastMaxMilkFarm = StorageUtil.GetFloatValue(kPlayer, "_SLS_breastMaxMilkFarm" )

	_breastSexBot = StorageUtil.GetFloatValue(kPlayer, "_SLS_breastSexBot" )
	_buttSexBot = StorageUtil.GetFloatValue(kPlayer, "_SLS_buttSexBot" )
	_weightSexBot = StorageUtil.GetFloatValue(kPlayer, "_SLS_weightSexBot" )

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

		AddHeaderOption(" Role Play Utilities")
		AddToggleOptionST("STATE_CLEARINVENTORY","Clear inventory", _clearInventory as Float)
		AddToggleOptionST("STATE_SETINVENTORY","Set inventory", _setInventory as Float)

	ElseIf (a_page == "Stories")
		SetCursorFillMode(TOP_TO_BOTTOM)
	
		; AddHeaderOption(" Placeholder - No option yet")
		; AddHeaderOption(" The Red Wave")
		; AddToggleOptionST("STATE_REDWAVE_START","Player starting quest", _startRedWave as Float, OPTION_FLAG_DISABLED)

		AddHeaderOption(" E.L.L.E SexBot")
		if (StorageUtil.GetIntValue(SexBotActor, "_SLS_iSexBotRepairLevel")>=4)
			AddSliderOptionST("STATE_SEXBOT_BREAST","SexBot breast size", _breastSexBot,"{1}")
			AddSliderOptionST("STATE_SEXBOT_BUTT","SexBot butt size", _buttSexBot,"{1}")
			AddSliderOptionST("STATE_SEXBOT_WEIGHT","SexBot weight", _weightSexBot,"{1}")
		else
			AddSliderOptionST("STATE_SEXBOT_BREAST","SexBot breast size", _breastSexBot,"{1}", OPTION_FLAG_DISABLED)
			AddSliderOptionST("STATE_SEXBOT_BUTT","SexBot butt size", _buttSexBot,"{1}", OPTION_FLAG_DISABLED)
			AddSliderOptionST("STATE_SEXBOT_WEIGHT","SexBot weight", _weightSexBot,"{1}", OPTION_FLAG_DISABLED)
		endif
		; AddToggleOptionST("STATE_SEXBOT_START","Player starting quest", _startSexBot as Float, OPTION_FLAG_DISABLED)

		; AddHeaderOption(" The Living Wonder")

		; AddHeaderOption(" The Family")

		SetCursorPosition(1)
		; AddHeaderOption(" The Twins")

		; AddHeaderOption(" The Old Gods")

		; AddHeaderOption(" The Brood Maiden")
		; AddToggleOptionST("STATE_START_CHAURUS","Player starting quest", _startChaurus as Float, OPTION_FLAG_DISABLED)

		; AddHeaderOption(" The Chaurus Queen")
		
	ElseIf (a_page == "Devious Stories")
		SetCursorFillMode(TOP_TO_BOTTOM)
	
		; AddHeaderOption(" Placeholder - No option yet")

		AddHeaderOption(" The Milk Farm")
		AddSliderOptionST("STATE_MILKFARM_BREAST","Max breast size", _breastMaxMilkFarm,"{1}")
		; AddToggleOptionST("STATE_MILKFARM_START","Player starting quest", _startMilkFarm as Float, OPTION_FLAG_DISABLED)
    

		SetCursorPosition(1)
		AddHeaderOption(" Last Cow Milked info")

		ObjectReference kActorRef = StorageUtil.GetFormValue( none , "_SD_iLastCowMilked")	as ObjectReference
		Actor kActor = kActorRef	as Actor

		AddTextOption(" Cow (actor): " + kActor, "", OPTION_FLAG_DISABLED)
		AddTextOption(" Cow (name): " +  kActor.GetBaseObject().GetName(), "", OPTION_FLAG_DISABLED) 

		if (kActorRef != None)
			AddTextOption(" _SLH_iLactating: " + StorageUtil.GetIntValue( kActor, "_SLH_iLactating")  as Int, "", OPTION_FLAG_DISABLED)
			; AddTextOption(" _SLH_iProlactinLevel: " + StorageUtil.GetIntValue( kActor , "_SLH_iProlactinLevel")  as Int, "", OPTION_FLAG_DISABLED)
			AddTextOption(" _SLH_fHormoneLactation: " + StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactation")  as Int, "", OPTION_FLAG_DISABLED)
			AddTextOption(" _SLH_fLactationThreshold: " + StorageUtil.GetFloatValue( kActor , "_SLH_fLactationThreshold")  as Int, "", OPTION_FLAG_DISABLED)
			AddTextOption(" _SLH_fHormoneLactationCooldown: " + StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactationCooldown")  as Int, "", OPTION_FLAG_DISABLED)
 
			AddTextOption(" _SLH_iMilkLevel: " + StorageUtil.GetIntValue( kActor , "_SLH_iMilkLevel")  as Int, "", OPTION_FLAG_DISABLED)
			AddTextOption(" _SLH_isPregnant: " + StorageUtil.GetIntValue( kActor , "_SLH_isPregnant")  as Int, "", OPTION_FLAG_DISABLED) 

			AddHeaderOption(" Cow Enrollment ") 
			AddTextOption(" _SLH_iMilkCow: " + StorageUtil.GetIntValue( kActor , "_SLH_iMilkCow")  as Int, "", OPTION_FLAG_DISABLED)

			Faction HucowsFaction   = Game.GetFormFromFile(0x439E6 , "SexLab-StoriesDevious.esp") as Faction
			Faction MilkFarmCowsFaction   = Game.GetFormFromFile(0x439E7 , "SexLab-StoriesDevious.esp") as Faction
 
			AddTextOption(" In HucowsList: " + kActor.IsInFaction(HucowsFaction)  , "", OPTION_FLAG_DISABLED)	
			 
			AddTextOption(" In MilkFarmList: " + kActor.IsInFaction(MilkFarmCowsFaction) , "", OPTION_FLAG_DISABLED)	

			AddHeaderOption(" Milk Production (Actor)") 
			AddTextOption(" _SLH_iMilkProduced: " + StorageUtil.GetIntValue( kActor , "_SLH_iMilkProduced")  as Int, "", OPTION_FLAG_DISABLED)
			AddTextOption(" _SLH_iDivineMilkProduced: " + StorageUtil.GetIntValue( kActor , "_SLH_iDivineMilkProduced")  as Int, "", OPTION_FLAG_DISABLED)

			AddHeaderOption(" Milk Production (Player)") 
			AddTextOption(" _SLH_iMilkProduced: " + StorageUtil.GetIntValue( kPlayer , "_SLH_iMilkProduced")  as Int, "", OPTION_FLAG_DISABLED)
			AddTextOption(" _SLH_iDivineMilkProduced: " + StorageUtil.GetIntValue( kPlayer , "_SLH_iDivineMilkProduced")  as Int, "", OPTION_FLAG_DISABLED)

			AddHeaderOption(" Milk Production (Total)") 
			AddTextOption(" _SLH_iMilkProducedTotal: " + StorageUtil.GetIntValue( kPlayer , "_SLH_iMilkProducedTotal")  as Int, "", OPTION_FLAG_DISABLED)
			AddTextOption(" _SLH_iDivineMilkProducedTotal: " + StorageUtil.GetIntValue( kPlayer , "_SLH_iDivineMilkProducedTotal")  as Int, "", OPTION_FLAG_DISABLED)

					
		else
			AddTextOption(" Cow not initialized. " , "", OPTION_FLAG_DISABLED)	 
			AddTextOption(" Milk an NPC first" , "", OPTION_FLAG_DISABLED)		
			AddTextOption(" or get yourself milked. " , "", OPTION_FLAG_DISABLED)		
		endif
		; AddHeaderOption(" The Pet")


 
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
		SetInfoText("Enable/Disable the fetish system (arousal based on certain actions.. takes effect after reloading).")
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
; AddToggleOptionST("STATE_SEXBOT_BREAST","Max breast size", _breastSexBot  as Float, OPTION_FLAG_DISABLED)
state STATE_SEXBOT_BREAST ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLS_breastSexBot"  ) )
		SetSliderDialogDefaultValue( 2.0 )
		SetSliderDialogRange( 0.0, 4.0 )
		SetSliderDialogInterval(0.1)
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLS_breastSexBot", thisValue )
		SetSliderOptionValueST( thisValue,"{1}" )
		updateSexBotBreast(thisValue)
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLS_breastSexBot", 2.0 )
		SetSliderOptionValueST( 2.0,"{1}" )
		updateSexBotBreast(2.0)
	endEvent

	event OnHighlightST()
		SetInfoText("Breast size for E.L.L.E (for NiOverride compatiblity). Only available after unlocking four E.L.L.E data cubes.")
	endEvent
endState

; AddToggleOptionST("STATE_SEXBOT_BUTT","Max breast size", _buttSexBot  as Float, OPTION_FLAG_DISABLED)
state STATE_SEXBOT_BUTT ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLS_buttSexBot"  ) )
		SetSliderDialogDefaultValue( 2.0 )
		SetSliderDialogRange( 0.0, 4.0 )
		SetSliderDialogInterval(0.1)
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLS_buttSexBot", thisValue )
		SetSliderOptionValueST( thisValue,"{1}" )
		updateSexBotButt(thisValue)
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLS_buttSexBot", 2.0 )
		SetSliderOptionValueST( 2.0,"{1}" )
		updateSexBotButt(2.0)
	endEvent

	event OnHighlightST()
		SetInfoText("Butt size for E.L.L.E (for NiOverride compatiblity). Only available after unlocking four E.L.L.E data cubes.")
	endEvent
endState

; AddToggleOptionST("STATE_SEXBOT_BUTT","Max breast size", _buttSexBot  as Float, OPTION_FLAG_DISABLED)
state STATE_SEXBOT_WEIGHT ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLS_weightSexBot"  ) )
		SetSliderDialogDefaultValue( 100.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLS_weightSexBot", thisValue )
		SetSliderOptionValueST( thisValue,"{1}" )
		updateSexBotWeight(thisValue)
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLS_weightSexBot", 100.0 )
		SetSliderOptionValueST( 100.0,"{1}" )
		updateSexBotWeight(100.0)
	endEvent

	event OnHighlightST()
		SetInfoText("Weight for E.L.L.E. Only available after unlocking four E.L.L.E data cubes.")
	endEvent
endState


; AddToggleOptionST("STATE_MILKFARM_BREAST","Max breast size", _breastMaxMilkFarm  as Float, OPTION_FLAG_DISABLED)
state STATE_MILKFARM_BREAST ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_SLS_breastMaxMilkFarm"  ) )
		SetSliderDialogDefaultValue( 2.0 )
		SetSliderDialogRange( 0.0, 4.0 )
		SetSliderDialogInterval(0.1)
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_SLS_breastMaxMilkFarm", thisValue )
		SetSliderOptionValueST( thisValue,"{1}" )
		kPlayer.SendModEvent("_SLSDDi_UpdateCow")
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_SLS_breastMaxMilkFarm", 2.0 )
		SetSliderOptionValueST( 2.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Max size of breast node while lactation is ON (for NiOverride compatiblity).")
	endEvent
endState
; AddToggleOptionST("STATE_CLEARINVENTORY","Clear inventory", _clearInventory as Float, OPTION_FLAG_DISABLED)
state STATE_CLEARINVENTORY ; TOGGLE
	event OnSelectST() 
		_clearInventory = True 
		SetToggleOptionValueST( _clearInventory )

		limitedRemoveAllKeys( akContainer=kPlayer, akTransferTo = inventoryKeysREF, abSilent = True, akIgnored = None)
		kPlayer.RemoveAllItems(akTransferTo = inventoryChestREF, abKeepOwnership = True)


		ForcePageReset()
	endEvent

	event OnDefaultST()
		_clearInventory = false
		SetToggleOptionValueST( _clearInventory )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Transfers player inventory in hidden chest (in sewers under abandonned prison)")
	endEvent

endState
; AddToggleOptionST("STATE_SETINVENTORY","Set inventory", _setInventory as Float, OPTION_FLAG_DISABLED)
state STATE_SETINVENTORY ; TOGGLE
	event OnSelectST() 
		_setInventory = True 
		SetToggleOptionValueST( _setInventory )

		kPlayer.AddItem(setInventoryCloth, 1)
		kPlayer.EquipItem(setInventoryCloth)
		kPlayer.AddItem(setInventoryShoes, 1)
		kPlayer.EquipItem(setInventoryShoes)
		kPlayer.AddItem(setInventoryDagger, 1)

		ForcePageReset()
	endEvent

	event OnDefaultST()
		_setInventory = false
		SetToggleOptionValueST( _setInventory )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Adds default items to player inventory (common clothes, boots and dagger)")
	endEvent

endState

Function limitedRemoveAllKeys ( ObjectReference akContainer, ObjectReference akTransferTo = None, Bool abSilent = True, FormList akIgnored = None )
	Int iFormIndex = 0
	Bool bDeviousDeviceEquipped = False
	Actor kActor = akContainer as Actor

	; Send all items in Equipment to akTransferTo

	Int[] uiTypes = New Int[12]
	uiTypes[0] = 23; kScrollItem = 23
	uiTypes[1] = 26; kArmor = 26
	uiTypes[2] = 27; kBook = 27
	uiTypes[3] = 30; kIngredient = 30
	uiTypes[4] = 32; kMisc = 32
	uiTypes[6] = 41; kWeapon = 41
	uiTypes[7] = 42; kAmmo = 42
	uiTypes[8] = 45; kKey = 45
	uiTypes[9] = 46; kPotion = 46
	uiTypes[10] = 48; kNote = 48
	uiTypes[11] = 52; kSoulGem = 52

	iFormIndex = akContainer.GetNumItems()

	While ( iFormIndex > 0 )
		iFormIndex -= 1
		Form kForm = akContainer.GetNthForm(iFormIndex)

		If ( kForm && akIgnored && akIgnored.HasForm( kForm ) ) || (uiTypes.Find( kForm.GetType() ) == 26)
			; continue
		ElseIf ( kForm &&  uiTypes.Find( kForm.GetType() ) > -1 ) 
			if (kForm.GetType()==45) ; keys only
				akContainer.RemoveItem(kForm, akContainer.GetItemCount( kForm ), abSilent, akTransferTo)
			endif
		EndIf
	EndWhile
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

bool Function CheckXPMSERequirements(Actor akActor, bool isFemale)
	return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && (SKSE.GetPluginVersion("SKEE") >= SKEE_VERSION && SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION) && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction

Function updateSexBotBreast(Float fBreast)
	Form SexBotForm = StorageUtil.GetFormValue(none, "_SLS_fSexBot")
	Actor SexBotActor = SexBotForm as Actor
	Bool bEnableBreast  = NetImmerse.HasNode(SexBotActor, "NPC L Breast", false)

	Bool bBreastEnabled     = ( bEnableBreast as bool )
	Bool isNiOInstalled = CheckXPMSERequirements(SexBotActor, True)

	if ( bBreastEnabled && isNiOInstalled  )

		XPMSELib.SetNodeScale(SexBotActor, true, NINODE_LEFT_BREAST, fBreast, SLS_KEY)
		XPMSELib.SetNodeScale(SexBotActor, true, NINODE_RIGHT_BREAST, fBreast, SLS_KEY)
		
	EndIf
EndFunction

Function updateSexBotButt(Float fButt)
	Form SexBotForm = StorageUtil.GetFormValue(none, "_SLS_fSexBot")
	Actor SexBotActor = SexBotForm as Actor
	Bool bEnableButt  = NetImmerse.HasNode(SexBotActor, "NPC L Butt", false)

	Bool bButtEnabled     = ( bButtEnabled as bool )
	Bool isNiOInstalled = CheckXPMSERequirements(SexBotActor, True)

	if ( bButtEnabled && isNiOInstalled  )

		XPMSELib.SetNodeScale(SexBotActor, true, NINODE_LEFT_BUTT, fButt, SLS_KEY)
		XPMSELib.SetNodeScale(SexBotActor, true, NINODE_RIGHT_BUTT, fButt, SLS_KEY)
		
	EndIf
EndFunction

Function updateSexBotWeight(Float fWeight)
	Form SexBotForm = StorageUtil.GetFormValue(none, "_SLS_fSexBot")
	Actor SexBotActor = SexBotForm as Actor
	ObjectReference SexBotREF= SexBotActor as ObjectReference
	ActorBase SexBotActorBase = SexBotActor.GetActorBase()
 
	Float fWeightOrig = SexBotActorBase.GetWeight()

	if (fWeightOrig != fWeight) 
		Float NeckDelta = (fWeightOrig / 100) - (fWeight / 100) ;Work out the neckdelta.

		; debug.Trace(" Old weight: " + fWeightOrig)
		; debug.Trace(" New weight: " + fWeight)
		; debug.Trace(" NeckDelta: " + NeckDelta)
	 
		SexBotActorBase.SetWeight(fWeight) 
		SexBotActor.UpdateWeight(NeckDelta) ;Apply the changes.
 
	EndIf
EndFunction
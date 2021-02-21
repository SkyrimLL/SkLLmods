Scriptname SLSDDi_PlayerREF extends ReferenceAlias  

ReferenceAlias Property PlayerAlias  Auto  
SexLabFramework     property SexLab Auto
zadLibs Property libs Auto
slaUtilScr Property slaUtil  Auto  

Potion Property Milk Auto
Potion Property DivineMilk Auto

GlobalVariable Property GV_MilkLevel  Auto  
GlobalVariable Property GV_ProlactinLevel  Auto  
GlobalVariable Property MilkProduced  Auto  
GlobalVariable Property MilkProducedTotal  Auto  

Keyword Property SLSD_CowHarness Auto
Keyword Property SLSD_CowMilker Auto
Keyword Property SLSD_MilkOMatic  Auto  
Keyword Property SLSD_MilkOMatic2  Auto  

SPELL Property SLSD_MilkOMaticSpell  Auto  
SPELL Property SLSD_MilkOMaticSpell2  Auto  
SPELL Property ApplySweatFX  Auto

ObjectReference Property MilkOMaticSoundFX  Auto  
ObjectReference Property LeonaraRef  Auto  

SLSDDi_QST_CowLife Property CowLife Auto

Bool isNiOInstalled = false
Bool Property isSlifInstalled Auto

int daysPassed
int iGameDateLastCheck = -1
int iDaysSinceLastCheck

; NiOverride version data
int                      Property NIOVERRIDE_VERSION    = 4 AutoReadOnly
int                      Property NIOVERRIDE_SCRIPT_VERSION = 4 AutoReadOnly

; XPMSE version data
float                    Property XPMSE_VERSION         = 3.0 AutoReadOnly
float                    Property XPMSELIB_VERSION      = 3.0 AutoReadOnly


Event OnInit()
	_maintenance()

EndEvent

Event OnPlayerLoadGame()
	_maintenance()

EndEvent

Function _maintenance()
 	Actor PlayerActor= Game.GetPlayer() as Actor
 	ActorBase pActorBase = PlayerActor.GetActorBase()

	if (!isNiOInstalled)
		isNiOInstalled = CheckXPMSERequirements(PlayerActor, pActorBase.GetSex())
		StorageUtil.SetIntValue(none, "_SLH_NiNodeOverrideON", isNiOInstalled as Int)
	EndIf



	int idx = Game.GetModCount()
	string modName = ""
	while idx > 0
		idx -= 1
		modName = Game.GetModName(idx)
		if modName == "SexLab Inflation Framework.esp"
			isSlifInstalled = true
			StorageUtil.SetIntValue(none, "_SLH_SlifON", isSlifInstalled as Int)

		elseif modName == "Campfire.esm"
			Form Flame = Game.GetFormFromFile(0xA50C , "SexLab-StoriesDevious.esp")
			If Flame 
				; debug.messagebox("[SLSDDi] Flame (pet) found: " + Flame)
				FormList CampHeatSourcesAll = Game.GetFormFromFile(0x28F06, "Campfire.esm") as FormList
				If CampHeatSourcesAll && !CampHeatSourcesAll.HasForm(Flame)
					CampHeatSourcesAll.AddForm(Flame)
					Debug.Trace("SexLab Stories Devious: Adding Flame to Campfire:CampHeatSourcesAll")
				else
					Debug.Trace("SexLab Stories Devious: Flame is already on Campfire:CampHeatSourcesAll")
				EndIf
				FormList CampHeatSourcesFire = Game.GetFormFromFile(0x2899F, "Campfire.esm") as FormList
				If CampHeatSourcesFire && !CampHeatSourcesFire.HasForm(Flame)
					CampHeatSourcesFire.AddForm(Flame)
					Debug.Trace("SexLab Stories Devious: Adding Flame to Campfire:CampHeatSourcesFire")
				else
					Debug.Trace("SexLab Stories Devious: Flame is already on Campfire:CampHeatSourcesFire")
				EndIf
				FormList CampHeatSourcesFireMedium = Game.GetFormFromFile(0x28F03, "Campfire.esm") as FormList
				If CampHeatSourcesFireMedium && !CampHeatSourcesFireMedium.HasForm(Flame)
					CampHeatSourcesFireMedium.AddForm(Flame)
					Debug.Trace("SexLab Stories Devious: Adding Flame to Campfire:CampHeatSourcesFireMedium")
				else
					Debug.Trace("SexLab Stories Devious: Flame is already on Campfire:CampHeatSourcesFireMedium")
				EndIf
			else
				; debug.messagebox("[SLSDDi] Flame (pet) not found")
			EndIf

		endif
	endwhile

 

	If (!StorageUtil.HasIntValue(none, "_SLS_iStoriesDevious"))
		StorageUtil.SetIntValue(none, "_SLS_iStoriesDevious", 1)
	EndIf

	UnregisterForAllModEvents()
	Debug.Trace("SexLab Stories Devious: Reset SexLab events")
	RegisterForModEvent("AnimationStart", "OnSexLabStart")
	RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")

	RegisterForModEvent("_SLSDDi_UpdateCow", "OnUpdateCow")
	RegisterForModEvent("_SLSDDi_UpdateCowList", "OnUpdateCowList")
	RegisterForModEvent("_SLSDDi_GropeCow", "OnGropeCow")
	RegisterForModEvent("_SLSDDi_DrinkCow", "OnDrinkCow")
	RegisterForModEvent("_SLSDDi_EquipMilkingDevice", "OnEquipMilkingDevice")
	RegisterForModEvent("_SLSDDi_RemoveMilkingDevice", "OnRemoveMilkingDevice")

	If (StorageUtil.GetIntValue(none, "_SLH_iHormones") != 1)
		; Hormones is not installed - register fallback mod event
		RegisterForModEvent("SLHModHormone",    "OnModHormoneEvent")

	endif

	; Update cows on Load
	; CowLife.InitBusiness()  ; comment out on release
	CowLife.updateAllCows("")
	CowLife.UpdateBalimundMerchantChest()

	RegisterForSingleUpdate(10)
EndFunction



Event OnUpdate()
 	Actor PlayerActor= Game.GetPlayer() as Actor

 	daysPassed = Game.QueryStat("Days Passed")

 	; Initial values
 	if (iGameDateLastCheck == -1)
 		iGameDateLastCheck = daysPassed
 	endIf
 
	iDaysSinceLastCheck = (daysPassed - iGameDateLastCheck ) as Int

	If (iDaysSinceLastCheck > 0)
		CowLife.updateAllCows("NewDay")
		CowLife.UpdateBalimundMerchantChest()
	endIf

	iGameDateLastCheck = daysPassed  

	RegisterForSingleUpdate(10)
EndEvent

Event OnModHormoneEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf

 	if (_args == "")
 		_args = "Lactation"
 	EndIf

	debug.Trace("[SLSDDi] Receiving 'mod hormone level' event. Actor: " + kActor )

	; fctHormones.modHormoneLevel(kActor, _args, _argc)
	Float fHormoneLevel = StorageUtil.GetFloatValue( kActor , "_SLH_fHormone" + _args)  + _argc

	if (fHormoneLevel > 100.0)
		fHormoneLevel = 100.0
	elseif (fHormoneLevel < 0.0)
		fHormoneLevel = 0.0
	endif

	StorageUtil.SetFloatValue( kActor , "_SLH_fHormone" + _args, fHormoneLevel)

EndEvent

Event OnUpdateCow(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	String sUpdateMode = _args
 	int iNumberBottles = _argc as Int

 	CowLife.updateCowStatus(kActor, sUpdateMode, iNumberBottles)

EndEvent

Event OnUpdateCowList(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor 

 	CowLife.updateAllCows("")

EndEvent

Event OnGropeCow(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer() as Actor
 	String sPlayerCow = _args
	Float fLactationHormoneMod = 0.1

	If  (SexLab.ValidateActor( kPlayer ) > 0) &&  (SexLab.ValidateActor(kActor) > 0) 
		actor[] sexActors = new actor[2]
		If (sPlayerCow == "PlayerCow")
			sexActors[0] = kPlayer
			sexActors[1] = kActor
		else
			sexActors[0] = kActor
			sexActors[1] = kPlayer
		endif

		sslBaseAnimation[] anims
		anims = new sslBaseAnimation[1]
		Int rnum = Utility.RandomInt(0,100)

		if (rnum > 50)
			anims[0] = SexLab.GetAnimationByName("3J Straight Breastfeeding")
		else
			anims[0] = SexLab.GetAnimationByName("3J Lesbian Breastfeeding")
		endif

		if (anims[0] ==None)
			anims = SexLab.GetAnimationsByTags(2, "Breast","Estrus,Dwemer")
		endif

		SexLab.StartSex(sexActors, anims)
	EndIf

	; CowLife.updateCowStatus(kPlayer,"")
	; CowLife.updateCowStatus(kActor,"")

EndEvent

Event OnDrinkCow(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer() as Actor
 	String sPlayerCow = _args
	Float fLactationHormoneMod = 0.1

	; Reduce levels from drinking
	If (sPlayerCow == "PlayerCow")

		SLSD_MilkOMaticSpell.Remotecast(kActor as ObjectReference ,kActor, kActor as ObjectReference)

	Else

		SLSD_MilkOMaticSpell.Remotecast(kPlayer as ObjectReference ,kPlayer, kPlayer as ObjectReference)
 
	Endif


	If  (SexLab.ValidateActor( kPlayer ) > 0) &&  (SexLab.ValidateActor(kActor) > 0) 
		actor[] sexActors = new actor[2]
		If (sPlayerCow == "PlayerCow")
			sexActors[0] = kPlayer
			sexActors[1] = kActor
		else
			sexActors[0] = kActor
			sexActors[1] = kPlayer
		endif

		sslBaseAnimation[] anims
		anims = new sslBaseAnimation[1]
		Int rnum = Utility.RandomInt(0,100)

		if (rnum > 50)
			anims[0] = SexLab.GetAnimationByName("3J Straight Breastfeeding")
		else
			anims[0] = SexLab.GetAnimationByName("3J Lesbian Breastfeeding")
		endif

		if (anims[0] ==None)
			anims = SexLab.GetAnimationsByTags(2, "Breast","Estrus,Dwemer")
		endif

		SexLab.StartSex(sexActors, anims)
	EndIf

	; If (sPlayerCow == "PlayerCow")
	;	CowLife.updateCowStatus(kPlayer,"Drink")
	; else
	;	CowLife.updateCowStatus(kActor,"Drink")
	; endif

EndEvent


Event OnEquipMilkingDevice(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	If (kActor == None)
		kActor = PlayerActor
	EndIf

	if (_args == "Auto")
		CowLife.PlayerReceivedAutoCowharness(kActor)
	else
		CowLife.PlayerReceivedCowharness(kActor)
	EndIf

EndEvent

Event OnRemoveMilkingDevice(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	If (kActor == None)
		kActor = PlayerActor
	EndIf

	if (_args == "Auto")
		CowLife.PlayerRemovedAutoCowharness(kActor)
	else
		CowLife.PlayerRemovedCowharness(kActor)
	EndIf

EndEvent

Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 
	Int iProlactinLevel
    sslBaseAnimation animation = SexLab.HookAnimation(_args)

	if !Self || !SexLab 
		Debug.Trace("SexLab Stories Devious: Critical error on SexLab Start")
		Return
	EndIf
	
	; Debug.Notification("SexLab Hormones: Sex start")

	Actor[] actors = SexLab.HookActors(_args)
	Actor   victim = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim
	
	; Debug.Notification("Has player: " + _hasPlayer(actors))
	; Debug.Notification("Arousal trigger: " + (slaUtil.GetActorExposure(PlayerActor) / 3))

	; Check for breast stimulation
	Debug.Trace("[SLSDDi] Checking Player lactation: " )

	If (_hasPlayer(actors))
		if (actors.Length == 2) && ( ((actors[0]!=PlayerActor) && (actors[1]==PlayerActor) && (isFemale(actors[0]))) || ((actors[1]!=PlayerActor) && (actors[0]==PlayerActor) && (isFemale(actors[1]))) )
			; Debug.Notification("[SLSDDi] Milk during sex ENABLED")
			CowLife.updateMilkDuringSexFlag(1)
		endif
	endif

	If (isFemale(PlayerActor)) && (_hasPlayer(actors))
		Debug.Trace("[SLSDDi]    Player is female" )

		CowLife.checkIfLactating(PlayerActor)

		if (animation.HasTag("Breast") || animation.HasTag("Boobs") || animation.HasTag("Boobjob")) && (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") ==0 ) 
	        if (Utility.RandomInt(0,100)>90)
	        	StorageUtil.SetIntValue(PlayerActor, "_SLH_iLactating", 1)
				Debug.Trace("[SLSDDi]    Player starts lactating" )

	        endif
	    EndIf


		; Force lactation if Player is wearing harness and not lactating yet
		if ( PlayerActor.WornHasKeyword(SLSD_CowHarness) || PlayerActor.WornHasKeyword(SLSD_CowMilker) ) 
			if (!StorageUtil.HasIntValue(PlayerActor, "_SLH_iLactating") || (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") == 0) )
				StorageUtil.SetIntValue(PlayerActor, "_SLH_iLactating", 1)
				Debug.Trace("[SLSDDi]    Player starts lactating" )
			endif
		endif

		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") == 1) 
			Debug.Trace("[SLSDDi]    Player is lactating - updating milk" )
			CowLife.UpdateMilkAfterSex(PlayerActor)
		else
			Debug.Trace("[SLSDDi]    Player is not lactating" )
			StorageUtil.SetFormValue( none , "_SD_iLastCowMilked", PlayerActor)
		Endif
	else
		Debug.Trace("[SLSDDi]    Invalid player" )
		Debug.Trace("[SLSDDi]       (_hasPlayer(actors): " + (_hasPlayer(actors)) )
		Debug.Trace("[SLSDDi]       isFemale(actors[idx]): " + isFemale(actors[idx]))

	endif

	int idx = 0
	while idx < actors.Length
		; Check for breast stimulation
		Debug.Trace("[SLSDDi] Checking actor list for lactation: " + idx + " / " + actors.Length )
		Debug.Trace("[SLSDDi] Checking actor lactation: " + actors[idx] )

		If (actors[idx]) && ( actors[idx] != PlayerActor) && (isFemale(actors[idx]))
			Debug.Trace("[SLSDDi]    Actor is female and not the player" )

			CowLife.checkIfLactating(actors[idx])

			if (animation.HasTag("Breast") || animation.HasTag("Boobs") || animation.HasTag("Boobjob")) && (StorageUtil.GetIntValue(actors[idx], "_SLH_iLactating") ==0 )
		        if (Utility.RandomInt(0,100)>90)
		        	StorageUtil.SetIntValue(actors[idx], "_SLH_iLactating", 1)
					Debug.Trace("[SLSDDi]    Actor starts lactating" )

		        endif
		    EndIf

			; Force lactation if NPC is wearing harness and not lactating yet
			if ( actors[idx].WornHasKeyword(SLSD_CowHarness) || actors[idx].WornHasKeyword(SLSD_CowMilker) ) 
				if  (!StorageUtil.HasIntValue(actors[idx], "_SLH_iLactating") || (StorageUtil.GetIntValue(actors[idx], "_SLH_iLactating") == 0) )
					StorageUtil.SetIntValue(actors[idx], "_SLH_iLactating", 1)
					Debug.Trace("[SLSDDi]    Actor starts lactating" )
				endif
			endif

			if (StorageUtil.GetIntValue(actors[idx], "_SLH_iLactating") == 1)
				Debug.Trace("[SLSDDi]    Actor is lactating - updating milk" )
				CowLife.UpdateMilkAfterSex(actors[idx])
			else
				Debug.Trace("[SLSDDi]    Actor is not lactating" )
				StorageUtil.SetFormValue( none , "_SD_iLastCowMilked", actors[idx])
			EndIf
		else
			Debug.Trace("[SLSDDi]    Invalid actor" )
			Debug.Trace("[SLSDDi]       actors[idx]: " + actors[idx] )
			Debug.Trace("[SLSDDi]       ( actors[idx] != PlayerActor): " + ( actors[idx] != PlayerActor) )
			Debug.Trace("[SLSDDi]       isFemale(actors[idx]): " + isFemale(actors[idx]))

		Endif

		idx += 1
	endwhile

	; Debug.Notification("SexLab Hormones: Forced refresh flag: " + StorageUtil.GetIntValue(none, "_SLH_iForcedRefresh"))
	
	If victim	;none consensual
		;

	Else        ;consensual
		;
		
	EndIf


EndEvent

Event OnSexLabEnd(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
    sslBaseAnimation animation = SexLab.HookAnimation(_args)
    Float fBreastScale 

	if !Self || !SexLab 
		Debug.Trace("SexLab Stories Devious: Critical error on SexLab End")
		Return
	EndIf


	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	if (actors.Length == 2) && ( ((actors[0]!=PlayerActor) && (actors[1]==PlayerActor) && (isFemale(actors[0]))) || ((actors[1]!=PlayerActor) && (actors[0]==PlayerActor) && (isFemale(actors[1]))) )
		; Debug.Notification("[SLSDDi] Milk during sex DISABLED")
		CowLife.updateMilkDuringSexFlag(0)
	endif
	
	; if config.bDebugMsg
	; 	_listActors("End: ", actors)
	; EndIf

	; If (_hasPlayer(actors))
		;
	; EndIf

EndEvent 

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 
	Int iMilkDateOffset

	if !Self || !SexLab 
		Debug.Trace("SexLab Stories Devious: Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	If (_hasPlayer(actors)) && (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") == 1)
		Debug.Trace("SexLab Stories: Orgasm!")
		If (!StorageUtil.HasIntValue(PlayerActor, "_SLH_iMilkDate") || (StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkDate") == 0) ) 
			StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkDate", Game.QueryStat("Days Passed"))
		Endif

		iMilkDateOffset = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkDate")

		CowLife.UpdateMilkAfterOrgasm(PlayerActor, iMilkDateOffset)

	Endif

	int idx = 0
	while idx < actors.Length
		if (actors[idx]) && ( actors[idx] != PlayerActor) && (StorageUtil.GetIntValue(actors[idx], "_SLH_iLactating") == 1)

			If (!StorageUtil.HasIntValue(actors[idx], "_SLH_iMilkDate") || (StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkDate") == 0) )
				StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkDate", Game.QueryStat("Days Passed"))
			Endif

			iMilkDateOffset = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkDate")

			CowLife.UpdateMilkAfterOrgasm(actors[idx],  iMilkDateOffset)
		EndIf
		idx += 1
	endwhile
EndEvent

Event OnSit(ObjectReference akFurniture)
	CowLife.UpdateMilkFromMachine(akFurniture)

endEvent



; -------------------------------------------------------------------
Bool function isFemale(actor kActor)
	Bool bIsFemale
	ActorBase kActorBase = kActor.GetActorBase()

	Debug.Trace("[SLP]Checking actor gender")
	Debug.Trace("[SLP]    kActor: " + kActor)
	Debug.Trace("[SLP]    kActorBase: " + kActorBase)

	if (kActorBase.GetSex() == 1) ; female
		bIsFemale = True
	Else
		bIsFemale = False
	EndIf

	return bIsFemale
EndFunction

Bool function isMale(actor kActor)
	return !isFemale(kActor)
EndFunction


; -------------------------------------------------------------------
Bool Function _hasPlayer(Actor[] _actors)
	ObjectReference PlayerREF= PlayerAlias.GetReference()

	int idx = 0
	while idx < _actors.Length
		if _actors[idx] == PlayerRef
			return True
		endif
		idx += 1
	endwhile
	Return False
EndFunction

Bool Function _hasActor(Actor[] _actors, Actor thisActor)

	int idx = 0
	while idx < _actors.Length
		if _actors[idx] == thisActor as ObjectReference
			return True
		endif
		idx += 1
	endwhile
	Return False
EndFunction

Bool Function _hasRace(Actor[] _actors, Race thisRace)
	ActorBase aBase 
	Race aRace 

	int idx = 0
	while idx < _actors.Length
		if (_actors[idx])
			; aBase = _actors[idx].GetBaseObject() as ActorBase
			aRace = _actors[idx].GetLeveledActorBase().GetRace()
			if aRace == thisRace
				return True
			endif
		EndIf
		idx += 1
	endwhile
	Return False
EndFunction

bool Function CheckXPMSERequirements(Actor akActor, bool isFemale)
	return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction
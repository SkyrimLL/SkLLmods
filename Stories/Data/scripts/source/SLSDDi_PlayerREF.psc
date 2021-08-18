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
GlobalVariable Property PlayerStartMilkFarm  Auto  

Keyword Property SLSD_CowHarness Auto
Keyword Property SLSD_CowMilker Auto
Keyword Property SLSD_MilkOMatic  Auto  
Keyword Property SLSD_MilkOMatic2  Auto  

SPELL Property SLSD_MilkOMaticSpell  Auto  
SPELL Property SLSD_MilkOMaticSpell2  Auto  
SPELL Property ApplySweatFX  Auto

ObjectReference Property MilkOMaticSoundFX  Auto  
ObjectReference Property LeonaraRef  Auto  
ObjectReference Property SLSD_PlayerBagRef  Auto  


SLSDDi_QST_CowLife Property CowLife Auto

Bool isNiOInstalled = false
Bool Property isSlifInstalled Auto

int daysPassed
int iGameDateLastCheck = -1
int iDaysSinceLastCheck

int                      Property SKEE_VERSION  = 1 AutoReadOnly

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
					debugTrace("SexLab Stories Devious: Adding Flame to Campfire:CampHeatSourcesAll")
				else
					debugTrace("SexLab Stories Devious: Flame is already on Campfire:CampHeatSourcesAll")
				EndIf
				FormList CampHeatSourcesFire = Game.GetFormFromFile(0x2899F, "Campfire.esm") as FormList
				If CampHeatSourcesFire && !CampHeatSourcesFire.HasForm(Flame)
					CampHeatSourcesFire.AddForm(Flame)
					debugTrace("SexLab Stories Devious: Adding Flame to Campfire:CampHeatSourcesFire")
				else
					debugTrace("SexLab Stories Devious: Flame is already on Campfire:CampHeatSourcesFire")
				EndIf
				FormList CampHeatSourcesFireMedium = Game.GetFormFromFile(0x28F03, "Campfire.esm") as FormList
				If CampHeatSourcesFireMedium && !CampHeatSourcesFireMedium.HasForm(Flame)
					CampHeatSourcesFireMedium.AddForm(Flame)
					debugTrace("SexLab Stories Devious: Adding Flame to Campfire:CampHeatSourcesFireMedium")
				else
					debugTrace("SexLab Stories Devious: Flame is already on Campfire:CampHeatSourcesFireMedium")
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
	debugTrace("SexLab Stories Devious: Reset SexLab events")
	RegisterForModEvent("AnimationStart", "OnSexLabStart")
	RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")
	RegisterForModEvent("SexLabOrgasmSeparate",    "OnSexLabOrgasmSeparate")

	RegisterForModEvent("_SLSDDi_UpdateCow", "OnUpdateCow")
	RegisterForModEvent("_SLSDDi_UpdateCowList", "OnUpdateCowList")
	RegisterForModEvent("_SLSDDi_GropeCow", "OnGropeCow")
	RegisterForModEvent("_SLSDDi_DrinkCow", "OnDrinkCow")
	RegisterForModEvent("_SLSDDi_EquipMilkingDevice", "OnEquipMilkingDevice")
	RegisterForModEvent("_SLSDDi_RemoveMilkingDevice", "OnRemoveMilkingDevice")
	RegisterForModEvent("_SLSDDi_TriggerCard", "OnTriggerCard")

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

	if ( (StorageUtil.GetIntValue(none, "_SLS_iPlayerStartMilkFarm") == 1) && (PlayerStartMilkFarm.GetValue()==0) )
		PlayerStartMilkFarm.SetValue(1)
		safeRemoveAllItems(PlayerActor, SLSD_PlayerBagRef)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iForcedHairLoss", 1)
		PlayerActor.SendModEvent("SLHShaveHead")
	endif

	iDaysSinceLastCheck = (daysPassed - iGameDateLastCheck ) as Int

	If (iDaysSinceLastCheck > 0)
		CowLife.updateAllCows("NewDay")
		CowLife.UpdateBalimundMerchantChest()
	endIf

	iGameDateLastCheck = daysPassed  

	RegisterForSingleUpdate(10)
EndEvent

; Back up event if Hormones is not installed
Event OnModHormoneEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	If (StorageUtil.GetIntValue(none, "_SLH_iHormones") == 1)
 		; Safety - disable if Hormones is activated and this mod event remains
 		return
 	endif

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf

 	if (_args == "")
 		_args = "Lactation"
 	EndIf

	debugTrace(" Receiving 'mod hormone level' event. Actor: " + kActor )

	; fctHormones.modHormoneLevel(kActor, _args, _argc)
	Float fHormoneLevel = StorageUtil.GetFloatValue( kActor , "_SLH_fHormone" + _args)  + _argc

	if (fHormoneLevel > 100.0)
		fHormoneLevel = 100.0
	elseif (fHormoneLevel < 0.0)
		fHormoneLevel = 0.0
	endif

	StorageUtil.SetFloatValue( kActor , "_SLH_fHormone" + _args, fHormoneLevel)

	; Force lactation modifier to 1.0 for compatibility
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactationMod", 1.0) 


EndEvent

Event OnTriggerCard(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor

 	if (kActor == None)
 		kActor = Game.GetPlayer()
 	EndIf

 	if (_args == "")
 		return
 	EndIf

	debugTrace(" Receiving 'trigger card' event. Actor: " + kActor )

	CowLife.triggerCard(_args)

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

Function _startBrestSexScene(String _args, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer() as Actor
 	String sPlayerCow = _args
	Float fLactationHormoneMod = 0.1

	If  (SexLab.ValidateActor( kPlayer ) > 0) &&  (SexLab.ValidateActor(kActor) > 0) 
		SendModEvent("dhlp-Suspend")
		StorageUtil.SetIntValue(none, "_SLS_iPlayerMilkFarmSex", 1)

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

		if (anims[0] ==None)
			anims = SexLab.GetAnimationsByTags(2, "Boob","Estrus,Dwemer")
		endif

		if (anims[0] ==None)
			anims = SexLab.GetAnimationsByTags(2, "Boobjob","Estrus,Dwemer")
		endif

		SexLab.StartSex(sexActors, anims)
	EndIf

	; CowLife.updateCowStatus(kPlayer,"")
	; CowLife.updateCowStatus(kActor,"")
Endfunction

Event OnGropeCow(String _eventName, String _args, Float _argc = -1.0, Form _sender)
	_startBrestSexScene( _args,  _sender)

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


	_startBrestSexScene( _args,  _sender)


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
		debugTrace("SexLab Stories Devious: Critical error on SexLab Start")
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
	debugTrace(" Checking Player lactation: " )

	If (_hasPlayer(actors))
		if (actors.Length == 2) && ( ((actors[0]!=PlayerActor) && (actors[1]==PlayerActor) && (isFemale(actors[0]))) || ((actors[1]!=PlayerActor) && (actors[0]==PlayerActor) && (isFemale(actors[1]))) )
			; Debug.Notification("[SLSDDi] Milk during sex ENABLED")
			CowLife.updateMilkDuringSexFlag(1)
		endif
	endif

	If (CowLife.checkHasBreasts(PlayerActor)) && (_hasPlayer(actors))
		debugTrace("    Player has breasts" )

		CowLife.checkIfLactating(PlayerActor)

		if (animation.HasTag("Breast") || animation.HasTag("Boobs") || animation.HasTag("Boobjob")) && (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") ==0 ) 
	        if (Utility.RandomInt(0,100)>90)
	        	StorageUtil.SetIntValue(PlayerActor, "_SLH_iLactating", 1)
				debugTrace("    Player starts lactating" )

	        endif
	    EndIf


		; Force lactation if Player is wearing harness and not lactating yet
		if ( PlayerActor.WornHasKeyword(SLSD_CowHarness) || PlayerActor.WornHasKeyword(SLSD_CowMilker) ) 
			if (!StorageUtil.HasIntValue(PlayerActor, "_SLH_iLactating") || (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") == 0) )
				StorageUtil.SetIntValue(PlayerActor, "_SLH_iLactating", 1)
				debugTrace("    Player starts lactating" )
			endif
		endif

		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") == 1) 
			debugTrace("    Player is lactating - updating milk" )
			CowLife.UpdateMilkAfterSex(PlayerActor)
		else
			debugTrace("    Player is not lactating" )
			StorageUtil.SetFormValue( none , "_SD_iLastCowMilked", PlayerActor)
		Endif
	else
		debugTrace("    Invalid player" )
		debugTrace("       (_hasPlayer(actors): " + (_hasPlayer(actors)) )
		debugTrace("       isFemale(actors[idx]): " + isFemale(actors[idx]))

	endif

	int idx = 0
	while idx < actors.Length
		; Check for breast stimulation
		debugTrace(" Checking actor list for lactation: " + idx + " / " + actors.Length )
		debugTrace(" Checking actor lactation: " + actors[idx] )

		If (actors[idx]) && ( actors[idx] != PlayerActor) && (isFemale(actors[idx]))
			debugTrace("    Actor is female and not the player" )

			CowLife.checkIfLactating(actors[idx])

			if (animation.HasTag("Breast") || animation.HasTag("Boobs") || animation.HasTag("Boobjob")) && (StorageUtil.GetIntValue(actors[idx], "_SLH_iLactating") ==0 )
		        if (Utility.RandomInt(0,100)>90)
		        	StorageUtil.SetIntValue(actors[idx], "_SLH_iLactating", 1)
					debugTrace("    Actor starts lactating" )

		        endif
		    EndIf

			; Force lactation if NPC is wearing harness and not lactating yet
			if ( actors[idx].WornHasKeyword(SLSD_CowHarness) || actors[idx].WornHasKeyword(SLSD_CowMilker) ) 
				if  (!StorageUtil.HasIntValue(actors[idx], "_SLH_iLactating") || (StorageUtil.GetIntValue(actors[idx], "_SLH_iLactating") == 0) )
					StorageUtil.SetIntValue(actors[idx], "_SLH_iLactating", 1)
					debugTrace("    Actor starts lactating" )
				endif
			endif

			if (StorageUtil.GetIntValue(actors[idx], "_SLH_iLactating") == 1)
				debugTrace("    Actor is lactating - updating milk" )
				CowLife.UpdateMilkAfterSex(actors[idx])
			else
				debugTrace("    Actor is not lactating" )
				StorageUtil.SetFormValue( none , "_SD_iLastCowMilked", actors[idx])
			EndIf
		else
			debugTrace("    Invalid actor" )
			debugTrace("       actors[idx]: " + actors[idx] )
			debugTrace("       ( actors[idx] != PlayerActor): " + ( actors[idx] != PlayerActor) )
			debugTrace("       isFemale(actors[idx]): " + isFemale(actors[idx]))

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
		debugTrace("SexLab Stories Devious: Critical error on SexLab End")
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

	if (StorageUtil.GetIntValue(none, "_SLS_iPlayerMilkFarmSex") == 1)
		SendModEvent("dhlp-Resume")
		StorageUtil.SetIntValue(none, "_SLS_iPlayerMilkFarmSex", 0)
	endif
	
	; if config.bDebugMsg
	; 	_listActors("End: ", actors)
	; EndIf

	; If (_hasPlayer(actors))
		;
	; EndIf

EndEvent 

Event OnSexLabOrgasmSeparate(Form ActorRef, Int Thread)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	string _args = Thread as string
	actor kActor = ActorRef as actor
	PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference()
	PlayerActor= PlayerREF as Actor

	If (kActor == None)
		kActor = PlayerActor
	EndIf
		
	doOrgasm(_args)
	
EndEvent

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender) 
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
 	Actor kActor = _sender as Actor

	PlayerREF= Game.GetPlayer() ; PlayerAlias.GetReference()
	PlayerActor= PlayerREF as Actor

	If (kActor == None)
		kActor = PlayerActor
	EndIf
		
	doOrgasm(_args)
EndEvent

Function doOrgasm(String _args)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 
	Int iMilkDateOffset

	if !Self || !SexLab 
		debugTrace("SexLab Stories Devious: Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	If (_hasPlayer(actors)) && (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") == 1)
		debugTrace("SexLab Stories: Orgasm!")
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
EndFunction

Event OnSit(ObjectReference akFurniture)
	Actor PlayerActor = Game.getPlayer()

	CowLife.UpdateMilkFromMachine(PlayerActor, akFurniture)

endEvent


; -------------------------------------------------------------------
Function safeRemoveAllItems ( ObjectReference akContainer, ObjectReference akTransferTo = None)
	Int iFormIndex = 0
	Bool bIgnoreItem = False
	Actor kPlayer = Game.GetPlayer()
	Actor kActor = akContainer as Actor

	; form[] slaveEquipment = SexLab.StripActor(kActor)
	; iFormIndex = slaveEquipment.Length

	iFormIndex = akContainer.GetNumItems()

	While ( iFormIndex > 0 )
		iFormIndex -= 1
		; Form kForm = slaveEquipment[iFormIndex]
		Form kForm = akContainer.GetNthForm(iFormIndex)

		If ( kForm )
			bIgnoreItem = ( (!SexLab.IsStrippable(kForm)) && !kForm.hasKeywordString("zad_BlockGeneric") && !kForm.hasKeywordString("VendorNoSale") && !kForm.hasKeywordString("SexLabNoStrip") && !kForm.HasKeywordString("MagicDisallowEnchanting")  && !kForm.HasKeywordString("SOS_Underwear")  && !kForm.HasKeywordString("SOS_Genitals") && !kForm.HasKeywordString("_SLMC_MCDevice") ) 

			If ( !bIgnoreItem  ) 
				akContainer.RemoveItem(kForm, akContainer.GetItemCount( kForm ), True, akTransferTo)
				; akTransferTo.AddItem(kForm, akContainer.GetItemCount( kForm ))
			EndIf
		Endif
	EndWhile

EndFunction

; -------------------------------------------------------------------
Bool function isFemale(actor kActor)
	return (kActor.GetActorBase().GetSex() == 1)
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
    if (SKSE.GetPluginVersion("SKEE") >= SKEE_VERSION) ; SKEE detected - Skyrim SE
        return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && SKSE.GetPluginVersion("SKEE") >= SKEE_VERSION
    else
        return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
    endif
EndFunction


Function debugTrace(string traceMsg)
	if (StorageUtil.GetIntValue(none, "_SLS_debugTraceON")==1)
	;	debugTrace("[SLSDDi_PlayerREF]" + traceMsg)
	endif
endFunction

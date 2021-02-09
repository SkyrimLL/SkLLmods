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

int MilkLevel = 0

; String                   Property NINODE_SCHLONG	 	= "NPC Genitals01 [Gen01]" AutoReadOnly
string                   Property SLS_KEY               = "SLSDDi_MilkFarm" AutoReadOnly
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
int                      Property NIOVERRIDE_VERSION    = 4 AutoReadOnly
int                      Property NIOVERRIDE_SCRIPT_VERSION = 4 AutoReadOnly

; XPMSE version data
float                    Property XPMSE_VERSION         = 3.0 AutoReadOnly
float                    Property XPMSELIB_VERSION      = 3.0 AutoReadOnly


int Property MAX_PRESETS = 4 AutoReadOnly
int Property MAX_MORPHS = 19 AutoReadOnly

int MILK_LEVEL_TRIGGER = 20


Bool isNiOInstalled = false
Bool Property isSlifInstalled Auto

int daysPassed
int iGameDateLastCheck = -1
int iDaysSinceLastCheck

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
	EndIf



	int idx = Game.GetModCount()
	string modName = ""
	while idx > 0
		idx -= 1
		modName = Game.GetModName(idx)
		if modName == "SexLab Inflation Framework.esp"
			isSlifInstalled = true
			
		elseif modName == "Campfire.esm"
			Form Flame = Game.GetFormFromFile(0xA50C , "SexLab-StoriesDevious.esp")
			If Flame 
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
			EndIf

		endif
	endwhile

 

	If (!StorageUtil.HasIntValue(none, "_SLS_iStoriesDevious"))
		StorageUtil.SetIntValue(none, "_SLS_iStoriesDevious", 1)
	EndIf

	UnregisterForAllModEvents()
	Debug.Trace("SexLab Stories Devious: Reset SexLab events")
	RegisterForModEvent("AnimationStart", "OnSexLabStart")
	; RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")

	RegisterForModEvent("_SLSDDi_UpdateCow", "OnUpdateCow")
	RegisterForModEvent("_SLSDDi_UpdateCowList", "OnUpdateCowList")
	RegisterForModEvent("_SLSDDi_DrinkCow", "OnDrinkCow")
	RegisterForModEvent("_SLSDDi_EquipMilkingDevice", "OnEquipMilkingDevice")
	RegisterForModEvent("_SLSDDi_RemoveMilkingDevice", "OnRemoveMilkingDevice")

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
		updateAllCows()
	endIf

	iGameDateLastCheck = daysPassed  

	RegisterForSingleUpdate(10)
EndEvent

Event OnUpdateCow(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	String bCreateMilk = _args

 	updateCowStatus(kActor, bCreateMilk)

EndEvent

Event OnUpdateCowList(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor 

 	updateAllCows()

EndEvent

Event OnDrinkCow(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer() as Actor
 	String sPlayerCow = _args

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
		anims[0] = SexLab.GetAnimationByName("3J Straight Breastfeeding")

		if (anims[0] ==None)
			anims = SexLab.GetAnimationsByTags(2, "Breast","Estrus,Dwemer")
		endif

		SexLab.StartSex(sexActors, anims)
	EndIf


	If (sPlayerCow == "PlayerCow")
		If (StorageUtil.GetIntValue(kPlayer, "_SLH_isPregnant") == 1) &&  (StorageUtil.GetIntValue(kPlayer, "_SLH_iMilkLevel") > 5)
			StorageUtil.GetIntValue(kPlayer, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kPlayer, "_SLH_iMilkLevel") - 2)
		elseif (StorageUtil.GetIntValue(kPlayer, "_SLH_isPregnant") != 1) &&  (StorageUtil.GetIntValue(kPlayer, "_SLH_iMilkLevel") > 8)
			StorageUtil.GetIntValue(kPlayer, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kPlayer, "_SLH_iMilkLevel") - 1)
		endIf

		if  (kPlayer.WornHasKeyword(SLSD_CowHarness) || kPlayer.WornHasKeyword(SLSD_CowMilker))
			StorageUtil.SetIntValue(kPlayer, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kPlayer, "_SLH_iProlactinLevel") + 2)	
		Else
			StorageUtil.SetIntValue(kPlayer, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kPlayer, "_SLH_iProlactinLevel") + 1)	
		endif
		SLSD_MilkOMaticSpell.Remotecast(kActor as ObjectReference ,kActor, kActor as ObjectReference)

	Else

		If (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1) &&  (StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") > 5)
			StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") - 2)
		elseif (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") != 1) &&  (StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") > 8)
			StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") - 1)
		endIf

		if  (kActor.WornHasKeyword(SLSD_CowHarness) || kActor.WornHasKeyword(SLSD_CowMilker))
			StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 2)	
		Else
			StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 1)	
		endif

		SLSD_MilkOMaticSpell.Remotecast(kPlayer as ObjectReference ,kPlayer, kPlayer as ObjectReference)
	Endif

	updateCowStatus(kPlayer,"")
	updateCowStatus(kActor,"")

EndEvent


Function registerCow(Actor kActor)
	If (StorageUtil.GetIntValue(kActor, "_SLH_iMilkCow") == 0)
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkCow", 1)
		StorageUtil.FormListAdd(none, "_SLH_lMilkCowList", kActor)
	endif
EndFunction

Function updateAllCows()
	Int valueCount = StorageUtil.FormListCount(none, "_SLH_lMilkCowList")
	int i = 0
	Form thisCow
 
 	Debug.Trace("[SLSDDi] Updating registered cows: " + valueCount)

	while(i < valueCount)
		thisCow = StorageUtil.FormListGet(none, "_SLH_lMilkCowList", i)
		updateCowStatus(thisCow as Actor, "NewDay")
		i = i + 1
	endwhile

EndFunction

Function updateCowStatus(Actor kActor, String bCreateMilk = "")
 	Actor PlayerActor= Game.GetPlayer() as Actor
 	ActorBase pActorBase
 	Int iProlactinLevel 

	If (kActor == None)
		kActor = PlayerActor
	EndIf

	Float fLactationBase = ( StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced") / 10) as Float
	Float fLactationLevel = ( StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") ) as Float
	Float fLactationMilkDate = ( Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(kActor, "_SLH_iMilkDate") ) as Float

	pActorBase = kActor.GetActorBase()

	if ( kActor.WornHasKeyword(SLSD_CowHarness) || kActor.WornHasKeyword(SLSD_CowMilker) ) && (!StorageUtil.HasIntValue(kActor, "_SLH_iLactating") || (StorageUtil.GetIntValue(kActor, "_SLH_iLactating") == 0) )
		StorageUtil.SetIntValue(kActor, "_SLH_iLactating", 1)
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", 0)
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkProduced", 0)
		StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", 10)
	endif

	If (!StorageUtil.HasIntValue(kActor, "_SLH_iMilkDate") || (StorageUtil.GetIntValue(kActor, "_SLH_iMilkDate") == 0) )
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkDate", Game.QueryStat("Days Passed"))
	Endif

	If (StorageUtil.GetIntValue(kActor, "_SLH_iMilkCow") == 0)
		registerCow(kActor)
	Endif

	If (bCreateMilk == "NewDay")
		iProlactinLevel = StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") 

		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant") == 1) 
			iProlactinLevel = iProlactinLevel + 1
			StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") + 1)
		else
			iProlactinLevel = iProlactinLevel - 2
			If (Utility.RandomInt(0,100)> (100-iProlactinLevel))
				StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") + 1)
			endif
		endIf

		if (iProlactinLevel < 10)
			iProlactinLevel = 10
		endIf
		StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", iProlactinLevel )
	Endif

	; Debug.Trace("[SLSDDi] Receiving Milk Cow update event")
	; Debug.Notification("[SLSDDi] Check for NiOverride: " + isNiOInstalled)
	; Debug.Notification("[SLSDDi] Check for Female actor: " + pActorBase.GetSex())
	; Debug.Notification("[SLSDDi] Check for Lactating actor: " + StorageUtil.GetIntValue(kActor, "_SLH_iLactating"))
	Debug.Trace("[SLSDDi] Milk level: " + StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel"))
	Debug.Trace("[SLSDDi] Prolactin level: " + StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel"))

	if (pActorBase.GetSex()==1)
		; Debug.Notification("[SLSDDi] Days since last milking: " + (fLactationMilkDate as Int))
		Float fBreast  = 1.0 +  (fLactationBase * 0.2) + (fLactationLevel * 0.1) + (fLactationMilkDate * 0.15)
		if (fbreast > StorageUtil.GetFloatValue(PlayerActor, "_SLS_breastMaxMilkFarm"  ))
			fBreast = StorageUtil.GetFloatValue(PlayerActor, "_SLS_breastMaxMilkFarm"  )
		Endif
	 
		if (isSlifInstalled)
			SLIF_inflateMax(kActor, "slif_belly", fBreast, NINODE_MAX_SCALE, SLS_KEY)

		elseif ( isNiOInstalled  ) 
			XPMSELib.SetNodeScale(kActor, true, NINODE_LEFT_BREAST, fBreast, SLS_KEY)
			XPMSELib.SetNodeScale(kActor, true, NINODE_RIGHT_BREAST, fBreast, SLS_KEY)

		Endif
		; Debug.Notification("[SLSDDi] Updating breast size to " + fBreast)
	
	EndIf

	If (bCreateMilk == "Milk") ; Milk bottle produced - reset timer
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkDate", Game.QueryStat("Days Passed"))

		iProlactinLevel = StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 2
		StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", iProlactinLevel )

	ElseIf (bCreateMilk == "Check") ; Messages from checking milk level
		If (fLactationLevel<((MILK_LEVEL_TRIGGER as Float) - 10.0))
			Debug.Notification("Her breasts are tender and filling up nicely - Level " + fLactationLevel as Int)
		ElseIf (fLactationLevel>= ((MILK_LEVEL_TRIGGER as Float) - 10.0)) && (fLactationLevel<( (MILK_LEVEL_TRIGGER as Float) - 6.0)) 
			Debug.Notification("Her breasts are swelling up with milk - Level " + fLactationLevel as Int)
		ElseIf (fLactationLevel>= ((MILK_LEVEL_TRIGGER as Float) - 6.0)) && (fLactationLevel< ( (MILK_LEVEL_TRIGGER as Float) - 2.0))
			Debug.Notification("Her breasts are heavy and her tits hard - Level " + fLactationLevel as Int)
		ElseIf (fLactationLevel>= ((MILK_LEVEL_TRIGGER as Float) - 2.0)) 
			Debug.Notification("Her breasts are full and ready to be milked - Level " + fLactationLevel as Int)
		Endif

	Endif

	If (kActor == PlayerActor)
		GV_MilkLevel.SetValue(StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") as Int)
		GV_ProlactinLevel.SetValue(StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") as Int)
	Endif
EndFunction

Function GetMilk(Actor kActor, Int iNumberBottles=1)
 	Actor PlayerActor= Game.GetPlayer() as Actor

	If (StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") >= 100)
		PlayerActor.AddItem(DivineMilk, iNumberBottles)	
	Else
		PlayerActor.AddItem(Milk, iNumberBottles)	
	Endif

	StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", 0)	
	StorageUtil.SetIntValue(kActor, "_SLH_iMilkProduced", StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced") +1)
	StorageUtil.SetIntValue(kActor, "_SLH_iMilkProducedTotal", StorageUtil.GetIntValue(kActor, "_SLH_iMilkProducedTotal") +1)	
EndFunction

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

	; Force lactation if Player is wearing harness and not lactating yet
	if ( PlayerActor.WornHasKeyword(SLSD_CowHarness) || PlayerActor.WornHasKeyword(SLSD_CowMilker) ) && (!StorageUtil.HasIntValue(PlayerActor, "_SLH_iLactating") || (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") == 0) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iLactating", 1)
	endif

	If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") == 1)
		If (_hasPlayer(actors))
			Debug.Trace("[SLSDDi] Player is lactating")

			iProlactinLevel = StorageUtil.GetIntValue(PlayerActor, "_SLH_iProlactinLevel")
			if (iProlactinLevel > 100)
				iProlactinLevel = 100
			endIf
			if (iProlactinLevel < 10)
				iProlactinLevel = 10
			endIf

			If (!StorageUtil.HasIntValue(PlayerActor, "_SLH_iMilkLevel"))
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkLevel", MilkLevel)
			Endif
			If (!StorageUtil.HasIntValue(PlayerActor, "_SLH_iMilkProduced"))
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkProduced", MilkProduced.GetValue() as Int)
			Endif

			If ( PlayerActor.WornHasKeyword(SLSD_CowHarness) && ( Utility.RandomInt(0,100) > (100 - iProlactinLevel*2 - slaUtil.GetActorExposure(PlayerActor))  ) ) || PlayerActor.WornHasKeyword(SLSD_CowMilker) 
				; Hormones compatibility
				Debug.Notification("Your breasts are swelling from a strong rush of milk.")

				If (StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant") == 1) 
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") + 3)
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iProlactinLevel") + 4)
				else
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") + 2)
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iProlactinLevel") + 3)

				endIf

			ElseIf ( !PlayerActor.WornHasKeyword(SLSD_CowHarness) && !PlayerActor.WornHasKeyword(SLSD_CowMilker) && ( Utility.RandomInt(0,100) > (100 - iProlactinLevel - slaUtil.GetActorExposure(PlayerActor))  ) )  || (StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant") == 1)
				; Hormones compatibility
				Debug.Notification("Your breasts are tingling from a small rush of milk.")

				if (StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant") == 1)
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") + 2)
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iProlactinLevel") + 3)
				elseif (StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant") != 1)
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") + 1)
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iProlactinLevel") + 2)
				endif
			Else
				Debug.Trace("[SLSDDi] You can't produce enough milk to fill the suction cup. Exposure trigger: " + slaUtil.GetActorExposure(PlayerActor))

				if (StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant") == 1)
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iProlactinLevel") + 2)
				elseif (StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant") != 1)
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iProlactinLevel") + 1)
				endif

			EndIf

			; PlayerActor.SendModEvent("_SLSDDi_UpdateCow")
			updateCowStatus(PlayerActor)

			Debug.Trace("[SLSDDi] Player Milk level: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel"))
			Debug.Trace("[SLSDDi] Player Milk produced: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced"))
		EndIf
	Endif

	int idx = 0
	while idx < actors.Length
		; Force lactation if NPC is wearing harness and not lactating yet
		if ( actors[idx].WornHasKeyword(SLSD_CowHarness) || actors[idx].WornHasKeyword(SLSD_CowMilker) ) && (!StorageUtil.HasIntValue(actors[idx], "_SLH_iLactating") || (StorageUtil.GetIntValue(actors[idx], "_SLH_iLactating") == 0) )
			StorageUtil.SetIntValue(actors[idx], "_SLH_iLactating", 1)
		endif

		if (actors[idx]) && ( actors[idx] != PlayerActor) && (StorageUtil.GetIntValue(actors[idx], "_SLH_iLactating") == 1)

			Debug.Trace("[SLSDDi] NPC is lactating: " + actors[idx].GetName())
			iProlactinLevel = StorageUtil.GetIntValue(actors[idx], "_SLH_iProlactinLevel")
			if (iProlactinLevel > 100)
				iProlactinLevel = 100
			endIf
			if (iProlactinLevel < 10)
				iProlactinLevel = 10
			endIf

			if ( actors[idx].WornHasKeyword(SLSD_CowHarness)  && ( Utility.RandomInt(0,100) > (100 - iProlactinLevel*2 - slaUtil.GetActorExposure(actors[idx]))  ) ) || actors[idx].WornHasKeyword(SLSD_CowMilker)  

				If (!StorageUtil.HasIntValue(actors[idx], "_SLH_iMilkLevel"))
						StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkLevel", 0)
				Endif
				If (!StorageUtil.HasIntValue(actors[idx], "_SLH_iMilkProduced"))
						StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkProduced", 0)
				Endif

				Debug.Notification("The cow's breasts are swelling from a strong rush of milk.")

				If (StorageUtil.GetIntValue(actors[idx], "_SLH_isPregnant") == 1)
					StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel") + 3)
					StorageUtil.SetIntValue(actors[idx], "_SLH_iProlactinLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iProlactinLevel") + 4)
				else
					StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel") + 2)
					StorageUtil.SetIntValue(actors[idx], "_SLH_iProlactinLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iProlactinLevel") + 3)
				endIf
				Debug.Trace("[SLSDDi] NPC Milk level: " + StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel"))

			elseif ( !actors[idx].WornHasKeyword(SLSD_CowHarness)  && !actors[idx].WornHasKeyword(SLSD_CowMilker)  && ( Utility.RandomInt(0,100) > (100 - iProlactinLevel - slaUtil.GetActorExposure(actors[idx]))  ) )  || (StorageUtil.GetIntValue(actors[idx], "_SLH_isPregnant") == 1) 

				If (!StorageUtil.HasIntValue(actors[idx], "_SLH_iMilkLevel"))
						StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkLevel", 0)
				Endif
				If (!StorageUtil.HasIntValue(actors[idx], "_SLH_iMilkProduced"))
						StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkProduced", 0)
				Endif

				Debug.Notification("The cow's breasts are tingling from a small drop of milk.")

				if (StorageUtil.GetIntValue(actors[idx], "_SLH_isPregnant") == 1) 
					StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel") + 2)
					StorageUtil.SetIntValue(actors[idx], "_SLH_iProlactinLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iProlactinLevel") + 3)
				elseif (StorageUtil.GetIntValue(actors[idx], "_SLH_isPregnant") != 1) 
					StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel") + 1)
					StorageUtil.SetIntValue(actors[idx], "_SLH_iProlactinLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iProlactinLevel") + 2)
				EndIf
			Else
				Debug.Trace("[SLSDDi] You can't extract enough milk to fill the suction cup. Exposure trigger: " + slaUtil.GetActorExposure(actors[idx]))

				if (StorageUtil.GetIntValue(actors[idx], "_SLH_isPregnant") == 1) 
					StorageUtil.SetIntValue(actors[idx], "_SLH_iProlactinLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iProlactinLevel") + 2)
				elseif (StorageUtil.GetIntValue(actors[idx], "_SLH_isPregnant") != 1) 
					StorageUtil.SetIntValue(actors[idx], "_SLH_iProlactinLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iProlactinLevel") + 1)
				EndIf
			endif

			; actors[idx].SendModEvent("_SLSDDi_UpdateCow")
			updateCowStatus(actors[idx])

			Debug.Trace("[SLSDDi] NPC Milk level: " + StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel"))
			Debug.Trace("[SLSDDi] NPC Milk produced: " + StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkProduced"))
		EndIf
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

	If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") == 1)
		Debug.Trace("SexLab Stories: Orgasm!")
		If (!StorageUtil.HasIntValue(PlayerActor, "_SLH_iMilkDate") || (StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkDate") == 0) ) 
			StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkDate", Game.QueryStat("Days Passed"))
		Endif

		iMilkDateOffset = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkDate")

		If ( (StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") + iMilkDateOffset) >= MILK_LEVEL_TRIGGER) && (_hasPlayer(actors))
			If  (PlayerActor.WornHasKeyword(SLSD_CowHarness) || PlayerActor.WornHasKeyword(SLSD_CowMilker))
				Debug.Notification("The suction cups painfully clench around your tits.")

				GetMilk(PlayerActor, 1)	
				libs.SexlabMoan(PlayerActor)	
			else
				libs.Pant(PlayerActor)
				StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkLevel",  StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") / 2)	
			;	ApplySweatFX.RemoteCast(PlayerActor as ObjectReference, PlayerActor,PlayerActor as ObjectReference)
				SexLab.AddCum(PlayerActor,False,True,False)
				Debug.Notification("Milk spills all over your chest.")
			Endif

			If  (StorageUtil.GetIntValue(none, "_SLS_fetishID") == 10 )
				slaUtil.UpdateActorExposure(PlayerActor, 10, "producing breast milk as a cow.")
			Else
				slaUtil.UpdateActorExposure(PlayerActor, -20, "producing breast milk as a cow.")
			EndIf

			if  (PlayerActor.WornHasKeyword(SLSD_CowHarness) || PlayerActor.WornHasKeyword(SLSD_CowMilker))
				StorageUtil.SetIntValue(PlayerActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iProlactinLevel") + 2)	
			Else
				StorageUtil.SetIntValue(PlayerActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iProlactinLevel") + 1)	
			endif

			Debug.Trace("[SLSDDi] NPC Milk Produced: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced"))
			Debug.Trace("[SLSDDi] NPC Milk Total: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProducedTotal"))

			; PlayerActor.SendModEvent("_SLSDDi_UpdateCow","Milk")
			updateCowStatus(PlayerActor,"Milk")

		EndIf
	Endif

	int idx = 0
	while idx < actors.Length
		if (actors[idx]) && ( actors[idx] != PlayerActor) && (StorageUtil.GetIntValue(actors[idx], "_SLH_iLactating") == 1)

			If (!StorageUtil.HasIntValue(actors[idx], "_SLH_iMilkDate") || (StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkDate") == 0) )
				StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkDate", Game.QueryStat("Days Passed"))
			Endif

			iMilkDateOffset = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkDate")

			If ( (StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel") + iMilkDateOffset) >= MILK_LEVEL_TRIGGER)
				if actors[idx].WornHasKeyword(SLSD_CowHarness)  || actors[idx].WornHasKeyword(SLSD_CowMilker)
					Debug.Notification("The harness container is full.")

					GetMilk(actors[idx],1)	
				else
					Debug.Notification("Milk spills all over her chest.")
					StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel") / 2)	
				;	ApplySweatFX.RemoteCast(actors[idx] as ObjectReference, actors[idx],actors[idx] as ObjectReference)
					SexLab.AddCum(actors[idx],False,True,False)
				Endif

				if  (actors[idx].WornHasKeyword(SLSD_CowHarness) || actors[idx].WornHasKeyword(SLSD_CowMilker))
					StorageUtil.SetIntValue(actors[idx], "_SLH_iProlactinLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iProlactinLevel") + 2)	
				Else
					StorageUtil.SetIntValue(actors[idx], "_SLH_iProlactinLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iProlactinLevel") + 1)	
				endif


				Debug.Trace("[SLSDDi] NPC Milk Produced: " + StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkProduced"))
				Debug.Trace("[SLSDDi] NPC Milk Total: " + StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkProducedTotal"))

				; actors[idx].SendModEvent("_SLSDDi_UpdateCow","Milk")
				updateCowStatus(actors[idx],"Milk")

				libs.SexlabMoan(actors[idx])
			endif
		EndIf
		idx += 1
	endwhile
EndEvent

Event OnSit(ObjectReference akFurniture)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Actor LeonaraActor = LeonaraRef as Actor
	Form fFurniture = akFurniture.GetBaseObject()
	String sFurnitureName = fFurniture.GetName()
	Float fBreastScale 
	Int iCounter=0
	Int iRandomEvent
	Int iTimer
	
	if (sFurnitureName == "Dwarven Milking Machine")  && (akFurniture.GetActorOwner() == LeonaraActor.GetActorBase() )
		; Debug.Notification("We just sat on " + sFurnitureName)
		; Debug.Messagebox("The " + sFurnitureName + " painfully sucks and tugs at your nipples, leaving both your breasts and your body drained.")
		
		; Hormones compatibility

		MilkOMaticSoundFX.Enable()
		Game.DisablePlayerControls(abActivate = true)
		iCounter = (fBreastScale * 60) as Int
		While (iCounter>0)
			iRandomEvent = Utility.RandomInt(0,100)
			iTimer = 1 + iCounter  / 60

			if (iRandomEvent>70)
				libs.SexlabMoan(PlayerActor)
				Utility.Wait(2.0)

			elseif (iRandomEvent>40)
				libs.Pant(PlayerActor)
				Utility.Wait(1.0)

			elseif (iRandomEvent>20)
				Debug.Notification("Milk is pumping into the machine.. " + iTimer + " m left")
			endif

			iCounter = iCounter - 1
		EndWhile
		Game.EnablePlayerControls(abActivate = true)
		MilkOMaticSoundFX.Disable()

		StorageUtil.SetIntValue(PlayerActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iProlactinLevel") + 4)	

		Debug.Trace("[SLSDDi] NPC Milk Produced: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced"))
		Debug.Trace("[SLSDDi] NPC Milk Total: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProducedTotal"))

		GetMilk(PlayerActor, 1)		

		If  (StorageUtil.GetIntValue(none, "_SLS_fetishID") == 10 )
			slaUtil.UpdateActorExposure(PlayerActor, 10, "producing breast milk as a cow.")
		Else
			slaUtil.UpdateActorExposure(PlayerActor, -20, "producing breast milk as a cow.")
		EndIf

		; PlayerActor.SendModEvent("_SLSDDi_UpdateCow","Milk")
		updateCowStatus(PlayerActor,"Milk")


	Elseif (sFurnitureName == "Dwarven Milking Machine II") && (akFurniture.GetActorOwner() == LeonaraActor.GetActorBase() )
		; Debug.Notification("We just sat on " + sFurnitureName)
		; Debug.Messagebox("The " + sFurnitureName + " painfully sucks and tugs at your nipples, leaving you drained both mentally and physically.")

		; Hormones compatibility

		MilkOMaticSoundFX.Enable()
		Game.DisablePlayerControls(abActivate = true)
		iCounter = (fBreastScale * 30) as Int
		While (iCounter>0)
			iRandomEvent = Utility.RandomInt(0,100)
			iTimer = 1 + iCounter  / 60

			if (iRandomEvent>80)
				libs.SexlabMoan(PlayerActor)
				Utility.Wait(2.0)

			elseif (iRandomEvent>60)
				libs.Moan(PlayerActor)
				Utility.Wait(2.0)

			elseif (iRandomEvent>40)
				libs.Pant(PlayerActor)
				Utility.Wait(3.0)

			elseif (iRandomEvent>20)
				Debug.Notification("Milk is pumping into the machine.. " + iTimer + " m left")
				libs.Moan(PlayerActor)
			endif

			iCounter = iCounter - 1
		EndWhile
		Game.EnablePlayerControls(abActivate = true)
		MilkOMaticSoundFX.Disable()

		StorageUtil.SetIntValue(PlayerActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iProlactinLevel") + 7)	

		Debug.Trace("[SLSDDi] NPC Milk Produced: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced"))
		Debug.Trace("[SLSDDi] NPC Milk Total: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProducedTotal"))


		; SLSD_MilkOMaticSpell2.Remotecast(PlayerREF,PlayerActor,PlayerREF)
		
		GetMilk(PlayerActor, 2)		

		If  (StorageUtil.GetIntValue(none, "_SLS_fetishID") == 10 )
			slaUtil.UpdateActorExposure(PlayerActor, 10, "producing breast milk as a cow.")
		Else
			slaUtil.UpdateActorExposure(PlayerActor, -20, "producing breast milk as a cow.")
		EndIf

		; PlayerActor.SendModEvent("_SLSDDi_UpdateCow","Milk")
		updateCowStatus(PlayerActor,"Milk")
	EndIf
endEvent



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
 
function SLIF_inflate(Actor kActor, String sKey, float value, String NiOString)
	int SLIF_event = ModEvent.Create("SLIF_inflate")
	If (SLIF_event)
		ModEvent.PushForm(SLIF_event, kActor)
		ModEvent.PushString(SLIF_event, "SexLab Parasites")
		ModEvent.PushString(SLIF_event, sKey)
		ModEvent.PushFloat(SLIF_event, value)
		ModEvent.PushString(SLIF_event, NiOString)
		ModEvent.Send(SLIF_event)
	EndIf
endFunction

function SLIF_setMax(Actor kActor, String sKey, float maximum)
	int SLIF_event = ModEvent.Create("SLIF_setMax")
	If (SLIF_event)
		ModEvent.PushForm(SLIF_event, kActor)
		ModEvent.PushString(SLIF_event, "SexLab Parasites")
		ModEvent.PushString(SLIF_event, sKey)
		ModEvent.PushFloat(SLIF_event, maximum)
		ModEvent.Send(SLIF_event)
	EndIf	
endFunction

function SLIF_inflateMax(Actor kActor, String sKey, float value, float maximum, String NiOString)
	SLIF_setMax(kActor, sKey, maximum)
	SLIF_inflate(kActor, sKey, value, NiOString)
endFunction


bool Function CheckXPMSERequirements(Actor akActor, bool isFemale)
	return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction
Scriptname SLS_PlayerAlias_Fetish extends ReferenceAlias  

ReferenceAlias Property PlayerAlias  Auto  
SexLabFramework     property SexLab Auto

Int iArousalThrottle = 20 ; Chance of success to consider updating arousal

;  0- No fetish
;  1- The Apprentice Stone - Craft / Hitting / Dom
;  2- The Atronach Stone - Killing monsters
;  3- The Lady Stone - Wearing Jewelry
;  4- The Lord Stone - Wearing Armor
;  5- The Lover Stone - Being Nude / Sex
;  6- The Mage Stone - Using magic
;  7- The Ritual Stone - Specific NPC / spouse
;  8- The Serpent Stone - Killing animals
;  9- The Shadow Stone - Killing humans
; 10- The Steed Stone - Bestiality
; 11- The Thief Stone - Stealing
; 12- The Tower Stone - Wearing leather / being hit / sub
; 13- The Warrior Stone - Using weapons

Event OnPlayerLoadGame()
	_maintenance()
	_getGameStats()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	; daysSinceEnslavement = (Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(akActor, "_SLMC_victimDateEnslaved") ) as Int
	; StorageUtil.SetIntValue(akActor, "_SLMC_victimGameDaysEnslaved", daysSinceEnslavement)

;  http://wiki.tesnexus.com/index.php/Skyrim_bodyparts_number
	; _SLS_NPCSexCount.SetValue(-1)

	if (Utility.RandomInt(0, 100) > iArousalThrottle)
		Return
	Endif
	
	If (_SLS_FetishID.GetValue() > 0)

		_refreshGameStats()

		If (_SLS_FetishID.GetValue() == 9 ) && (StorageUtil.GetIntValue(akActor, "_SLS_statPeopleKillDiff" )>0)
			slaUtil.UpdateActorExposure(akRef = akActor, val = StorageUtil.GetIntValue(akActor, "_SLS_statPeopleKillDiff" ), debugMsg = "killing people.")
		EndIf

		If (_SLS_FetishID.GetValue() == 8 ) && (StorageUtil.GetIntValue(akActor, "_SLS_statAnimalKillDiff" )>0)
			slaUtil.UpdateActorExposure(akRef = akActor, val = StorageUtil.GetIntValue(akActor, "_SLS_statAnimalKillDiff" ), debugMsg = "killing animals.")
		EndIf

		If (_SLS_FetishID.GetValue() == 2 ) && (StorageUtil.GetIntValue(akActor, "_SLS_statCreatureKillDiff" )>0)
			slaUtil.UpdateActorExposure(akRef = akActor, val = StorageUtil.GetIntValue(akActor, "_SLS_statCreatureKillDiff" ), debugMsg = "killing creatures.")
		EndIf

		If (_SLS_FetishID.GetValue() == 6 ) && (StorageUtil.GetIntValue(akActor, "_SLS_statMagicDiff" )>0)
			slaUtil.UpdateActorExposure(akRef = akActor, val = StorageUtil.GetIntValue(akActor, "_SLS_statMagicDiff" ), debugMsg = "using magic.")
		EndIf

		If (_SLS_FetishID.GetValue() == 1 ) && (StorageUtil.GetIntValue(akActor, "_SLS_statCraftDiff" )>0)
			slaUtil.UpdateActorExposure(akRef = akActor, val = StorageUtil.GetIntValue(akActor, "_SLS_statCraftDiff" ), debugMsg = "crafting items.")
		EndIf

		If (_SLS_FetishID.GetValue() == 11 ) && (StorageUtil.GetIntValue(akActor, "_SLS_statCrimeDiff" )>0)
			slaUtil.UpdateActorExposure(akRef = akActor, val = StorageUtil.GetIntValue(akActor, "_SLS_statCrimeDiff" ), debugMsg = "stealing and commiting crime.")
		EndIf

		If (_SLS_FetishID.GetValue() == 5 ) && !slaUtil.IsActorExhibitionist(akActor)
			slaUtil.SetActorExhibitionist(akActor, True)
		EndIf

		If (_SLS_FetishID.GetValue() == 9 ) && ((akActor.GetLightLevel()<50) || (akActor.IsSneaking() ))
			slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "being in darkness.")
		EndIf

		If (_SLS_FetishID.GetValue() == 10 ) && akActor.IsOnMount()
			slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "riding a horse.")
		EndIf

		Actor randomActor = Game.FindRandomActorFromRef(akActor, 10.0)
		If (randomActor != None)
			If (_SLS_FetishID.GetValue() == 7 ) && ( (akActor.HasFamilyRelationship(randomActor)) || (randomActor.IsPlayerTeammate()))
				slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "being close to a loved one.")
			ElseIf (_SLS_FetishID.GetValue() == 7 ) && ( (akActor.HasAssociation(SpouseType, randomActor)))
				slaUtil.UpdateActorExposure(akRef = akActor, val = 5, debugMsg = "being close to a spouse.")
			EndIf
		EndIf

		Bool bArmorOn = akActor.WornHasKeyword(ArmorOn)
		Bool bClothingOn = akActor.WornHasKeyword(ClothingOn)

		Int[] uiSlotMask = New Int[4]
		uiSlotMask[0]  = 0x00000004 ;32   - body (full)
		uiSlotMask[1]  = 0x00000020 ;35   - amulet
		uiSlotMask[2]  = 0x00000040 ;36   - ring
		uiSlotMask[3]  = 0x00001000 ;42   - circlet

		Int iFormIndex = uiSlotMask.Length
		While ( iFormIndex > 0 )
			iFormIndex -= 1
			Form kForm = akActor.GetWornForm( uiSlotMask[iFormIndex] ) 

			If ((_SLS_FetishID.GetValue() == 4 ) || (_SLS_FetishID.GetValue() == 5 ) || (_SLS_FetishID.GetValue() == 10 ) || (_SLS_FetishID.GetValue() == 11 ) || (_SLS_FetishID.GetValue() == 3 ))&& (iFormIndex==0)
				Armor kArmor = kForm as Armor
				If ( kArmor ) && (_SLS_FetishID.GetValue() == 4 )
					slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "wearing an armor.")
				ElseIf  ( kArmor ) && (_SLS_FetishID.GetValue() == 3 ) && (kForm.GetGoldValue() > 500) && (bClothingOn)
					slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "wearing expensive clothing.")
				ElseIf ( !kForm ) && ( (_SLS_FetishID.GetValue() == 5 ) || (_SLS_FetishID.GetValue() == 10 ) || (_SLS_FetishID.GetValue() == 11 ) || (_SLS_FetishID.GetValue() == 3 ) )
					slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "not wearing cloth or armor.")
				EndIf
			ElseIf (_SLS_FetishID.GetValue() == 3 ) && (iFormIndex!=0)	
				If (kForm)
					slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "wearing jewelry.")
				EndIf
			EndIf
		EndWhile	

		; See - http://www.creationkit.com/GetEquippedItemType_-_Actor - For specialization ideas

		Weapon krHand = akActor.GetEquippedWeapon()
		Weapon klHand = akActor.GetEquippedWeapon( True )
		If ( krHand ) && (_SLS_FetishID.GetValue() == 13 )
			slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "holding a weapon.")
		EndIf
		If ( klHand ) && (_SLS_FetishID.GetValue() == 13 )
			slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "holding a weapon.")
		EndIf
	EndIf
endEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	if (Utility.RandomInt(0, 100) > iArousalThrottle)
		Return
	Endif

	If (akTarget != None)

	    if (aeCombatState == 0)
	      	; Debug.Trace("We have left combat with the player!")

		  	If (_SLS_FetishID.GetValue() == 12 ) || (_SLS_FetishID.GetValue() == 8 )  || (_SLS_FetishID.GetValue() == 13 )  
				;  Debug.Trace("We were hit by " + akAggressor)

				slaUtil.UpdateActorExposure(akRef = akActor, val = 1, debugMsg = "leaving combat.")
			EndIf    	

	    elseif (aeCombatState == 1)
	      	; Debug.Trace("We have entered combat with the player!")

		  	If (_SLS_FetishID.GetValue() == 12 ) 

				slaUtil.UpdateActorExposure(akRef = akActor, val = 1, debugMsg = "starting combat.")
		  	ElseIf (_SLS_FetishID.GetValue() == 13 )

				slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "starting combat.")
			EndIf 

	    elseif (aeCombatState == 2)
	      	; Debug.Trace("We are searching for the player...")

		  	If (_SLS_FetishID.GetValue() == 8 ) 

				slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "going on a hunt.")
			EndIf 
	    endIf
	EndIf
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	if (Utility.RandomInt(0, 100) > iArousalThrottle)
		Return
	Endif

	If (akAggressor != None) && (_SLS_FetishID.GetValue() == 12) 
		;  Debug.Trace("We were hit by " + akAggressor)

		slaUtil.UpdateActorExposure(akRef = akActor, val = 1, debugMsg = "being hit.")
	EndIf
EndEvent



Event OnEnterBleedout()
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	if (Utility.RandomInt(0, 100) > iArousalThrottle)
		Return
	Endif
	
	If (_SLS_FetishID.GetValue() == 12)

		slaUtil.UpdateActorExposure(akRef = akActor, val = 5, debugMsg = "being knocked down.")
	EndIf
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()
	bool playerOwnsItem = False

	if (Utility.RandomInt(0, 100) > iArousalThrottle)
		Return
	Endif
	
	if (akItemReference) && (_SLS_FetishID.GetValue() == 11)
        playerOwnsItem = (akItemReference.GetActorOwner() == Game.GetPlayer().GetActorBase()) || (akItemReference.GetActorOwner() == None)
        
        If !playerOwnsItem
            slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "stealing.")

        EndIf
	EndIf

	Int iuType = akBaseItem.GetType()

	If (_SLS_FetishID.GetValue() == 3) && (akBaseItem.GetGoldValue() > 200)
		slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "getting jewelry or expensive item.")

	ElseIf (_SLS_FetishID.GetValue() == 13) && ( iuType == 41 )
		slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "getting a weapon.")

	ElseIf (_SLS_FetishID.GetValue() == 4) && ( iuType == 26 )
		slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "getting an armor.")

	EndIf
EndEvent

Function _Maintenance()
	; UnregisterForAllModEvents()
	Debug.Trace("SexLab Stories: Reset SexLab events")
	RegisterForModEvent("AnimationStart", "OnSexLabStart")
	RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")

	; _SLS_NPCSexCount.SetValue(-1)
EndFunction

Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 

	if !Self || !SexLab 
		Debug.Trace("SexLab Stories: Critical error on SexLab Start")
		Return
	EndIf
	
	; Debug.Notification("SexLab Hormones: Sex start")

	Actor[] actors = SexLab.HookActors(_args)
	Actor   victim = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim
	
	; Debug.Notification("Has player: " + _hasPlayer(actors))
	; Debug.Notification("Arousal trigger: " + (slaUtil.GetActorExposure(akRef = PlayerActor) / 3))

	; If (_hasPlayer(actors))

	; EndIf

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
		Debug.Trace("SexLab Stories: Critical error on SexLab End")
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

	if !Self || !SexLab 
		Debug.Trace("SexLab Stories: Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	; If (_hasPlayer(actors))
	;	Debug.Trace("SexLab Stories: Orgasm!")

	; EndIf
	
EndEvent


int function iMin(int a, int b)
	if (a<=b)
		return a
	else
		return b
	EndIf
EndFunction

int function iMax(int a, int b)
	if (a<b)
		return b
	else
		return a
	EndIf
EndFunction

float function fMin(float  a, float b)
	if (a<=b)
		return a
	else
		return b
	EndIf
EndFunction

float function fMax(float a, float b)
	if (a<b)
		return b
	else
		return a
	EndIf
EndFunction

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
			aBase = _actors[idx].GetBaseObject() as ActorBase
			aRace = aBase.GetRace()
			if aRace == thisRace
				return True
			endif
		EndIf
		idx += 1
	endwhile
	Return False
EndFunction

function _getGameStats()
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	; People Killed - Assaults - Murders  - Sneak Attacks - Backstabs
	int statPeopleKill = Game.QueryStat("People Killed") + Game.QueryStat("Assaults") + Game.QueryStat("Murders") + Game.QueryStat("Sneak Attacks") + Game.QueryStat("Backstabs") 

	; Animals Killed - Bunnies Slaughtered - Wings Plucked
	int statAnimalKill = Game.QueryStat("Animals Killed") + Game.QueryStat("Bunnies Slaughtered") + Game.QueryStat("Wings Plucked") 

	; Creatures Killed - Undead Killed - Daedra Killed - Automatons Killed
	int statCreatureKill = Game.QueryStat("Creatures Killed") + Game.QueryStat("Undead Killed") + Game.QueryStat("Daedra Killed") + Game.QueryStat("Automatons Killed") 

	; Spells Learned - Dragon Souls Collected - Words Of Power Learned - Words Of Power Unlocked - Shouts Learned - Shouts Unlocked - Shouts Mastered - Times Shouted - Soul Gems Used - Souls Trapped - Magic Items Made
	int statMagic = Game.QueryStat("Spells Learned") + Game.QueryStat("Dragon Souls Collected") +  Game.QueryStat("Words Of Power Learned") + Game.QueryStat("Words Of Power Unlocked") + Game.QueryStat("Shouts Learned") + Game.QueryStat("Shouts Unlocked") + Game.QueryStat("Shouts Mastered") + Game.QueryStat("Times Shouted") + Game.QueryStat("Soul Gems Used") + Game.QueryStat("Souls Trapped") + Game.QueryStat("Magic Items Made")

	; Weapons Improved - Weapons Made - Armor Improved - Armor Made - Potions Mixed - Poisons Mixed - Brawls Won - Critical Strikes
	int statCraft = Game.QueryStat("Weapons Improved") + Game.QueryStat("Weapons Made") + Game.QueryStat("Armor Improved") + Game.QueryStat("Armor Made") + Game.QueryStat("Potions Mixed") + Game.QueryStat("Poisons Mixed") + Game.QueryStat("Brawls Won") + Game.QueryStat("Critical Strikes")

	; Locks Picked - Pockets Picked - Items Pickpocketed - Times Jailed - Items Stolen - Trespasses
	int statCrime = Game.QueryStat("Locks Picked") + Game.QueryStat("Pockets Picked") + Game.QueryStat("Items Pickpocketed") + Game.QueryStat("Times Jailed") + Game.QueryStat("Items Stolen") + Game.QueryStat("Trespasses")

	StorageUtil.SetIntValue(akActor, "_SLS_statPeopleKillDiff", 0 )
	StorageUtil.SetIntValue(akActor, "_SLS_statAnimalKillDiff", 0 )
	StorageUtil.SetIntValue(akActor, "_SLS_statCreatureKillDiff", 0 )
	StorageUtil.SetIntValue(akActor, "_SLS_statMagicDiff", 0 )
	StorageUtil.SetIntValue(akActor, "_SLS_statCraftDiff", 0 )
	StorageUtil.SetIntValue(akActor, "_SLS_statCrimeDiff", 0 )

	StorageUtil.SetIntValue(akActor, "_SLS_statPeopleKill", statPeopleKill )
	StorageUtil.SetIntValue(akActor, "_SLS_statAnimalKill", statAnimalKill )
	StorageUtil.SetIntValue(akActor, "_SLS_statCreatureKill", statCreatureKill )
	StorageUtil.SetIntValue(akActor, "_SLS_statMagic", statMagic )
	StorageUtil.SetIntValue(akActor, "_SLS_statCraft", statCraft )
	StorageUtil.SetIntValue(akActor, "_SLS_statCrime", statCrime )

EndFunction

function _refreshGameStats()
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	; People Killed - Assaults - Murders  - Sneak Attacks - Backstabs
	int statPeopleKill = Game.QueryStat("People Killed") + Game.QueryStat("Assaults") + Game.QueryStat("Murders") + Game.QueryStat("Sneak Attacks") + Game.QueryStat("Backstabs") 

	; Animals Killed - Bunnies Slaughtered - Wings Plucked
	int statAnimalKill = Game.QueryStat("Animals Killed") + Game.QueryStat("Bunnies Slaughtered") + Game.QueryStat("Wings Plucked") 

	; Creatures Killed - Undead Killed - Daedra Killed - Automatons Killed
	int statCreatureKill = Game.QueryStat("Creatures Killed") + Game.QueryStat("Undead Killed") + Game.QueryStat("Daedra Killed") + Game.QueryStat("Automatons Killed") 

	; Spells Learned - Dragon Souls Collected - Words Of Power Learned - Words Of Power Unlocked - Shouts Learned - Shouts Unlocked - Shouts Mastered - Times Shouted - Soul Gems Used - Souls Trapped - Magic Items Made
	int statMagic = Game.QueryStat("Spells Learned") + Game.QueryStat("Dragon Souls Collected") +  Game.QueryStat("Words Of Power Learned") + Game.QueryStat("Words Of Power Unlocked") + Game.QueryStat("Shouts Learned") + Game.QueryStat("Shouts Unlocked") + Game.QueryStat("Shouts Mastered") + Game.QueryStat("Times Shouted") + Game.QueryStat("Soul Gems Used") + Game.QueryStat("Souls Trapped") + Game.QueryStat("Magic Items Made")

	; Weapons Improved - Weapons Made - Armor Improved - Armor Made - Potions Mixed - Poisons Mixed - Brawls Won - Critical Strikes
	int statCraft = Game.QueryStat("Weapons Improved") + Game.QueryStat("Weapons Made") + Game.QueryStat("Armor Improved") + Game.QueryStat("Armor Made") + Game.QueryStat("Potions Mixed") + Game.QueryStat("Poisons Mixed") + Game.QueryStat("Brawls Won") + Game.QueryStat("Critical Strikes")

	; Locks Picked - Pockets Picked - Items Pickpocketed - Times Jailed - Items Stolen - Trespasses
	int statCrime = Game.QueryStat("Locks Picked") + Game.QueryStat("Pockets Picked") + Game.QueryStat("Items Pickpocketed") + Game.QueryStat("Times Jailed") + Game.QueryStat("Items Stolen") + Game.QueryStat("Trespasses")

	StorageUtil.SetIntValue(akActor, "_SLS_statPeopleKillDiff", iMin(iMax(statPeopleKill - StorageUtil.GetIntValue(akActor, "_SLS_statPeopleKill"), 0), 5) )
	StorageUtil.SetIntValue(akActor, "_SLS_statAnimalKillDiff", iMin(iMax(statAnimalKill - StorageUtil.GetIntValue(akActor, "_SLS_statAnimalKill"), 0), 5) )
	StorageUtil.SetIntValue(akActor, "_SLS_statCreatureKillDiff", iMin(iMax(statCreatureKill - StorageUtil.GetIntValue(akActor, "_SLS_statCreatureKill"), 0), 5) )
	StorageUtil.SetIntValue(akActor, "_SLS_statMagicDiff", iMin(iMax(statMagic - StorageUtil.GetIntValue(akActor, "_SLS_statMagic"), 0), 5) )
	StorageUtil.SetIntValue(akActor, "_SLS_statCraftDiff", iMin(iMax(statCraft - StorageUtil.GetIntValue(akActor, "_SLS_statCraft"), 0), 5) )
	StorageUtil.SetIntValue(akActor, "_SLS_statCrimeDiff", iMin(iMax(statCrime - StorageUtil.GetIntValue(akActor, "_SLS_statCrime"), 0), 5) )

	StorageUtil.SetIntValue(akActor, "_SLS_statPeopleKill", statPeopleKill )
	StorageUtil.SetIntValue(akActor, "_SLS_statAnimalKill", statAnimalKill )
	StorageUtil.SetIntValue(akActor, "_SLS_statCreatureKill", statCreatureKill )
	StorageUtil.SetIntValue(akActor, "_SLS_statMagic", statMagic )
	StorageUtil.SetIntValue(akActor, "_SLS_statCraft", statCraft )
	StorageUtil.SetIntValue(akActor, "_SLS_statCrime", statCrime )

EndFunction



; slaUtil.SetActorExhibitionist(kSanguine, True)
; slaUtil.UpdateActorExposureRate(kSanguine, 10.0)

GlobalVariable Property _SLS_FetishID  Auto  
slaUtilScr Property slaUtil  Auto  
 


; bool nateOnMount = Nate.IsOnMount()

; if (Game.QueryStat("Houses Owned") == 5)
;     Debug.Trace("Player owns 5 houses!")
; endif

 
Keyword Property ArmorOn  Auto  

Keyword Property ClothingOn  Auto  

AssociationType Property SpouseType  Auto  
GlobalVariable Property _SLS_NPCSexCount  Auto  

Scriptname SLS_PlayerNordQueenAlias extends ReferenceAlias  


ReferenceAlias Property PlayerAlias  Auto  
SexLabFramework     property SexLab Auto

objectreference property SLS_PlayerNordQueenStorage auto

Armor Property NordQueenCrown Auto
Armor Property NordQueenDress Auto

Spell Property NordQueenStage0FX Auto
Spell Property NordQueenStage1FX Auto
Spell Property NordQueenStage2FX Auto
Spell Property NordQueenStage3FX Auto

SPELL Property RaiseZombie  Auto  
SPELL Property ReanimateCorpse  Auto  
SPELL Property CharmDraugr  Auto  
SPELL Property SummonGhost  Auto  

SPELL Property DrainUndeadPower  Auto  
SPELL Property NordSpiritPower  Auto  
SPELL Property ClearUndeadPower  Auto  
 
WordOfPower Property WordDrainEssence Auto
WordOfPower Property WordClearUndead Auto
WordOfPower Property WordSpiritOfNord Auto
WordOfPower Property WordKingSlayer Auto

Location Property FolgunthurLocation  Auto  
Location Property SaarthalLocation  Auto  
Location Property GeirmundHallLocation  Auto  
Location Property ReachwaterRockLocation  Auto  

Keyword Property SLS_NordQueenFX Auto

Race Property DraugrRace Auto
Race Property NordRace Auto

Faction Property DraugrFaction Auto
Faction Property UndeadFaction Auto

GlobalVariable Property PlayerNordQueenStage Auto
GlobalVariable Property  AllowPlayerShout Auto
Quest Property SLS_PlayerNordQueenQuest  Auto  

bool  bUpdateStage = false 
int iSexEnergy = -1

bool  bIsPregnant = false 
bool  bBeeingFemale = false 
bool  bEstrusChaurus = false 

int daysPassed
int iGameDateLastCheck = -1
int iDaysSinceLastCheck
int iDebtLastCheck


Event OnInit()
	_maintenance()
	RegisterForSingleUpdate(10)
EndEvent

Event OnPlayerLoadGame()
	_maintenance()
	RegisterForSingleUpdate(10)
EndEvent


Function _Maintenance()
	Actor PlayerActor= Game.GetPlayer() as Actor

	If (!StorageUtil.HasIntValue(none, "_SLS_iStoriesPlayerNordQueen"))
	 	StorageUtil.SetIntValue(none, "_SLS_iStoriesPlayerNordQueen", 0)
	EndIf

	UnregisterForAllModEvents()
	; Debug.Trace("SexLab Stories: Reset SexLab events")
	; RegisterForModEvent("AnimationStart", "OnSexLabStart")
	RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")

	RegisterForModEvent("_SLS_PlayerNordQueen", "OnPlayerNordQueen")

EndFunction

Event OnUpdate()
 	Actor PlayerActor= Game.GetPlayer() as Actor
	Location currentLocation = Game.GetPlayer().GetCurrentLocation()

	If  !Self || !SexLab || (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerNordQueen")==0)
		Return
	EndIf

 	daysPassed = Game.QueryStat("Days Passed")

 	; Initial values
 	if (iGameDateLastCheck == -1)
 		iGameDateLastCheck = daysPassed
 	endIf
 
	iDaysSinceLastCheck = (daysPassed - iGameDateLastCheck ) as Int

	If (iDaysSinceLastCheck > 0)
		; iDebtLastCheck = PlayerRedWaveDebt.GetValue() as Int

	elseIf (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerNordQueen")==1) && (iSexEnergy < 20)
		_RefreshQueenFX()

	endIf

	If (currentLocation)
		If currentLocation.IsSameLocation(FolgunthurLocation) && (!Game.IsWordUnlocked(WordDrainEssence))
			Debug.MessageBox("You are beginning to remember these halls. They still echo of the horrors you have suffered here. And with these painful memories come echoes of ancient words of powers you once knew.")

			PlayerActor.ModActorValue("DragonSouls", 1)
			Game.TeachWord(WordDrainEssence)
			Game.UnlockWord(WordDrainEssence)
			AllowPlayerShout.value = 1
		endif
		If currentLocation.IsSameLocation(SaarthalLocation) && (!Game.IsWordUnlocked(WordClearUndead))
			Debug.MessageBox("There is power deep in this place. You can feel it course through you. And with it comes another word of power you learned from Gauldur himself.")
			PlayerActor.ModActorValue("DragonSouls", 1)
			Game.TeachWord(WordClearUndead)
			Game.UnlockWord(WordClearUndead)
		endif
		If currentLocation.IsSameLocation(GeirmundHallLocation) && (!Game.IsWordUnlocked(WordSpiritOfNord))
			Debug.MessageBox("These ruins remind you of the birthright you have lost. Your connection to the land and the people runs deep. After all this time, you are still their queen.")
			PlayerActor.ModActorValue("DragonSouls", 1)
			Game.TeachWord(WordSpiritOfNord)
			Game.UnlockWord(WordSpiritOfNord)
		endif
		If currentLocation.IsSameLocation(ReachwaterRockLocation) && (!Game.IsWordUnlocked(WordKingSlayer))
			Debug.MessageBox("The spirit of Gauldur is near. You can feel the presence of your lover and mentor deep within these walls.")
			PlayerActor.ModActorValue("DragonSouls", 1)
			Game.TeachWord(WordKingSlayer)
			Game.UnlockWord(WordKingSlayer)
		endif
	Endif
	iGameDateLastCheck = daysPassed  

	RegisterForSingleUpdate(10)
EndEvent


Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	If  !Self || !SexLab || (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerNordQueen")==0)
		Return
	EndIf
	
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor PlayerActor= Game.GetPlayer() as Actor
	Int daysSinceLastPass 
	Int iGold 

	If (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerNordQueen")==1) && (iSexEnergy < 20)
		_RefreshQueenFX()

	endIf

EndEvent

Event OnPlayerNordQueen(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	StorageUtil.SetIntValue(none, "_SLS_iStoriesPlayerNordQueen", 1)

	If (!(StorageUtil.HasIntValue(none, "_SLS_iPlayerStartNordQueen")))
		StorageUtil.SetIntValue(none, "_SLS_iPlayerStartNordQueen", 0)
	EndIf

	; PlayerActor.MoveTo(SLS_PlayerRedWaveStartMarker)

	PlayerActor.RemoveAllItems(akTransferTo = SLS_PlayerNordQueenStorage, abKeepOwnership = True)

	PlayerActor.EquipItem(NordQueenCrown)
	PlayerActor.EquipItem(NordQueenDress)
	Utility.Wait(1.0)

	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryLevel", 1)
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryExposure", 50)
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iDaedricInfluence", 5)

	Int iNordQueenSkinColor = Math.LeftShift(255, 24) + Math.LeftShift(100, 16) + Math.LeftShift(200, 8) + 255
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", iNordQueenSkinColor ) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 0.2 ) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 0.0 ) 
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iForcedHairLoss", 1)
	PlayerActor.SendModEvent("SLHShaveHead")
	PlayerActor.SendModEvent("SLHRefresh")
	
	SendModEvent("SDSanguineBlessingMod", "", 5)  

	ModEvent.Send(ModEvent.Create("HoSLDD_GivePlayerPowers"))

	If (bBeeingFemale) && isFemale(PlayerActor)
		PlayerActor.SendModEvent("BeeingFemale", "ChangeState", 5)  ;5, 6, 7 for 2nd, 3rd, labor
		StorageUtil.SetFloatValue(PlayerActor,"FW.UnbornHealth",100.0)
		StorageUtil.UnsetIntValue(PlayerActor,"FW.Abortus")
		StorageUtil.FormListClear(PlayerActor,"FW.ChildFather")
		StorageUtil.SetIntValue(PlayerActor,"FW.NumChilds", 1)
		StorageUtil.FormListAdd(PlayerActor,"FW.ChildFather", none )

		SLS_PlayerNordQueenQuest.SetStage(15)
	Else
		SLS_PlayerNordQueenQuest.SetStage(10)
	EndIf

	PlayerActor.addtofaction(UndeadFaction) 

	StorageUtil.GetIntValue(PlayerActor, "_SLSL_iNordQueenPolymorphStage", 0)
	PlayerNordQueenStage.SetValue(0)
	iSexEnergy = 0
	; PlayerActor.SetGhost()
	; PlayerActor.SetAlpha(0.5)
	NordQueenStage0FX.Cast(PlayerActor,PlayerActor)

	RegisterForSingleUpdate(10)

EndEvent



Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 

 
	if !Self || !SexLab 
		Debug.Trace("SexLab Stories: Critical error on SexLab Start")
		Return
	EndIf

	If (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerNordQueen")==0)
		Return
	endif
	
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
    Int iPlayerPolymorphStage = 0

	if !Self || !SexLab  || (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerNordQueen")==0)
	;	Debug.Trace("SexLab Stories: Critical error on SexLab End")
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

	If (bUpdateStage)
		bUpdateStage = false
		iPlayerPolymorphStage = StorageUtil.GetIntValue(PlayerActor, "_SLSL_iNordQueenPolymorphStage")

		If (iSexEnergy<0)
			iSexEnergy = 0
		EndIf

		If  (iSexEnergy == 0) 

			PlayerActor.addtofaction(DraugrFaction) 		
			StorageUtil.SetIntValue(PlayerActor, "_SLSL_iNordQueenPolymorphStage", 0)
			PlayerNordQueenStage.SetValue(0)
			; PlayerActor.SetGhost()
			; PlayerActor.SetAlpha(0.8)
			PlayerActor.DispelSpell(NordQueenStage1FX)
			NordQueenStage0FX.Cast(PlayerActor,PlayerActor)

			If (StorageUtil.GetIntValue(none, "_SLH_iHormones") ==1)
				PlayerActor.SendModEvent("SLHShaveHead")
				PlayerActor.SendModEvent("yps-SetPubicHairLengthEvent", "", 0)
				PlayerActor.SendModEvent("yps-SetArmpitsHairLengthEvent", "", 0)
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 0.3 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBelly", 0.6 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButt", 0.6 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 0.0 )  
				PlayerActor.SendModEvent("SLHRefresh")
			Endif		

		ElseIf  (iSexEnergy >= 1) && (iSexEnergy < 5) && (iPlayerPolymorphStage!=1)
			if (!PlayerActor.HasSpell(RaiseZombie))
				PlayerActor.AddSpell(RaiseZombie)
			endif

			If (PlayerNordQueenStage.GetValue()!=1)
				Debug.MessageBox("The sweet taste of life force at last! You feel stronger as you skin regains some substance.")
			EndIf

			PlayerActor.addtofaction(DraugrFaction) 		
			StorageUtil.SetIntValue(PlayerActor, "_SLSL_iNordQueenPolymorphStage", 1)
			PlayerNordQueenStage.SetValue(1)
			; PlayerActor.SetGhost()
			; PlayerActor.SetAlpha(0.8)
			PlayerActor.DispelSpell(NordQueenStage0FX)
			PlayerActor.DispelSpell(NordQueenStage2FX)
			NordQueenStage1FX.Cast(PlayerActor,PlayerActor)

			If (StorageUtil.GetIntValue(none, "_SLH_iHormones") ==1)
				PlayerActor.SendModEvent("SLHShaveHead")
				PlayerActor.SendModEvent("yps-SetPubicHairLengthEvent", "", 0)
				PlayerActor.SendModEvent("yps-SetArmpitsHairLengthEvent", "", 0)
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 0.5 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBelly", 0.8 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButt", 0.8 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 0.0 )  
				PlayerActor.SendModEvent("SLHRefresh")
			Endif

		ElseIf  (iSexEnergy >= 5) && (iSexEnergy < 10) && (iPlayerPolymorphStage!=2)
			if (!PlayerActor.HasSpell(ReanimateCorpse))
				PlayerActor.AddSpell(ReanimateCorpse)
			endif

			If (PlayerNordQueenStage.GetValue()!=2)
				Debug.MessageBox("Sensations are slowly reaching your soul again, like an owverwhelming swarm of pins and needles.")
			EndIf

			PlayerActor.addtofaction(UndeadFaction) 			
			StorageUtil.SetIntValue(PlayerActor, "_SLSL_iNordQueenPolymorphStage", 2)
			PlayerNordQueenStage.SetValue(2)
			; PlayerActor.SetGhost()
			; PlayerActor.SetAlpha(0.9)
			PlayerActor.DispelSpell(NordQueenStage1FX)
			PlayerActor.DispelSpell(NordQueenStage3FX)
			NordQueenStage2FX.Cast(PlayerActor,PlayerActor)

			If (StorageUtil.GetIntValue(none, "_SLH_iHormones") ==1)
				PlayerActor.SendModEvent("SLHShaveHead")
				PlayerActor.SendModEvent("yps-SetPubicHairLengthEvent", "", 0)
				PlayerActor.SendModEvent("yps-SetArmpitsHairLengthEvent", "", 0)
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 0.7 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBelly", 0.9 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButt", 0.9 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 10.0 ) 
				PlayerActor.SendModEvent("SLHRefresh")
			Endif

		ElseIf  (iSexEnergy >= 10) && (iSexEnergy < 20) && (iPlayerPolymorphStage!=3)
			if (!PlayerActor.HasSpell(CharmDraugr))
				PlayerActor.AddSpell(CharmDraugr)
			Endif

			If (PlayerNordQueenStage.GetValue()!=3)
				Debug.MessageBox("You can feel the cold caress of air on your skin and the wetness between your legs. Your transformation is almost complete.")
			Endif

			PlayerActor.addtofaction(UndeadFaction) 
			StorageUtil.SetIntValue(PlayerActor, "_SLSL_iNordQueenPolymorphStage", 3)
			PlayerNordQueenStage.SetValue(3)
			; PlayerActor.SetGhost(false)
			; PlayerActor.SetAlpha(1.0)
			PlayerActor.DispelSpell(NordQueenStage2FX) 
			NordQueenStage3FX.Cast(PlayerActor,PlayerActor)

			If (StorageUtil.GetIntValue(none, "_SLH_iHormones") ==1)
				PlayerActor.SendModEvent("SLHShaveHead")
				PlayerActor.SendModEvent("yps-SetPubicHairLengthEvent", "", 0)
				PlayerActor.SendModEvent("yps-SetArmpitsHairLengthEvent", "", 0)
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 0.9 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBelly", 1.0 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButt", 1.0 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 20.0 ) 
				PlayerActor.SendModEvent("SLHRefresh")
			Endif

		ElseIf  (iSexEnergy >= 20) && (iPlayerPolymorphStage!=4)
			if (!PlayerActor.HasSpell(SummonGhost))
				PlayerActor.AddSpell(SummonGhost)
			endif

			If (PlayerNordQueenStage.GetValue()!=4)
				Debug.MessageBox("Reborn at last... you have now regained your lost beauty.")
			Endif

			PlayerActor.removefromfaction(UndeadFaction) 
			StorageUtil.SetIntValue(PlayerActor, "_SLSL_iNordQueenPolymorphStage", 4)
			PlayerNordQueenStage.SetValue(4)
			PlayerActor.DispelSpell(NordQueenStage3FX)

			If (StorageUtil.GetIntValue(none, "_SLH_iHormones") ==1)
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 1.5 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBelly", 1.2 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButt", 1.2 ) 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 50.0 ) 
				PlayerActor.SendModEvent("SLHRefresh")
			Endif

			ModEvent.Send(ModEvent.Create("HoSLDD_TakeAwayPlayerPowers"))

 			; SLS_PlayerNordQueenQuest.SetObjectiveDisplayed(21, false)
 			; SLS_PlayerNordQueenQuest.SetObjectiveDisplayed(22, false)
 			; SLS_PlayerNordQueenQuest.SetObjectiveDisplayed(23, false)

			; Game.ShowRaceMenu()
		EndIf


	endif

EndEvent 

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 

	if !Self || !SexLab  || (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerNordQueen")==0)
	;	Debug.Trace("SexLab Stories: Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	If (_hasPlayer(actors))
		If (_hasRace(actors, DraugrRace))
		;	Debug.Trace("SexLab Stories: Orgasm!")
			iSexEnergy = iSexEnergy + 1
			Debug.Notification("You can drain some Nord essence from sex with a draugr")
			Debug.Notification("Recovery energy " + iSexEnergy)
			bUpdateStage = true
 			SLS_PlayerNordQueenQuest.SetObjectiveDisplayed(22)
		ElseIf (_hasRace(actors, NordRace))
		;	Debug.Trace("SexLab Stories: Orgasm!")
			iSexEnergy = iSexEnergy + 5
			Debug.Notification("You can drain pure Nord essence from sex with a Nord")
			Debug.Notification("Recovery energy " + iSexEnergy)
			bUpdateStage = true
 			SLS_PlayerNordQueenQuest.SetObjectiveDisplayed(21)
		Else
			iSexEnergy = iSexEnergy - 1
			Debug.Notification("Sex with a non Nord drains you")
			Debug.Notification("Recovery energy " + iSexEnergy)
			bUpdateStage = true
 			SLS_PlayerNordQueenQuest.SetObjectiveDisplayed(23)
		EndIf

		If ((SLS_PlayerNordQueenQuest.GetStage()==10) || (SLS_PlayerNordQueenQuest.GetStage()==15))
			SLS_PlayerNordQueenQuest.SetStage(20)
		Endif
	EndIf
	
EndEvent


Function _RefreshQueenFX()
 	Actor PlayerActor= Game.GetPlayer() as Actor
	; Reapply magic effect if dispelled by cure disease or altar
	if (!PlayerActor.HasMagicEffectWithKeyword(SLS_NordQueenFX)) && (PlayerNordQueenStage.GetValue()!=4)
		Debug.Notification("[SLS] Skin refresh - Stage:" + PlayerNordQueenStage.GetValue() as Int)

		if (PlayerNordQueenStage.GetValue()==0)
			NordQueenStage0FX.Cast(PlayerActor,PlayerActor) ; Ghost FX
		elseif (PlayerNordQueenStage.GetValue()==1)
			NordQueenStage1FX.Cast(PlayerActor,PlayerActor) ; Shade FX
		elseif (PlayerNordQueenStage.GetValue()==2)
			NordQueenStage2FX.Cast(PlayerActor,PlayerActor) ; Zombie FX
		elseif (PlayerNordQueenStage.GetValue()==3)
			NordQueenStage3FX.Cast(PlayerActor,PlayerActor) ; Undead FX
		endIf
	endIf
EndFunction


bool function isPregnantBySoulGemOven(actor kActor) 
  	return (StorageUtil.GetIntValue(Game.GetPlayer(), "sgo_IsBellyScaling") == 1) || (StorageUtil.GetIntValue(Game.GetPlayer(), "sgo_IsBreastScaling ") == 1)

endFunction

bool function isPregnantBySimplePregnancy(actor kActor) 
  	return StorageUtil.HasFloatValue(kActor, "SP_Visual")

endFunction

bool function isPregnantByBeeingFemale(actor kActor)
  if ( (StorageUtil.GetIntValue(none, "_SLS_isBeeingFemaleON")==1 ) &&  ( (StorageUtil.GetIntValue(kActor, "FW.CurrentState")>=4) && (StorageUtil.GetIntValue(kActor, "FW.CurrentState")<=8))  )
    return true
  endIf
  return false
endFunction
 
bool function isPregnantByEstrusChaurus(actor kActor)
  spell  ChaurusBreeder 
  if (StorageUtil.GetIntValue(none, "_SLS_isCagedFollowerON") ==  1) 
  	ChaurusBreeder = StorageUtil.GetFormValue(none, "_SLS_getCagedFollowerQuestKeyword") as Spell
  	if (ChaurusBreeder != none)
    	return kActor.HasSpell(ChaurusBreeder)
    endif
  endIf
  return false
endFunction

bool function isPregnant(actor kActor)
	bIsPregnant = ( isPregnantBySoulGemOven(kActor) || isPregnantBySimplePregnancy(kActor) || isPregnantByBeeingFemale(kActor) || isPregnantByEstrusChaurus(kActor) || ((StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SuccubusON") == 1) && (StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SoulGemPregnancyON") == 1)) )
	Return bIsPregnant
EndFunction

Bool function isFemale(actor kActor)
	Bool bIsFemale
	ActorBase kActorBase = kActor.GetActorBase()

	if (kActorBase.GetSex() == 1) ; female
		bIsFemale = True
	Else
		bIsFemale = False
	EndIf

	return bIsFemale
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
	Actor kPlayer = Game.GetPlayer()

	int idx = 0
	while idx < _actors.Length
		if (_actors[idx]) && (_actors[idx] != kPlayer )
			; aBase = _actors[idx].GetBaseObject() as ActorBase
			; aRace = aBase.GetRace()
			aRace = _actors[idx].GetLeveledActorBase().GetRace()
			if (aRace == thisRace)
				return True
			endif
		EndIf
		idx += 1
	endwhile
	Return False
EndFunction





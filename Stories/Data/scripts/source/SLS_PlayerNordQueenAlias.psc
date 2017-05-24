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

Keyword Property SLS_NordQueenFX Auto

Race Property DraugrRace Auto
Race Property NordRace Auto

Faction Property draugrFaction Auto

GlobalVariable Property PlayerNordQueenStage Auto
Quest Property SLS_PlayerNordQueenQuest  Auto  

bool  bUpdateStage = false 
int iSexEnergy = -1

bool  bIsPregnant = false 
bool  bBeeingFemale = false 
bool  bEstrusChaurus = false 
spell  BeeingFemalePregnancy 
spell  ChaurusBreeder 

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

	_InitExternalPregancy()

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
		; iDebtLastCheck = PlayerRedWaveDebt.GetValue() as Int

	elseIf (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerNordQueen")==1) && (iSexEnergy < 20)
		_RefreshQueenFX()

	endIf

	iGameDateLastCheck = daysPassed  

	RegisterForSingleUpdate(10)
EndEvent


Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	If  !Self || !SexLab || (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerNordQueen")==0)
		Return
	EndIf
	
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()
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

	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryLevel", 0)
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryExposure", 0)

	Int iNordQueenSkinColor = Math.LeftShift(255, 24) + Math.LeftShift(100, 16) + Math.LeftShift(200, 8) + 255
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", iNordQueenSkinColor ) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 0.2 ) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 0.0 ) 
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iForcedHairLoss", 1)
	PlayerActor.SendModEvent("SLHShaveHead")
	PlayerActor.SendModEvent("SLHRefresh")

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

	PlayerActor.addtofaction(DraugrFaction) 

	StorageUtil.GetIntValue(PlayerActor, "_SLSL_iNordQueenPolymorphStage", 0)
	PlayerNordQueenStage.SetValue(0)
	iSexEnergy = 0
	; PlayerActor.SetGhost()
	; PlayerActor.SetAlpha(0.5)
	NordQueenStage0FX.Cast(PlayerActor,PlayerActor)

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

		If (iSexEnergy<0)
			iSexEnergy = 0
		EndIf
		
		If (PlayerNordQueenStage.GetValue()!=1) && (iSexEnergy >= 1) && (iSexEnergy < 5)
			if (!PlayerActor.HasSpell(RaiseZombie))
				PlayerActor.AddSpell(RaiseZombie)
			endif

			PlayerActor.addtofaction(DraugrFaction) 		
			StorageUtil.SetIntValue(PlayerActor, "_SLSL_iNordQueenPolymorphStage", 1)
			PlayerNordQueenStage.SetValue(1)
			; PlayerActor.SetGhost()
			; PlayerActor.SetAlpha(0.8)
			PlayerActor.DispelSpell(NordQueenStage0FX)
			PlayerActor.DispelSpell(NordQueenStage2FX)
			NordQueenStage1FX.Cast(PlayerActor,PlayerActor)

			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 0.5 ) 
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 10.0 ) 
			StorageUtil.SetIntValue(PlayerActor, "_SLH_iForcedHairLoss", 1)
			PlayerActor.SendModEvent("SLHRefresh")

			Debug.MessageBox("The sweet taste of life force at last! You feel stronger as you skin regains some substance.")

		ElseIf (PlayerNordQueenStage.GetValue()!=2) && (iSexEnergy >= 5) && (iSexEnergy < 10)
			if (!PlayerActor.HasSpell(ReanimateCorpse))
				PlayerActor.AddSpell(ReanimateCorpse)
			endif

			PlayerActor.addtofaction(DraugrFaction) 			
			StorageUtil.SetIntValue(PlayerActor, "_SLSL_iNordQueenPolymorphStage", 2)
			PlayerNordQueenStage.SetValue(2)
			; PlayerActor.SetGhost()
			; PlayerActor.SetAlpha(0.9)
			PlayerActor.DispelSpell(NordQueenStage1FX)
			PlayerActor.DispelSpell(NordQueenStage3FX)
			NordQueenStage2FX.Cast(PlayerActor,PlayerActor)

			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 1.0 ) 
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 30.0 ) 
			StorageUtil.SetIntValue(PlayerActor, "_SLH_iForcedHairLoss", 1)
			PlayerActor.SendModEvent("SLHRefresh")

			Debug.MessageBox("Sensations are slowly reaching your soul again, like an owverwhelming swarm of pins and needles.")

		ElseIf (PlayerNordQueenStage.GetValue()!=3) && (iSexEnergy >= 10) && (iSexEnergy < 20)
			if (!PlayerActor.HasSpell(CharmDraugr))
				PlayerActor.AddSpell(CharmDraugr)
			Endif

			PlayerActor.addtofaction(DraugrFaction) 
			StorageUtil.SetIntValue(PlayerActor, "_SLSL_iNordQueenPolymorphStage", 3)
			PlayerNordQueenStage.SetValue(3)
			; PlayerActor.SetGhost(false)
			; PlayerActor.SetAlpha(1.0)
			PlayerActor.DispelSpell(NordQueenStage2FX) 
			NordQueenStage3FX.Cast(PlayerActor,PlayerActor)

			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 1.5 ) 
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 5.0 ) 
			StorageUtil.SetIntValue(PlayerActor, "_SLH_iForcedHairLoss", 1)
			PlayerActor.SendModEvent("SLHRefresh")

			Debug.MessageBox("You can feel the cold caress of air on your skin and the wetness between your legs. Your transformation is almost complete.")

		ElseIf (PlayerNordQueenStage.GetValue()!=4) && (iSexEnergy >= 20)
			if (!PlayerActor.HasSpell(SummonGhost))
				PlayerActor.AddSpell(SummonGhost)
			endif

			PlayerActor.removefromfaction(DraugrFaction) 
			StorageUtil.SetIntValue(PlayerActor, "_SLSL_iNordQueenPolymorphStage", 4)
			PlayerNordQueenStage.SetValue(4)
			PlayerActor.DispelSpell(NordQueenStage3FX)

			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 2.0 ) 
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 80.0 ) 
			PlayerActor.SendModEvent("SLHRefresh")

			ModEvent.Send(ModEvent.Create("HoSLDD_TakeAwayPlayerPowers"))

			Debug.MessageBox("Reborn at last... you have now regained your lost beauty.")

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
		ElseIf (_hasRace(actors, NordRace))
		;	Debug.Trace("SexLab Stories: Orgasm!")
			iSexEnergy = iSexEnergy + 5
			Debug.Notification("You can drain pure Nord essence from sex with a Nord")
			Debug.Notification("Recovery energy " + iSexEnergy)
			bUpdateStage = true
		Else
			iSexEnergy = iSexEnergy - 1
			Debug.Notification("Sex with a non Nord drains you")
			Debug.Notification("Recovery energy " + iSexEnergy)
			bUpdateStage = true
 
		EndIf
	EndIf
	
EndEvent


Function _RefreshQueenFX()
 	Actor PlayerActor= Game.GetPlayer() as Actor
	; Reapply magic effect if dispelled by cure disease or altar
	if (!PlayerActor.HasMagicEffectWithKeyword(SLS_NordQueenFX)) && (PlayerNordQueenStage.GetValue()!=4)
		Debug.Notification("[SLS] Skin refresh - Stage:" + PlayerNordQueenStage.GetValue() as Int)

		if (PlayerNordQueenStage.GetValue()==0)
			NordQueenStage0FX.Cast(PlayerActor,PlayerActor)
		elseif (PlayerNordQueenStage.GetValue()==1)
			NordQueenStage1FX.Cast(PlayerActor,PlayerActor)
		elseif (PlayerNordQueenStage.GetValue()==2)
			NordQueenStage2FX.Cast(PlayerActor,PlayerActor)
		elseif (PlayerNordQueenStage.GetValue()==3)
			NordQueenStage3FX.Cast(PlayerActor,PlayerActor)
		endIf
	endIf
EndFunction

Function _InitExternalPregancy()
	bEstrusChaurus = false
	bBeeingFemale = false
	int idx = Game.GetModCount()
	string modName = ""
	while idx > 0
	idx -= 1
	modName = Game.GetModName(idx)

	if modName == "EstrusChaurus.esp"
	  bEstrusChaurus = true
	  ChaurusBreeder = Game.GetFormFromFile(0x00019121, modName) as spell

	elseif modName == "BeeingFemale.esm"
	  bBeeingFemale = true
	  BeeingFemalePregnancy = Game.GetFormFromFile(0x000028A0, modName) as spell
	endif
	endWhile
EndFunction

bool function isPregnantBySoulGemOven(actor kActor) 
  	return (StorageUtil.GetIntValue(Game.GetPlayer(), "sgo_IsBellyScaling") == 1) || (StorageUtil.GetIntValue(Game.GetPlayer(), "sgo_IsBreastScaling ") == 1)

endFunction

bool function isPregnantBySimplePregnancy(actor kActor) 
  	return StorageUtil.HasFloatValue(kActor, "SP_Visual")

endFunction

bool function isPregnantByBeeingFemale(actor kActor)
	 if ( (bBeeingFemale==true) &&  ( (StorageUtil.GetIntValue(kActor, "FW.CurrentState")>=4) && (StorageUtil.GetIntValue(kActor, "FW.CurrentState")<=8))  )
    	return true
	endIf
	return false
endFunction
 
bool function isPregnantByEstrusChaurus(actor kActor)
	if bEstrusChaurus==true && ChaurusBreeder != none
	return kActor.HasSpell(ChaurusBreeder)
	endIf
	return false
endFunction

bool function isPregnant(actor kActor)
	bIsPregnant = ( isPregnantBySoulGemOven(kActor) || isPregnantBySimplePregnancy(kActor) || isPregnantByBeeingFemale(kActor) || isPregnantByEstrusChaurus(kActor) || ((StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SuccubusON") == 1) && (StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SoulGemPregnancyON") == 1)) )
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


Scriptname SLP_PlayerChaurusQueenAlias extends ReferenceAlias  

ReferenceAlias Property PlayerAlias  Auto  
SexLabFramework     property SexLab Auto
SLP_fcts_parasites Property fctParasites  Auto
SLP_fcts_outfits Property fctOutfits  Auto

Quest Property SLP_PlayerChaurusQueenQuest  Auto  
ReferenceAlias Property _SLP_LastelleRef  Auto  
ReferenceAlias Property _SLP_ChaurusStudRef  Auto  
ReferenceAlias Property _SLP_ChaurusStudLastelleRef  Auto  

GlobalVariable Property _SLP_ChaurusStudWithLastelle Auto
GlobalVariable Property _SLP_isPlayerStartQueenOfChaurus Auto
GlobalVariable Property _SLP_isPlayerStartBroodMaiden Auto
GlobalVariable Property _SLP_GV_numInfections Auto

objectreference property SLP_PlayerChaurusQueenStorage auto
objectreference property SLP_PlayerBroodMaidenStorage auto

objectreference property SLP_PlayerChaurusQueenStartMarker auto
objectreference property SLP_PlayerBroodMaidenStartMarker auto

objectreference property SLP_PlayerChaurusQueenSlaver auto

Race Property ChaurusRace Auto
Race Property FalmerRace Auto



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

	If (!StorageUtil.HasIntValue(none, "_SLS_iStoriesPlayerChaurusQueen"))
	 	StorageUtil.SetIntValue(none, "_SLS_iStoriesPlayerChaurusQueen", 0)
	EndIf

	If (!StorageUtil.HasIntValue(none, "_SLS_iStoriesPlayerBroodMaiden"))
	 	StorageUtil.SetIntValue(none, "_SLS_iStoriesPlayerBroodMaiden", 0)
	EndIf

	If ( (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerChaurusQueen")==1) && (_SLP_GV_isPlayerStartChaurusQueen.GetValue()==0) )
		_SLP_GV_isPlayerStartChaurusQueen.SetValue(1)
	Endif

	If ( (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerBroodMaiden")==1) && (_SLP_GV_isPlayerStartBroodMaiden.GetValue()==0) )
		_SLP_GV_isPlayerStartBroodMaiden.SetValue(1)
	Endif


	If (isPregnantByEstrusChaurus(PlayerActor)) && (StorageUtil.GetIntValue(PlayerActor, "_SLP_iInfections") ==0 )

		StorageUtil.SetIntValue(PlayerActor, "_SLP_iInfections",  StorageUtil.GetIntValue(PlayerActor, "_SLP_iInfections") + 1)

		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(PlayerActor, "_SLP_iInfections"))
	Endif

	UnregisterForAllModEvents()
	; Debug.Trace("SexLab Stories: Reset SexLab events")
	; RegisterForModEvent("AnimationStart", "OnSexLabStart")
	; RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	; RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")

	RegisterForModEvent("_SLP_PlayerChaurusQueen", "OnPlayerChaurusQueen")
	RegisterForModEvent("_SLP_PlayerBroodMaiden", "OnPlayerBroodMaiden")

	; _InitExternalPregancy()

EndFunction

Event OnUpdate()
 	Actor PlayerActor= Game.GetPlayer() as Actor
 	Actor kChaurusStud = _SLP_ChaurusStudRef.GetReference() as Actor

 	daysPassed = Game.QueryStat("Days Passed")

 	; Initial values
 	if (iGameDateLastCheck == -1)
 		iGameDateLastCheck = daysPassed
 	endIf
 
	iDaysSinceLastCheck = (daysPassed - iGameDateLastCheck ) as Int

	If (iDaysSinceLastCheck > 0)
		; iDebtLastCheck = PlayerRedWaveDebt.GetValue() as Int

	elseIf (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerChaurusQueen")==1)
		; _RefreshQueenFX()
		if (kChaurusStud==None) || (kChaurusStud.IsDead())
			_SLP_ChaurusStudWithLastelle.SetValue(0)
			_SLP_ChaurusStudRef.clear()
		Endif

	endIf

	iGameDateLastCheck = daysPassed  

	RegisterForSingleUpdate(10)
EndEvent



Event OnPlayerChaurusQueen(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor
	Int iFalmerSkinColor = Math.LeftShift(255, 24) + Math.LeftShift(100, 16) + Math.LeftShift(200, 8) + 255
	Float	breastMod = 0.25
	Float	weightMod = 2.0

	StorageUtil.SetIntValue(none, "_SLS_iStoriesPlayerChaurusQueen", 1)

	; If (!(StorageUtil.HasIntValue(none, "_SLS_iPlayerStartChaurusQueen")))
		StorageUtil.SetIntValue(none, "_SLS_iPlayerStartChaurusQueen", 1)
		_SLP_isPlayerStartQueenOfChaurus.SetValue(1)
	; EndIf

	; FalmerSlaver.sendModEvent("PCSubEnslave")
	PlayerActor.MoveTo(SLP_PlayerChaurusQueenStartMarker)
	PlayerActor.RemoveAllItems(akTransferTo = SLP_PlayerChaurusQueenStorage, abKeepOwnership = True)

	PlayerActor.SendModEvent("SLPInfectChaurusWorm")

	Debug.Notification("The tingling in your nipples is driving you mad.")

	StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", iFalmerSkinColor ) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBreast" ) + breastMod ) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", StorageUtil.GetFloatValue(PlayerActor, "_SLH_fWeight" ) + weightMod ) 
	PlayerActor.SendModEvent("SLHRefresh")
	PlayerActor.SendModEvent("SLHRefreshColors")

	SLP_PlayerChaurusQueenSlaver.SendModEvent("PCSubEnslave")

	SLP_PlayerChaurusQueenQuest.SetStage(10)

EndEvent

Event OnPlayerBroodMaiden(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor
	Actor LastelleActor= _SLP_LastelleRef.GetReference() as Actor
	ActorBase pActorBase = LastelleActor.GetActorBase()

	StorageUtil.SetIntValue(none, "_SLS_iStoriesPlayerBroodMaiden", 1)

	; If (!(StorageUtil.HasIntValue(none, "_SLS_iPlayerStartBroodMaiden")))
		StorageUtil.SetIntValue(none, "_SLS_iPlayerStartBroodMaiden", 1)
		_SLP_isPlayerStartBroodMaiden.SetValue(1)
	; EndIf

	; FalmerSlaver.sendModEvent("PCSubEnslave")

	PlayerActor.MoveTo(SLP_PlayerBroodMaidenStartMarker)
	PlayerActor.RemoveAllItems(akTransferTo = SLP_PlayerBroodMaidenStorage, abKeepOwnership = True)

	pActorBase.SetWeight(0.0) 
	fctParasites.infectEstrusTentacles( LastelleActor   )
	fctParasites.infectEstrusChaurusEgg( LastelleActor )
	; fctParasites.infectChaurusWormVag( LastelleActor   )

	SLP_PlayerChaurusQueenQuest.SetStage(20)

EndEvent



Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 

 
	if !Self || !SexLab   || (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerChaurusQueen")==0)
	;	Debug.Trace("SexLab Stories: Critical error on SexLab Start")
		Return
	EndIf

	If (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerChaurusQueen")==0)
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

	if !Self || !SexLab  || (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerChaurusQueen")==0)
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


EndEvent 

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 

	if !Self || !SexLab  || (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerChaurusQueen")==0)
	;	Debug.Trace("SexLab Stories: Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	If (_hasPlayer(actors))
		If (_hasRace(actors, FalmerRace))
		;	Debug.Trace("SexLab Stories: Orgasm!")

		ElseIf (_hasRace(actors, ChaurusRace))
		;	Debug.Trace("SexLab Stories: Orgasm!")

		Else

		EndIf
	EndIf
	
EndEvent





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
GlobalVariable Property _SLP_GV_isPlayerStartChaurusQueen  Auto  

GlobalVariable Property _SLP_GV_isPlayerStartBroodMaiden  Auto  

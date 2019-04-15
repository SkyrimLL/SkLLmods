Scriptname SLS_PlayerSexBotAlias extends ReferenceAlias  


ReferenceAlias Property PlayerAlias  Auto  
SexLabFramework     property SexLab Auto

Quest Property SLS_PlayerSexBotQuest  Auto  

; objectreference property SLS_PlayerNordQueenStorage auto

ObjectReference Property FalmerSlaver Auto


bool  bIsPregnant = false 
bool  bBeeingFemale = false 
bool  bEstrusChaurus = false 
spell  BeeingFemalePregnancy  

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

	If (!StorageUtil.HasIntValue(none, "_SLS_iStoriesPlayerSexBot"))
	 	StorageUtil.SetIntValue(none, "_SLS_iStoriesPlayerSexBot", 0)
	EndIf

	UnregisterForAllModEvents()
	; Debug.Trace("SexLab Stories: Reset SexLab events")
	; RegisterForModEvent("AnimationStart", "OnSexLabStart")
	; RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	; RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")

	RegisterForModEvent("_SLS_PlayerSexBot", "OnPlayerSexBot")
 

EndFunction

Event OnUpdate()
 	Actor PlayerActor= Game.GetPlayer() as Actor

	If (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerSexBot")==0)
		Return
	endif
	

 	daysPassed = Game.QueryStat("Days Passed")

 	; Initial values
 	if (iGameDateLastCheck == -1)
 		iGameDateLastCheck = daysPassed
 	endIf
 
	iDaysSinceLastCheck = (daysPassed - iGameDateLastCheck ) as Int

	If (iDaysSinceLastCheck > 0)
		; iDebtLastCheck = PlayerRedWaveDebt.GetValue() as Int

	elseIf (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerSexBot")==1)
		; _RefreshQueenFX()

	endIf

	iGameDateLastCheck = daysPassed  

	RegisterForSingleUpdate(10)
EndEvent



Event OnPlayerSexBot(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	StorageUtil.SetIntValue(none, "_SLS_iStoriesPlayerSexBot", 1)

	If (!(StorageUtil.HasIntValue(none, "_SLS_iPlayerStartSexBot")))
		StorageUtil.SetIntValue(none, "_SLS_iPlayerStartSexBot", 0)
	EndIf

	FalmerSlaver.sendModEvent("PCSubEnslave")

	SLS_PlayerSexBotQuest.SetStage(10)

	RegisterForSingleUpdate(10)

EndEvent



Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 

 
	if !Self || !SexLab  || (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerSexBot")==0)
	; 	Debug.Trace("SexLab Stories: Critical error on SexLab Start")
		Return
	EndIf

	If (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerSexBot")==0)
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

	if !Self || !SexLab  || (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerSexBot")==0)
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

	if !Self || !SexLab  || (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerSexBot")==0)
		Debug.Trace("SexLab Stories: Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	If (_hasPlayer(actors))

	EndIf
	
EndEvent





Function _InitExternalPregancy()
	; Obsolete - replaced by function in SLS_playeralias_fetish
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
  	ChaurusBreeder = StorageUtil.GetFormValue(none, "_SLS_getEstrusChaurusBreederSpell") as Spell
  	if (ChaurusBreeder != none)
    	return kActor.HasSpell(ChaurusBreeder)
    endif
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


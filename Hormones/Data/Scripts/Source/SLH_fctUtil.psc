Scriptname SLH_fctUtil extends Quest  

GlobalVariable      Property GV_changeOverrideToggle	Auto

; SexLab Aroused
Int iOrigSLAExposureRank = -3
Faction  Property kfSLAExposure Auto
slaUtilScr Property slaUtil  Auto  

GlobalVariable      Property GV_allowExhibitionist		Auto 

bool property bIsPregnant = false auto
bool property bBeeingFemale = false auto
bool property bEstrusChaurus = false auto
spell property BeeingFemalePregnancy auto
spell property ChaurusBreeder auto

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

int function iRange(int val, int minVal, int maxVal)
	return iMin( iMax( val, minVal), maxVal)
endFunction

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

float function fRange(float val, float minVal, float maxVal)
	return fMin( fMax( val, minVal), maxVal)
endFunction

String Function actorName(Actor _person)
	return _person.GetLeveledActorBase().GetName()
EndFunction

String function notify(String _text)
	; If config.bDebugMsg
		debug.Notification(_text)
	; EndIf
EndFunction

function castSpell(Actor[] _actors, Actor _skip, Spell _spell)
	int idx = 0
	
	While idx < _actors.Length
		if _actors[idx] && _actors[idx] != _skip
			notify("Spell:" + _spell.GetName() + "->" + actorName(_actors[idx]))
			_spell.RemoteCast(_actors[idx], _actors[idx], _actors[idx])
		endif
		idx += 1
	EndWhile
EndFunction

function castSpell1st(Actor[] _actors, Spell _spell)
	int idx = 0
	
	if _actors.Length > 0
		if _actors[idx]
			notify("Spell:" + _spell.GetName() + "->" + actorName(_actors[idx]))
			_spell.RemoteCast(_actors[idx], _actors[idx], _actors[idx])
		endif
	EndIf
EndFunction


function listActors(String _txt, Actor[] _actors)
	int idx = 0
	While idx < _actors.Length
		; Debug.Notification(_txt + actorName(_actors[idx]))
		idx += 1
	EndWhile
EndFunction


Bool function hasPlayer(Actor[] _actors)
	ObjectReference PlayerREF= Game.GetPlayer()

	int idx = 0
	while idx < _actors.Length
		if _actors[idx] == PlayerRef
			return True
		endif
		idx += 1
	endwhile
	Return False
EndFunction

Bool function hasActor(Actor[] _actors, Actor thisActor)

	int idx = 0
	while idx < _actors.Length
		if _actors[idx] == thisActor as ObjectReference
			return True
		endif
		idx += 1
	endwhile
	Return False
EndFunction

Bool function hasRace(Actor[] _actors, Race thisRace)
	ActorBase aBase 
	Race aRace 

	; debugTrace("[SLH] Race check:" + _actors.Length + " actors" )

	int idx = 0
	while idx < _actors.Length
		if (_actors[idx])
			; aBase = _actors[idx].GetBaseObject() as ActorBase
			aRace = _actors[idx].GetRace()

			; debugTrace("[SLH] Race check:" + aRace + " / "  + thisRace)

			if aRace == thisRace
				return True
			endif
		EndIf
		idx += 1
	endwhile
	Return False
EndFunction

Actor function getRaceActor(Actor[] _actors, Race thisRace)
	ActorBase aBase 
	Race aRace 

	; debugTrace("[SLH] Race check:" + _actors.Length + " actors" )

	int idx = 0
	while idx < _actors.Length
		if (_actors[idx])
			; aBase = _actors[idx].GetBaseObject() as ActorBase
			aRace = _actors[idx].GetRace()

			; debugTrace("[SLH] Race check:" + aRace + " / "  + thisRace)

			if aRace == thisRace
				return _actors[idx]
			endif
		EndIf
		idx += 1
	endwhile
	Return None
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

Bool function isMale(actor kActor)
	Bool bIsMale
	ActorBase kActorBase = kActor.GetActorBase()

	if (kActorBase.GetSex() == 0) ; male
		bIsMale = True
	Else
		bIsMale = False
	EndIf

	return bIsMale
EndFunction

Bool function isSameSex(actor kActor1, actor kActor2)
	Bool bIsSameSex = false

	bIsSameSex = (isFemale(kActor1) && isFemale(kActor2)) || (isMale(kActor1) && isMale(kActor2)) 

	return bIsSameSex
EndFunction

bool function isFHUCumFilledEnabled(actor kActor) 
  	return (StorageUtil.GetIntValue(Game.GetPlayer(), "CI_CumInflation_ON") == 1) 

endFunction

bool function isPregnantBySoulGemOven(actor kActor) 
  	return (StorageUtil.GetIntValue(Game.GetPlayer(), "sgo_IsBellyScaling") == 1) || (StorageUtil.GetIntValue(Game.GetPlayer(), "sgo_IsBreastScaling ") == 1)

endFunction

bool function isPregnantBySimplePregnancy(actor kActor) 
  	return StorageUtil.HasFloatValue(kActor, "SP_Visual")

endFunction

bool function isPregnantByBeeingFemale(actor kActor)
  if bBeeingFemale==true && BeeingFemalePregnancy != none
    return kActor.HasSpell(BeeingFemalePregnancy)
  endIf
  return false
endFunction
 
bool function isPregnantByEstrusChaurus(actor kActor)
  if bEstrusChaurus==true && ChaurusBreeder != none
    return kActor.HasSpell(ChaurusBreeder)
  endIf
  return false
endFunction

bool function isExternalChangeModActive(actor kActor)
	ObjectReference kActorREF = kActor as ObjectReference 
	ActorBase pActorBase = kActor.GetActorBase()
	Float fCurrentWeight = pActorBase.GetWeight()

	bIsPregnant = ( isPregnantBySoulGemOven(kActor) || isPregnantBySimplePregnancy(kActor) || isPregnantByBeeingFemale(kActor) || isPregnantByEstrusChaurus(kActor) || ((StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SuccubusON") == 1) && (StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SoulGemPregnancyON") == 1)) )

	Return bIsPregnant || (GV_changeOverrideToggle.GetValue() == 0) || ((fCurrentWeight!=StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")) && (StorageUtil.GetFloatValue(kActor, "_SLH_fManualWeightChange") == -1))

endFunction

function manageSexLabAroused(Actor kActor, int aiModRank = -1)
 
	Float Libido = StorageUtil.GetFloatValue(kActor, "_SLH_fLibido" ) 
	Float AbsLibido = Math.abs(Libido)
	
	If (Libido > 0)
		If (GV_allowExhibitionist.GetValue() == 1) && ((StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1) || (StorageUtil.GetIntValue(kActor, "_SLH_isBimbo") == 1) || (StorageUtil.GetIntValue(kActor, "_SLH_isSuccubus") == 1))
			If (AbsLibido >= 50)
				slaUtil.SetActorExhibitionist(kActor, True)
			Else
				slaUtil.SetActorExhibitionist(kActor, False)
			EndIf
		EndIf
		
	    slaUtil.UpdateActorExposureRate(kActor, AbsLibido / 10.0)
	EndIf

	if (StorageUtil.GetIntValue(kActor, "_SLH_isSuccubus") == 1)
		slaUtil.UpdateActorExposureRate(kActor, 9.0)
	EndIf

	if (StorageUtil.GetIntValue(kActor, "_SLH_isBimbo") == 1)
		slaUtil.UpdateActorExposureRate(kActor, 5.0)
	EndIf

	if (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1)
		slaUtil.UpdateActorExposureRate(kActor, 3.0)
	EndIf

	if ( StorageUtil.GetIntValue(kActor, "_SLH_isDrugged") == 1)
		slaUtil.UpdateActorExposureRate(kActor, 9.0)
	EndIf

endFunction


Function debugTrace(string traceMsg)
	if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
		Debug.Trace(traceMsg)
	endif
endFunction


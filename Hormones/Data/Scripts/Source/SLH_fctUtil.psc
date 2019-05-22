Scriptname SLH_fctUtil extends Quest

; SexLab Aroused
Int iOrigSLAExposureRank = -3
slaUtilScr Property slaUtil  Auto
SexlabFramework Property SexLab Auto

GlobalVariable      Property GV_allowExhibitionist		Auto
GlobalVariable      Property GV_changeOverrideToggle	Auto
GlobalVariable      Property GV_isGagEquipped			Auto
GlobalVariable      Property GV_isPlugEquipped			Auto

bool property bIsPregnant = false auto hidden

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

Bool function hasFormKeyword(Actor[] _actors, Keyword thisKeyword)
	Form kForm

	; debugTrace(" Keyword check:" + _actors.Length + " actors" )

	int idx = 0
	while idx < _actors.Length
		if (_actors[idx])
			kForm = _actors[idx] as Form

			; debugTrace(" Keyword check:" + thisKeyword + " / "  + kForm.HasKeyword(thisKeyword))

			if kForm.HasKeyword(thisKeyword)
				return True
			endif
		EndIf
		idx += 1
	endwhile

	Return False
EndFunction

Bool function hasRace(Actor[] _actors, Race thisRace)
	Race aRace

	; debugTrace(" Race check:" + _actors.Length + " actors" )

	int idx = 0
	while idx < _actors.Length
		if (_actors[idx])
			; aBase = _actors[idx].GetBaseObject() as ActorBase
			aRace = _actors[idx].GetRace()

			; debugTrace(" Race check:" + aRace + " / "  + thisRace)

			if aRace == thisRace
				return True
			endif
		EndIf
		idx += 1
	endwhile

	Return False
EndFunction

Actor function getRaceActor(Actor[] _actors, Race thisRace)
	Race aRace

	; debugTrace(" Race check:" + _actors.Length + " actors" )

	int idx = 0
	while idx < _actors.Length
		if (_actors[idx])
			; aBase = _actors[idx].GetBaseObject() as ActorBase
			aRace = _actors[idx].GetRace()

			; debugTrace(" Race check:" + aRace + " / "  + thisRace)

			if aRace == thisRace
				return _actors[idx]
			endif
		EndIf
		idx += 1
	endwhile

	Return None
EndFunction

function checkGender(actor kActor)
	ActorBase kActorBase = kActor.GetActorBase()

	; Debug.Trace("[SLH] Sex from Actorbase:" + kActorBase.GetSex())
	; Debug.Trace("[SLH] Sex from Sexlab:" + Sexlab.GetGender(kActor))

	if (kActorBase.GetSex() == 1) ; female
		StorageUtil.SetIntValue(kActor, "_SLH_isFemale", 1)
		StorageUtil.SetIntValue(kActor, "_SLH_isMale", 0)
	Else
		StorageUtil.SetIntValue(kActor, "_SLH_isFemale", 0)
		StorageUtil.SetIntValue(kActor, "_SLH_isMale", 1)
	EndIf
EndFunction

Bool function isFemale(actor kActor)
	return (StorageUtil.GetIntValue(kActor, "_SLH_isFemale") as Bool)
EndFunction

Bool function isMale(actor kActor)
	return (StorageUtil.GetIntValue(kActor, "_SLH_isMale") as Bool)
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
	if ( (StorageUtil.GetIntValue(none, "_SLS_isBeeingFemaleON")==1 ) && ((StorageUtil.GetIntValue(kActor, "FW.CurrentState")>=4) && (StorageUtil.GetIntValue(kActor, "FW.CurrentState")<=8)) )
		return true
	endIf

	return false
endFunction

bool function isPregnantByEstrusChaurus(actor kActor)
	Spell ChaurusBreeder
	if (StorageUtil.GetIntValue(none, "_SLS_isCagedFollowerON") == 1)
		ChaurusBreeder = StorageUtil.GetFormValue(none, "_SLS_getEstrusChaurusBreederSpell") as Spell
		if (ChaurusBreeder != none)
			return kActor.HasSpell(ChaurusBreeder)
		endif
	endIf

	return false
endFunction

bool function isExternalChangeModActive(actor kActor)
	ActorBase pActorBase = kActor.GetActorBase()
	Float fCurrentWeight = pActorBase.GetWeight()
	Actor kPlayer = Game.GetPlayer()

	bIsPregnant = ( isPregnantBySoulGemOven(kActor) || isPregnantBySimplePregnancy(kActor) || isPregnantByBeeingFemale(kActor) || isPregnantByEstrusChaurus(kActor) || ((StorageUtil.GetIntValue(kPlayer, "PSQ_SuccubusON") == 1) && (StorageUtil.GetIntValue(kPlayer, "PSQ_SoulGemPregnancyON") == 1)) )

	Return bIsPregnant || (GV_changeOverrideToggle.GetValue() == 0) || ((fCurrentWeight!=StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")) && (StorageUtil.GetFloatValue(kActor, "_SLH_fManualWeightChange") == -1))
endFunction

function manageSexLabAroused(Actor kActor, int aiModRank = -1)
	Float Libido = StorageUtil.GetFloatValue(kActor, "_SLH_fLibido")
	Float fAbsLibido = Math.abs(Libido)
	Float fArousalRateMod = 1.0

	If (Libido > 0)
		If (GV_allowExhibitionist.GetValue() == 1) && ((StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1) || (StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") == 1) || (StorageUtil.GetIntValue(kActor, "_SLH_isSuccubus") == 1))
			If (fAbsLibido >= 50)
				slaUtil.SetActorExhibitionist(kActor, True)
			Else
				slaUtil.SetActorExhibitionist(kActor, False)
			EndIf
		EndIf

		fArousalRateMod = fAbsLibido / 10.0
	EndIf

	if (StorageUtil.GetIntValue(kActor, "_SLH_isSuccubus") == 1)
		fArousalRateMod = 9.0
	EndIf

	if (StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") == 1)
		fArousalRateMod = 5.0
	EndIf

	if (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1)
		fArousalRateMod = 2.0
	EndIf

	if ( StorageUtil.GetIntValue(kActor, "_SLH_isDrugged") == 1)
		fArousalRateMod = 9.0
	EndIf

	if (StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") == 1) && ((GV_isGagEquipped.GetValue() == 1) || (GV_isPlugEquipped.GetValue() == 1))
		fArousalRateMod = fMax( fArousalRateMod / 9.0, 1.1)
	Endif

	slaUtil.UpdateActorExposureRate(kActor, fArousalRateMod)
endFunction

function updateSexLabArousedExposure(Actor kActor, int iExposure)
	slaUtil.UpdateActorExposure(kActor, iExposure, "Updated from SL Hormones")
endFunction

Function debugTrace(string traceMsg)
	if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON") == 1)
		Debug.Trace("[SLH_fctUtil]" + traceMsg)
	endif
endFunction

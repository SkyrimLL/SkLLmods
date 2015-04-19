Scriptname SLS_QST_SexBot extends Quest  

ReferenceAlias Property SexBotAlias  Auto  

Event OnInit()
	_Maintenance()
EndEvent

Function _Maintenance()
	ObjectReference SexBotREF= SexBotAlias.GetReference()
	Actor SexBotActor= SexBotAlias.GetReference() as Actor

	; Debug.Notification("SexBot: init");

		SexBotActor.EvaluatePackage()

	UnregisterForAllModEvents()
	Debug.Trace("SexLab SexBot: Reset SexLab events")
	RegisterForModEvent("AnimationStart", "OnSexLabStart")
	RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")

	; StorageUtil.SetIntValue(SexBotActor, "_SD_iCanBeEnslaved", 0)
	StorageUtil.SetIntValue(SexBotActor, "_SD_iCanBeStripped", 0)
EndFunction




Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference SexBotREF= SexBotAlias.GetReference()
	Actor SexBotActor= SexBotAlias.GetReference() as Actor

	if !Self || !SexLab 
		Debug.Trace("SexLab SexBot: Critical error on SexLab Start")
		Return
	EndIf
	
	Actor[] actors = SexLab.HookActors(_args)
	Actor   victim = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	If (_hasPlayer(actors))

	EndIf

	If victim	;none consensual
		;

	Else        ;consensual
		;
		
	EndIf


EndEvent

Event OnSexLabEnd(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference SexBotREF= SexBotAlias.GetReference()
	Actor SexBotActor= SexBotAlias.GetReference() as Actor

	if !Self || !SexLab 
		Debug.Trace("SexLab SexBot: Critical error on SexLab End")
		Return
	EndIf


	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim
	
	; if config.bDebugMsg
	; 	_listActors("End: ", actors)
	; EndIf

	If (_hasActor(actors, SexBotActor))
		; Debug.Trace("SexLab Stories: Orgasm!")


	EndIf

EndEvent 

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference SexBotREF= SexBotAlias.GetReference()
	Actor SexBotActor= SexBotAlias.GetReference() as Actor

	if !Self || !SexLab 
		Debug.Trace("SexLab Stories: Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	If (_hasActor(actors, SexBotActor))
		; Debug.Trace("SexLab Stories: Orgasm!")
 
		If (SLS_SexBotOnOff.GetValue() == 0)
			Debug.Notification("E.L.L.E is now recharged.")
			SLS_SexBotOnOff.SetValue(1)
			SexBotActor.EvaluatePackage()
			Utility.Wait(1.0)
		EndIf

	EndIf
	
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
	ObjectReference PlayerREF= Game.GetPlayer() as ObjectReference

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
		if _actors[idx] == thisActor 
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
SexLabFramework Property SexLab  Auto  

GlobalVariable Property SLS_SexBotOnOff  Auto  
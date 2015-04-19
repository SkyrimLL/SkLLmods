Scriptname SLSDDi_PlayerREF extends ReferenceAlias  

ReferenceAlias Property PlayerAlias  Auto  
SexLabFramework     property SexLab Auto

int MilkLevel = 0

Event OnPlayerLoadGame()
	_maintenance()

EndEvent

Function _Maintenance()
	UnregisterForAllModEvents()
	Debug.Trace("SexLab Stories Devious: Reset SexLab events")
	RegisterForModEvent("AnimationStart", "OnSexLabStart")
	RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")
EndFunction

Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 

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
	; Debug.Notification("Arousal trigger: " + (slaUtil.GetActorExposure(akRef = PlayerActor) / 3))

	If (_hasPlayer(actors))

		If ( MilkProduced.GetValue() >=1 ) && ( Utility.RandomInt(0,120) < (slaUtil.GetActorExposure(akRef = PlayerActor) ) ) 
			; Hormones compatibility
			Debug.Notification("Your breasts are aching from a rush of milk.")
			fBreastScale = StorageUtil.GetFloatValue(none, "_SLH_fBreast") 
			StorageUtil.SetFloatValue(none, "_SLH_fBreast",  fBreastScale + fBreastScale * 0.1) 
			StorageUtil.SetIntValue(none, "_SLH_iForcedRefresh", 1) 

			MilkLevel = Milklevel + 1

		EndIf
	EndIf

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

	If (_hasPlayer(actors))
		;
	EndIf

EndEvent 

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 

	if !Self || !SexLab 
		Debug.Trace("SexLab Stories Devious: Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	If (_hasPlayer(actors))
		Debug.Trace("SexLab Stories: Orgasm!")

		If ( MilkProduced.GetValue() >=1 )
			Debug.Trace("SexLab Stories: Milk Level: " + MilkLevel)

			If (MilkLevel >= 10)
				Debug.Notification("The suction cups painfully clench around your tits.")

				PlayerActor.AddItem(Milk, 1)
				MilkLevel = 0

				MilkProduced.SetValue( MilkProduced.GetValue() + 1 )
				MilkProducedTotal.SetValue( MilkProducedTotal.GetValue() + 1 )		

				If  (StorageUtil.GetIntValue(none, "_SLS_fetishID") == 10 )
					slaUtil.UpdateActorExposure(akRef = PlayerActor, val = 10, debugMsg = "producing breast milk as a cow.")
				Else
					slaUtil.UpdateActorExposure(akRef = PlayerActor, val = -20, debugMsg = "producing breast milk as a cow.")
				EndIf

				
				; Hormones compatibility
				fBreastScale = StorageUtil.GetFloatValue(none, "_SLH_fBreast") 
				StorageUtil.SetFloatValue(none, "_SLH_fBreast",  0.9) 	
				StorageUtil.SetIntValue(none, "_SLH_iForcedRefresh", 1) 


				libs.SexlabMoan(PlayerActor)	
			Else
				libs.Pant(PlayerActor)
			EndIf

		EndIf
	EndIf
	
EndEvent

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



Potion Property Milk Auto

GlobalVariable Property MilkProduced  Auto  

GlobalVariable Property MilkProducedTotal  Auto  

zadLibs Property libs Auto
slaUtilScr Property slaUtil  Auto  
 
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

	If (StorageUtil.GetIntValue(none, "_SLH_iLactating") == 1)
		If (_hasPlayer(actors))

			If (!StorageUtil.HasIntValue(PlayerActor, "_SLH_iMilkLevel"))
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkLevel", MilkLevel)
			Endif
			If (!StorageUtil.HasIntValue(PlayerActor, "_SLH_iMilkProduced"))
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkProduced", MilkProduced.GetValue() as Int)
			Endif


			If ( PlayerActor.WornHasKeyword(SLSD_CowHarness) && ( Utility.RandomInt(0,80) < slaUtil.GetActorExposure(akRef = PlayerActor) ) ) || PlayerActor.WornHasKeyword(SLSD_CowMilker)
				; Hormones compatibility
				Debug.Notification("Your breasts are aching from a rush of milk.")

				fBreastScale = StorageUtil.GetFloatValue(none, "_SLH_fBreast") 
				StorageUtil.SetFloatValue(none, "_SLH_fBreast",  fBreastScale + fBreastScale * 0.1) 
				StorageUtil.SetIntValue(none, "_SLH_iForcedRefresh", 1) 

				StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") + 1)
			Else
				Debug.Trace("[SLSDDi] You can't produce enough milk to fill the suction cup. Exposure trigger: " + slaUtil.GetActorExposure(akRef = PlayerActor))

			EndIf

			Debug.Trace("[SLSDDi] Player Milk level: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel"))
			Debug.Trace("[SLSDDi] Player Milk produced: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced"))
		EndIf
	Endif

	int idx = 0
	while idx < actors.Length
		if (actors[idx]) && ( actors[idx] != PlayerActor)

			if ( actors[idx].WornHasKeyword(SLSD_CowHarness)  && ( Utility.RandomInt(0,80) < (slaUtil.GetActorExposure(akRef = actors[idx]) ) ) ) || actors[idx].WornHasKeyword(SLSD_CowMilker)

				If (!StorageUtil.HasIntValue(actors[idx], "_SLH_iMilkLevel"))
						StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkLevel", 0)
				Endif
				If (!StorageUtil.HasIntValue(actors[idx], "_SLH_iMilkProduced"))
						StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkProduced", 0)
				Endif


				Debug.Notification("The cow's breasts are aching from a rush of milk.")

				StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel") + 1)
				Debug.Notification("[SLSDDi] NPC Milk level: " + StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel"))
			Else
				Debug.Trace("[SLSDDi] You can't extract enough milk to fill the suction cup. Exposure trigger: " + slaUtil.GetActorExposure(akRef = actors[idx]))

			endif

			Debug.Trace("[SLSDDi] Player Milk level: " + StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel"))
			Debug.Trace("[SLSDDi] Player Milk produced: " + StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkProduced"))
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

	if !Self || !SexLab 
		Debug.Trace("SexLab Stories Devious: Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	If (StorageUtil.GetIntValue(none, "_SLH_iLactating") == 1)
		If (_hasPlayer(actors)) && PlayerActor.WornHasKeyword(SLSD_CowHarness)
			Debug.Trace("SexLab Stories: Orgasm!")

			If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced") >= 10)
				Debug.Notification("The suction cups painfully clench around your tits.")

				PlayerActor.AddItem(Milk, 1)	

				If  (StorageUtil.GetIntValue(none, "_SLS_fetishID") == 10 )
					slaUtil.UpdateActorExposure(akRef = PlayerActor, val = 10, debugMsg = "producing breast milk as a cow.")
				Else
					slaUtil.UpdateActorExposure(akRef = PlayerActor, val = -20, debugMsg = "producing breast milk as a cow.")
				EndIf

				
				; Hormones compatibility
				fBreastScale = StorageUtil.GetFloatValue(none, "_SLH_fBreast") 
				StorageUtil.SetFloatValue(none, "_SLH_fBreast",  0.9) 	
				StorageUtil.SetIntValue(none, "_SLH_iForcedRefresh", 1) 

				StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkLevel", 0)	
				StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkProduced", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced") +1)
				StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkProducedTotal", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProducedTotal") +1)	

				Debug.Notification("[SLSDDi] NPC Milk Produced: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced"))
				Debug.Notification("[SLSDDi] NPC Milk Total: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProducedTotal"))

				libs.SexlabMoan(PlayerActor)	
			Else
				libs.Pant(PlayerActor)
			EndIf
		EndIf
	Endif

	int idx = 0
	while idx < actors.Length
		if (actors[idx]) && ( actors[idx] != PlayerActor) 

			if actors[idx].WornHasKeyword(SLSD_CowHarness)  && ( StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel") >= 10)
				Debug.Notification("The harness container is full.")

				PlayerActor.AddItem(Milk, 1)

				StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkLevel", 0)	
				StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkProduced", StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkProduced") +1)
				StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkProducedTotal", StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkProducedTotal") +1)	

				Debug.Notification("[SLSDDi] NPC Milk Produced: " + StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkProduced"))
				Debug.Notification("[SLSDDi] NPC Milk Total: " + StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkProducedTotal"))

				libs.SexlabMoan(actors[idx])
			endif
		EndIf
		idx += 1
	endwhile
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

Keyword Property SLSD_CowHarness Auto
Keyword Property SLSD_CowMilker Auto


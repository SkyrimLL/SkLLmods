Scriptname SLSDDi_PlayerREF extends ReferenceAlias  

ReferenceAlias Property PlayerAlias  Auto  
SexLabFramework     property SexLab Auto
zadLibs Property libs Auto
slaUtilScr Property slaUtil  Auto  

Potion Property Milk Auto

GlobalVariable Property MilkProduced  Auto  

GlobalVariable Property MilkProducedTotal  Auto  

Keyword Property SLSD_CowHarness Auto
Keyword Property SLSD_CowMilker Auto
Keyword Property SLSD_MilkOMatic  Auto  
Keyword Property SLSD_MilkOMatic2  Auto  

SPELL Property SLSD_MilkOMaticSpell  Auto  
SPELL Property SLSD_MilkOMaticSpell2  Auto  

ObjectReference Property MilkOMaticSoundFX  Auto  
ObjectReference Property LeonaraRef  Auto  

SLS_QST_CowLife Property CowLife Auto

int MilkLevel = 0

Event OnInit()
	_maintenance()

EndEvent

Event OnPlayerLoadGame()
	_maintenance()

EndEvent

Function _Maintenance()
	If (!StorageUtil.HasIntValue(none, "_SLS_iStoriesDevious"))
		StorageUtil.SetIntValue(none, "_SLS_iStoriesDevious", 1)
	EndIf

	UnregisterForAllModEvents()
	Debug.Trace("SexLab Stories Devious: Reset SexLab events")
	RegisterForModEvent("AnimationStart", "OnSexLabStart")
	RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")

	RegisterForModEvent("_SLSDDi_EquipMilkingDevice", "OnEquipMilkingDevice")
	RegisterForModEvent("_SLSDDi_RemoveMilkingDevice", "OnRemoveMilkingDevice")
EndFunction

Event OnEquipMilkingDevice(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	If (kActor == None)
		kActor = PlayerActor
	EndIf

	if (_args == "Auto")
		CowLife.PlayerReceivedAutoCowharness(kActor)
	else
		CowLife.PlayerReceivedCowharness(kActor)
	EndIf

EndEvent

Event OnRemoveMilkingDevice(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	If (kActor == None)
		kActor = PlayerActor
	EndIf

	if (_args == "Auto")
		CowLife.PlayerRemovedAutoCowharness(kActor)
	else
		CowLife.PlayerRemovedCowharness(kActor)
	EndIf

EndEvent

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

	; Force lactation if Player is wearing harness and not lactating yet
	if ( PlayerActor.WornHasKeyword(SLSD_CowHarness) || PlayerActor.WornHasKeyword(SLSD_CowMilker) ) && (!StorageUtil.HasIntValue(PlayerActor, "_SLH_iLactating") || (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") == 0) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iLactating", 1)
	endif

	If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") == 1)
		If (_hasPlayer(actors))
			Debug.Trace("[SLSDDi] Player is lactating")

			If (!StorageUtil.HasIntValue(PlayerActor, "_SLH_iMilkLevel"))
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkLevel", MilkLevel)
			Endif
			If (!StorageUtil.HasIntValue(PlayerActor, "_SLH_iMilkProduced"))
					StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkProduced", MilkProduced.GetValue() as Int)
			Endif


			If ( PlayerActor.WornHasKeyword(SLSD_CowHarness) && ( Utility.RandomInt(0,80) < slaUtil.GetActorExposure(akRef = PlayerActor) ) ) || PlayerActor.WornHasKeyword(SLSD_CowMilker) || (StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant") == 1)
				; Hormones compatibility
				Debug.Notification("Your breasts are aching from a strong rush of milk.")

				fBreastScale = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBreast") 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast",  fBreastScale + fBreastScale * 0.2) 
				PlayerActor.SendModEvent("SLHRefresh")

				StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") + 1)
			ElseIf ( !PlayerActor.WornHasKeyword(SLSD_CowHarness) && ( Utility.RandomInt(0,200) < slaUtil.GetActorExposure(akRef = PlayerActor) ) )  || (StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant") == 1)
				; Hormones compatibility
				Debug.Notification("Your breasts are tingling from a small rush of milk.")

				fBreastScale = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBreast") 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast",  fBreastScale + fBreastScale * 0.1) 
				PlayerActor.SendModEvent("SLHRefresh")

				if (Utility.RandomInt(0,100)>80)
					StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") + 1)
				endif
			Else
				Debug.Trace("[SLSDDi] You can't produce enough milk to fill the suction cup. Exposure trigger: " + slaUtil.GetActorExposure(akRef = PlayerActor))

			EndIf

			Debug.Trace("[SLSDDi] Player Milk level: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel"))
			Debug.Trace("[SLSDDi] Player Milk produced: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced"))
		EndIf
	Endif

	int idx = 0
	while idx < actors.Length
		; Force lactation if NPC is wearing harness and not lactating yet
		if ( actors[idx].WornHasKeyword(SLSD_CowHarness) || actors[idx].WornHasKeyword(SLSD_CowMilker) ) && (!StorageUtil.HasIntValue(actors[idx], "_SLH_iLactating") || (StorageUtil.GetIntValue(actors[idx], "_SLH_iLactating") == 0) )
			StorageUtil.SetIntValue(actors[idx], "_SLH_iLactating", 1)
		endif

		if (actors[idx]) && ( actors[idx] != PlayerActor) && (StorageUtil.GetIntValue(actors[idx], "_SLH_iLactating") == 1)

			Debug.Trace("[SLSDDi] NPC is lactating: " + actors[idx].GetName())

			if ( actors[idx].WornHasKeyword(SLSD_CowHarness)  && ( Utility.RandomInt(0,80) < (slaUtil.GetActorExposure(akRef = actors[idx]) ) ) ) || actors[idx].WornHasKeyword(SLSD_CowMilker) || (StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant") == 1) 

				If (!StorageUtil.HasIntValue(actors[idx], "_SLH_iMilkLevel"))
						StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkLevel", 0)
				Endif
				If (!StorageUtil.HasIntValue(actors[idx], "_SLH_iMilkProduced"))
						StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkProduced", 0)
				Endif


				Debug.Notification("The cow's breasts are aching from a strong rush of milk.")

				StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel") + 1)
				Debug.Notification("[SLSDDi] NPC Milk level: " + StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel"))

			elseif ( !actors[idx].WornHasKeyword(SLSD_CowHarness)  && ( Utility.RandomInt(0,80) < (slaUtil.GetActorExposure(akRef = actors[idx]) ) ) )  || (StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant") == 1) 

				If (!StorageUtil.HasIntValue(actors[idx], "_SLH_iMilkLevel"))
						StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkLevel", 0)
				Endif
				If (!StorageUtil.HasIntValue(actors[idx], "_SLH_iMilkProduced"))
						StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkProduced", 0)
				Endif

				Debug.Notification("The cow's breasts are tingling from a small drop of milk.")

				if (Utility.RandomInt(0,100)>80)
					StorageUtil.SetIntValue(actors[idx], "_SLH_iMilkLevel", StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel") + 1)
				EndIf
			Else
				Debug.Trace("[SLSDDi] You can't extract enough milk to fill the suction cup. Exposure trigger: " + slaUtil.GetActorExposure(akRef = actors[idx]))

			endif

			Debug.Trace("[SLSDDi] NPC Milk level: " + StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkLevel"))
			Debug.Trace("[SLSDDi] NPC Milk produced: " + StorageUtil.GetIntValue(actors[idx], "_SLH_iMilkProduced"))
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

	If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating") == 1)
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
				fBreastScale = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBreast") 
				StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast",  fBreastScale * 0.9) 	
				PlayerActor.SendModEvent("SLHRefresh")

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

Event OnSit(ObjectReference akFurniture)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Actor LeonaraActor = LeonaraRef as Actor
	Form fFurniture = akFurniture.GetBaseObject()
	String sFurnitureName = fFurniture.GetName()
	Float fBreastScale 
	Int iCounter=0
	Int iRandomEvent
	Int iTimer
	
	if (sFurnitureName == "Dwarven Milking Machine")  && (akFurniture.GetActorOwner() == LeonaraActor.GetActorBase() )
		; Debug.Notification("We just sat on " + sFurnitureName)
		; Debug.Messagebox("The " + sFurnitureName + " painfully sucks and tugs at your nipples, leaving both your breasts and your body drained.")
		
		; Hormones compatibility
		fBreastScale = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBreast") 

		MilkOMaticSoundFX.Enable()
		Game.DisablePlayerControls(abActivate = true)
		iCounter = (fBreastScale * 60) as Int
		While (iCounter>0)
			iRandomEvent = Utility.RandomInt(0,100)
			iTimer = 1 + iCounter  / 60

			if (iRandomEvent>70)
				libs.SexlabMoan(PlayerActor)
				Utility.Wait(2.0)

			elseif (iRandomEvent>40)
				libs.Pant(PlayerActor)
				Utility.Wait(1.0)

			elseif (iRandomEvent>20)
				Debug.Notification("Milk is pumping into the machine.. " + iTimer + " m left")
			endif

			iCounter = iCounter - 1
		EndWhile
		Game.EnablePlayerControls(abActivate = true)
		MilkOMaticSoundFX.Disable()


		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast",  fBreastScale * 0.8) 	
		PlayerActor.SendModEvent("SLHRefresh")

		StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkLevel", 0)	
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkProduced", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced") +1)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkProducedTotal", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProducedTotal") +1)	

		Debug.Notification("[SLSDDi] NPC Milk Produced: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced"))
		Debug.Notification("[SLSDDi] NPC Milk Total: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProducedTotal"))

		; SLSD_MilkOMaticSpell.Remotecast(PlayerREF,PlayerActor,PlayerREF)

		PlayerActor.AddItem(Milk, 1)	

		If  (StorageUtil.GetIntValue(none, "_SLS_fetishID") == 10 )
			slaUtil.UpdateActorExposure(akRef = PlayerActor, val = 10, debugMsg = "producing breast milk as a cow.")
		Else
			slaUtil.UpdateActorExposure(akRef = PlayerActor, val = -20, debugMsg = "producing breast milk as a cow.")
		EndIf




	Elseif (sFurnitureName == "Dwarven Milking Machine II") && (akFurniture.GetActorOwner() == LeonaraActor.GetActorBase() )
		; Debug.Notification("We just sat on " + sFurnitureName)
		; Debug.Messagebox("The " + sFurnitureName + " painfully sucks and tugs at your nipples, leaving you drained both mentally and physically.")

		; Hormones compatibility
		fBreastScale = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBreast") 

		MilkOMaticSoundFX.Enable()
		Game.DisablePlayerControls(abActivate = true)
		iCounter = (fBreastScale * 30) as Int
		While (iCounter>0)
			iRandomEvent = Utility.RandomInt(0,100)
			iTimer = 1 + iCounter  / 60

			if (iRandomEvent>80)
				libs.SexlabMoan(PlayerActor)
				Utility.Wait(2.0)

			elseif (iRandomEvent>60)
				libs.Moan(PlayerActor)
				Utility.Wait(2.0)

			elseif (iRandomEvent>40)
				libs.Pant(PlayerActor)
				Utility.Wait(3.0)

			elseif (iRandomEvent>20)
				Debug.Notification("Milk is pumping into the machine.. " + iTimer + " m left")
				libs.Moan(PlayerActor)
			endif

			iCounter = iCounter - 1
		EndWhile
		Game.EnablePlayerControls(abActivate = true)
		MilkOMaticSoundFX.Disable()

		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast",  fBreastScale * 0.5) 	
		PlayerActor.SendModEvent("SLHRefresh")

		StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkLevel", 0)	
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkProduced", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced") +1)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkProducedTotal", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProducedTotal") +1)	

		Debug.Notification("[SLSDDi] NPC Milk Produced: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced"))
		Debug.Notification("[SLSDDi] NPC Milk Total: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProducedTotal"))


		; SLSD_MilkOMaticSpell2.Remotecast(PlayerREF,PlayerActor,PlayerREF)
		
		PlayerActor.AddItem(Milk, 2)	

		If  (StorageUtil.GetIntValue(none, "_SLS_fetishID") == 10 )
			slaUtil.UpdateActorExposure(akRef = PlayerActor, val = 10, debugMsg = "producing breast milk as a cow.")
		Else
			slaUtil.UpdateActorExposure(akRef = PlayerActor, val = -20, debugMsg = "producing breast milk as a cow.")
		EndIf

	EndIf
endEvent

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
 



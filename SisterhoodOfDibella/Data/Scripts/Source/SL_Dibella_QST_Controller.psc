Scriptname SL_Dibella_QST_Controller extends ReferenceAlias  

ReferenceAlias Property PlayerAlias  Auto  
SexLabFramework     property SexLab Auto

Bool isPlayerEnslaved = False
Bool isPlayerPregnant = False
Bool isPlayerSuccubus = False

Event OnPlayerLoadGame()
	_maintenance()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	; Check sex with Fjotra
	; Trigger scenes as Dibella's vessel

EndEvent

Function _Maintenance()
	; UnregisterForAllModEvents()
	Debug.Trace("[SLD] Reset SexLab events")
	RegisterForModEvent("AnimationStart", "OnSexLabStart")
	RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")
	RegisterForSleep()

	; _SLS_NPCSexCount.SetValue(-1)

	If (!DibellaHeartQuest.IsCompleted())
		StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption", 2)
	Else

		If (SybilLevel.GetValue() == 0) 
			SybilLevel.SetValue(1)
		EndIf

		If (SybilLevel.GetValue() >=1) && (SybilLevel.GetValue() <=2)
			StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption", 2)

		ElseIf (SybilLevel.GetValue() >=3) && (SybilLevel.GetValue() <=4)
			StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption", 3)

		ElseIf (SybilLevel.GetValue() >=5) 
			StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption", 4)
		EndIf

		StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iDibellaSybilLevel", SybilLevel.GetValue() as Int)

	EndIf

	TempleCorruption.SetValue( StorageUtil.GetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption") )

	If (DibellaPathQuest.GetStage() == 0)
		DibellaPathQuest.SetStage(20) 
	EndIf

	isPlayerEnslaved = StorageUtil.GetIntValue( Game.GetPlayer(), "_SD_iEnslaved") as Bool
	isPlayerPregnant = StorageUtil.GetIntValue( Game.GetPlayer(), "_SLH_isPregnant") as Bool
	isPlayerSuccubus = StorageUtil.GetIntValue( Game.GetPlayer(), "_SLH_isSuccubus") as Bool

	_SLSD_isPlayerPregnant.SetValue(isPlayerPregnant as Int)
	_SLSD_isPlayerSuccubus.SetValue(isPlayerSuccubus as Int)
	_SLSD_isPlayerEnslaved.SetValue(isPlayerEnslaved as Int)

	; Debug.Notification("[SLD] Dibella Heart: " + DibellaHeartQuest.IsCompleted())
	; Debug.Notification("[SLD] Temple corruption: " + TempleCorruption.GetValue() as Int)
	; Debug.Notification("[SLD] Sybil Level: " + SybilLevel.GetValue() as Int )

EndFunction

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	Actor kPlayer = Game.GetPlayer() as Actor
	Location kLocation = Game.GetPlayer().GetCurrentLocation()
	Int iTempleCorruption = StorageUtil.GetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption")

	If kLocation.IsSameLocation( DibellaTempleBaths ) && (iTempleCorruption >= 2)
		If (Utility.RandomInt(0,100)<= (TempleCorruption.GetValue() * 10) ) && (StorageUtil.GetIntValue(Game.getPlayer(), "_SD_iDisableDreamworldOnSleep") == 0) && ( StorageUtil.GetIntValue(Game.getPlayer(), "_SD_iSanguineBlessings") > 0)
			SendModEvent("SDDreamworldPull")
		Endif
	EndIf
Endevent

Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 

	if !Self || !SexLab 
		Debug.Trace("[SLSD] Critical error on SexLab Start")
		Return
	EndIf
	
	; Debug.Notification("[SLSD]  Sex start")

	Actor[] actors = SexLab.HookActors(_args)
	Actor   victim = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim
	
	; Debug.Notification("Has player: " + _hasPlayer(actors))
	; Debug.Notification("Arousal trigger: " + (slaUtil.GetActorExposure(akRef = PlayerActor) / 3))

	; If (_hasPlayer(actors))

	; EndIf

 
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
		Debug.Trace("[SLSD] Critical error on SexLab End")
		Return
	EndIf


	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim
	
	; if config.bDebugMsg
	; 	_listActors("End: ", actors)
	; EndIf

	If (_hasActor(actors, FjotraRef as Actor)) && (_hasPlayer(actors))
		if ( (Game.GetPlayer().HasMagicEffect(AgentOfDibella  )) && (_SLSD_HormonesSexChange.GetValue() == 1) && (pActorBase.GetSex() == 0) )
			InitiationFX.Cast(PlayerActor, PlayerActor )

			StorageUtil.SetIntValue( PlayerActor, "_SLH_allowHRT", 1)
 			PlayerActor.SendModEvent("SLHCastHRTCurse")
 			_SLSD_PlayerSexChanged.SetValue(1)

		 	Debug.MessageBox("Dibella's Grace washes over you, changing your features in her image.")

		 	Utility.Wait(5.0)

    		Game.ShowRaceMenu()
 
		endIf
	EndIf

EndEvent 

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	Float fBreastScale 
	Int iRandomNum

	if !Self || !SexLab 
		Debug.Trace("[SLSD] Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	; If (_hasPlayer(actors))
	; 	Debug.Trace("[SLSD] Orgasm!")
	; EndIf

	If (_hasActor(actors, FjotraRef as Actor)) && (_hasPlayer(actors))
		if ( (Game.GetPlayer().HasMagicEffect(AgentOfDibella  )) && (_SLSD_HormonesSexChange.GetValue() == 1) && (pActorBase.GetSex() == 0) )
			; Do nothing... message box will open from SexLab End event
		Else
		 	Debug.Trace("[SLSD] Orgasm with Fjotra!")

			iRandomNum = Utility.RandomInt(0,100)

			If (iRandomNum > 70) && (TempleCorruption.getValue()>0)
		 		InitiationFX.Cast(FjotraRef as Actor ,FjotraRef as Actor )
		 		Utility.Wait(2.0)

		 		iRandomNum = Utility.RandomInt(0,100)
		 		If (iRandomNum > 80) 
		 			; [Dibella after orgasm] There is a disease in my temple. Help my Sybil and show her the path!
		 			Debug.MessageBox("The Sybil reaches for your arm and gasps in an otherworldly voice 'There is a disease in my temple. Help my Sybil and show her the path!'")

		 		ElseIf (iRandomNum > 50)
					; [Dibella after orgasm] My Sybil needs you!
					Debug.MessageBox("The Sybil cries out, transfixed 'My Sybil needs you! Hurry!'.")

		 		ElseIf (iRandomNum > 20)
					; [Dibella after orgasm] Trust Senna.
					Debug.MessageBox("The Sybil is collapses and whispers 'Trust Senna.. she will help you.'.")

				Else
					Debug.MessageBox("The Sybil is possessed by the essence of Dibella, transfixed, eyes glowing and looking right through you.")

				EndIf

	 		Endif

	 		If (iRandomNum > 80) 
				; Hormones compatibility
				if (pActorBase.GetSex() == 0)
					StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSchlong",  StorageUtil.GetFloatValue(PlayerActor, "_SLH_fSchlong")  * 1.5) 	
				else
					StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast",  StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBreast")  * 2.0) 	
					StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButt",  StorageUtil.GetFloatValue(PlayerActor, "_SLH_fButt")  * 1.5) 	
				endIf

				PlayerActor.SendModEvent("SLHRefresh")

	 		endIf	 		
	 	EndIf
	 ElseIf (_hasFaction(actors, DibellaTempleFaction)) && (_hasPlayer(actors))
	 	Debug.Trace("[SLSD] Orgasm with Sister of Dibella!")

		iRandomNum = Utility.RandomInt(0,100)

		If (iRandomNum > 60)
	 		Game.getPlayer().AddItem(DibellaToken,1)

	 		; Debug.MessageBox("Your lover gives you a Mark of Dibella.")
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

Bool Function _hasFaction(Actor[] _actors, faction _faction, bool includePlayer = False)
	ObjectReference PlayerREF= PlayerAlias.GetReference()

	int idx = 0
	while idx < _actors.Length
		if (( (_actors[idx] == PlayerRef) && includePlayer ) || ( (_actors[idx] != PlayerRef) && !includePlayer )) && _actors[idx].IsInFaction(_faction)
			return True
		endif
		idx += 1
	endwhile
	Return False
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

ObjectReference Property FjotraRef Auto
GlobalVariable Property SybilLevel Auto
GlobalVariable Property TempleCorruption Auto

SPELL Property InitiationFX  Auto 
Quest Property DibellaHeartQuest Auto
Quest Property DibellaPathQuest Auto

GlobalVariable Property _SLSD_isPlayerPregnant auto
GlobalVariable Property _SLSD_isPlayerSuccubus auto
GlobalVariable Property _SLSD_isPlayerEnslaved auto

Faction Property DibellaTempleFaction Auto

MiscObject Property DibellaToken  Auto  
Location Property DibellaTempleBaths  Auto  

MagicEffect   Property AgentOfDibella  Auto  

GlobalVariable Property _SLSD_HormonesSexChange  Auto  
GlobalVariable Property _SLSD_PlayerSexChanged  Auto  

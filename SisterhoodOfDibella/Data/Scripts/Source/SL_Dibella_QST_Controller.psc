Scriptname SL_Dibella_QST_Controller extends ReferenceAlias  

ReferenceAlias Property PlayerAlias  Auto  
SexLabFramework     property SexLab Auto

ObjectReference Property FjotraRef Auto
GlobalVariable Property SybilLevel Auto
GlobalVariable Property TempleCorruption Auto

SPELL Property InitiationFX  Auto 
SPELL Property DibellaKissFX  Auto 
Quest Property DibellaHeartQuest Auto
Quest Property DibellaPathQuest Auto

GlobalVariable Property _SLSD_isPlayerPregnant auto
GlobalVariable Property _SLSD_isPlayerSuccubus auto
GlobalVariable Property _SLSD_isPlayerEnslaved auto

Faction Property DibellaTempleFaction Auto

Armor Property DibellaNecklace  Auto  
Armor Property DibellaWreath  Auto  
MiscObject Property DibellaToken  Auto  
Location Property DibellaTempleBaths  Auto  

MagicEffect   Property AgentOfDibella  Auto  

GlobalVariable Property _SLSD_HormonesSexChange  Auto  
GlobalVariable Property _SLSD_PlayerSexChanged  Auto  
GlobalVariable Property _SLSD_PlayerSexChangeAllowed  Auto  

Bool isPlayerEnslaved = False
Bool isPlayerPregnant = False
Bool isPlayerSuccubus = False

Event OnPlayerLoadGame()
	_maintenance()

	; Debug.Notification("[SLSD] Sending mark of dibella request")
	; SendModEvent("SLSDMarkOfDibella", "", 1.0)
EndEvent

; Event OnLocationChange(Location akOldLoc, Location akNewLoc)
;	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
;	Actor akActor= Game.GetPlayer()

	; Check sex with Fjotra
	; Trigger scenes as Dibella's vessel

; EndEvent

Function _Maintenance()
	Actor kPlayer = Game.GetPlayer()

	If (!StorageUtil.HasIntValue(none, "_SLSD_iDibellaSisterhood"))
		StorageUtil.SetIntValue(none, "_SLSD_iDibellaSisterhood", 1)
	EndIf

	UnregisterForAllModEvents()
	Debug.Trace("[SLD] Reset SexLab events")
	; RegisterForModEvent("AnimationStart", "OnSexLabStart")
	RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")
	RegisterForModEvent("SexlabOrgasmSeparate", "OnSexlabOrgasmS")
	RegisterForModEvent("SLSDMarkOfDibella",   "OnSLSDMarkOfDibella")
	RegisterForModEvent("SLSDDibellaSex",   "OnSLSDDibellaSex")
	RegisterForSleep()

	; _SLS_NPCSexCount.SetValue(-1)

	If (!DibellaHeartQuest.IsCompleted())
		StorageUtil.SetIntValue( kPlayer, "_SLSD_iDibellaTempleCorruption", 2)
	Else

		If (SybilLevel.GetValue() == 0) 
			SybilLevel.SetValue(1)
		EndIf

		If (SybilLevel.GetValue() >=1) && (SybilLevel.GetValue() <=2)
			StorageUtil.SetIntValue( kPlayer, "_SLSD_iDibellaTempleCorruption", 2)

		ElseIf (SybilLevel.GetValue() >=3) && (SybilLevel.GetValue() <=4)
			StorageUtil.SetIntValue( kPlayer, "_SLSD_iDibellaTempleCorruption", 3)

		ElseIf (SybilLevel.GetValue() >=5) 
			StorageUtil.SetIntValue( kPlayer, "_SLSD_iDibellaTempleCorruption", 4)
		EndIf

		StorageUtil.SetIntValue( kPlayer, "_SLSD_iDibellaSybilLevel", SybilLevel.GetValue() as Int)

	EndIf

	TempleCorruption.SetValue( StorageUtil.GetIntValue( kPlayer, "_SLSD_iDibellaTempleCorruption") )

	If (DibellaPathQuest.GetStage() == 0)
		DibellaPathQuest.SetStage(20) 
	EndIf

	isPlayerEnslaved = StorageUtil.GetIntValue( kPlayer, "_SD_iEnslaved") as Bool
	isPlayerPregnant = StorageUtil.GetIntValue( kPlayer, "_SLH_isPregnant") as Bool
	isPlayerSuccubus = StorageUtil.GetIntValue( kPlayer, "_SLH_isSuccubus") as Bool

	_SLSD_isPlayerPregnant.SetValue(isPlayerPregnant as Int)
	_SLSD_isPlayerSuccubus.SetValue(isPlayerSuccubus as Int)
	_SLSD_isPlayerEnslaved.SetValue(isPlayerEnslaved as Int)

	; Debug.Notification("[SLD] Dibella Heart: " + DibellaHeartQuest.IsCompleted())
	; Debug.Notification("[SLD] Temple corruption: " + TempleCorruption.GetValue() as Int)
	; Debug.Notification("[SLD] Sybil Level: " + SybilLevel.GetValue() as Int )

EndFunction


Event OnSLSDMarkOfDibella(String _eventName, String _args, Float _argc = 1.0, Form _sender)
	int iAmount = _argc as Int
 	Actor kActor = _sender as Actor
	Actor kPlayer = Game.GetPlayer() as Actor

	Debug.Trace("[SLSD] Receiving OnSLSDMarkOfDibella event")
	if (kActor == None)
		Debug.Notification("[SLSD] 		No sender - using player instead")
		; StorageUtil _SD_TempAggressor is deprecated
		; Use _sender through kActor.SendModEvent("") in priority instead 
		kActor = kPlayer
	EndIf

	; Debug.Notification("[SLSD] 	Adding mark of dibella")
	; Debug.Notification("[SLSD] 		Actor: " + kActor)
	; Debug.Notification("[SLSD] 		Amount: " + iAmount)
	kActor.AddItem(DibellaToken, iAmount )
EndEvent

Bool Function checkGenderRestriction(Actor kActor, Actor akTarget)
	Actor kPlayer = Game.GetPlayer() as Actor
	Int    speakerGender = kActor.GetLeveledActorBase().GetSex() as Int
	Int    targetGender = akTarget.GetLeveledActorBase().GetSex() as Int
	Int    genderRestrictions = StorageUtil.GetIntValue(kPlayer, "_SLSD_iSexGenderRestriction") as Int
	Bool bGenderChecked = false;

	; usually, 'akTarget' is the player
	; 0 - both genders allowed
	; 1 - same gender only
	; 2 - opposite gender only
	; 3 - use sexlab settings
		
	Debug.Trace("[SLSD] 		speakerGender: " + speakerGender)
	Debug.Trace("[SLSD] 		targetGender: " + targetGender)

	if (genderRestrictions <= 2) ; gender restriction system
		bGenderChecked = (genderRestrictions  == 0) || ( (genderRestrictions  == 1) && (speakerGender  == targetGender ) ) || ( (genderRestrictions  == 2) && (speakerGender  != targetGender ) ) 

		Debug.Trace("[SLSD] 		genderRestrictions: " + genderRestrictions)
		Debug.Trace("[SLSD] 		bGenderChecked: " + bGenderChecked)

	else ; use SexLab gender restriction system
		bGenderChecked = (SexLab.IsBisexual(akTarget)) || ( (SexLab.IsGay(akTarget)) && (speakerGender  == targetGender ) ) || ( (SexLab.IsStraight(akTarget)) && (speakerGender  != targetGender ) ) 

		Debug.Trace("[SLSD] 		genderRestrictions: SexLab ")
		Debug.Trace("[SLSD] 		bGenderChecked: " + bGenderChecked)
	EndIf

	if !(bGenderChecked)
		Debug.Notification("Oh no.. your charms won't work with me harlot!")
		Debug.Trace("[SLSD] 		gender restriction")
	endif

	return bGenderChecked

EndFunction

Event OnSLSDDibellaSex(String _eventName, String _args, Float _argc = 1.0, Form _sender)
	; int iAmount = _argc as Int
	String SexLabInTags = _args as String
 	Actor kActor = _sender as Actor 
	Actor kPlayer = Game.GetPlayer() as Actor
	Actor akTarget

	Debug.Trace("[SLSD] Receiving OnSLSDDibellaSex event")
	if (kActor == None)
		Debug.Notification("[SLSD] 		No sender - using player instead")
		; StorageUtil _SD_TempAggressor is deprecated
		; Use _sender through kActor.SendModEvent("") in priority instead 
		kActor = kPlayer
	EndIf

	Bool bIsTargetVictim = true
	Bool bIsSpeakerVictim = false
 
	If (!kPlayer && !kActor) ;Only one actor required (masturbation scene?). 
		Debug.Trace("[OnSLSDDibellaSex] Sex scene aborted - no actor available")
		RETURN 
	EndIf

	Int    speakerGender = kActor.GetLeveledActorBase().GetSex() as Int
	Int    targetGender = kPlayer.GetLeveledActorBase().GetSex() as Int
	Int    genderRestrictions = StorageUtil.GetIntValue(kPlayer, "_SLSD_iSexGenderRestriction") as Int


	; Masturbation scenes
	If (SexLabInTags == "Masturbation") && ( SexLab.ValidateActor( kActor ) > 0 )

		If (SexLabInTags == "Masturbation")  
			If (speakerGender  == 0)
				SexLabInTags = "Masturbation,M"
			Else
				SexLabInTags =  "Masturbation,F"
			EndIf

			actor[] sexActors = new actor[1]
			sexActors[0] = kPlayer
			sslBaseAnimation[] animations = SexLab.GetAnimationsByTags(1,  SexLabInTags, "Estrus,Dwemer")
			SexLab.StartSex(sexActors, animations)

			; SexLab.QuickStart(kActor, AnimationTags = SexLabInTags)

		EndIf

	; Gender restrictions - 2 actors
	; In general, Target = Player, speaker = Master
	ElseIf checkGenderRestriction( kActor,  kPlayer)

		akTarget = kPlayer

		If ( (genderRestrictions  == 1) && (speakerGender  == targetGender ) ) 
			If (speakerGender  == 0)
				SexLabInTags = "Anal"
			Else
				SexLabInTags = "Lesbian"
			EndIf
		ElseIf ( (genderRestrictions  != 1) && (speakerGender  != targetGender ) ) 
				; switching dominant position'
				
				If (speakerGender == 1) ; Female Mistress and Male slave
					SexLabInTags = "Cowgirl"
					If (utility.RandomInt(0,100)>90)
						SexLabInTags = "Anal"
					Endif
					akTarget = kActor
					kActor = kPlayer
				 	bIsTargetVictim = true
					bIsSpeakerVictim = false

				ElseIf  (speakerGender == 0) ; Male Master and Female slave
					SexLabInTags = "Doggystyle"
				 	bIsTargetVictim = true
					bIsSpeakerVictim = false

				EndIf
		EndIf

		Debug.Trace("[OnSLSDDibellaSex] Gender check: Restrictions= " + genderRestrictions  + " [ " + kActor + " / " + akTarget + " ] ")
		Debug.Trace("[OnSLSDDibellaSex] SexLabInTags= " + SexLabInTags )
 
		If  (SexLab.ValidateActor( kActor ) > 0) &&  (SexLab.ValidateActor( akTarget ) > 0) 

			sslThreadModel Thread = SexLab.NewThread()
			Thread.AddActor(akTarget, bIsTargetVictim) ; IsVictim = true
			Thread.AddActor(kActor, bIsSpeakerVictim)
			Thread.SetAnimations(SexLab.GetAnimationsByTags(2, SexLabInTags,  "Solo,Estrus"))
			((Thread.StartThread() AS BOOL) AS INT)
		Else
			Debug.Trace("[OnSLSDDibellaSex] Sex: SexLab Check failed - " + SexLab.ValidateActor( kActor ) + " / " + SexLab.ValidateActor( akTarget ))
		EndIf
	Else
		Debug.Trace("[OnSLSDDibellaSex] Gender check failed: Restrictions= " + genderRestrictions  + " [ " + speakerGender + " / " + targetGender + " ] ")
	EndIf

 
EndEvent


Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	Actor kPlayer = Game.GetPlayer() as Actor
	Location kLocation = kPlayer.GetCurrentLocation()

	If (kLocation != None)

		Int iTempleCorruption = StorageUtil.GetIntValue( kPlayer, "_SLSD_iDibellaTempleCorruption")

		If kLocation.IsSameLocation( DibellaTempleBaths ) && (iTempleCorruption >= 2)
			If (Utility.RandomInt(0,100)<= (TempleCorruption.GetValue() * 10) ) && (StorageUtil.GetIntValue(kPlayer, "_SD_iDisableDreamworldOnSleep") == 0) && ( StorageUtil.GetIntValue(kPlayer, "_SD_iSanguineBlessings") > 0)
				SendModEvent("SDDreamworldPull")
			Endif
		EndIf
	Endif
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
    Bool bHasPlayer = False
    Bool bHasFemale = False
    Float fBreastScale 

	if !Self || !SexLab 
		Debug.Trace("[SLSD] Critical error on SexLab End")
		Return
	EndIf


	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	bHasPlayer = _hasPlayer(actors)
	bHasFemale = _hasGender(actors, "Female")
	
	; if config.bDebugMsg
	; 	_listActors("End: ", actors)
	; EndIf 

	If  (bHasPlayer) && (bHasFemale) && (pActorBase.GetSex() == 0) && (_SLSD_PlayerSexChanged.GetValue()==0) && (_SLSD_PlayerSexChangeAllowed.GetValue()==1)
		Debug.Trace("[SLSD] SexLab End - Sex change curse ON")
		if ((Game.GetPlayer().HasMagicEffect(AgentOfDibella  )) || (DibellaHeartQuest.IsStageDone(60)))
			InitiationFX.Cast(PlayerActor, PlayerActor )

			StorageUtil.SetIntValue( PlayerActor, "_SLH_allowHRT", 1)
 			PlayerActor.SendModEvent("SLHCastHRTCurse")
 			_SLSD_PlayerSexChanged.SetValue(1)

		 	Debug.MessageBox("Dibella's Grace washes over you, changing your features in her image. There is a price to pay for trespassing in her temple after all...")

		 	; Utility.Wait(5.0)

    		; Game.ShowRaceMenu()
 		else
 			Debug.Trace("[SLSD] SexLab End - Sex change aborted - player is already female or sex change is not allowed yet")
		endIf
	else
		Debug.Trace("[SLSD] SexLab End - Check for Sex change curse")
		Debug.Trace("[SLSD] bHasPlayer: " + bHasPlayer)
		Debug.Trace("[SLSD] bHasFemale: " + bHasFemale)
		Debug.Trace("[SLSD] _SLSD_PlayerSexChanged.GetValue(): " + _SLSD_PlayerSexChanged.GetValue())
		Debug.Trace("[SLSD] _SLSD_PlayerSexChangeAllowed.GetValue(): " + _SLSD_PlayerSexChangeAllowed.GetValue())
	EndIf

EndEvent 

Function _doOrgasm(String _args)
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
		if ( (PlayerActor.HasMagicEffect(AgentOfDibella  )) && (_SLSD_HormonesSexChange.GetValue() == 1) && (pActorBase.GetSex() == 0) )
			; Do nothing... message box will open from SexLab End event
		Else
		 	Debug.Trace("[SLSD] Orgasm with Fjotra!")

			iRandomNum = Utility.RandomInt(0,100)

			If (iRandomNum > 70) && (TempleCorruption.getValue()>0)
		 		DibellaKissFX.Cast(FjotraRef as Actor ,FjotraRef as Actor )
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
			ElseIf  (TempleCorruption.getValue()<=0)
		 		DibellaKissFX.Cast(FjotraRef as Actor ,FjotraRef as Actor )
		 		Utility.Wait(2.0)
				Debug.MessageBox("The eyes of the Sybil glow in extasy.")

	 		Endif

	 		If (iRandomNum > 80) 
				; Hormones compatibility
				if (pActorBase.GetSex() == 0)
				
					PlayerActor.SendModEvent("SLHSetNiNode","Schlong", StorageUtil.GetFloatValue(PlayerActor, "_SLH_fSchlong")  * 1.5 )  
				else

					PlayerActor.SendModEvent("SLHSetNiNode","Breast", StorageUtil.GetFloatValue(PlayerActor, "_SLH_fSchlong")  * 2.0 ) 
					PlayerActor.SendModEvent("SLHSetNiNode","Butt", StorageUtil.GetFloatValue(PlayerActor, "_SLH_fSchlong")  * 1.5 )  	
				endIf

				PlayerActor.SendModEvent("SLHRefresh")

	 		endIf	 		
	 	EndIf

	 Elseif (PlayerActor.GetItemCount(DibellaWreath)>=1)
	 	If ( (_hasFaction(actors, DibellaTempleFaction, false)) || (_hasItem(actors, DibellaToken as Form, false)) || (_hasItem(actors, DibellaNecklace as Form, false)) || (_hasRelationshipRank(actors, 1, false)) ) && (_hasPlayer(actors))
		 	Debug.Trace("[SLSD] Orgasm with Sister of Dibella!")

			iRandomNum = Utility.RandomInt(0,100)

			If (iRandomNum > 60)
		 		PlayerActor.AddItem(DibellaToken,1)

		 		Debug.Notification("Your lover gives you a Mark of Dibella.")
		 	EndIf
		 endif
	EndIf
EndFunction

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	_doOrgasm(  _args )

EndEvent

Event OnSexLabOrgasmS(Form ActorRef, Int Thread)

	string _args = Thread as string

	_doOrgasm( _args )


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

Bool Function _hasRelationshipRank(Actor[] _actors, Int _iRank,  bool includePlayer = False)
	ObjectReference PlayerREF= PlayerAlias.GetReference()

	int idx = 0
	while idx < _actors.Length
		if (( (_actors[idx] == (PlayerRef as Actor)) && includePlayer ) || ( (_actors[idx] != (PlayerRef as Actor)) && !includePlayer )) && (_actors[idx].GetRelationshipRank(PlayerRef as Actor) >= _iRank)
			return True
		endif
		idx += 1
	endwhile
	Return False
EndFunction

Bool Function _hasItem(Actor[] _actors, Form _itemForm, bool includePlayer = False)
	ObjectReference PlayerREF= PlayerAlias.GetReference()

	int idx = 0
	while idx < _actors.Length
		if (( (_actors[idx] == (PlayerRef as Actor)) && includePlayer ) || ( (_actors[idx] != (PlayerRef as Actor)) && !includePlayer )) && (_actors[idx].GetItemCount(_itemForm) >= 1)
			return True
		endif
		idx += 1
	endwhile
	Return False
EndFunction

Bool Function _hasFaction(Actor[] _actors, faction _faction, bool includePlayer = False)
	ObjectReference PlayerREF= PlayerAlias.GetReference()

	int idx = 0
	while idx < _actors.Length
		if (( (_actors[idx] == (PlayerRef as Actor)) && includePlayer ) || ( (_actors[idx] != (PlayerRef as Actor)) && !includePlayer )) && _actors[idx].IsInFaction(_faction)
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
		if _actors[idx] == (PlayerRef as Actor)
			return True
		endif
		idx += 1
	endwhile
	Return False
EndFunction

Bool Function _hasGender(Actor[] _actors, String sGender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	ActorBase pActorBase
	Bool bGenderMatch = False

	int idx = 0
	while idx < _actors.Length
		if _actors[idx] != (PlayerRef as Actor)
			pActorBase = _actors[idx].GetLeveledActorBase()

			if (sGender=="Male") && (pActorBase.GetSex() == 0)
				bGenderMatch = True
			elseif (sGender=="Female") && (pActorBase.GetSex() == 1)
				bGenderMatch = True
			Endif
		endif
		idx += 1
	endwhile

	debug.trace("[SLSD] Gender match found - " + bGenderMatch)
	Return bGenderMatch
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
			; aBase = _actors[idx].GetBaseObject() as ActorBase
			aRace = _actors[idx].GetLeveledActorBase().GetRace()
			if aRace == thisRace
				return True
			endif
		EndIf
		idx += 1
	endwhile
	Return False
EndFunction

Scriptname SLH_QST_HormoneGrowth extends Quest  

Import Utility
Import Math

SexLabFramework     property SexLab Auto


SOS_API _SOS

SOS_API Property SOS
  SOS_API Function Get()
    If !_SOS
      _SOS = SOS_API.Get()
    EndIf
    Return _SOS
  EndFunction
EndProperty


Sound Property SLH_MoanMarkerBreast  Auto
Sound Property SLH_MoanMarkerBelly  Auto
Sound Property SLH_MoanMarkerButt  Auto
ReferenceAlias Property PlayerAlias  Auto  

GlobalVariable Property SLH_Libido  Auto  
GlobalVariable Property SLH_OrigWeight  Auto  

SPELL Property SLH_Masturbation  Auto  
SPELL Property SLH_Undress  Auto  
bool property bBeeingFemale = false auto
bool property bEstrusChaurus = false auto
spell property BeeingFemalePregnancy auto
spell property ChaurusBreeder auto

int Property MAX_PRESETS = 4 AutoReadOnly
int Property MAX_MORPHS = 19 AutoReadOnly

Bool	 bInit 
String[] skillList
float fRefreshAfterSleep = 0.0

float DaysUntilNextAllowed = 0.04  ;about 1 "game hour" expressed in GameDaysPassed
float NextAllowed = -1.0
int daysPassed

; Code base from SexLabUtil1 and EstrusChaurus
; Adapted with permission of both authors

Event OnInit()
	_doInit()
	RegisterForSleep()
	RegisterForSingleUpdate(5)
EndEvent

Function _doInit()

	skillList = new String[18]
	skillList[0]  = "OneHanded"
	skillList[1]  = "TwoHanded"
	skillList[2]  = "Marksman"
	skillList[3]  = "Block"
	skillList[4]  = "Smithing"
	skillList[5]  = "HeavyArmor"
	skillList[6]  = "LightArmor"
	skillList[7]  = "Pickpocket"
	skillList[8]  = "Lockpicking"
	skillList[9]  = "Sneak"
	skillList[10] = "Alchemy"
	skillList[11] = "Speechcraft"
	skillList[12] = "Alteration"
	skillList[13] = "Conjuration"
	skillList[14] = "Destruction"
	skillList[15] = "Illusion"
	skillList[16] = "Restoration"
	skillList[17] = "Enchanting"

	NextAllowed = -1.0
EndFunction

Function Maintenance()
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	
	; UnregisterForAllModEvents()
	Debug.Trace("[SLH]  Reset SexLab events")
	RegisterForModEvent("AnimationStart", "OnSexLabStart")
	RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")
	RegisterForModEvent("SLHRefresh",    "OnRefreshShapeEvent")
	RegisterForModEvent("SLHSetShape",    "OnSetShapeEvent")
	RegisterForModEvent("SLHResetShape",    "OnResetShapeEvent")
	RegisterForModEvent("SLHSetSchlong",    "OnSetSchlongEvent")
	RegisterForModEvent("SLHRemoveSchlong",    "OnRemoveSchlongEvent")

	RegisterForSleep()
	RegisterForSingleUpdate(5)

	; Debug.Notification("SexLab Hormones: Add spell")
	PlayerActor.AddSpell( SLH_Masturbation )
	PlayerActor.AddSpell( SLH_Undress )

	_initShapeConstants()
	_getHormonesState()	

	; Debug.Notification("[Hormones] s:" + iSexCountToday + " - v:" + iVaginalCountToday + " - a:" + iAnalCountToday + " - o:" + iOralCountToday)

	If (iGameDateLastSex  == 0)  ; Variable never set - initialize state
		_initHormonesState()
	EndIf

	if (pActorBase.GetSex() == 1) ; female
		bIsFemale = True
	Else
		bIsFemale = False
	EndIf

	NextAllowed = -1.0

 	daysPassed = Game.QueryStat("Days Passed")

	If (iGameDateLastSex  == -1) 
		iGameDateLastSex = daysPassed   
	EndIf

	If (iGameDateLastCheck  == -1) 
		iGameDateLastCheck = daysPassed   
	EndIf
 
EndFunction

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	Debug.Trace("Player went to sleep at: " + Utility.GameTimeToString(afSleepStartTime))
	Debug.Trace("Player wants to wake up at: " + Utility.GameTimeToString(afDesiredSleepEndTime))

	fRefreshAfterSleep = (afDesiredSleepEndTime - afSleepStartTime)
	Debug.Trace("[SLH]  fRefreshAfterSleep: " + fRefreshAfterSleep)
endEvent

Event OnSleepStop(bool abInterrupted)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor

	if abInterrupted
	    ; Debug.Trace("Player was woken by something!")
	else
	    ; Debug.Trace("Player woke up naturally")
	endIf

endEvent

Event OnUpdate()
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	Int RandomNum = 0
	Bool bExternalChangeModActive = _isExternalChangeModActive(PlayerActor)
	
	; Modifiers for each part - on update in case they were modified in MCM
	fWeightSwellMod = GV_weightSwellMod.GetValue()   ; 5.0   

	fBreastSwellMod = GV_breastSwellMod.GetValue()   ; 0.3 
	fBellySwellMod = GV_bellySwellMod.GetValue()   ; 0.1 
	fButtSwellMod = GV_buttSwellMod.GetValue()   ; 0.2 
	fSchlongSwellMod = GV_schlongSwellMod.GetValue()   ; 0.2 

	fBreastMax      = GV_breastMax.GetValue()   ; 4.0
	fBellyMax       = GV_bellyMax.GetValue()   ; 1.0
	fButtMax       	= GV_buttMax.GetValue()   ; 4.0
	fSchlongMax     = GV_schlongMax.GetValue()   ; 4.0
	fSchlongMax     = GV_weightMax.GetValue()   ; 4.0

	fBreastMin      = GV_breastMin.GetValue()   ; 4.0
	fBellyMin       = GV_bellyMin.GetValue()   ; 1.0
	fButtMin       	= GV_buttMin.GetValue()   ; 4.0
	fSchlongMin     = GV_schlongMin.GetValue()   ; 4.0
	fSchlongMax     = GV_schlongMax.GetValue()   ; 4.0

	if !Self
		Return
	EndIf

	; Debug.Notification("SexLab Hormones: Init: " + bInit)
	if !bInit
		bInit = True

		kTarget = PlayerActor

		Debug.Trace("[SLH]  Add spell")
		PlayerActor.AddSpell( SLH_Masturbation )
		PlayerActor.AddSpell( SLH_Undress )

		; Debug.Notification("SexLab Hormones: Waiting for 3d to load")
		; make sure we have loaded 3d to access
		; while ( !kTarget.Is3DLoaded() )
		; 	Utility.Wait( 1.0 )
		; endWhile

		Debug.Trace("[SLH]  Save body state baseline")

		if (pActorBase.GetSex() == 1) ; female
			bIsFemale = True
		Else
			bIsFemale = False
		EndIf

		NextAllowed = -1.0

		_initShapeConstants()
		_getHormonesState()	

		If (iGameDateLastSex  == 0)  ; Variable never set - initialize state
			_initHormonesState()
		EndIf

		Debug.Trace("[SLH]  Registering SexLab events")
		RegisterForModEvent("AnimationStart", "OnSexLabStart")
		RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
		RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")
		RegisterForModEvent("SLHRefresh",    "OnRefreshShapeEvent")
		RegisterForModEvent("SLHSetShape",    "OnSetShapeEvent")
		RegisterForModEvent("SLHResetShape",    "OnResetShapeEvent")
		RegisterForModEvent("SLHSetSchlong",    "OnSetSchlongEvent")
		RegisterForModEvent("SLHRemoveSchlong",    "OnRemoveSchlongEvent")

		StorageUtil.SetIntValue(Game.GetPlayer(), "Puppet_SpellON", -1)
		StorageUtil.SetIntValue(Game.GetPlayer(), "PSQ_SpellON", -1)

		Debug.Trace("[SLH]  Initialization of body")
		_alterBodyAfterRest()
		_setHormonesState()	

		Debug.Notification("SexLab Hormones started")
		Debug.Trace("SexLab Hormones started")
	EndIf

 	daysPassed = Game.QueryStat("Days Passed")
 
 	; Debug.Notification("SexLab Hormones: Days Passed: " + daysPassed + " / " + iGameDateLastCheck)
	; Debug.Notification("SexLab Hormones: fRefreshAfterSleep: " + fRefreshAfterSleep )


 	; Debug.Notification("SexLab Hormones: iDaysSinceLastSex: " + iDaysSinceLastSex)
 	; Debug.Notification("SexLab Hormones: iDaysSinceLastCheck: " + iDaysSinceLastCheck)

 	iDaysSinceLastSex = (daysPassed - iGameDateLastSex ) as Int
	iDaysSinceLastCheck = (daysPassed - iGameDateLastCheck ) as Int

	StorageUtil.SetIntValue(none, "_SLH_iDaysSinceLastSex", iDaysSinceLastSex)
	StorageUtil.SetIntValue(none, "_SLH_iDaysSinceLastCheck", iDaysSinceLastCheck)

 	; Debug.Notification("SexLab Hormones: - iDaysSinceLastSex: " + iDaysSinceLastSex)
 	; Debug.Notification("SexLab Hormones: - iDaysSinceLastCheck: " + iDaysSinceLastCheck)
 	
 	; Debug.Notification("SexLab Hormones: NextAllowed " + NextAllowed)

	; Debug.Trace("[SLH]  Forced refresh flag: " + StorageUtil.GetIntValue(none, "_SLH_iForcedRefresh"))

	If ( StorageUtil.GetIntValue(none, "_SLH_iForcedRefresh") == 1)
		; Forced refresh from PapyrusUtils (API)

		Debug.Trace("[SLH]  Forced refresh from API - storageUtil trigger - deprecated for mod event")	

		SendModEvent("SLHRefresh")

	ElseIf (iDaysSinceLastCheck > 0) || (fRefreshAfterSleep > 0.02)
		; Manage sex effect ==================================================
		If (iSexCountToday==0)
			PlayerActor.DispelSpell(_SLH_SexBoost)
			_SLH_SexFocus.Cast(PlayerActor,PlayerActor)
			_SLH_SexStarve.Cast(PlayerActor,PlayerActor)
		EndIf

		fRefreshAfterSleep = 0.0

		Debug.Trace("[SLH]  Days since Sex acts : " + iDaysSinceLastSex)
		; Check if body modifications are applicable
			
		_getShapeState()

		If ( _isExternalChangeModActive(PlayerActor) )
			_getShapeActor()
		EndIf

		_alterBodyAfterRest()
		_setHormonesState()	

		If !( bExternalChangeModActive ) && (NextAllowed!= -1) && (GV_shapeUpdateOnTimer.GetValue()==1)
			_applyBodyShapeChanges()
		EndIf

	Else
		RandomNum = Utility.RandomInt(0,100)
		If (RandomNum>90)
			; Debug.Trace("[SLH]  Today: Sex acts: " + iSexCountToday + " - Orgasms: " + iOrgasmsCountToday)
			; Debug.Trace("[SLH]  Sex dates: " + Game.QueryStat("Days Passed") + " - " + iGameDateLastSex + " = " + iDaysSinceLastSex)
			; Debug.Trace("[SLH]  Check dates: " + Game.QueryStat("Days Passed") + " - " + iGameDateLastCheck + " = " + iDaysSinceLastCheck)
		EndIf

		; Debug.Notification("[Hormones] Next: " + NextAllowed)
		; Debug.Notification("[Hormones] Day passed stat: " +  Game.QueryStat("Days Passed"))
		; Debug.Notification("[Hormones] RandomNum: " + RandomNum)


		If (RandomNum>50) && (bIsFemale)  && (iSexCountToday > 0) && (NextAllowed > 15) && (GV_showStatus.GetValue() == 1)
			; Debug.Notification("[Hormones] s:" + iSexCountToday + " - v:" + iVaginalCountToday + " - a:" + iAnalCountToday + " - o:" + iOralCountToday)

			If (iVaginalCountToday > 0) 
				If (iVaginalCountToday > 10) 
					Debug.Notification("Your pussy feels sore and slippery.")
				ElseIf (iVaginalCountToday > 5) 
					Debug.Notification("Semen runs down your leg slowly.")
				Else
					Debug.Notification("Your pussy is moist and throbbing softly.")
				EndIf
			EndIf
			If (iAnalCountToday > 0) 
				If (iAnalCountToday > 10) 
					Debug.Notification("Your ass is a painful reminder of your fate.")
				ElseIf (iAnalCountToday > 5) 
					Debug.Notification("Your ass feels wet and sticky.")
				Else
					Debug.Notification("Your ass is still sore.")
				EndIf
			EndIf
			If (iOralCountToday > 0)
				If (iOralCountToday > 10) 
					Debug.Notification("The after taste of cum makes you feel dizzy.")
				ElseIf (iOralCountToday > 5) 
					Debug.Notification("Your cleavage is still sticky from dripping cum.")
				Else
					Debug.Notification("Saltiness still coats your lips.")
				EndIf
			EndIf

			
			NextAllowed = 0.0 ;  GameDaysPassed.GetValue() + DaysUntilNextAllowed


		ElseIf (RandomNum>80) && !(bIsFemale) && (iSexCountToday > 0)  && (NextAllowed > 10) && (GV_showStatus.GetValue() == 1)
			If (iSexCountToday > 10) 
				Debug.Notification("Your cock throbs painfully after what happened today.")
			ElseIf (iSexCountToday > 5) 
				Debug.Notification("Your hardon keeps you horny and warm.")
			ElseIf (iSexCountToday > 0) 
				Debug.Notification("Cum still coats the tip of your cock.")
			EndIf

			NextAllowed = 0.0 ;  GameDaysPassed.GetValue() + DaysUntilNextAllowed

		EndIf

		; Detect pregnancy ==================================================
		Bool bShapeChangeDetect = _detectShapeChange()

		If (NextAllowed == -1.0) 
			; First time here after loading a game - apply changes to shape
			; Refreshing values in case of any external change from other mods
			; _getShapeState()
			; _refreshBodyShape()
			; _setHormonesState()

			; If !( _isExternalChangeModActive(PlayerActor) )
				_applyBodyShapeChanges()
			; EndIf

			NextAllowed = 0.0

		ElseIf (bShapeChangeDetect) 

			If ( _isExternalChangeModActive(PlayerActor) )

				Debug.Trace("[SLH]  Update ignored. PC is changing from another mod.")
				; GV_changeOverrideToggle.SetValue(0)

				; Refreshing values in case of any external change from other mods
				_getShapeActor()
				; _refreshBodyShape()
				_setHormonesState()

				; No need to apply changes again since other mods have already changed body shape
				; _applyBodyShapeChanges()
			Else
				; GV_changeOverrideToggle.SetValue(1)

				Debug.Trace("[SLH]  Updating shape.")
				; Debug.Notification("SexLab Hormones: Before: " + fBelly + " from " + NetImmerse.GetNodeScale(PlayerActor, NINODE_BELLY, false) )

				; Refreshing values in case of any external change from other mods
				; _getShapeState(bUseNodes = True)
				_getShapeState()

				iSkinColor = _alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iOrigSkinColor, colorMod = 1.0/8.0 )

				_refreshBodyShape()
				_setHormonesState()

				If (GV_shapeUpdateOnCellChange.GetValue()==1)
					_applyBodyShapeChanges()
				EndIf

				; Debug.Notification("SexLab Hormones: After: " + fBelly + " from " + NetImmerse.GetNodeScale(PlayerActor, NINODE_BELLY, false) )
			EndIf

		EndIf

		NextAllowed = NextAllowed + 1.0 ;  GameDaysPassed.GetValue() + DaysUntilNextAllowed

	EndIf

	iGameDateLastCheck = daysPassed  

	RegisterForSingleUpdate(10)
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
  if akBaseObject as Armor

		SendModEvent("SLHRefresh")

  endIf
endEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
  if akBaseObject as Armor

		SendModEvent("SLHRefresh")

  endIf
endEvent

Event OnRefreshShapeEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.getPlayer() as Actor
	Bool bExternalChangeModActive = _isExternalChangeModActive(PlayerActor)

	Debug.Trace("[SLH] Receiving 'refresh shape' event" )

	If ( StorageUtil.GetIntValue(none, "_SLH_iForcedRairLoss") == 1)
		_shaveHair ( )		
		StorageUtil.SetIntValue(none, "_SLH_iForcedRairLoss", 0) 
	Endif

	_getShapeState()

	Utility.Wait(1.0)

	_refreshBodyShape()
	_setHormonesState()

	If !( bExternalChangeModActive ) && (NextAllowed!= -1)
		_applyBodyShapeChanges()
	EndIf
	
	StorageUtil.SetIntValue(none, "_SLH_iForcedRefresh", 0) 
	GV_forcedRefresh.SetValue(0)

	
EndEvent

Event OnSetShapeEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.getPlayer() as Actor

	Debug.Trace("[SLH] Receiving 'set shape' event" )

	_setHormonesStateDefault()
	
EndEvent

Event OnResetShapeEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.getPlayer() as Actor

	Debug.Trace("[SLH] Receiving 'reset shape' event" )

	_resetHormonesState()
	
EndEvent

Event OnSetSchlongEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.getPlayer() as Actor
   	Form schlong

	Debug.Trace("[SLH] Receiving 'set schlong' event" )

	if (_args == "Any") || (_args == "")
		schlong =  SOS_Data.GetAddon(0)
	else
		; Get first addon available for now... add code to better select later
		schlong = SOS.FindSchlongByName(_args)
	endif
 
 	if (schlong != None)
    	SOS.SetSchlong(kActor, schlong)
    endIf

    ;/
    Other ways for getting a schlong ref
    Form schlong = sos.GetSchlong(Game.GetPlayer())
    Form schlong = Quest.GetQuest("SOS_Addon_VectorPlexusMuscular_Quest") ; or Game.GetFormFromFile()
    Form schlong = SOS_Data.GetAddon(i) ; to iterate installed schlongs, where i between 0 and SOS_Data.CountAddons()
    /;
	
EndEvent

Event OnRemoveSchlongEvent(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.getPlayer() as Actor

	Debug.Trace("[SLH] Receiving 'remove schlong' event" )

	Form schlong = sos.GetSchlong(kActor)
 
 	if (schlong != None)
    	SOS.RemoveSchlong(kActor)
    endIf

    ;/
    Other ways for getting a schlong ref
    Form schlong = sos.GetSchlong(Game.GetPlayer())
    Form schlong = Quest.GetQuest("SOS_Addon_VectorPlexusMuscular_Quest") ; or Game.GetFormFromFile()
    Form schlong = SOS_Data.GetAddon(i) ; to iterate installed schlongs, where i between 0 and SOS_Data.CountAddons()
    /;
	
EndEvent


Bool Function isSchlongSet(Actor akActor)
	Return SOS.isSchlonged(akActor)
Endfunction

Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLab 
		Debug.Trace("[SLH] Critical error on SexLab Start")
		Return
	EndIf
	
	; Debug.Notification("SexLab Hormones: Sex start")

	Actor[] actors = SexLab.HookActors(_args)
	Actor   victim = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim
	
	
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
    Bool bOral = False
    Bool bVaginal = False
    Bool bAnal = False

	
	kTarget = PlayerActor
	kPlayer = PlayerActor

	if !Self || !SexLab 
		Debug.Trace("[SLH] Critical error on SexLab End")
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
	    Debug.Trace("[SLH]  Sex end: " + animation.name)

		If victim  ;none consensual
			;
	
		Else  ;consensual
			;
	
		EndIf

		; Manage orgasms count ==================================================
		If (iGameDateLastSex  == 0) 
			iGameDateLastSex = Game.QueryStat("Days Passed")   
		EndIf

		iDaysSinceLastSex = (Game.QueryStat("Days Passed") - iGameDateLastSex ) as Int

		iSexCountAll   = iSexCountAll + 1

		If (iDaysSinceLastSex == 0)
			iSexCountToday   = iSexCountToday + 1
		EndIf

		iGameDateLastSex = Game.QueryStat("Days Passed")   


		; Manage sex effect ==================================================
		If (iSexCountToday>1)
			PlayerActor.DispelSpell(_SLH_SexFocus)
			_SLH_SexBoost.Cast(PlayerActor,PlayerActor)
		EndIf

		; Manage sex act count ==================================================
		if animation.HasTag("Oral") || animation.HasTag("Bestiality") || animation.HasTag("Gangbang")
	    	iOralCountToday   = iOralCountToday + 1
			bOral = True
	    EndIf

		if animation.HasTag("Anal") || animation.HasTag("Doggystyle") || animation.HasTag("Gangbang")
	 	   iAnalCountToday   = iAnalCountToday + 1
			bAnal = True
	    EndIf

		if animation.HasTag("Vaginal") || animation.HasTag("Holding") || animation.HasTag("Gangbang")
	        iVaginalCountToday   = iVaginalCountToday + 1
			bVaginal = True
	    EndIf

		Debug.Trace("[Hormones] s:" + iSexCountToday + " - v:" + iVaginalCountToday + " - a:" + iAnalCountToday + " - o:" + iOralCountToday)

		; Manage racial act count ==================================================
		; akSpeaker.GetActorBase().GetSex() as Int
		if animation.HasTag("Bestiality")
			iSexCreaturesAll   	= iSexCreaturesAll + 1
		EndIf

		if animation.HasTag("Canine")
			iSexDogAll   	= iSexDogAll + 1
		EndIf

		if animation.HasTag("Wolf")
			iSexWolfAll   	= iSexWolfAll + 1
		EndIf

		if animation.HasTag("Troll")
			iSexTrollAll   	= iSexTrollAll + 1
		EndIf

		if animation.HasTag("Chaurus") ||  animation.HasTag("Spider")
			iSexBugAll   	= iSexBugAll + 1
		EndIf

		if animation.HasTag("Giant")
			iSexGiantAll   	= iSexGiantAll + 1
		EndIf

		if animation.HasTag("Falmer")
			iSexFalmerAll   	= iSexFalmerAll + 1
		EndIf

		if animation.HasTag("Horse")
			iSexHorseAll   	= iSexHorseAll + 1
		EndIf

		if animation.HasTag("Bear")
			iSexBearAll   	= iSexBearAll + 1
		EndIf

		if animation.HasTag("Cat")
			iSexCatAll   	= iSexCatAll + 1
		EndIf

		if animation.HasTag("Gargoyle")
			iSexGargoyleAll   	= iSexGargoyleAll + 1
		EndIf

		if animation.HasTag("Vampire Lord")
			iSexVampireLordAll   	= iSexVampireLordAll + 1
		EndIf

		if animation.HasTag("Dragon")
			iSexDragonAll   	= iSexDragonAll + 1
		EndIf

		; Debug.Trace("[Hormones] Daedra sex count:" + iSexDaedraAll + " - race check:" + _hasRace(actors, _SLH_DremoraRace) )

		if animation.HasTag("Daedra") || _hasRace(actors, _SLH_DremoraRace) || _hasRace(actors, _SLH_DremoraOutcastRace)
			iSexDaedraAll   	= iSexDaedraAll + 1
			iDaedricInfluence   = iSexDaedraAll * 3 + Game.QueryStat("Daedric Quests Completed") * 2 + Game.QueryStat("Daedra Killed") + 1

			Debug.Trace("[Hormones] Daedra sex count:" + iSexDaedraAll + " - influence:" + iDaedricInfluence)

			_SLH_DaedricInfluence.Cast(PlayerActor,PlayerActor)

			; modify succubus influence based on other daedric exposure
			if (iDaedricInfluence >1) && (GV_allowSuccubus.GetValue()==1) && (GV_isSuccubus.GetValue()==0)
				iSuccubus = 1
				GV_isSuccubus.SetValue(1)
				; _SLH_QST_Succubus.Start()
				_SLH_QST_Succubus.SetStage(10)

			elseif (iDaedricInfluence >1) && (GV_allowSuccubus.GetValue()==1) && (GV_isSuccubus.GetValue()==1)
				if (_SLH_QST_Succubus.GetStage()<=10) && (iDaedricInfluence >=10)
					_SLH_QST_Succubus.SetStage(20)
				elseif (_SLH_QST_Succubus.GetStage()<=20) && (iDaedricInfluence >=20)
					_SLH_QST_Succubus.SetStage(30)
					ModEvent.Send(ModEvent.Create("HoSLDD_GivePlayerPowers"))
				elseif (_SLH_QST_Succubus.GetStage()<=30) && (iDaedricInfluence >=30)
					_SLH_QST_Succubus.SetStage(40)
				elseif (_SLH_QST_Succubus.GetStage()<=40) && (iDaedricInfluence >=40)
					_SLH_QST_Succubus.SetStage(50)
					StorageUtil.SetIntValue(Game.GetPlayer(), "PSQ_SpellON", 1)
					SendModEvent("SLHisSuccubus")
				Endif
			else
				iSuccubus = 0
				GV_isSuccubus.SetValue(0)
			EndIf
			; _showStatus()
		EndIf


		If (bOral || bVaginal || bAnal)
			; Refreshing values in case of any external change from other mods
			_getShapeState()
	    	_alterBodyAfterSex(bOral, bVaginal, bAnal )
			_setHormonesState()	

			If !( _isExternalChangeModActive(PlayerActor) ) && (GV_shapeUpdateAfterSex.GetVAlue() == 1)
				_applyBodyShapeChanges()
			EndIf
		Else
			_setHormonesState()	
		EndIf


		if animation.HasTag("Masturbation") || animation.HasTag("Solo") 
			SLH_Libido.SetValue( iMin( iMax( (SLH_Libido.GetValue() as Int) + 1, -100), 100) )
			Debug.Trace("[SLH]  Set Libido to " + SLH_Libido.GetValue() as Int )	  
	    EndIf

	    ; Chance of rape if sex in public 

	    ; Test if kPervert is in actors[] - small chance of repeat from current partner

		actor kPervert = SexLab.FindAvailableActor(SexLab.PlayerRef as ObjectReference, 200.0)  

		If (GV_allowBimbo.GetValue()==1) || (GV_allowHRT.GetValue()==1) || (GV_allowTG.GetValue()==1) 
			If (GV_isBimbo.GetValue()==0) && (GV_isHRT.GetValue()==0) && (GV_isTG.GetValue()==0) && ( (_hasRace(actors, _SLH_DremoraOutcastRace) || _hasRace(actors, _SLH_BimboRace)))

				kPervert = None
				Debug.Trace("[SLH] Cast Bimbo Curse" )	  
				; PolymorphBimbo.Cast(PlayerActor,PlayerActor)
				PlayerActor.DoCombatSpellApply(PolymorphBimbo, PlayerActor)

				If _hasRace(actors, _SLH_BimboRace)
					_SLH_QST_Bimbo.SetStage(10)
					iDaedricInfluence   = iDaedricInfluence   + 5
				elseIf _hasRace(actors, _SLH_DremoraOutcastRace)
					_SLH_QST_Bimbo.SetStage(11)
				endif
			Endif
		Endif		

		If (kPervert) 
			Bool isCurrentPartner = _hasActor(actors, kPervert)

			If (!kPervert.IsDead()) && (kPervert.GetAV("Morality")<=2) && (((Utility.RandomInt(0,100)>50) && !isCurrentPartner) || ( (Utility.RandomInt(0,100)>90) && isCurrentPartner))

				If  (SexLab.ValidateActor( SexLab.PlayerRef) > 0) && (SexLab.ValidateActor( kPervert) > 0) 
					Int IButton = _SLH_warning.Show()

					If IButton == 0 ; Show the thing.

						; Debug.MessageBox( "Someone grabs you before you are done ." )
						SexLab.QuickStart(SexLab.PlayerRef, kPervert, Victim = SexLab.PlayerRef, AnimationTags = "Aggressive")
					EndIf
				Else
					Debug.Trace("[SLH]  Pervert found but not ready [SexLab not ready]" )
				EndIf
			EndIf
		Else
			Debug.Trace("[SLH]  No pervert found " )

		EndIf


	EndIf

EndEvent

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor

	if !Self || !SexLab 
		Debug.Trace("[SLH]  Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim
	
	; if _checkRnd100(config.fSoulCProc)
	;	_doSoulDevour(actors)
	; endif

	If (_hasPlayer(actors))
		Debug.Trace("[SLH]  Orgasm!")

		; Manage orgasms count ==================================================
		If (iGameDateLastSex  == 0) 
			iGameDateLastSex = Game.QueryStat("Days Passed")   
		EndIf

		iDaysSinceLastSex = (Game.QueryStat("Days Passed") - iGameDateLastSex ) as Int

		iOrgasmsCountAll   = iOrgasmsCountAll + 1

		If (iDaysSinceLastSex == 0)
			iOrgasmsCountToday   = iOrgasmsCountToday + 1
		EndIf

		If (iOrgasmsCountToday>=1)
			PlayerActor.DispelSpell(_SLH_SexStarve)
		EndIf

		iGameDateLastSex = Game.QueryStat("Days Passed")   
		Float AbsLibido = (Math.abs(SLH_Libido.GetValue()) as Float)

		; Succubus effect ==================================================
		If ((iSuccubus == 1)  && (_SLH_QST_Succubus.GetStage()>=30))
			; PlayerActor.resethealthandlimbs()
			If (Utility.RandomInt(0,100) > (60.0 - (AbsLibido / 10.0) * 2.0) )
				_doSoulDevour(actors)
			EndIf
		EndIf

		; Succubus effect ==================================================
		If ((iSuccubus == 1)  && (iDaedricInfluence>=20))
			; PlayerActor.resethealthandlimbs()

			If ( AbsLibido >= 80)
				StorageUtil.SetIntValue(Game.GetPlayer(), "Puppet_SpellON", 1)
				StorageUtil.SetIntValue(Game.GetPlayer(), "_SLH_succubusMC", 1)
			Else
				if (StorageUtil.GetIntValue(Game.GetPlayer(), "_SLMC_controlDeviceON")!=1)
					StorageUtil.SetIntValue(Game.GetPlayer(), "Puppet_SpellON", -1)
				EndIf
				StorageUtil.SetIntValue(Game.GetPlayer(), "_SLH_succubusMC", 0) 
			EndIf
		EndIf
		; _showStatus()

	EndIf
	
EndEvent

Function _alterBodyAfterRest()
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	Float fNodeMax
	Race thisRace = pActorBase.GetRace()
	Bool bArmorOn = PlayerActor.WornHasKeyword(ArmorOn)
	Bool bClothingOn = PlayerActor.WornHasKeyword(ClothingOn)
	Bool bExternalChangeModActive = _isExternalChangeModActive(PlayerActor)
	Float fApparelMod = 1.0
	
	If (kOrigRace != None) 
		If (thisRace != kOrigRace)
			Debug.Trace("[SLH]  Race change detected - aborting")
			return
		EndIf
	EndIf

	If (bArmorOn)
		fApparelMod = GV_armorMod.GetValue() as Float
	ElseIf (bClothingOn)
		fApparelMod = GV_clothMod.GetValue() as Float
	EndIf

	fGameTime       = Utility.GetCurrentGameTime()
	
	; SexLab Aroused ==================================================
	_manageSexLabAroused()

	iDaysSinceLastSex = (Game.QueryStat("Days Passed") - iGameDateLastSex ) as Int

	If (iSexCountToday <= 1) && (iDaysSinceLastSex >= (GV_sexActivityBuffer.GetValue() as Int) ); Decrease
		Debug.Notification("You feel more focused")
		fSwellFactor = -1.0 * GV_baseShrinkFactor.GetValue() 
		SLH_Libido.SetValue(SLH_Libido.GetValue() - 10)

		iDaedricInfluence   = iMax(0, iDaedricInfluence   - 1 )

	ElseIf ( iSexCountToday >1) && ( (iSexCountToday >= GV_sexActivityThreshold.GetValue()) || (iDaysSinceLastSex <= (GV_sexActivityBuffer.GetValue() as Int) ) ) ; Increase
		Debug.Notification("You feel more voluptuous")
		SLH_Libido.SetValue(SLH_Libido.GetValue() + 3 + iMin(iOrgasmsCountToday,10) + ( 10 - (Abs(SLH_Libido.GetValue()) / 10) ))

		fSwellFactor    = GV_baseSwellFactor.GetValue() 

	Else     ; If ((iSexCountToday > 1) && (iSexCountToday <= GV_sexActivityThreshold.GetValue())) || (iDaysSinceLastSex <= GV_sexActivityBuffer.GetValue())  ; Stable
		Debug.Notification("You feel more balanced")
		; No change
		; fSwellFactor = -0.5 * fSwellFactor 
		; SLH_Libido.SetValue(SLH_Libido.GetValue() - 1)
		fSwellFactor    = 0
		SLH_Libido.SetValue(SLH_Libido.GetValue() + 2 - Utility.RandomInt(0, 4))

	EndIf	

	; Debug - Decrease
	;	fSwellFactor = -5.0 
	;	SLH_Libido.SetValue(-90)

	SLH_Libido.SetValue( iMin( iMax( (SLH_Libido.GetValue() as Int), -100), 100) )

	If (GV_isBimbo.GetValue()==1)
		SLH_Libido.SetValue( iMin( iMax( (SLH_Libido.GetValue() as Int) + 5, 50), 100) )
	EndIf

	Debug.Trace("[SLH]  Set Libido to " + SLH_Libido.GetValue() as Int )

	if (GV_useWeight.GetValue() == 1)
		Debug.Trace( "[SLH] _alterBodyAfterRest Weight")
		Debug.Trace( "[SLH] Actorbase weight: " + pActorBase.GetWeight())
		Debug.Trace( "[SLH] Current weight: " + fWeight)
		Debug.Trace( "[SLH] StorageUtil: " + StorageUtil.GetFloatValue(none, "_SLH_fWeight") )

		; WEIGHT CHANGE ====================================================
		Float fCurrentWeight = pActorBase.GetWeight()
		fWeight = fMin(fMax( fCurrentWeight + ( fSwellFactor * (110 - fCurrentWeight) / 100.0 ) * fWeightSwellMod  , fWeightMin), fWeightMax)
		Debug.Trace("[SLH]  Set weight to " + fWeight + " from " + fCurrentWeight)
		_alterWeight( fWeight, fCurrentWeight  )

		; Debug.Notification("[SLH]  Set weight to " + fWeight + " from " + fCurrentWeight)

	EndIf

	If (fSwellFactor != 0) && (bIsFemale) && (GV_useNodes.GetValue() == 1)
		; --------
		; BREAST SWELL ====================================================
		If ((iSexCountToday > 0) || (fSwellFactor < 0)) && (GV_useBreastNode.GetValue() == 1)
			if ( bBreastEnabled ) 
				Float fCurrentBreast = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BREAST, false)

				if (bExternalChangeModActive)
					fNodeMax = fPregBreastMax
					fBreast = fCurrentBreast
				Else
					fNodeMax = fBreastMax
					fBreast = ( fCurrentBreast + ( fSwellFactor * (fNodeMax + fBreastMin  - fCurrentBreast) / 100.0 ) * fBreastSwellMod )  * fApparelMod
				EndIf

				; Debug.Trace("[SLH]  Breast swell mod:  " + fBreastSwellMod)
				; Debug.Trace("[SLH]  Set breast to " + fBreast + " from " + fCurrentBreast)

				_alterBreastNode( fBreast )	

				if fGrowthLastMsg < fGameTime && fSwellFactor > 0
					fGrowthLastMsg = fGameTime + Utility.RandomFloat(0.0417, 0.25)

					; Debug.Notification(sSwellingMsgs[Utility.RandomInt(0, sSwellingMsgs.Length - 1)])
					If (fSwellFactor > 0)
							Sound.SetInstanceVolume( SLH_MoanMarkerBreast.Play(PlayerActor), 1.0 )
					EndIf
				endif				
			endif
		EndIf

		; BELLY SWELL =====================================================
		If ((iSexCountToday > 0) || (fSwellFactor < 0)) && (GV_useBellyNode.GetValue() == 1)
			if ( bBellyEnabled )  
				Float fCurrentBelly = NetImmerse.GetNodeScale(PlayerActor, NINODE_BELLY, false)

				if (bExternalChangeModActive)
					fNodeMax = fPregBellyMax
					fBelly = fCurrentBelly
				Else
					fNodeMax = fBellyMax
					fBelly = (fCurrentBelly + ( fSwellFactor * (fNodeMax + fBellyMin - fCurrentBelly) / 100.0 ) * fBellySwellMod ) * fApparelMod
				EndIf
				
				_alterBellyNode(fBelly )

			endif
		EndIf

		; BUTT SWELL ======================================================
		If ((iSexCountToday > 0) || (fSwellFactor < 0)) && (GV_useButtNode.GetValue() == 1)
			if ( bButtEnabled )  
				Float fCurrentButt = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BUTT, false)

				if (bExternalChangeModActive)
					fNodeMax = fPregButtMax
					fButt = fCurrentButt
				Else
					fNodeMax = fButtMax
					fButt = ( fCurrentButt + ( fSwellFactor * (fNodeMax + fButtMin  - fCurrentButt) / 100.0 ) * fButtSwellMod )  * fApparelMod
				EndIf
				
				_alterButtNode( fButt )
			endif
		EndIf

	ElseIf (fSwellFactor != 0) && !(bIsFemale) && (GV_useNodes.GetValue() == 1)
		; Debug.Notification("SexLab Hormones: Male: Schlong updates: " + fSchlong )
		; SCHLONG SWELL ======================================================
		If  (iVaginalCountToday > 0) || (iAnalCountToday > 0) || (iOralCountToday > 0)  || (fSwellFactor < 0)
			; Debug.Notification("SexLab Hormones: Male: Schlong enabled: " + bEnableSchlong )

			if ( bEnableSchlong )   && (GV_useSchlongNode.GetValue() == 1)
				Float fCurrentSchlong = NetImmerse.GetNodeScale(PlayerActor, NINODE_SCHLONG, false)
				fSchlong = fCurrentSchlong + ( fSwellFactor * (fSchlongMax + fSchlongMin  - fCurrentSchlong) / 100.0 ) * fSchlongSwellMod 

				_alterSchlongNode( fSchlong )
			endif
		EndIf
	EndIf

	if (GV_useColors.GetValue() == 1)
		Debug.Trace("[SLH]  Set skin color"  )
		; SKIN TONE =======================================================

		; Types
		; 0 - Frekles
		; 1 - Lips
		; 2 - Cheeks
		; 3 - Eyeliner
		; 4 - Upper Eyesocket
		; 5 - Lower Eyesocket
		; 6 - SkinTone
		; 7 - Warpaint
		; 8 - Frownlines
		; 9 - Lower Cheeks
		; 10 - Nose
		; 11 - Chin
		; 12 - Neck
		; 13 - Forehead
		; 14 - Dirt

		Float fColorOffset = ( fSwellFactor * 0.2 / 100.0 ) ; max 0.2 increments
		Int rgbColorOffset = ( (fSwellFactor as Int) * 10 / 100 ) ; max 10 increments
		Debug.Trace("[SLH]  fColorOffset: " + fColorOffset )
		Debug.Trace("[SLH]  rgbColorOffset: " + rgbColorOffset )

		; skin
		; _alterTintMask(type = 6, alpha = (255.0 * colorFactor) as Int, red = 236, green =194, blue = 184)
		iRedSkinColor = Math.LeftShift(128, 24) + (GV_redShiftColor.GetValue() as Int)
		iBlueSkinColor = Math.LeftShift(128, 24) + (GV_blueShiftColor.GetValue() as Int)
		iSuccubusRedSkinColor = Math.LeftShift(255, 24) + (GV_redShiftColor.GetValue() as Int)
		iSuccubusBlueSkinColor = Math.LeftShift(255, 24) + (GV_blueShiftColor.GetValue() as Int)

		If ((iSuccubus == 1)  && (iDaedricInfluence>=10))
			fColorOffset = fColorOffset * 5.0
			rgbColorOffset = rgbColorOffset * 2
		EndIf

		if (fSwellFactor > 0) ; Aroused
			; skin
			; _alterTintMask(type = 6, alpha = (255.0 * colorFactor) as Int, red = 236, green =194, blue = 184)

			; iSkinColor = _alterTintMaskRelativeHSL(colorOrig = iOrigSkinColor, colorBase = iSkinColor, maskType = 6, maskIndex = 0, aOffset = rgbColorOffset, hOffset = 0.0, sOffset = 0.0, lOffset = -1.0 * fColorOffset  )
			iSkinColor = _alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iOrigSkinColor, colorMod = 1.0/3.0 )

			; cheeks
			; _alterTintMask(type = 9, alpha = (128.0 * colorFactor) as Int, red = 200, green = 10, blue = 10)
			iCheeksColor = _alterTintMaskRelativeRGB(colorBase = iCheeksColor, maskType = 9, maskIndex = 0, aOffset = rgbColorOffset, rOffset = rgbColorOffset, gOffset = 0, bOffset = 0)

			; lips
			; _alterTintMask(type = 1, alpha = (255.0 * colorFactor) as Int, red = 255, green = 0, blue = 0)
			iLipsColor = _alterTintMaskRelativeRGB(colorBase = iLipsColor, maskType = 1, maskIndex = 0, aOffset = rgbColorOffset, rOffset = rgbColorOffset * 2, gOffset = 0, bOffset = 0)

			; Eyeliner 
			; _alterTintMask(type = 3, alpha = (255.0 * colorFactor) as Int, red = 0, green = 0, blue = 0)
			iEyelinerColor = _alterTintMaskRelativeRGB(colorBase = iEyelinerColor, maskType = 3, maskIndex = 0, aOffset = rgbColorOffset, rOffset = -5, gOffset = -5, bOffset = -5)

		ElseIf (fSwellFactor == 0) ; Healthy
			; Coverge back to default skin color
			iSkinColor = _alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iOrigSkinColor, colorMod = 1.0/3.0 )
		Else ; Pale
			; skin
			; _alterTintMask(type = 6, alpha = (-1.0 * 255.0 * colorFactor) as Int, red = 220, green =229, blue = 255)
			; _alterTintMaskRelativeHSL(maskType = 6, maskIndex = 0, aOffset = colorOffset as Int, hOffset = 0.0, sOffset = 0.0, lOffset = colorOffset * 0.05 )

			; Coverge back to default skin color
			If ((iSuccubus == 1) && (iDaedricInfluence>=20))
				iSkinColor = _alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iSuccubusBlueSkinColor, colorMod = 1.0/4.0 * GV_redShiftColorMod.GetValue() )
			Else
				iSkinColor = _alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iBlueSkinColor, colorMod = 1.0/8.0  * GV_redShiftColorMod.GetValue())
			EndIf

			iSkinColor = _alterTintMaskRelativeHSL(colorOrig = iOrigSkinColor, colorBase = iSkinColor, maskType = 6, maskIndex = 0, aOffset = rgbColorOffset, hOffset = 0.0, sOffset = 0.0, lOffset = fColorOffset )

			; cheeks
			; _alterTintMask(type = 9, alpha = (-1.0 * 128.0 * colorFactor) as Int, red = 220, green = 229, blue = 255)
			iCheeksColor = _alterTintMaskRelativeRGB(colorBase = iCheeksColor, maskType = 9, maskIndex = 0, aOffset = rgbColorOffset, rOffset = 0, gOffset = 0, bOffset = rgbColorOffset)

			; lips
			; _alterTintMask(type = 1, alpha = (-1.0 * 255.0 * colorFactor) as Int, red = 10, green = 10, blue = 125)
			iLipsColor = _alterTintMaskRelativeRGB(colorBase = iLipsColor, maskType = 1, maskIndex = 0, aOffset = rgbColorOffset, rOffset = 0, gOffset = 0, bOffset = rgbColorOffset  )

			; Eyeliner 
			iEyelinerColor = _alterTintMaskRelativeRGB(colorBase = iEyelinerColor, maskType = 3, maskIndex = 0, aOffset = rgbColorOffset, rOffset = 5, gOffset = 0, bOffset = 0)

		EndIf
	EndIf
	
 	; _refreshBodyShape()
 	; _applyBodyShapeChanges()

	_traceStatus()

	iOrgasmsCountToday   = 0
	iSexCountToday   = 0
	iOralCountToday   = 0
	iAnalCountToday   = 0
	iVaginalCountToday   = 0


EndFunction

Function _alterBodyAfterSex(Bool bOral = False, Bool bVaginal = False, Bool bAnal = False)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	Float fNodeMax
	Race thisRace = pActorBase.GetRace()
	Bool bArmorOn = PlayerActor.WornHasKeyword(ArmorOn)
	Bool bClothingOn = PlayerActor.WornHasKeyword(ClothingOn)
	Bool bExternalChangeModActive = _isExternalChangeModActive(PlayerActor)
	Float fApparelMod = 1.0
	
	If (kOrigRace != None) 
		If (thisRace != kOrigRace)
			Debug.Trace("[SLH]  Race change detected - aborting")
			return
		EndIf
	EndIf

	If (bArmorOn)
		fApparelMod = GV_armorMod.GetValue() as Float
	ElseIf (bClothingOn)
		fApparelMod = GV_clothMod.GetValue() as Float
	EndIf

	fGameTime       = Utility.GetCurrentGameTime()
	
	; SexLab Aroused ==================================================
	_manageSexLabAroused()

	fSwellFactor    = GV_baseSwellFactor.GetValue() / GV_sexActivityThreshold.GetValue()

	SLH_Libido.SetValue( iMin( iMax( (SLH_Libido.GetValue() as Int) + 1, -100), 100) )

	If (GV_isBimbo.GetValue()==1)
		SLH_Libido.SetValue( iMin( iMax( (SLH_Libido.GetValue() as Int) + 10, 50), 100) )
	EndIf

	Debug.Trace("[SLH]  Set Libido to " + SLH_Libido.GetValue() as Int )

		Debug.Trace( "[SLH] _alterBodyAfterSex Weight")
		Debug.Trace( "[SLH] Actorbase weight: " + pActorBase.GetWeight())
		Debug.Trace( "[SLH] Current weight: " + fWeight)
		Debug.Trace( "[SLH] StorageUtil: " + StorageUtil.GetFloatValue(none, "_SLH_fWeight") )
		Debug.Trace( "[SLH] Global Value: " + GV_weightValue.GetValue() )


	If (bIsFemale) && (GV_useNodes.GetValue() == 1)
		; --------
		; BREAST SWELL ====================================================
		If (bOral) 
			if ( bBreastEnabled )  && (GV_useBreastNode.GetValue() == 1)
				Float fCurrentBreast = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BREAST, false)

				if (bExternalChangeModActive)
					fNodeMax = fPregBreastMax
					fBreast = fCurrentBreast 
				Else
					fNodeMax = fBreastMax
					fBreast = ( fCurrentBreast + ( fSwellFactor * (fNodeMax + fBreastMin  - fCurrentBreast) / 100.0 ) * fBreastSwellMod )  * fApparelMod
				EndIf

				_alterBreastNode( fBreast )				
			endif
		EndIf

		; BELLY SWELL =====================================================
		If  (bVaginal) 
			if ( bBellyEnabled )   && (GV_useBellyNode.GetValue() == 1)
				Float fCurrentBelly = NetImmerse.GetNodeScale(PlayerActor, NINODE_BELLY, false)

				if (bExternalChangeModActive) || (_isFHUCumFilledEnabled(Game.GetPlayer()))
					fNodeMax = fPregBellyMax
					fBelly = fCurrentBelly
				Else
					fNodeMax = fBellyMax
					fBelly = ( fCurrentBelly + ( fSwellFactor * (fNodeMax + fBellyMin  - fCurrentBelly) / 100.0 ) * fBellySwellMod )  * fApparelMod
				EndIf

				_alterBellyNode(fBelly)

			endif
		EndIf

		; BUTT SWELL ======================================================
		If  (bAnal) 
			if ( bButtEnabled )  && (GV_useButtNode.GetValue() == 1) 
				Float fCurrentButt = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BUTT, false)

				if (bExternalChangeModActive)
					fNodeMax = fPregButtMax
					fButt = fCurrentButt
				Else
					fNodeMax = fButtMax
					fButt = ( fCurrentButt + ( fSwellFactor * (fNodeMax + fButtMin  - fCurrentButt) / 100.0 ) * fButtSwellMod ) * fApparelMod
				EndIf

				_alterButtNode( fButt )
			endif
		EndIf

	ElseIf !(bIsFemale) && (GV_useNodes.GetValue() == 1)

		; SCHLONG SWELL ======================================================
		If  (bAnal) || (bVaginal) || (bOral) 

			if ( bEnableSchlong )   && (GV_useSchlongNode.GetValue() == 1)
				Float fCurrentSchlong = NetImmerse.GetNodeScale(PlayerActor, NINODE_SCHLONG, false)
				fSchlong = fCurrentSchlong + ( fSwellFactor * (fSchlongMax  + fSchlongMin - fCurrentSchlong) / 100.0 ) * fSchlongSwellMod 

				_alterSchlongNode( fSchlong )
			endif
		EndIf
	EndIf

	if (GV_useColors.GetValue() == 1)
		Debug.Trace("[SLH]  Set skin color"  )
		; SKIN TONE =======================================================

		; Types
		; 0 - Frekles
		; 1 - Lips
		; 2 - Cheeks
		; 3 - Eyeliner
		; 4 - Upper Eyesocket
		; 5 - Lower Eyesocket
		; 6 - SkinTone
		; 7 - Warpaint
		; 8 - Frownlines
		; 9 - Lower Cheeks
		; 10 - Nose
		; 11 - Chin
		; 12 - Neck
		; 13 - Forehead
		; 14 - Dirt


		Float fColorOffset = ( fSwellFactor * 0.4 / 100.0 ) ; max 0.2 increments
		Int rgbColorOffset = ( (fSwellFactor as Int) * 20 / 100 ) ; max 10 increments
		Debug.Trace("[SLH]  fColorOffset: " + fColorOffset )
		Debug.Trace("[SLH]  rgbColorOffset: " + rgbColorOffset )

		; skin
		; _alterTintMask(type = 6, alpha = (255.0 * colorFactor) as Int, red = 236, green =194, blue = 184)

		iRedSkinColor = Math.LeftShift(128, 24) + (GV_redShiftColor.GetValue() as Int)
		iBlueSkinColor = Math.LeftShift(128, 24) + (GV_blueShiftColor.GetValue() as Int)
		iSuccubusRedSkinColor = Math.LeftShift(255, 24) + (GV_redShiftColor.GetValue() as Int)
		iSuccubusBlueSkinColor = Math.LeftShift(255, 24) + (GV_blueShiftColor.GetValue() as Int)

		If ((iSuccubus == 1) && (iDaedricInfluence>=10))
			fColorOffset = fColorOffset * 2.0
			rgbColorOffset = rgbColorOffset * 2
		EndIf

		
		; Coverge back to default skin color
		If ((iSuccubus == 1) && (iDaedricInfluence>=20))
			iSkinColor = _alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iSuccubusRedSkinColor, colorMod = 1.0/4.0 * GV_redShiftColorMod.GetValue() )
		Else
			iSkinColor = _alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iRedSkinColor, colorMod = 1.0/8.0 * GV_redShiftColorMod.GetValue() )
		EndIf

		iSkinColor = _alterTintMaskRelativeHSL(colorOrig = iOrigSkinColor, colorBase = iSkinColor, maskType = 6, maskIndex = 0, aOffset = rgbColorOffset, hOffset = 0.0, sOffset = 0.0, lOffset = -1.0 * fColorOffset  )

		; cheeks
		; _alterTintMask(type = 9, alpha = (128.0 * colorFactor) as Int, red = 200, green = 10, blue = 10)
		iCheeksColor = _alterTintMaskRelativeRGB(colorBase = iCheeksColor, maskType = 9, maskIndex = 0, aOffset = rgbColorOffset, rOffset = rgbColorOffset, gOffset = 0, bOffset = 0)

		; lips
		; _alterTintMask(type = 1, alpha = (255.0 * colorFactor) as Int, red = 255, green = 0, blue = 0)
		iLipsColor = _alterTintMaskRelativeRGB(colorBase = iLipsColor, maskType = 1, maskIndex = 0, aOffset = rgbColorOffset, rOffset = rgbColorOffset * 2, gOffset = 0, bOffset = 0)

		; Eyeliner 
		; _alterTintMask(type = 3, alpha = (255.0 * colorFactor) as Int, red = 0, green = 0, blue = 0)
		iEyelinerColor = _alterTintMaskRelativeRGB(colorBase = iEyelinerColor, maskType = 3, maskIndex = 0, aOffset = rgbColorOffset, rOffset = -5, gOffset = -5, bOffset = -5)

	EndIf
	
 	; _refreshBodyShape()

	_traceStatus()

EndFunction

Bool Function _detectShapeChange()
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()

	Race thisRace = pActorBase.GetRace()

	If (kOrigRace != None) 
		If (thisRace != kOrigRace)
			Debug.Trace("[SLH]  Race change detected - aborting")
			return False
		EndIf
	EndIf

	Float fCurrentBreast       = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BREAST, false)
	Float fCurrentButt       = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BUTT, false)
	Float fCurrentBelly       = NetImmerse.GetNodeScale(PlayerActor, NINODE_BELLY, false)
	Float fCurrentSchlong       = NetImmerse.GetNodeScale(PlayerActor, NINODE_SCHLONG, false)
	Float fCurrentWeight = pActorBase.GetWeight()

	Bool changeDetected = False

	If (fCurrentBreast!=fBreast) || (fCurrentBelly!=fBelly) || (fCurrentButt!=fButt) || (fCurrentSchlong!=fSchlong) || (fCurrentWeight!=fWeight)
		changeDetected = True

		Debug.Trace("[SLH]  External shape change detected " )
		Debug.Trace("[SLH]  Breast change " + fBreast + " from " + fCurrentBreast )
		Debug.Trace("[SLH]  Butt change " + fButt + " from " + fCurrentButt )
		Debug.Trace("[SLH]  Belly change " + fBelly + " from " + fCurrentBelly )
		Debug.Trace("[SLH]  Schlong change " + fSchlong + " from " + fCurrentSchlong )

	EndIf

	return changeDetected
EndFunction

Function _showStatus()
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()

	Debug.MessageBox("SexLab Hormones \n Sex acts today: " + iSexCountToday + " - Total: " + iSexCountAll + " \n v: " + iVaginalCountToday  + " a: " + iAnalCountToday  + " o: " + iOralCountToday  + " \n Orgasms today: " + iOrgasmsCountToday + " - Total: " + iOrgasmsCountAll + " \n Libido: " + SLH_Libido.GetValue() + " \n Daedric: " + iDaedricInfluence + " Succubus: " + iSuccubus +" \n Bimbo: " + iBimbo +" \n Sex change: " + iHRT +" TransGender: " + iTG +" \n Pregnant: " + _isPregnantByBeeingFemale(PlayerActor) +" Chaurus: " + _isPregnantByEstrusChaurus(PlayerActor) +" \n Weight: " + fWeight + " \n Breasts: " + fBreast + " \n Belly: " + fBelly + " \n Butt: " + fButt + " \n Schlong: " + fSchlong)

	If (kOrigRace == None)
		kOrigRace = pActorBase.GetRace()
	EndIf
EndFunction

Function _traceStatus()
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor

	Debug.Trace("[SLH]  Status ---------------------------------" )
	Debug.Trace("[SLH]  Sex acts today: " + iSexCountToday + " - Total: " + iSexCountAll)

	Debug.Trace("[SLH]  Oral acts today: " + iOralCountToday)
	Debug.Trace("[SLH]  Vaginal acts today: " + iVaginalCountToday)
	Debug.Trace("[SLH]  Anal acts today: " + iAnalCountToday)

	Debug.Trace("[SLH]  Daedric Influence: " + iDaedricInfluence)
	Debug.Trace("[SLH]  Succubus: " + iSuccubus)
	Debug.Trace("[SLH]  Bimbo: " + iBimbo)
	Debug.Trace("[SLH]  Sex Change: " + iHRT)
	Debug.Trace("[SLH]  TransGender: " + iTG)
	; Debug.Trace("[SLH]  HRT Phase: " + iSexStage)
	Debug.Trace("[SLH]  Pregnant: " + _isPregnantByBeeingFemale(PlayerActor))
	Debug.Trace("[SLH]  Chaurus Breeder: " + _isPregnantByEstrusChaurus(PlayerActor))

	Debug.Trace("[SLH]  Orgasms today: " + iOrgasmsCountToday + " - Total: " + iOrgasmsCountAll)

	Debug.Trace("[SLH]  Libido: " + SLH_Libido.GetValue())
	Debug.Trace("[SLH]  Weight: " + fWeight + " [ " + fWeightMin + " / " + fWeightMax + " ]")
	Debug.Trace("[SLH]  Breast: " + fBreast + " [ " + fBreastMin + " / " + fBreastMax + " ]")
	Debug.Trace("[SLH]  Belly: " + fBelly + " [ " + fBellyMin + " / " + fBellyMax + " ]")
	Debug.Trace("[SLH]  Butt: " + fButt + " [ " + fButtMin + " / " + fButtMax + " ]")
	Debug.Trace("[SLH]  Schlong: " + fSchlong + " [ " + fSchlongMin + " / " + fSchlongMax + " ]")

EndFunction

function _alterWeight(float fNewWeight = 0.0, float fWeightOrig = 0.0)		
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()

	Debug.Trace( "[SLH] _alterWeight Weight")
	Debug.Trace( "[SLH] Actorbase weight: " + pActorBase.GetWeight())
	Debug.Trace( "[SLH] New weight: " + fNewWeight)
	Debug.Trace( "[SLH] StorageUtil: " + StorageUtil.GetFloatValue(none, "_SLH_fWeight") )
	Debug.Trace( "[SLH] Global Value: " + GV_weightValue.GetValue() )

	Float fCurrentWeight = StorageUtil.GetFloatValue(none, "_SLH_fWeight") ; pActorBase.GetWeight()

	if (fNewWeight <= 1.0)
		Debug.Trace( "[SLH] Weight discrepency: " + pActorBase.GetWeight())
		; Debug.Notification( "[SLH] Weight discrepency: " + pActorBase.GetWeight())
	endif

	; pActorBase.SetWeight(fWeight)
	fWeight = fMin(fMax(fNewWeight, fWeightMin), fWeightMax)

	if (fWeightOrig != fNewWeight)
		Float NeckDelta = (fWeightOrig / 100) - (fWeight / 100) ;Work out the neckdelta.

		; Debug.Notification("[SLH] New weight: " + fNewWeight)
	 
		pActorBase.SetWeight(fNewWeight) ;Set Player's weight to a random float between 0.0 and 100.0.
		PlayerActor.UpdateWeight(NeckDelta) ;Apply the changes.
	EndIf
 
EndFunction

function _alterBreastNode(float fNewBreast = 0.0)				
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	Float fNodeMax


	; if bTorpedoFixEnabled
	; 	fPregLeftBreast01  = fPregLeftBreast01 * (fOrigLeftBreast / fPregLeftBreast)
	; 	fPregRightBreast01 = fPregRightBreast01 * (fOrigRightBreast / fPregRightBreast)
	; endIf

	; fPregLeftBreast = iMin(fPregLeftBreast, NINODE_MAX_SCALE)
	; fPregRightBreast = iMin(fPregRightBreast, NINODE_MAX_SCALE)

	; if bTorpedoFixEnabled
	; 	fPregLeftBreast01 = fMax(fPregLeftBreast01, NINODE_MIN_SCALE)
	; 	fPregRightBreast01 = fMax(fPregRightBreast01, NINODE_MIN_SCALE)
	; endif

	; Debug.Trace("[SLH]  Breast Old: " + fPregLeftBreast + " Min: " + NINODE_MIN_SCALE + " - Max: " + fBreastMax)

	if (_isExternalChangeModActive(PlayerActor))
		fNodeMax = fPregBreastMax
	Else
		fNodeMax = fBreastMax
	EndIf

	; fBreast = fMin(fMax(fBreast, NINODE_MIN_SCALE), fNodeMax)
	fBreast = fMin(fMax(fNewBreast, fBreastMin), fNodeMax)
	
	fPregLeftBreast    = fBreast
	fPregRightBreast   = fBreast

	; Debug.Trace("[SLH]  Breast New: " + fPregLeftBreast )

	NetImmerse.SetNodeScale( PlayerActor, NINODE_LEFT_BREAST, fPregLeftBreast, false)
	NetImmerse.SetNodeScale( PlayerActor, NINODE_RIGHT_BREAST, fPregRightBreast, false)
	; if bTorpedoFixEnabled
	;	NetImmerse.SetNodeScale( PlayerActor, NINODE_LEFT_BREAST01, fPregLeftBreast01, false)
	;	NetImmerse.SetNodeScale( PlayerActor, NINODE_RIGHT_BREAST01, fPregRightBreast01, false)
	; endIf

	NetImmerse.SetNodeScale( PlayerActor, NINODE_RIGHT_BREAST, fPregRightBreast, true)
	NetImmerse.SetNodeScale( PlayerActor, NINODE_LEFT_BREAST, fPregLeftBreast, true)
	; if bTorpedoFixEnabled
	;	NetImmerse.SetNodeScale( PlayerActor, NINODE_RIGHT_BREAST01, fPregRightBreast01, true)
	;	NetImmerse.SetNodeScale( PlayerActor, NINODE_LEFT_BREAST01, fPregLeftBreast01, true)
	; endIf
EndFunction

function _alterBellyNode(float fNewBelly = 0.0)				
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	Float fNodeMax


	if (_isExternalChangeModActive(PlayerActor))
		fNodeMax = fPregBellyMax
	Else
		fNodeMax = fBellyMax
	EndIf

	; fPregBelly = iMin(fPregBelly, NINODE_MAX_SCALE * 2.0)
	fBelly = fMin(fMax(fNewBelly, fBellyMin), fNodeMax)
	fPregBelly     = fBelly

	; kTarget.SetAnimationVariableFloat("ecBellySwell", fBellySwell)
	NetImmerse.SetNodeScale( PlayerActor, NINODE_BELLY, fPregBelly, false)
	NetImmerse.SetNodeScale( PlayerActor, NINODE_BELLY, fPregBelly, true)

	; Debug.Notification("SexLab Hormones: Set Belly scale: " + fPregBelly)
EndFunction

function _alterButtNode(float fNewButt = 0.0)	
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	Float fNodeMax
		
	if (_isExternalChangeModActive(PlayerActor))
		fNodeMax = fPregButtMax
	Else
		fNodeMax = fButtMax
	EndIf

	fButt = fMin(fMax(fNewButt, fButtMin), fNodeMax)

	fPregLeftButt = fButt
	fPregRightButt = fButt

	NetImmerse.SetNodeScale( PlayerActor, NINODE_LEFT_BUTT, fPregLeftButt, false)
	NetImmerse.SetNodeScale( PlayerActor, NINODE_RIGHT_BUTT, fPregRightButt, false)

	NetImmerse.SetNodeScale( PlayerActor, NINODE_LEFT_BUTT, fPregLeftButt, true)
	NetImmerse.SetNodeScale( PlayerActor, NINODE_RIGHT_BUTT, fPregRightButt, true)
EndFunction

function _alterSchlongNode(float fNewSchlong = 0.0)				
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
 
	; Debug.Notification("SexLab Hormones: Schlong Old: " + fSchlong + " Min: " + NINODE_MIN_SCALE + " - Max: " + fSchlongMax)
	fSchlong = fMin(fMax(fNewSchlong, fSchlongMin), fSchlongMax)
 	; Debug.Notification("SexLab Hormones: Schlong New: " + fSchlong )

	NetImmerse.SetNodeScale( PlayerActor, NINODE_SCHLONG, fSchlong, false)
	NetImmerse.SetNodeScale( PlayerActor, NINODE_SCHLONG, fSchlong, true)
EndFunction

Function _shaveHair ( )
 
	Int   iPlayerGender = kPlayer.GetLeveledActorBase().GetSex() as Int

	Int Hair = kPlayer.GetLeveledActorBase().GetNumHeadParts()
	Int i = 0
	While i < Hair
		If kPlayer.GetLeveledActorBase().GetNthHeadPart(i).GetType() == 3
			hpHairCurrent = kPlayer.GetLeveledActorBase().GetNthHeadPart(i)
			i = Hair
		EndIf
		i += 1
	EndWhile

	If (hpHairOrig == None)
		hpHairOrig = hpHairCurrent
	EndIf

	If (iPlayerGender==0) 
		If (hpHairCurrent != hpHairBaldM)
			kPlayer.ChangeHeadPart(hpHairBaldM)
			Debug.Messagebox("Your rapid body changes force your hair to fall.")
		Else
			; Game.ShowLimitedRaceMenu()
		EndIf

	Else
		If (hpHairCurrent != hpHairBaldF)
			kPlayer.ChangeHeadPart(hpHairBaldM)
			Debug.Notification("Your rapid body changes force your hair to fall.")
		Else
			; Game.ShowLimitedRaceMenu()
		EndIf

	EndIf

EndFunction

function _alterTintMask(int type = 6, int alpha = 0, int red = 125, int green = 90, int blue = 70, int setIndex = 0, Bool setAll = False)

	; Sets the tintMask color for the particular type and index
	; r,g,b,a: 0-255 range

	; Types
	; 0 - Frekles
	; 1 - Lips
	; 2 - Cheeks
	; 3 - Eyeliner
	; 4 - Upper Eyesocket
	; 5 - Lower Eyesocket
	; 6 - SkinTone
	; 7 - Warpaint
	; 8 - Frownlines
	; 9 - Lower Cheeks
	; 10 - Nose
	; 11 - Chin
	; 12 - Neck
	; 13 - Forehead
	; 14 - Dirt

	int color = Math.LeftShift(alpha, 24) + Math.LeftShift(red, 16) + Math.LeftShift(green, 8) + blue
	; int color = Math.LogicalOr(Math.LogicalAnd(rgb, 0xFFFFFF), Math.LeftShift((alpha * 255) as Int, 24))
 	int index_count = Game.GetNumTintsByType(type)

 	int index = 0
 	while(index < index_count)
 		if (index == setIndex) || (setAll)
 			Game.SetTintMaskColor(color, type, index)
 		EndIf
  		index = index + 1
 	EndWhile

EndFunction

function _setTintMask(int type = 6, int rgbacolor = 0, int setIndex = 0, Bool setAll = False)
 
	; Sets the tintMask color for the particular type and index
	; r,g,b,a: 0-255 range

	; Types
	; 0 - Frekles
	; 1 - Lips
	; 2 - Cheeks
	; 3 - Eyeliner
	; 4 - Upper Eyesocket
	; 5 - Lower Eyesocket
	; 6 - SkinTone
	; 7 - Warpaint
	; 8 - Frownlines
	; 9 - Lower Cheeks
	; 10 - Nose
	; 11 - Chin
	; 12 - Neck
	; 13 - Forehead
	; 14 - Dirt

	; int color = Math.LeftShift(alpha, 24) + Math.LeftShift(red, 16) + Math.LeftShift(green, 8) + blue
	; int color = Math.LogicalOr(Math.LogicalAnd(rgb, 0xFFFFFF), Math.LeftShift((alpha * 255) as Int, 24))
 	int index_count = Game.GetNumTintsByType(type)

 	int index = 0
 	while(index < index_count)
 		if (index == setIndex) || (setAll)
 			Game.SetTintMaskColor(rgbacolor, type, index)
 		EndIf
 		index = index + 1
 	EndWhile

EndFunction

Int function _alterHairColor(int rgbacolor, HeadPart thisHair)
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	ActorBase pLeveledActorBase = PlayerActor.GetLeveledActorBase()
	ColorForm thisHairColor 

	PlayerActor.ChangeHeadPart(thisHair)

	thisHairColor.SetColor(rgbacolor)
	pLeveledActorBase.SetHairColor(thisHairColor)

EndFunction

Int function _alterEyesColor(int rgbacolor, HeadPart thisEyes)
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()

	; Find out how to change eyes color

	PlayerActor.ChangeHeadPart(thisEyes)

EndFunction

Int function _alterHeight(float fHeight)
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()

	PlayerActor.SetScale(fHeight)
EndFunction

Int function _alterTintMaskRelativeRGB(int colorBase, int maskType = 6, int maskIndex = 0, int aOffset = 0, int rOffset = 0, int gOffset = 0, int bOffset = 0)
 	; int colorBase = Game.GetTintMaskColor(maskType, maskIndex)
	int aBase = Math.RightShift( colorBase, 24)
	int rBase = Math.LogicalAnd( Math.RightShift( colorBase, 16), 0x00FF) 
	int gBase = Math.LogicalAnd( Math.RightShift( colorBase, 8), 0x0000FF) 
	int bBase = Math.LogicalAnd( colorBase, 0x000000FF) 

	Debug.Trace( ":::: SexLab Hormones: Updating tint mask RGB - " +  maskType )
	Debug.Trace("[SLH]  Base RGB - " + aBase + " - " + rBase + " - " + gBase + " - " + bBase  )
	Debug.Trace("[SLH]  Offsets - " + aOffset + " - " + rOffset + " - " + gOffset + " - " + bOffset  )

	int aNew = iMin(iMax(aBase + aOffset, 0), 255)
	int rNew = iMin(iMax(rBase + rOffset, 0), 255)
	int gNew = iMin(iMax(gBase + gOffset, 0), 255)
	int bNew = iMin(iMax(bBase + bOffset, 0), 255)

	Debug.Trace("[SLH]  New color - " + aNew + " - " + rNew + " - " + gNew + " - " + bNew  )
    _alterTintMask(type = maskType, alpha = aNew, red = rNew, green = gNew, blue = bNew)

    int color = Math.LeftShift(aNew, 24) + Math.LeftShift(rNew, 16) + Math.LeftShift(gNew, 8) + bNew
    return color

EndFunction

Int function _alterTintMaskRelativeHSL(int colorOrig, int colorBase, int maskType = 6, int maskIndex = 0, int aOffset = 0, float hOffset = 0.0, float sOffset = 0.0, float lOffset = 0.0)

 	; int colorOrig = iOrigSkinColor
	int aOrig = Math.RightShift( colorOrig, 24)
	int rOrig = Math.LogicalAnd( Math.RightShift( colorOrig, 16), 0x00FF) 
	int gOrig = Math.LogicalAnd( Math.RightShift( colorOrig, 8), 0x0000FF) 
	int bOrig = Math.LogicalAnd( colorOrig, 0x000000FF) 

 	; int colorBase = Game.GetTintMaskColor(maskType, maskIndex)
	int aBase = Math.RightShift( colorBase, 24)
	int rBase = Math.LogicalAnd( Math.RightShift( colorBase, 16), 0x00FF) 
	int gBase = Math.LogicalAnd( Math.RightShift( colorBase, 8), 0x0000FF) 
	int bBase = Math.LogicalAnd( colorBase, 0x000000FF) 

	float[] hslBase  = new float[3]
	float[] hslNew  = new float[3]
	float[] hslOrig  = new float[3]
	int[] rgbNew  = new int[3]

	Debug.Trace( ":::: SexLab Hormones: Updating tint mask HSL - " +  maskType )
	; Debug.Trace("[SLH]  Orig RGB - " + aOrig + " - " + rOrig + " - " + gOrig + " - " + bOrig  )
	Debug.Trace("[SLH]  Base RGB - " + aBase + " - " + rBase + " - " + gBase + " - " + bBase  )
	Debug.Trace("[SLH]  Offsets - " + aOffset + " - " + hOffset + " - " + sOffset + " - " + lOffset  )

	hslOrig = _RGBtoHSL(rOrig, gOrig, bOrig)
	hslBase = _RGBtoHSL(rBase, gBase, bBase)

	; Debug.Trace("[SLH]  Orig HSL - " + hslOrig[0] + " - " + hslOrig[1] + " - " + hslOrig[2])
	; Debug.Trace("[SLH]  Base HSL - " + hslBase[0] + " - " + hslBase[1] + " - " + hslBase[2])

	hslNew[0] = fMin( fMax( hslBase[0] + hOffset, 0), 1.0)
	hslNew[1] = fMin( fMax( hslBase[1] + sOffset, 0), 1.0)
	hslNew[2] = fMin( fMax( hslBase[2] + lOffset, 0), 1.0)

	; Prevent skin from becoming too dark 
	hslNew[2] = fMin( fMax( hslNew[2], hslOrig[2]/2.0), 1.0)

	; Debug.Trace("[SLH]  HSL - " + hslNew[0] + " - " + hslNew[1] + " - " + hslNew[2]   )



	rgbNew = _HSLtoRGB(hslNew[0], hslNew[1], hslNew[2])

	; Debug.Trace("[SLH]  RGB - " + rgbNew[0] + " - " + rgbNew[1] + " - " + rgbNew[2]   )

	int aNew = iMin(iMax(aBase + aOffset, 0), 255)
	int rNew = iMin(iMax(rgbNew[0], 0), 255)
	int gNew = iMin(iMax(rgbNew[1], 0), 255)
	int bNew = iMin(iMax(rgbNew[2], 0), 255)

	Debug.Trace("[SLH]  New color - " + aNew + " - " + rNew + " - " + gNew + " - " + bNew  )
    _alterTintMask(type = maskType, alpha = aNew, red = rNew, green = gNew, blue = bNew)

    int color = Math.LeftShift(aNew, 24) + Math.LeftShift(rNew, 16) + Math.LeftShift(gNew, 8) + bNew
    return color
EndFunction


Int function _alterTintMaskTarget(int colorBase, int maskType = 6, int maskIndex = 0, int colorTarget, float colorMod = 0.5)
	int aOffset = 0
	int rOffset = 0
	int gOffset = 0
	int bOffset = 0

 	; int colorBase = Game.GetTintMaskColor(maskType, maskIndex)
	int aBase = Math.RightShift( colorBase, 24)
	int rBase = Math.LogicalAnd( Math.RightShift( colorBase, 16), 0x00FF) 
	int gBase = Math.LogicalAnd( Math.RightShift( colorBase, 8), 0x0000FF) 
	int bBase = Math.LogicalAnd( colorBase, 0x000000FF) 

	int aTarget = Math.RightShift( colorTarget, 24)
	int rTarget = Math.LogicalAnd( Math.RightShift( colorTarget, 16), 0x00FF) 
	int gTarget = Math.LogicalAnd( Math.RightShift( colorTarget, 8), 0x0000FF) 
	int bTarget = Math.LogicalAnd( colorTarget, 0x000000FF) 

	aOffset = -1 * ((( (aBase - aTarget) as Float) * colorMod) as Int)
	rOffset = -1 * ((( (rBase - rTarget) as Float) * colorMod) as Int)
	gOffset = -1 * ((( (gBase - gTarget) as Float) * colorMod) as Int)
	bOffset = -1 * ((( (bBase - bTarget) as Float) * colorMod) as Int)

	Debug.Trace( ":::: SexLab Hormones: Sync tint mask - " +  maskType )
	Debug.Trace("[SLH]  Orig color - " + aBase + " - " + rBase + " - " + gBase + " - " + bBase  )
	Debug.Trace("[SLH]  Target color - " + aTarget + " - " + rTarget + " - " + gTarget + " - " + bTarget  )
	Debug.Trace("[SLH]  Offsets - " + aOffset + " - " + rOffset + " - " + gOffset + " - " + bOffset  )
	Debug.Trace("[SLH]  ColorMod - " + colorMod )

	int aNew = iMin(iMax(aBase + aOffset, 0), 255)
	int rNew = iMin(iMax(rBase + rOffset, 0), 255)
	int gNew = iMin(iMax(gBase + gOffset, 0), 255)
	int bNew = iMin(iMax(bBase + bOffset, 0), 255)

	Debug.Trace("[SLH]  New color - " + aNew + " - " + rNew + " - " + gNew + " - " + bNew  )
    _alterTintMask(type = maskType, alpha = aNew, red = rNew, green = gNew, blue = bNew)

    int color = Math.LeftShift(aNew, 24) + Math.LeftShift(rNew, 16) + Math.LeftShift(gNew, 8) + bNew
    return color
EndFunction

; HSL to RGB conversion - see: http://stackoverflow.com/questions/2353211/hsl-to-rgb-color-conversion

int[] function _HSLtoRGB(float H, float S, float L)

    int[] rgb   = new int[3]

    if(S == 0.0) ; achromatic
        rgb[0] = (255.0 * L ) as Int	; r
        rgb[1] = (255.0 * L ) as Int	; g
        rgb[2] = (255.0 * L ) as Int	; b
    else
        float q 
        float p

        if (L < 0.5)
        	q = L * (1.0 + S) 
        Else
       		q = L + S - L * S
    	EndIf

        p = 2.0 * L - q

        rgb[0] = (255.0 * _hue2RGB(p, q, H + 1.0/3.0) ) as Int	; r
        rgb[1] = (255.0 * _hue2RGB(p, q, H) ) as Int			; g
        rgb[2] = (255.0 * _hue2RGB(p, q, H - 1.0/3.0) ) as Int	; b
    EndIf

    return rgb
EndFunction

float function _hue2RGB(float p, float q, float t)
    if (t < 0) 
    	t = t + 1.0
    EndIf
    if (t > 1.0) 
    	t = t - 1.0
    EndIf
    if (t < 1.0/6.0) 
    	return p + (q - p) * 6.0 * t
    EndIf
    if (t < 1.0/2.0) 
    	return q
    EndIf
 	if (t < 2.0/3.0) 
    	return p + (q - p) * (2.0/3.0 - t) * 6.0
    EndIf
    return p
EndFunction


float[] function _RGBtoHSL(int r, int g, int b)
    float fR = (r as float) / 255.0
    float fG = (g as float) / 255.0
    float fB = (b as float) / 255.0
    float[] hsl   = new float[3]
    float offset = 0.0

    float max = fMax( fMax(fR, fG), fB)
    float min = fMin( fMin(fR, fG), fB)

   	hsl[0] = (max + min) / 2.0 ; H
   	hsl[1] = (max + min) / 2.0 ; S
   	hsl[2] = (max + min) / 2.0 ; L

    if(max == min) ;  achromatic
        hsl[0] = 0.0
        hsl[1] = 0.0
    else
        float d = max - min

        if (hsl[2] > 0.5)
        	hsl[1] =  d / (2.0 - max - min) 
        Else
        	hsl[1] =  d / (max + min)
        endIf

        if ( max == fR)
        	if (fG < fB) 
        		offset = 6.0
        	EndIf
        	hsl[0] = (fG - fB) / d + offset
        elseIf ( max == fG)
            hsl[0] = (fB - fR) / d + 2.0
        else
            hsl[0] = (fR - fG) / d + 4.0
        EndIf
        hsl[0] = hsl[0] / 6.0;
    EndIf

    return hsl
EndFunction


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

String Function actorName(Actor _person)
	return _person.GetLeveledActorBase().GetName()
EndFunction

String Function _notify(String _text)
	; If config.bDebugMsg
		debug.Notification(_text)
	; EndIf
EndFunction

Function _castSpell(Actor[] _actors, Actor _skip, Spell _spell)
	int idx = 0
	
	While idx < _actors.Length
		if _actors[idx] && _actors[idx] != _skip
			_notify("Spell:" + _spell.GetName() + "->" + actorName(_actors[idx]))
			_spell.RemoteCast(_actors[idx], _actors[idx], _actors[idx])
		endif
		idx += 1
	EndWhile
EndFunction

Function _castSpell1st(Actor[] _actors, Spell _spell)
	int idx = 0
	
	if _actors.Length > 0
		if _actors[idx]
			_notify("Spell:" + _spell.GetName() + "->" + actorName(_actors[idx]))
			_spell.RemoteCast(_actors[idx], _actors[idx], _actors[idx])
		endif
	EndIf
EndFunction


Function _listActors(String _txt, Actor[] _actors)
	int idx = 0
	While idx < _actors.Length
		; Debug.Notification(_txt + actorName(_actors[idx]))
		idx += 1
	EndWhile
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

	; Debug.Trace("[Hormones] Race check:" + _actors.Length + " actors" )

	int idx = 0
	while idx < _actors.Length
		if (_actors[idx])
			; aBase = _actors[idx].GetBaseObject() as ActorBase
			aRace = _actors[idx].GetRace()

			; Debug.Trace("[Hormones] Race check:" + aRace + " / "  + thisRace)

			if aRace == thisRace
				return True
			endif
		EndIf
		idx += 1
	endwhile
	Return False
EndFunction

Function _doSoulDevour(Actor[] _actors)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor

	if _actors.Length < 2
		Return
	endif
	
	if !_hasPlayer(_actors)
		Return
	EndIf
	
	Debug.Notification("Your orgasm drains your partner's very essence.")
	Float Libido = SLH_Libido.GetValue() as float
	Float AbsLibido = Math.abs(Libido)
	
	Actor target
	Actor bandit
	int   idx
	int   ii
	float skillPercent
	float statValue

	; SexSkill - 2 + 18 (if grand master in all 3 skills) + 10 (if powerful succubus) -> Max is 70
	Float   sexSkill = fMin ( 2.0 + (SexLab.GetPlayerStatLevel("Oral") + SexLab.GetPlayerStatLevel("Anal") + SexLab.GetPlayerStatLevel("Vaginal")) + (AbsLibido / 10.0), 70.0 )

	idx = 0
	while idx < _actors.Length
		if _actors[idx] == PlayerREF
			bandit = _actors[idx]
		else 
			target = _actors[idx]
		endif
		idx += 1
	endwhile
	
	
	if (Libido<= -10.0)   ; absorb Sta
		skillPercent = fMin( (Utility.RandomFloat(5.0, 20.0) + sexSkill) / 100.0 , 1.0 )
		Debug.Trace("[Hormones] S%: " + skillPercent)
		
		statValue = target.GetActorValue("Stamina")
		statValue = math.Floor(statValue * skillPercent)
		bandit.RestoreActorValue("Stamina", statValue)
		Debug.Trace("[Hormones] Sta: " + statValue)
	endif

	if (Libido>= 10.0)  ; absorb Sta/Mag
		skillPercent = fMin( (Utility.RandomFloat(5.0, 20.0) + sexSkill) / 100.0 , 1.0 )
		Debug.Trace("[Hormones] M%: " + skillPercent)
		
		statValue = target.GetActorValue("Magicka")
		statValue = math.Floor(statValue * skillPercent)
		bandit.RestoreActorValue("Magicka", statValue)
		Debug.Trace("[Hormones] Mag: " + statValue)
	endif
	
	if (Libido<= -10.0)  ; absorb HP
		skillPercent = fMin( (Utility.RandomFloat(5.0, 20.0) + sexSkill) / 100.0 , 1.0 )
		Debug.Trace("[Hormones] HP%: " + skillPercent)
		
		statValue = target.GetActorValue("Health")
		statValue = math.Floor(statValue * skillPercent)
		bandit.RestoreActorValue("Health", statValue)
		Debug.Trace("[Hormones] HP: " + statValue)
	endif
	
	if (Libido>= 80.0)  ; skill boost
		int[] skillsDiff = new Int[18]
		int   lowCnt
		int   skillDiff
		
		lowCnt = 0
		idx = 0
		while idx < skillList.Length
			skillDiff = math.floor(target.GetBaseActorValue(skillList[idx]) - bandit.GetBaseActorValue(skillList[idx]))
			if skillDiff > 0
				skillsDiff[lowCnt] = idx
				Debug.Trace("[Hormones] Skill+:" + skillList[idx])
				lowCnt += 1
			endif
			idx += 1
		endWhile
		
		if lowCnt > 0
			idx = Utility.RandomInt(0, lowCnt - 1)
			if sexSkill > 0.0
				ii = 1 + ((sexSkill / 10.0) as Int )
			else
				ii = 1
			endif
			Game.IncrementSkillBy(skillList[idx], ii)
			Debug.Trace("[Hormones] Skill: " + skillList[idx])
		endif
		
		If (utility.RandomInt(0,100)>90)
			; Small chance of puppet spell cast automatically
			Debug.MessageBox("Your charm is overwhelming for your victim.")
			StorageUtil.SetIntValue(Game.GetPlayer(), "Puppet_CastTarget", 1)
			StorageUtil.SetFormValue(Game.GetPlayer(), "Puppet_NewTarget", bandit)

			If !(StorageUtil.HasIntValue(bandit, "_SD_iRelationshipType"))
				StorageUtil.SetIntValue(bandit, "_SD_iRelationshipType" , 5 )
			EndIf		
		EndIf
	endif

	if (Libido<= -80.0)   ; spell
		int spellCnt
		int spellGot
		ActorBase akBase = target.GetActorBase()
		
		spellCnt = akBase.GetSpellCount()
		spellGot = 0
		idx = 0
		while idx < spellCnt && spellGot < 1
			Spell spl = akBase.GetNthSpell(idx)
			
			if spl && spl.GetPerk() && !bandit.HasSpell(spl)
				bandit.AddSpell(spl, true)
				Debug.Trace("[Hormones] Spell:" + spl.GetName())
				spellGot += 1
			endif

			idx += 1
		endwhile
		
	endif
	
EndFunction

bool function _isFHUCumFilledEnabled(actor ActorRef)
  	; return (StorageUtil.GetIntValue(ActorRef, "SP_IsPregnant") != 0)
  	return (StorageUtil.GetIntValue(Game.GetPlayer(), "CI_CumInflation_ON") == 1) 

endFunction

bool function _isPregnantBySoulGemOven(actor ActorRef)
  	; return (StorageUtil.GetIntValue(ActorRef, "SP_IsPregnant") != 0)
  	return (StorageUtil.GetIntValue(Game.GetPlayer(), "sgo_IsBellyScaling") == 1) || (StorageUtil.GetIntValue(Game.GetPlayer(), "sgo_IsBreastScaling ") == 1)

endFunction

bool function _isPregnantBySimplePregnancy(actor ActorRef)
  	; return (StorageUtil.GetIntValue(ActorRef, "SP_IsPregnant") != 0)
  	return StorageUtil.HasFloatValue(ActorRef, "SP_Visual")

endFunction

bool function _isPregnantByBeeingFemale(actor ActorRef)
  if bBeeingFemale==true && BeeingFemalePregnancy != none
    return ActorRef.HasSpell(BeeingFemalePregnancy)
  endIf
  return false
endFunction
 
bool function _isPregnantByEstrusChaurus(actor ActorRef)
  if bEstrusChaurus==true && ChaurusBreeder != none
    return ActorRef.HasSpell(ChaurusBreeder)
  endIf
  return false
endFunction

bool function _isExternalChangeModActive(actor ActorRef)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor

	Return ( _isPregnantBySoulGemOven(PlayerActor) || _isPregnantBySimplePregnancy(PlayerActor) || _isPregnantByBeeingFemale(PlayerActor) || _isPregnantByEstrusChaurus(PlayerActor) || ((StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SuccubusON") == 1) && (StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SoulGemPregnancyON") == 1)) || (GV_changeOverrideToggle.GetValue() == 0) )
endFunction

function _manageSexLabAroused(int aiModRank = -1)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor

	Float Libido = SLH_Libido.GetValue() as float
	Float AbsLibido = Math.abs(Libido)
	
	If (Libido > 0)
		If (AbsLibido >= 50)
			slaUtil.SetActorExhibitionist(PlayerActor, True)
		Else
			slaUtil.SetActorExhibitionist(PlayerActor, False)
		EndIf

	    slaUtil.UpdateActorExposureRate(PlayerActor, AbsLibido / 10.0)
	EndIf

	if (StorageUtil.GetIntValue(Game.GetPlayer(), "_SLH_isPregnant") == 1)
		slaUtil.UpdateActorExposureRate(PlayerActor, 9.0)
	EndIf

	if ( StorageUtil.GetIntValue(Game.GetPlayer(), "_SLH_isDrugged") == 1)
		slaUtil.UpdateActorExposureRate(PlayerActor, 9.0)
	EndIf

endFunction

Function _LoadFaceValues(Actor _targetActor, int[] _presets = None, float[] _morphs = None)
	ActorBase targetBase = _targetActor.GetActorBase()
	int totalPresets = MAX_PRESETS
	int totalMorphs = MAX_MORPHS

	int i = 0
	While i < totalPresets
		targetBase.SetFacePreset(_presets[i], i)
		i += 1
	EndWhile
 
	i = 0
	While i < totalMorphs
		targetBase.SetFaceMorph(_morphs[i], i)
		i += 1
	EndWhile
EndFunction

Function _SaveFaceValues(Actor _targetActor, int[] _presets = None, float[] _morphs = None)
	ActorBase targetBase = _targetActor.GetActorBase()
	int totalPresets = MAX_PRESETS
	int totalMorphs = MAX_MORPHS

	int i = 0
	While i < totalPresets
		_presets[i] = targetBase.GetFacePreset(i)
		i += 1
	EndWhile
 
	i = 0
	While i < totalMorphs
		_morphs[i] = targetBase.GetFaceMorph(i)
		i += 1
	EndWhile
EndFunction

function _refreshBodyShape()
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	Race thisRace = pActorBase.GetRace()
	Bool bArmorOn = PlayerActor.WornHasKeyword(ArmorOn)
	Bool bClothingOn = PlayerActor.WornHasKeyword(ClothingOn)
	Float fApparelMod = 1.0

	If (bArmorOn)
		fApparelMod = GV_armorMod.GetValue() as Float
	ElseIf (bClothingOn)
		fApparelMod = GV_clothMod.GetValue() as Float
	EndIf

;	Debug.Notification("SexLab Hormones: Refreshing body shape values")
;	Debug.Notification(".")
	Debug.Trace("[SLH]  Refreshing body shape values")


	If (kOrigRace != None) 
		If (thisRace != kOrigRace)
			Debug.Trace("[SLH]  Race change detected - aborting")
			return
		EndIf
	EndIf

	; Refreshing values in case of any external change from other mods
	; _getShapeState() needs to be called separately

	if (GV_useWeight.GetValue() == 1)
		Debug.Trace( "[SLH] _refreshBodyShape Weight")
		Debug.Trace( "[SLH] Actorbase weight: " + pActorBase.GetWeight())
		Debug.Trace( "[SLH] Current weight: " + fWeight)
		Debug.Trace( "[SLH] StorageUtil: " + StorageUtil.GetFloatValue(none, "_SLH_fWeight") )

		Float fCurrentWeight = pActorBase.GetWeight()

		if (StorageUtil.GetFloatValue(none, "_SLH_fWeight") != pActorBase.GetWeight())
			Debug.Trace( "[SLH] Weight discrepency: " + pActorBase.GetWeight())
			; Debug.Notification( "[SLH] Weight discrepency: " + pActorBase.GetWeight())
		endif

		_alterWeight( fWeight, fCurrentWeight  )
	EndIf

	If (GV_useNodes.GetValue() == 1)
		; --------
		; BREAST SWELL ====================================================
		if ( bBreastEnabled )  && (GV_useBreastNode.GetValue() == 1)
			_alterBreastNode( fBreast * fApparelMod)				
		endif

		; BELLY SWELL =====================================================
		if ( bBellyEnabled )  && (GV_useBellyNode.GetValue() == 1) 
			_alterBellyNode(fBelly * fApparelMod )
		endif

		; BUTT SWELL ======================================================
		if ( bButtEnabled )   && (GV_useButtNode.GetValue() == 1)  
			_alterButtNode( fButt  * fApparelMod)
		endif

		; BUTT SWELL ======================================================
		if ( bSchlongEnabled )    && (GV_useSchlongNode.GetValue() == 1) 
			_alterSchlongNode( fSchlong )
		endif

	EndIf

	if (GV_useColors.GetValue() == 1)
		If (iSkinColor == 0)
			iSkinColor = Game.GetTintMaskColor(6,0)
		Else
			_setTintMask(6,iSkinColor)
		EndIf

		If (iCheeksColor == 0)
			iCheeksColor = Game.GetTintMaskColor(9,0)
		Else
			_setTintMask(9,iCheeksColor)
		EndIf

		If (iLipsColor == 0)
			iLipsColor = Game.GetTintMaskColor(1,0)
		Else
			_setTintMask(1,iLipsColor)
		EndIf

		If (iEyelinerColor  == 0)
			iEyelinerColor = Game.GetTintMaskColor(3,0)
		Else
			_setTintMask(3,iEyelinerColor)
		EndIf

	EndIf
endFunction

function _applyBodyShapeChanges()
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()

	Race thisRace = pActorBase.GetRace()

	; Debug.Notification("SexLab Hormones: Applying body changes")
	Debug.Trace("[SLH]  Applying body changes")

	Utility.Wait( 2.0 )

	if (!PlayerActor) || (PlayerActor == None)
		return
	endif

	; Wait until menu is closed
	while ( Utility.IsInMenuMode() )
		Utility.Wait( 2.0 )
	endWhile

	; 3d will not be loaded in some situations, such as werewolf transformations.
	; Skip body update if 3d not loaded or player is on mount or in combat

	If ( !PlayerActor.Is3DLoaded() || PlayerActor.IsOnMount() || (PlayerActor.GetActorValue("Variable01")!= 0) || PlayerActor.IsInCombat() || PlayerActor.IsWeaponDrawn() )
		return
	EndIf

	; Abort if race has changed (vampire lord or werewolf transformation)
	If (kOrigRace != None) 
		If (thisRace != kOrigRace)
			Debug.Trace("[SLH]  Race change detected - aborting")
			return
		EndIf
	EndIf

	if (GV_useColors.GetValue() == 1)
	 	If SKSE.GetPluginVersion("NiOverride") >= 1
	 		Debug.Trace("[SLH]  Applying NiOverride")
		 	NiOverride.ApplyOverrides(PlayerActor)
	 		NiOverride.ApplyNodeOverrides(PlayerActor)
	 	Endif

		; Game.UpdateHairColor()
		Debug.Trace("[SLH]  Updating TintMaskColors")
		Game.UpdateTintMaskColors()
	EndIf

 
	If ((GV_useNodes.GetValue() == 1) || (GV_useWeight.GetValue() == 1)) && (GV_enableNiNodeUpdate.GetValue() == 1)
		Debug.Trace("[SLH]  QueueNiNodeUpdate")
		Utility.Wait(2.0)
		PlayerActor.QueueNiNodeUpdate()
		Utility.Wait(2.0)
	Else
		Debug.Trace("[SLH]  QueueNiNodeUpdate aborted - " + GV_useNodes.GetValue() + " - " +GV_useWeight.GetValue() )
	EndIf
 

	Utility.Wait(1.0)
endFunction

function _initShapeConstants()
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	ActorBase pLeveledActorBase = PlayerActor.GetLeveledActorBase()

	; Modifiers for each part
	fWeightSwellMod = GV_weightSwellMod.GetValue()   ; 5.0   

	fBreastSwellMod = GV_breastSwellMod.GetValue()   ; 0.3 
	fBellySwellMod = GV_bellySwellMod.GetValue()   ; 0.1 
	fButtSwellMod = GV_buttSwellMod.GetValue()   ; 0.2 

	fBreastMax      = GV_breastMax.GetValue()   ; 4.0
	fBellyMax       = GV_bellyMax.GetValue()   ; 1.0
	fButtMax       	= GV_buttMax.GetValue()   ; 4.0

	bEnableLeftBreast  = NetImmerse.HasNode(PlayerActor, NINODE_LEFT_BREAST, false)
	bEnableRightBreast = NetImmerse.HasNode(PlayerActor, NINODE_RIGHT_BREAST, false)
	bEnableLeftButt    = NetImmerse.HasNode(PlayerActor, NINODE_LEFT_BUTT, false)
	bEnableRightButt   = NetImmerse.HasNode(PlayerActor, NINODE_RIGHT_BUTT, false)
	bEnableBelly       = NetImmerse.HasNode(PlayerActor, NINODE_BELLY, false)
	bEnableSchlong     = NetImmerse.HasNode(PlayerActor, NINODE_SCHLONG, false)

	bBreastEnabled     = ( bEnableLeftBreast && bEnableRightBreast as bool )
	bButtEnabled       = ( bEnableLeftButt && bEnableRightButt  as bool )
	bBellyEnabled      = ( bEnableBelly  as bool )
	bSchlongEnabled     = ( bEnableSchlong as bool )

	iHairColorSuccubus = Math.LeftShift(255, 24) + Math.LeftShift(0, 16) + Math.LeftShift(0, 8) + 0
	iHairColorBimbo = Math.LeftShift(255, 24) + Math.LeftShift(251, 16) + Math.LeftShift(198, 8) + 248

	; iHairColorOrig = pLeveledActorBase.GetHairColor()
	; pLeveledActorBase.SetHairColor(iHairColorSuccubus)

	iRedSkinColor = Math.LeftShift(128, 24) + Math.LeftShift(200, 16) + Math.LeftShift(0, 8) + 0
	iBlueSkinColor = Math.LeftShift(128, 24) + Math.LeftShift(50, 16) + Math.LeftShift(0, 8) + 255

	if (GV_redShiftColor.GetValue() == 0)
		GV_redShiftColor.SetValue( Math.LeftShift(200, 16) + Math.LeftShift(0, 8) + 0 )
	Else
		iRedSkinColor = Math.LeftShift(128, 24) + (GV_redShiftColor.GetValue() as Int)
	EndIf

	if (GV_blueShiftColor.GetValue() == 0)
		GV_blueShiftColor.SetValue( Math.LeftShift(50, 16) + Math.LeftShift(0, 8) + 255 )
	Else
		iBlueSkinColor =  Math.LeftShift(128, 24) + (GV_blueShiftColor.GetValue() as Int)
	EndIf

	iSuccubusRedSkinColor = iRedSkinColor
	iSuccubusBlueSkinColor = iBlueSkinColor


endFunction

 


function _initHormonesState()
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	ActorBase pLeveledActorBase = PlayerActor.GetLeveledActorBase()
	
	; Debug.Notification("SexLab Hormones: Initialization of body state")
	Debug.Trace("[SLH]  Initialization of body state")


	if ( bBreastEnabled && PlayerActor.GetLeveledActorBase().GetSex() == 1 )
		fOrigLeftBreast  = NetImmerse.GetNodeScale(PlayerActor, NINODE_LEFT_BREAST, false)
		fOrigRightBreast = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BREAST, false)
		fPregLeftBreast  = fOrigLeftBreast
		fPregRightBreast = fOrigRightBreast
		fBreast 		 = fOrigRightBreast
		if bTorpedoFixEnabled
			fOrigLeftBreast01  = NetImmerse.GetNodeScale(PlayerActor, NINODE_LEFT_BREAST01, false)
			fOrigRightBreast01 = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BREAST01, false)
			fPregLeftBreast01  = fOrigLeftBreast01
			fPregRightBreast01 = fOrigRightBreast01
		endif
	endif
	if ( bButtEnabled )
		fOrigLeftButt    = NetImmerse.GetNodeScale(PlayerActor, NINODE_LEFT_BUTT, false)
		fOrigRightButt   = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BUTT, false)
		fPregLeftButt    = fOrigLeftButt
		fPregRightButt   = fOrigRightButt
		fButt   		 = fOrigRightButt
	endif
	if ( bBellyEnabled )
		fOrigBelly       = NetImmerse.GetNodeScale(PlayerActor, NINODE_BELLY, false)
		fPregBelly       = fOrigBelly  
		fBelly       	 = fOrigBelly  
	endif		
	if ( bSchlongEnabled )
		fOrigSchlong       = NetImmerse.GetNodeScale(PlayerActor, NINODE_SCHLONG, false) 
		fSchlong       	 = fOrigSchlong  
	endif		

	iOrigSkinColor = Game.GetTintMaskColor(6,0)
	iSkinColor = iOrigSkinColor
	iOrigCheeksColor = Game.GetTintMaskColor(9,0)
	iCheeksColor = iOrigCheeksColor
	iOrigLipsColor = Game.GetTintMaskColor(1,0)
	iLipsColor = iOrigLipsColor
	iOrigEyelinerColor = Game.GetTintMaskColor(3,0)
	iEyelinerColor = iOrigEyelinerColor


	Int Eye = pLeveledActorBase.GetNumHeadParts()
	Int i = 0
	While i < Eye
		If pLeveledActorBase.GetNthHeadPart(i).GetType() == 2
			hpEyesOrig = pLeveledActorBase.GetNthHeadPart(i)
			i = Eye
		EndIf
		i += 1
	EndWhile
	; PlayerActor.ChangeHeadPart( hpEyes )

	Int Hair = pLeveledActorBase.GetNumHeadParts()
	i = 0
	While i < Hair
		If pLeveledActorBase.GetNthHeadPart(i).GetType() == 3
			hpHairOrig = pLeveledActorBase.GetNthHeadPart(i)
			i = Hair
		EndIf
		i += 1
	EndWhile
	; PlayerActor.ChangeHeadPart( hpHair )

	fWeight = pActorBase.GetWeight()
	fOrigWeight = fWeight

	fHeight = PlayerREF.GetScale()
	fOrigHeight = fHeight

	SLH_OrigWeight.SetValue(fOrigWeight)

	GV_breastValue.SetValue(fBreast)
	GV_buttValue.SetValue(fButt)
	GV_bellyValue.SetValue(fBelly)
	GV_schlongValue.SetValue(fSchlong)
	GV_weightValue.SetValue(fWeight)

	If (PlayerActor.GetLeveledActorBase().GetSex() == 1 ) && (GV_isHRT.GetValue() == 0)
		iSexStage = -2
	Else
		iSexStage = 2
	EndIf

	iOrgasmsCountToday   = 1
	iSexCountToday   = 1
	iOralCountToday   = 0
	iAnalCountToday   = 0
	iVaginalCountToday   = 0

	If (kOrigRace == None)
		kOrigRace = pActorBase.GetRace()
	EndIf

	SLH_Libido.SetValue( Utility.RandomInt(15,30))
	fLibido = SLH_Libido.GetValue() as Float
endFunction

function _setHormonesStateDefault()
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	ActorBase pLeveledActorBase = PlayerActor.GetLeveledActorBase()
	
	; Debug.Notification("SexLab Hormones: Initialization of body state")
	Debug.Trace("[SLH]  Reset of body state")


	if ( bBreastEnabled && PlayerActor.GetLeveledActorBase().GetSex() == 1 )
		fOrigLeftBreast  = NetImmerse.GetNodeScale(PlayerActor, NINODE_LEFT_BREAST, false)
		fOrigRightBreast = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BREAST, false)
		fPregLeftBreast  = fOrigLeftBreast
		fPregRightBreast = fOrigRightBreast
		fBreast 		 = fOrigRightBreast
		if bTorpedoFixEnabled
			fOrigLeftBreast01  = NetImmerse.GetNodeScale(PlayerActor, NINODE_LEFT_BREAST01, false)
			fOrigRightBreast01 = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BREAST01, false)
			fPregLeftBreast01  = fOrigLeftBreast01
			fPregRightBreast01 = fOrigRightBreast01
		endif
	endif
	if ( bButtEnabled )
		fOrigLeftButt    = NetImmerse.GetNodeScale(PlayerActor, NINODE_LEFT_BUTT, false)
		fOrigRightButt   = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BUTT, false)
		fPregLeftButt    = fOrigLeftButt
		fPregRightButt   = fOrigRightButt
		fButt   		 = fOrigRightButt
	endif
	if ( bBellyEnabled )
		fOrigBelly       = NetImmerse.GetNodeScale(PlayerActor, NINODE_BELLY, false)
		fPregBelly       = fOrigBelly  
		fBelly       	 = fOrigBelly  
	endif		
	if ( bSchlongEnabled )
		fOrigSchlong       = NetImmerse.GetNodeScale(PlayerActor, NINODE_SCHLONG, false) 
		fSchlong       	 = fOrigSchlong  
	endif		

	iOrigSkinColor = Game.GetTintMaskColor(6,0)
	iSkinColor = iOrigSkinColor
	iOrigCheeksColor = Game.GetTintMaskColor(9,0)
	iCheeksColor = iOrigCheeksColor
	iOrigLipsColor = Game.GetTintMaskColor(1,0)
	iLipsColor = iOrigLipsColor
	iOrigEyelinerColor = Game.GetTintMaskColor(3,0)
	iEyelinerColor = iOrigEyelinerColor


	Int Eye = pLeveledActorBase.GetNumHeadParts()
	Int i = 0
	While i < Eye
		If pLeveledActorBase.GetNthHeadPart(i).GetType() == 2
			hpEyesOrig = pLeveledActorBase.GetNthHeadPart(i)
			i = Eye
		EndIf
		i += 1
	EndWhile
	; PlayerActor.ChangeHeadPart( hpEyes )

	Int Hair = pLeveledActorBase.GetNumHeadParts()
	i = 0
	While i < Hair
		If pLeveledActorBase.GetNthHeadPart(i).GetType() == 3
			hpHairOrig = pLeveledActorBase.GetNthHeadPart(i)
			i = Hair
		EndIf
		i += 1
	EndWhile
	; PlayerActor.ChangeHeadPart( hpHair )

	fWeight = pActorBase.GetWeight()
	fOrigWeight = fWeight

	fHeight = PlayerREF.GetScale()
	fOrigHeight = fHeight

	SLH_OrigWeight.SetValue(fOrigWeight)

	GV_breastValue.SetValue(fBreast)
	GV_buttValue.SetValue(fButt)
	GV_bellyValue.SetValue(fBelly)
	GV_schlongValue.SetValue(fSchlong)
	GV_weightValue.SetValue(fWeight)

	If (PlayerActor.GetLeveledActorBase().GetSex() == 1 ) && (GV_isHRT.GetValue() == 0)
		iSexStage = -2
	Else
		iSexStage = 2
	EndIf

	; iOrgasmsCountToday   = 1
	; iSexCountToday   = 1
	; iOralCountToday   = 0
	; iAnalCountToday   = 0
	; iVaginalCountToday   = 0

	kOrigRace = pActorBase.GetRace()

	SLH_Libido.SetValue( Utility.RandomInt(15,30))
	fLibido = SLH_Libido.GetValue() as Float

	_alterBodyAfterRest()
	_setHormonesState()	

	If !( _isExternalChangeModActive(PlayerActor) ) && (NextAllowed!= -1)
		_applyBodyShapeChanges()
	EndIf

endFunction

function _resetHormonesState()
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
	ActorBase pLeveledActorBase = PlayerActor.GetLeveledActorBase()
	
	; Debug.Notification("SexLab Hormones: Initialization of body state")
	Debug.Trace("[SLH]  Reset of body state")


	if ( bBreastEnabled && PlayerActor.GetLeveledActorBase().GetSex() == 1 )
		; fOrigLeftBreast  = NetImmerse.GetNodeScale(PlayerActor, NINODE_LEFT_BREAST, false)
		; fOrigRightBreast = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BREAST, false)
		fPregLeftBreast  = fOrigLeftBreast
		fPregRightBreast = fOrigRightBreast
		fBreast 		 = fOrigRightBreast
		if bTorpedoFixEnabled
			; fOrigLeftBreast01  = NetImmerse.GetNodeScale(PlayerActor, NINODE_LEFT_BREAST01, false)
			; fOrigRightBreast01 = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BREAST01, false)
			fPregLeftBreast01  = fOrigLeftBreast01
			fPregRightBreast01 = fOrigRightBreast01
		endif
	endif
	if ( bButtEnabled )
		; fOrigLeftButt    = NetImmerse.GetNodeScale(PlayerActor, NINODE_LEFT_BUTT, false)
		; fOrigRightButt   = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BUTT, false)
		fPregLeftButt    = fOrigLeftButt
		fPregRightButt   = fOrigRightButt
		fButt   		 = fOrigRightButt
	endif
	if ( bBellyEnabled )
		; fOrigBelly       = NetImmerse.GetNodeScale(PlayerActor, NINODE_BELLY, false)
		; fPregBelly       = fOrigBelly  
		fBelly       	 = fOrigBelly  
	endif		
	if ( bSchlongEnabled )
		; fOrigSchlong       = NetImmerse.GetNodeScale(PlayerActor, NINODE_SCHLONG, false) 
		fSchlong       	 = fOrigSchlong  
	endif		

	; iOrigSkinColor = Game.GetTintMaskColor(6,0)
	iSkinColor = iOrigSkinColor
	; iOrigCheeksColor = Game.GetTintMaskColor(9,0)
	iCheeksColor = iOrigCheeksColor
	; iOrigLipsColor = Game.GetTintMaskColor(1,0)
	iLipsColor = iOrigLipsColor
	; iOrigEyelinerColor = Game.GetTintMaskColor(3,0)
	iEyelinerColor = iOrigEyelinerColor


	fWeight = fOrigWeight
	pActorBase.SetWeight(fWeight) 

	fHeight = fOrigHeight
	PlayerREF.SetScale(fHeight)

	; SLH_OrigWeight.SetValue(fOrigWeight)

	GV_breastValue.SetValue(fBreast)
	GV_buttValue.SetValue(fButt)
	GV_bellyValue.SetValue(fBelly)
	GV_schlongValue.SetValue(fSchlong)
	GV_weightValue.SetValue(fWeight)

	If (PlayerActor.GetLeveledActorBase().GetSex() == 1 ) && (GV_isHRT.GetValue() == 0)
		iSexStage = -2
	Else
		iSexStage = 2
	EndIf

	; iOrgasmsCountToday   = 1
	; iSexCountToday   = 1
	; iOralCountToday   = 0
	; iAnalCountToday   = 0
	; iVaginalCountToday   = 0

	; kOrigRace = pActorBase.GetRace()

	SLH_Libido.SetValue( Utility.RandomInt(15,30))
	fLibido = SLH_Libido.GetValue() as Float

	_alterBodyAfterRest()
	_setHormonesState()	

	If !( _isExternalChangeModActive(PlayerActor) ) && (NextAllowed!= -1)
		_applyBodyShapeChanges()
	EndIf

endFunction

function _setBimboState(Bool bBimboState)
	iBimbo = bBimboState as Int
	GV_isBimbo.SetValue(iBimbo as Int)
	StorageUtil.SetIntValue(none, "_SLH_iBimbo", iBimbo as Int)
endFunction

function _setTGState(Bool bTGState)
	iTG = bTGState as Int
	GV_isTG.SetValue(iTG as Int)
	StorageUtil.SetIntValue(none, "_SLH_iTG", iTG as Int)
endFunction

function _setHRTState(Bool bHRTState)
	iHRT = bHRTState as Int
	GV_isHRT.SetValue(iHRT as Int)
	StorageUtil.SetIntValue(none, "_SLH_iHRT", iHRT as Int)
endFunction

function _setSuccubusState(Bool bSuccubusState)
	iSuccubus = bSuccubusState as Int
	GV_isSuccubus.SetValue(iSuccubus as Int)
	StorageUtil.SetIntValue(none, "_SLH_iSuccubus", iSuccubus as Int)
endFunction

function _setHormonesState()
	; Debug.Notification("SexLab Hormones: Writing state to storage")
	Debug.Trace("[SLH]  Writing state to storage")

	If (!StorageUtil.HasIntValue(none, "_SLH_iHormones"))
		StorageUtil.SetIntValue(none, "_SLH_iHormones", 1)
	EndIf

; StorageUtil.SetIntValue(none, "myGlobalVariable", 5) ; enter none as first argument to set global variable
; StorageUtil.SetIntValue(Game.GetPlayer(), "myVariable", 25) ; set "myVariable" to 25 on player
; StorageUtil.SetFloatValue(akTarget, "myVariable", 75.3) ; set "myVariable" to 75.3 on akTarget
; StorageUtil.SetStringValue(none, "myGlobalVariable", "hello") ; enter none as first argument to set global variable

	StorageUtil.SetIntValue(none, "_SLH_iGameDateLastSex", iGameDateLastSex) 
	StorageUtil.SetIntValue(none, "_SLH_iDaysSinceLastSex", iDaysSinceLastSex)
	StorageUtil.SetIntValue(none, "_SLH_iDaysSinceLastCheck", iDaysSinceLastCheck)

	StorageUtil.SetIntValue(none, "_SLH_iOrigSkinColor", iOrigSkinColor) 
	StorageUtil.SetIntValue(none, "_SLH_iOrigCheeksColor", iOrigCheeksColor) 
	StorageUtil.SetIntValue(none, "_SLH_iOrigLipsColor", iOrigLipsColor) 
	StorageUtil.SetIntValue(none, "_SLH_iOrigEyelinerColor", iOrigEyelinerColor) 
	StorageUtil.SetIntValue(none, "_SLH_iOrigEyesColor", iOrigEyesColor) 
	StorageUtil.SetIntValue(none, "_SLH_iOrigHairColor", iOrigHairColor) 

	StorageUtil.SetFloatValue(none, "_SLH_fOrigWeight", fOrigWeight) 
	StorageUtil.SetFloatValue(none, "_SLH_fOrigHeight", fOrigHeight) 
	StorageUtil.SetFloatValue(none, "_SLH_fOrigLeftBreast",  fOrigLeftBreast) 
	StorageUtil.SetFloatValue(none, "_SLH_fOrigLeftBreast01",  fOrigLeftBreast01) 
	StorageUtil.SetFloatValue(none, "_SLH_fOrigRightBreast",  fOrigRightBreast) 
	StorageUtil.SetFloatValue(none, "_SLH_fOrigRightBreast01",  fOrigRightBreast01) 
	StorageUtil.SetFloatValue(none, "_SLH_fOrigLeftButt",  fOrigLeftButt) 
	StorageUtil.SetFloatValue(none, "_SLH_fOrigRightButt",  fOrigRightButt) 
	StorageUtil.SetFloatValue(none, "_SLH_fOrigBelly",  fOrigBelly) 
	StorageUtil.SetFloatValue(none, "_SLH_fOrigSchlong",  fOrigSchlong) 

	fLibido = SLH_Libido.GetValue() as Float
	StorageUtil.SetFloatValue(none, "_SLH_fLibido",  fLibido) 

	StorageUtil.SetIntValue(none, "_SLH_iSkinColor", iSkinColor) 
	StorageUtil.SetIntValue(none, "_SLH_iCheeksColor", iCheeksColor) 
	StorageUtil.SetIntValue(none, "_SLH_iLipsColor", iLipsColor) 
	StorageUtil.SetIntValue(none, "_SLH_iEyelinerColor", iEyelinerColor) 
	StorageUtil.SetIntValue(none, "_SLH_iEyesColor", iEyesColor) 
	StorageUtil.SetIntValue(none, "_SLH_iHairColor", iHairColor) 

	StorageUtil.SetFloatValue(none, "_SLH_fPregLeftBreast",  fPregLeftBreast) 
	StorageUtil.SetFloatValue(none, "_SLH_fPregLeftBreast01",  fPregLeftBreast01) 
	StorageUtil.SetFloatValue(none, "_SLH_fPregRightBreast",  fPregRightBreast) 
	StorageUtil.SetFloatValue(none, "_SLH_fPregRightBreast01",  fPregRightBreast01) 
	StorageUtil.SetFloatValue(none, "_SLH_fPregLeftButt",  fPregLeftButt) 
	StorageUtil.SetFloatValue(none, "_SLH_fPregRightButt",  fPregRightButt) 
	StorageUtil.SetFloatValue(none, "_SLH_fPregBelly",  fPregBelly) 
	StorageUtil.SetFloatValue(none, "_SLH_fBreast",  fBreast) 
	StorageUtil.SetFloatValue(none, "_SLH_fButt",  fButt) 
	StorageUtil.SetFloatValue(none, "_SLH_fBelly",  fBelly) 
	StorageUtil.SetFloatValue(none, "_SLH_fSchlong",  fSchlong) 
	StorageUtil.SetFloatValue(none, "_SLH_fWeight",  fWeight) 
	StorageUtil.SetFloatValue(none, "_SLH_fHeight",  fHeight) 

	StorageUtil.SetIntValue(none, "_SLH_iOrgasmsCountToday", iOrgasmsCountToday) 
	StorageUtil.SetIntValue(none, "_SLH_iOrgasmsCountAll", iOrgasmsCountAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexCountToday", iSexCountToday) 
	StorageUtil.SetIntValue(none, "_SLH_iSexCountAll", iSexCountAll) 
	StorageUtil.SetIntValue(none, "_SLH_iOralCountToday", iOralCountToday) 
	StorageUtil.SetIntValue(none, "_SLH_iAnalCountToday", iAnalCountToday) 
	StorageUtil.SetIntValue(none, "_SLH_iVaginalCountToday", iVaginalCountToday) 

	StorageUtil.SetIntValue(none, "_SLH_iBimbo", iBimbo) 
	StorageUtil.SetIntValue(none, "_SLH_iHRT", iHRT) 
	StorageUtil.SetIntValue(none, "_SLH_iTG", iTG) 
	StorageUtil.SetIntValue(none, "_SLH_iSuccubus", iSuccubus) 
	StorageUtil.SetIntValue(none, "_SLH_iDaedricInfluence",  iDaedricInfluence) 
	StorageUtil.SetIntValue(none, "_SLH_iSexStage",  iSexStage) 

	StorageUtil.SetIntValue(none, "_SLH_iSexCreaturesAll", iSexCreaturesAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexDogAll", iSexDogAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexWolfAll", iSexWolfAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexWerewolfAll", iSexWerewolfAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexManAll", iSexManAll)
	StorageUtil.SetIntValue(none, "_SLH_iSexMerAll", iSexMerAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexTrollAll", iSexTrollAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexBugAll", iSexBugAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexGiantAll", iSexGiantAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexFalmerAll", iSexFalmerAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexHorseAll", iSexHorseAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexBearAll", iSexBearAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexCatAll", iSexCatAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexGargoyleAll", iSexGargoyleAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexVampireLordAll", iSexVampireLordAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexDragonAll", iSexDragonAll) 
	StorageUtil.SetIntValue(none, "_SLH_iSexDaedraAll", iSexDaedraAll) 

	GV_isBimbo.SetValue(iBimbo)
	GV_isHRT.SetValue(iHRT)
	GV_isTG.SetValue(iTG)
	GV_isSuccubus.SetValue(iSuccubus)

	GV_breastValue.SetValue(fBreast)
	GV_buttValue.SetValue(fButt)
	GV_bellyValue.SetValue(fBelly)
	GV_schlongValue.SetValue(fSchlong)
	GV_weightValue.SetValue(fWeight)

	if 	( _isPregnantBySoulGemOven(Game.GetPlayer()) || _isPregnantBySimplePregnancy(Game.GetPlayer()) || _isPregnantByBeeingFemale(Game.GetPlayer()) || _isPregnantByEstrusChaurus(Game.GetPlayer()) || ((StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SuccubusON") == 1) && (StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SoulGemPregnancyON") == 1)) )
		StorageUtil.SetIntValue(Game.GetPlayer(), "_SLH_isPregnant", 1)
	Else
		StorageUtil.SetIntValue(Game.GetPlayer(), "_SLH_isPregnant", 0)
	EndIf

	if 	(GV_isSuccubus.GetValue() == 1) || ((StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SuccubusON") == 1))
		StorageUtil.SetIntValue(Game.GetPlayer(), "_SLH_isSuccubus", 1)
	Else
		StorageUtil.SetIntValue(Game.GetPlayer(), "_SLH_isSuccubus", 0)
	EndIf	
endFunction

function _setShapeState()
	; Debug.Notification("SexLab Hormones: Writing state to storage")
	Debug.Trace("[SLH]  Writing shape state to storage")

; StorageUtil.SetIntValue(none, "myGlobalVariable", 5) ; enter none as first argument to set global variable
; StorageUtil.SetIntValue(Game.GetPlayer(), "myVariable", 25) ; set "myVariable" to 25 on player
; StorageUtil.SetFloatValue(akTarget, "myVariable", 75.3) ; set "myVariable" to 75.3 on akTarget
; StorageUtil.SetStringValue(none, "myGlobalVariable", "hello") ; enter none as first argument to set global variable

	fLibido = SLH_Libido.GetValue() as Float
	StorageUtil.SetFloatValue(none, "_SLH_fLibido",  fLibido) 

	StorageUtil.SetIntValue(none, "_SLH_iSkinColor", iSkinColor) 
	StorageUtil.SetIntValue(none, "_SLH_iCheeksColor", iCheeksColor) 
	StorageUtil.SetIntValue(none, "_SLH_iLipsColor", iLipsColor) 
	StorageUtil.SetIntValue(none, "_SLH_iEyelinerColor", iEyelinerColor) 
	StorageUtil.SetIntValue(none, "_SLH_iEyesColor", iEyesColor) 
	StorageUtil.SetIntValue(none, "_SLH_iHairColor", iHairColor) 

	StorageUtil.SetFloatValue(none, "_SLH_fPregLeftBreast",  fPregLeftBreast) 
	StorageUtil.SetFloatValue(none, "_SLH_fPregLeftBreast01",  fPregLeftBreast01) 
	StorageUtil.SetFloatValue(none, "_SLH_fPregRightBreast",  fPregRightBreast) 
	StorageUtil.SetFloatValue(none, "_SLH_fPregRightBreast01",  fPregRightBreast01) 
	StorageUtil.SetFloatValue(none, "_SLH_fPregLeftButt",  fPregLeftButt) 
	StorageUtil.SetFloatValue(none, "_SLH_fPregRightButt",  fPregRightButt) 
	StorageUtil.SetFloatValue(none, "_SLH_fPregBelly",  fPregBelly) 

	StorageUtil.SetFloatValue(none, "_SLH_fBreast",  fBreast) 
	StorageUtil.SetFloatValue(none, "_SLH_fButt",  fButt) 
	StorageUtil.SetFloatValue(none, "_SLH_fBelly",  fBelly) 
	StorageUtil.SetFloatValue(none, "_SLH_fSchlong",  fSchlong) 
	StorageUtil.SetFloatValue(none, "_SLH_fWeight",  fWeight) 
	StorageUtil.SetFloatValue(none, "_SLH_fHeight",  fHeight) 

	GV_breastValue.SetValue(fBreast)
	GV_buttValue.SetValue(fButt)
	GV_bellyValue.SetValue(fBelly)
	GV_schlongValue.SetValue(fSchlong)
	GV_weightValue.SetValue(fWeight)


endFunction


function _getHormonesState()
	; Debug.Notification("SexLab Hormones: Reading state from storage")
	Debug.Trace("[SLH]  Reading state from storage")

; int value = StorageUtil.GetIntValue(none, "myGlobalVariable") ; get the previously saved global variable
; value = StorageUtil.GetIntValue(Game.GetPlayer(), "myVariable") ; get value of myVariable from player
; float fvalue = StorageUtil.GetFloatValue(akTarget, "myVariable") ; get float value from akTarget
; string svalue = StorageUtil.GetStringValue(none, "myGlobalVariable") ; get "hello"

	iGameDateLastSex = StorageUtil.GetIntValue(none, "_SLH_iGameDateLastSex") 
	iDaysSinceLastSex = StorageUtil.GetIntValue(none, "_SLH_iDaysSinceLastSex")
	iDaysSinceLastCheck = StorageUtil.GetIntValue(none, "_SLH_iDaysSinceLastCheck" )


	iOrigSkinColor = StorageUtil.GetIntValue(none, "_SLH_iOrigSkinColor") 
	iOrigCheeksColor = StorageUtil.GetIntValue(none, "_SLH_iOrigCheeksColor") 
	iOrigLipsColor = StorageUtil.GetIntValue(none, "_SLH_iOrigLipsColor") 
	iOrigEyelinerColor = StorageUtil.GetIntValue(none, "_SLH_iOrigEyelinerColor") 
	iOrigEyesColor = StorageUtil.GetIntValue(none, "_SLH_iOrigEyesColor") 
	iOrigHairColor = StorageUtil.GetIntValue(none, "_SLH_iOrigHairColor") 

	fOrigWeight = StorageUtil.GetFloatValue(none, "_SLH_fOrigWeight") 
	fOrigHeight = StorageUtil.GetFloatValue(none, "_SLH_fOrigHeight") 
	fOrigLeftBreast = StorageUtil.GetFloatValue(none, "_SLH_fOrigLeftBreast") 
	fOrigLeftBreast01 = StorageUtil.GetFloatValue(none, "_SLH_fOrigLeftBreast01") 
	fOrigRightBreast = StorageUtil.GetFloatValue(none, "_SLH_fOrigRightBreast") 
	fOrigRightBreast01 = StorageUtil.GetFloatValue(none, "_SLH_fOrigRightBreast01") 
	fOrigLeftButt = StorageUtil.GetFloatValue(none, "_SLH_fOrigLeftButt") 
	fOrigRightButt = StorageUtil.GetFloatValue(none, "_SLH_fOrigRightButt") 
	fOrigBelly = StorageUtil.GetFloatValue(none, "_SLH_fOrigBelly") 
	fOrigSchlong = StorageUtil.GetFloatValue(none, "_SLH_fOrigSchlong") 

	fLibido = StorageUtil.GetFloatValue(none, "_SLH_fLibido") 

	iSkinColor = StorageUtil.GetIntValue(none, "_SLH_iSkinColor") 
	iCheeksColor = StorageUtil.GetIntValue(none, "_SLH_iCheeksColor") 
	iLipsColor = StorageUtil.GetIntValue(none, "_SLH_iLipsColor") 
	iEyelinerColor = StorageUtil.GetIntValue(none, "_SLH_iEyelinerColor") 
	iEyesColor = StorageUtil.GetIntValue(none, "_SLH_iEyesColor") 
	iHairColor = StorageUtil.GetIntValue(none, "_SLH_iHairColor") 

	fPregLeftBreast = StorageUtil.GetFloatValue(none, "_SLH_fPregLeftBreast") 
	fPregLeftBreast01 = StorageUtil.GetFloatValue(none, "_SLH_fPregLeftBreast01") 
	fPregRightBreast = StorageUtil.GetFloatValue(none, "_SLH_fPregRightBreast") 
	fPregRightBreast01 = StorageUtil.GetFloatValue(none, "_SLH_fPregRightBreast01") 
	fPregLeftButt = StorageUtil.GetFloatValue(none, "_SLH_fPregLeftButt") 
	fPregRightButt = StorageUtil.GetFloatValue(none, "_SLH_fPregRightButt") 
	fPregBelly = StorageUtil.GetFloatValue(none, "_SLH_fPregBelly") 
	fBreast = StorageUtil.GetFloatValue(none, "_SLH_fBreast") 
	fButt = StorageUtil.GetFloatValue(none, "_SLH_fButt") 
	fBelly = StorageUtil.GetFloatValue(none, "_SLH_fBelly") 
	fSchlong = StorageUtil.GetFloatValue(none, "_SLH_fSchlong") 
	fWeight = StorageUtil.GetFloatValue(none, "_SLH_fWeight") 
	fHeight = StorageUtil.GetFloatValue(none, "_SLH_fHeight") 


	iOrgasmsCountToday = StorageUtil.GetIntValue(none, "_SLH_iOrgasmsCountToday") 
	iOrgasmsCountAll = StorageUtil.GetIntValue(none, "_SLH_iOrgasmsCountAll") 
	iSexCountToday = StorageUtil.GetIntValue(none, "_SLH_iSexCountToday") 
	iSexCountAll = StorageUtil.GetIntValue(none, "_SLH_iSexCountAll") 
 	iOralCountToday = StorageUtil.GetIntValue(none, "_SLH_iOralCountToday") 
	iAnalCountToday = StorageUtil.GetIntValue(none, "_SLH_iAnalCountToday") 
	iVaginalCountToday = StorageUtil.GetIntValue(none, "_SLH_iVaginalCountToday") 

	iTG = StorageUtil.GetIntValue(none, "_SLH_iTG") 
	iHRT = StorageUtil.GetIntValue(none, "_SLH_iHRT") 
	iBimbo = StorageUtil.GetIntValue(none, "_SLH_iBimbo") 
	iSuccubus = StorageUtil.GetIntValue(none, "_SLH_iSuccubus") 
	iDaedricInfluence = StorageUtil.GetIntValue(none, "_SLH_iDaedricInfluence") 
	iSexStage = StorageUtil.GetIntValue(none, "_SLH_iSexStage") 

	iSexCreaturesAll = StorageUtil.GetIntValue(none, "_SLH_iSexCreaturesAll") 
	iSexDogAll = StorageUtil.GetIntValue(none, "_SLH_iSexDogAll") 
	iSexWolfAll = StorageUtil.GetIntValue(none, "_SLH_iSexWolfAll") 
	iSexWerewolfAll = StorageUtil.GetIntValue(none, "_SLH_iSexWerewolfAll") 
	iSexManAll = StorageUtil.GetIntValue(none, "_SLH_iSexManAll")
	iSexMerAll = StorageUtil.GetIntValue(none, "_SLH_iSexMerAll") 
	iSexTrollAll = StorageUtil.GetIntValue(none, "_SLH_iSexTrollAll") 
	iSexBugAll = StorageUtil.GetIntValue(none, "_SLH_iSexBugAll") 
	iSexGiantAll = StorageUtil.GetIntValue(none, "_SLH_iSexGiantAll") 
	iSexFalmerAll = StorageUtil.GetIntValue(none, "_SLH_iSexFalmerAll") 
	iSexHorseAll = StorageUtil.GetIntValue(none, "_SLH_iSexHorseAll") 
	iSexBearAll = StorageUtil.GetIntValue(none, "_SLH_iSexBearAll") 
	iSexCatAll = StorageUtil.GetIntValue(none, "_SLH_iSexCatAll") 
	iSexGargoyleAll = StorageUtil.GetIntValue(none, "_SLH_iSexGargoyleAll") 
	iSexVampireLordAll = StorageUtil.GetIntValue(none, "_SLH_iSexVampireLordAll") 
	iSexDragonAll = StorageUtil.GetIntValue(none, "_SLH_iSexDragonAll") 
	iSexDaedraAll = StorageUtil.GetIntValue(none, "_SLH_iSexDaedraAll") 

	GV_isBimbo.SetValue(iBimbo)
	GV_isTG.SetValue(iTG)
	GV_isHRT.SetValue(iHRT)
	GV_isSuccubus.SetValue(iSuccubus)

	; fBreast = fMin(fMax(fBreast, fBreastMin), fBreastMax)
	; fButt = fMin(fMax(fButt, fButtMin), fButtMax)
	; fBelly = fMin(fMax(fBelly, fBellyMin), fBellyMax)
	; fSchlong = fMin(fMax(fSchlong, fSchlongMin), fSchlongMax)
	; fWeight = fMin(fMax(fWeight, fWeightMin), fWeightMax)

	fBreastMin = fMin(fMax(fBreastMin, 0.1), fBreastMax)
	fButtMin = fMin(fMax(fButtMin, 0.1), fButtMax)
	fBellyMin = fMin(fMax(fBellyMin, 0.1), fBellyMax)
	fSchlongMin = fMin(fMax(fSchlongMin, 0.1), fSchlongMax)
	fWeightMin = fMin(fMax(fWeightMin, 0.0), fWeightMax)

	fBreastMax = fMin(fMax(fBreastMin, fBreastMax), 7.0)
	fButtMax = fMin(fMax(fButtMin, fButtMax), 4.0)
	fBellyMax = fMin(fMax(fBellyMin, fBellyMax), 10.0)
	fSchlongMax = fMin(fMax(fSchlongMin, fSchlongMax), 7.0)
	fWeightMax = fMin(fMax(fWeightMin, fWeightMax), 100.0)

	GV_breastMin.SetValue(fBreastMin)
	GV_buttMin.SetValue(fButtMin)
	GV_bellyMin.SetValue(fBellyMin)
	GV_schlongMin.SetValue(fSchlongMin)
	GV_weightMin.SetValue(fWeightMin)

	GV_breastMax.SetValue(fBreastMax)
	GV_buttMax.SetValue(fButtMax)
	GV_bellyMax.SetValue(fBellyMax)
	GV_schlongMax.SetValue(fSchlongMax)
	GV_weightMax.SetValue(fWeightMax)

	GV_breastValue.SetValue(fBreast)
	GV_buttValue.SetValue(fButt)
	GV_bellyValue.SetValue(fBelly)
	GV_schlongValue.SetValue(fSchlong)
	GV_weightValue.SetValue(fWeight)

endFunction

function _getShapeState()
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()

	; Debug.Notification("SexLab Hormones: Reading state from storage")
	Debug.Trace("[SLH]  Reading state from storage")

; int value = StorageUtil.GetIntValue(none, "myGlobalVariable") ; get the previously saved global variable
; value = StorageUtil.GetIntValue(Game.GetPlayer(), "myVariable") ; get value of myVariable from player
; float fvalue = StorageUtil.GetFloatValue(akTarget, "myVariable") ; get float value from akTarget
; string svalue = StorageUtil.GetStringValue(none, "myGlobalVariable") ; get "hello"

	fLibido = StorageUtil.GetFloatValue(none, "_SLH_fLibido") 

	iSkinColor = StorageUtil.GetIntValue(none, "_SLH_iSkinColor") 
	iCheeksColor = StorageUtil.GetIntValue(none, "_SLH_iCheeksColor") 
	iLipsColor = StorageUtil.GetIntValue(none, "_SLH_iLipsColor") 
	iEyelinerColor = StorageUtil.GetIntValue(none, "_SLH_iEyelinerColor") 
	iEyesColor = StorageUtil.GetIntValue(none, "_SLH_iEyesColor") 
	iHairColor = StorageUtil.GetIntValue(none, "_SLH_iHairColor") 

	fPregLeftBreast = StorageUtil.GetFloatValue(none, "_SLH_fPregLeftBreast") 
	fPregLeftBreast01 = StorageUtil.GetFloatValue(none, "_SLH_fPregLeftBreast01") 
	fPregRightBreast = StorageUtil.GetFloatValue(none, "_SLH_fPregRightBreast") 
	fPregRightBreast01 = StorageUtil.GetFloatValue(none, "_SLH_fPregRightBreast01") 
	fPregLeftButt = StorageUtil.GetFloatValue(none, "_SLH_fPregLeftButt") 
	fPregRightButt = StorageUtil.GetFloatValue(none, "_SLH_fPregRightButt") 

	fPregBelly = StorageUtil.GetFloatValue(none, "_SLH_fPregBelly") 
	fBreast = StorageUtil.GetFloatValue(none, "_SLH_fBreast") 
	fButt = StorageUtil.GetFloatValue(none, "_SLH_fButt") 
	fBelly = StorageUtil.GetFloatValue(none, "_SLH_fBelly") 
	fSchlong = StorageUtil.GetFloatValue(none, "_SLH_fSchlong") 
	fWeight = StorageUtil.GetFloatValue(none, "_SLH_fWeight") 
	fHeight = StorageUtil.GetFloatValue(none, "_SLH_fHeight") 

	GV_breastValue.SetValue(fBreast)
	GV_buttValue.SetValue(fButt)
	GV_bellyValue.SetValue(fBelly)
	GV_schlongValue.SetValue(fSchlong)
	GV_weightValue.SetValue(fWeight)

endFunction

function _getShapeActor(Bool bUseNodes = False)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()

	; Debug.Notification("SexLab Hormones: Reading state from storage")
	Debug.Trace("[SLH]  Reading state from player actor")

	fBreast       = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BREAST, false)
	fButt       = NetImmerse.GetNodeScale(PlayerActor, NINODE_RIGHT_BUTT, false)
	fBelly       = NetImmerse.GetNodeScale(PlayerActor, NINODE_BELLY, false)
	fSchlong       = NetImmerse.GetNodeScale(PlayerActor, NINODE_SCHLONG, false)
	fWeight = pActorBase.GetWeight()
	fHeight = PlayerREF.GetScale()

	StorageUtil.SetFloatValue(none, "_SLH_fBreast",  fBreast) 
	StorageUtil.SetFloatValue(none, "_SLH_fButt",  fButt) 
	StorageUtil.SetFloatValue(none, "_SLH_fBelly",  fBelly) 
	StorageUtil.SetFloatValue(none, "_SLH_fSchlong",  fSchlong) 
	StorageUtil.SetFloatValue(none, "_SLH_fWeight",  fWeight) 

	GV_breastValue.SetValue(fBreast)
	GV_buttValue.SetValue(fButt)
	GV_bellyValue.SetValue(fBelly)
	GV_schlongValue.SetValue(fSchlong)
	GV_weightValue.SetValue(fWeight)

EndFunction


Actor kTarget            = None
Actor kCaster            = None
Actor kPlayer            = None

; SexLab Aroused
Int iOrigSLAExposureRank = -3
Faction  Property kfSLAExposure Auto
slaUtilScr Property slaUtil  Auto  

Bool  bDisableNodeChange = False
Bool  bEnableLeftBreast  = False
Bool  bEnableRightBreast = False
Bool  bEnableLeftButt    = False
Bool  bEnableRightButt   = False
Bool  bEnableBelly       = False
Bool  bEnableSchlong      = False
Bool  bEnableSkirt02     = False
Bool  bEnableSkirt03     = False
Bool  bBreastEnabled     = False
Bool  bButtEnabled       = False
Bool  bBellyEnabled      = False
Bool  bSchlongEnabled 	= False
Bool  bUninstall         = False
Bool  bIsFemale          = False
Bool  bTorpedoFixEnabled = True

Int iBlueSkinColor = 0
Int iRedSkinColor = 0
Int iSuccubusBlueSkinColor = 0
Int iSuccubusRedSkinColor = 0
Int iOrigSkinColor = 0
Int iOrigCheeksColor = 0
Int iOrigLipsColor = 0
Int iOrigEyelinerColor = 0
Float fOrigWeight = 0.0
Float fOrigHeight = 0.0
Float fOrigLeftBreast    = 1.0
Float fOrigLeftBreast01  = 1.0
Float fOrigRightBreast   = 1.0
Float fOrigRightBreast01 = 1.0
Float fOrigLeftButt      = 1.0
Float fOrigRightButt     = 1.0
Float fOrigBelly         = 1.0
Float fOrigSchlong       = 1.0

Int iSkinColor 			= 0
Int iCheeksColor 		= 0
Int iLipsColor 			= 0
Int iEyelinerColor 		= 0
Float fPregLeftBreast    = 1.0
Float fPregLeftBreast01  = 1.0
Float fPregRightBreast   = 1.0
Float fPregRightBreast01 = 1.0
Float fPregLeftButt      = 1.0
Float fPregRightButt     = 1.0
Float fPregBelly         = 1.0
Float fBreast       	= 0.0
Float fButt       		= 0.0
Float fBelly       		= 0.0
Float fSchlong      	= 0.0
Float fWeight 			= 0.0
Float fHeight 			= 0.0
Float fLibido 			= 0.0
Int iOrgasmsCountToday   = 0
Int iOrgasmsCountAll   	= 0
Int iSexCountToday   	= 0
Int iSexCountAll   		= 0
Int iOralCountToday   	= 0
Int iAnalCountToday   	= 0
Int iVaginalCountToday   = 0
Int iSexCreaturesAll   	= 0
Int iSexDogAll   		= 0
Int iSexWolfAll   		= 0
Int iSexWerewolfAll   	= 0
Int iSexManAll  	 	= 0
Int iSexMerAll  	 	= 0
Int iSexTrollAll  	 	= 0
Int iSexGiantAll  	 	= 0
Int iSexFalmerAll  	 	= 0
Int iSexBugAll  	 	= 0
Int iSexHorseAll  	 	= 0
Int iSexBearAll  	 	= 0
Int iSexCatAll  	 	= 0
Int iSexGargoyleAll  	 	= 0
Int iSexVampireLordAll  	 	= 0
Int iSexDragonAll  	 	= 0
Int iSexDaedraAll  	 	= 0

float fBreastSwellMod    = 0.0
float fButtSwellMod      = 0.0
float fBellySwellMod      = 0.0
Float fPregBreastMax      	= 15.0
Float fPregBellyMax       	= 15.0
Float fPregButtMax       	= 15.0
Float fWeightSwell = 0.0
float fWeightSwellMod    = 0.0
Float fSchlongSwellMod = 1.0

Float fBreastMax      	= 3.0
Float fBellyMax       	= 2.4
Float fButtMax       	= 2.0
Float fSchlongMax 		= 3.0
Float fWeightMax 		= 100.0

Float fBreastMin      	= 0.8
Float fBellyMin       	= 0.9
Float fButtMin       	= 0.9
Float fSchlongMin 		= 0.9
Float fWeightMin 		= 0.0

Float fArmorMod = 0.5
Float fClothingMod = 0.8

Float fUpdateTime        = 5.0
Float fWaitingTime       = 10.0
Float fOviparityTime     = 7.5
Float fGameTime          = 0.0
Float fSwellFactor	     = 0.0
Float fGrowthLastMsg  = 0.0

Int iGameDateLastSex   = -1
Int iGameDateLastCheck   = -1
Int iDaysSinceLastSex   = 0
Int iDaysSinceLastCheck   = 0

Int iEyesIndexOrig = 0
Int iHairIndexOrig = 0
Int iHairColorOrig = 0
Int iOrigEyesColor = 0
Int iOrigHairColor = 0
Int iEyesColor = 0
Int iHairColor = 0
Int iHairColorSuccubus = 0
Int iHairColorBimbo = 0

Int iTG = 0
Int iHRT = 0
Int iBimbo = 0
Int iSuccubus = 0
Int iDaedricInfluence  = 0
Int iSexStage  = 0

Race kOrigRace = None

; String                   Property NINODE_SCHLONG	 	= "NPC Genitals01 [Gen01]" AutoReadOnly
String                   Property NINODE_SCHLONG	 	= "NPC GenitalsBase [GenBase]" AutoReadOnly
String                   Property NINODE_LEFT_BREAST    = "NPC L Breast" AutoReadOnly
String                   Property NINODE_LEFT_BREAST01  = "NPC L Breast01" AutoReadOnly
String                   Property NINODE_LEFT_BUTT      = "NPC L Butt" AutoReadOnly
String                   Property NINODE_RIGHT_BREAST   = "NPC R Breast" AutoReadOnly
String                   Property NINODE_RIGHT_BREAST01 = "NPC R Breast01" AutoReadOnly
String                   Property NINODE_RIGHT_BUTT     = "NPC R Butt" AutoReadOnly
String                   Property NINODE_SKIRT02        = "SkirtBBone02" AutoReadOnly
String                   Property NINODE_SKIRT03        = "SkirtBBone03" AutoReadOnly
String                   Property NINODE_BELLY          = "NPC Belly" AutoReadOnly
Float                    Property NINODE_MAX_SCALE      = 2.0 AutoReadOnly
Float                    Property NINODE_MIN_SCALE      = 0.1 AutoReadOnly

HeadPart hpEyesOrig	 = None
HeadPart hpHairOrig	 = None 
HeadPart hpHairCurrent	 = None 

HeadPart Property hpHairBaldF Auto
HeadPart Property hpHairBaldM Auto

HeadPart Property hpEyes Auto
HeadPart Property hpHair Auto
HeadPart Property hpEyesSuccubus Auto
HeadPart Property hpHairSuccubus Auto
HeadPart Property hpEyesBimbo Auto
HeadPart Property hpHairBimbo Auto

GlobalVariable      Property GV_startingLibido 			Auto
GlobalVariable      Property GV_sexActivityThreshold 	Auto
GlobalVariable      Property GV_sexActivityBuffer 	 	Auto
GlobalVariable      Property GV_baseSwellFactor 		Auto
GlobalVariable      Property GV_baseShrinkFactor 		Auto
GlobalVariable      Property GV_breastSwellMod 			Auto
GlobalVariable      Property GV_bellySwellMod 			Auto
GlobalVariable      Property GV_schlongSwellMod 		Auto
GlobalVariable      Property GV_buttSwellMod 			Auto
GlobalVariable      Property GV_weightSwellMod 			Auto

GlobalVariable      Property GV_breastMax 				Auto
GlobalVariable      Property GV_buttMax 				Auto
GlobalVariable      Property GV_bellyMax 				Auto
GlobalVariable      Property GV_schlongMax 				Auto
GlobalVariable      Property GV_weightMax 				Auto

GlobalVariable      Property GV_breastMin				Auto
GlobalVariable      Property GV_buttMin 				Auto
GlobalVariable      Property GV_bellyMin 				Auto
GlobalVariable      Property GV_schlongMin 				Auto
GlobalVariable      Property GV_weightMin 				Auto

GlobalVariable      Property GV_breastValue 			Auto
GlobalVariable      Property GV_buttValue 				Auto
GlobalVariable      Property GV_bellyValue 				Auto
GlobalVariable      Property GV_schlongValue 			Auto
GlobalVariable      Property GV_weightValue 			Auto

GlobalVariable      Property GV_useNodes 				Auto
GlobalVariable      Property GV_useBreastNode 			Auto
GlobalVariable      Property GV_useButtNode 			Auto
GlobalVariable      Property GV_useBellyNode 			Auto
GlobalVariable      Property GV_useSchlongNode 			Auto

GlobalVariable      Property GV_useWeight 				Auto
GlobalVariable      Property GV_useColors 				Auto
GlobalVariable      Property GV_redShiftColor  			Auto
GlobalVariable      Property GV_redShiftColorMod 		Auto
GlobalVariable      Property GV_blueShiftColor 			Auto
GlobalVariable      Property GV_blueShiftColorMod 		Auto
GlobalVariable      Property GV_isTG                    Auto
GlobalVariable      Property GV_isHRT 					Auto
GlobalVariable      Property GV_isBimbo 				Auto
GlobalVariable      Property GV_isSuccubus 				Auto
GlobalVariable      Property GV_allowTG                 Auto
GlobalVariable      Property GV_allowHRT 				Auto
GlobalVariable      Property GV_allowBimbo 				Auto
GlobalVariable      Property GV_allowSuccubus 			Auto
GlobalVariable      Property GV_resetToggle 			Auto
GlobalVariable      Property GV_forcedRefresh 			Auto
GlobalVariable      Property GV_armorMod 				Auto
GlobalVariable      Property GV_clothMod	 			Auto
GlobalVariable      Property GV_showStatus 				Auto
GlobalVariable      Property GV_commentsFrequency		Auto

GlobalVariable      Property GV_changeOverrideToggle	Auto
GlobalVariable      Property GV_shapeUpdateOnCellChange	Auto
GlobalVariable      Property GV_shapeUpdateAfterSex		Auto
GlobalVariable      Property GV_shapeUpdateOnTimer		Auto
GlobalVariable      Property GV_enableNiNodeUpdate		Auto

Message Property _SLH_Warning Auto

SPELL Property _SLH_SexBoost  Auto  
SPELL Property _SLH_SexFocus  Auto  
SPELL Property _SLH_SexStarve  Auto  


			

SPELL Property _SLH_DaedricInfluence  Auto  

Race Property _SLH_DremoraRace  Auto  
Race Property _SLH_DremoraOutcastRace  Auto  
Race Property _SLH_BimboRace  Auto  

Quest Property _SLH_QST_Succubus  Auto  
Quest Property _SLH_QST_Bimbo  Auto  


Keyword Property ArmorOn  Auto  

Keyword Property ClothingOn  Auto  
SPELL Property PolymorphBimbo Auto

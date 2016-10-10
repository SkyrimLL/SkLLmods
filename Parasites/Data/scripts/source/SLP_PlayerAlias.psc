Scriptname SLP_PlayerAlias extends ReferenceAlias  

SexLabFramework     property SexLab Auto
zadLibs Property libs Auto
slaUtilScr Property slaUtil  Auto  

; SLP_functions Property funct  Auto
; SLP_fcts_constraints Property fctConstraints  Auto
SLP_fcts_parasites Property fctParasites  Auto

ReferenceAlias Property PlayerAlias  Auto  
ReferenceAlias Property SpiderInfectedAlias  Auto  

GlobalVariable Property _SLP_GV_numInfections  Auto 
GlobalVariable Property _SLP_GV_numSpiderEggInfections  Auto 

Container Property EggSac  Auto  

; String                   Property NINODE_SCHLONG	 	= "NPC Genitals01 [Gen01]" AutoReadOnly
string                   Property SLH_KEY               = "SexLab_Hormones.esp" AutoReadOnly
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
Float                    Property NINODE_MAX_SCALE      = 4.0 AutoReadOnly
Float                    Property NINODE_MIN_SCALE      = 0.1 AutoReadOnly

; NiOverride version data
int                      Property NIOVERRIDE_VERSION    = 4 AutoReadOnly
int                      Property NIOVERRIDE_SCRIPT_VERSION = 4 AutoReadOnly

; XPMSE version data
float                    Property XPMSE_VERSION         = 3.0 AutoReadOnly
float                    Property XPMSELIB_VERSION      = 3.0 AutoReadOnly


int Property MAX_PRESETS = 4 AutoReadOnly
int Property MAX_MORPHS = 19 AutoReadOnly

Bool isNiOInstalled = false
int daysPassed
int iGameDateLastCheck = -1
int iDaysSinceLastCheck

Event OnInit()
	_maintenance()

EndEvent

Event OnPlayerLoadGame()
	_maintenance()

EndEvent

Function _maintenance()
 	Actor PlayerActor= Game.GetPlayer() as Actor
 	ActorBase pActorBase = PlayerActor.GetActorBase()

	if (!isNiOInstalled)
		isNiOInstalled = CheckXPMSERequirements(PlayerActor, pActorBase.GetSex())
	EndIf

	If (!StorageUtil.HasIntValue(none, "_SLP_iSexLabParasites"))
		StorageUtil.SetIntValue(none, "_SLP_iSexLabParasites", 1)
	EndIf

	UnregisterForAllModEvents()
	Debug.Trace("SexLab Parasites: Reset SexLab events")
	RegisterForModEvent("AnimationStart", "OnSexLabStart")
	RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")
 
	RegisterForModEvent("SLPInfectSpiderEgg",   "OnSLPInfectSpiderEgg")
	RegisterForModEvent("SLPCureSpiderEgg",   "OnSLPCureSpiderEgg")
	; RegisterForModEvent("SLPInfectChaurusWorm",   "OnSLPInfectChaurusWorm")

	RegisterForSingleUpdate(10)
EndFunction



Event OnUpdate()
 	Actor PlayerActor= Game.GetPlayer() as Actor

 	daysPassed = Game.QueryStat("Days Passed")

 	; Initial values
 	if (iGameDateLastCheck == -1)
 		iGameDateLastCheck = daysPassed
 	endIf
 
	iDaysSinceLastCheck = (daysPassed - iGameDateLastCheck ) as Int

	If (iDaysSinceLastCheck > 0)
		; updateAllCows()
	endIf

	iGameDateLastCheck = daysPassed  

	RegisterForSingleUpdate(10)
EndEvent


Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 
	Int iProlactinLevel 

	if !Self || !SexLab 
		Debug.Trace("SexLab Parasites: Critical error on SexLab Start")
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
		If (fctParasites.isInfectedByString( PlayerActor,  "SpiderEgg" ))
			slaUtil.UpdateActorExposure(akRef = PlayerActor, val = 2, debugMsg = "Aroused from sex while carrying spider eggs.")
		Endif
	endif

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
		Debug.Trace("SexLab Parasites: Critical error on SexLab End")
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

	if animation.HasTag("Chaurus") && (_hasPlayer(actors)) ; && (_SDGVP_enable_parasites.GetValue() == 1)
		If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "PlugAnal"))

			PlayerActor.SendModEvent("SLPInfectChaurusWorm")

		EndIf
	EndIf

	if animation.HasTag("Spider") && (_hasPlayer(actors)) ; && (_SDGVP_enable_parasites.GetValue() == 1)
		; Debug.Notification("[SLP] Sex with spider detected ")
		; Debug.Notification("[SLP] Player wearing belt -  " + fctParasites.ActorHasKeywordByString(PlayerActor, "Belt"))
		; Debug.Notification("[SLP] Player wearing plug -  " + fctParasites.ActorHasKeywordByString(PlayerActor, "PlugVaginal"))
		If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "PlugVaginal"))

			; Debug.Notification("[SLP] Sending infection event" )
			PlayerActor.SendModEvent("SLPInfectSpiderEgg")

		EndIf
	EndIf
EndEvent 

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
    sslBaseAnimation animation = SexLab.HookAnimation(_args)
 
	if !Self || !SexLab 
		Debug.Trace("SexLab Parasites: Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	; 
	if animation.HasTag("Spider") && (_hasPlayer(actors))  
 
		if (fctParasites.isInfectedByString( PlayerActor,  "SpiderEgg" )) && (Utility.RandomInt(0,100)< (1 + StorageUtil.GetIntValue(PlayerActor, "_SLP_chanceSpiderEgg" ) / 4))
			Debug.MessageBox("As you lay on the floor, still panting, you realize the spider extracted the fertilized eggs out of your exhausted body.")
			PlayerActor.SendModEvent("SLPCureSpiderEgg","All")
			PlayerActor.PlaceAtMe(EggSac)
		endIf
 
	EndIf
EndEvent


Event OnSLPInfectSpiderEgg(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()
 	Int iNumSpiderEggs
 
	Debug.Trace("[SLP] Receiving 'infect spider egg' event - Actor: " + kActor)

	If (StorageUtil.GetIntValue(kActor, "_SLP_toggleSpiderEgg" )!= 1)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (fctParasites.isInfectedByString( kActor,  "SpiderEgg" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	if (Utility.RandomInt(0,100)< StorageUtil.GetIntValue(kActor, "_SLP_chanceSpiderEgg" ))
		If (kActor == PlayerActor)
			SpiderInfectedAlias.ForceRefTo(PlayerActor)
		endIf

		iNumSpiderEggs = Utility.RandomInt(5,10)
		fctParasites.equipParasiteNPCByString (kActor, "SpiderEgg")

		ApplyBodyChange( kActor, "SpiderEgg", "Belly", (2.0 + 4.0 * (iNumSpiderEggs as Float) / 10.0) )

		If !StorageUtil.HasIntValue(kActor, "_SLP_iSpiderEggInfections")
				StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  0)
		EndIf

		StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
		StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections") + 1)
		StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )

		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numSpiderEggInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections"))

		Debug.MessageBox("You gasp as the spider fills your womb with a string if slimy eggs.")

		SendModEvent("SLPSpiderEggInfection")

	EndIf
	
EndEvent

Event OnSLPCureSpiderEgg(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()
 	Int iNumSpiderEggs
 
	Debug.Trace("[SLP] Receiving 'cure spider egg' event - Actor: " + kActor)

	If (fctParasites.isInfectedByString( kActor,  "SpiderEgg" ))
		iNumSpiderEggs = StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount") - Utility.RandomInt(2,8)

		if (iNumSpiderEggs < 0) || (_args == "All")
			If (kActor == PlayerActor)
				SpiderInfectedAlias.ForceRefTo(None)
			endIf
			iNumSpiderEggs = 0
			StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", 0 )

			fctParasites.clearParasiteNPCByString (kActor, "SpiderEgg")
		Endif

		ApplyBodyChange( kActor, "SpiderEgg", "Belly", (6.0 * (iNumSpiderEggs as Float) / 10.0) )
 
		StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )
		SendModEvent("SLPSpiderEggInfection")

	EndIf
	
EndEvent


Event OnSLPInfectChaurusWorm(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 
	Debug.Trace("[SLP] Receiving 'infect chaurus worm' event - Actor: " + kActor)

	If (StorageUtil.GetIntValue(kActor, "_SLP_toggleChaurusWorm" )!= 1)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (fctParasites.isInfectedByString( kActor,  "ChaurusWorm" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	if (Utility.RandomInt(0,100)< StorageUtil.GetIntValue(kActor, "_SLP_chanceSpiderEgg" ))

		fctParasites.equipParasiteNPCByString (kActor, "ChaurusWorm")

		ApplyBodyChange( kActor, "Chaurus", "Belly", 1.0)

		If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusWormInfections")
				StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormInfections",  0)
		EndIf

		StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
		StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormInfections") + 1)
		SendModEvent("SLPChaurusWormInfection")

	EndIf
	
EndEvent

Function ApplyBodyChange(Actor kActor, String sParasite, String sBodyPart, Float fValue)
  	ActorBase pActorBase = kActor.GetActorBase()
 	Actor PlayerActor = Game.GetPlayer()
  	String NiOString = "SLP_" + sParasite

	if ( isNiOInstalled  )  

		Debug.Trace("[SLP] Receiving body change: " + sBodyPart)

		if (( sBodyPart == "Breast"  ) && (pActorBase.GetSex()==1)) ; Female change
	 		if (fValue > 3.0)
				fValue = 3.0
			Endif
			; Reduce effect for player with Hormones
			if (kActor == PlayerActor) && (StorageUtil.GetIntValue(none, "_SLH_iHormones")==1) && (fValue > 1.0)
				fValue = 2.0
			endif
	
			Debug.Trace("[SLP]     Applying breast change: " + NiOString)
			Debug.Trace("[SLP]     Value: " + fValue)

			XPMSELib.SetNodeScale(kActor, true, NINODE_LEFT_BREAST, fValue, NiOString)
			XPMSELib.SetNodeScale(kActor, true, NINODE_RIGHT_BREAST, fValue, NiOString)

		Elseif (( sBodyPart == "Belly"  ) && (pActorBase.GetSex()==1)) ; Female change
	 		if (fValue > 6.0)
				fValue = 6.0
			Endif
			; Reduce effect for player with Hormones
			if (kActor == PlayerActor) && (StorageUtil.GetIntValue(none, "_SLH_iHormones")==1) && (fValue > 4.0)
				fValue = 4.0
			endif
	
			Debug.Trace("[SLP]     Applying belly change: " + NiOString)
			Debug.Trace("[SLP]     Value: " + fValue)

			XPMSELib.SetNodeScale(kActor, true, NINODE_BELLY, fValue, NiOString)

		Endif
	Else
		; Debug.Notification("[SLP] Receiving body change: NiO not installed")

	EndIf

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
 


bool Function CheckXPMSERequirements(Actor akActor, bool isFemale)
	return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction


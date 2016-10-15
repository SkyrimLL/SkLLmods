Scriptname SLP_PlayerAlias extends ReferenceAlias  

SexLabFramework     property SexLab Auto
zadLibs Property libs Auto
slaUtilScr Property slaUtil  Auto  

; SLP_functions Property funct  Auto
; SLP_fcts_constraints Property fctConstraints  Auto
SLP_fcts_parasites Property fctParasites  Auto

ReferenceAlias Property PlayerAlias  Auto  
ReferenceAlias Property SpiderInfectedAlias  Auto  
ReferenceAlias Property SpiderFollowerAlias  Auto  

GlobalVariable Property _SLP_GV_numInfections  Auto 
GlobalVariable Property _SLP_GV_numSpiderEggInfections  Auto 
GlobalVariable Property _SLP_GV_numChaurusWormInfections  Auto 
GlobalVariable Property _SLP_GV_numTentacleMonsterInfections  Auto 

Faction Property PlayerFollowerFaction Auto

SPELL Property StomachRot Auto

Container Property EggSac  Auto  
Ingredient  Property TrollFat Auto
Ingredient  Property IngredientChaurusWorm Auto

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
 
	RegisterForModEvent("SLPSexCure",   "OnSLPSexCure")

	RegisterForModEvent("SDParasiteAn",   "OnSLPInfectSpiderEgg")
	RegisterForModEvent("SDParasiteVag",   "OnSLPInfectChaurusWorm")

	RegisterForModEvent("SLPInfectSpiderEgg",   "OnSLPInfectSpiderEgg")
	RegisterForModEvent("SLPCureSpiderEgg",   "OnSLPCureSpiderEgg")
	RegisterForModEvent("SLPInfectSpiderPenis",   "OnSLPInfectSpiderPenis")
	RegisterForModEvent("SLPCureSpiderPenis",   "OnSLPCureSpiderPenis")
	RegisterForModEvent("SLPInfectChaurusWorm",   "OnSLPInfectChaurusWorm")
	RegisterForModEvent("SLPCureChaurusWorm",   "OnSLPCureChaurusWorm")
	RegisterForModEvent("SLPInfectTentacleMonster",   "OnSLPInfectTentacleMonster")
	RegisterForModEvent("SLPCureTentacleMonster",   "OnSLPCureTentacleMonster")

	RegisterForModEvent("ArachnophobiaPlayerCaptured",   "OnArachnophobiaPlayerCaptured")

	RegisterForModEvent("SLPRefreshBodyShape",   "OnSLPRefreshBodyShape")

	RegisterForSingleUpdate(10)
EndFunction



Event OnUpdate()
 	Actor PlayerActor= Game.GetPlayer() as Actor
 	Int iParasiteDuration
 	Float fValue

 	daysPassed = Game.QueryStat("Days Passed")

 	; Initial values
 	if (iGameDateLastCheck == -1)
 		iGameDateLastCheck = daysPassed
 	endIf
 
	iDaysSinceLastCheck = (daysPassed - iGameDateLastCheck ) as Int

	If (iDaysSinceLastCheck > 0)
		If (fctParasites.isInfectedByString( PlayerActor,  "SpiderPenis" ))
			iParasiteDuration = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(PlayerActor, "_SLP_iSpiderPenisDate")
			If (Utility.RandomInt(0,100) > (100 - (iParasiteDuration * 10) ) )
				Debug.MessageBox("The remains of the spider penis finally slide out of you.")
				PlayerActor.SendModEvent("SLPCureSpiderPenis")
			endif
		Endif
		If (fctParasites.isInfectedByString( PlayerActor,  "TentacleMonster" ))
			iParasiteDuration = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(PlayerActor, "_SLP_iTentacleMonsterDate")
			If (iParasiteDuration < 10)
				Debug.MessageBox("Your breasts grow under the influence of the tentacles.")
				fValue = (iParasiteDuration as Float) / 10.0
				ApplyBodyChange( PlayerActor, "TentacleMonster", "Breast", fValue, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxTentacleMonster" ) )
			endif
			If (iParasiteDuration >= 10) && (StorageUtil.GetIntValue(PlayerActor, "_SLH_iLactating")!=1)
				StorageUtil.SetIntValue(PlayerActor, "_SLH_iLactating", 1)
				PlayerActor.SendModEvent("_SLSDDi_UpdateCow")
			Endif
		Endif



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
	
	; Debug.Notification("[SLP] Sex start")
	; Debug.Trace("[SLP] Sex start")

	Actor[] actors = SexLab.HookActors(_args)
	Actor   victim = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim
	
	; Debug.Notification("[SLP]  Has player: " + _hasPlayer(actors))
	; Debug.Trace("[SLP]  Has player: " + _hasPlayer(actors))
	; Debug.Notification("Arousal trigger: " + (slaUtil.GetActorExposure(akRef = PlayerActor) / 3))

	If (_hasPlayer(actors))
		If (fctParasites.isInfectedByString( PlayerActor,  "SpiderEgg" ))
			slaUtil.UpdateActorExposure(akRef = PlayerActor, val = 2, debugMsg = "Aroused from sex while carrying spider eggs.")
		ElseIf (fctParasites.isInfectedByString( PlayerActor,  "SpiderPenis" ))
			slaUtil.UpdateActorExposure(akRef = PlayerActor, val = 5, debugMsg = "Aroused from sex while carrying spider eggs.")
		ElseIf (fctParasites.isInfectedByString( PlayerActor,  "ChaurusWorm" ))
			slaUtil.UpdateActorExposure(akRef = PlayerActor, val = 10, debugMsg = "Aroused from sex while carrying spider eggs.")
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
    Actor kSexPartner 

	if !Self || !SexLab 
		Debug.Trace("SexLab Parasites: Critical error on SexLab End")
		Return
	EndIf


	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	; Debug.Notification("[SLP] Sex end")
	; Debug.Trace("[SLP] Sex end")

	; if config.bDebugMsg
	; 	_listActors("End: ", actors)
	; EndIf

	; If (_hasPlayer(actors))
		;
	; EndIf
	If (_hasPlayer(actors))
		; Debug.Notification("[SLP] Player in animation")
		; Debug.Trace("[SLP] Player in animation")

		if animation.HasTag("Chaurus") ; && (_SDGVP_enable_parasites.GetValue() == 1)
			If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "PlugAnal"))

				if (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" ) as Int) )
					PlayerActor.SendModEvent("SLPInfectChaurusWorm")
				Endif

			EndIf
		EndIf

		if animation.HasTag("Spider") ; && (_SDGVP_enable_parasites.GetValue() == 1)
			; Debug.Notification("[SLP] Sex with spider")
			; Debug.Trace("[SLP] Sex with spider")

			If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "PlugVaginal"))
				; Debug.Notification("[SLP] Player vulnerable to spider")
				; Debug.Trace("[SLP] Player vulnerable to spider")

				if (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderPenis" ) as Int) )
					; Debug.Notification("[SLP] Receiving spider penis")
					; Debug.Trace("[SLP] Receiving spider penis")

					PlayerActor.SendModEvent("SLPInfectSpiderPenis")
					kSexPartner = _firstNotPlayer(actors)
					SpiderInfectedAlias.ForceRefTo(kSexPartner)

				elseif (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) as Int) )
					; Debug.Notification("[SLP] Receiving spider eggs")
					; Debug.Trace("[SLP] Receiving spider eggs")
					PlayerActor.SendModEvent("SLPInfectSpiderEgg")
				endif
			EndIf
		EndIf
	Else
		; Debug.Notification("[SLP] Player NOT in animation")
		; Debug.Trace("[SLP] Player NOT in animation")
	Endif

	int idx = 0
	while idx < actors.Length
		if (actors[idx]) && ( actors[idx] != PlayerActor) && ( actors[idx].IsInFaction(PlayerFollowerFaction))
			if animation.HasTag("Chaurus") ; && (_SDGVP_enable_parasites.GetValue() == 1)
				If (!fctParasites.ActorHasKeywordByString(actors[idx], "Belt")) && (!fctParasites.ActorHasKeywordByString(actors[idx], "PlugAnal"))

					if (Utility.RandomInt(1,100)< (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" ) as Int) )
						actors[idx].SendModEvent("SLPInfectChaurusWorm")
					Endif

				EndIf
			EndIf

			if animation.HasTag("Spider") ; && (_SDGVP_enable_parasites.GetValue() == 1)
				If (!fctParasites.ActorHasKeywordByString(actors[idx], "Belt")) && (!fctParasites.ActorHasKeywordByString(actors[idx], "PlugVaginal"))

					if (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderPenis" ) as Int) )
						actors[idx].SendModEvent("SLPInfectSpiderPenis")

					elseif (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) as Int) )
						actors[idx].SendModEvent("SLPInfectSpiderEgg")
					endif
				EndIf
			EndIf
		endIf
		idx += 1
	endwhile
	; Debug.Trace("[SLP] Sex end - end")
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

	; Debug.Notification("[SLP] Orgasm")
	; Debug.Trace("[SLP] Orgasm")
	; 
	if (_hasPlayer(actors))
		if animation.HasTag("Spider")  
	 
			if (fctParasites.isInfectedByString( PlayerActor,  "SpiderEgg" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) / 4))
				Debug.MessageBox("As you lay on the floor, still panting, you realize the spider extracted the fertilized eggs out of your exhausted body.")
				PlayerActor.SendModEvent("SLPCureSpiderEgg","All")
				PlayerActor.PlaceAtMe(EggSac)
			endIf
	 
		EndIf

		If (fctParasites.isInfectedByString( PlayerActor,  "ChaurusWorm" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" ) / 5))
				Debug.MessageBox("The power of your orgasm is enough to expel the worm from your bowels, making you nearly black out from the added stimulation.")
				PlayerActor.SendModEvent("SLPCureChaurusWorm")
				PlayerActor.AddItem(IngredientChaurusWorm,1)
		EndIf
	endif

	int idx = 0
	while idx < actors.Length
		if (actors[idx]) && ( actors[idx] != PlayerActor) 
			if (fctParasites.isInfectedByString( actors[idx],  "SpiderEgg" )) && (Utility.RandomInt(2,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) / 4))
				actors[idx].SendModEvent("SLPCureSpiderEgg","All")
				actors[idx].PlaceAtMe(EggSac)
			endIf

			If (fctParasites.isInfectedByString( actors[idx],  "ChaurusWorm" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" ) / 5))
					actors[idx].SendModEvent("SLPCureChaurusWorm")
					actors[idx].AddItem(IngredientChaurusWorm,1)
			EndIf

		endIf
		idx += 1
	endwhile
	; Debug.Trace("[SLP] Orgasm - end")
EndEvent

Event OnArachnophobiaPlayerCaptured(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()

 	PlayerActor.SendModEvent("PCSubFree")

	If (!fctParasites.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasites.ActorHasKeywordByString(PlayerActor, "PlugVaginal"))

		if (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderPenis" ) as Int) )
			PlayerActor.SendModEvent("SLPInfectSpiderPenis")

		elseif (Utility.RandomInt(1,100)<= (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" ) as Int) )
			PlayerActor.SendModEvent("SLPInfectSpiderEgg")
		endif
	EndIf
EndEvent



Event OnSLPInfectSpiderEgg(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()
 	Int iNumSpiderEggs
 
	Debug.Trace("[SLP] Receiving 'infect spider egg' event - Actor: " + kActor)

	If (StorageUtil.GetFloatValue(kActor, "_SLP_chanceSpiderEgg" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (fctParasites.isInfectedByString( kActor,  "SpiderEgg" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	iNumSpiderEggs = Utility.RandomInt(5,10)

	If (kActor == PlayerActor)
		SpiderInfectedAlias.ForceRefTo(PlayerActor)
	endIf
	if (iNumSpiderEggs>=8)
		StomachRot.RemoteCast(kActor as ObjectReference, kActor,kActor as ObjectReference)
	endIf

	fctParasites.equipParasiteNPCByString (kActor, "SpiderEgg")

	ApplyBodyChange( kActor, "SpiderEgg", "Belly", (2.0 + 4.0 * (iNumSpiderEggs as Float) / 10.0), StorageUtil.GetFloatValue(kActor, "_SLP_bellyMaxSpiderEgg" ))

	If !StorageUtil.HasIntValue(kActor, "_SLP_iSpiderEggInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numSpiderEggInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections"))

	Debug.MessageBox("You gasp as the spider fills your womb with a string if slimy eggs.")

	SendModEvent("SLPSpiderEggInfection")

	
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

			kActor.DispelSpell(StomachRot)

			StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 0)
			fctParasites.clearParasiteNPCByString (kActor, "SpiderEgg")
		Endif

		ApplyBodyChange( kActor, "SpiderEgg", "Belly", (2.0 + 4.0 * (iNumSpiderEggs as Float) / 10.0), StorageUtil.GetFloatValue(kActor, "_SLP_bellyMaxSpiderEgg" ) )
 
		StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )
		SendModEvent("SLPSpiderEggInfection")

	EndIf
	
EndEvent


Event OnSLPInfectSpiderPenis(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()
 	Int iNumSpiderEggs
 
	Debug.Trace("[SLP] Receiving 'infect spider penis' event - Actor: " + kActor)

	If (StorageUtil.GetFloatValue(kActor, "_SLP_chanceSpiderPenis" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (fctParasites.isInfectedByString( kActor,  "SpiderPenis" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	iNumSpiderEggs = Utility.RandomInt(5,10)

	If (kActor == PlayerActor)
		SpiderInfectedAlias.ForceRefTo(PlayerActor)
	endIf
	if (iNumSpiderEggs>=4)
		StomachRot.RemoteCast(kActor as ObjectReference, kActor,kActor as ObjectReference)
	endIf

	fctParasites.equipParasiteNPCByString (kActor, "SpiderPenis")

	ApplyBodyChange( kActor, "SpiderEgg", "Belly", (2.0 + 4.0 * (iNumSpiderEggs as Float) / 10.0), StorageUtil.GetFloatValue(kActor, "_SLP_bellyMaxSpiderEgg" ) )

	If !StorageUtil.HasIntValue(kActor, "_SLP_iSpiderEggInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderPenisDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numSpiderEggInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections"))

	Debug.MessageBox("You gasp as the spider fills your womb with a string if slimy eggs. Unfortunately, the penis of the spider remains firmly lodged inside you after the act.")

	SendModEvent("SLPSpiderEggInfection")

	
EndEvent

Event OnSLPCureSpiderPenis(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()
 	Int iNumSpiderEggs
 
	Debug.Trace("[SLP] Receiving 'cure spider penis' event - Actor: " + kActor)

	If (fctParasites.isInfectedByString( kActor,  "SpiderPenis" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 0 )
		fctParasites.clearParasiteNPCByString (kActor, "SpiderPenis")

		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 1 )
		fctParasites.equipParasiteNPCByString (kActor, "SpiderEgg")
	EndIf
	
EndEvent

Event OnSLPInfectChaurusWorm(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 
	Debug.Trace("[SLP] Receiving 'infect chaurus worm' event - Actor: " + kActor)

	If (StorageUtil.GetFloatValue(kActor, "_SLP_chanceChaurusWorm" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (fctParasites.isInfectedByString( kActor,  "ChaurusWorm" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	fctParasites.equipParasiteNPCByString (kActor, "ChaurusWorm")

	ApplyBodyChange( kActor, "ChaurusWorm", "Butt", 1.0, StorageUtil.GetFloatValue(kActor, "_SLP_buttMaxChaurusWorm" ))

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusWormInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormInfections") + 1)

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numChaurusWormInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormInfections"))

	SendModEvent("SLPChaurusWormInfection")
	
EndEvent

Event OnSLPCureChaurusWorm(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()
 	Int iNumSpiderEggs
 
	Debug.Trace("[SLP] Receiving 'cure chaurus worm' event - Actor: " + kActor)

	If (fctParasites.isInfectedByString( kActor,  "ChaurusWorm" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 0)
		fctParasites.clearParasiteNPCByString (kActor, "ChaurusWorm")
	EndIf
	
EndEvent

Event OnSLPInfectTentacleMonster(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 
	Debug.Trace("[SLP] Receiving 'infect tentacle monster' event - Actor: " + kActor)

	If (StorageUtil.GetFloatValue(kActor, "_SLP_chanceTentacleMonster" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (fctParasites.isInfectedByString( kActor,  "TentacleMonster" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	fctParasites.equipParasiteNPCByString (kActor, "TentacleMonster")

	If !StorageUtil.HasIntValue(kActor, "_SLP_iTentacleMonsterInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iTentacleMonsterInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iTentacleMonsterDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iTentacleMonsterInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iTentacleMonsterInfections") + 1)

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numTentacleMonsterInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iTentacleMonsterInfections"))

	SendModEvent("SLPTentacleMonsterInfection")
	
EndEvent

Event OnSLPCureTentacleMonster(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()
 	Int iNumSpiderEggs
 
	Debug.Trace("[SLP] Receiving 'cure tentacle monster' event - Actor: " + kActor)

	If (fctParasites.isInfectedByString( kActor,  "TentacleMonster" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 0 )
		fctParasites.clearParasiteNPCByString (kActor, "TentacleMonster")
	EndIf
	
EndEvent


Event OnSLPSexCure(String _eventName, String _args, Float _argc = 0.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer() as Actor
 	String sParasite = _args
 	String sTags 
 	Bool bIsPlayerHealer = _argc as Bool

 	If (sParasite == "SpiderEgg")
 		sTags = "Fisting"
 		kPlayer.RemoveItem(TrollFat,1)
 	Else
		sTags = "Oral"
  	endif

	If  (SexLab.ValidateActor( kPlayer ) > 0) &&  (SexLab.ValidateActor(kActor) > 0) 
		actor[] sexActors = new actor[2]
		If (bIsPlayerHealer)
			sexActors[0] = kActor
			sexActors[1] = kPlayer
		else
			sexActors[0] = kPlayer
			sexActors[1] = kActor
		endif

		sslBaseAnimation[] anims
		anims = new sslBaseAnimation[1]
		anims = SexLab.GetAnimationsByTags(2, sTags,"Estrus,Dwemer")

		SexLab.StartSex(sexActors, anims)
	EndIf


	If (bIsPlayerHealer)
		If (sParasite == "SpiderEgg")
			kActor.SendModEvent("SLPCureSpiderEgg","All")
		Endif

	Else
		If (sParasite == "SpiderEgg")
			kPlayer.SendModEvent("SLPCureSpiderEgg","All")
		Endif
	Endif

EndEvent

Event OnSLPRefreshBodyShape(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor = Game.GetPlayer()

	Debug.Trace("[SLP] Receiving 'refresh body shape' event - Actor: " + kActor)

	If (fctParasites.isInfectedByString( kActor,  "SpiderEgg" )) || (fctParasites.isInfectedByString( kActor,  "SpiderPenis" ))
		Debug.Trace("[SLP] Refreshing belly shape (spider egg)")
		Int iNumSpiderEggs = StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount" )
		ApplyBodyChange( kActor, "SpiderEgg", "Belly", (2.0 + 4.0 * (iNumSpiderEggs as Float) / 10.0), StorageUtil.GetFloatValue(kActor, "_SLP_bellyMaxSpiderEgg" ))
	EndIf

	If (fctParasites.isInfectedByString( kActor,  "ChaurusWorm" ))
		Debug.Trace("[SLP] Refreshing butt shape (chaurus worm)")
		ApplyBodyChange( kActor, "ChaurusWorm", "Butt", 1.0, StorageUtil.GetFloatValue(kActor, "_SLP_buttMaxChaurusWorm" ))
	EndIf

	If (fctParasites.isInfectedByString( kActor,  "TentacleMonster" ))
		Debug.Trace("[SLP] Refreshing breast shape (tentacle monster)")
		Int iParasiteDuration = Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(kActor, "_SLP_iTentacleMonsterDate")
		Float fValue = (iParasiteDuration as Float) / 10.0
		ApplyBodyChange( kActor, "TentacleMonster", "Breast", fValue, StorageUtil.GetFloatValue(kActor, "_SLP_breastMaxTentacleMonster" ) )
	EndIf

EndEvent

Function ApplyBodyChange(Actor kActor, String sParasite, String sBodyPart, Float fValue=1.0, Float fValueMax=1.0)
  	ActorBase pActorBase = kActor.GetActorBase()
 	Actor PlayerActor = Game.GetPlayer()
  	String NiOString = "SLP_" + sParasite

	if ( isNiOInstalled  )  

		Debug.Trace("[SLP] Receiving body change: " + sBodyPart)
 		if (fValue > fValueMax)
			fValue = fValueMax
		Endif

		if (( sBodyPart == "Breast"  ) && (pActorBase.GetSex()==1)) ; Female change
			Debug.Trace("[SLP]     Applying breast change: " + NiOString)
			Debug.Trace("[SLP]     Value: " + fValue)

			XPMSELib.SetNodeScale(kActor, true, NINODE_LEFT_BREAST, fValue, NiOString)
			XPMSELib.SetNodeScale(kActor, true, NINODE_RIGHT_BREAST, fValue, NiOString)

		Elseif (( sBodyPart == "Belly"  ) && (pActorBase.GetSex()==1)) ; Female change
			Debug.Trace("[SLP]     Applying belly change: " + NiOString)
			Debug.Trace("[SLP]     Value: " + fValue)

			XPMSELib.SetNodeScale(kActor, true, NINODE_BELLY, fValue, NiOString)

		Elseif (( sBodyPart == "Butt"  )) 
			Debug.Trace("[SLP]     Applying butt change: " + NiOString)
			Debug.Trace("[SLP]     Value: " + fValue)

			XPMSELib.SetNodeScale(kActor, pActorBase.GetSex(), NINODE_LEFT_BUTT, fValue, NiOString)
			XPMSELib.SetNodeScale(kActor, pActorBase.GetSex(), NINODE_RIGHT_BUTT, fValue, NiOString)

		Elseif (( sBodyPart == "Schlong"  ) ) 
			Debug.Trace("[SLP]     Applying schlong change: " + NiOString)
			Debug.Trace("[SLP]     Value: " + fValue)

			XPMSELib.SetNodeScale(kActor, pActorBase.GetSex(), NINODE_SCHLONG, fValue, NiOString)

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

Actor Function _firstNotPlayer(Actor[] _actors)
	ObjectReference PlayerREF= PlayerAlias.GetReference()

	int idx = 0
	while idx < _actors.Length
		if _actors[idx] != PlayerRef
			return _actors[idx]
		endif
		idx += 1
	endwhile
	Return None
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


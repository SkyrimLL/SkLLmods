Scriptname SLP_fcts_utils extends Quest  

Import Utility
Import SKSE
zadLibs Property libs Auto
SexLabFrameWork Property SexLab Auto

Faction Property ChaurusFaction  Auto
Faction Property SpiderFaction  Auto
Faction Property SprigganFaction  Auto

Race Property ChaurusRace  Auto
Race Property ChaurusReaperRace  Auto  
Race Property SpiderRace  Auto
Race Property SpiderLargeRace  Auto
Race Property SprigganRace  Auto
Race Property SprigganMatronRace  Auto
Race Property SprigganEarthMotherRace  Auto
Race Property SprigganSwarmRace  Auto
Race Property SprigganBurntRace  Auto

Keyword Property _SLP_Parasite  Auto  

ImageSpaceModifier Property FalmerBlueImod  Auto  

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

int                      Property SKEE_VERSION  = 1 AutoReadOnly


; NiOverride version data
int                      Property NIOVERRIDE_VERSION    = 4 AutoReadOnly
int                      Property NIOVERRIDE_SCRIPT_VERSION = 4 AutoReadOnly

; XPMSE version data
float                    Property XPMSE_VERSION         = 3.0 AutoReadOnly
float                    Property XPMSELIB_VERSION      = 3.0 AutoReadOnly


int Property MAX_PRESETS = 4 AutoReadOnly
int Property MAX_MORPHS = 19 AutoReadOnly

Bool Property isNiOInstalled Auto
Bool Property isSlifInstalled Auto


;------------------------------------------------------------------------------
Bool Function isInfected( Actor akActor )
	Bool isInfected = False

	; By order of complexity

	if (akActor && akActor.WornHasKeyword(_SLP_Parasite) )
		isInfected = True
	Endif

	Return isInfected
EndFunction


;------------------------------------------------------------------------------
Function ApplyBodyChange(Actor kActor, String sParasite, String sBodyPart, Float fValue=1.0, Float fValueMax=1.0)
  	ActorBase pActorBase = kActor.GetActorBase()
 	Actor PlayerActor = Game.GetPlayer()
  	String NiOString = "SLP_" + sParasite

	if ( isNiOInstalled  )  

		Debug.Trace("[SLP]Receiving body change: " + sBodyPart)
		Debug.Trace("[SLP] 	Node string: " + sParasite)
		Debug.Trace("[SLP] 	Max node: " + fValueMax)

 		if (!isSlifInstalled)
			if (fValue < 1.0)
				fValue = 1.0     ; NiO node is reset with value of 1.0 - not 0.0!
			Endif		

			if (fValue > fValueMax)
				fValue = fValueMax
			Endif
		Endif

		If (StorageUtil.GetIntValue(none, "_SLH_iHormones")!=1) && (kActor == PlayerActor)

			if ( sBodyPart == "Breast"  )
				StorageUtil.SetFloatValue(kActor, "_SLH_fBreast", fValue )  

			elseif ( sBodyPart == "Belly"  )
				StorageUtil.SetFloatValue(kActor, "_SLH_fBelly", fValue )  

			elseif ( sBodyPart == "Butt"  )
				StorageUtil.SetFloatValue(kActor, "_SLH_fButt", fValue )
				  
			elseif ( sBodyPart == "Schlong"  )
				StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong", fValue )  
			endif

			kActor.SendModEvent("SLHRefresh")

		else

			if (( sBodyPart == "Breast"  ) && (pActorBase.GetSex()==1)) ; Female change
				Debug.Trace("[SLP]    Applying breast change: " + NiOString)
				Debug.Trace("[SLP]    Value: " + fValue)

				if (isSlifInstalled)
					SLIF_inflateMax(kActor, "slif_breast", fValue, fValueMax, NiOString)
				else
					XPMSELib.SetNodeScale(kActor, true, NINODE_LEFT_BREAST, fValue, NiOString)
					XPMSELib.SetNodeScale(kActor, true, NINODE_RIGHT_BREAST, fValue, NiOString)
				Endif

			Elseif (( sBodyPart == "Belly"  ) && (pActorBase.GetSex()==1)) ; Female change
				Debug.Trace("[SLP]    Applying belly change: " + NiOString)
				Debug.Trace("[SLP]    Value: " + fValue)

				if (isSlifInstalled)
					SLIF_inflateMax(kActor, "slif_belly", fValue, fValueMax, NiOString)
				else
					XPMSELib.SetNodeScale(kActor, true, NINODE_BELLY, fValue, NiOString)
				Endif


			Elseif (( sBodyPart == "Butt"  )) 
				Debug.Trace("[SLP]    Applying butt change: " + NiOString)
				Debug.Trace("[SLP]    Value: " + fValue)

				if (isSlifInstalled)
					SLIF_inflateMax(kActor, "slif_butt", fValue, fValueMax, NiOString)
				else
					XPMSELib.SetNodeScale(kActor, pActorBase.GetSex(), NINODE_LEFT_BUTT, fValue, NiOString)
					XPMSELib.SetNodeScale(kActor, pActorBase.GetSex(), NINODE_RIGHT_BUTT, fValue, NiOString)
				Endif


			Elseif (( sBodyPart == "Schlong"  ) ) 
				Debug.Trace("[SLP]    Applying schlong change: " + NiOString)
				Debug.Trace("[SLP]    Value: " + fValue)

				if (isSlifInstalled)
					SLIF_inflateMax(kActor, "slif_schlong", fValue, fValueMax, NiOString)
				else
					XPMSELib.SetNodeScale(kActor, pActorBase.GetSex(), NINODE_SCHLONG, fValue, NiOString)
				Endif

			Endif
		endif
	Else
		; Debug.Notification("[SLP]Receiving body change: NiO not installed")

	EndIf

EndFunction

; -------------------------------------------------------
Bool Function checkIfSpider ( Actor akActor )
	Bool bIsSpider = False
	ActorBase akActorBase = akActor.GetLeveledActorBase() as ActorBase
	Race actorRace = akActorBase.GetRace()
	Actor kPlayer = Game.GetPlayer()
	; Race _SD_Race_FalmerFrozen = StorageUtil.GetFormValue(None, "_SD_Race_FalmerFrozen") as Race

	if (akActor) && (akActor != kPlayer)
		if (StorageUtil.GetIntValue( akActor, "_SLP_iDateSpiderRaceChecked")==0)
			StorageUtil.SetIntValue( akActor, "_SLP_iDateSpiderRaceChecked", Game.QueryStat("Days Passed"))

			Debug.Trace("[SLP]       actorRace.GetName(): " + actorRace.GetName())
			Debug.Trace("[SLP]       actorRace.GetName(): " + actorRace.GetName())

			bIsSpider = (actorRace == SpiderRace ) || (actorRace == SpiderLargeRace ) || (StringUtil.Find(actorRace.GetName(),"Spider")!= -1)

			StorageUtil.SetIntValue( akActor, "_SD_bIsSpider", bIsSpider as Int) 
		else
			bIsSpider = StorageUtil.GetIntValue( akActor, "_SD_bIsSpider") as Bool
		endIf
	EndIf
	
	Return bIsSpider
EndFunction

Bool Function checkIfChaurus ( Actor akActor )
	Bool bIsChaurus = False
	ActorBase akActorBase = akActor.GetLeveledActorBase() as ActorBase
	Race actorRace = akActorBase.GetRace()
	Actor kPlayer = Game.GetPlayer()
	; Race _SD_Race_FalmerFrozen = StorageUtil.GetFormValue(None, "_SD_Race_FalmerFrozen") as Race

	if (akActor) && (akActor != kPlayer)
		if (StorageUtil.GetIntValue( akActor, "_SLP_iDateChaurusRaceChecked")==0)
			StorageUtil.SetIntValue( akActor, "_SLP_iDateChaurusRaceChecked", Game.QueryStat("Days Passed"))

			Debug.Trace("[SLP]       actorRace.GetName(): " + actorRace.GetName())

			bIsChaurus = (actorRace == ChaurusRace ) || (actorRace == ChaurusReaperRace ) || (StringUtil.Find(actorRace.GetName(), "Chaurus")!= -1)

			StorageUtil.SetIntValue( akActor, "_SD_bIsChaurus", bIsChaurus as Int) 
		else
			bIsChaurus = StorageUtil.GetIntValue( akActor, "_SD_bIsChaurus") as Bool
		endIf
	EndIf
	
	Return bIsChaurus
EndFunction

Bool Function checkIfSpriggan ( Actor akActor )
	Bool bIsSpriggan = False
	ActorBase akActorBase = akActor.GetLeveledActorBase() as ActorBase
	Race actorRace = akActorBase.GetRace()
	Actor kPlayer = Game.GetPlayer()

	if (akActor)  && (akActor != kPlayer)
		if (StorageUtil.GetIntValue( akActor, "_SLP_iDateSprigganRaceChecked")==0)
			StorageUtil.SetIntValue( akActor, "_SLP_iDateSprigganRaceChecked", Game.QueryStat("Days Passed"))

			Debug.Trace("[SLP]       actorRace.GetName(): " + actorRace.GetName())

			bIsSpriggan = ( (akActor.GetRace() == SprigganRace) || (akActor.GetRace() == SprigganMatronRace) || (akActor.GetRace() == SprigganEarthMotherRace) || (akActor.GetRace() == SprigganSwarmRace) || (akActor.GetRace() == SprigganBurntRace) || (StringUtil.Find(actorRace.GetName(), "Spriggan")!= -1) )

			StorageUtil.SetIntValue( akActor, "_SD_bIsSpriggan", bIsSpriggan as Int) 
		else
			bIsSpriggan = StorageUtil.GetIntValue( akActor, "_SD_bIsSpriggan") as Bool
		endIf
	EndIf
	
	Return bIsSpriggan
EndFunction

Bool Function checkIfSpiderFaction ( Actor akActor )
	return akActor.IsInFaction(SpiderFaction)
EndFunction

Bool Function checkIfChaurusFaction ( Actor akActor )
	return akActor.IsInFaction(ChaurusFaction)
EndFunction

Bool Function checkIfSprigganFaction ( Actor akActor )
	return akActor.IsInFaction(SprigganFaction)
EndFunction


;------------------------------------------------------------------------------

Bool function isFemale(actor kActor)
	return (kActor.GetActorBase().GetSex() == 1)
EndFunction

Bool function isMale(actor kActor)
	return !isFemale(kActor)
EndFunction

;------------------------------------------------------------------------------
bool function isPregnantByEstrusChaurus(actor kActor)
  spell  ChaurusBreeder 
  if (StorageUtil.GetIntValue(none, "_SLS_isEstrusChaurusON") ==  1) 
  	ChaurusBreeder = StorageUtil.GetFormValue(none, "_SLS_getEstrusChaurusBreederSpell") as Spell
  	if (ChaurusBreeder != none)
    	return kActor.HasSpell(ChaurusBreeder)
    endif
  endIf
  return false
endFunction

bool function isEstrusChaurusON()
	if (StorageUtil.GetFormValue(none, "_SLS_getEstrusChaurusBreederSpell")!=none)
		return true
	else
		return false
	endif
endFunction

;------------------------------------------------------------------------------
function SLIF_inflate(Actor kActor, String sKey, float value, String NiOString)
	int SLIF_event = ModEvent.Create("SLIF_inflate")
	If (SLIF_event)
		ModEvent.PushForm(SLIF_event, kActor)
		ModEvent.PushString(SLIF_event, "SexLab Parasites")
		ModEvent.PushString(SLIF_event, sKey)
		ModEvent.PushFloat(SLIF_event, value)
		ModEvent.PushString(SLIF_event, NiOString)
		ModEvent.Send(SLIF_event)
	EndIf
endFunction

function SLIF_setMax(Actor kActor, String sKey, float maximum)
	int SLIF_event = ModEvent.Create("SLIF_setMax")
	If (SLIF_event)
		ModEvent.PushForm(SLIF_event, kActor)
		ModEvent.PushString(SLIF_event, "SexLab Parasites")
		ModEvent.PushString(SLIF_event, sKey)
		ModEvent.PushFloat(SLIF_event, maximum)
		ModEvent.Send(SLIF_event)
	EndIf	
endFunction

function SLIF_inflateMax(Actor kActor, String sKey, float value, float maximum, String NiOString)
	SLIF_setMax(kActor, sKey, maximum)
	SLIF_inflate(kActor, sKey, value, NiOString)
endFunction


;------------------------------------------------------------------------------
Function FalmerBlue(Actor kActor, Actor kTarget)
	If (StorageUtil.GetIntValue(none, "_SLH_iHormones")==1)
		Int iFalmerSkinColor = Math.LeftShift(255, 24) + Math.LeftShift(100, 16) + Math.LeftShift(200, 8) + 255
		Float breastMod = 0.05
		Float weightMod = 2.0

		FalmerBlueImod.Apply( )

		If (Utility.RandomInt(0,100)>60)
			Int randomNum = Utility.RandomInt(0,100)
			If (randomNum>80)
				Debug.MessageBox("Glowing fluids spread from the Falmer's skin across yours like quicksilver, making your nipples stiffen and tingle painfully with poisonous throbs. ")
				breastMod = 0.5
				weightMod = 15.0
				StorageUtil.SetIntValue(none, "_SLH_iForcedHairLoss", 1)
				kTarget.SendModEvent("SLHShaveHead")

			ElseIf (randomNum>60)
				Debug.MessageBox("The purpose of the glowing substance is clear to you now, fattening you up for breeding and turning you into an irresistible beacon for the Falmers and their pets.")
				breastMod = 0.25
				weightMod = 10.0
				StorageUtil.SetIntValue(none, "_SLH_iForcedHairLoss", 1)
				kTarget.SendModEvent("SLHShaveHead")

			ElseIf (randomNum>40)
				Debug.Notification("Your skin burns under glowing droplets.")
				breastMod = 0.1
				weightMod = 5.0

			ElseIf (randomNum>20)
				Debug.Notification("The tingling over your skin is driving you mad.")
				breastMod = 0.25
				weightMod = 2.0

			EndIf

		EndIf

		StorageUtil.SetIntValue(kTarget, "_SLH_iSkinColor", iFalmerSkinColor ) 
		StorageUtil.SetFloatValue(kTarget, "_SLH_fBreast", StorageUtil.GetFloatValue(kTarget, "_SLH_fBreast" ) + breastMod ) 
		StorageUtil.SetFloatValue(kTarget, "_SLH_fWeight", StorageUtil.GetFloatValue(kTarget, "_SLH_fWeight" ) + weightMod ) 
		kTarget.SendModEvent("SLHRefresh")
		kTarget.SendModEvent("SLHRefreshColors")


		if (Utility.RandomInt(0,100)>90)
			SendModEvent("SLHModHormoneRandom", "Chaurus", 1.0)
		else
			SendModEvent("SLHModHormone", "Growth", 5.0)
			SendModEvent("SLHModHormone", "Female", 10.0)
			SendModEvent("SLHModHormone", "Male", -5.0)

			if (isFemale(kTarget))
				SendModEvent("SLHModHormone", "Metabolism", -15.0)
				SendModEvent("SLHModHormone", "Lactation", 5.0)
				SendModEvent("SLHModHormone", "Fertility", 5.0)
			else
				SendModEvent("SLHModHormone", "Metabolism", 15.0)
			endif
		endif
	Endif	
EndFunction
;------------------------------------------------------------------------------

bool Function CheckXPMSERequirements(Actor akActor, bool isFemale)
	if (SKSE.GetPluginVersion("SKEE") >= SKEE_VERSION) ; SKEE detected - Skyrim SE
		return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && (SKSE.GetPluginVersion("SKEE") >= SKEE_VERSION && SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION) && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
	else
		return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
	endif
EndFunction

Function _resetParasiteSettings()
	Actor kPlayer = Game.GetPlayer()

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSpiderEgg", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSpiderEgg", 50.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxSpiderEgg", 2.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSpiderPenis", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSpiderPenis", 10.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusWorm", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusWorm", 10.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_buttMaxChaurusWorm", 2.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusWormVag", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusWormVag", 10.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxChaurusWormVag", 2.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleEstrusTentacles", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceEstrusTentacles", 10.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleTentacleMonster", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceTentacleMonster", 30.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_breastMaxTentacleMonster", 2.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleEstrusSlime", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceEstrusSlime", 10.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleLivingArmor", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceLivingArmor", 30.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_breastMaxLivingArmor", 2.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleFaceHugger", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceFaceHugger", 30.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceFaceHuggerGag", 30.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxFaceHugger", 2.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleBarnacles", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceBarnacles", 30.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootGag", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootGag", 10.0 )
	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootArms", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootArms", 20.0 )
	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootFeet", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootFeet", 30.0 )
	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSprigganRootBody", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSprigganRootBody", 50.0 )
EndFunction



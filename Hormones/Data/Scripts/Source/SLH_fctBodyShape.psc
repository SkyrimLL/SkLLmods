Scriptname SLH_fctBodyShape extends Quest  

Import Utility
Import Math

SLH_fctColor Property fctColor Auto
SLH_fctUtil Property fctUtil Auto
SLH_fctHormonesLevels Property fctHormones Auto

SOS_API _SOS

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
Bool  bTorpedoFixEnabled = True


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


Float fPregLeftBreast    = 1.0
Float fPregLeftBreast01  = 1.0
Float fPregRightBreast   = 1.0
Float fPregRightBreast01 = 1.0
Float fPregLeftButt      = 1.0
Float fPregRightButt     = 1.0
Float fPregBelly         = 1.0
Float fPregBreastMax      	= 15.0
Float fPregBellyMax       	= 15.0
Float fPregButtMax       	= 15.0 

; Float fBreast       	= 0.0
; Float fButt       		= 0.0
; Float fBelly       		= 0.0
; Float fSchlong      	= 0.0
; Float fWeight 			= 0.0
Float fHeight 			= 0.0
 
; float fBreastSwellMod    = 0.0
; float fButtSwellMod      = 0.0
; float fBellySwellMod      = 0.0
; float fWeightSwellMod    = 0.0
; Float fSchlongSwellMod = 1.0

; Float fBreastMax      	= 3.0
; Float fBellyMax       	= 2.4
; Float fButtMax       	= 2.0
; Float fSchlongMax 		= 3.0
; Float fWeightMax 		= 100.0

; Float fBreastMin      	= 0.8
; Float fBellyMin       	= 0.9
; Float fButtMin       	= 0.9
; Float fSchlongMin 		= 0.9
; Float fWeightMin 		= 0.0

; Float fArmorMod = 0.5
; Float fClothingMod = 0.8

; Float fSwellFactor	     = 0.0
Float fGameTime          = 0.0
Float fGrowthLastMsg  = 0.0

Int iGameDateLastSex   
Int iDaysSinceLastSex   
Int iOrgasmsCountToday   = 0
Int iOrgasmsCountAll   	= 0
Int iSexCountToday   	= 0
Int iSexCountAll   		= 0
Int iOralCountToday   	= 0
Int iAnalCountToday   	= 0
Int iVaginalCountToday   = 0
; Int iSuccubus = 0
Int iDaedricInfluence  = 0
Int iSexStage  = 0

; Race kOrigRace = None

GlobalVariable 		Property SLH_Libido  				Auto  

GlobalVariable 		Property SLH_OrigWeight  Auto  

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
GlobalVariable      Property GV_heightValue 			Auto

GlobalVariable      Property GV_useColors 				Auto

GlobalVariable      Property GV_useNodes 				Auto
GlobalVariable      Property GV_useBreastNode 			Auto
GlobalVariable      Property GV_useButtNode 			Auto
GlobalVariable      Property GV_useBellyNode 			Auto
GlobalVariable      Property GV_useSchlongNode 			Auto

GlobalVariable      Property GV_useHeight 				Auto
GlobalVariable      Property GV_useWeight 				Auto
GlobalVariable      Property GV_enableNiNodeUpdate		Auto
GlobalVariable      Property GV_armorMod 				Auto
GlobalVariable      Property GV_clothMod	 			Auto

; ====================================================
; Deprecated global variables

; GlobalVariable      Property GV_sexActivityThreshold 	Auto
; GlobalVariable      Property GV_sexActivityBuffer 	 	Auto
; GlobalVariable      Property GV_baseSwellFactor 		Auto
; GlobalVariable      Property GV_baseShrinkFactor 		Auto
; GlobalVariable      Property GV_enableNiNodeOverride	Auto
; ====================================================

Sound Property SLH_MoanMarkerBreast  Auto
Sound Property SLH_MoanMarkerBelly  Auto
Sound Property SLH_MoanMarkerButt  Auto

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

Keyword Property ArmorOn  Auto  
Keyword Property ClothingOn  Auto  

Bool isNiOInstalled = false
Bool Property isSlifInstalled Auto

;-----------------------------------

SOS_API Property SOS
  SOS_API Function Get()
    If !_SOS
      _SOS = SOS_API.Get()
    EndIf
    Return _SOS
  EndFunction
EndProperty


Bool Function isSoSAPI()
	if (Game.GetFormFromFile(0x1eda4, "Schlongs of Skyrim.esp") != None)
		Return True
	Else
		Return False
	Endif
Endfunction

Bool Function isSchlongSet(Actor kActor)
	if !isSoSAPI()
		Return False
	Endif

	Return SOS.isSchlonged(kActor)
Endfunction

Function setSchlong(Actor kActor, string schlongLabel)
	Form schlong

	if !isSoSAPI()
		Return
	Endif

	if (schlongLabel == "Any") || (schlongLabel == "")
		; Get first addon available for now... add code to better select later
		schlong =  SOS_Data.GetAddon(0)
	else
		schlong = SOS.FindSchlongByName(schlongLabel)
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
Endfunction

Function removeSchlong(Actor kActor)
	if !isSoSAPI()
		Return
	Endif

	Form schlong = SOS.GetSchlong(kActor)
 
 	if (schlong != None)
    	SOS.RemoveSchlong(kActor)
    endIf
Endfunction

 
bool Function CheckXPMSERequirements(Actor akActor, bool isFemale)
	return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction

function SLIF_inflate(Actor kActor, String sKey, float value, String NiOString)
	int SLIF_event = ModEvent.Create("SLIF_inflate")
	If (SLIF_event)
		ModEvent.PushForm(SLIF_event, kActor)
		ModEvent.PushString(SLIF_event, "Hormones")
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
		ModEvent.PushString(SLIF_event, "Hormones")
		ModEvent.PushString(SLIF_event, sKey)
		ModEvent.PushFloat(SLIF_event, maximum)
		ModEvent.Send(SLIF_event)
	EndIf	
endFunction

function SLIF_inflateMax(Actor kActor, String sKey, float value, float maximum, String NiOString)
	SLIF_setMax(kActor, sKey, maximum)
	SLIF_inflate(kActor, sKey, value, NiOString)
endFunction

;----------------------------------
function alterBodyAfterRest(Actor kActor)
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	Race thisRace = pActorBase.GetRace()
	Bool bArmorOn = kActor.WornHasKeyword(ArmorOn)
	Bool bClothingOn = kActor.WornHasKeyword(ClothingOn)
	Int iSuccubus
	Float fNodeMax
	Bool bExternalChangeModActive = fctUtil.isExternalChangeModActive(kActor)
	Float fLibido = StorageUtil.GetFloatValue(kActor, "_SLH_fLibido")
	Int iSexActivityBuffer = StorageUtil.GetIntValue(kActor, "_SLH_iSexActivityBuffer")
	Int iSexActivityThreshold = StorageUtil.GetIntValue(kActor, "_SLH_iSexActivityThreshold")


	Float fBreastSwellMod   = StorageUtil.GetFloatValue(kActor, "_SLH_fBreastSwellMod")
	Float fButtSwellMod     = StorageUtil.GetFloatValue(kActor, "_SLH_fButtSwellMod")
	Float fBellySwellMod    = StorageUtil.GetFloatValue(kActor, "_SLH_fBellySwellMod")
	Float fSchlongSwellMod  = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongSwellMod")
	Float fWeightSwellMod   = StorageUtil.GetFloatValue(kActor, "_SLH_fWeightSwellMod")
	Float fBreastMax      	= StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMax")
	Float fBellyMax       	= StorageUtil.GetFloatValue(kActor, "_SLH_fBellyMax")
	Float fButtMax       	= StorageUtil.GetFloatValue(kActor, "_SLH_fButtMax")
	Float fSchlongMax 		= StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMax")
	Float fWeightMax 		= StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMax")
	Float fBreastMin      	= StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMin")
	Float fBellyMin       	= StorageUtil.GetFloatValue(kActor, "_SLH_fBellyMin")
	Float fButtMin       	= StorageUtil.GetFloatValue(kActor, "_SLH_fButtMin")
	Float fSchlongMin 		= StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMin")
	Float fWeightMin 		= StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMin")

	Float fCurrentWeight
	Float fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")
	Float fBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")       
	Float fButt = StorageUtil.GetFloatValue(kActor, "_SLH_fButt")       	
	Float fBelly = StorageUtil.GetFloatValue(kActor, "_SLH_fBelly")       		
	Float fSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")      			

	Float fSwellfactor = StorageUtil.GetFloatValue(kActor, "_SLH_fSwellFactor") 
	Float fWeightGrowth 
	Float fBreastGrowth 
	Float fButtGrowth 
	Float fBellyGrowth 
	Float fSchlongGrowth 

	Race kOrigRace = StorageUtil.GetFormValue(kActor, "_SLH_fOrigRace") as Race

	If (kOrigRace != None) 
		If (thisRace != kOrigRace)
			debugTrace("  Race change detected - aborting")
			return
		EndIf
	Else
		StorageUtil.SetFormValue(kActor, "_SLH_fOrigRace",thisRace) 
	EndIf

	fGameTime       = Utility.GetCurrentGameTime()
	
	iSexCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iSexCountToday") 
	iGameDateLastSex = StorageUtil.GetIntValue(kActor, "_SLH_iGameDateLastSex") 

	iOrgasmsCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iOrgasmsCountToday") 
	iOrgasmsCountAll = StorageUtil.GetIntValue(kActor, "_SLH_iOrgasmsCountAll") 
	iSexCountAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexCountAll") 
 	iOralCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iOralCountToday") 
	iAnalCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iAnalCountToday") 
	iVaginalCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iVaginalCountToday") 

	iDaysSinceLastSex = (Game.QueryStat("Days Passed") - iGameDateLastSex ) as Int
	StorageUtil.SetIntValue(kActor, "_SLH_iDaysSinceLastSex", iDaysSinceLastSex)

	iSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_iSuccubus") 
	iDaedricInfluence = StorageUtil.GetIntValue(kActor, "_SLH_iDaedricInfluence") 


	if (iSexCountToday < iSexActivityBuffer)
		; no body change if sex activity below buffer
		debugTrace("  no body change - sex activity below buffer")
		return
	endif

	if (iDaysSinceLastSex >= iSexActivityThreshold )
		; invert body changes if sex activity below threshold
		debugTrace("  invert body changes - sex activity below threshold")
		fWeightSwellMod = -1.0 * fWeightSwellMod
		fBreastSwellMod = -1.0 * fBreastSwellMod
		fButtSwellMod = -1.0 * fButtSwellMod
		fBellySwellMod = -1.0 * fBellySwellMod
		fSchlongSwellMod = -1.0 * fSchlongSwellMod
	endif

	if (GV_useWeight.GetValue() == 1)
		debug.trace( "[SLH] alterBodyAfterRest Weight")
		debugTrace( " Actorbase weight: " + pActorBase.GetWeight())
		; debugTrace( "[SLH] Current weight: " + fWeight)
		debugTrace( " StorageUtil: " + StorageUtil.GetFloatValue(kActor, "_SLH_fWeight") )
		debugTrace( " Global Value: " + GV_weightValue.GetValue() )

		; WEIGHT CHANGE ====================================================
		fCurrentWeight = pActorBase.GetWeight()

		if (fWeightSwellMod>=0)
			; (fWeightSwellMod>=0) means More Weight = More muscle
			fWeightGrowth = ( (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneGrowth") + abs(StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale") - StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMale")) ) / 20.0) * (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMetabolism") / 100.0)
		else
			; (fWeightSwellMod<0) means More Weight = More fat
			fWeightGrowth = ( (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneGrowth") + abs(StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale") - StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMale")) ) / 20.0) * ((100.0 - StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMetabolism")) / 100.0)

		endif
		fWeight = fCurrentWeight + (fWeightGrowth * ( fSwellFactor/ 100.0 ) * fWeightSwellMod)
		fWeight = fctUtil.fRange( fWeight  , fWeightMin, fWeightMax)

		; debug.notification("[SLH]   Weight growth: " + fWeightGrowth)
		debug.trace("[SLH]   Weight growth: " + fWeightGrowth)
		debug.trace("[SLH]   	fSwellFactor: " + fSwellFactor)
		debug.trace("[SLH]   	fWeightSwellMod: " + fWeightSwellMod)
		; debug.notification("[SLH]   Set weight to " + fWeight + " from " + fCurrentWeight )
		debug.trace("[SLH]   Set weight to " + fWeight + " from " + fCurrentWeight)
		alterWeight(kActor, fWeight  )

		; Debug.Notification("[SLH]  Set weight to " + fWeight + " from " + fCurrentWeight)

	EndIf

	If (fSwellFactor != 0) 
		; --------
		; BREAST SWELL ====================================================
		If ((iSexCountToday > 0) || (fSwellFactor < 0)) && (GV_useBreastNode.GetValue() == 1)
			if ( bBreastEnabled ) 
				Float fCurrentBreast 
				If (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
					fCurrentBreast = SLHGetNodeScale(kActor, NINODE_RIGHT_BREAST, false)
				else
					fCurrentBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")
				endIf

				if (bExternalChangeModActive) && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
					fNodeMax = fPregBreastMax
					fBreast = fCurrentBreast
				Else
					fNodeMax = fBreastMax
					fBreastGrowth = ( (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneGrowth") + StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale") ) / 200.0) * ((100.0 - StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMetabolism")) / 200.0) ; (fNodeMax + fBreastMin  - fCurrentBreast)  
					fBreast = fCurrentBreast + ( fBreastGrowth * ( fSwellFactor/ 100.0 ) * fBreastSwellMod )   
				EndIf

				debugTrace("  	fCurrentBreast:  " + fCurrentBreast)
				debugTrace("  		fBreastSwellMod:  " + fBreastSwellMod)
				; debug.notification("[SLH]  		fBreastGrowth:  " + fBreastGrowth)
				debugTrace("  		fBreastGrowth:  " + fBreastGrowth)
				debugTrace("  		fSwellFactor:  " + fSwellFactor)
				debugTrace("  		fNodeMax:  " + fNodeMax)
				debugTrace("  	fBreast:  " + fBreast)

				alterBreastNode(kActor,  fBreast )	

				if fGrowthLastMsg < fGameTime && fSwellFactor > 0
					fGrowthLastMsg = fGameTime + Utility.RandomFloat(0.0417, 0.25)

					; Debug.Notification(sSwellingMsgs[Utility.RandomInt(0, sSwellingMsgs.Length - 1)])
					If (fSwellFactor > 0)
							; Sound.SetInstanceVolume( SLH_MoanMarkerBreast.Play(kActor), 1.0 )
					EndIf
				endif				
			endif
		EndIf

		; BELLY SWELL =====================================================
		If ((iSexCountToday > 0) || (fSwellFactor < 0)) && (GV_useBellyNode.GetValue() == 1)
			if ( bBellyEnabled )  
				Float fCurrentBelly 
				If (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
					fCurrentBelly = SLHGetNodeScale(kActor, NINODE_BELLY, false)
				else
					fCurrentBelly = StorageUtil.GetFloatValue(kActor, "_SLH_fBelly")
				endIf

				if (bExternalChangeModActive) && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
					fNodeMax = fPregBellyMax
					fBelly = fCurrentBelly
				Else
					fNodeMax = fBellyMax
					fBellyGrowth = ( (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneGrowth") + StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMale") ) / 600.0) * ((100.0 - StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMetabolism")) / 200.0) ; (fNodeMax + fBellyMin - fCurrentBelly)  
					fBelly = fCurrentBelly + ( fBellyGrowth * ( fSwellFactor/ 100.0 ) * fBellySwellMod ) 
					; debug.notification("[SLH]  		fBellyGrowth:  " + fBellyGrowth)
					debugTrace("  		fBellyGrowth:  " + fBellyGrowth)
				EndIf
				
				alterBellyNode(kActor, fBelly )

			endif
		EndIf

		; BUTT SWELL ======================================================
		If ((iSexCountToday > 0) || (fSwellFactor < 0)) && (GV_useButtNode.GetValue() == 1)
			if ( bButtEnabled )  
				Float fCurrentButt 
				If (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
					fCurrentButt = SLHGetNodeScale(kActor, NINODE_RIGHT_BUTT, false)
				else
					fCurrentButt = StorageUtil.GetFloatValue(kActor, "_SLH_fButt")
				endIf

				if (bExternalChangeModActive) && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
					fNodeMax = fPregButtMax
					fButt = fCurrentButt
				Else
					fNodeMax = fButtMax
					fButtGrowth = ( (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneGrowth") + StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale") ) / 200.0) * ((100.0 - StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMetabolism")) / 200.0) ; (fNodeMax + fButtMin  - fCurrentButt)  
					; debug.notification("[SLH]  		fButtGrowth:  " + fButtGrowth)
					debugTrace("  		fButtGrowth:  " + fButtGrowth)
					fButt = fCurrentButt + ( fButtGrowth * ( fSwellFactor/ 100.0 ) * fButtSwellMod )   
				EndIf
				
				alterButtNode(kActor,  fButt )
			endif
		EndIf
	EndIf
	
	If (fSwellFactor != 0) && (GV_useNodes.GetValue() == 1)
		; Debug.Notification("SexLab Hormones: Male: Schlong updates: " + fSchlong )
		; SCHLONG SWELL ======================================================
		If  (iVaginalCountToday > 0) || (iAnalCountToday > 0) || (iOralCountToday > 0)  || (fSwellFactor < 0)
			; Debug.Notification("SexLab Hormones: Male: Schlong enabled: " + bEnableSchlong )

			if ( bEnableSchlong )   && (GV_useSchlongNode.GetValue() == 1)
				Float fCurrentSchlong 
				If (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
					fCurrentSchlong = NetImmerse.GetNodeScale(kActor, NINODE_SCHLONG, false)
				else
					fCurrentSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")
				endIf

				fSchlongGrowth = ( (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneGrowth") + StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMale") ) / 200.0) * (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMetabolism") / 200.0) ; (fSchlongMax + fSchlongMin  - fCurrentSchlong)  
				; debug.notification("[SLH]  		fSchlongGrowth:  " + fSchlongGrowth)
				debugTrace("  		fSchlongGrowth:  " + fSchlongGrowth)

				if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMale") < StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale"))
					fSchlongGrowth = -1.0 * fSchlongGrowth
				endIf

				fSchlong = fCurrentSchlong + ( fSchlongGrowth*  ( fSwellFactor/ 100.0 ) *  fSchlongSwellMod )

				alterSchlongNode(kActor,  fSchlong )
			endif
		EndIf
	EndIf
	
	; Imported from MME Morphs code - Double check if this needs to be here
	NiOverride.UpdateModelWeight(kActor)
	; StorageUtil.SetFloatValue(kActor, "_SLH_fSwellFactor",  fSwellFactor) 
 
	
 	; _refreshBodyShape()
 	; _applyBodyShapeChanges()




EndFunction

function alterBodyAfterSex(Actor kActor, Bool bOral = False, Bool bVaginal = False, Bool bAnal = False)
	if (bOral) || (bVaginal) || (bAnal)
		fctHormones.modHormoneLevel(kActor, "Pigmentation", 1.5)
		fctHormones.modHormoneLevel(kActor, "SexDrive", 10.0)
		fctHormones.modHormoneLevel(kActor, "Growth", 0.5)
	endIf

	alterBodyAfterRest(kActor)
EndFunction

function alterBodyByPercent(Actor kActor, String sBodyPart, Float modFactor)
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	Race thisRace = pActorBase.GetRace()
	Float fNodeMax
	Bool bExternalChangeModActive = fctUtil.isExternalChangeModActive(kActor)
	Float fLibido = StorageUtil.GetFloatValue(kActor, "_SLH_fLibido")
	Float fBreastSwellMod    = StorageUtil.GetFloatValue(kActor, "_SLH_fBreastSwellMod")
	Float fButtSwellMod      = StorageUtil.GetFloatValue(kActor, "_SLH_fButtSwellMod")
	Float fBellySwellMod      = StorageUtil.GetFloatValue(kActor, "_SLH_fBellySwellMod")
	Float fWeightSwellMod    = StorageUtil.GetFloatValue(kActor, "_SLH_fWeightSwellMod")
	Float fSchlongSwellMod = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongSwellMod")
	Float fBreastMax      	= StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMax")
	Float fBellyMax       	= StorageUtil.GetFloatValue(kActor, "_SLH_fBellyMax")
	Float fButtMax       	= StorageUtil.GetFloatValue(kActor, "_SLH_fButtMax")
	Float fSchlongMax 		= StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMax")
	Float fWeightMax 		= StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMax")
	Float fBreastMin      	= StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMin")
	Float fBellyMin       	= StorageUtil.GetFloatValue(kActor, "_SLH_fBellyMin")
	Float fButtMin       	= StorageUtil.GetFloatValue(kActor, "_SLH_fButtMin")
	Float fSchlongMin 		= StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMin")
	Float fWeightMin 		= StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMin")

	Float fCurrentWeight
	Float fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")
	Float fBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")       
	Float fButt = StorageUtil.GetFloatValue(kActor, "_SLH_fButt")       	
	Float fBelly = StorageUtil.GetFloatValue(kActor, "_SLH_fBelly")       		
	Float fSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")      			
	
	Race kOrigRace = StorageUtil.GetFormValue(kActor, "_SLH_fOrigRace") as Race

	
	If (kOrigRace != None) 
		If (thisRace != kOrigRace)
			debugTrace("  Race change detected - aborting")
			return
		EndIf
	Else
		StorageUtil.SetFormValue(kActor, "_SLH_fOrigRace",thisRace) 
	EndIf

	debugTrace( "alterBodyByPercent " + sBodyPart)
	debugTrace( "modFactor: " + modFactor)

	if (GV_useWeight.GetValue() == 1) && (sBodyPart=="Weight")
		; 2020-03-14 - force positive value of fWeightSwellMod - losing weight always means a decrease here
		; if (fWeightSwellMod<0)
		;	fWeightSwellMod = -1.0 * fWeightSwellMod
		; endif

		fCurrentWeight = pActorBase.GetWeight()

		debugTrace( "pActorBase.GetWeight(): " + fCurrentWeight)
		debugTrace( "fWeightSwellMod: " + fWeightSwellMod)
		debugTrace( "StorageUtil _SLH_fWeight: " + StorageUtil.GetFloatValue(kActor, "_SLH_fWeight") )
		; debugTrace( "Global Value: " + GV_weightValue.GetValue() )

		; WEIGHT CHANGE ====================================================
		fWeight = fCurrentWeight + ( (modFactor * fCurrentWeight) / 100.0 ) * fWeightSwellMod
		fWeight = fctUtil.fRange( fWeight  , fWeightMin, fWeightMax)

		debugTrace("  Set weight from " + fCurrentWeight + " to " + fWeight )
		alterWeight(kActor, fWeight  )

		; Debug.Notification(" Set weight to " + fWeight + " from " + fCurrentWeight)

	EndIf

	If (GV_useNodes.GetValue() == 1)
		; --------
		; BREAST SWELL ====================================================
		If  (sBodyPart=="Breast") && (GV_useBreastNode.GetValue() == 1)
			if ( bBreastEnabled ) 
				Float fCurrentBreast 
                If (StorageUtil.GetIntValue(none, "_SLH_BodyMorphsON")==1)
                    fCurrentBreast = SLHGetNodeScale(kActor, NINODE_RIGHT_BREAST, false)
                elseif (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
                    fCurrentBreast = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BREAST, false)
                else
                    fCurrentBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")
                endIf


				if (bExternalChangeModActive) && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
					fNodeMax = fPregBreastMax
					fBreast = fCurrentBreast
				Else
					fNodeMax = fBreastMax
					fBreast = ( fCurrentBreast + ( modFactor * fCurrentBreast) / 100.0 )    
				EndIf

				debugTrace("  	fCurrentBreast:  " + fCurrentBreast)
				debugTrace("  		fBreastSwellMod:  " + fBreastSwellMod)
				debugTrace("  		fSwellFactor:  " + modFactor)
				debugTrace("  		fNodeMax:  " + fNodeMax)
				debugTrace("  	fBreast:  " + fBreast)

				alterBreastNode(kActor,  fBreast )	
 			
			endif
		EndIf

		; BELLY SWELL =====================================================
		If (sBodyPart=="Belly")  && (GV_useBellyNode.GetValue() == 1)
			if ( bBellyEnabled )  
				Float fCurrentBelly 
                If (StorageUtil.GetIntValue(none, "_SLH_BodyMorphsON")==1)
                    fCurrentBelly = SLHGetNodeScale(kActor, NINODE_BELLY, false)
                elseif (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
                    fCurrentBelly = NetImmerse.GetNodeScale(kActor, NINODE_BELLY, false)
                else
                    fCurrentBelly = StorageUtil.GetFloatValue(kActor, "_SLH_fBelly")
                endIf

				if (bExternalChangeModActive) && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
					fNodeMax = fPregBellyMax
					fBelly = fCurrentBelly
				Else
					fNodeMax = fBellyMax
					fBelly = (fCurrentBelly + ( modFactor * fCurrentBelly) / 100.0 )
				EndIf
				
				alterBellyNode(kActor, fBelly )

			endif
		EndIf

		; BUTT SWELL ======================================================
		If (sBodyPart=="Butt")  && (GV_useButtNode.GetValue() == 1)
			if ( bButtEnabled )  
				Float fCurrentButt 
                If (StorageUtil.GetIntValue(none, "_SLH_BodyMorphsON")==1)
                    fCurrentButt = SLHGetNodeScale(kActor, NINODE_RIGHT_BUTT, false)
                elseif (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
                    fCurrentButt = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BUTT, false)
                else
                    fCurrentButt = StorageUtil.GetFloatValue(kActor, "_SLH_fButt")
                endIf

				if (bExternalChangeModActive) && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
					fNodeMax = fPregButtMax
					fButt = fCurrentButt
				Else
					fNodeMax = fButtMax
					fButt = ( fCurrentButt + ( modFactor * fCurrentButt) / 100.0 )  
				EndIf
				
				alterButtNode(kActor,  fButt )
			endif
		EndIf

		If (sBodyPart=="Schlong") && (GV_useSchlongNode.GetValue() == 1)
			; Debug.Notification("SexLab Hormones: Male: Schlong updates: " + fSchlong )
			; SCHLONG SWELL ======================================================
	 
			if ( bEnableSchlong )  
				Float fCurrentSchlong 
				If (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
					fCurrentSchlong = NetImmerse.GetNodeScale(kActor, NINODE_SCHLONG, false)
				else
					fCurrentSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")
				endIf

				; if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMale") < StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale"))
				;	modFactor = -1.0 * modFactor
				; endIf
				
				fSchlong = ( fCurrentSchlong + ( modFactor * fCurrentSchlong) / 100.0 )  

				alterSchlongNode(kActor,  fSchlong )
			endif
	 
		EndIf
	EndIf
	
	; Imported from MME Morphs code - Double check if this needs to be here
	NiOverride.UpdateModelWeight(kActor)
	; StorageUtil.SetFloatValue(kActor, "_SLH_fSwellFactor",  modFactor) 
 
EndFunction

Bool function detectShapeChange(Actor kActor)
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	Race thisRace = pActorBase.GetRace()
	Float fApparelMod = 1.0
 	Bool bArmorOn = kActor.WornHasKeyword(ArmorOn)
	Bool bClothingOn = kActor.WornHasKeyword(ClothingOn)
	Float deltaChange = 0.1


	Race kOrigRace = StorageUtil.GetFormValue(kActor, "_SLH_fOrigRace") as Race

	If (bArmorOn)
		fApparelMod = GV_armorMod.GetValue() as Float
	ElseIf (bClothingOn)
		fApparelMod = GV_clothMod.GetValue() as Float
	EndIf

	if (fApparelMod==0.0)
		fApparelMod = 0.1
	Endif
	
	If (kOrigRace != None) 
		If (thisRace != kOrigRace)
			debugTrace("  Race change detected - aborting")
			return False
		EndIf
	Else
		StorageUtil.SetFormValue(kActor, "_SLH_fOrigRace",thisRace) 
	EndIf

	Float fCurrentBreast       = SLHGetNodeScale(kActor, NINODE_RIGHT_BREAST, false) / fApparelMod
	Float fCurrentButt       = SLHGetNodeScale(kActor, NINODE_RIGHT_BUTT, false) / fApparelMod
	Float fCurrentBelly       = SLHGetNodeScale(kActor, NINODE_BELLY, false) / fApparelMod
	Float fCurrentSchlong       = NetImmerse.GetNodeScale(kActor, NINODE_SCHLONG, false)
	Float fCurrentWeight = pActorBase.GetWeight()

	Bool changeDetected = False
	Bool changeBreastDetected = False
	Bool changeBellyDetected = False
	Bool changeButtDetected = False
	Bool changeSchlongDetected = False
	Bool changeWeightDetected = False

	If (GV_useWeight.GetValue() == 1)
		If ((Math.abs(fCurrentWeight - StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")) > deltaChange) ) && (fCurrentWeight != StorageUtil.GetFloatValue(kActor, "_SLH_fWeightNode"))
			changeWeightDetected = True
		Endif
	endif

	If (GV_useNodes.GetValue() == 1)
		If (GV_useBreastNode.GetValue() == 1) && (Math.abs(fCurrentBreast - StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")) > deltaChange) && (fCurrentBreast != StorageUtil.GetFloatValue(kActor, "_SLH_fBreastNode"))
			changeBreastDetected = True
		Endif

		If (GV_useBellyNode.GetValue() == 1) && (Math.abs(fCurrentButt - StorageUtil.GetFloatValue(kActor, "_SLH_fButt"))  > deltaChange) && (fCurrentButt != StorageUtil.GetFloatValue(kActor, "_SLH_fButtNode"))
			changeBellyDetected = True
		Endif

		If (GV_useButtNode.GetValue() == 1) && (Math.abs(fCurrentBelly - StorageUtil.GetFloatValue(kActor, "_SLH_fBelly"))  > deltaChange) && (fCurrentBelly != StorageUtil.GetFloatValue(kActor, "_SLH_fBellyNode"))
			changeButtDetected = True
		Endif

		If (GV_useSchlongNode.GetValue() == 1) && (Math.abs(fCurrentSchlong - StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong"))  > deltaChange) && (fCurrentSchlong != StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongNode"))
			changeSchlongDetected = True
		Endif

	endIf


	If ( changeWeightDetected || changeBreastDetected || changeBellyDetected || changeButtDetected || changeSchlongDetected )

		changeDetected = True

		debugTrace("  -- External shape change detected " )
		debugTrace("  	Breast change " + fCurrentBreast + " from " + StorageUtil.GetFloatValue(kActor, "_SLH_fBreast") )
		debugTrace("  	Butt change " + fCurrentButt + " from " + StorageUtil.GetFloatValue(kActor, "_SLH_fButt") )
		debugTrace("  	Belly change " + fCurrentBelly + " from " + StorageUtil.GetFloatValue(kActor, "_SLH_fBelly") )
		debugTrace("  	Schlong change " + fCurrentSchlong + " from " + StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong") )

		StorageUtil.SetFloatValue(kActor, "_SLH_fBreastNode", fCurrentBreast)
		StorageUtil.SetFloatValue(kActor, "_SLH_fBellyNode", fCurrentBelly)
		StorageUtil.SetFloatValue(kActor, "_SLH_fButtNode", fCurrentButt)
		StorageUtil.SetFloatValue(kActor, "_SLH_fSchlongNode", fCurrentSchlong)
		StorageUtil.SetFloatValue(kActor, "_SLH_fWeightNode", fCurrentWeight)

	EndIf

	return changeDetected
EndFunction

function alterWeight(Actor kActor, float fNewWeight = 0.0)		
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
 
	; Float fWeightSwellMod    = StorageUtil.GetFloatValue(kActor, "_SLH_fWeightSwellMod")
	Float fWeightMax 		= StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMax")
	Float fWeightMin 		= StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMin")
 
	Float fWeight = fctUtil.fRange(fNewWeight, fWeightMin, fWeightMax)
	Float fWeightOrig = pActorBase.GetWeight()


	Float fManualWeightChange = StorageUtil.GetFloatValue(kActor, "_SLH_fManualWeightChange") 

	If (StorageUtil.GetIntValue(none, "_SLH_iHormonesSleepInit")==0)
		; Mod Init safety - sleep first
		Return
	Endif

	if (fManualWeightChange != -1)
	 	debugTrace(" Weight inconsistency - maybe after showracemenu? " + fManualWeightChange)
		StorageUtil.SetFloatValue(kActor, "_SLH_fManualWeightChange",  -1) 

		fWeightOrig = fManualWeightChange
		; 	StorageUtil.SetFloatValue(kActor, "_SLH_fWeight", fWeightOrig)
	EndIf

	if (fWeightOrig != fWeight) 
		Float NeckDelta = (fWeightOrig / 100) - (fWeight / 100) ;Work out the neckdelta.

		debugTrace(" Old weight: " + fWeightOrig)
		debugTrace(" New weight: " + fWeight)
		debugTrace(" NeckDelta: " + NeckDelta)
	 
		pActorBase.SetWeight(fWeight) 
		kActor.UpdateWeight(NeckDelta) ;Apply the changes.

		GV_weightValue.SetValue(fWeight)
		StorageUtil.SetFloatValue(kActor, "_SLH_fWeight",  fWeight)
	EndIf

 
EndFunction

function alterBreastNode(Actor kActor, float fNewBreast = 0.0)				
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	Float fNodeMax

	Float fBreastSwellMod    = StorageUtil.GetFloatValue(kActor, "_SLH_fBreastSwellMod")
	Float fBreastMax      	= StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMax")
	Float fBreastMin      	= StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMin")

	Float fApparelMod = 1.0
	Bool bArmorOn = kActor.WornHasKeyword(ArmorOn)
	Bool bClothingOn = kActor.WornHasKeyword(ClothingOn)

	If (StorageUtil.GetIntValue(none, "_SLH_iHormonesSleepInit")==0)
		; Mod Init safety - sleep first
		Return
	Endif

	If (bArmorOn)
		fApparelMod = GV_armorMod.GetValue() as Float
	ElseIf (bClothingOn)
		fApparelMod = GV_clothMod.GetValue() as Float
	EndIf

	if (fApparelMod==0.0)
		fApparelMod = 0.1
	Endif

	; if bTorpedoFixEnabled
	; 	fPregLeftBreast01  = fPregLeftBreast01 * (fOrigLeftBreast / fPregLeftBreast)
	; 	fPregRightBreast01 = fPregRightBreast01 * (fOrigRightBreast / fPregRightBreast)
	; endIf

	; fPregLeftBreast = fctUtil.iMin(fPregLeftBreast, NINODE_MAX_SCALE)
	; fPregRightBreast = fctUtil.iMin(fPregRightBreast, NINODE_MAX_SCALE)

	; if bTorpedoFixEnabled
	; 	fPregLeftBreast01 = fctUtil.fMax(fPregLeftBreast01, NINODE_MIN_SCALE)
	; 	fPregRightBreast01 = fctUtil.fMax(fPregRightBreast01, NINODE_MIN_SCALE)
	; endif

	if (fctUtil.isExternalChangeModActive(kActor)) && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
		fNodeMax = fPregBreastMax
	Else
		fNodeMax = fBreastMax
	EndIf

	debugTrace("  Breast Old: " + StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")  + " New: " + fNewBreast + " Min: " + fBreastMin + " - Max: " + fNodeMax)

	; fBreast = fctUtil.fRange(fBreast, NINODE_MIN_SCALE), fNodeMax)
	Float fBreast = fctUtil.fRange(fNewBreast, fBreastMin, fNodeMax)
	GV_breastValue.SetValue(fBreast)
	StorageUtil.SetFloatValue(kActor, "_SLH_fBreast",  fBreast) 

	debugTrace("  Breast New: " + fBreast )
	
	fPregLeftBreast    = fBreast
	fPregRightBreast   = fBreast


	if (isSlifInstalled)
		SLIF_inflateMax(kActor, "slif_breast", fPregLeftBreast * fApparelMod, fNodeMax, SLH_KEY)

	elseIf (StorageUtil.GetIntValue(none, "_SLH_BasicNetImmerseON")==1)
		NetImmerse.SetNodeScale( kActor, NINODE_LEFT_BREAST, fPregLeftBreast * fApparelMod, false)
		NetImmerse.SetNodeScale( kActor, NINODE_LEFT_BREAST, fPregLeftBreast * fApparelMod, true)

	elseIf (isNiOInstalled && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==1) )
		XPMSELib.SetNodeScale(kActor, fctUtil.isFemale(kActor), NINODE_LEFT_BREAST, fPregLeftBreast * fApparelMod, SLH_KEY)
		XPMSELib.SetNodeScale(kActor, fctUtil.isFemale(kActor), NINODE_RIGHT_BREAST, fPregRightBreast * fApparelMod, SLH_KEY)

	elseif (StorageUtil.GetIntValue(none, "_SLH_BodyMorphsON") == 1)
		SLHSetNodeScale( kActor, NINODE_RIGHT_BREAST, fPregRightBreast * fApparelMod, false)
		SLHSetNodeScale( kActor, NINODE_RIGHT_BREAST, fPregRightBreast * fApparelMod, true)	
	endIf
EndFunction

function alterBellyNode(Actor kActor, float fNewBelly = 0.0)				
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	Float fNodeMax

	Float fBellySwellMod      = StorageUtil.GetFloatValue(kActor, "_SLH_fBellySwellMod")
	Float fBellyMax       	= StorageUtil.GetFloatValue(kActor, "_SLH_fBellyMax")
	Float fBellyMin       	= StorageUtil.GetFloatValue(kActor, "_SLH_fBellyMin")

	Float fApparelMod = 1.0
	Bool bArmorOn = kActor.WornHasKeyword(ArmorOn)
	Bool bClothingOn = kActor.WornHasKeyword(ClothingOn)

	If (StorageUtil.GetIntValue(none, "_SLH_iHormonesSleepInit")==0)
		; Mod Init safety - sleep first
		Return
	Endif

	If (bArmorOn)
		fApparelMod = GV_armorMod.GetValue() as Float
	ElseIf (bClothingOn)
		fApparelMod = GV_clothMod.GetValue() as Float
	EndIf

	if (fApparelMod==0.0)
		fApparelMod = 0.1
	Endif
	

	if (fctUtil.isExternalChangeModActive(kActor)) && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
		fNodeMax = fPregBellyMax
	Else
		fNodeMax = fBellyMax
	EndIf

	debugTrace("  Belly Old: " + StorageUtil.GetFloatValue(kActor, "_SLH_fBelly")  + " New: " + fNewBelly + " Min: " + fBellyMin + " - Max: " + fNodeMax)

	; fPregBelly = fctUtil.iMin(fPregBelly, NINODE_MAX_SCALE * 2.0)
	Float fBelly = fctUtil.fRange(fNewBelly, fBellyMin, fNodeMax)
	GV_bellyValue.SetValue(fBelly)
	StorageUtil.SetFloatValue(kActor, "_SLH_fBelly",  fBelly) 
	
	debugTrace("  Belly New: " + fBelly )

	fPregBelly     = fBelly

	if (isSlifInstalled)
		SLIF_inflateMax(kActor, "slif_belly", fPregBelly * fApparelMod, fNodeMax, SLH_KEY)

	elseIf (StorageUtil.GetIntValue(none, "_SLH_BasicNetImmerseON")==1)
		NetImmerse.SetNodeScale( kActor, NINODE_BELLY, fPregBelly * fApparelMod, false)

	elseIf (isNiOInstalled && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==1) )
		XPMSELib.SetNodeScale(kActor, fctUtil.isFemale(kActor),  NINODE_BELLY, fPregBelly * fApparelMod, SLH_KEY) 
	
	elseif (StorageUtil.GetIntValue(none, "_SLH_BodyMorphsON") == 1)
		; kTarget.SetAnimationVariableFloat("ecBellySwell", fBellySwell)
		SLHSetNodeScale( kActor, NINODE_BELLY, fPregBelly * fApparelMod, false)
		SLHSetNodeScale( kActor, NINODE_BELLY, fPregBelly * fApparelMod, true)

	endIf
	; Debug.Notification("SexLab Hormones: Set Belly scale: " + fPregBelly)
EndFunction

function alterButtNode(Actor kActor, float fNewButt = 0.0)	
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	Float fNodeMax
		
	Float fButtSwellMod      = StorageUtil.GetFloatValue(kActor, "_SLH_fButtSwellMod")
	Float fButtMax       	= StorageUtil.GetFloatValue(kActor, "_SLH_fButtMax")
	Float fButtMin       	= StorageUtil.GetFloatValue(kActor, "_SLH_fButtMin")

	Float fApparelMod = 1.0
	Bool bArmorOn = kActor.WornHasKeyword(ArmorOn)
	Bool bClothingOn = kActor.WornHasKeyword(ClothingOn)

	If (StorageUtil.GetIntValue(none, "_SLH_iHormonesSleepInit")==0)
		; Mod Init safety - sleep first
		Return
	Endif

	If (bArmorOn)
		fApparelMod = GV_armorMod.GetValue() as Float
	ElseIf (bClothingOn)
		fApparelMod = GV_clothMod.GetValue() as Float
	EndIf

	if (fApparelMod==0.0)
		fApparelMod = 0.1
	Endif
	

	if (fctUtil.isExternalChangeModActive(kActor)) && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==0)
		fNodeMax = fPregButtMax
	Else
		fNodeMax = fButtMax
	EndIf

	debugTrace("  Butt Old: " + StorageUtil.GetFloatValue(kActor, "_SLH_fButt")  + " New: " + fNewButt + " Min: " + fButtMin + " - Max: " + fNodeMax)

	Float fButt = fctUtil.fRange(fNewButt, fButtMin, fNodeMax)
	GV_buttValue.SetValue(fButt)
	StorageUtil.SetFloatValue(kActor, "_SLH_fButt",  fButt) 

	debugTrace("  Butt New: " + fButt )

	fPregLeftButt = fButt
	fPregRightButt = fButt

	if (isSlifInstalled)
		SLIF_inflateMax(kActor, "slif_butt", fPregLeftButt * fApparelMod, fNodeMax, SLH_KEY)

	elseIf (StorageUtil.GetIntValue(none, "_SLH_BasicNetImmerseON")==1)
		NetImmerse.SetNodeScale( kActor, NINODE_LEFT_BUTT, fPregLeftButt * fApparelMod, false)
		NetImmerse.SetNodeScale( kActor, NINODE_LEFT_BUTT, fPregLeftButt * fApparelMod, true)


	elseIf (isNiOInstalled && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==1) )
		XPMSELib.SetNodeScale(kActor, fctUtil.isFemale(kActor),  NINODE_LEFT_BUTT, fPregLeftButt * fApparelMod, SLH_KEY) 
		XPMSELib.SetNodeScale(kActor, fctUtil.isFemale(kActor),  NINODE_RIGHT_BUTT, fPregRightButt * fApparelMod, SLH_KEY) 

	elseif (StorageUtil.GetIntValue(none, "_SLH_BodyMorphsON") == 1)
		SLHSetNodeScale( kActor, NINODE_RIGHT_BUTT, fPregRightButt * fApparelMod, false)
		SLHSetNodeScale( kActor, NINODE_RIGHT_BUTT, fPregRightButt * fApparelMod, true)

	endIf
EndFunction

function alterSchlongNode(Actor kActor, float fNewSchlong = 0.0)				
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
 
	Float fSchlongSwellMod = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongSwellMod")
	Float fSchlongMax 		= StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMax")
	Float fSchlongMin 		= StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMin")

	If (StorageUtil.GetIntValue(none, "_SLH_iHormonesSleepInit")==0)
		; Mod Init safety - sleep first
		Return
	Endif

	debugTrace("  Schlong Old: " + StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")  + " New: " + fNewSchlong + " Min: " + fSchlongMin + " - Max: " + fSchlongMax)

	Float fSchlong = fctUtil.fRange(fNewSchlong, fSchlongMin, fSchlongMax)
	GV_schlongValue.SetValue(fSchlong)
	StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong",  fSchlong) 

 	debugTrace("  Schlong New: " + fSchlong )

	if (isSlifInstalled)
		SLIF_inflateMax(kActor, "slif_schlong", fSchlong, fSchlongMax, SLH_KEY)

	elseif (StorageUtil.GetIntValue(none, "_SLH_BasicNetImmerseON")==1)
		NetImmerse.SetNodeScale( kActor, NINODE_SCHLONG, fSchlong, false)
		NetImmerse.SetNodeScale( kActor, NINODE_SCHLONG, fSchlong, true)

	elseIf (isNiOInstalled && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==1) )
		XPMSELib.SetNodeScale(kActor, fctUtil.isFemale(kActor), NINODE_SCHLONG, fSchlong , SLH_KEY)

	elseif (StorageUtil.GetIntValue(none, "_SLH_BodyMorphsON") == 1)
		XPMSELib.SetNodeScale(kActor, fctUtil.isFemale(kActor), NINODE_SCHLONG, fSchlong , SLH_KEY)

	endIf
EndFunction

function shaveHair ( Actor kActor)
 	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	ActorBase pLeveledActorBase = kActor.GetLeveledActorBase()
	Int   iPlayerGender = pLeveledActorBase.GetSex() as Int

	If (StorageUtil.GetIntValue(kActor, "_SLH_iUseHair") == 1) && (StorageUtil.GetIntValue(kActor, "_SLH_iUseHairColor") == 1)
		If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
			; YPS Fashion override if detected
			; See - http://www.loverslab.com/topic/56627-immersive-hair-growth-and-styling-yps-devious-immersive-fashion-v5/
			debugTrace("       -> YPS Fashion override")
			SendModEvent("yps-HaircutEvent", "", 2) ; shaved - bald
			StorageUtil.SetIntValue(kActor, "_SLH_iShavedHead", 1)

		elseIf (StorageUtil.GetIntValue(kActor, "_SLH_iUseHairLoss") == 1)
			Int Hair = pLeveledActorBase.GetNumHeadParts()
			Int i = 0
			While i < Hair
				If pLeveledActorBase.GetNthHeadPart(i).GetType() == 3
					hpHairCurrent = pLeveledActorBase.GetNthHeadPart(i)
					i = Hair
				EndIf
				i += 1
			EndWhile

			If (hpHairOrig == None)
				hpHairOrig = hpHairCurrent
			EndIf

			If (iPlayerGender==0) 
				If (hpHairCurrent != hpHairBaldM)
					kActor.ChangeHeadPart(hpHairBaldM)
					StorageUtil.SetIntValue(kActor, "_SLH_iShavedHead", 1)
					; Debug.Messagebox("Your rapid body changes force your hair to fall. " )
				Else
					; Game.ShowLimitedRaceMenu()
				EndIf

			Else
				If (hpHairCurrent != hpHairBaldF)
					kActor.ChangeHeadPart(hpHairBaldF)
					StorageUtil.SetIntValue(kActor, "_SLH_iShavedHead", 1)
					; Debug.Messagebox("Your rapid body changes force your hair to fall. ")
				Else
					; Game.ShowLimitedRaceMenu()
				EndIf

			EndIf

		EndIf

		StorageUtil.SetIntValue(kActor, "_SLH_iForcedHairLoss", 0) 

		debugTrace("       -> Forced hair change applied")
	Else
		debugTrace("       -> Forced hair change skipped (Hair change disabled)")
	Endif
 
EndFunction



function LoadFaceValues(Actor _targetActor, int[] _presets = None, float[] _morphs = None)
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

	_targetActor.RegenerateHead() ;Refresh the Player's head mesh.
EndFunction

function SaveFaceValues(Actor _targetActor, int[] _presets = None, float[] _morphs = None)
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

function refreshBodyShape(Actor kActor)
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	Race thisRace = pActorBase.GetRace()
	Float fNodeMax
	Bool bExternalChangeModActive = fctUtil.isExternalChangeModActive(kActor)

	Float fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")
	Float fBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")
	Float fBelly = StorageUtil.GetFloatValue(kActor, "_SLH_fBelly")
	Float fButt = StorageUtil.GetFloatValue(kActor, "_SLH_fButt")
	Float fSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")


;	Debug.Notification("SexLab Hormones: Refreshing body shape values")
;	Debug.Notification(".")
	debugTrace("  Refreshing body shape values")

	Race kOrigRace = StorageUtil.GetFormValue(kActor, "_SLH_fOrigRace") as Race

	
	If (kOrigRace != None) 
		If (thisRace != kOrigRace)
			debugTrace("  Race change detected - aborting")
			return
		EndIf
	Else
		StorageUtil.SetFormValue(kActor, "_SLH_fOrigRace",thisRace) 
	EndIf

	; Refreshing values in case of any external change from other mods
	; _getShapeState() needs to be called separately

	if (GV_useWeight.GetValue() == 1)
		debugTrace( "refreshBodyShape Weight")
		debugTrace( "	Actorbase weight: " + pActorBase.GetWeight())
		debugTrace( "	Current weight: " + fWeight)
		debugTrace( "	StorageUtil: " + StorageUtil.GetFloatValue(kActor, "_SLH_fWeight") )

		alterWeight(kActor,  fWeight  )
	else
		debugTrace( "refreshBodyShape Weight - Cancelled - GV_useWeight = 0")
	EndIf

	If (GV_useNodes.GetValue() == 1)
		debugTrace( "refreshBodyShape Values")
		; --------
		; BREAST SWELL ====================================================
		if ( bBreastEnabled )  && (GV_useBreastNode.GetValue() == 1)
			debugTrace( "    Breast")
			alterBreastNode(kActor,  fBreast )		
		else		
			debugTrace( "    Breast - Cancelled")
			debugTrace( "          bBreastEnabled: " + bBreastEnabled)
			debugTrace( "          GV_useBreastNode.GetValue(): " + GV_useBreastNode.GetValue())
		endif

		; BELLY SWELL =====================================================
		if ( bBellyEnabled )  && (GV_useBellyNode.GetValue() == 1) 
			debugTrace( "    Belly")
			alterBellyNode(kActor, fBelly  )
		else		
			debugTrace( "    Belly - Cancelled")
			debugTrace( "          bBellyEnabled: " + bBreastEnabled)
			debugTrace( "          GV_useBellyNode.GetValue(): " + GV_useBreastNode.GetValue())
		endif

		; BUTT SWELL ======================================================
		if ( bButtEnabled )   && (GV_useButtNode.GetValue() == 1)  
			debugTrace( "    Butt")
			alterButtNode(kActor,  fButt  )
		else		
			debugTrace( "    Butt - Cancelled")
			debugTrace( "          bButtEnabled: " + bBreastEnabled)
			debugTrace( "          GV_useButtNode.GetValue(): " + GV_useBreastNode.GetValue())
		endif

		; BUTT SWELL ======================================================
		if ( bSchlongEnabled )    && (GV_useSchlongNode.GetValue() == 1) 
			debugTrace( "    Schlong")
			alterSchlongNode(kActor,  fSchlong )
		else		
			debugTrace( "    Schlong - Cancelled")
			debugTrace( "          bSchlongEnabled: " + bBreastEnabled)
			debugTrace( "          GV_useSchlongNode.GetValue(): " + GV_useBreastNode.GetValue())
		endif

	else
		debugTrace( "refreshBodyShape Weight - Cancelled - GV_useNodes = 0")

	EndIf
	
	; Imported from MME Morphs code - Double check if this needs to be here
	NiOverride.UpdateModelWeight(kActor)


endFunction

function applyBodyShapeChanges(Actor kActor)
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	Race thisRace = pActorBase.GetRace()
 

	; Debug.Notification("SexLab Hormones: Applying body changes")
	debugTrace("  Applying body changes")

	Utility.Wait( 2.0 )

	if (!kActor) || (kActor == None)
		return
	endif

	; Wait until menu is closed
	while ( Utility.IsInMenuMode() )
		Utility.Wait( 2.0 )
	endWhile

	; 3d will not be loaded in some situations, such as werewolf transformations.
	; Skip body update if 3d not loaded or player is on mount or in combat

	; This should be set by carts and horses but the value is not properly cleared
	; (kActor.GetActorValue("Variable01")!= 0) ||  
	
	If ( !kActor.Is3DLoaded() || kActor.IsOnMount() || kActor.IsInCombat() || (kActorREF.GetCurrentScene()!=None) || kActor.IsWeaponDrawn() )
			debugTrace("  QueueNiNodeUpdate - bad conditions - aborting")
			debugTrace("             kActor: " + kActor)
			debugTrace("             kActor.Is3DLoaded(): " + kActor.Is3DLoaded())
			debugTrace("             kActor.IsOnMount(): " + kActor.IsOnMount())
			debugTrace("             kActor.GetActorValue('Variable01'): " + kActor.GetActorValue("Variable01"))
			debugTrace("             kActor.IsInCombat(): " + kActor.IsInCombat())
			debugTrace("             kActorREF.GetCurrentScene(): " + kActorREF.GetCurrentScene())
			debugTrace("             kActor.IsWeaponDrawn(): " + kActor.IsWeaponDrawn())
		return
	EndIf

	; Abort if race has changed (vampire lord or werewolf transformation)
	Race kOrigRace = StorageUtil.GetFormValue(kActor, "_SLH_fOrigRace") as Race

	
	If (kOrigRace != None) 
		If (thisRace != kOrigRace)
			debugTrace("  QueueNiNodeUpdate - Race change detected - aborting")
			return
		EndIf
	Else
		StorageUtil.SetFormValue(kActor, "_SLH_fOrigRace",thisRace) 
	EndIf

 	; If (StorageUtil.GetIntValue(none, "_SLH_NiNodeUpdateON") == 1)
	;	If ((GV_useNodes.GetValue() == 1) || (GV_useWeight.GetValue() == 1))

	; 2019-12-13 - Testing a forced QueueNiNodeUpdate to fully refresh shape and colors
			debugTrace("  QueueNiNodeUpdate")
			; debug.Notification("[SLH] QueueNiNodeUpdate")
			Utility.Wait(1.0)
			string facegen = "bUseFaceGenPreprocessedHeads:General"
			Utility.SetINIBool(facegen, false)
			; Game.GetPlayer().QueueNiNodeUpdate()
			kActor.QueueNiNodeUpdate()
			Utility.SetINIBool(facegen, true)
			Utility.Wait(1.0)

	;	Else
	;		debugTrace("  QueueNiNodeUpdate aborted - " + GV_useNodes.GetValue() + " - " +GV_useWeight.GetValue() )
	;	Endif	
	;EndIf
 
	; If (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==1)
		; If (GV_useWeight.GetValue() == 1)
			; debugTrace("  NiOverride.UpdateModelWeight")
			; NiOverride.UpdateModelWeight(kActor)
		; endif
	; endif

	Utility.Wait(1.0)
endFunction

function alterHeight(Actor kActor, float fNewHeight) 
	ObjectReference kActorREF = kActor as ObjectReference

	If (StorageUtil.GetIntValue(none, "_SLH_iHormonesSleepInit")==0)
		; Mod Init safety - sleep first
		Return
	Endif

	kActorREF.SetScale(fNewHeight)
	fHeight = fNewHeight
	StorageUtil.SetFloatValue(kActor, "_SLH_fHeight",  fHeight) 

EndFunction

; -------------------------------------------------------------------

Bool function trySuccubusEvent(Actor kActor) ; succubus corruption
	Bool bEventTriggered = False
	Int iSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_iSuccubus") 
	Int iBimbo = StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") 
	Int _allowSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_allowSuccubus")

	; --------
	; Male

	; --------
	; Female

	return 	bEventTriggered 
EndFunction

Bool function tryTGEvent(Actor kActor, float fHoursSleep) ; trans gender
	Bool bEventTriggered = False
	ActorBase pActorBase = kActor.GetActorBase()
	String sMessage = ""
	Int iSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_iSuccubus") 
	Int iBimbo = StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") 
	Int _allowTG = StorageUtil.GetIntValue(kActor, "_SLH_allowTG")
	Float fHormoneBimbo = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneBimbo" ) 	
	Float fHormoneMetabolism = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMetabolism" ) 	
	Float fHormoneSexDrive = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneSexDrive" ) 	
	Float fHormoneFemale = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale" ) 	
	Float fHormoneMale = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMale" ) 	
	Float fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")
	Float fBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")
	Float fBreastMax 		= StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMax")
	Float fBreastMin 		= StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMin")
	Float fSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")
	Float fSchlongMax 		= StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMax")
	Float fSchlongMin 		= StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMin")

	Int rollFirstPerson = Utility.RandomInt(0,100)

	if (_allowTG==0)	
		; Transformation disabled
		Return False
	endIf
	; --------
	; Male
	if (fctUtil.isMale(kActor))
		if (fHormoneFemale>=50.0) && (fHormoneMale>=50.0) && (fHormoneMetabolism>=50)
			debugTrace("	 TG transformation - stage 1 passed")
			If (rollFirstPerson <= (fHormoneBimbo as Int))
				sMessage = "I could swear I am losing weight!"
			else
				sMessage = "Hey.. you are losing weight!"
			Endif

			fctHormones.modHormoneLevel(kActor, "Metabolism", 2.0 * fHoursSleep) ; accelerate path to transformation
			fctHormones.modHormoneLevel(kActor, "Growth", -2.0 * fHoursSleep) ; make actor lose weight
			fctHormones.modHormoneLevel(kActor, "Male", 2.0 * fHoursSleep) ; accelerate path to transformation
			fctHormones.modHormoneLevel(kActor, "Female", 2.0 * fHoursSleep) ; accelerate path to transformation
			alterBodyByPercent(kActor, "Weight", -2.0 * fHoursSleep * (1.0 + (fHormoneMetabolism / 100.0)))
			fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")
		endif

		if (fHormoneFemale>=80.0) && (fHormoneMale>=80.0) && (fHormoneMetabolism>=80) && (fWeight < 10)  
			debugTrace("	 TG transformation - stage 2 passed")
			If (rollFirstPerson <= (fHormoneBimbo as Int))
				sMessage = "My cock! it's shrinking!"
			else
				sMessage = "Your cock is getting smaller every day."
			Endif
			alterBodyByPercent(kActor, "Schlong", -4.0 * fHoursSleep)
			
			fSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")
			if (fSchlong <= (fSchlongMin + 0.1) )
				debugTrace("	 TG transformation - stage 3 passed")
				If (rollFirstPerson <= (fHormoneBimbo as Int))
					sMessage = "My cock turned into a large clit!"
				else
					sMessage = "Your features have become decidedly female."
				Endif

				bEventTriggered = True
				fctHormones.modHormoneLevel(kActor, "Metabolism", -100.0) ; 

				; No TG option for male yet - will try later with SoS compatible vagina
				; For now, forcing a sex change to Female + Schlong

				; debugTrace("	 Casting HRT curse")
				; kActor.SendModEvent("SLHCastTGCurse", "Bimbo")
				kActor.SendModEvent("SLHCastTGCurse", "Bimbo")

			else
				debugTrace("	 Casting Sex change curse failed - Schlong not small enough")
				sMessage = sMessage + " Each night is filled with increasingly androgyne dreams and thoughts of cock turning into a beautiful vagina."
			endif
			 
		endif

	else
	; --------
	; Female 
		if (fHormoneFemale>=50.0) && (fHormoneMale>=50.0) && (fHormoneMetabolism>=50)
			debugTrace("	 TG transformation - stage 1 passed")
			If (rollFirstPerson <= (fHormoneBimbo as Int))
				sMessage = "Why am I feeling so hot!"
			else
				sMessage = "Your body is feverish and aching."
			Endif

			fctHormones.modHormoneLevel(kActor, "Metabolism", 2.0 * fHoursSleep) ; accelerate path to transformation
			fctHormones.modHormoneLevel(kActor, "Growth", -2.0 * fHoursSleep) ; make actor lose weight
			fctHormones.modHormoneLevel(kActor, "Male", 2.0 * fHoursSleep) ; accelerate path to transformation
			fctHormones.modHormoneLevel(kActor, "Female", 2.0 * fHoursSleep) ; accelerate path 

			alterBodyByPercent(kActor, "Weight", -2.0 * fHoursSleep * (1.0 + (fHormoneMetabolism / 100.0)))
			fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")	
		endIf

		if (fHormoneFemale>=90.0) && (fHormoneMale>=80.0) && (fHormoneMetabolism>=80) && (fWeight < 10)  
			debugTrace("	 TG transformation - stage 2 passed")
			If (rollFirstPerson <= (fHormoneBimbo as Int))
				sMessage = "Are my boobs shrinking?"
			else
				sMessage = "Your shape is getting flatter every day."
			Endif
			alterBodyByPercent(kActor, "Breast", -4.0 * fHoursSleep)
			alterBodyByPercent(kActor, "Butt", -4.0 * fHoursSleep)
			
			fBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast") 
			if (fBreast <= (fBreastMin + 1.0) )
				debugTrace("	 TG transformation - stage 3 passed")
				If (rollFirstPerson <= (fHormoneBimbo as Int))
					sMessage = "My Clit! It's growing into... a cock?"
				else
					sMessage = "Your clit is growing into a small size cock!"
				Endif

				bEventTriggered = True
				fctHormones.modHormoneLevel(kActor, "Metabolism", -100.0) ; 
				debugTrace("	 Casting TG curse")
				kActor.SendModEvent("SLHCastTGCurse", "Bimbo")
			else
				debugTrace("	 Casting TG curse failed - Breast not small enough")
				sMessage = sMessage + " Each night is filled with increasingly androgyne dreams and thoughts of flat chest and clit growing into a beautiful cock."
			endif
			 
		Endif
	endif

	If (sMessage != "")
		debug.MessageBox(sMessage + " (TG)")
	Endif

	return 	bEventTriggered 

EndFunction

Bool function tryHRTEvent(Actor kActor, float fHoursSleep) ; sex change
	Bool bEventTriggered = False
	ActorBase pActorBase = kActor.GetActorBase()
	String sMessage = ""
	Int iSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_iSuccubus") 
	Int iBimbo = StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") 
	Int _allowHRT = StorageUtil.GetIntValue(kActor, "_SLH_allowHRT")
	Float fHormoneBimbo = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneBimbo" ) 	
	Float fHormoneMetabolism = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMetabolism" ) 	
	Float fHormoneSexDrive = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneSexDrive" ) 	
	Float fHormoneFemale = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale" ) 	
	Float fHormoneMale = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMale" ) 	
	Float fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")
	Float fBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")
	Float fBreastMax 		= StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMax")
	Float fBreastMin 		= StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMin")
	Float fSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")
	Float fSchlongMax 		= StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMax")
	Float fSchlongMin 		= StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMin")


	Int rollFirstPerson = Utility.RandomInt(0,100)

	if (_allowHRT==0)	
		; Transformation disabled
		Return False
	endIf

	; --------
	; Male
	if (fctUtil.isMale(kActor))
		if (fHormoneFemale>=50.0) && (fHormoneMale<50.0) && (fHormoneMetabolism>=50.0)
			debugTrace("	 HRT (sex change) transformation - stage 1 passed")
			If (rollFirstPerson <= (fHormoneBimbo as Int))
				sMessage = "I could swear I am losing weight!"
			else
				sMessage = "Hey.. you are losing weight!"
			Endif

			fctHormones.modHormoneLevel(kActor, "Metabolism", 2.0 * fHoursSleep) ; accelerate path to transformation
			fctHormones.modHormoneLevel(kActor, "Growth", 2.0 * fHoursSleep) ; make actor lose weight
			fctHormones.modHormoneLevel(kActor, "Male", 2.0 * fHoursSleep) ; accelerate path to transformation
			fctHormones.modHormoneLevel(kActor, "Female", -2.0 * fHoursSleep) ; accelerate path 

			alterBodyByPercent(kActor, "Weight", -2.0 * fHoursSleep * (1.0 + (fHormoneMetabolism / 100.0)))
			fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")
		endif

		if (fHormoneFemale>=80.0) && (fHormoneMale<20.0) && (fHormoneMetabolism>=80) && (fWeight < 10)  
			debugTrace("	 HRT (sex change) transformation - stage 2 passed")
			If (rollFirstPerson <= (fHormoneBimbo as Int))
				sMessage = "My cock! it's shrinking!"
			else
				sMessage = "Your cock is getting smaller every day."
			Endif
			alterBodyByPercent(kActor, "Schlong", -4.0 * fHoursSleep)
			fctHormones.modHormoneLevel(kActor, "Growth", 4.0 * fHoursSleep) ; make breasts and butt larger
			
			fSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")
			if (fSchlong <= (fSchlongMin + 0.1) )
				debugTrace("	 HRT (sex change) transformation - stage 3 passed")
				If (rollFirstPerson <= (fHormoneBimbo as Int))
					sMessage = "Boobs? Clit! I turned into a woman!"
				else
					sMessage = "Your features have become decidedly female."
				Endif

				bEventTriggered = True
				fctHormones.modHormoneLevel(kActor, "Metabolism", -100.0 * fHoursSleep) ; 
				debugTrace("	 Casting HRT curse")
				kActor.SendModEvent("SLHCastHRTCurse", "Bimbo")
			else
				debugTrace("	 Casting Sex change curse failed - Schlong not small enough")
				sMessage = sMessage + " Each night is filled with increasingly feminine dreams and thoughts of cock turning into a beautiful vagina."
			endif
			 
		endif

	else
	; --------
	; Female
		if (fHormoneFemale<50.0) && (fHormoneMale>=50.0) && (fHormoneMetabolism>=50)
			debugTrace("	 HRT (sex change) transformation - stage 1 passed")
			If (rollFirstPerson <= (fHormoneBimbo as Int))
				sMessage = "I could swear I am losing weight!"
			else
				sMessage = "Hey.. you are losing weight!"
			Endif

			fctHormones.modHormoneLevel(kActor, "Metabolism", 2.0 * fHoursSleep) ; accelerate path to transformation
			fctHormones.modHormoneLevel(kActor, "Growth", -2.0 * fHoursSleep) ; make actor lose weight
			fctHormones.modHormoneLevel(kActor, "Male", -2.0 * fHoursSleep) ; accelerate path to transformation
			fctHormones.modHormoneLevel(kActor, "Female", 2.0 * fHoursSleep) ; accelerate path 

			alterBodyByPercent(kActor, "Weight", -2.0 * fHoursSleep)
			fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")	
		endIf

		if (fHormoneFemale<20.0) && (fHormoneMale>=80.0) && (fHormoneMetabolism>=80) && (fWeight < 10)  
			debugTrace("	 HRT (sex change) transformation - stage 2 passed")
			If (rollFirstPerson <= (fHormoneBimbo as Int))
				sMessage = "Are my boobs shrinking?"
			else
				sMessage = "Your shape is getting flatter every day."
			Endif
			alterBodyByPercent(kActor, "Breast", -4.0 * fHoursSleep)
			alterBodyByPercent(kActor, "Butt", -4.0 * fHoursSleep)
			
			fBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast") 

			if (fBreast <= (fBreastMin + 0.1) ) && (iBimbo == 0 ) ; no transformation to male if already a bimbo
				debugTrace("	 HRT (sex change) transformation - stage 3 passed")
				If (rollFirstPerson <= (fHormoneBimbo as Int))
					sMessage = "My Boobs! My Clit! I turned into a man!"
				else
					sMessage = "Your features have become decidedly male."
				Endif

				bEventTriggered = True
				fctHormones.modHormoneLevel(kActor, "Metabolism", -100.0) ; 
				debugTrace("	 Casting HRT curse")
				kActor.SendModEvent("SLHCastHRTCurse", "Bimbo")
			else
				debugTrace("	 Casting Sex change curse failed - Breast not small enough")
				sMessage = sMessage + " Each night is filled with increasingly masculine dreams and thoughts of flat chest and clit growing into a beautiful cock."
			endif
			 
		Endif
	endif

	If (sMessage != "")
		debug.MessageBox(sMessage + " (HRT)")
	Endif

	return 	bEventTriggered 
EndFunction

Bool function tryBimboEvent(Actor kActor, float fHoursSleep) ; bimbo curse
	Bool bEventTriggered = False
	ActorBase pActorBase = kActor.GetActorBase()
	String sMessage = ""
	Int iSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_iSuccubus") 
	Int iBimbo = StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") 
	Int _allowBimbo = StorageUtil.GetIntValue(kActor, "_SLH_allowBimbo")
	Float fHormoneBimbo = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneBimbo" ) 	
	Float fHormoneMetabolism = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMetabolism" ) 	
	Float fHormoneSexDrive = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneSexDrive" ) 	
	Float fHormoneFemale = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale" ) 	
	Float fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")
	Float fSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")
	Float fSchlongMax 		= StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMax")
	Float fSchlongMin 		= StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMin")

	Int rollFirstPerson = Utility.RandomInt(0,100)

	if (StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") == 1) || (_allowBimbo==0)	
		; Player already a bimbo or bimbo transformation disabled
		Return False
	endIf

	if (fHormoneBimbo>=30.0) && (fHormoneMetabolism>=70)
		debugTrace("	 Bimbo transformation - stage 1 passed")
		If (rollFirstPerson <= (fHormoneBimbo as Int))
			sMessage = "I'm so horny today."
		else
			sMessage = "You wake up horny."
		Endif

		; Enable bimbo thoughts
		StorageUtil.SetIntValue(kActor, "_SLH_iAllowBimboThoughts", 1)

		fctHormones.modHormoneLevel(kActor, "Metabolism", 2.0 * fHoursSleep) ; accelerate path to transformation
		fctHormones.modHormoneLevel(kActor, "Bimbo", 2.0 * fHoursSleep) ; accelerate path to transformation
		fctHormones.modHormoneLevel(kActor, "SexDrive", 4.0 * fHoursSleep) ; make actor hornier
		fctHormones.modHormoneLevel(kActor, "Growth", 1.0 * fHoursSleep) ; make breasts and butt larger
	endif

	if (fHormoneBimbo>=50.0) && (fHormoneMetabolism>=70)
		debugTrace("	 Bimbo transformation - stage 2 passed")
		If (rollFirstPerson <= (fHormoneBimbo as Int))
			sMessage = "Mmm.. I feel so soft and sexy."
		else
			sMessage = "You feel soft and sexy."
		Endif

		fctHormones.modHormoneLevel(kActor, "Female", 2.0 * fHoursSleep) ; make actor more feminine
		fctHormones.modHormoneLevel(kActor, "Male", -4.0 * fHoursSleep) ; 
		fctHormones.modHormoneLevel(kActor, "Bimbo", 2.0 * fHoursSleep) ; accelerate path to transformation
		fctHormones.modHormoneLevel(kActor, "Growth", 2.0 * fHoursSleep) ; make breasts and butt larger
	endIf
	
	if (fHormoneBimbo>=70.0) && (fHormoneMetabolism>=80)
		debugTrace("	 Bimbo transformation - stage 3 passed")
		If (rollFirstPerson <= (fHormoneBimbo as Int))
			sMessage = "I could swear I am losing weight!"
		else
			sMessage = "Hey.. you are losing weight!"
		Endif

		fctHormones.modHormoneLevel(kActor, "Growth", 4.0 * fHoursSleep) ; make actor lose weight
		alterBodyByPercent(kActor, "Weight", -4.0 * fHoursSleep * (1.0 + (fHormoneMetabolism / 100.0)))
		fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")	
	endIf
	
	if (fHormoneBimbo>=80.0) && (fHormoneMetabolism>=80)
		debugTrace("	 Bimbo transformation - stage 4 passed")
		If (rollFirstPerson <= (fHormoneBimbo as Int))
			sMessage = "Something is definitely happening to me."
		else
			sMessage = "Something is changing.. you can feel it."
		Endif

		if (fctUtil.isMale(kActor))
			if (fWeight < 20)
				If (rollFirstPerson <= (fHormoneBimbo as Int))
					sMessage = "My cock! it's shrinking!"
				else
					sMessage = "Your cock is getting smaller every day."
				Endif
				alterBodyByPercent(kActor, "Schlong", -4.0 * fHoursSleep)
			endif
		endif

	endIf
	
	if (fHormoneBimbo>=90.0) && (fHormoneMetabolism>=90)
		debugTrace("	 Bimbo transformation - stage 5 passed")
		if (fctUtil.isMale(kActor))
			fSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")
			if (fSchlong <= (fSchlongMin + 0.1) )
				If (rollFirstPerson <= (fHormoneBimbo as Int))
					sMessage = "Oh My Gods! What happened?"
				else
					sMessage = "Your body is going through deep changes."
				Endif

				bEventTriggered = True
				fctHormones.modHormoneLevel(kActor, "Metabolism", -100.0) ; 
				debugTrace("	 Casting Bimbo curse")
				kActor.SendModEvent("SLHCastBimboCurse","Bimbo")
			else
				debugTrace("	 Casting Bimbo curse failed - schlong not ready")
				sMessage = sMessage + " Each night is filled with increasingly pink bubbly dreams and thoughts of cock turning into a beautiful pussy."

			endif
		else
			if (Utility.RandomInt(0,100)<= (fHormoneBimbo as Int))
				If (rollFirstPerson <= (fHormoneBimbo as Int))
					sMessage = "Oh My Gods! What happened?"
				else
					sMessage = "Your body is going through deep changes."
				Endif
				
				bEventTriggered = True
				fctHormones.modHormoneLevel(kActor, "Metabolism", -100.0) ; 
				debugTrace("	 Casting Bimbo curse")
				kActor.SendModEvent("SLHCastBimboCurse","Bimbo")
			else
				debugTrace("	 Casting Bimbo curse failed - better luck next time")
				sMessage = sMessage + " Each night is filled with increasingly pink bubbly dreams and thoughts of cocks... yummy cocks everywhere!"

			endif
		endif
	endif

	If (sMessage != "")
		debug.MessageBox(sMessage + " (Bimbo)")
	Endif

	return 	bEventTriggered 
EndFunction








; -------------------------------------------------------------------
function initShapeConstants(Actor kActor)
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	ActorBase pLeveledActorBase = kActor.GetLeveledActorBase()

	debugTrace("  Init shape constants")

	; Modifiers for each part
	; fWeightSwellMod = GV_weightSwellMod.GetValue()   ; 5.0   

	; fBreastSwellMod = GV_breastSwellMod.GetValue()   ; 0.3 
	; fBellySwellMod = GV_bellySwellMod.GetValue()   ; 0.1 
	; fButtSwellMod = GV_buttSwellMod.GetValue()   ; 0.2 
	; fSchlongSwellMod = GV_schlongSwellMod.GetValue()   ; 0.2 
	; fWeightSwellMod = GV_weightSwellMod.GetValue()   ; 0.2 

	; Repair min-max constants if erased by accident
	If (GV_breastMin.GetValue() == GV_breastMax.GetValue())
		GV_breastMin.SetValue(0.8)
		GV_breastMax.SetValue(4.0)
		GV_breastSwellMod.SetValue(1.5)
	Endif
	If (GV_bellyMin.GetValue() == GV_bellyMax.GetValue())
		GV_bellyMin.SetValue(0.9)
		GV_bellyMax.SetValue(1.5)
		GV_bellySwellMod.SetValue(1.5)
	Endif
	If (GV_buttMin.GetValue() == GV_buttMax.GetValue())
		GV_buttMin.SetValue(0.9)
		GV_buttMax.SetValue(1.5)
		GV_buttSwellMod.SetValue(1.2)
	Endif
	If (GV_schlongMin.GetValue() == GV_schlongMax.GetValue())
		GV_schlongMin.SetValue(0.5)
		GV_schlongMax.SetValue(3.0)
		GV_schlongSwellMod.SetValue(1.2)
	Endif
	If (GV_weightMin.GetValue() == GV_weightMax.GetValue())
		GV_weightMin.SetValue(0.0)
		GV_weightMax.SetValue(100.0)
		GV_weightSwellMod.SetValue(-1.5)
	Endif



	StorageUtil.SetFloatValue(kActor, "_SLH_fBreastSwellMod",  GV_breastSwellMod.GetValue() as Float) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fButtSwellMod",  GV_buttSwellMod.GetValue()  as Float) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fBellySwellMod",  GV_bellySwellMod.GetValue()   as Float) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fSchlongSwellMod",  GV_schlongSwellMod.GetValue()  as Float) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fWeightSwellMod",  GV_weightSwellMod.GetValue()   as Float) 

	StorageUtil.SetFloatValue(kActor, "_SLH_fBreastMin",  GV_breastMin.GetValue() as Float) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fButtMin",  GV_buttMin.GetValue()  as Float) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fBellyMin",  GV_bellyMin.GetValue()   as Float) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fSchlongMin",  GV_schlongMin.GetValue()  as Float) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fWeightMin",  GV_weightMin.GetValue()   as Float) 

	StorageUtil.SetFloatValue(kActor, "_SLH_fBreastMax",  GV_breastMax.GetValue() as Float)
	StorageUtil.SetFloatValue(kActor, "_SLH_fButtMax",  GV_buttMax.GetValue()  as Float)
	StorageUtil.SetFloatValue(kActor, "_SLH_fBellyMax",  GV_bellyMax.GetValue() as Float)
	StorageUtil.SetFloatValue(kActor, "_SLH_fSchlongMax",  GV_schlongMax.GetValue()  as Float)
	StorageUtil.SetFloatValue(kActor, "_SLH_fWeightMax",  GV_weightMax.GetValue()   as Float)

	bEnableLeftBreast  = NetImmerse.HasNode(kActor, NINODE_LEFT_BREAST, false)
	bEnableRightBreast = NetImmerse.HasNode(kActor, NINODE_RIGHT_BREAST, false)
	bEnableLeftButt    = NetImmerse.HasNode(kActor, NINODE_LEFT_BUTT, false)
	bEnableRightButt   = NetImmerse.HasNode(kActor, NINODE_RIGHT_BUTT, false)
	bEnableBelly       = NetImmerse.HasNode(kActor, NINODE_BELLY, false)
	bEnableSchlong     = NetImmerse.HasNode(kActor, NINODE_SCHLONG, false)

	bBreastEnabled     = ( bEnableLeftBreast && bEnableRightBreast as bool )
	bButtEnabled       = ( bEnableLeftButt && bEnableRightButt  as bool )
	bBellyEnabled      = ( bEnableBelly  as bool )
	bSchlongEnabled     = ( bEnableSchlong as bool )


	isNiOInstalled =  CheckXPMSERequirements(kActor, fctUtil.isFemale(kActor))
	debugTrace("  NiOverride detection: " + isNiOInstalled)
	StorageUtil.SetIntValue(none, "_SLH_NiNodeOverrideON", isNiOInstalled as Int)

	isSlifInstalled = Game.GetModbyName("SexLab Inflation Framework.esp") != 255
	StorageUtil.SetIntValue(none, "_SLH_SlifON", isSlifInstalled as Int)

	; setShapeState(kActor)

endFunction

function initShapeState(Actor kActor)
	ObjectReference kActorREF = kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	ActorBase pLeveledActorBase = kActor.GetLeveledActorBase()
	

	if ( bBreastEnabled && pLeveledActorBase.GetSex() == 1 )
		;fOrigLeftBreast  = SLHGetNodeScale(kActor, NINODE_LEFT_BREAST, false)
		fOrigRightBreast = SLHGetNodeScale(kActor, NINODE_RIGHT_BREAST, false)
		;fPregLeftBreast  = fOrigLeftBreast
		fPregRightBreast = fOrigRightBreast
		StorageUtil.SetFloatValue(kActor, "_SLH_fBreast", fOrigRightBreast)
		if bTorpedoFixEnabled
			;fOrigLeftBreast01  = SLHGetNodeScale(kActor, NINODE_LEFT_BREAST01, false)
			fOrigRightBreast01 = SLHGetNodeScale(kActor, NINODE_RIGHT_BREAST01, false)
			;fPregLeftBreast01  = fOrigLeftBreast01
			fPregRightBreast01 = fOrigRightBreast01
		endif
	endif
	if ( bButtEnabled )
		;fOrigLeftButt    = SLHGetNodeScale(kActor, NINODE_LEFT_BUTT, false)
		fOrigRightButt   = SLHGetNodeScale(kActor, NINODE_RIGHT_BUTT, false)
		;fPregLeftButt    = fOrigLeftButt
		fPregRightButt   = fOrigRightButt
		StorageUtil.SetFloatValue(kActor, "_SLH_fButt", fOrigRightButt)
	endif
	if ( bBellyEnabled )
		fOrigBelly       = SLHGetNodeScale(kActor, NINODE_BELLY, false)
		fPregBelly       = fOrigBelly  
		StorageUtil.SetFloatValue(kActor, "_SLH_fBelly", fOrigBelly)
	endif		
	if ( bSchlongEnabled )
		fOrigSchlong       = NetImmerse.GetNodeScale(kActor, NINODE_SCHLONG, false) 
		StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong", fOrigSchlong)
	endif		

	Int Eye = pLeveledActorBase.GetNumHeadParts()
	Int i = 0
	While i < Eye
		If pLeveledActorBase.GetNthHeadPart(i).GetType() == 2
			hpEyesOrig = pLeveledActorBase.GetNthHeadPart(i)
			i = Eye
		EndIf
		i += 1
	EndWhile
	; kActor.ChangeHeadPart( hpEyes )

	Int Hair = pLeveledActorBase.GetNumHeadParts()
	i = 0
	While i < Hair
		If pLeveledActorBase.GetNthHeadPart(i).GetType() == 3
			hpHairOrig = pLeveledActorBase.GetNthHeadPart(i)
			i = Hair
		EndIf
		i += 1
	EndWhile
	; kActor.ChangeHeadPart( hpHair )

	Float fWeight = pActorBase.GetWeight()
	fOrigWeight = fWeight
	StorageUtil.SetFloatValue(kActor, "_SLH_fWeight", fWeight)
	StorageUtil.SetFloatValue(kActor, "_SLH_fWeightOrig", fWeight)
	StorageUtil.SetFloatValue(kActor, "_SLH_fManualWeightChange",  fWeight) 

	fHeight = kActorREF.GetScale()
	fOrigHeight = fHeight

	SLH_OrigWeight.SetValue(fOrigWeight)

	If (pLeveledActorBase.GetSex() == 1 ) && (StorageUtil.GetIntValue(kActor, "_SLH_iHRT") == 0)
		iSexStage = -2
	Else
		iSexStage = 2
	EndIf

	StorageUtil.SetFormValue(kActor, "_SLH_fOrigRace",  pActorBase.GetRace()) 

	debugTrace(" Init race: " + pActorBase.GetRace().getName())
	; Debug.Messagebox("Init race: " + pActorBase.GetRace().getName())

	setShapeState(kActor)

endFunction

function setShapeStateDefault(Actor kActor)
	ObjectReference kActorREF = kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	ActorBase pLeveledActorBase = kActor.GetLeveledActorBase()
	
	if ( bBreastEnabled && pLeveledActorBase.GetSex() == 1 )
		;fOrigLeftBreast  = NetImmerse.GetNodeScale(kActor, NINODE_LEFT_BREAST, false)
		fOrigRightBreast = SLHGetNodeScale(kActor, NINODE_RIGHT_BREAST, false)
		;fPregLeftBreast  = fOrigLeftBreast
		fPregRightBreast = fOrigRightBreast
		StorageUtil.SetFloatValue(kActor, "_SLH_fBreast", fOrigRightBreast)
		if bTorpedoFixEnabled
			;fOrigLeftBreast01  = NetImmerse.GetNodeScale(kActor, NINODE_LEFT_BREAST01, false)
			fOrigRightBreast01 = SLHGetNodeScale(kActor, NINODE_RIGHT_BREAST01, false)
			;fPregLeftBreast01  = fOrigLeftBreast01
			fPregRightBreast01 = fOrigRightBreast01
		endif
	endif
	if ( bButtEnabled )
		;fOrigLeftButt    = NetImmerse.GetNodeScale(kActor, NINODE_LEFT_BUTT, false)
		fOrigRightButt   = SLHGetNodeScale(kActor, NINODE_RIGHT_BUTT, false)
		;fPregLeftButt    = fOrigLeftButt
		fPregRightButt   = fOrigRightButt
		StorageUtil.SetFloatValue(kActor, "_SLH_fButt", fOrigRightButt)
	endif
	if ( bBellyEnabled )
		fOrigBelly       = SLHGetNodeScale(kActor, NINODE_BELLY, false)
		fPregBelly       = fOrigBelly  
		StorageUtil.SetFloatValue(kActor, "_SLH_fBelly", fOrigBelly)
	endif		
	if ( bSchlongEnabled )
		fOrigSchlong       = NetImmerse.GetNodeScale(kActor, NINODE_SCHLONG, false) 
		StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong", fOrigSchlong)  
	endif		

 
	Int Eye = pLeveledActorBase.GetNumHeadParts()
	Int i = 0
	While i < Eye
		If pLeveledActorBase.GetNthHeadPart(i).GetType() == 2
			hpEyesOrig = pLeveledActorBase.GetNthHeadPart(i)
			i = Eye
		EndIf
		i += 1
	EndWhile
	; kActor.ChangeHeadPart( hpEyes )

	Int Hair = pLeveledActorBase.GetNumHeadParts()
	i = 0
	While i < Hair
		If pLeveledActorBase.GetNthHeadPart(i).GetType() == 3
			hpHairOrig = pLeveledActorBase.GetNthHeadPart(i)
			i = Hair
		EndIf
		i += 1
	EndWhile
	; kActor.ChangeHeadPart( hpHair )

	Float fWeight = pActorBase.GetWeight()
	fOrigWeight = fWeight
	StorageUtil.SetFloatValue(kActor, "_SLH_fWeight", fWeight)
	StorageUtil.SetFloatValue(kActor, "_SLH_fWeightOrig", fWeight)

	fHeight = kActorREF.GetScale()
	fOrigHeight = fHeight

	SLH_OrigWeight.SetValue(fOrigWeight)

	If (pLeveledActorBase.GetSex() == 1 ) && (StorageUtil.GetIntValue(kActor, "_SLH_iHRT") == 0)
		iSexStage = -2
	Else
		iSexStage = 2
	EndIf
 
	StorageUtil.SetFormValue(kActor, "_SLH_fOrigRace",  pActorBase.GetRace()) 

	setShapeState(kActor)

endFunction

function resetShapeState(Actor kActor)
	ObjectReference kActorREF = kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	ActorBase pLeveledActorBase = kActor.GetLeveledActorBase()


	if ( bBreastEnabled && pLeveledActorBase.GetSex() == 1 )
		; fOrigLeftBreast  = NetImmerse.GetNodeScale(kActor, NINODE_LEFT_BREAST, false)
		; fOrigRightBreast = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BREAST, false)
		fPregLeftBreast  = fOrigLeftBreast
		fPregRightBreast = fOrigRightBreast
		StorageUtil.SetFloatValue(kActor, "_SLH_fBreast", fOrigRightBreast)
		if bTorpedoFixEnabled
			; fOrigLeftBreast01  = NetImmerse.GetNodeScale(kActor, NINODE_LEFT_BREAST01, false)
			; fOrigRightBreast01 = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BREAST01, false)
			fPregLeftBreast01  = fOrigLeftBreast01
			fPregRightBreast01 = fOrigRightBreast01
		endif
	endif
	if ( bButtEnabled )
		; fOrigLeftButt    = NetImmerse.GetNodeScale(kActor, NINODE_LEFT_BUTT, false)
		; fOrigRightButt   = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BUTT, false)
		fPregLeftButt    = fOrigLeftButt
		fPregRightButt   = fOrigRightButt
		StorageUtil.SetFloatValue(kActor, "_SLH_fButt", fOrigRightButt)
	endif
	if ( bBellyEnabled )
		; fOrigBelly       = NetImmerse.GetNodeScale(kActor, NINODE_BELLY, false)
		; fPregBelly       = fOrigBelly  
		StorageUtil.SetFloatValue(kActor, "_SLH_fBelly", fOrigBelly) 
	endif		
	if ( bSchlongEnabled )
		; fOrigSchlong       = NetImmerse.GetNodeScale(kActor, NINODE_SCHLONG, false) 
		StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong", fOrigSchlong)   
	endif		
 

	Float fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeightOrig")
	alterWeight(kActor, fWeight)
	StorageUtil.SetFloatValue(kActor, "_SLH_fWeight", fWeight)

	fHeight = fOrigHeight
	kActorREF.SetScale(fHeight)

	; SLH_OrigWeight.SetValue(fOrigWeight)

	If (pLeveledActorBase.GetSex() == 1 ) && (StorageUtil.GetIntValue(kActor, "_SLH_iHRT") == 0)
		iSexStage = -2
	Else
		iSexStage = 2
	EndIf
 
 
	setShapeState(kActor)

endFunction

function getShapeFromNodes(Actor kActor)
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	Float fApparelMod = 1.0
	Bool bArmorOn = kActor.WornHasKeyword(ArmorOn)
	Bool bClothingOn = kActor.WornHasKeyword(ClothingOn)

	If (bArmorOn)
		fApparelMod = GV_armorMod.GetValue() as Float
	ElseIf (bClothingOn)
		fApparelMod = GV_clothMod.GetValue() as Float
	EndIf

	if (fApparelMod==0.0)
		fApparelMod = 0.1
	Endif
	

	if (kActor == None)
		return
	endIf

	; Debug.Notification("SexLab Hormones: Reading state from storage")
	debugTrace("    :: Reading state from player actor")

	if (StorageUtil.GetIntValue(none, "_SLH_BodyMorphsON") == 1)
		StorageUtil.SetFloatValue(kActor, "_SLH_fBreast", SLHGetNodeScale(kActor, NINODE_RIGHT_BREAST, false) / fApparelMod)
		StorageUtil.SetFloatValue(kActor, "_SLH_fButt", SLHGetNodeScale(kActor, NINODE_RIGHT_BUTT, false) / fApparelMod)
		StorageUtil.SetFloatValue(kActor, "_SLH_fBelly", SLHGetNodeScale(kActor, NINODE_BELLY, false)  / fApparelMod)
		StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong", NetImmerse.GetNodeScale(kActor, NINODE_SCHLONG, false)) 
	else
		StorageUtil.SetFloatValue(kActor, "_SLH_fBreast", NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BREAST, false) / fApparelMod)
		StorageUtil.SetFloatValue(kActor, "_SLH_fButt", NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BUTT, false) / fApparelMod)
		StorageUtil.SetFloatValue(kActor, "_SLH_fBelly", NetImmerse.GetNodeScale(kActor, NINODE_BELLY, false)  / fApparelMod)
		StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong", NetImmerse.GetNodeScale(kActor, NINODE_SCHLONG, false)) 
	endif

	StorageUtil.SetFloatValue(kActor, "_SLH_fWeight", pActorBase.GetWeight())
	fHeight = kActorREF.GetScale()

	setShapeState(kActor)

EndFunction

Function SLHSetNodeScale(Actor akActor, string nodeName, float value, bool isFemale)
	string modName = "SexLab_Hormones.esp"
	If nodeName == "NPC R Breast"
		SLHSetMorphScale(akActor, "Breasts", value)
		SLHSetMorphScale(akActor, "BreastsSH", value)
		SLHSetMorphScale(akActor, "BreastGravity", value)
		SLHSetMorphScale(akActor, "BreastCleavage", value)
		SLHSetMorphScale(akActor, "DoubleMelon", value)
		SLHSetMorphScale(akActor, "BreastsFantasy", value)
		SLHSetMorphScale(akActor, "NipplePerkiness", value)
		SLHSetMorphScale(akActor, "NippleLength", value)
	ElseIf nodeName == "NPC Belly"
		SLHSetMorphScale(akActor, "Belly", value)
		SLHSetMorphScale(akActor, "BigBelly", value)
		SLHSetMorphScale(akActor, "HipsUpperWidth", value)
		SLHSetMorphScale(akActor, "WideWaistLine", value)
	ElseIf nodeName == "NPC R Butt"
		SLHSetMorphScale(akActor, "Butt", value)
		SLHSetMorphScale(akActor, "ChubbyButt", value)
		SLHSetMorphScale(akActor, "MuscleButt", value)
		SLHSetMorphScale(akActor, "Hips", value)
		SLHSetMorphScale(akActor, "Thighs", value)
	EndIf
EndFunction

Function SLHSetMorphScale(Actor akActor, string nodeName, float value)
	string modName = "SexLab_Hormones.esp"

	string JsonKey
	If nodeName == "Breasts"
		JsonKey = "breasts"
	ElseIf nodeName == "BreastsSH"
		JsonKey = "breastssh"
	ElseIf nodeName == "BreastGravity"
		JsonKey = "breastgravity"
	ElseIf nodeName == "BreastCleavage"
		JsonKey = "breastcleavage"
	ElseIf nodeName == "DoubleMelon"
		JsonKey = "doublemelon"
	ElseIf nodeName == "BreastsFantasy"
		JsonKey = "breastsfantasy"
	ElseIf nodeName == "NipplePerkiness"
		JsonKey = "nippleperkiness"
	ElseIf nodeName == "NippleLength"
		JsonKey = "nipplelength"
	ElseIf nodeName == "Belly"
		JsonKey = "belly"
	ElseIf nodeName == "BigBelly"
		JsonKey = "bigbelly"
	ElseIf nodeName == "Hips"
		JsonKey = "hips"
	ElseIf nodeName == "HipsUpperWidth"
		JsonKey = "hipsupperwidth"
	ElseIf nodeName == "WideWaistLine"
		JsonKey = "widewaistline"
	ElseIf nodeName == "Butt"
		JsonKey = "butt"
	ElseIf nodeName == "ChubbyButt"
		JsonKey = "chubbybutt"
	ElseIf nodeName == "MuscleButt"
		JsonKey = "musclebutt"
	ElseIf nodeName == "Thighs"
		JsonKey = "thighs"
	EndIf
	
	
	;SE bodyslide notes:
	;BreastsSH changed to BreastsNewSH
	;BreastsSSH doesnt exist in SE
	;BreastGravity changed to BreastGravity2
	;NippleAreola changed to AreolaSize
	;try to scale all nodes for se converted/legacy armors
	
	;NetImmerse-Bodyslide converter
	float bodyslide_value = (value - 1.0) / 2.0
	float bodyslide_scale_modifier = JsonUtil.GetFloatValue("/SLHormones/Bodymorph", JsonKey)
	
	;breast scale
	If nodeName == "Breasts"
		NiOverride.SetBodyMorph(akActor, "Breasts", modName, bodyslide_value * bodyslide_scale_modifier)
	ElseIf nodeName == "BreastsSH"
		NiOverride.SetBodyMorph(akActor, "BreastsNewSH", modName, bodyslide_value * bodyslide_scale_modifier)
	ElseIf nodeName == "BreastGravity"
		NiOverride.SetBodyMorph(akActor, "BreastGravity2", modName, bodyslide_value * bodyslide_scale_modifier)
	ElseIf nodeName == "BreastCleavage"
		NiOverride.SetBodyMorph(akActor, "BreastCleavage", modName, bodyslide_value * bodyslide_scale_modifier)
	ElseIf nodeName == "DoubleMelon"
		NiOverride.SetBodyMorph(akActor, "DoubleMelon", modName, bodyslide_value * bodyslide_scale_modifier)
	ElseIf nodeName == "BreastsFantasy"
		NiOverride.SetBodyMorph(akActor, "BreastsFantasy", modName, bodyslide_value * bodyslide_scale_modifier)
	ElseIf nodeName == "NipplePerkiness"
		NiOverride.SetBodyMorph(akActor, "NipplePerkiness", modName, bodyslide_value * bodyslide_scale_modifier)
	ElseIf nodeName == "NippleLength"
		NiOverride.SetBodyMorph(akActor, "NippleLength", modName, bodyslide_value * bodyslide_scale_modifier)
	;belly scale
	ElseIf nodeName == "Belly"
		NiOverride.SetBodyMorph(akActor, "Belly", modName, bodyslide_value * bodyslide_scale_modifier)
	ElseIf nodeName == "BigBelly"
		NiOverride.SetBodyMorph(akActor, "BigBelly", modName, bodyslide_value * bodyslide_scale_modifier)
	ElseIf nodeName == "HipsUpperWidth"
		NiOverride.SetBodyMorph(akActor, "HipsUpperWidth", modName, bodyslide_value * bodyslide_scale_modifier)
	ElseIf nodeName == "WideWaistLine"
		NiOverride.SetBodyMorph(akActor, "WideWaistLine", modName, bodyslide_value * bodyslide_scale_modifier)
	;butt scale
	ElseIf nodeName == "Butt"
		NiOverride.SetBodyMorph(akActor, "Butt", modName, bodyslide_value * bodyslide_scale_modifier)
	ElseIf nodeName == "ChubbyButt"
		NiOverride.SetBodyMorph(akActor, "ChubbyButt", modName, bodyslide_value * bodyslide_scale_modifier)
	ElseIf nodeName == "MuscleButt"
		NiOverride.SetBodyMorph(akActor, "MuscleButt", modName, bodyslide_value * bodyslide_scale_modifier)
	ElseIf nodeName == "Hips"
		NiOverride.SetBodyMorph(akActor, "Hips", modName, bodyslide_value * bodyslide_scale_modifier)
	ElseIf nodeName == "Thighs"
		NiOverride.SetBodyMorph(akActor, "Thighs", modName, bodyslide_value * bodyslide_scale_modifier)
	EndIf
EndFunction

Float Function SLHGetNodeScale(Actor akActor, string nodeName, bool isFemale)
	string modName = "SexLab_Hormones.esp"

	string JsonKey
	If nodeName == "NPC R Breast"
		JsonKey = "breasts"
	ElseIf nodeName == "NPC Belly"
		JsonKey = "belly"
	ElseIf nodeName == "NPC R Butt"
		JsonKey = "butt"
	EndIf
	
	
	;SE bodyslide notes:
	;BreastsSH changed to BreastsNewSH
	;BreastsSSH doesnt exist in SE
	;BreastGravity changed to BreastGravity2
	;NippleAreola changed to AreolaSize
	;try to scale all nodes for se converted/legacy armors
	
	;NetImmerse-Bodyslide converter
	float bodyslide_scale_modifier = JsonUtil.GetFloatValue("/SLHormones/Bodymorph", JsonKey)
	float NodeConvertValue
	float value

	;breast scale
	If nodeName == "NPC R Breast"
		NodeConvertValue = NiOverride.GetBodyMorph(akActor, "Breasts", modName)
		value = ((2.0*(NodeConvertValue / bodyslide_scale_modifier)) + 1.0)
		return value
	;belly scale
	ElseIf nodeName == "NPC Belly"
		NodeConvertValue = NiOverride.GetBodyMorph(akActor, "Belly", modName)
		value = ((2.0*(NodeConvertValue / bodyslide_scale_modifier)) + 1.0)
		return value
	;butt scale
	ElseIf nodeName == "NPC R Butt"
		NodeConvertValue = NiOverride.GetBodyMorph(akActor, "Butt", modName)
		value = ((2.0*(NodeConvertValue / bodyslide_scale_modifier)) + 1.0)
		return value
	EndIf
EndFunction


function setShapeState(Actor kActor)
	; Debug.Notification("SexLab Hormones: Writing state to storage")
	debugTrace("    :: Writing shape state to storage")

	StorageUtil.SetFloatValue(kActor, "_SLH_fOrigWeight", fOrigWeight) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fOrigHeight", fOrigHeight) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fOrigLeftBreast",  fOrigLeftBreast) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fOrigLeftBreast01",  fOrigLeftBreast01) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fOrigRightBreast",  fOrigRightBreast) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fOrigRightBreast01",  fOrigRightBreast01) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fOrigLeftButt",  fOrigLeftButt) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fOrigRightButt",  fOrigRightButt) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fOrigBelly",  fOrigBelly) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fOrigSchlong",  fOrigSchlong) 

	StorageUtil.SetFloatValue(kActor, "_SLH_fPregLeftBreast",  fPregLeftBreast) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fPregLeftBreast01",  fPregLeftBreast01) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fPregRightBreast",  fPregRightBreast) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fPregRightBreast01",  fPregRightBreast01) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fPregLeftButt",  fPregLeftButt) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fPregRightButt",  fPregRightButt) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fPregBelly",  fPregBelly) 

	; StorageUtil.SetFloatValue(kActor, "_SLH_fBreastSwellMod",  fBreastSwellMod) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fButtSwellMod",  fButtSwellMod) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fBellySwellMod",  fBellySwellMod) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fSchlongSwellMod",  fSchlongSwellMod) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fWeightSwellMod",  fWeightSwellMod) 

	; StorageUtil.SetFloatValue(kActor, "_SLH_fBreastMin",  fBreastMin) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fButtMin",  fButtMin) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fBellyMin",  fBellyMin) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fSchlongMin",  fSchlongMin) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fWeightMin",  fWeightMin) 

	; StorageUtil.SetFloatValue(kActor, "_SLH_fBreastMax",  fBreastMax) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fButtMax",  fButtMax) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fBellyMax",  fBellyMax) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fSchlongMax",  fSchlongMax) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fWeightMax",  fWeightMax) 

	; StorageUtil.SetFloatValue(kActor, "_SLH_fBreast",  fBreast) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fButt",  fButt) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fBelly",  fBelly) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong",  fSchlong) 
	; StorageUtil.SetFloatValue(kActor, "_SLH_fWeight",  fWeight) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHeight",  fHeight) 

	GV_breastMin.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMin"))
	GV_buttMin.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fButtMin"))
	GV_bellyMin.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBellyMin"))
	GV_schlongMin.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMin"))
	GV_weightMin.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMin"))

	GV_breastMax.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMax"))
	GV_buttMax.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fButtMax"))
	GV_bellyMax.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBellyMax"))
	GV_schlongMax.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMax"))
	GV_weightMax.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMax"))

	GV_breastSwellMod.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBreastSwellMod"))
	GV_buttSwellMod.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fButtSwellMod"))
	GV_bellySwellMod.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBellySwellMod"))
	GV_schlongSwellMod.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongSwellMod"))
	GV_weightSwellMod.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fWeightSwellMod"))

	GV_breastValue.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBreast"))
	GV_buttValue.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fButt"))
	GV_bellyValue.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBelly"))
	GV_schlongValue.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong"))
	GV_weightValue.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fWeight"))

	; GV_heightSwellMod.SetValue(fHeightSwellMod)

endFunction


function getShapeState(Actor kActor)

	; Debug.Notification("SexLab Hormones: Reading state from storage")
	debugTrace("    ::  Reading shape state from storage")
 
	fOrigWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fOrigWeight") 
	fOrigHeight = StorageUtil.GetFloatValue(kActor, "_SLH_fOrigHeight") 
	fOrigLeftBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fOrigLeftBreast") 
	fOrigLeftBreast01 = StorageUtil.GetFloatValue(kActor, "_SLH_fOrigLeftBreast01") 
	fOrigRightBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fOrigRightBreast") 
	fOrigRightBreast01 = StorageUtil.GetFloatValue(kActor, "_SLH_fOrigRightBreast01") 
	fOrigLeftButt = StorageUtil.GetFloatValue(kActor, "_SLH_fOrigLeftButt") 
	fOrigRightButt = StorageUtil.GetFloatValue(kActor, "_SLH_fOrigRightButt") 
	fOrigBelly = StorageUtil.GetFloatValue(kActor, "_SLH_fOrigBelly") 
	fOrigSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fOrigSchlong") 

	fPregLeftBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fPregLeftBreast") 
	fPregLeftBreast01 = StorageUtil.GetFloatValue(kActor, "_SLH_fPregLeftBreast01") 
	fPregRightBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fPregRightBreast") 
	fPregRightBreast01 = StorageUtil.GetFloatValue(kActor, "_SLH_fPregRightBreast01") 
	fPregLeftButt = StorageUtil.GetFloatValue(kActor, "_SLH_fPregLeftButt") 
	fPregRightButt = StorageUtil.GetFloatValue(kActor, "_SLH_fPregRightButt") 
	fPregBelly = StorageUtil.GetFloatValue(kActor, "_SLH_fPregBelly") 

	; fBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast") 
	; fButt = StorageUtil.GetFloatValue(kActor, "_SLH_fButt") 
	; fBelly = StorageUtil.GetFloatValue(kActor, "_SLH_fBelly") 
	; fSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong") 
	; fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight") 
	fHeight = StorageUtil.GetFloatValue(kActor, "_SLH_fHeight") 

	; fBreastSwellMod = StorageUtil.GetFloatValue(kActor, "_SLH_fBreastSwellMod") 
	; fButtSwellMod = StorageUtil.GetFloatValue(kActor, "_SLH_fButtSwellMod") 
	; fBellySwellMod = StorageUtil.GetFloatValue(kActor, "_SLH_fBellySwellMod") 
	; fSchlongSwellMod = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongSwellMod") 
	; fWeightSwellMod = StorageUtil.GetFloatValue(kActor, "_SLH_fWeightSwellMod") 

	GV_breastMin.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMin"))
	GV_buttMin.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fButtMin"))
	GV_bellyMin.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBellyMin"))
	GV_schlongMin.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMin"))
	GV_weightMin.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMin"))

	GV_breastMax.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMax"))
	GV_buttMax.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fButtMax"))
	GV_bellyMax.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBellyMax"))
	GV_schlongMax.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMax"))
	GV_weightMax.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMax"))

	GV_breastSwellMod.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBreastSwellMod"))
	GV_buttSwellMod.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fButtSwellMod"))
	GV_bellySwellMod.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBellySwellMod"))
	GV_schlongSwellMod.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongSwellMod"))
	GV_weightSwellMod.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fWeightSwellMod"))

	GV_breastValue.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBreast"))
	GV_buttValue.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fButt"))
	GV_bellyValue.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fBelly"))
	GV_schlongValue.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong"))
	GV_weightValue.SetValue(StorageUtil.GetFloatValue(kActor, "_SLH_fWeight"))

endFunction





string function getMessageStatus(Actor kActor)
	return(" \n Weight: " + StorageUtil.GetFloatValue(kActor, "_SLH_fWeight") + " \n Breasts: " + StorageUtil.GetFloatValue(kActor, "_SLH_fBreast") + " \n Belly: " + StorageUtil.GetFloatValue(kActor, "_SLH_fBelly") + " \n Butt: " + StorageUtil.GetFloatValue(kActor, "_SLH_fButt") + " \n Schlong: " + StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong"))
endFunction

function traceShapeStatus(Actor kActor)

	debugTrace("  Weight: " + StorageUtil.GetFloatValue(kActor, "_SLH_fWeight") + " [ " + StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMin") + " / " + StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMax") + " ]")
	debugTrace("  Breast: " + StorageUtil.GetFloatValue(kActor, "_SLH_fBreast") + " [ " + StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMin") + " / " + StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMax") + " ]")
	debugTrace("  Belly: " + StorageUtil.GetFloatValue(kActor, "_SLH_fBelly") + " [ " + StorageUtil.GetFloatValue(kActor, "_SLH_fBellyMin") + " / " + StorageUtil.GetFloatValue(kActor, "_SLH_fBellyMax") + " ]")
	debugTrace("  Butt: " + StorageUtil.GetFloatValue(kActor, "_SLH_fButt") + " [ " + StorageUtil.GetFloatValue(kActor, "_SLH_fButtMin") + " / " + StorageUtil.GetFloatValue(kActor, "_SLH_fButtMax") + " ]")
	debugTrace("  Schlong: " + StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong") + " [ " + StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMin") + " / " + StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMax") + " ]")

EndFunction


Function debugTrace(string traceMsg)
	if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
		; Disabled for body shape feedback
		Debug.Trace("[SLH_fctBodyShape] " + traceMsg)
	endif
endFunction

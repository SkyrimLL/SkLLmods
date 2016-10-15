Scriptname SLH_fctBodyShape extends Quest  

Import Utility
Import Math

SLH_fctColor Property fctColor Auto
SLH_fctUtil Property fctUtil Auto

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

Float fSwellFactor	     = 0.0
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
Int iSuccubus = 0
Int iDaedricInfluence  = 0
Int iSexStage  = 0

; Race kOrigRace = None

GlobalVariable 		Property SLH_Libido  				Auto  

GlobalVariable 		Property SLH_OrigWeight  Auto  
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
GlobalVariable      Property GV_enableNiNodeOverride	Auto
GlobalVariable      Property GV_armorMod 				Auto
GlobalVariable      Property GV_clothMod	 			Auto

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


function alterBodyAfterRest(Actor kActor)
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	Race thisRace = pActorBase.GetRace()
	Bool bArmorOn = kActor.WornHasKeyword(ArmorOn)
	Bool bClothingOn = kActor.WornHasKeyword(ClothingOn)
	Float fNodeMax
	Bool bExternalChangeModActive = fctUtil.isExternalChangeModActive(kActor)
	Float fLibido = StorageUtil.GetFloatValue(kActor, "_SLH_fLibido")
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

	Float fApparelMod = 1.0

	Race kOrigRace = StorageUtil.GetFormValue(kActor, "_SLH_fOrigRace") as Race

	
	If (kOrigRace != None) 
		If (thisRace != kOrigRace)
			debugTrace("[SLH]  Race change detected - aborting")
			return
		EndIf
	Else
		StorageUtil.SetFormValue(kActor, "_SLH_fOrigRace",thisRace) 
	EndIf

	If (bArmorOn)
		fApparelMod = GV_armorMod.GetValue() as Float
	ElseIf (bClothingOn)
		fApparelMod = GV_clothMod.GetValue() as Float
	EndIf

	if (fApparelMod==0.0)
		fApparelMod = 0.1
	Endif
	

	fGameTime       = Utility.GetCurrentGameTime()
	
	; SexLab Aroused ==================================================
	fctUtil.manageSexLabAroused(kActor)

	iSexCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iSexCountToday") 
	iGameDateLastSex = StorageUtil.GetIntValue(kActor, "_SLH_iGameDateLastSex") 
	iOrgasmsCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iOrgasmsCountToday") 
	iOrgasmsCountAll = StorageUtil.GetIntValue(kActor, "_SLH_iOrgasmsCountAll") 
	iSexCountAll = StorageUtil.GetIntValue(kActor, "_SLH_iSexCountAll") 
 	iOralCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iOralCountToday") 
	iAnalCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iAnalCountToday") 
	iVaginalCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iVaginalCountToday") 
	iSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_iSuccubus") 
	iDaedricInfluence = StorageUtil.GetIntValue(kActor, "_SLH_iDaedricInfluence") 

	iDaysSinceLastSex = (Game.QueryStat("Days Passed") - iGameDateLastSex ) as Int
	StorageUtil.SetIntValue(kActor, "_SLH_iDaysSinceLastSex", iDaysSinceLastSex)

	If (iSexCountToday <= 1) && (iDaysSinceLastSex >= (GV_sexActivityBuffer.GetValue() as Int) ); Decrease
		Debug.Notification("You feel more focused")
		fSwellFactor = -1.0 * GV_baseShrinkFactor.GetValue() 

		fLibido = fLibido - 10.0


		iDaedricInfluence   = fctUtil.iMax(0, iDaedricInfluence   - 1 )

	ElseIf ( iSexCountToday >1) && ( (iSexCountToday >= GV_sexActivityThreshold.GetValue()) || (iDaysSinceLastSex <= (GV_sexActivityBuffer.GetValue() as Int) ) ) ; Increase
		Debug.Notification("You feel more voluptuous")
 
		fLibido = fLibido + 3 + fctUtil.iMin(iOrgasmsCountToday,10) + ( 10 - (Abs(fLibido) / 10) )

		fSwellFactor    = GV_baseSwellFactor.GetValue() 

	Else     ; If ((iSexCountToday > 1) && (iSexCountToday <= GV_sexActivityThreshold.GetValue())) || (iDaysSinceLastSex <= GV_sexActivityBuffer.GetValue())  ; Stable
		Debug.Notification("You feel more balanced")
		; No change
		; fSwellFactor = -0.5 * fSwellFactor 
		; SLH_Libido.SetValue(SLH_Libido.GetValue() - 1)
		fSwellFactor    = 0

		fLibido = fLibido  + 2 - Utility.RandomInt(0, 4)

	EndIf	
	
	fLibido = fctUtil.fRange( fLibido , -100.0, 100.0)

	If (StorageUtil.GetIntValue(kActor, "_SLH_iBimbo")==1)
		fLibido =  fctUtil.fRange( fLibido + 5.0, 50.0, 100.0)
	EndIf

	SLH_Libido.SetValue( fLibido )
	StorageUtil.SetFloatValue(kActor, "_SLH_fLibido",  fLibido) 

	; Debug - Decrease
	;	fSwellFactor = -5.0 
	;	SLH_Libido.SetValue(-90)

	debugTrace("[SLH]  Set Libido to " + fLibido )

	if (GV_useWeight.GetValue() == 1)
		debugTrace( "[SLH] alterBodyAfterRest Weight")
		debugTrace( "[SLH] Actorbase weight: " + pActorBase.GetWeight())
		; debugTrace( "[SLH] Current weight: " + fWeight)
		debugTrace( "[SLH] StorageUtil: " + StorageUtil.GetFloatValue(kActor, "_SLH_fWeight") )
		debugTrace( "[SLH] Global Value: " + GV_weightValue.GetValue() )

		; WEIGHT CHANGE ====================================================
		fCurrentWeight = pActorBase.GetWeight()
		fWeight = fCurrentWeight + ( fSwellFactor * (110 - fCurrentWeight) / 100.0 ) * fWeightSwellMod
		fWeight = fctUtil.fRange( fWeight  , fWeightMin, fWeightMax)

		debugTrace("[SLH]  Set weight to " + fWeight + " from " + fCurrentWeight)
		alterWeight(kActor, fWeight  )

		; Debug.Notification("[SLH]  Set weight to " + fWeight + " from " + fCurrentWeight)

	EndIf

	If (fSwellFactor != 0) 
		; --------
		; BREAST SWELL ====================================================
		If ((iSexCountToday > 0) || (fSwellFactor < 0)) && (GV_useBreastNode.GetValue() == 1)
			if ( bBreastEnabled ) 
				Float fCurrentBreast 
				If (GV_enableNiNodeOverride.GetValue()==0)
					fCurrentBreast = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BREAST, false)
				else
					fCurrentBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")
				endIf

				if (bExternalChangeModActive) && (GV_enableNiNodeOverride.GetValue()==0)
					fNodeMax = fPregBreastMax
					fBreast = fCurrentBreast
				Else
					fNodeMax = fBreastMax
					fBreast = ( fCurrentBreast + ( fSwellFactor * (fNodeMax + fBreastMin  - fCurrentBreast) / 100.0 ) * fBreastSwellMod )   
				EndIf

				debugTrace("[SLH]  	fCurrentBreast:  " + fCurrentBreast)
				debugTrace("[SLH]  		fBreastSwellMod:  " + fBreastSwellMod)
				debugTrace("[SLH]  		fSwellFactor:  " + fSwellFactor)
				debugTrace("[SLH]  		fNodeMax:  " + fNodeMax)
				debugTrace("[SLH]  		fApparelMod:  " + fApparelMod)
				debugTrace("[SLH]  	fBreast:  " + fBreast)

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
				If (GV_enableNiNodeOverride.GetValue()==0)
					fCurrentBelly = NetImmerse.GetNodeScale(kActor, NINODE_BELLY, false)
				else
					fCurrentBelly = StorageUtil.GetFloatValue(kActor, "_SLH_fBelly")
				endIf

				if (bExternalChangeModActive) && (GV_enableNiNodeOverride.GetValue()==0)
					fNodeMax = fPregBellyMax
					fBelly = fCurrentBelly
				Else
					fNodeMax = fBellyMax
					fBelly = (fCurrentBelly + ( fSwellFactor * (fNodeMax + fBellyMin - fCurrentBelly) / 100.0 ) * fBellySwellMod ) 
				EndIf
				
				alterBellyNode(kActor, fBelly )

			endif
		EndIf

		; BUTT SWELL ======================================================
		If ((iSexCountToday > 0) || (fSwellFactor < 0)) && (GV_useButtNode.GetValue() == 1)
			if ( bButtEnabled )  
				Float fCurrentButt 
				If (GV_enableNiNodeOverride.GetValue()==0)
					fCurrentButt = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BUTT, false)
				else
					fCurrentButt = StorageUtil.GetFloatValue(kActor, "_SLH_fButt")
				endIf

				if (bExternalChangeModActive) && (GV_enableNiNodeOverride.GetValue()==0)
					fNodeMax = fPregButtMax
					fButt = fCurrentButt
				Else
					fNodeMax = fButtMax
					fButt = ( fCurrentButt + ( fSwellFactor * (fNodeMax + fButtMin  - fCurrentButt) / 100.0 ) * fButtSwellMod )   
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
				If (GV_enableNiNodeOverride.GetValue()==0)
					fCurrentSchlong = NetImmerse.GetNodeScale(kActor, NINODE_SCHLONG, false)
				else
					fCurrentSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")
				endIf


				fSchlong = fCurrentSchlong + ( fSwellFactor * (fSchlongMax + fSchlongMin  - fCurrentSchlong) / 100.0 ) * fSchlongSwellMod 

				alterSchlongNode(kActor,  fSchlong )
			endif
		EndIf
	EndIf

	StorageUtil.SetFloatValue(kActor, "_SLH_fSwellFactor",  fSwellFactor) 
 
	
 	; _refreshBodyShape()
 	; _applyBodyShapeChanges()




EndFunction

function alterBodyAfterSex(Actor kActor, Bool bOral = False, Bool bVaginal = False, Bool bAnal = False)
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

	Float fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")
	Float fBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")       
	Float fButt = StorageUtil.GetFloatValue(kActor, "_SLH_fButt")       	
	Float fBelly = StorageUtil.GetFloatValue(kActor, "_SLH_fBelly")       		
	Float fSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")     

	Float fTempGrowthMod = StorageUtil.GetFloatValue(kActor, "_SLH_fTempGrowthMod")  

	if (fTempGrowthMod==0.0)		
		fTempGrowthMod=1.0	 
	Endif

	Race kOrigRace = StorageUtil.GetFormValue(kActor, "_SLH_fOrigRace") as Race

	
	If (kOrigRace != None) 
		If (thisRace != kOrigRace)
			debugTrace("[SLH]  Race change detected - aborting")
			return
		EndIf
	Else
		StorageUtil.SetFormValue(kActor, "_SLH_fOrigRace",thisRace) 
	EndIf


	fGameTime       = Utility.GetCurrentGameTime()
	
	; SexLab Aroused ==================================================
	fctUtil.manageSexLabAroused(kActor)

	; StorageUtil.SetFloatValue(kActor, "_SLH_fTempGrowthMod",  1.0) 
	fSwellFactor    = (fTempGrowthMod * GV_baseSwellFactor.GetValue()) / GV_sexActivityThreshold.GetValue()
 
	fLibido = fctUtil.iRange( (fLibido as Int) + 1, -100, 100)

	If (StorageUtil.GetIntValue(kActor, "_SLH_iBimbo")==1)
		fLibido = fctUtil.iRange( (fLibido as Int) + 10, 50, 100) 
	EndIf

	SLH_Libido.SetValue(fLibido)
	StorageUtil.SetFloatValue(kActor, "_SLH_fLibido",fLibido)

	debugTrace("[SLH]  Set Libido to " + fLibido )

		debugTrace( "[SLH] alterBodyAfterSex Weight")
		debugTrace( "[SLH] Actorbase weight: " + pActorBase.GetWeight())
		; debugTrace( "[SLH] Current weight: " + fWeight)
		debugTrace( "[SLH] StorageUtil: " + StorageUtil.GetFloatValue(kActor, "_SLH_fWeight") )
		debugTrace( "[SLH] Global Value: " + GV_weightValue.GetValue() )


	If (GV_useNodes.GetValue() == 1)
		; --------
		; BREAST SWELL ====================================================
		If (bOral) 
			if ( bBreastEnabled )  && (GV_useBreastNode.GetValue() == 1)
				Float fCurrentBreast 
				If (GV_enableNiNodeOverride.GetValue()==0)
					fCurrentBreast = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BREAST, false)
				else
					fCurrentBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")
				endIf


				if (bExternalChangeModActive) && (GV_enableNiNodeOverride.GetValue()==0)
					fNodeMax = fPregBreastMax
					fBreast = fCurrentBreast 
				Else
					fNodeMax = fBreastMax
					fBreast = ( fCurrentBreast + ( fSwellFactor * (fNodeMax + fBreastMin  - fCurrentBreast) / 100.0 ) * fBreastSwellMod ) 
				EndIf

				alterBreastNode(kActor,  fBreast )				
			endif
		EndIf

		; BELLY SWELL =====================================================
		If  (bVaginal) 
			if ( bBellyEnabled )   && (GV_useBellyNode.GetValue() == 1)
				Float fCurrentBelly 
				If (GV_enableNiNodeOverride.GetValue()==0)
					fCurrentBelly = NetImmerse.GetNodeScale(kActor, NINODE_BELLY, false)
				else
					fCurrentBelly = StorageUtil.GetFloatValue(kActor, "_SLH_fBelly")
				endIf

				if (bExternalChangeModActive) || (fctUtil.isFHUCumFilledEnabled(kActor)) && (GV_enableNiNodeOverride.GetValue()==0)
					fNodeMax = fPregBellyMax
					fBelly = fCurrentBelly
				Else
					fNodeMax = fBellyMax
					fBelly = ( fCurrentBelly + ( fSwellFactor * (fNodeMax + fBellyMin  - fCurrentBelly) / 100.0 ) * fBellySwellMod ) 
				EndIf

				alterBellyNode(kActor, fBelly)

			endif
		EndIf

		; BUTT SWELL ======================================================
		If  (bAnal) 
			if ( bButtEnabled )  && (GV_useButtNode.GetValue() == 1) 
				Float fCurrentButt 
				If (GV_enableNiNodeOverride.GetValue()==0)
					fCurrentButt = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BUTT, false)
				else
					fCurrentButt = StorageUtil.GetFloatValue(kActor, "_SLH_fButt")
				endIf

				if (bExternalChangeModActive) && (GV_enableNiNodeOverride.GetValue()==0)
					fNodeMax = fPregButtMax
					fButt = fCurrentButt
				Else
					fNodeMax = fButtMax
					fButt = ( fCurrentButt + ( fSwellFactor * (fNodeMax + fButtMin  - fCurrentButt) / 100.0 ) * fButtSwellMod ) 
				EndIf

				alterButtNode(kActor,  fButt )
			endif
		EndIf

		; SCHLONG SWELL ======================================================
		If  (bAnal) || (bVaginal) || (bOral) 

			if ( bEnableSchlong )   && (GV_useSchlongNode.GetValue() == 1)
				Float fCurrentSchlong 
				If (GV_enableNiNodeOverride.GetValue()==0)
					fCurrentSchlong = NetImmerse.GetNodeScale(kActor, NINODE_SCHLONG, false)
				else
					fCurrentSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")
				endIf

				fSchlong = fCurrentSchlong + ( fSwellFactor * (fSchlongMax  + fSchlongMin - fCurrentSchlong) / 100.0 ) * fSchlongSwellMod 

				alterSchlongNode(kActor,  fSchlong )
			endif
		EndIf
	EndIf
 
	
 	; _refreshBodyShape()
 	StorageUtil.SetFloatValue(kActor, "_SLH_fTempGrowthMod",  1.0) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fSwellFactor",  fSwellFactor) 
 

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
			debugTrace("[SLH]  Race change detected - aborting")
			return
		EndIf
	Else
		StorageUtil.SetFormValue(kActor, "_SLH_fOrigRace",thisRace) 
	EndIf

	if (GV_useWeight.GetValue() == 1) && (sBodyPart=="Weight")
		debugTrace( "[SLH] alterBodyByPercent Weight")
		debugTrace( "[SLH] Actorbase weight: " + pActorBase.GetWeight())
		debugTrace( "[SLH] Weight factor: " + modFactor)
		debugTrace( "[SLH] StorageUtil: " + StorageUtil.GetFloatValue(kActor, "_SLH_fWeight") )
		debugTrace( "[SLH] Global Value: " + GV_weightValue.GetValue() )

		; WEIGHT CHANGE ====================================================
		fCurrentWeight = pActorBase.GetWeight()
		fWeight = fCurrentWeight + ( modFactor * (110 - fCurrentWeight) / 100.0 ) * fWeightSwellMod
		fWeight = fctUtil.fRange( fWeight  , fWeightMin, fWeightMax)

		debugTrace("[SLH]  Set weight to " + fWeight + " from " + fCurrentWeight)
		alterWeight(kActor, fWeight  )

		; Debug.Notification("[SLH]  Set weight to " + fWeight + " from " + fCurrentWeight)

	EndIf

	If (GV_useNodes.GetValue() == 1)
		; --------
		; BREAST SWELL ====================================================
		If  (sBodyPart=="Breast") && (GV_useBreastNode.GetValue() == 1)
			if ( bBreastEnabled ) 
				Float fCurrentBreast 
				If (GV_enableNiNodeOverride.GetValue()==0)
					fCurrentBreast = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BREAST, false)
				else
					fCurrentBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")
				endIf


				if (bExternalChangeModActive) && (GV_enableNiNodeOverride.GetValue()==0)
					fNodeMax = fPregBreastMax
					fBreast = fCurrentBreast
				Else
					fNodeMax = fBreastMax
					fBreast = ( fCurrentBreast + ( modFactor * (fNodeMax + fBreastMin  - fCurrentBreast) / 100.0 )   ) 
				EndIf

				debugTrace("[SLH]  	fCurrentBreast:  " + fCurrentBreast)
				debugTrace("[SLH]  		fBreastSwellMod:  " + fBreastSwellMod)
				debugTrace("[SLH]  		fSwellFactor:  " + modFactor)
				debugTrace("[SLH]  		fNodeMax:  " + fNodeMax)
				debugTrace("[SLH]  	fBreast:  " + fBreast)

				alterBreastNode(kActor,  fBreast )	
 			
			endif
		EndIf

		; BELLY SWELL =====================================================
		If (sBodyPart=="Belly")  && (GV_useBellyNode.GetValue() == 1)
			if ( bBellyEnabled )  
				Float fCurrentBelly 
				If (GV_enableNiNodeOverride.GetValue()==0)
					fCurrentBelly = NetImmerse.GetNodeScale(kActor, NINODE_BELLY, false)
				else
					fCurrentBelly = StorageUtil.GetFloatValue(kActor, "_SLH_fBelly")
				endIf

				if (bExternalChangeModActive) && (GV_enableNiNodeOverride.GetValue()==0)
					fNodeMax = fPregBellyMax
					fBelly = fCurrentBelly
				Else
					fNodeMax = fBellyMax
					fBelly = (fCurrentBelly + ( modFactor * (fNodeMax + fBellyMin - fCurrentBelly) / 100.0 )   ) 
				EndIf
				
				alterBellyNode(kActor, fBelly )

			endif
		EndIf

		; BUTT SWELL ======================================================
		If (sBodyPart=="Butt")  && (GV_useButtNode.GetValue() == 1)
			if ( bButtEnabled )  
				Float fCurrentButt 
				If (GV_enableNiNodeOverride.GetValue()==0)
					fCurrentButt = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BUTT, false)
				else
					fCurrentButt = StorageUtil.GetFloatValue(kActor, "_SLH_fButt")
				endIf

				if (bExternalChangeModActive) && (GV_enableNiNodeOverride.GetValue()==0)
					fNodeMax = fPregButtMax
					fButt = fCurrentButt
				Else
					fNodeMax = fButtMax
					fButt = ( fCurrentButt + ( modFactor * (fNodeMax + fButtMin  - fCurrentButt) / 100.0 )   )  
				EndIf
				
				alterButtNode(kActor,  fButt )
			endif
		EndIf

		If (sBodyPart=="Schlong") && (GV_useSchlongNode.GetValue() == 1)
			; Debug.Notification("SexLab Hormones: Male: Schlong updates: " + fSchlong )
			; SCHLONG SWELL ======================================================
	 
			if ( bEnableSchlong )  
				Float fCurrentSchlong 
				If (GV_enableNiNodeOverride.GetValue()==0)
					fCurrentSchlong = NetImmerse.GetNodeScale(kActor, NINODE_SCHLONG, false)
				else
					fCurrentSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")
				endIf

				fSchlong = fCurrentSchlong + ( modFactor * (fSchlongMax + fSchlongMin  - fCurrentSchlong) / 100.0 )  

				alterSchlongNode(kActor,  fSchlong )
			endif
	 
		EndIf
	EndIf
	

 
	StorageUtil.SetFloatValue(kActor, "_SLH_fSwellFactor",  modFactor) 
 
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
			debugTrace("[SLH]  Race change detected - aborting")
			return False
		EndIf
	Else
		StorageUtil.SetFormValue(kActor, "_SLH_fOrigRace",thisRace) 
	EndIf

	Float fCurrentBreast       = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BREAST, false) / fApparelMod
	Float fCurrentButt       = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BUTT, false) / fApparelMod
	Float fCurrentBelly       = NetImmerse.GetNodeScale(kActor, NINODE_BELLY, false) / fApparelMod
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

		debugTrace("[SLH]  -- External shape change detected " )
		debugTrace("[SLH]  	Breast change " + fCurrentBreast + " from " + StorageUtil.GetFloatValue(kActor, "_SLH_fBreast") )
		debugTrace("[SLH]  	Butt change " + fCurrentButt + " from " + StorageUtil.GetFloatValue(kActor, "_SLH_fButt") )
		debugTrace("[SLH]  	Belly change " + fCurrentBelly + " from " + StorageUtil.GetFloatValue(kActor, "_SLH_fBelly") )
		debugTrace("[SLH]  	Schlong change " + fCurrentSchlong + " from " + StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong") )

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
 
	Float fWeightSwellMod    = StorageUtil.GetFloatValue(kActor, "_SLH_fWeightSwellMod")
	Float fWeightMax 		= StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMax")
	Float fWeightMin 		= StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMin")
 
	Float fWeight = fctUtil.fRange(fNewWeight, fWeightMin, fWeightMax)
	Float fWeightOrig = pActorBase.GetWeight()


	Float fManualWeightChange = StorageUtil.GetFloatValue(kActor, "_SLH_fManualWeightChange") 

	if (fManualWeightChange != -1)
	 	debugTrace("[SLH] Weight inconsistency - maybe after showracemenu? " + fManualWeightChange)
		StorageUtil.SetFloatValue(kActor, "_SLH_fManualWeightChange",  -1) 

		fWeightOrig = fManualWeightChange
		; 	StorageUtil.SetFloatValue(kActor, "_SLH_fWeight", fWeightOrig)
	EndIf

	if (fWeightOrig != fWeight) 
		Float NeckDelta = (fWeightOrig / 100) - (fWeight / 100) ;Work out the neckdelta.

		debugTrace("[SLH] Old weight: " + fWeightOrig)
		debugTrace("[SLH] New weight: " + fWeight)
		debugTrace("[SLH] NeckDelta: " + NeckDelta)
	 
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

	if (fctUtil.isExternalChangeModActive(kActor)) && (GV_enableNiNodeOverride.GetValue()==0)
		fNodeMax = fPregBreastMax
	Else
		fNodeMax = fBreastMax
	EndIf

	debugTrace("[SLH]  Breast Old: " + StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")  + " New: " + fNewBreast + " Min: " + fBreastMin + " - Max: " + fNodeMax)

	; fBreast = fctUtil.fRange(fBreast, NINODE_MIN_SCALE), fNodeMax)
	Float fBreast = fctUtil.fRange(fNewBreast, fBreastMin, fNodeMax)
	GV_breastValue.SetValue(fBreast)
	StorageUtil.SetFloatValue(kActor, "_SLH_fBreast",  fBreast) 

	debugTrace("[SLH]  Breast New: " + fBreast )
	
	fPregLeftBreast    = fBreast
	fPregRightBreast   = fBreast

	If (GV_enableNiNodeOverride.GetValue()==0)
		NetImmerse.SetNodeScale( kActor, NINODE_LEFT_BREAST, fPregLeftBreast * fApparelMod, false)
		NetImmerse.SetNodeScale( kActor, NINODE_RIGHT_BREAST, fPregRightBreast * fApparelMod, false)
		; if bTorpedoFixEnabled
		;	NetImmerse.SetNodeScale( kActor, NINODE_LEFT_BREAST01, fPregLeftBreast01, false)
		;	NetImmerse.SetNodeScale( kActor, NINODE_RIGHT_BREAST01, fPregRightBreast01, false)
		; endIf

		NetImmerse.SetNodeScale( kActor, NINODE_LEFT_BREAST, fPregLeftBreast * fApparelMod, true)
		NetImmerse.SetNodeScale( kActor, NINODE_RIGHT_BREAST, fPregRightBreast * fApparelMod, true)
		; if bTorpedoFixEnabled
		;	NetImmerse.SetNodeScale( kActor, NINODE_RIGHT_BREAST01, fPregRightBreast01, true)
		;	NetImmerse.SetNodeScale( kActor, NINODE_LEFT_BREAST01, fPregLeftBreast01, true)
		; endIf

	elseIf (isNiOInstalled && (GV_enableNiNodeOverride.GetValue()==1) )
		XPMSELib.SetNodeScale(kActor, fctUtil.isFemale(kActor), NINODE_LEFT_BREAST, fPregLeftBreast * fApparelMod, SLH_KEY)
		XPMSELib.SetNodeScale(kActor, fctUtil.isFemale(kActor), NINODE_RIGHT_BREAST, fPregRightBreast * fApparelMod, SLH_KEY)

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

	If (bArmorOn)
		fApparelMod = GV_armorMod.GetValue() as Float
	ElseIf (bClothingOn)
		fApparelMod = GV_clothMod.GetValue() as Float
	EndIf

	if (fApparelMod==0.0)
		fApparelMod = 0.1
	Endif
	

	if (fctUtil.isExternalChangeModActive(kActor)) && (GV_enableNiNodeOverride.GetValue()==0)
		fNodeMax = fPregBellyMax
	Else
		fNodeMax = fBellyMax
	EndIf

	debugTrace("[SLH]  Belly Old: " + StorageUtil.GetFloatValue(kActor, "_SLH_fBelly")  + " New: " + fNewBelly + " Min: " + fBellyMin + " - Max: " + fNodeMax)

	; fPregBelly = fctUtil.iMin(fPregBelly, NINODE_MAX_SCALE * 2.0)
	Float fBelly = fctUtil.fRange(fNewBelly, fBellyMin, fNodeMax)
	GV_bellyValue.SetValue(fBelly)
	StorageUtil.SetFloatValue(kActor, "_SLH_fBelly",  fBelly) 
	
	debugTrace("[SLH]  Belly New: " + fBelly )

	fPregBelly     = fBelly

	If (GV_enableNiNodeOverride.GetValue()==0)
		; kTarget.SetAnimationVariableFloat("ecBellySwell", fBellySwell)
		NetImmerse.SetNodeScale( kActor, NINODE_BELLY, fPregBelly * fApparelMod, false)
		NetImmerse.SetNodeScale( kActor, NINODE_BELLY, fPregBelly * fApparelMod, true)

	elseIf (isNiOInstalled && (GV_enableNiNodeOverride.GetValue()==1) )
		XPMSELib.SetNodeScale(kActor, fctUtil.isFemale(kActor),  NINODE_BELLY, fPregBelly * fApparelMod, SLH_KEY) 

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

	If (bArmorOn)
		fApparelMod = GV_armorMod.GetValue() as Float
	ElseIf (bClothingOn)
		fApparelMod = GV_clothMod.GetValue() as Float
	EndIf

	if (fApparelMod==0.0)
		fApparelMod = 0.1
	Endif
	

	if (fctUtil.isExternalChangeModActive(kActor)) && (GV_enableNiNodeOverride.GetValue()==0)
		fNodeMax = fPregButtMax
	Else
		fNodeMax = fButtMax
	EndIf

	debugTrace("[SLH]  Butt Old: " + StorageUtil.GetFloatValue(kActor, "_SLH_fButt")  + " New: " + fNewButt + " Min: " + fButtMin + " - Max: " + fNodeMax)

	Float fButt = fctUtil.fRange(fNewButt, fButtMin, fNodeMax)
	GV_buttValue.SetValue(fButt)
	StorageUtil.SetFloatValue(kActor, "_SLH_fButt",  fButt) 

	debugTrace("[SLH]  Butt New: " + fButt )

	fPregLeftButt = fButt
	fPregRightButt = fButt

	If (GV_enableNiNodeOverride.GetValue()==0)
		NetImmerse.SetNodeScale( kActor, NINODE_LEFT_BUTT, fPregLeftButt * fApparelMod, false)
		NetImmerse.SetNodeScale( kActor, NINODE_RIGHT_BUTT, fPregRightButt * fApparelMod, false)

		NetImmerse.SetNodeScale( kActor, NINODE_LEFT_BUTT, fPregLeftButt * fApparelMod, true)
		NetImmerse.SetNodeScale( kActor, NINODE_RIGHT_BUTT, fPregRightButt * fApparelMod, true)

	elseIf (isNiOInstalled && (GV_enableNiNodeOverride.GetValue()==1) )
		XPMSELib.SetNodeScale(kActor, fctUtil.isFemale(kActor),  NINODE_LEFT_BUTT, fPregLeftButt * fApparelMod, SLH_KEY) 
		XPMSELib.SetNodeScale(kActor, fctUtil.isFemale(kActor),  NINODE_RIGHT_BUTT, fPregRightButt * fApparelMod, SLH_KEY) 

	endIf
EndFunction

function alterSchlongNode(Actor kActor, float fNewSchlong = 0.0)				
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
 
	Float fSchlongSwellMod = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongSwellMod")
	Float fSchlongMax 		= StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMax")
	Float fSchlongMin 		= StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMin")

	debugTrace("[SLH]  Schlong Old: " + StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")  + " New: " + fNewSchlong + " Min: " + fSchlongMin + " - Max: " + fSchlongMax)

	Float fSchlong = fctUtil.fRange(fNewSchlong, fSchlongMin, fSchlongMax)
	GV_schlongValue.SetValue(fSchlong)
	StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong",  fSchlong) 

 	debugTrace("[SLH]  Schlong New: " + fSchlong )

	If (GV_enableNiNodeOverride.GetValue()==0)
		NetImmerse.SetNodeScale( kActor, NINODE_SCHLONG, fSchlong, false)
		NetImmerse.SetNodeScale( kActor, NINODE_SCHLONG, fSchlong, true)

	elseIf (isNiOInstalled && (GV_enableNiNodeOverride.GetValue()==1) )
		XPMSELib.SetNodeScale(kActor, fctUtil.isFemale(kActor),  NINODE_SCHLONG, fSchlong, SLH_KEY)  

	endIf
EndFunction

function shaveHair ( Actor kActor)
 	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	ActorBase pLeveledActorBase = kActor.GetLeveledActorBase()

	Int   iPlayerGender = pLeveledActorBase.GetSex() as Int

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

	debugTrace("[SLH]       -> Forced hair change applied")
 
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
	debugTrace("[SLH]  Refreshing body shape values")

	Race kOrigRace = StorageUtil.GetFormValue(kActor, "_SLH_fOrigRace") as Race

	
	If (kOrigRace != None) 
		If (thisRace != kOrigRace)
			debugTrace("[SLH]  Race change detected - aborting")
			return
		EndIf
	Else
		StorageUtil.SetFormValue(kActor, "_SLH_fOrigRace",thisRace) 
	EndIf

	; Refreshing values in case of any external change from other mods
	; _getShapeState() needs to be called separately

	if (GV_useWeight.GetValue() == 1)
		debugTrace( "[SLH] refreshBodyShape Weight")
		debugTrace( "[SLH] 	Actorbase weight: " + pActorBase.GetWeight())
		debugTrace( "[SLH] 	Current weight: " + fWeight)
		debugTrace( "[SLH] 	StorageUtil: " + StorageUtil.GetFloatValue(kActor, "_SLH_fWeight") )

		alterWeight(kActor,  fWeight  )
	EndIf

	If (GV_useNodes.GetValue() == 1)
		; --------
		; BREAST SWELL ====================================================
		if ( bBreastEnabled )  && (GV_useBreastNode.GetValue() == 1)
			alterBreastNode(kActor,  fBreast )				
		endif

		; BELLY SWELL =====================================================
		if ( bBellyEnabled )  && (GV_useBellyNode.GetValue() == 1) 
			alterBellyNode(kActor, fBelly  )
		endif

		; BUTT SWELL ======================================================
		if ( bButtEnabled )   && (GV_useButtNode.GetValue() == 1)  
			alterButtNode(kActor,  fButt  )
		endif

		; BUTT SWELL ======================================================
		if ( bSchlongEnabled )    && (GV_useSchlongNode.GetValue() == 1) 
			alterSchlongNode(kActor,  fSchlong )
		endif

	EndIf


endFunction

function applyBodyShapeChanges(Actor kActor)
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	Race thisRace = pActorBase.GetRace()
 

	; Debug.Notification("SexLab Hormones: Applying body changes")
	debugTrace("[SLH]  Applying body changes")

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

	If ( !kActor.Is3DLoaded() || kActor.IsOnMount() || (kActor.GetActorValue("Variable01")!= 0) || kActor.IsInCombat() || kActor.IsWeaponDrawn() )
		return
	EndIf

	; Abort if race has changed (vampire lord or werewolf transformation)
	Race kOrigRace = StorageUtil.GetFormValue(kActor, "_SLH_fOrigRace") as Race

	
	If (kOrigRace != None) 
		If (thisRace != kOrigRace)
			debugTrace("[SLH]  Race change detected - aborting")
			return
		EndIf
	Else
		StorageUtil.SetFormValue(kActor, "_SLH_fOrigRace",thisRace) 
	EndIf

 	If (GV_enableNiNodeUpdate.GetValue() == 1)
		If ((GV_useNodes.GetValue() == 1) || (GV_useWeight.GetValue() == 1))
			debugTrace("[SLH]  QueueNiNodeUpdate")
			Utility.Wait(1.0)
			string facegen = "bUseFaceGenPreprocessedHeads:General"
			Utility.SetINIBool(facegen, false)
			; Game.GetPlayer().QueueNiNodeUpdate()
			kActor.QueueNiNodeUpdate()
			Utility.SetINIBool(facegen, true)
			Utility.Wait(1.0)

		Else
			debugTrace("[SLH]  QueueNiNodeUpdate aborted - " + GV_useNodes.GetValue() + " - " +GV_useWeight.GetValue() )
		Endif	
	EndIf
 
	; If (GV_enableNiNodeOverride.GetValue()==1)
		; If (GV_useWeight.GetValue() == 1)
			; debugTrace("[SLH]  NiOverride.UpdateModelWeight")
			; NiOverride.UpdateModelWeight(kActor)
		; endif
	; endif

	Utility.Wait(1.0)
endFunction


function initShapeConstants(Actor kActor)
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	ActorBase pLeveledActorBase = kActor.GetLeveledActorBase()

	debugTrace("[SLH]  Init shape constants")

	; Modifiers for each part
	; fWeightSwellMod = GV_weightSwellMod.GetValue()   ; 5.0   

	; fBreastSwellMod = GV_breastSwellMod.GetValue()   ; 0.3 
	; fBellySwellMod = GV_bellySwellMod.GetValue()   ; 0.1 
	; fButtSwellMod = GV_buttSwellMod.GetValue()   ; 0.2 
	; fSchlongSwellMod = GV_schlongSwellMod.GetValue()   ; 0.2 
	; fWeightSwellMod = GV_weightSwellMod.GetValue()   ; 0.2 
 
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
	debugTrace("[SLH]  NiOverride detection: " + isNiOInstalled)

	; setShapeState(kActor)

endFunction

function initShapeState(Actor kActor)
	ObjectReference kActorREF = kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	ActorBase pLeveledActorBase = kActor.GetLeveledActorBase()
	

	if ( bBreastEnabled && pLeveledActorBase.GetSex() == 1 )
		fOrigLeftBreast  = NetImmerse.GetNodeScale(kActor, NINODE_LEFT_BREAST, false)
		fOrigRightBreast = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BREAST, false)
		fPregLeftBreast  = fOrigLeftBreast
		fPregRightBreast = fOrigRightBreast
		StorageUtil.SetFloatValue(kActor, "_SLH_fBreast", fOrigRightBreast)
		if bTorpedoFixEnabled
			fOrigLeftBreast01  = NetImmerse.GetNodeScale(kActor, NINODE_LEFT_BREAST01, false)
			fOrigRightBreast01 = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BREAST01, false)
			fPregLeftBreast01  = fOrigLeftBreast01
			fPregRightBreast01 = fOrigRightBreast01
		endif
	endif
	if ( bButtEnabled )
		fOrigLeftButt    = NetImmerse.GetNodeScale(kActor, NINODE_LEFT_BUTT, false)
		fOrigRightButt   = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BUTT, false)
		fPregLeftButt    = fOrigLeftButt
		fPregRightButt   = fOrigRightButt
		StorageUtil.SetFloatValue(kActor, "_SLH_fButt", fOrigRightButt)
	endif
	if ( bBellyEnabled )
		fOrigBelly       = NetImmerse.GetNodeScale(kActor, NINODE_BELLY, false)
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

	debugTrace("[SLH] Init race: " + pActorBase.GetRace().getName())
	; Debug.Messagebox("[SLH] Init race: " + pActorBase.GetRace().getName())

	setShapeState(kActor)

endFunction

function setShapeStateDefault(Actor kActor)
	ObjectReference kActorREF = kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()
	ActorBase pLeveledActorBase = kActor.GetLeveledActorBase()
	
	if ( bBreastEnabled && pLeveledActorBase.GetSex() == 1 )
		fOrigLeftBreast  = NetImmerse.GetNodeScale(kActor, NINODE_LEFT_BREAST, false)
		fOrigRightBreast = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BREAST, false)
		fPregLeftBreast  = fOrigLeftBreast
		fPregRightBreast = fOrigRightBreast
		StorageUtil.SetFloatValue(kActor, "_SLH_fBreast", fOrigRightBreast)
		if bTorpedoFixEnabled
			fOrigLeftBreast01  = NetImmerse.GetNodeScale(kActor, NINODE_LEFT_BREAST01, false)
			fOrigRightBreast01 = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BREAST01, false)
			fPregLeftBreast01  = fOrigLeftBreast01
			fPregRightBreast01 = fOrigRightBreast01
		endif
	endif
	if ( bButtEnabled )
		fOrigLeftButt    = NetImmerse.GetNodeScale(kActor, NINODE_LEFT_BUTT, false)
		fOrigRightButt   = NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BUTT, false)
		fPregLeftButt    = fOrigLeftButt
		fPregRightButt   = fOrigRightButt
		StorageUtil.SetFloatValue(kActor, "_SLH_fButt", fOrigRightButt)
	endif
	if ( bBellyEnabled )
		fOrigBelly       = NetImmerse.GetNodeScale(kActor, NINODE_BELLY, false)
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
	debugTrace("[SLH] <--- Reading state from player actor")

	StorageUtil.SetFloatValue(kActor, "_SLH_fBreast", NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BREAST, false) / fApparelMod)
	StorageUtil.SetFloatValue(kActor, "_SLH_fButt", NetImmerse.GetNodeScale(kActor, NINODE_RIGHT_BUTT, false) / fApparelMod)
	StorageUtil.SetFloatValue(kActor, "_SLH_fBelly", NetImmerse.GetNodeScale(kActor, NINODE_BELLY, false)  / fApparelMod)
	StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong", NetImmerse.GetNodeScale(kActor, NINODE_SCHLONG, false))
	; fWeight = pActorBase.GetWeight()
	StorageUtil.SetFloatValue(kActor, "_SLH_fWeight", pActorBase.GetWeight())

	fHeight = kActorREF.GetScale()

	setShapeState(kActor)

EndFunction

function setShapeState(Actor kActor)
	; Debug.Notification("SexLab Hormones: Writing state to storage")
	debugTrace("[SLH] ---> Writing shape state to storage")

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
	debugTrace("[SLH] <---  Reading shape state from storage")
 
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

	debugTrace("[SLH]  Weight: " + StorageUtil.GetFloatValue(kActor, "_SLH_fWeight") + " [ " + StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMin") + " / " + StorageUtil.GetFloatValue(kActor, "_SLH_fWeightMax") + " ]")
	debugTrace("[SLH]  Breast: " + StorageUtil.GetFloatValue(kActor, "_SLH_fBreast") + " [ " + StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMin") + " / " + StorageUtil.GetFloatValue(kActor, "_SLH_fBreastMax") + " ]")
	debugTrace("[SLH]  Belly: " + StorageUtil.GetFloatValue(kActor, "_SLH_fBelly") + " [ " + StorageUtil.GetFloatValue(kActor, "_SLH_fBellyMin") + " / " + StorageUtil.GetFloatValue(kActor, "_SLH_fBellyMax") + " ]")
	debugTrace("[SLH]  Butt: " + StorageUtil.GetFloatValue(kActor, "_SLH_fButt") + " [ " + StorageUtil.GetFloatValue(kActor, "_SLH_fButtMin") + " / " + StorageUtil.GetFloatValue(kActor, "_SLH_fButtMax") + " ]")
	debugTrace("[SLH]  Schlong: " + StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong") + " [ " + StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMin") + " / " + StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMax") + " ]")

EndFunction


Function debugTrace(string traceMsg)
	if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
		Debug.Trace(traceMsg)
	endif
endFunction

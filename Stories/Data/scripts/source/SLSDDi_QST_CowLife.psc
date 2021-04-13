Scriptname SLSDDi_QST_CowLife extends Quest  

ReferenceAlias Property PlayerAlias  Auto  
SexLabFramework     property SexLab Auto

zadLibs Property libs Auto
zaddReliableForceGreet Property fg Auto

slaUtilScr Property slaUtil  Auto  

Quest Property DivineCheeseQuest  Auto
SLSDDi_QST_DivineCheese Property DivineCheeseScript Auto

ReferenceAlias Property SnowShodCowDunmerAlias Auto
ReferenceAlias Property SnowShodCowBosmerAlias Auto
ReferenceAlias Property SnowShodCowNordAlias Auto
ReferenceAlias Property SnowShodCowAltmerAlias Auto
ReferenceAlias Property SnowShodCowImperialAlias Auto
ReferenceAlias Property SnowShodCowOrcAlias Auto
ReferenceAlias Property SnowShodCowBretonAlias Auto
ReferenceAlias Property SnowShodCowRedguardAlias Auto

ObjectReference Property BretonCowRef Auto
ObjectReference Property NordCowRef Auto

FormList Property HucowsList Auto
FormList Property MilkFarmList Auto

Faction Property HucowsFaction Auto
Faction Property MilkFarmCowsFaction Auto
Faction Property CrimeFactionRiften Auto

Potion Property Milk Auto
Potion Property DivineMilk Auto
MiscObject Property EmptyMilk Auto

GlobalVariable Property GV_MilkDuringSex  Auto  
GlobalVariable Property GV_MilkLevel  Auto  
GlobalVariable Property GV_ProlactinLevel  Auto  
GlobalVariable Property MilkProduced  Auto  
GlobalVariable Property MilkDivineProduced  Auto  
GlobalVariable Property MilkProducedTotal  Auto  

Keyword Property SLSD_CowHarness Auto
Keyword Property SLSD_CowMilker Auto
Keyword Property SLSD_MilkOMatic  Auto  
Keyword Property SLSD_MilkOMatic2  Auto  

SPELL Property SLSD_MilkOMaticSpell  Auto  
SPELL Property SLSD_MilkOMaticSpell2  Auto  
SPELL Property ApplySweatFX  Auto

ObjectReference Property MilkOMaticSoundFX  Auto  
ObjectReference Property LeonaraRef  Auto  
ObjectReference Property BalimundMerchantChest Auto

ObjectReference Property TrophiesMarkerRef Auto
ObjectReference Property GrummitesMarkerRef Auto
ObjectReference Property SkeeversMarkerRef Auto
ObjectReference Property KnightsMarkerRef Auto
ObjectReference Property WabbajackMarkerRef Auto
SPELL Property WabbajackSpell Auto
Sound Property CardSoundFX Auto
ObjectReference[] Property ShiveringGroveHazards  Auto  

MiscObject Property Gold Auto

Armor Property cowHarnessInventory Auto
Armor Property cowHarnessRendered Auto
Armor Property autoCowHarnessInventory Auto
Armor Property autoCowHarnessRendered Auto

Armor Property MilkFarmCowSkin Auto

Outfit Property FarmCowOutfit Auto

Sound Property SteamSoundFX Auto
Sound Property MachineSoundFX Auto
Sound Property SuctionSoundFX Auto

Keyword Property SLS_CowHarness Auto
Keyword Property SLS_CowMilker Auto

 
; String                   Property NINODE_SCHLONG	 	= "NPC Genitals01 [Gen01]" AutoReadOnly
string                   Property SLS_KEY               = "SLSDDi_MilkFarm" AutoReadOnly
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
 

int Property MAX_PRESETS = 4 AutoReadOnly
int Property MAX_MORPHS = 19 AutoReadOnly

int MilkLevel = 0
Int iTotalMilkProduced = 0

int MILK_LEVEL_TRIGGER = 20




Function PlayerReceivedCowharness(Actor kActor )
	libs.Log("PlayerReceivedCowharness ")
	
	; zaddsgBeltInexperiencedMsg.Show()
	if kActor == libs.PlayerRef
		Debug.MessageBox("The harness molds around your body, accentuating your breasts as the suction cups lock in around your nipples.")
	else
		Debug.MessageBox("The harness fits tightly around her body, pressing into her breasts as the suction cups lock in around her nipples.")
	endif

	; EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
	libs.EquipDevice(kActor, cowHarnessInventory , cowHarnessRendered , SLS_CowHarness)
	; StorageUtil.SetIntValue(none, "_SLH_iLactating", 1)

	; SetStage(10)
	; SetObjectiveDisplayed(10)
EndFunction

Function PlayerRemovedCowharness( Actor kActor )
	libs.Log("PlayerLostCowharness ")
	
	; zaddsgBeltInexperiencedMsg.Show()
	if kActor == libs.PlayerRef
		Debug.MessageBox("The harness lets go of your sore nipples with a loud pop.")
	else
		Debug.MessageBox("The harness lets go of her sore nipples with a loud pop.")
	endif

	; EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
	libs.RemoveDevice(kActor, cowHarnessInventory , cowHarnessRendered , SLS_CowHarness)
	; StorageUtil.SetIntValue(none, "_SLH_iLactating", 0)

	; SetStage(10)
	; SetObjectiveDisplayed(10)
EndFunction

Function PlayerReceivedAutoCowharness( Actor kActor )
	libs.Log("PlayerReceivedAutoCowharness ")
	
	; zaddsgBeltInexperiencedMsg.Show()
	if kActor == libs.PlayerRef
		Debug.MessageBox("The harness molds around your body and starts humming, accentuating your breasts as the suction cups lock in around your nipples.")
	else
		Debug.MessageBox("The harness molds around her body and starts humming, compressing her breasts as the suction cups latch on her nipples.")
	endif

	; EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
	libs.EquipDevice(kActor, autoCowHarnessInventory , autoCowHarnessRendered , SLS_CowMilker)
	; StorageUtil.SetIntValue(none, "_SLH_iLactating", 1)

	; SetStage(10)
	; SetObjectiveDisplayed(10)
EndFunction

Function PlayerRemovedAutoCowharness( Actor kActor )
	libs.Log("PlayerLostAutoCowharness ")
	
	; zaddsgBeltInexperiencedMsg.Show()
	if kActor == libs.PlayerRef
		Debug.MessageBox("The harness lets go of your swollen nipples with a loud pop.")
	else
		Debug.MessageBox("The harness lets go of her swollen nipples with a loud pop.")
	endif

	; EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
	libs.RemoveDevice(kActor, autoCowHarnessInventory , autoCowHarnessRendered , SLS_CowMilker)
	; StorageUtil.SetIntValue(none, "_SLH_iLactating", 0)

	; SetStage(10)
	; SetObjectiveDisplayed(10)
EndFunction

Function registerCow(Actor kActor)
	ActorBase pActorBase = kActor.GetActorBase()
	Float fLactationHormoneLevel = StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactation") 
	Float fInitLactationLevel 
	Float fWeight = pActorBase.GetWeight()
	Float fBreast  = NetImmerse.GetNodeScale(kActor, NINODE_LEFT_BREAST, false)


	If (StorageUtil.GetIntValue(kActor, "_SLH_iMilkCow") == 0)
		debugTrace(" Registering new cow: " + kActor )
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkCow", 1)
		StorageUtil.FormListAdd(none, "_SLH_lMilkCowList", kActor)

		StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", 0)
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkProduced", 0)
		StorageUtil.SetIntValue(kActor, "_SLH_iDivineMilkProduced", 0)
	endif

 	; Add cow to HucowsList for Dialogue conditions
	; Int iIndex = HucowsList.Find(kActor as Form)
	; If iIndex == -1
	;	HucowsList.AddForm(kActor as Form)
 	; EndIf

 	if (!kActor.IsInFaction(HucowsFaction))
 		kActor.AddToFaction(HucowsFaction)
 	endif

	; if (StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") < 10)
	;	StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", Utility.RandomInt(2,10)) 
	; endif 

	checkIfLactating( kActor)
	if ((StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactation") ) < 10.0)
		StorageUtil.SetFloatValue( kActor , "_SLH_fHormoneLactation", (fWeight / 10.0) +  (fBreast * 10.0) )
	endif
 

EndFunction

Function updateAllCows(String sUpdateMode = "")
	Int valueCount = StorageUtil.FormListCount(none, "_SLH_lMilkCowList")
	int i = 0
	Form thisCow
 
 	debugTrace(" Updating registered cows: " + valueCount)

	while(i < valueCount)
		thisCow = StorageUtil.FormListGet(none, "_SLH_lMilkCowList", i)
		updateCowStatus(thisCow as Actor, sUpdateMode, 0)
		i = i + 1
	endwhile

EndFunction

Function updateCowStatus(Actor kActor, String sUpdateMode = "", Int iNumberBottles=0)
 	Actor kPlayer= Game.GetPlayer() as Actor
 	ActorBase pActorBase
	ActorBase pLeveledActorBase 
 	Float fLactationHormoneMod = 0.1

	debugTrace(" updateCowStatus - Actor: " + kActor)

	if (kActor == kPlayer) && (isMale(kPlayer))
		debugTrace(" Actor is Player and Male - Aborting updateCowStatus.")
		Return
	endif

 	; sUpdateMode - allowed values 
 	; "Silent" - init values, correct errors, check status
  	; "Check" - same as "Silent" with extra message, good for one ccow check
	; "NewDay" - apply daily cooldowns
	; "Milk" - reset milk date after production of bottle
	; "Drink" - updates levels if player drinks from cow
	; "AfterSex" - update after sex
	; "AfterOrgasm" - update after orgasm

	If (sUpdateMode == "")
		sUpdateMode = "Silent"
	endif

	If (kActor == None)
		kActor = kPlayer
	EndIf

	Float fLactationBase = ( StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced") / 10) as Float
	Float fLactationLevel = ( StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") ) as Float
	Float fLactationMilkDate = 1.0 + ( Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(kActor, "_SLH_iMilkDate") ) as Float
	Float fLactationHormoneLevel = StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactation") 
	Float fLactationHormoneCooldownMod = StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactationCooldown") / 100.0
	Int	iLactationHormoneLevel = fLactationHormoneLevel  as Int
	Int iMilkProductionMod = 1 + (iLactationHormoneLevel / 20) ; should be between 1 and 6, to accelerate milk production Lactation hormone is high
	Int iMilkLevel = StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel")
	 

	pActorBase = kActor.GetActorBase()
	pLeveledActorBase = kActor.GetLeveledActorBase()

	checkIfLactating(kActor)

	; Fix potential init issues
 	if (StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel")>0)
 		; Disable Prolactin variable and move to Hormone Lactation variable for Hormones compatibility
 		StorageUtil.SetFloatValue( kActor , "_SLH_fHormoneLactation", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") as Int)
 		StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", -1)
 	endif

	if ( kActor.WornHasKeyword(SLSD_CowHarness) || kActor.WornHasKeyword(SLSD_CowMilker) ) && (!StorageUtil.HasIntValue(kActor, "_SLH_iLactating") || (StorageUtil.GetIntValue(kActor, "_SLH_iLactating") == 0) )
		registerCow(kActor)
	endif

	If (!StorageUtil.HasIntValue(kActor, "_SLH_iMilkDate") || (StorageUtil.GetIntValue(kActor, "_SLH_iMilkDate") == 0) )
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkDate", Game.QueryStat("Days Passed"))
	Endif

	if (fLactationHormoneCooldownMod<=1.0) 
		StorageUtil.SetFloatValue( kActor , "_SLH_fHormoneLactationCooldown", 50.0) 
		fLactationHormoneCooldownMod = 0.5
	endif

	if (fLactationLevel > 100.0)
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", 100)
	elseif (fLactationLevel < 0.0)
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", 0)
	endif


	If (StorageUtil.GetIntValue(kActor, "_SLH_iMilkCow") == 0)
		registerCow(kActor)
	Endif

 	if (!kActor.IsInFaction(HucowsFaction))
 		kActor.AddToFaction(HucowsFaction)
 	endif

	If (sUpdateMode == "NewDay")

		If (kActor.IsInFaction(MilkFarmCowsFaction))
			; If cow is at the farm, we can assume they keep getting stimulated if the player is away
			fLactationHormoneMod = fLactationHormoneMod - (-5.0 + Utility.RandomInt(0,5)) * fLactationHormoneCooldownMod
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") + 4 * (fLactationMilkDate as Int))

		elseIf (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1) 
			fLactationHormoneMod = fLactationHormoneMod - (2.5 * fLactationHormoneCooldownMod)
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") + 2 * (fLactationMilkDate as Int))
		else
			fLactationHormoneMod = fLactationHormoneMod - 5.0 * fLactationHormoneCooldownMod

			If (Utility.RandomInt(0,100)> (100-iLactationHormoneLevel))
				StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") + 1 * (fLactationMilkDate as Int))
			endif
		endIf

 		kActor.SendModEvent("SLHModHormone", "Lactation", fLactationHormoneMod )

	ElseIf (sUpdateMode == "Milk") ; Milk bottle produced - reset timer
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkDate", Game.QueryStat("Days Passed"))

		fLactationHormoneMod = fLactationHormoneMod  + 2.0
		; StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", iProlactinLevel )

 		kActor.SendModEvent("SLHModHormone", "Lactation", fLactationHormoneMod )

 		; Reduce milk level from producing a bottle
 		Int iMilkRemoved = iNumberBottles * ((12.0 * (( StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactation") / 100.0))) as Int )

 		debug.notification("[SLSDDi] Milk removed: " + iMilkRemoved)
 		debugTrace(" Milk removed: " + iMilkRemoved)

		If (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1) &&  (StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") > 5)
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") - (iMilkRemoved / 2))

		elseif (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") != 1) &&  (StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") > 5)
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") - iMilkRemoved)
		endIf

 	Elseif  (sUpdateMode == "Drink")

		If (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1) &&  (StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") > 5)
			StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") - 2)

		elseif (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") != 1) &&  (StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") > 5)
			StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") - 1)
		endIf
 

	ElseIf (sUpdateMode == "AfterSex") ; Adjust levels from stimulation
		; Level adjustments handled in Sex event

	ElseIf (sUpdateMode == "Check") ; Messages from checking milk level
		If (fLactationLevel<((MILK_LEVEL_TRIGGER as Float) - 10.0))
			Debug.Notification("Her breasts are tender and filling up nicely - Level " + fLactationLevel as Int)

		ElseIf (fLactationLevel>= ((MILK_LEVEL_TRIGGER as Float) - 10.0)) && (fLactationLevel<( (MILK_LEVEL_TRIGGER as Float) - 6.0)) 
			Debug.Notification("Her breasts are swelling up with milk - Level " + fLactationLevel as Int)

		ElseIf (fLactationLevel>= ((MILK_LEVEL_TRIGGER as Float) - 6.0)) && (fLactationLevel< ( (MILK_LEVEL_TRIGGER as Float) - 2.0))
			Debug.Notification("Her breasts are heavy and her tits hard - Level " + fLactationLevel as Int)

		ElseIf (fLactationLevel>= ((MILK_LEVEL_TRIGGER as Float) - 2.0)) 
			Debug.Notification("Her breasts are full and ready to be milked - Level " + fLactationLevel as Int)
		Endif


	Endif


	if (fLactationLevel > 100.0)
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", 100)
	elseif (fLactationLevel < 0.0)
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", 0)
	endif

	fLactationLevel = ( StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") ) as Float

	If (kActor == kPlayer)
		GV_MilkLevel.SetValue(StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") as Int)
		MilkProduced.SetValue(StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced") as Int)
		GV_ProlactinLevel.SetValue( StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactation") as Int)
		MilkProduced.SetValue(StorageUtil.GetIntValue(kActor, "_SLH_iMilkProducedTotal") as Int)
		MilkDivineProduced.SetValue(StorageUtil.GetIntValue(kActor, "_SLH_iDivineMilkProducedTotal") as Int)
		MilkProducedTotal.SetValue((StorageUtil.GetIntValue(kActor, "_SLH_iMilkProducedTotal") as Int) + (StorageUtil.GetIntValue(kActor, "_SLH_iDivineMilkProducedTotal") as Int))
	Endif
		

	StorageUtil.SetFormValue( none , "_SD_iLastCowMilked", kActor)

	; Update breast size
	if hasBreasts(kActor)
		; Float fBreast  = 1.0 +  (fLactationBase * 0.2) + (fLactationLevel * 0.1) + (fLactationMilkDate * 0.15)
		Float fBreast  = (fLactationLevel * StorageUtil.GetFloatValue(kPlayer, "_SLS_breastMaxMilkFarm"  )) / 100.0

		; if (kActor == kPlayer)
		;	Debug.notification("[SLSDDi] Breast from milk level: " + fBreast)
		;	Debug.notification("[SLSDDi]     fLactationLevel:" + fLactationLevel)
		;	Debug.notification("[SLSDDi]     fLactationMilkDate:" + fLactationMilkDate)
		; endif

		If (StorageUtil.GetIntValue(none, "_SLH_iHormones")!=1) && (kActor == kPlayer)
			; if Hormones is detected, defer to mod event change for Hormones
			Float fCurrentWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")
			Float fNewWeight = fCurrentWeight + ((( (fLactationBase * 10.0) - fCurrentWeight) ) / 2.0 ) as Int

			StorageUtil.SetFloatValue(kActor, "_SLH_fBreast", fBreast ) 
			StorageUtil.SetFloatValue(kActor, "_SLH_fWeight", fNewWeight ) 
			; StorageUtil.SetIntValue(kActor, "_SLH_iForcedHairLoss", 1)
			; kActor.SendModEvent("SLHShaveHead")
			kActor.SendModEvent("SLHRefresh")
			
		else
			; Debug.Notification("[SLSDDi] Days since last milking: " + (fLactationMilkDate as Int))
			Bool bEnableBreast  = NetImmerse.HasNode(kActor, "NPC L Breast", false)

			if (fbreast > StorageUtil.GetFloatValue(kPlayer, "_SLS_breastMaxMilkFarm"  ))
				fBreast = StorageUtil.GetFloatValue(kPlayer, "_SLS_breastMaxMilkFarm"  )
			Endif
		 
		 	if (StorageUtil.GetIntValue(none, "_SLH_iHormones") == 1)
		 		kActor.SendModEvent("SLHSetNiNode","Breast",fBreast)
		 	else
				if (StorageUtil.GetIntValue(none, "_SLH_SlifON")==1)
					SLIF_inflateMax(kActor, "slif_belly", fBreast, NINODE_MAX_SCALE, SLS_KEY)

				elseif (bEnableBreast) || (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==1) 
					XPMSELib.SetNodeScale(kActor, true, NINODE_LEFT_BREAST, fBreast, SLS_KEY)
					XPMSELib.SetNodeScale(kActor, true, NINODE_RIGHT_BREAST, fBreast, SLS_KEY)
		
					; Debug.Notification("[SLSDDi] Updating breast size to " + fBreast)
				Endif
			endif
		endif

		If (StorageUtil.GetIntValue(none, "_SLH_iHormones")!=1)
			if (StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel")> StorageUtil.GetFloatValue( kActor , "_SLH_fLactationThreshold") ) 
				sendSlaveTatModEvent(kActor, "milkfarm","Milk Drip", bRefresh = True )
			else
				sendSlaveTatRemoveModEvent(kActor, "milkfarm","Milk Drip", bRefresh = True )
			endif

			if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneLactation")>80.0)
				sendSlaveTatModEvent(kActor, "milkfarm","Milk Veins", iColor = 0x99184f6b, bRefresh = True )
			else
				sendSlaveTatRemoveModEvent(kActor, "milkfarm","Milk Veins", bRefresh = True )
			endif
		else
			kActor.SendModEvent("SLHTryHormoneTats")
		endif

		; Milk Mod Economy integration - register NPC as Milk Maid after their first bottle produced in Stories
		if ( (StorageUtil.GetFloatValue(kActor,"MME.MilkMaid.BreastCount")>0.0) && ((StorageUtil.GetIntValue(kActor, "_SLH_iMilkProducedTotal") + StorageUtil.GetIntValue(kActor, "_SLH_iDivineMilkProducedTotal"))>0) )

			;Send Add MilkSlave Event
			int MME_AddMilkSlave = ModEvent.Create("MME_AddMilkSlave")
			if (MME_AddMilkSlave)
				ModEvent.PushForm(MME_AddMilkSlave, kActor)
				ModEvent.Send(MME_AddMilkSlave)
			endif

		endif
		; Dynamic skin gets reset after each game load - canceling this feature for now.
		; If (iIndex != -1) 
			; pActorBase.SetSkin(MilkFarmCowSkin)
			; pLeveledActorBase.SetSkin(MilkFarmCowSkin)
			; kActor.UpdateWeight(0)
		; endif

	EndIf


	; debugTrace(" Receiving Milk Cow update event")
	; Debug.Notification("[SLSDDi] Check for NiOverride: " + isNiOInstalled)
	; Debug.Notification("[SLSDDi] Check for Female actor: " + pActorBase.GetSex())
	; Debug.Notification("[SLSDDi] Check for Lactating actor: " + StorageUtil.GetIntValue(kActor, "_SLH_iLactating"))
	debugTrace(" Milk level: " + StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel"))
	debugTrace(" Lactation Hormone level: " + iLactationHormoneLevel)

EndFunction

Function UpdateMilkAfterSex(Actor kActor)
	Actor kPlayer = Game.GetPlayer() 
	Float fLactationHormoneMod = 0.1
	Float fLactationHormoneLevel = StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactation") 
	Int	iLactationHormoneLevel = fLactationHormoneLevel  as Int
	Int iMilkProductionMod = 1 + (iLactationHormoneLevel / 20) ; should be between 1 and 6, to accelerate milk production Lactation hormone is high

	debugTrace(" UpdateMilkAfterSex - Actor: " + kActor)
	debugTrace(" 	iMilkProductionMod: " + iMilkProductionMod)

	if (kActor == kPlayer) && (isMale(kPlayer))
		debugTrace(" Actor is Player and Male - Aborting UpdateMilkAfterSex.")
		Return
	endif

	StorageUtil.SetFormValue( none , "_SD_iLastCowMilked", kActor)
 
	If (!StorageUtil.HasIntValue(kActor, "_SLH_iMilkLevel"))
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", 0)
	Endif
	If (!StorageUtil.HasIntValue(kActor, "_SLH_iMilkProduced"))
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkProduced", 0)
	Endif


	If ( kActor.WornHasKeyword(SLSD_CowHarness) && ( Utility.RandomInt(0,100) > (100 - iLactationHormoneLevel*2 - slaUtil.GetActorExposure(kActor))  ) ) || kActor.WornHasKeyword(SLSD_CowMilker) 
		debugTrace(" Milk level increase from harness.")

		; Hormones compatibility
		if (kActor == kPlayer)
			Debug.Notification("Your breasts are swelling from a strong rush of milk.")
		else
			Debug.Notification("The cow's breasts are swelling from a strong rush of milk.")
		endif

		If (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1) 
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") + (iMilkProductionMod) + ((iMilkProductionMod)/2) + 1)
			; StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 4)
			fLactationHormoneMod = fLactationHormoneMod + 4.0

		else
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") + (iMilkProductionMod ) + 1)
			; StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 3)
			fLactationHormoneMod = fLactationHormoneMod + 3.0

		endIf

	ElseIf ( !kActor.WornHasKeyword(SLSD_CowHarness) && !kActor.WornHasKeyword(SLSD_CowMilker) && ( Utility.RandomInt(0,100) > (100 - iLactationHormoneLevel - slaUtil.GetActorExposure(kActor))  ) )  || (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1)

		debugTrace(" Milk level increase from manual stimulation")
		; Hormones compatibility
		if (kActor == kPlayer)
			Debug.Notification("Your breasts are tingling from a small rush of milk.")
		else
			Debug.Notification("The cow's breasts are tingling from a small rush of milk.")
		endif

		if (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1)
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") + (iMilkProductionMod ) + 1 )
			; StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 3)
			fLactationHormoneMod = fLactationHormoneMod + 3.0

		elseif (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") != 1)
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") + ((iMilkProductionMod) / 2) + 1+ 1 )
			; StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 2)
			fLactationHormoneMod = fLactationHormoneMod + 2.0
		endif
	Else
		debugTrace(" Actor can't produce enough milk to fill the suction cup. Exposure trigger: " + slaUtil.GetActorExposure(kActor))

		if (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1)
			; StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 2)
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") + ((iMilkProductionMod) / 2) + 1 )
			fLactationHormoneMod = fLactationHormoneMod + 2.0

		elseif (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") != 1)
			; StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 1)
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") + ((iMilkProductionMod) / 4) + 1 )
			fLactationHormoneMod = fLactationHormoneMod + 1.0
		endif

	EndIf

	; kActor.SendModEvent("_SLSDDi_UpdateCow")
	kActor.SendModEvent("SLHModHormone", "Lactation", fLactationHormoneMod )
 
	updateCowStatus(kActor, "AfterSex", 0)

	debugTrace(" Actor Hormone mod: " + fLactationHormoneMod  as Int )
	debugTrace(" Actor Lactation Hormone level: " + StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactation")  as Int )
	debugTrace(" Actor SLHModHormone Lactation: " + StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneLactation"))
	debugTrace(" Actor Milk level: " + StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel"))
	debugTrace(" Actor Milk produced: " + StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced"))


EndFunction

Function UpdateMilkAfterOrgasm(Actor kActor, Int iMilkDateOffset)
	Actor kPlayer = Game.GetPlayer()
	Float fLactationHormoneMod = 0.1
	Int iEmptyBottleCount
	Bool bGotMilk = false
	Float fLactationHormoneLevel = StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactation") 
	Float fLactationThreshold = StorageUtil.GetFloatValue( kActor , "_SLH_fLactationThreshold") 
	Int	iLactationHormoneLevel = fLactationHormoneLevel  as Int
	Int iMilkProductionMod = 1 + (iLactationHormoneLevel / 20) ; should be between 1 and 6, to accelerate milk production Lactation hormone is high
	Int iMilkLevel = StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel")

	debugTrace(" UpdateNPCMilkAfterOrgasm - Actor: " + kActor)

	if (kActor == kPlayer) && (isMale(kPlayer))
		debugTrace(" Actor is Player and Male - Aborting UpdateMilkAfterOrgasm.")
		Return
	endif

	MILK_LEVEL_TRIGGER = 50 + (fLactationThreshold as Int)

	if (MILK_LEVEL_TRIGGER > 90)
		MILK_LEVEL_TRIGGER = 90
	endif

	debugTrace("   iMilkLevel: " + iMilkLevel)
	debugTrace("   iMilkDateOffset: " + iMilkDateOffset)
	debugTrace(" 	MILK_LEVEL_TRIGGER: " + MILK_LEVEL_TRIGGER)

	; Add 10% chance of milking for each day since last milking
	If ( (iMilkLevel + (iMilkDateOffset * 10)) >= MILK_LEVEL_TRIGGER)
		; 
		debugTrace(" 	>>> Milk is expressed ")

		libs.Pant(kActor)
		;	ApplySweatFX.RemoteCast(kActor as ObjectReference, kActor,kActor as ObjectReference)

		iEmptyBottleCount = kPlayer.GetItemCount(EmptyMilk)

		if (iEmptyBottleCount>=1)
			kPlayer.RemoveItem(EmptyMilk, 1)
			GetMilk(kActor, 1)	
			libs.SexlabMoan(kActor)	

			If  (kActor.WornHasKeyword(SLSD_CowHarness) || kActor.WornHasKeyword(SLSD_CowMilker))
				Debug.Notification("The suction cups extract enough milk for a bottle.")
			else
				if (kActor == kPlayer)
					Debug.Notification("Your breasts release enough milk for a bottle.")
				else
					Debug.Notification("Her breasts release enough milk for a bottle.")
				endif
			endif

		else
			if (kActor == kPlayer)
				Debug.Notification("Milk spills all over your chest.")
			else
				Debug.Notification("Milk spills all over her chest.")
			endif

			; SexLab.AddCum(kActor,False,True,False)
			If (StorageUtil.GetIntValue(none, "_SLH_iHormones")!=1)
				if (StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel")> StorageUtil.GetFloatValue( kActor , "_SLH_fLactationThreshold") ) 
					sendSlaveTatModEvent(kActor, "milkfarm","Milk Drip", bRefresh = True )
				else
					sendSlaveTatRemoveModEvent(kActor, "milkfarm","Milk Drip", bRefresh = True )
				endif

				if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneLactation")>80.0)
					sendSlaveTatModEvent(kActor, "milkfarm","Milk Veins", iColor = 0x99184f6b, bRefresh = True )
				else
					sendSlaveTatRemoveModEvent(kActor, "milkfarm","Milk Veins", bRefresh = True )
				endif
			else
				kActor.SendModEvent("SLHTryHormoneTats")
			endif

			If (DivineCheeseQuest.GetStageDone(47)) && (!DivineCheeseQuest.GetStageDone(48)) && (!DivineCheeseQuest.GetStageDone(49))
				; Enable dialogues about Farm Items for sale
				DivineCheeseQuest.SetStage(48)
			endif
		endif

		if  (kActor.WornHasKeyword(SLSD_CowHarness) || kActor.WornHasKeyword(SLSD_CowMilker))
			; StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 2)	
			fLactationHormoneMod = fLactationHormoneMod +2.0
		Else
			; StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 1)	
			fLactationHormoneMod = fLactationHormoneMod + 1.0
		endif

		kActor.SendModEvent("SLHModHormone", "Lactation", fLactationHormoneMod )

		; 2021-02-11 - Replace by mod events to Hormones fetish system eventually
		If  (StorageUtil.GetIntValue(none, "_SLS_fetishID") == 10 )
			slaUtil.UpdateActorExposure(kActor, 10, "producing breast milk as a cow.")
		Else
			slaUtil.UpdateActorExposure(kActor, -20, "producing breast milk as a cow.")
		EndIf

		debugTrace(" Actor Milk Produced: " + StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced"))
		debugTrace(" Actor Divine Milk Produced: " + StorageUtil.GetIntValue(kActor, "_SLH_iDivineMilkProduced"))

		; kActor.SendModEvent("_SLSDDi_UpdateCow","Milk")
		updateCowStatus(kActor,"Milk",1)

	EndIf

EndFunction

Function UpdateMilkFromMachine(Actor kActor, ObjectReference akFurniture)
	; Only Player Actor for now

	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor kPlayer= Game.GetPlayer()
	Actor LeonaraActor = LeonaraRef as Actor
	Form fFurniture = akFurniture.GetBaseObject()
	String sFurnitureName = fFurniture.GetName()
	Float fBreastScale 
	Int iCounter=0
	Int iRandomEvent
	Int iTimer
	Float fLactationHormoneLevel = StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactation") 
	Int	iLactationHormoneLevel = fLactationHormoneLevel  as Int
	Float fLactationHormoneMod = 0.1
	Int iMilkProductionMod = 1 + (iLactationHormoneLevel / 20) ; should be between 1 and 6, to accelerate milk production Lactation hormone is high
	Int iMilkLevel = StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel")
	Int iNumBottles

	debugTrace(" UpdateMilkFromMachine - Actor: " + kActor)
	debugTrace("     	NINODE_LEFT_BREAST: " + NetImmerse.HasNode(kActor, NINODE_LEFT_BREAST, false))
	debugTrace("     	checkHasBreasts(kActor): " + checkHasBreasts(kActor))
	debugTrace("     	isFemale(kActor): " + isFemale(kActor))

	if (!checkHasBreasts(kActor))
		debugTrace(" Actor doesn't have breasts - Aborting UpdateMilkFromMachine.")
		Debug.notification("The suction cups don't seem to fit.")
		Return
	endif
	
	if (sFurnitureName == "Dwarven Milking Machine")  && (akFurniture.GetActorOwner() == LeonaraActor.GetActorBase() )
		; Debug.Notification("We just sat on " + sFurnitureName)
		; Debug.Messagebox("The " + sFurnitureName + " painfully sucks and tugs at your nipples, leaving both your breasts and your body drained.")
		 

		; MilkOMaticSoundFX.Enable()
		Debug.Notification("The milker restraints lock in place.")
		if (kActor == kPlayer)
			Game.DisablePlayerControls(abActivate = true)
		endif

		iCounter = 30 + Utility.RandomInt(0,60)
		While (iCounter>0)
			iRandomEvent = Utility.RandomInt(0,100)
			iTimer = 1 + iCounter  / 60

			if (iRandomEvent>70)
				SteamSoundFX.play(kActor) 
				libs.SexlabMoan(kActor)
				Utility.Wait(2.0)

			elseif (iRandomEvent>40)
				MachineSoundFX.play(kActor) 
				libs.Pant(kActor)
				Utility.Wait(1.0)

			elseif (iRandomEvent>20)
				Debug.Notification("Milk is pumping into the machine.. " + iTimer + " m left")
				Debug.Notification("Milk counter: " + iCounter )
				SuctionSoundFX.play(kActor) 
				Utility.Wait(1.0)
				libs.Moan(kActor)
			endif

			iCounter = iCounter - 1
		EndWhile
		Debug.Notification("The milker restraints are released.")

		if (kActor == kPlayer)
			Game.EnablePlayerControls(abActivate = true)
		endif

		; MilkOMaticSoundFX.Disable()

		; StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 4)	
		fLactationHormoneMod = fLactationHormoneMod + 4.0

		if (iMilkLEvel >= 10)
			Debug.Notification("The milker successfully produced a bottle.")
			debugTrace(" Milk Produced: " + StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced"))
			debugTrace(" Divine Milk Produced: " + StorageUtil.GetIntValue(kActor, "_SLH_iDivineMilkProduced"))


			GetMilk(kActor, 1)		
			updateCowStatus(kActor,"Milk",1)
		else
			Debug.Notification("There is not enough milk left to extract.")

		endif

		; kActor.SendModEvent("_SLSDDi_UpdateCow","Milk")
		kActor.SendModEvent("SLHModHormone", "Lactation", fLactationHormoneMod )


	Elseif (sFurnitureName == "Dwarven Milking Machine II") && (akFurniture.GetActorOwner() == LeonaraActor.GetActorBase() )
		; Debug.Notification("We just sat on " + sFurnitureName)
		; Debug.Messagebox("The " + sFurnitureName + " painfully sucks and tugs at your nipples, leaving you drained both mentally and physically.")
 

		; MilkOMaticSoundFX.Enable()
		Debug.Notification("The milker restraints lock in place.")
		if (kActor == kPlayer)
			Game.DisablePlayerControls(abActivate = true)
		endif

		iCounter = ( 10 + Utility.RandomInt(0,20)) * (1 + (iMilkLevel / 12)) as Int
		While (iCounter>0)
			iRandomEvent = Utility.RandomInt(0,100)
			iTimer = 1 + iCounter  / 60

			if (iRandomEvent>80)
				SteamSoundFX.play(kActor)
				libs.SexlabMoan(kActor)
				Utility.Wait(2.0)

			elseif (iRandomEvent>60)
				MachineSoundFX.play(kActor)
				libs.Moan(kActor)
				Utility.Wait(2.0)

			elseif (iRandomEvent>40)
				MachineSoundFX.play(kActor)
				libs.Pant(kActor)
				Utility.Wait(3.0)

			elseif (iRandomEvent>20)
				Debug.Notification("Milk is pumping into the machine.. " + iTimer + " m left")
				Debug.Notification("Milk counter: " + iCounter )
				SuctionSoundFX.play(kActor) 
				libs.Moan(kActor)
			endif

			iCounter = iCounter - 1
		EndWhile
		Debug.Notification("The milker restraints are released.")
		if (kActor == kPlayer)
			Game.EnablePlayerControls(abActivate = true)
		endif
		; MilkOMaticSoundFX.Disable() 

		; StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 7)	
		fLactationHormoneMod = fLactationHormoneMod + 8.0

		if (iMilkLEvel >= 10)

			if (kActor == kPlayer)
				Debug.Notification("The milker successfully drained you of your milk.")
			else
				Debug.Notification("The milker successfully drained her.")
			endif

			iNumBottles = iMilkLevel / 12

			debugTrace(" Milk Produced: " + StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced"))
			debugTrace(" Divine Milk Produced: " + StorageUtil.GetIntValue(kActor, "_SLH_iDivineMilkProduced"))

			; SLSD_MilkOMaticSpell2.Remotecast(PlayerREF,kActor,PlayerREF)
			
			GetMilk(kActor, iNumBottles)		
			updateCowStatus(kActor,"Milk",iNumBottles)
		else
			Debug.Notification("There is not enough milk left to extract.")
		endif

		; kActor.SendModEvent("_SLSDDi_UpdateCow","Milk")
		kActor.SendModEvent("SLHModHormone", "Lactation", fLactationHormoneMod )
	EndIf


EndFunction

Function GetMilk(Actor kActor, Int iNumberBottles=1)
	; Manages production of new milk bottles - decrease in milk level is handled in cow status update function

 	Actor kPlayer= Game.GetPlayer() as Actor
	Float fLactationHormoneLevel = StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactation") 

	; --------
	debugTrace(" GetMilk - Actor: " + kActor)
	; debugTrace(" _SLH_iMilkProduced: " + StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced"))
	; debugTrace(" _SLH_iDivineMilkProduced: " + StorageUtil.GetIntValue(kActor, "_SLH_iDivineMilkProduced"))

	; _SLH_iMilkProducedTotal - indexed on the Player. Total amount produced across all cows
	; debugTrace(" _SLH_iMilkProducedTotal: " + StorageUtil.GetIntValue(kPlayer, "_SLH_iMilkProducedTotal"))

	debugTrace(" iNumberBottles: " + iNumberBottles)

	if (kActor == kPlayer) && (isMale(kPlayer))
		debugTrace(" Actor is Player and Male - Aborting GetMilk.")
		Return
	endif
	
	If (fLactationHormoneLevel >= 90.0)
		kPlayer.AddItem(DivineMilk, iNumberBottles)	
		StorageUtil.SetIntValue(kActor, "_SLH_iDivineMilkProduced", StorageUtil.GetIntValue(kActor, "_SLH_iDivineMilkProduced") + iNumberBottles)
		StorageUtil.SetIntValue(kPlayer, "_SLH_iDivineMilkProducedTotal", StorageUtil.GetIntValue(kPlayer, "_SLH_iDivineMilkProducedTotal") + iNumberBottles)	
	Else
		kPlayer.AddItem(Milk, iNumberBottles)	
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkProduced", StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced") + iNumberBottles)
		StorageUtil.SetIntValue(kPlayer, "_SLH_iMilkProducedTotal", StorageUtil.GetIntValue(kPlayer, "_SLH_iMilkProducedTotal") + iNumberBottles)	
	Endif

	; _SLH_iMilkProducedTotal - indexed on the Player. Total amount produced across all cows
	iTotalMilkProduced = (StorageUtil.GetIntValue(kPlayer, "_SLH_iMilkProducedTotal") as Int) + (StorageUtil.GetIntValue(kPlayer, "_SLH_iDivineMilkProducedTotal") as Int)


	; Trigger quest stages based on milk production
	if ( (DivineCheeseQuest.GetStageDone(20)) && (!DivineCheeseQuest.GetStageDone(100)) && ( iTotalMilkProduced >= 5) ) 
		; Ask to improve lactation
	    DivineCheeseQuest.SetStage(100)
	endif

	if ( (DivineCheeseQuest.GetStageDone(20)) && (!DivineCheeseQuest.GetStageDone(200)) && ((StorageUtil.GetIntValue(kPlayer, "_SLH_iDivineMilkProducedTotal") as Int) >= 1) ) 
		; Ask about Divine Milk
	    DivineCheeseQuest.SetStage(200)
	endif

	if ( (DivineCheeseQuest.GetStageDone(20)) && (!DivineCheeseQuest.GetStageDone(320)) && ((StorageUtil.GetIntValue(kPlayer, "_SLH_iDivineMilkProducedTotal") as Int) >= 5) ) 
		; Ask about improved production (milk machine)
	    DivineCheeseQuest.SetStage(320)
	endif

	if ( (DivineCheeseQuest.GetStageDone(20)) && (!DivineCheeseQuest.GetStageDone(330)) && ((StorageUtil.GetIntValue(kPlayer, "_SLH_iDivineMilkProducedTotal") as Int) >= 10) ) 
		; Ask about optimal production (milk machine mark II)
	    DivineCheeseQuest.SetStage(330)
	endif

	; Compatiblity with Fetish system
	If (kActor == kPlayer) && (StorageUtil.GetIntValue(none, "_SLS_fetishID") == 10 )
		slaUtil.UpdateActorExposure(kPlayer, 10, "producing breast milk as a cow.")
	Else
		slaUtil.UpdateActorExposure(kPlayer, -20, "producing breast milk as a cow.")
	EndIf

	; --------
	; debugTrace(" after _SLH_iMilkProduced: " + StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced"))
	; debugTrace(" after _SLH_iDivineMilkProduced: " + StorageUtil.GetIntValue(kActor, "_SLH_iDivineMilkProduced"))

	; _SLH_iMilkProducedTotal - indexed on the Player. Total amount produced across all cows
	; debugTrace(" after _SLH_iMilkProducedTotal: " + StorageUtil.GetIntValue(kPlayer, "_SLH_iMilkProducedTotal"))

EndFunction

Bool Function checkHasBreasts(Actor kActor)
	Bool bEnableLeftBreast  = NetImmerse.HasNode(kActor, NINODE_LEFT_BREAST, false) as Bool
	return bEnableLeftBreast
EndFunction

Function checkIfLactating(Actor kActor)
	ActorBase pActorBase = kActor.GetActorBase()
	Float fWeight = pActorBase.GetWeight()
	Float fBreast  = NetImmerse.GetNodeScale(kActor, NINODE_LEFT_BREAST, false)
	Float fLactationThreshold 
	Bool isLactating = false

	; High weight = lactation is easier
	; Large breasts nodes = lactation is easier
	fLactationThreshold = 40.0 - (fWeight / 10.0) - (fBreast * 10.0)

	if (fLactationThreshold<5.0)
		fLactationThreshold = 5.0
	endif

	If (StorageUtil.GetIntValue(kActor, "_SLH_iMilkCow") == 1)
		isLactating = true
	endif

	StorageUtil.SetFloatValue( kActor , "_SLH_fLactationThreshold", fLactationThreshold)

	; if (StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") > 0)
	;	isLactating = true
	; endif
	
	; debug.notification("[SLSDDi] Lactation threshold: " + fLactationThreshold)
	debugTrace(" Checking lactation for actor: " + kActor)
	debugTrace(" 	_SLH_fHormoneLactation: " + StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactation"))
	debugTrace(" 	Lactation threshold: " + fLactationThreshold)
	debugTrace(" 	fWeight: " + fWeight)
	debugTrace(" 	fBreast: " + fBreast)

	if (StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactation") > fLactationThreshold)
		isLactating = true
	endif

	if (isLactating)
		StorageUtil.SetIntValue(kActor, "_SLH_iLactating", 1)
	else
		StorageUtil.SetIntValue(kActor, "_SLH_iLactating", 0)
	endif
EndFunction

Function updateMilkDuringSexFlag(Int iFlagValue)
	GV_MilkDuringSex.SetValue(iFlagValue)
EndFunction

; -------------------------------------------------------------------
Function InitBusiness()
	Actor kBretonCow = BretonCowRef as Actor
	Actor kNordCow = NordCowRef as Actor

	If (!StorageUtil.HasIntValue(none, "_SLS_iMilkFarmBusiness"))
 
		InitFarmCow(BretonCowRef, "Breton cow") 
		kBretonCow.SendModEvent("SLHModHormone", "Lactation", 70.0 )

		InitFarmCow(NordCowRef, "Nord cow")  
		kNordCow.SendModEvent("SLHModHormone", "Lactation", 40.0 )

		StorageUtil.SetIntValue(none, "_SLS_iMilkFarmBusiness", 1)
		debugTrace(" [SLS] Milk Farm Business initialized")
	EndIf
	
	; Debug - for testing purposes - comment out on release
	; StorageUtil.SetFloatValue( kBretonCow , "_SLH_fHormoneLactation", 70.0)
	; StorageUtil.SetFloatValue( kNordCow , "_SLH_fHormoneLactation", 40.0)
EndFunction

Function UpdateBusiness()
	String sBusinessStatusMsg = "" 
	Actor kPlayer = Game.getPlayer()

	; First time init if mod updated from old version
	If (!StorageUtil.HasIntValue(none, "_SLS_iMilkFarmBusiness"))
		InitBusiness()
	endif
 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowNordAlias.GetReference(), "Nord cow") 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowBretonAlias.GetReference(), "Breton cow") 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowImperialAlias.GetReference(), "Imperial cow") 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowRedguardAlias.GetReference(), "Redguard cow") 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowBosmerAlias.GetReference(), "Bosmer cow") 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowDunmerAlias.GetReference(), "Dunmer cow") 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowAltmerAlias.GetReference(), "Altmer cow") 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowOrcAlias.GetReference(), "Orc cow") 

	if (StorageUtil.GetIntValue(kPlayer, "_SLH_iLactating") == 1)
		sBusinessStatusMsg += "\n Player: "  +  (StorageUtil.GetIntValue(kPlayer, "_SLH_iMilkProduced") + StorageUtil.GetIntValue(kPlayer, "_SLH_iDivineMilkProduced")) + " L: " +StorageUtil.GetIntValue(kPlayer, "_SLH_iMilkLevel") + " H: " + StorageUtil.GetFloatValue( kPlayer , "_SLH_fHormoneLactation")
	endif

	updateAllCows("")

	sBusinessStatusMsg += "\n Total Milk: " + (StorageUtil.GetIntValue( kPlayer, "_SLH_iMilkProducedTotal") + StorageUtil.GetIntValue( kPlayer, "_SLH_iDivineMilkProducedTotal"))

	if (StorageUtil.GetIntValue( kPlayer, "_SLH_iDivineMilkProducedTotal")>0)
		sBusinessStatusMsg += "\n Total Divine Milk: " + StorageUtil.GetIntValue( kPlayer, "_SLH_iDivineMilkProducedTotal")
	endif

	; sBusinessStatusMsg += "\n For the Nords and Imperials..." 

	debug.Trace(sBusinessStatusMsg)
	debug.MessageBox(sBusinessStatusMsg)
EndFunction

Function InitFarmCow(ObjectReference kCowActorRef, String sCowRace) 
	Actor kCowActor

	kCowActor = kCowActorRef as Actor 

	if (sCowRace == "Breton cow")
		SnowShodCowBretonAlias.ForceRefTo(kCowActorRef)
	elseif (sCowRace == "Nord cow") || (sCowRace == "nord cow")  ; somehow, a string can be automatically changed when passed as a variable. 'Nord' becomes 'nord'... 'Imperial' becomes 'IMPERIAL'
		SnowShodCowNordAlias.ForceRefTo(kCowActorRef)
	elseif (sCowRace == "Imperial cow") || (sCowRace == "IMPERIAL cow")  ; don't ask why - Papyrus is being a dick about this
		SnowShodCowImperialAlias.ForceRefTo(kCowActorRef)
	elseif (sCowRace == "Redguard cow")
		SnowShodCowRedguardAlias.ForceRefTo(kCowActorRef)
	elseif (sCowRace == "Bosmer cow")
		SnowShodCowBosmerAlias.ForceRefTo(kCowActorRef)
	elseif (sCowRace == "Dunmer cow")
		SnowShodCowDunmerAlias.ForceRefTo(kCowActorRef)
	elseif (sCowRace == "Altmer cow")
		SnowShodCowAltmerAlias.ForceRefTo(kCowActorRef)
	elseif (sCowRace == "Orc cow")
		SnowShodCowOrcAlias.ForceRefTo(kCowActorRef)
	endif

 	; Add cow to HucowsList for Dialogue conditions
	; Int iIndex = MilkFarmList.Find(kCowActor as Form)
	; If iIndex == - 1
	;	MilkFarmList.AddForm(kCowActor as Form)
 	; EndIf

  	if (!kCowActor.IsInFaction(HucowsFaction))
 		kCowActor.AddToFaction(HucowsFaction)
 	endif

 	if (!kCowActor.IsInFaction(MilkFarmCowsFaction))
 		kCowActor.AddToFaction(MilkFarmCowsFaction)
 	endif

	registerCow(kCowActor)

	kCowActor.EvaluatePackage()

Endfunction

String Function GetFarmCowStatus(ObjectReference kCowActorRef, String sCowRace)
	String sBusinessStatusMsg = ""
	Actor kCowActor = kCowActorRef as Actor

	if (kCowActorRef != None)
		sBusinessStatusMsg += "\n " + sCowRace + ": M: " +  (StorageUtil.GetIntValue(kCowActor, "_SLH_iMilkProduced") + StorageUtil.GetIntValue(kCowActor, "_SLH_iDivineMilkProduced"))  + " L: " +StorageUtil.GetIntValue(kCowActor, "_SLH_iMilkLevel") + " H: " + StorageUtil.GetFloatValue( kCowActor , "_SLH_fHormoneLactation")

		; If  (!kCowActor.WornHasKeyword(SLSD_CowHarness) && !kCowActor.WornHasKeyword(SLSD_CowMilker))
		;	kCowActor.SetOutfit(FarmCowOutfit)
		; endif
		
	  	if (!kCowActor.IsInFaction(HucowsFaction))
	 		kCowActor.AddToFaction(HucowsFaction)
	 	endif

	 	if (!kCowActor.IsInFaction(MilkFarmCowsFaction))
	 		kCowActor.AddToFaction(MilkFarmCowsFaction)
	 	endif
	else
		; sBusinessStatusMsg += "\n " + sCowRace + ": - " 
	endif


	debugTrace(" [SLS] GetFarmCowStatus - sCowRace: " + sCowRace)

	Return sBusinessStatusMsg
Endfunction

Function PayEnrolledCow(Actor kActor)
	Actor kPlayer = Game.GetPlayer()
	Int iPlayerGold = kPlayer.GetItemCount(Gold)
	Faction CrimeFaction = kActor.GetCrimeFaction()
	Form fActorForm = kActor as Form
	String sActorName = fActorForm.GetName()

	if (sActorName == "")
		sActorName = "her"
	endif

	if (kActor.GetRelationshipRank(kPlayer) >= 1) && (iPlayerGold > 10)
		kPlayer.RemoveItem(Gold, 10, True)
	  	Debug.Notification("You pay " + sActorName + " a fee of 10 gold.")

	elseif (kActor.GetRelationshipRank(kPlayer) == 3) && (iPlayerGold > 5)
		kPlayer.RemoveItem(Gold, 5, True)
	  	Debug.Notification("You pay " + sActorName + " a fee of 5 gold.")

	elseif (kActor.GetRelationshipRank(kPlayer) == 4) 
	  	; Debug.Notification("You may stimulate " + sActorName + " for free")

	else
		; Figure out what to do when player cannot pay enrolled cow
	  	Debug.Notification("You could not pay " + sActorName + " and she reported you.")

	  	if (CrimeFaction == None)
	  		CrimeFactionRiften.ModCrimeGold(5)
	  	Else
			CrimeFaction.ModCrimeGold(5)
		endif
	endIf
Endfunction


Function UpdateBalimundMerchantChest()
	If (DivineCheeseQuest.GetStageDone(49))
	; Test if it is possible to add items for sale dynamically by adding LeveledItems to container

 	;	BalimundMerchantChest.AddItem(EmptyMilk, 24)
 	;	BalimundMerchantChest.AddItem(cowHarnessInventory, 2)
 	endif
Endfunction


Function triggerCard(String sCardEvent) 
	Actor kPlayer = Game.Getplayer()

	CardSoundFX.play(kPlayer) 

	if (sCardEvent == "Trophies")
		TrophiesMarkerRef.enable()
		; cast wabbajack effect on sheo statue
		; WabbajackSpell.cast(kPlayer, WabbajackMarkerRef)
		Debug.Notification("What happened to the trophies?")

	elseif (sCardEvent == "Grummites")
		GrummitesMarkerRef.enable()
		Debug.Notification("The halls echo of wet grunts.")

	elseif (sCardEvent == "Skeevers")
		SkeeversMarkerRef.enable()
		Debug.Notification("Is that rats in the halls?")

	elseif (sCardEvent == "Knights")
		KnightsMarkerRef.enable()
		Debug.Notification("Something big is happening outside.")

	elseif (sCardEvent == "Wabbajack") 
		Debug.Notification("Booring! Let's change things a bit.")

		; Loop through ShiveringGroveHazards 
		; if random int and actor is not dead, cast wabbajack effect

		Int iIdx = 0
		Actor kActor
		While ( iIdx < ShiveringGroveHazards.Length )
			if (Utility.RandomInt(0,100)>10) 
				kActor = ShiveringGroveHazards[iIdx] as Actor
				if (!kActor.IsDead()) && (ShiveringGroveHazards[iIdx].IsEnabled()) 
					; Debug.Notification("Wabbajack! " + iIdx)
					WabbajackSpell.cast(ShiveringGroveHazards[iIdx], ShiveringGroveHazards[iIdx])
				; elseif (kActor.IsDead()) && (Utility.RandomInt(0,100)>50) 
					; kActor.Resurrect()
				; elseif (ShiveringGroveHazards[iIdx].IsEnabled()) && (Utility.RandomInt(0,100)>50) 
					; ShiveringGroveHazards[iIdx].disable()
				endif
			Else
				; Nothing happens
				; Debug.Notification("Nothing " + iIdx)
			Endif
			iIdx += 1
		EndWhile

	elseif (sCardEvent == "Random")

		; on randon int

		Int iNum = Utility.RandomInt(0,100)
 		int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do
		
		if (iNum>80) && (StorageUtil.GetIntValue(none, "_SLH_iHormones")!=1)
		; 	cast hormone scrambling effect
			Debug.Notification("You feel dizzy and very hot.")
			kPlayer.SendModEvent("SLHModHormoneRandom", "Succubus")

		elseif (iNum>60) && hasBreasts(kPlayer)
		; 	max milk level and lactation
			Debug.Notification("Your chest tingles.")

			kPlayer.SendModEvent("SLHModHormone", "Lactation", 100.0 )
			StorageUtil.SetIntValue(kPlayer, "_SLH_iMilkLevel", 100)
			updateCowStatus(kPlayer, sUpdateMode = "Silent", iNumberBottles=0)

		elseif (iNum>40) && (ECTrap)
		; 	cast EC dwemer machine (check if even in Stories for ELLE?)
			Debug.Notification("The ground shakes around you.")

	        ModEvent.PushForm(ECTrap, self)             ; Form (Some SendModEvent scripting "black magic" - required)
	        ModEvent.PushForm(ECTrap, kPlayer)          ; Form The animation target
	        ModEvent.PushInt(ECTrap, 1)    ; Int  The animation required    0 = Tentacles, 1 = Machine
	        ModEvent.PushBool(ECTrap, true)             ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	        ModEvent.Pushint(ECTrap, 500)               ; Int  Alarm radius in units (0 to disable) 
	        ModEvent.PushBool(ECTrap, true)             ; Bool Use EC (basic) crowd control on hostiles 
	        ModEvent.Send(ECtrap)

		elseif (iNum>20) && (!kPlayer.WornHasKeyword(SLSD_CowMilker))
		;  	equip harness if no harness on and female
			Debug.Notification("A milker appears on your chest.")
			PlayerReceivedAutoCowharness(kPlayer)
		else
			Debug.Notification("Isn't this fun?")
		endif

	Endif
 
Endfunction

; Requires SlaveTats Event Bridge
function sendSlaveTatModEvent(actor akActor, string sType, string sTatooName, int iColor = 0x99000000, bool bRefresh = False)
	; SlaveTats.simple_add_tattoo(bimbo, "Bimbo", "Tramp Stamp", last = false, silent = true)
  	int STevent = ModEvent.Create("STSimpleAddTattoo")  

  	if (STevent) 
  		debugTrace(" Applying slavetat: " + sTatooName)
  		debugTrace(" 	Applying actor: " + akActor)
        ModEvent.PushForm(STevent, akActor)      	; Form - actor
        ModEvent.PushString(STevent, sType)    	; String - type of tattoo?
        ModEvent.PushString(STevent, sTatooName)  	; String - name of tattoo
        ModEvent.PushInt(STevent, iColor)  			; Int - color
        ModEvent.PushBool(STevent, bRefresh)        	; Bool - last = false
        ModEvent.PushBool(STevent, true)         	; Bool - silent = true

        ModEvent.Send(STevent)
  	else
  		debugTrace(" Applying slavetat failed: " + sTatooName)
  		debugTrace(" Send slave tat event failed.")
	endIf
endfunction

function sendSlaveTatRemoveModEvent(actor akActor, string sType, string sTatooName, int iColor = 0x99000000, bool bRefresh = False)
	; akSlave.RemoveFromFaction( slaveFaction as Faction )
	int STevent = ModEvent.Create("STSimpleRemoveTattoo") 
	if (STevent)
  		debugTrace(" Clearing slavetat: " + sTatooName)
  		debugTrace(" 	Clearing actor: " + akActor)
	    ModEvent.PushForm(STevent, akActor)        ; Form - actor
	    ModEvent.PushString(STevent, sType)     	; String - tattoo section (the folder name)
	    ModEvent.PushString(STevent, sTatooName)    ; String - name of tattoo
	    ModEvent.PushBool(STevent, true)            ; Bool - last = false (the tattoos are only removed when last = true, use it on batches)
	    ModEvent.PushBool(STevent, true)            ; Bool - silent = true (do not show a message)
	    ModEvent.Send(STevent)
  	else
  		debugTrace(" Clearing slavetat failed: " + sTatooName)
  		debugTrace(" Send slave tat remove event failed.")
	endif
endfunction

; Local inflation support - defer to Hormones if available

function SLIF_inflate(Actor kActor, String sKey, float value, String NiOString)
	int SLIF_event = ModEvent.Create("SLIF_inflate")
	If (SLIF_event)
		ModEvent.PushForm(SLIF_event, kActor)
		ModEvent.PushString(SLIF_event, "SexLab Stories Devious")
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
		ModEvent.PushString(SLIF_event, "SexLab Stories Devious")
		ModEvent.PushString(SLIF_event, sKey)
		ModEvent.PushFloat(SLIF_event, maximum)
		ModEvent.Send(SLIF_event)
	EndIf	
endFunction

function SLIF_inflateMax(Actor kActor, String sKey, float value, float maximum, String NiOString)
	SLIF_setMax(kActor, sKey, maximum)
	SLIF_inflate(kActor, sKey, value, NiOString)
endFunction

; -------------------------------------------------------------------
Bool function isFemale(actor kActor)
	return (kActor.GetActorBase().GetSex() == 1)
EndFunction

Bool function isMale(actor kActor)
	return !isFemale(kActor)
EndFunction

Bool function hasBreasts(actor kActor)
	return NetImmerse.HasNode(kActor, "NPC L Breast", false)
EndFunction

 

Function debugTrace(string traceMsg)
	if (StorageUtil.GetIntValue(none, "_SLS_debugTraceON")==1)
	;	debugTrace("[SLSDDi_QST_CowLife]" + traceMsg)
	endif
endFunction
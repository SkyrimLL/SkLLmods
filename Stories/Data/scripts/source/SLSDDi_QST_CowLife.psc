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

Potion Property Milk Auto
Potion Property DivineMilk Auto

GlobalVariable Property GV_MilkLevel  Auto  
GlobalVariable Property GV_ProlactinLevel  Auto  

GlobalVariable Property MilkProduced  Auto  

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


Armor Property cowHarnessInventory Auto
Armor Property cowHarnessRendered Auto
Armor Property autoCowHarnessInventory Auto
Armor Property autoCowHarnessRendered Auto

Outfit Property FarmCowOutfit Auto

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
	Debug.MessageBox("The harness molds around your body, accentuating your breasts as the suction cups lock in around your nipples.")

	; EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
	libs.EquipDevice(kActor, cowHarnessInventory , cowHarnessRendered , SLS_CowHarness)
	; StorageUtil.SetIntValue(none, "_SLH_iLactating", 1)

	; SetStage(10)
	; SetObjectiveDisplayed(10)
EndFunction

Function PlayerRemovedCowharness( Actor kActor )
	libs.Log("PlayerLostCowharness ")
	
	; zaddsgBeltInexperiencedMsg.Show()
	Debug.MessageBox("The harness lets go of your sore nipples with a loud pop.")

	; EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
	libs.RemoveDevice(kActor, cowHarnessInventory , cowHarnessRendered , SLS_CowHarness)
	; StorageUtil.SetIntValue(none, "_SLH_iLactating", 0)

	; SetStage(10)
	; SetObjectiveDisplayed(10)
EndFunction

Function PlayerReceivedAutoCowharness( Actor kActor )
	libs.Log("PlayerReceivedAutoCowharness ")
	
	; zaddsgBeltInexperiencedMsg.Show()
	Debug.MessageBox("The harness molds around your body and starts humming, accentuating your breasts as the suction cups lock in around your nipples.")

	; EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
	libs.EquipDevice(kActor, autoCowHarnessInventory , autoCowHarnessRendered , SLS_CowMilker)
	; StorageUtil.SetIntValue(none, "_SLH_iLactating", 1)

	; SetStage(10)
	; SetObjectiveDisplayed(10)
EndFunction

Function PlayerRemovedAutoCowharness( Actor kActor )
	libs.Log("PlayerLostAutoCowharness ")
	
	; zaddsgBeltInexperiencedMsg.Show()
	Debug.MessageBox("The harness lets go of your swollen nipples with a loud pop.")

	; EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
	libs.RemoveDevice(kActor, autoCowHarnessInventory , autoCowHarnessRendered , SLS_CowMilker)
	; StorageUtil.SetIntValue(none, "_SLH_iLactating", 0)

	; SetStage(10)
	; SetObjectiveDisplayed(10)
EndFunction

Function registerCow(Actor kActor)
	If (StorageUtil.GetIntValue(kActor, "_SLH_iMilkCow") == 0)
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkCow", 1)
		StorageUtil.FormListAdd(none, "_SLH_lMilkCowList", kActor)
	endif

	if (StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") < 10)
		StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", Utility.RandomInt(2,10)) 
	endif
	
	StorageUtil.SetFloatValue( kActor , "_SLH_fHormoneLactation", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") as Float)
	StorageUtil.SetIntValue(kActor, "_SLH_iLactating", 1)

EndFunction

Function updateAllCows()
	Int valueCount = StorageUtil.FormListCount(none, "_SLH_lMilkCowList")
	int i = 0
	Form thisCow
 
 	Debug.Trace("[SLSDDi] Updating registered cows: " + valueCount)

	while(i < valueCount)
		thisCow = StorageUtil.FormListGet(none, "_SLH_lMilkCowList", i)
		updateCowStatus(thisCow as Actor, "NewDay")
		i = i + 1
	endwhile

EndFunction

Function updateCowStatus(Actor kActor, String bCreateMilk = "")
 	Actor PlayerActor= Game.GetPlayer() as Actor
 	ActorBase pActorBase
 	Int iProlactinLevel 

	If (kActor == None)
		kActor = PlayerActor
	EndIf

	Float fLactationBase = ( StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced") / 10) as Float
	Float fLactationLevel = ( StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") ) as Float
	Float fLactationMilkDate = ( Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(kActor, "_SLH_iMilkDate") ) as Float

	pActorBase = kActor.GetActorBase()

	checkIfLactating(kActor)

	if ( kActor.WornHasKeyword(SLSD_CowHarness) || kActor.WornHasKeyword(SLSD_CowMilker) ) && (!StorageUtil.HasIntValue(kActor, "_SLH_iLactating") || (StorageUtil.GetIntValue(kActor, "_SLH_iLactating") == 0) )
		StorageUtil.SetIntValue(kActor, "_SLH_iLactating", 1)
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", 0)
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkProduced", 0)
		StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", 10)
	endif

	If (!StorageUtil.HasIntValue(kActor, "_SLH_iMilkDate") || (StorageUtil.GetIntValue(kActor, "_SLH_iMilkDate") == 0) )
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkDate", Game.QueryStat("Days Passed"))
	Endif

	If (StorageUtil.GetIntValue(kActor, "_SLH_iMilkCow") == 0)
		registerCow(kActor)
	Endif

	If (bCreateMilk == "NewDay")
		iProlactinLevel = StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") 

		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_isPregnant") == 1) 
			iProlactinLevel = iProlactinLevel + 1
			StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") + 1)
		else
			iProlactinLevel = iProlactinLevel - 2
			If (Utility.RandomInt(0,100)> (100-iProlactinLevel))
				StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkLevel") + 1)
			endif
		endIf

		if (iProlactinLevel < 10)
			iProlactinLevel = 10
		endIf
		StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", iProlactinLevel )
	Endif

	; Debug.Trace("[SLSDDi] Receiving Milk Cow update event")
	; Debug.Notification("[SLSDDi] Check for NiOverride: " + isNiOInstalled)
	; Debug.Notification("[SLSDDi] Check for Female actor: " + pActorBase.GetSex())
	; Debug.Notification("[SLSDDi] Check for Lactating actor: " + StorageUtil.GetIntValue(kActor, "_SLH_iLactating"))
	Debug.Trace("[SLSDDi] Milk level: " + StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel"))
	Debug.Trace("[SLSDDi] Prolactin level: " + StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel"))

	if (pActorBase.GetSex()==1)
		; Debug.Notification("[SLSDDi] Days since last milking: " + (fLactationMilkDate as Int))
		Float fBreast  = 1.0 +  (fLactationBase * 0.2) + (fLactationLevel * 0.1) + (fLactationMilkDate * 0.15)
		if (fbreast > StorageUtil.GetFloatValue(PlayerActor, "_SLS_breastMaxMilkFarm"  ))
			fBreast = StorageUtil.GetFloatValue(PlayerActor, "_SLS_breastMaxMilkFarm"  )
		Endif
	 
		if (StorageUtil.GetIntValue(kActor, "_SLH_SlifON")==1)
			SLIF_inflateMax(kActor, "slif_belly", fBreast, NINODE_MAX_SCALE, SLS_KEY)

		elseif (StorageUtil.GetIntValue(kActor, "_SLH_NiNodeOverrideON")==1) 
			XPMSELib.SetNodeScale(kActor, true, NINODE_LEFT_BREAST, fBreast, SLS_KEY)
			XPMSELib.SetNodeScale(kActor, true, NINODE_RIGHT_BREAST, fBreast, SLS_KEY)

		Endif
		; Debug.Notification("[SLSDDi] Updating breast size to " + fBreast)
	
	EndIf

	If (bCreateMilk == "Milk") ; Milk bottle produced - reset timer
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkDate", Game.QueryStat("Days Passed"))

		iProlactinLevel = StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 2
		StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", iProlactinLevel )

	ElseIf (bCreateMilk == "Check") ; Messages from checking milk level
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

	If (kActor == PlayerActor)
		GV_MilkLevel.SetValue(StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") as Int)
		GV_ProlactinLevel.SetValue(StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") as Int)
	Endif

	StorageUtil.SetFormValue( none , "_SD_iLastCowMilked", kActor)
EndFunction

Function UpdateMilkAfterSex(Actor kActor)
	Actor kPlayer = Game.GetPlayer()
	Int iProlactinLevel 
	Float fLactiationHormoneMod = 0.1

	Debug.Trace("[SLSDDi] UpdateMilkAfterSex - Actor: " + kActor)
	StorageUtil.SetFormValue( none , "_SD_iLastCowMilked", kActor)

	iProlactinLevel = StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel")
	if (iProlactinLevel > 100)
		iProlactinLevel = 100
	endIf
	if (iProlactinLevel < 10)
		iProlactinLevel = 10
	endIf

	If (!StorageUtil.HasIntValue(kActor, "_SLH_iMilkLevel"))
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", 0)
	Endif
	If (!StorageUtil.HasIntValue(kActor, "_SLH_iMilkProduced"))
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkProduced", 0)
	Endif


	If ( kActor.WornHasKeyword(SLSD_CowHarness) && ( Utility.RandomInt(0,100) > (100 - iProlactinLevel*2 - slaUtil.GetActorExposure(kActor))  ) ) || kActor.WornHasKeyword(SLSD_CowMilker) 
		; Hormones compatibility
		if (kActor == kPlayer)
			Debug.Notification("Your breasts are swelling from a strong rush of milk.")
		else
			Debug.Notification("The cow's breasts are swelling from a strong rush of milk.")
		endif

		If (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1) 
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") + 3)
			StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 4)
			fLactiationHormoneMod = fLactiationHormoneMod + 1.0

		else
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") + 2)
			StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 3)
			fLactiationHormoneMod = fLactiationHormoneMod + 2.0

		endIf

	ElseIf ( !kActor.WornHasKeyword(SLSD_CowHarness) && !kActor.WornHasKeyword(SLSD_CowMilker) && ( Utility.RandomInt(0,100) > (100 - iProlactinLevel - slaUtil.GetActorExposure(kActor))  ) )  || (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1)
		; Hormones compatibility
		if (kActor == kPlayer)
			Debug.Notification("Your breasts are tingling from a small rush of milk.")
		else
			Debug.Notification("the cow's breasts are tingling from a small rush of milk.")
		endif

		if (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1)
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") + 2)
			StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 3)
			fLactiationHormoneMod = fLactiationHormoneMod + 0.5

		elseif (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") != 1)
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") + 1)
			StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 2)
			fLactiationHormoneMod = fLactiationHormoneMod + 1.0
		endif
	Else
		Debug.Trace("[SLSDDi] Actor can't produce enough milk to fill the suction cup. Exposure trigger: " + slaUtil.GetActorExposure(kActor))

		if (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1)
			StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 2)
			fLactiationHormoneMod = fLactiationHormoneMod + 0.2

		elseif (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") != 1)
			StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 1)
		endif

	EndIf

	; kActor.SendModEvent("_SLSDDi_UpdateCow")
	kActor.SendModEvent("SLHModHormone", "Lactation", Utility.RandomFloat(0.0,5.0))

	updateCowStatus(kActor)

	Debug.Trace("[SLSDDi] Actor Prolactin level: " + StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel"))
	Debug.Trace("[SLSDDi] Actor SLHModHormone Lactation: " + StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneLactation"))
	Debug.Trace("[SLSDDi] Actor Milk level: " + StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel"))
	Debug.Trace("[SLSDDi] Actor Milk produced: " + StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced"))


EndFunction

Function UpdateMilkAfterOrgasm(Actor kActor, Int iMilkDateOffset)
	Actor kPlayer = Game.GetPlayer()

	Debug.Trace("[SLSDDi] UpdateNPCMilkAfterOrgasm - Actor: " + kActor)

	If ( (StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") + iMilkDateOffset) >= MILK_LEVEL_TRIGGER)
		If  (kActor.WornHasKeyword(SLSD_CowHarness) || kActor.WornHasKeyword(SLSD_CowMilker))
			if (kActor == kPlayer)
				Debug.Notification("The suction cups painfully clench around your tits.")
			else
				Debug.Notification("The suction cups painfully clench around her tits.")
			endif

			GetMilk(kActor, 1)	
			libs.SexlabMoan(kActor)	
		else
			libs.Pant(kActor)
			StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel",  StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel") / 2)	
		;	ApplySweatFX.RemoteCast(kActor as ObjectReference, kActor,kActor as ObjectReference)
			SexLab.AddCum(kActor,False,True,False)

			if (kActor == kPlayer)
				Debug.Notification("Milk spills all over your chest.")
			else
				Debug.Notification("Milk spills all over her chest.")
			endif
		Endif

		If  (StorageUtil.GetIntValue(none, "_SLS_fetishID") == 10 )
			slaUtil.UpdateActorExposure(kActor, 10, "producing breast milk as a cow.")
		Else
			slaUtil.UpdateActorExposure(kActor, -20, "producing breast milk as a cow.")
		EndIf

		if  (kActor.WornHasKeyword(SLSD_CowHarness) || kActor.WornHasKeyword(SLSD_CowMilker))
			StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 2)	
		Else
			StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") + 1)	
		endif

		Debug.Trace("[SLSDDi] Actor Milk Produced: " + StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced"))
		Debug.Trace("[SLSDDi] Actor Milk Total: " + StorageUtil.GetIntValue(kActor, "_SLH_iMilkProducedTotal"))

		; kActor.SendModEvent("_SLSDDi_UpdateCow","Milk")
		updateCowStatus(kActor,"Milk")

	EndIf

EndFunction

Function UpdateMilkFromMachine(ObjectReference akFurniture)
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

		StorageUtil.SetIntValue(PlayerActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iProlactinLevel") + 4)	

		Debug.Trace("[SLSDDi] NPC Milk Produced: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced"))
		Debug.Trace("[SLSDDi] NPC Milk Total: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProducedTotal"))

		GetMilk(PlayerActor, 1)		

		If  (StorageUtil.GetIntValue(none, "_SLS_fetishID") == 10 )
			slaUtil.UpdateActorExposure(PlayerActor, 10, "producing breast milk as a cow.")
		Else
			slaUtil.UpdateActorExposure(PlayerActor, -20, "producing breast milk as a cow.")
		EndIf

		; PlayerActor.SendModEvent("_SLSDDi_UpdateCow","Milk")
		updateCowStatus(PlayerActor,"Milk")


	Elseif (sFurnitureName == "Dwarven Milking Machine II") && (akFurniture.GetActorOwner() == LeonaraActor.GetActorBase() )
		; Debug.Notification("We just sat on " + sFurnitureName)
		; Debug.Messagebox("The " + sFurnitureName + " painfully sucks and tugs at your nipples, leaving you drained both mentally and physically.")

		; Hormones compatibility

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

		StorageUtil.SetIntValue(PlayerActor, "_SLH_iProlactinLevel", StorageUtil.GetIntValue(PlayerActor, "_SLH_iProlactinLevel") + 7)	

		Debug.Trace("[SLSDDi] NPC Milk Produced: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProduced"))
		Debug.Trace("[SLSDDi] NPC Milk Total: " + StorageUtil.GetIntValue(PlayerActor, "_SLH_iMilkProducedTotal"))


		; SLSD_MilkOMaticSpell2.Remotecast(PlayerREF,PlayerActor,PlayerREF)
		
		GetMilk(PlayerActor, 2)		

		If  (StorageUtil.GetIntValue(none, "_SLS_fetishID") == 10 )
			slaUtil.UpdateActorExposure(PlayerActor, 10, "producing breast milk as a cow.")
		Else
			slaUtil.UpdateActorExposure(PlayerActor, -20, "producing breast milk as a cow.")
		EndIf

		; PlayerActor.SendModEvent("_SLSDDi_UpdateCow","Milk")
		updateCowStatus(PlayerActor,"Milk")
	EndIf


EndFunction

Function GetMilk(Actor kActor, Int iNumberBottles=1)
 	Actor PlayerActor= Game.GetPlayer() as Actor

	If (StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") >= 100)
		PlayerActor.AddItem(DivineMilk, iNumberBottles)	
		StorageUtil.SetIntValue(kActor, "_SLH_iDivineMilkProduced", StorageUtil.GetIntValue(kActor, "_SLH_iDivineMilkProduced") +1)
	Else
		PlayerActor.AddItem(Milk, iNumberBottles)	
		StorageUtil.SetIntValue(kActor, "_SLH_iMilkProduced", StorageUtil.GetIntValue(kActor, "_SLH_iMilkProduced") +1)
	Endif

	StorageUtil.SetIntValue(kActor, "_SLH_iMilkLevel", 0)	
	StorageUtil.SetIntValue(kActor, "_SLH_iMilkProducedTotal", StorageUtil.GetIntValue(kActor, "_SLH_iMilkProducedTotal") +1)	
EndFunction

Function checkIfLactating(Actor kActor)
	Bool isLactating = false

	If (StorageUtil.GetIntValue(kActor, "_SLH_iMilkCow") == 1)
		isLactating = true
	endif

	if (StorageUtil.GetIntValue(kActor, "_SLH_iProlactinLevel") > 0)
		isLactating = true
	endif
	
	if (StorageUtil.GetFloatValue( kActor , "_SLH_fHormoneLactation") > 0.0)
		isLactating = true
	endif

	if (isLactating)
		StorageUtil.SetIntValue(kActor, "_SLH_iLactating", 1)
	else
		StorageUtil.SetIntValue(kActor, "_SLH_iLactating", 0)
	endif
EndFunction

; -------------------------------------------------------------------
Function InitBusiness()
	If (!StorageUtil.HasIntValue(none, "_SLS_iMilkFarmBusiness"))
 
		InitFarmCow(BretonCowRef, "Breton") 
		InitFarmCow(NordCowRef, "Nord")  

		StorageUtil.SetIntValue(none, "_SLS_iMilkFarmBusiness", 1)
		Debug.Trace("[SLS] Milk Farm Business initialized")
	EndIf
EndFunction

Function UpdateBusiness()
	String sBusinessStatusMsg = "" 

	; First time init if mod updated from old version
	If (!StorageUtil.HasIntValue(none, "_SLS_iMilkFarmBusiness"))
		InitBusiness()
	endif
 
	iTotalMilkProduced = 0
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowBretonAlias.GetReference(), "Breton") 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowNordAlias.GetReference(), "Nord") 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowImperialAlias.GetReference(), "Imperial") 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowRedguardAlias.GetReference(), "Redguard") 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowBosmerAlias.GetReference(), "Bosmer") 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowDunmerAlias.GetReference(), "Dunmer") 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowAltmerAlias.GetReference(), "Altmer") 
	sBusinessStatusMsg += GetFarmCowStatus(SnowShodCowOrcAlias.GetReference(), "Orc") 

	iTotalMilkProduced += StorageUtil.GetIntValue(game.getplayer(), "_SLH_iMilkProducedTotal")
	sBusinessStatusMsg += "\n Player: " +  iTotalMilkProduced + " Milk Bottle"

	updateAllCows()

	sBusinessStatusMsg += "\n Total Milk Produced: " + iTotalMilkProduced

	debug.MessageBox(sBusinessStatusMsg)
EndFunction

Function InitFarmCow(ObjectReference kCowActorRef, String sCowRace) 
	Actor kCowActor

	kCowActor = kCowActorRef as Actor 

	if (sCowRace == "Breton")
		SnowShodCowBretonAlias.ForceRefTo(kCowActorRef)
	elseif (sCowRace == "Nord")
		SnowShodCowNordAlias.ForceRefTo(kCowActorRef)
	elseif (sCowRace == "Imperial")
		SnowShodCowImperialAlias.ForceRefTo(kCowActorRef)
	elseif (sCowRace == "Redguard")
		SnowShodCowRedguardAlias.ForceRefTo(kCowActorRef)
	elseif (sCowRace == "Bosmer")
		SnowShodCowBosmerAlias.ForceRefTo(kCowActorRef)
	elseif (sCowRace == "Dunmer")
		SnowShodCowDunmerAlias.ForceRefTo(kCowActorRef)
	elseif (sCowRace == "Altmer")
		SnowShodCowAltmerAlias.ForceRefTo(kCowActorRef)
	elseif (sCowRace == "Orc")
		SnowShodCowOrcAlias.ForceRefTo(kCowActorRef)
	endif

	registerCow(kCowActor)

	kCowActor.EvaluatePackage()

Endfunction

String Function GetFarmCowStatus(ObjectReference kCowActorRef, String sCowRace)
	String sBusinessStatusMsg = ""

	if (kCowActorRef != None)
		iTotalMilkProduced += StorageUtil.GetIntValue(kCowActorRef as Actor, "_SLH_iMilkProducedTotal")
		sBusinessStatusMsg += "\n " + sCowRace + " cow: " +  iTotalMilkProduced + " Milk Bottle"

		(kCowActorRef as Actor).SetOutfit(FarmCowOutfit)
	else
		sBusinessStatusMsg += "\n " + sCowRace + " cow: X " 
	endif

	Return sBusinessStatusMsg
Endfunction


 
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

 
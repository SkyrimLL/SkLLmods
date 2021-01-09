Scriptname SLH_fctHormonesLevels extends Quest  

Import Utility
Import Math

SLH_fctUtil Property fctUtil Auto


; Pigmentation 	- _SLH_fHormonePigmentation 	- speed of skin color change
; Growth 		- _SLH_fHormoneGrowth 			- speed of weight change
; Metabolism 	- _SLH_fHormoneMetabolism 		- gain / burn fat / resistance to heat loss / used as switch for body transformation
; Sleep 		- _SLH_fHormoneSleep 			- need to sleep / stamina
; Hunger 		- _SLH_fHormoneHunger 			- need to eat
; Immunity 		- _SLH_fHormoneImmunity 		- resistance to disease
; Stress 		- _SLH_fHormoneStress 			- fight or flight / boost health
; Mood 			- _SLH_fHormoneMood 			- focus / boost to magica/skill gain
; Female 		- _SLH_fHormoneFemale 			- breast/butt growth / fertility
; Male 			- _SLH_fHormoneMale 			- schlong growth / fertility / muscles / facial hair
; SexDrive 		- _SLH_fHormoneSexDrive 		- personal arousal
; Pheromones 	- _SLH_fHormonePheromones 		- attraction from others / coveted effect
; Lactation 	- _SLH_fHormoneLactation 		- breast growth / milk production

; API - Inside Hormones
; 		fctHormones.modHormoneLevel(PlayerActor, "Pheromones", 1.0)

; API - Outside Hormones (player actor only for now)
; 		SendModEvent("SLHModHormone", "Pheromones", 1.0)

function initHormonesLevels(Actor kActor)

	debugTrace("    :: Init Hormones levels")

	StorageUtil.SetIntValue(kActor, "_SLH_iHormoneLevelsInit", 1) 

	; force default values to 0.0 to initialize
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePigmentation", 0.0 ) 	 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneGrowth", 0.0 ) 		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMetabolism", 0.0 )	 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSleep", 0.0 ) 	 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneHunger", 0.0 ) 		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneImmunity", 0.0 )		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneStress", 0.0 ) 			 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMood", 0.0 ) 			 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemale", 0.0 ) 			 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMale", 0.0 )		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSexDrive", 0.0 )	 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePheromones", 0.0 ) 		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactation", 0.0 ) 		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneBimbo", 0.0 ) 		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSuccubus", 0.0 ) 		 

	; set default racial modifiers
	setHormoneLevelsRacialMod( kActor)

	; calculate default levels
	setHormonesLevels( kActor)

	; record original state for cooldown
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePigmentationInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormonePigmentation") ) 	 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneGrowthInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneGrowth") ) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMetabolismInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMetabolism") ) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSleepInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneSleep")	  ) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneHungerInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneHunger")	 )  
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneImmunityInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneImmunity")	  ) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneStressInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneStress") ) 		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMoodInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMood") ) 		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemaleInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale") ) 		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMaleInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMale") ) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSexDriveInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneSexDrive") ) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePheromonesInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormonePheromones") ) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactationInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneLactation") ) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneBimboInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneBimbo") ) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSuccubusInit", StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneSuccubus") ) 

endFunction

function setHormonesLevels(Actor kActor)
	; Use only for first time initialization
	Int isPregnant = StorageUtil.GetIntValue(kActor, "_SLH_isPregnant")
	Int isSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_isSuccubus")
	Int isLactating = StorageUtil.GetIntValue(kActor, "_SLH_iLactating")
	Int isBimbo = StorageUtil.GetIntValue(kActor, "_SLH_iBimbo")
	Float fLibido = StorageUtil.GetFloatValue(kActor, "_SLH_fLibido")
	Float fBreast = StorageUtil.GetFloatValue(kActor, "_SLH_fBreast")
	Float fButt = StorageUtil.GetFloatValue(kActor, "_SLH_fButt")
	Float fBelly = StorageUtil.GetFloatValue(kActor, "_SLH_fBelly")
	Float fSchlong = StorageUtil.GetFloatValue(kActor, "_SLH_fSchlong")
	Float fWeight = StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")

	debugTrace("    :: Refresh/adjust Hormones levels after init")

	; Generic humanoid
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePigmentation", (50.0 * StorageUtil.GetFloatValue(kActor, "_SLH_fHormonePigmentationMod"))  ) 	 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneGrowth", (50.0 * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneGrowthMod"))   ) 	 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMetabolism", (50.0 * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMetabolismMod"))   )		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSleep", (50.0 * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneSleepMod"))  ) 		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneHunger", (50.0 * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneHungerMod"))  ) 		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneImmunity", (50.0 * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneImmunityMod"))   )		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneStress", (50.0 * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneStressMod"))  ) 		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMood", (50.0 * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMoodMod"))   ) 			 

	fLibido = fctUtil.fRange( fLibido , 0.0, 20.0)

	fctUtil.checkGender(kActor) 

	if fctUtil.isMale(kActor)
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemale", (10.0 * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemaleMod"))    ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMale", (50.0 * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMaleMod"))  )	
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactation", 0.0)		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactationMod", 0.0 ) 		 
	else
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemale", (50.0 * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemaleMod"))   ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMale", (10.0 * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMaleMod"))   )			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactation", 0.0)		 
	endIf

	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSexDrive", ((isPregnant * 20 + isSuccubus * 20 + isLactating * 20 + isBimbo * 20) as Float) + ((fLibido * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneSexDriveMod"))  )  )		 
	StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePheromones", ((isPregnant * 10 + isSuccubus * 30 + isLactating * 10 + isBimbo * 30) as Float) + ((fLibido * StorageUtil.GetFloatValue(kActor, "_SLH_fHormonePheromonesMod"))  ) ) 		 
 
	if (isLactating >0)
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactation", ((isPregnant * 10 + isSuccubus * 10 + isLactating * 50 + isBimbo * 10) as Float) + ((fLibido * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneLactationMod"))  ) ) 		
	Endif

	if (isBimbo >0)
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneBimbo", 10.0 * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneBimboMod"))	

	Endif
	if (isSuccubus >0)
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSuccubus", 10.0 * StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneSuccubusMod"))		 
	Endif

	capHormoneLevels(kActor)

	; debug.trace("[SLH] isPregnant = " + isPregnant )
	; debug.trace("[SLH] isSuccubus = " + isSuccubus)
	; debug.trace("[SLH] isLactating = " + isLactating)
	; debug.trace("[SLH] isBimbo = " + isBimbo)
	; debug.trace("[SLH] fLibido = " + fLibido)
	; debug.trace("[SLH] fBreast = " + fBreast)
	; debug.trace("[SLH] fButt = " + fButt)
	; debug.trace("[SLH] fBelly = " + fBelly)
	; debug.trace("[SLH] fSchlong = " + fSchlong)
	; debug.trace("[SLH] fWeight = " + fWeight)
endFunction

Function capHormoneLevels(Actor kActor) 
	capHormoneLevel(kActor, "Pigmentation")
	capHormoneLevel(kActor, "Growth")
	capHormoneLevel(kActor, "Metabolism")
	capHormoneLevel(kActor, "Sleep")
	capHormoneLevel(kActor, "Hunger")
	capHormoneLevel(kActor, "Immunity")
	capHormoneLevel(kActor, "Stress")
	capHormoneLevel(kActor, "Mood")
	capHormoneLevel(kActor, "Female")
	capHormoneLevel(kActor, "Male")
	capHormoneLevel(kActor, "SexDrive")
	capHormoneLevel(kActor, "Pheromones")
	capHormoneLevel(kActor, "Lactation")
	capHormoneLevel(kActor, "Bimbo")
	capHormoneLevel(kActor, "Succubus")

endFunction

function capHormoneLevel(Actor kActor, String sHormoneLevel)
	Float fHormoneLevel = StorageUtil.GetFloatValue(kActor, "_SLH_fHormone" + sHormoneLevel)

	fHormoneLevel = fctUtil.fRange( fHormoneLevel , 0.0, 100.0)

	StorageUtil.SetFloatValue(kActor, "_SLH_fHormone" + sHormoneLevel, fHormoneLevel)

EndFunction

Function cooldownHormoneLevels(Actor kActor, Float fHours) 
	cooldownHormoneLevel(kActor, "Pigmentation", fHours, 0.1)
	cooldownHormoneLevel(kActor, "Growth", fHours, 0.1)
	cooldownHormoneLevel(kActor, "Metabolism", fHours, 0.1)
	cooldownHormoneLevel(kActor, "Sleep", fHours, 8.0)
	cooldownHormoneLevel(kActor, "Hunger", fHours, -2.0)
	cooldownHormoneLevel(kActor, "Immunity", fHours, 0.1)
	cooldownHormoneLevel(kActor, "Stress", fHours, 2.0)
	cooldownHormoneLevel(kActor, "Mood", fHours, 2.0)
	cooldownHormoneLevel(kActor, "Female", fHours, 0.1)
	cooldownHormoneLevel(kActor, "Male", fHours, 0.1)
	cooldownHormoneLevel(kActor, "SexDrive", fHours, 4.0)
	cooldownHormoneLevel(kActor, "Pheromones", fHours, 5.0)
	cooldownHormoneLevel(kActor, "Lactation", fHours, 0.1)
	cooldownHormoneLevel(kActor, "Bimbo", fHours, 0.1)
	cooldownHormoneLevel(kActor, "Succubus", fHours, 0.1)

endFunction

function cooldownHormoneLevel(Actor kActor, String sHormoneLevel, Float fHours, Float fBaseCooldown)
	Float fHormoneLevel  = StorageUtil.GetFloatValue(kActor, "_SLH_fHormone" + sHormoneLevel)
	; Racial adjustment of mod value
	Float fModValue = fHours * fBaseCooldown * StorageUtil.GetFloatValue(kActor, "_SLH_fHormone" + sHormoneLevel + "Mod")

	; debugTrace("    :: Cooldown Hormone " + sHormoneLevel + " : Value = " + fHormoneLevel)

	If (fHormoneLevel > StorageUtil.GetFloatValue(kActor, "_SLH_fHormone" + sHormoneLevel + "Init") )
		fModValue = -1.0 * fModValue
	Endif

	; debugTrace("    :: Cooldown Hormone - Hours: " + fHours)
	; debugTrace("    :: Cooldown Hormone - Mod: " + fHours * fBaseCooldown)
	; debugTrace("    :: Cooldown Hormone - Mod Value : " + fModValue)

	fHormoneLevel = fctUtil.fRange( fHormoneLevel + fModValue , 0.0, 100.0)

	StorageUtil.SetFloatValue(kActor, "_SLH_fHormone" + sHormoneLevel, fHormoneLevel)
	debugTrace("    :: Cooldown Hormone " + sHormoneLevel + " : New Value = " + fHormoneLevel)
EndFunction


Float function getHormoneLevelsRacialAdjusted(Actor kActor, String sHormoneLevel)
	Float fHormoneLevel  = StorageUtil.GetFloatValue(kActor, "_SLH_fHormone" + sHormoneLevel)
	; Racial adjustment of hormone level
	fHormoneLevel = fHormoneLevel * StorageUtil.GetFloatValue(kActor, "_SLH_fHormone" + sHormoneLevel + "Mod")

	fHormoneLevel = fctUtil.fRange( fHormoneLevel , 0.0, 100.0)

	return fHormoneLevel 
EndFunction

function modHormoneLevel(Actor kActor, String sHormoneLevel, Float fModValue)
	Float fHormoneLevel  = StorageUtil.GetFloatValue(kActor, "_SLH_fHormone" + sHormoneLevel)
	; Racial adjustment of mod value
	fModValue = fModValue * StorageUtil.GetFloatValue(kActor, "_SLH_fHormone" + sHormoneLevel + "Mod")

	debugTrace("    :: Hormone Mod " + sHormoneLevel + " : Value = " + fHormoneLevel)

	fHormoneLevel = fctUtil.fRange( fHormoneLevel + fModValue , 0.0, 100.0)

	; minimum level to always keep a residue of hormone in body
	if (fHormoneLevel<2.0)
		fHormoneLevel=2.0
	endif

	StorageUtil.SetFloatValue(kActor, "_SLH_fHormone" + sHormoneLevel, fHormoneLevel)
	debugTrace("    :: Hormone Mod " + sHormoneLevel + " : New Value = " + fHormoneLevel)

	If (fModValue > 0)
		; debug.Notification(sHormoneLevel + " Hormone Mod +" + fModValue)
		debugTrace(sHormoneLevel + " Hormone Mod +" + fModValue)
	Else
		; debug.Notification(sHormoneLevel + " Hormone Mod " + fModValue)
		debugTrace(sHormoneLevel + " Hormone Mod " + fModValue)
	endIf
EndFunction

function modHormoneLevelPercent(Actor kActor, String sHormoneLevel, Float fModValue)
	Float fHormoneLevel  = StorageUtil.GetFloatValue(kActor, "_SLH_fHormone" + sHormoneLevel)
	; Racial adjustment of mod value
	fModValue = fModValue * StorageUtil.GetFloatValue(kActor, "_SLH_fHormone" + sHormoneLevel + "Mod")
	fModValue = (fModValue / 100.0 ) * fHormoneLevel

	; minimum level to prevent finding a percent of 0
	if (fHormoneLevel<5.0)
		fHormoneLevel=5.0
	endif

	debugTrace("    :: Hormone Mod Percent " + sHormoneLevel + " : Value = " + fHormoneLevel)

	fHormoneLevel = fctUtil.fRange( fHormoneLevel + fModValue , 0.0, 100.0)

	StorageUtil.SetFloatValue(kActor, "_SLH_fHormone" + sHormoneLevel, fHormoneLevel)
	debugTrace("    :: Hormone Mod Percente " + sHormoneLevel + " : New Value = " + fHormoneLevel)

	If (fModValue > 0)
		; debug.Notification(sHormoneLevel + " Hormone Mod +" + fModValue)
		debugTrace(sHormoneLevel + " Hormone Mod +" + fModValue)
	Else
		; debug.Notification(sHormoneLevel + " Hormone Mod " + fModValue)
		debugTrace(sHormoneLevel + " Hormone Mod " + fModValue)
	endIf
EndFunction



Float function updateActorLibido(Actor kActor)
	Float fLibido = StorageUtil.GetFloatValue(kActor, "_SLH_fLibido")

	Int iSexCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iSexCountToday") 
	Int iGameDateLastSex = StorageUtil.GetIntValue(kActor, "_SLH_iGameDateLastSex") 
	Int iOrgasmsCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iOrgasmsCountToday") 
	Int iSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_iSuccubus") 
	Int iBimbo = StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") 
	Int iDaedricInfluence = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneSuccubus") as Int

	Int sexActivityThreshold = StorageUtil.GetIntValue(kActor, "_SLH_iSexActivityThreshold") 
	Int sexActivityBuffer = StorageUtil.GetIntValue(kActor, "_SLH_iSexActivityBuffer") 

	Int iDaysSinceLastSex = (Game.QueryStat("Days Passed") - iGameDateLastSex ) as Int
	StorageUtil.SetIntValue(kActor, "_SLH_iDaysSinceLastSex", iDaysSinceLastSex)

	; from SexLab Aroused
 	fctUtil.manageSexLabAroused(kActor)

	If (iSexCountToday <= 1) && (iDaysSinceLastSex >= sexActivityBuffer )
	; Decrease
		Debug.Notification("You feel more focused")

		fLibido = fLibido - 10.0

		iDaedricInfluence   = fctUtil.iMax(0, iDaedricInfluence   - 1 )

	ElseIf ( iSexCountToday >1) && ( (iSexCountToday >= sexActivityThreshold) || (iDaysSinceLastSex <= sexActivityBuffer ) ) 
	; Increase
		Debug.Notification("You feel more voluptuous")
 
		fLibido = fLibido + 3 + fctUtil.iMin(iOrgasmsCountToday,10) + ( 10 - (Abs(fLibido) / 10) )

	Else   
	; Stable
		Debug.Notification("You feel more balanced")
		; No change

		fLibido = fLibido  + 2 - Utility.RandomInt(0, 4)

	EndIf	
	
	fLibido = fctUtil.fRange( fLibido , -100.0, 100.0)

	If (iBimbo==1)
		fLibido =  fctUtil.fRange( fLibido + 5.0, 50.0, 100.0)
	EndIf

	StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSuccubus", iDaedricInfluence as Float ) 
	StorageUtil.SetFloatValue(kActor, "_SLH_fLibido",  fLibido) 

	debugTrace("  Set Libido to " + fLibido )
	return fLibido
EndFunction

Float function updateActorSwellFactor(Actor kActor)
	Float fSwellfactor = StorageUtil.GetFloatValue(kActor, "_SLH_fSwellFactor") 

	Int iSexCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iSexCountToday") 
	Int iGameDateLastSex = StorageUtil.GetIntValue(kActor, "_SLH_iGameDateLastSex") 
	Int iSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_iSuccubus") 
	Int iBimbo = StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") 

	Int sexActivityThreshold = StorageUtil.GetIntValue(kActor, "_SLH_iSexActivityThreshold") 
	Int sexActivityBuffer = StorageUtil.GetIntValue(kActor, "_SLH_iSexActivityBuffer") 
	Float baseShrinkFactor = StorageUtil.GetFloatValue(kActor, "_SLH_fBaseShrinkFactor") 
	Float baseSwellFactor = StorageUtil.GetFloatValue(kActor, "_SLH_fBaseSwellFactor") 

	Int iDaysSinceLastSex = (Game.QueryStat("Days Passed") - iGameDateLastSex ) as Int
	StorageUtil.SetIntValue(kActor, "_SLH_iDaysSinceLastSex", iDaysSinceLastSex)

	If (iSexCountToday <= 1) && (iDaysSinceLastSex >= sexActivityBuffer )
	 ; Decrease if 0 or 1 sex act only today AND number of days since last sex is higher than the value in the menu slider
		Debug.Notification("You feel more focused")

		fSwellFactor = -1.0 * baseShrinkFactor

	ElseIf ( iSexCountToday >1) && ( (iSexCountToday >= sexActivityThreshold) || (iDaysSinceLastSex <= sexActivityBuffer ) ) 
	; Increase if more than 1 sex act today AND ( number of sex acts is larger than value set in the menu or the last sex act happened under the limit of days set in the menu)
		Debug.Notification("You feel more voluptuous") 
 
		fSwellFactor    = baseSwellFactor

	Else   
	; Stable - no particular sex activity. Weight should continue to grow at a slower rate to simulate inertia - body keeps growing even when doing nothing
		Debug.Notification("You feel more balanced")
		; No change
		fSwellFactor    = baseSwellFactor / 10.0 
 
	EndIf	
		
	Debug.Trace("  fSwellFactor: " + fSwellFactor )
	
	; fSwellFactor = fctUtil.fRange( fSwellFactor , -100.0, 100.0)

	; If (iBimbo==1)
	; 	fSwellFactor =  fctUtil.fRange( fSwellFactor + 5.0, 50.0, 100.0)
	; EndIf

	StorageUtil.SetFloatValue(kActor, "_SLH_fSwellFactor",  fSwellFactor) 
 
	debugTrace("  Set swell factor to " + fSwellFactor )
	return fSwellFactor
EndFunction

function setHormoneLevelsRacialMod(Actor kActor)
	Race thisRace = kActor.GetRace()
	String sRaceName = thisRace.GetName()

	; Racial modifiers
	; Nord  
	If (StringUtil.Find(sRaceName, "Nord")!= -1)
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePigmentationMod", 0.1 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneGrowthMod", 1.5 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMetabolismMod", 1.5 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSleepMod", 1.5 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneHungerMod", 1.5 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneImmunityMod", 1.5)		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneStressMod", 1.5 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMoodMod", 1.5 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMaleMod", 1.8 )		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemaleMod", 0.5 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSexDriveMod", 1.5 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePheromonesMod", 1.2 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactationMod", 1.5 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneBimboMod", 0.8 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSuccubusMod", 0.4 ) 		 

	; Breton
	ElseIf (StringUtil.Find(sRaceName, "Breton")!= -1)
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePigmentationMod", 0.1 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneGrowthMod", 0.5 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMetabolismMod", 0.5 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSleepMod", 1.2 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneHungerMod", 1.2 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneImmunityMod", 0.5)		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneStressMod", 1.8 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMoodMod", 0.5 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMaleMod", 1.2 )		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemaleMod", 1.2 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSexDriveMod", 1.1 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePheromonesMod", 1.1 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactationMod", 1.5 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneBimboMod", 1.2 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSuccubusMod", 1.2 ) 		 

	; Imperial
	ElseIf (StringUtil.Find(sRaceName, "Imperial")!= -1)
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePigmentationMod", 0.5 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneGrowthMod", 0.5 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMetabolismMod", 0.5 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSleepMod", 0.8 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneHungerMod", 1.2 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneImmunityMod", 0.2)		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneStressMod", 1.2 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMoodMod", 1.2 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMaleMod", 1.1 )		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemaleMod", 1.5 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSexDriveMod", 1.1 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePheromonesMod", 1.1 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactationMod", 0.8 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneBimboMod", 1.5 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSuccubusMod", 0.8 ) 		 

	; Redguard
	ElseIf (StringUtil.Find(sRaceName, "Redguard")!= -1)
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePigmentationMod", 1.2 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneGrowthMod", 1.2 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMetabolismMod", 1.5 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSleepMod", 0.1 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneHungerMod", 0.8 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneImmunityMod", 0.1)		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneStressMod", 1.8 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMoodMod", 1.8 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMaleMod", 1.8 )		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemaleMod", 1.1 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSexDriveMod", 1.5 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePheromonesMod", 1.5 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactationMod", 1.5 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneBimboMod", 1.5 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSuccubusMod", 0.4 ) 		 

	; Orc
	ElseIf (StringUtil.Find(sRaceName, "Orc")!= -1)
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePigmentationMod", 1.2 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneGrowthMod", 1.8 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMetabolismMod", 0.5 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSleepMod", 1.8 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneHungerMod", 1.8 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneImmunityMod", 0.1)		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneStressMod", 0.6 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMoodMod", 1.9 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMaleMod", 1.9 )		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemaleMod", 0.7 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSexDriveMod", 0.8 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePheromonesMod", 0.8 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactationMod", 0.8 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneBimboMod", 0.4 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSuccubusMod", 0.4 ) 		 

	; Elf
	ElseIf (StringUtil.Find(sRaceName, "Elf")!= -1) || (StringUtil.Find(sRaceName, "Dunmer")!= -1) || (StringUtil.Find(sRaceName, "Altmer")!= -1) || (StringUtil.Find(sRaceName, "Bosmer")!= -1)
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePigmentationMod", 0.1 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneGrowthMod", 0.1 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMetabolismMod", 0.1 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSleepMod", 1.2 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneHungerMod", 0.1 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneImmunityMod", 1.2)		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneStressMod", 1.8 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMoodMod", 0.1 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMaleMod", 0.9 )		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemaleMod", 1.5 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSexDriveMod", 1.5 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePheromonesMod", 1.8 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactationMod", 1.1 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneBimboMod", 1.5 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSuccubusMod", 1.5 ) 		 

	; Khajit
	ElseIf (StringUtil.Find(sRaceName, "Khajiit")!= -1)
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePigmentationMod", 0.05  ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneGrowthMod", 0.1 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMetabolismMod", 0.4 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSleepMod", 1.9 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneHungerMod", 1.7 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneImmunityMod", 1.7)		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneStressMod", 0.1 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMoodMod", 0.1 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMaleMod", 1.1 )		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemaleMod", 1.1 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSexDriveMod", 1.9 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePheromonesMod", 1.9 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactationMod", 1.2 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneBimboMod", 0.2 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSuccubusMod", 0.2 ) 		 

	; Argonian
	ElseIf (StringUtil.Find(sRaceName, "Argonian")!= -1)
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePigmentationMod", 0.05  ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneGrowthMod", 0.05 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMetabolismMod", 0.1 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSleepMod", 1.8 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneHungerMod", 0.1 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneImmunityMod", 1.9)		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneStressMod", 0.1 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMoodMod", 1.9 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMaleMod", 1.5 )		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemaleMod", 1.1 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSexDriveMod", 1.1 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePheromonesMod", 0.1 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactationMod", 0.0 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneBimboMod", 1.5 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSuccubusMod", 0.2 ) 		 

	; Dremora
	ElseIf (StringUtil.Find(sRaceName, "Dremora")!= -1)
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePigmentationMod", 1.9  ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneGrowthMod", 1.8 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMetabolismMod", 0.1 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSleepMod", 0.1) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneHungerMod", 0.1 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneImmunityMod", 1.9)		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneStressMod", 1.9 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMoodMod", 1.9 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMaleMod", 1.9 )		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemaleMod", 1.9 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSexDriveMod", 1.9 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePheromonesMod", 1.9 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactationMod", 0.2 ) 	
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneBimboMod", 1.9 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSuccubusMod", 1.9 ) 		 

	; Generic race
	Else
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePigmentationMod", 0.1 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneGrowthMod", 0.5 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMetabolismMod", 0.5 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSleepMod", 1.2 ) 	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneHungerMod", 1.2 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneImmunityMod", 0.5)		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneStressMod", 1.8 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMoodMod", 0.5 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMaleMod", 1.2 )		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemaleMod", 1.2 ) 			 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSexDriveMod", 1.1 )	 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormonePheromonesMod", 1.1 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneLactationMod", 1.5 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneBimboMod", 1.2 ) 		 
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneSuccubusMod", 1.2 ) 		 


	endif

EndFunction


Function debugTrace(string traceMsg)
	if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
		; Debug.Trace("[SLH_fctHormonesLevels]" + traceMsg)
	endif
endFunction

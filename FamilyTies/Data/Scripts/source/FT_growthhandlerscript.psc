Scriptname FT_growthhandlerscript extends ReferenceAlias  

FT_fctSeasons Property fctSeasons Auto

MusicType Property MUSReward  Auto  

FormList Property VanillaHairRaceList  Auto  
FormList Property CustomHairRaceList  Auto  
FormList Property CustomEyesRaceList  Auto  

Race Property bteen  Auto  
Race Property brace  Auto  

Race Property iteen  Auto  
Race Property irace  Auto  

Race Property nteen  Auto  
Race Property nrace  Auto  

Race Property rteen  Auto  
Race Property rrace  Auto  

Race Property erace  Auto  

Message Property adultmsg  Auto  
Message Property eldermsg  Auto  


Race rPlayerRealRace 
Race rPlayerCurrentRace 

int age
int	baseAge 
int	anniversaryFrequency 
int	agingFrequency 
int daysPassed = 0
int yearsCount  = 0
int daysCount = 0
int iGameDateLastCheck = -1
Int iDaysSinceLastCheck = -1
int iDaysSinceLastAnniversary = 0
int iDaysSinceLastBirthday = 0

Bool bGrantStartPerks = False

Event OnInit()
	Actor PlayerActor 

	PlayerActor = Game.getPlayer() as Actor
	rPlayerRealRace = PlayerActor.getrace()
	StorageUtil.SetFormValue(PlayerActor, "_FT_fPlayerRealRace", rPlayerRealRace as Form)

	StorageUtil.SetFloatValue(PlayerActor, "_FT_baseAge", 18.0 )
	StorageUtil.SetFloatValue(PlayerActor, "_FT_anniversaryFrequency", 364.0 ) 
	StorageUtil.SetFloatValue(PlayerActor, "_FT_agingFrequency", 364.0 ) 

	StorageUtil.SetIntValue(none, "_FT_startAging", 0 )
 	StorageUtil.SetIntValue(none, "_FT_pauseAging", 0 )

	StorageUtil.SetIntValue(PlayerActor, "_FT_iPlayerAge", 18)

	; Debug.Messagebox("Birthday initialization\nPlayer Level: "+ PlayerActor.getlevel() +"\nPlayer Age Level: " + StorageUtil.GetIntValue(PlayerActor, "_FT_iPlayerAgeLevel")  +"\nPlayer Age: " + start_age.GetValue() as Int)

	_maintenance()

EndEvent

Event OnPlayerLoadGame()

	_maintenance()

EndEvent

Function _maintenance()
 	Actor PlayerActor= Game.GetPlayer() as Actor
 	ActorBase pActorBase = PlayerActor.GetActorBase()

	If (!StorageUtil.HasIntValue(none, "_FT_iFamilyTies"))
		StorageUtil.SetIntValue(none, "_FT_iFamilyTies", 1)
	EndIf

	If (!StorageUtil.HasIntValue(none, "_FT_enableSeasons"))
		StorageUtil.SetIntValue(none, "_FT_enableSeasons", 1)
	EndIf

	rPlayerCurrentRace = PlayerActor.getrace()
	StorageUtil.SetFormValue(PlayerActor, "_FT_fPlayerCurrentRace", rPlayerCurrentRace as Form)
	StorageUtil.SetIntValue(PlayerActor, "_FT_iPlayerYearsCount", yearsCount)

	StorageUtil.SetFloatValue(none, "_FT_fMinHeight", 0.96)
	StorageUtil.SetFloatValue(none, "_FT_fMaxHeight", 1.1)

	if ((StorageUtil.GetFormValue(PlayerActor, "_FT_fPlayerRealRace") as Race) != None )
		rPlayerRealRace = StorageUtil.GetFormValue(PlayerActor, "_FT_fPlayerRealRace") as Race
	else
		rPlayerRealRace = None
	endif

	_registerNewRacesForHeadparts( VanillaHairRaceList  )
	_registerNewRacesForHeadparts( CustomHairRaceList  )
	_registerNewRacesForHeadparts( CustomEyesRaceList  )

	UnregisterForAllModEvents()
	Debug.Trace("Family ties: Reset events")

	RegisterForSleep()

	; RegisterForSingleUpdate(10)
EndFunction

 
Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	Actor PlayerActor = Game.GetPlayer() as Actor
	Int anniversaryCycle
	Int agingCycle
	; Location kLocation = PlayerActor.GetCurrentLocation()
	; Bool bLocationAllowed = False


 		
	If (StorageUtil.GetIntValue(none, "_FT_startAging" ) == 0)
		Debug.Trace("[FT] Family Ties aging stopped" )
		bGrantStartPerks = false
		Return
	Endif


	If (StorageUtil.GetIntValue(none, "_FT_pauseAging" ) == 1)
		Debug.Trace("[FT] Family Ties aging disabled" )
		Return
	Endif

	baseAge = StorageUtil.GetFloatValue(PlayerActor, "_FT_baseAge" ) as Int
	anniversaryFrequency = StorageUtil.GetFloatValue(PlayerActor, "_FT_anniversaryFrequency" ) as Int
	agingFrequency = StorageUtil.GetFloatValue(PlayerActor, "_FT_agingFrequency" ) as Int

	if (anniversaryFrequency > agingFrequency)
		anniversaryFrequency = agingFrequency
		StorageUtil.SetFloatValue(PlayerActor, "_FT_anniversaryFrequency",anniversaryFrequency as Float ) 
	EndIf

 	daysPassed = Game.QueryStat("Days Passed")
	daysCount = StorageUtil.GetIntValue(PlayerActor, "_FT_iPlayerDaysCount")
	yearsCount = StorageUtil.GetIntValue(PlayerActor, "_FT_iPlayerYearsCount")

 	; Initial values
 	if (iGameDateLastCheck == -1)
 		iGameDateLastCheck = daysPassed
		iDaysSinceLastAnniversary = 0
		iDaysSinceLastBirthday = 0
 		daysCount = 0
		yearsCount = 0
 	endIf

 	; Grant perk points based on starting age
 	If (!bGrantStartPerks) && (baseAge>16)
 		bGrantStartPerks = true
 		Game.AddPerkPoints((baseAge as Int) - 16)
 	endif
 
	iDaysSinceLastCheck = (daysPassed - iGameDateLastCheck ) as Int

	if (iDaysSinceLastCheck>0)
		; celebrate only once a day
		daysCount = daysCount + iDaysSinceLastCheck
		age = baseAge + yearsCount

		anniversaryCycle = (daysCount % anniversaryFrequency)
		agingCycle = (daysCount % agingFrequency)
	 
		if (agingCycle == 0)
			yearsCount = yearsCount + 1
	 		age = baseAge + yearsCount
	 		daysCount = 0
			celebrateBirthday()

		ElseIf (anniversaryCycle == 0)  
			celebrateAnniversary()
		EndIf
	Endif

	iGameDateLastCheck = daysPassed  

	Debug.Trace("[FT] age = " + age)
	Debug.Trace("[FT] yearsCount = " + yearsCount) 
	Debug.Trace("[FT] daysCount = " + daysCount)
	Debug.Trace("[FT] anniversaryFrequency = " + anniversaryFrequency)

	StorageUtil.SetIntValue(PlayerActor, "_FT_iPlayerDaysCount", daysCount)
	StorageUtil.SetIntValue(PlayerActor, "_FT_iPlayerYearsCount", yearsCount)
	StorageUtil.SetIntValue(PlayerActor, "_FT_iPlayerAge", age)
EndEvent


Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	Actor PlayerActor = Game.GetPlayer() as Actor
	Int iSeason
	Int iDaysInSeason
	Int iDaysInSeasonTotal
	Int iPercentSeason
	Int iChanceWeatherOverride

	agingFrequency = StorageUtil.GetFloatValue(PlayerActor, "_FT_agingFrequency" ) as Int
	daysCount = StorageUtil.GetIntValue(PlayerActor, "_FT_iPlayerDaysCount")

	iDaysInSeasonTotal = (agingFrequency / 4)
	iSeason = daysCount / iDaysInSeasonTotal
	iDaysInSeason = ( daysCount % iDaysInSeasonTotal)

	iPercentSeason = ( iDaysInSeason * 100) /  iDaysInSeasonTotal

	StorageUtil.SetIntValue(none, "_FT_iSeason", daysCount)
	StorageUtil.SetIntValue(none, "_FT_iPercentSeason", daysCount)

	iChanceWeatherOverride = (100 - ( 2 * Math.abs(50 - iPercentSeason))) as Int

	; cap the chance of weather override to prevent changing weather at every cell location change
	iChanceWeatherOverride = ( (iChanceWeatherOverride * 80) / 100 )

	if (iChanceWeatherOverride<10)
		iChanceWeatherOverride = 10
	endif


	; debug.notification("[FT] agingFrequency: " + agingFrequency)
	; debug.notification("[FT] daysCount: " + daysCount)
	; debug.notification("[FT] iSeason: " + iSeason)
	; debug.notification("[FT] iDaysInSeason: " + iDaysInSeason)
	; debug.notification("[FT] iDaysInSeasonTotal: " + iDaysInSeasonTotal)
	; debug.notification("[FT] iPercentSeason: " + iPercentSeason)
	; debug.notification("[FT] iChanceWeatherOverride: " + iChanceWeatherOverride)

	;/
	debug.trace("[FT] agingFrequency: " + agingFrequency)
	debug.trace("[FT] iSeason: " + iSeason)
	debug.trace("[FT] iDaysInSeasonTotal: " + iDaysInSeasonTotal)
	debug.trace("[FT] daysCount: " + daysCount)
	debug.trace("[FT] iDaysInSeason: " + iDaysInSeason)
	debug.trace("[FT] iPercentSeason: " + iPercentSeason)
	debug.trace("[FT] iChanceWeatherOverride: " + iChanceWeatherOverride)
	/;

  	If (StorageUtil.GetIntValue(none, "_FT_enableSeasons") == 1 )

		if (Utility.RandomInt(0,100)<iChanceWeatherOverride)
  			fctSeasons.updateWeather(iSeason, iPercentSeason)
  		endif

	EndIf
endEvent

Function celebrateAnniversary()
	Actor PlayerActor = Game.GetPlayer() as Actor
	Form fPlayerRealRace 
	Form fPlayerCurrentRace 
	agingFrequency = StorageUtil.GetFloatValue(PlayerActor, "_FT_agingFrequency" ) as Int
 
	rPlayerCurrentRace = PlayerActor.getrace()

	StorageUtil.SetFormValue(PlayerActor, "_FT_fPlayerCurrentRace", rPlayerCurrentRace as Form)

	if ((StorageUtil.GetFormValue(PlayerActor, "_FT_fPlayerRealRace") as Race) != None )
		rPlayerRealRace = StorageUtil.GetFormValue(PlayerActor, "_FT_fPlayerRealRace") as Race
	else
		rPlayerRealRace = None
	endif
 
	fPlayerRealRace = rPlayerRealRace as Form
	fPlayerCurrentRace  = rPlayerCurrentRace as Form

	If (rPlayerRealRace != None) && (rPlayerRealRace != rPlayerCurrentRace)
		Debug.Messagebox("[Anniversary perks skipped because current race "+ rPlayerCurrentRace +" is not player real race " + rPlayerRealRace+"\nPlayer Real Race: " + fPlayerRealRace.GetName()+"\nPlayer Current Race: " + fPlayerCurrentRace.GetName() + " ]")

	ElseIf (rPlayerRealRace != None) && (rPlayerRealRace == rPlayerCurrentRace)
		MUSReward.Add()

		Debug.Messagebox("Anniversary update\nPlayer Level: "+ PlayerActor.getlevel() +"\nPlayer Age : " + age )

		; if (Utility.RandomInt(1,agingFrequency)<=anniversaryFrequency)
			Game.AddPerkPoints(1)
		; endif

     endif


EndFunction


Function celebrateBirthday()
	Actor PlayerActor
	Form fPlayerRealRace 
	Form fPlayerCurrentRace 
	float fMinHeight =	StorageUtil.GetFloatValue(none, "_FT_fMinHeight")
	float fMaxHeight =	StorageUtil.GetFloatValue(none, "_FT_fMaxHeight")

	PlayerActor = Game.GetPlayer() as Actor
	rPlayerCurrentRace = PlayerActor.getrace()

	StorageUtil.SetFormValue(PlayerActor, "_FT_fPlayerCurrentRace", rPlayerCurrentRace as Form)

	if ((StorageUtil.GetFormValue(PlayerActor, "_FT_fPlayerRealRace") as Race) != None )
		rPlayerRealRace = StorageUtil.GetFormValue(PlayerActor, "_FT_fPlayerRealRace") as Race
	else
		rPlayerRealRace = None
	endif
 
	fPlayerRealRace = rPlayerRealRace as Form
	fPlayerCurrentRace  = rPlayerCurrentRace as Form

	If (rPlayerRealRace != None) && (rPlayerRealRace != rPlayerCurrentRace)
		Debug.Messagebox("[Birthday perks skipped because current race "+ rPlayerCurrentRace +" is not player real race " + rPlayerRealRace+"\nPlayer Real Race: " + fPlayerRealRace.GetName()+"\nPlayer Current Race: " + fPlayerCurrentRace.GetName() + " ]")

	ElseIf (rPlayerRealRace != None) && (rPlayerRealRace == rPlayerCurrentRace)
		MUSReward.Add()

		Debug.Messagebox("Birthday update\nPlayer Level: "+ PlayerActor.getlevel() +"\nPlayer Age : " + age )

		If (age <= 20) 
			if ( rPlayerRealRace == bteen) ||  ( rPlayerRealRace == iteen) ||  ( rPlayerRealRace == nteen) ||  ( rPlayerRealRace == rteen) 
				Debug.Messagebox("Happy birthday!\n At " + age + ", you are no longer a sheltered child. As a teenager, you are discovering the harsh environment of Skyrim. Life is short.. make the most of it.")

				_changePlayerScale(fMinHeight + ((age - baseAge) * 0.01 ) )
 			Else
				Debug.Messagebox("Happy birthday!\n You are " + age + ". ")
			Endif
			Game.AddPerkPoints(2)
			
		elseif (age == 21)  
			if ( rPlayerRealRace == bteen) ||  ( rPlayerRealRace == iteen) ||  ( rPlayerRealRace == nteen) ||  ( rPlayerRealRace == rteen) 
				Debug.Messagebox("Happy birthday!\n At " + age + ", you are a fully grown adult now. Surviving was not easy and will not get any easier from now on. ")

				if rPlayerRealRace == bteen
					PlayerActor.setrace(brace)

				elseif rPlayerRealRace == iteen
					PlayerActor.setrace(irace)

				elseif rPlayerRealRace == nteen
					PlayerActor.setrace(nrace)

				elseif rPlayerRealRace == rteen
					PlayerActor.setrace(rrace)
			 	endif
					
				_changePlayerScale(fMaxHeight)

			 	Utility.Wait(10.0)
				int iopt2 = adultmsg.show()
			 	if iopt2 == 0
					game.showracemenu()
				endif
			Else
				Debug.Messagebox("Happy birthday!\n You are " + age + ". ")
			Endif
			Game.AddPerkPoints(3)

		elseif (age < 70)
			Debug.Messagebox("Happy birthday!\n You are " + age + ". ")
			Game.AddPerkPoints(3)

		elseif (age == 70)
			if ( rPlayerRealRace == brace) ||  ( rPlayerRealRace == irace) ||  ( rPlayerRealRace == nrace) ||  ( rPlayerRealRace == rrace) 
				Debug.Messagebox("Happy birthday!\n After years of adventuring, with old age comes power and wisdom. Happly both carefully.")

				PlayerActor.setrace(erace)
				_changePlayerScale(fMaxHeight - 0.2)
				Utility.Wait(10.0)
				int iopt3 = eldermsg.show()
	 			if iopt3 == 0
					game.showlimitedracemenu()
				endif
			Else
				Debug.Messagebox("Happy birthday!\n You are " + age + ". ")
			Endif

			Game.AddPerkPoints(5)

		endif

     endif


EndFunction



Function _registerNewRacesForHeadparts(FormList HairRaceList)
 
    If (!HairRaceList.HasForm( bteen  as Form) )
		HairRaceList.AddForm( bteen  as Form) 
	Endif

    If (!HairRaceList.HasForm( rteen  as Form) )
		HairRaceList.AddForm( rteen  as Form) 
	Endif

    If (!HairRaceList.HasForm( nteen  as Form) )
		HairRaceList.AddForm( nteen  as Form) 
	Endif

    If (!HairRaceList.HasForm( iteen  as Form) )
		HairRaceList.AddForm( iteen  as Form) 
	Endif

    If (!HairRaceList.HasForm( erace  as Form) )
		HairRaceList.AddForm( erace  as Form) 
	Endif
 
EndFunction

Function _changePlayerScale(float fHeight)
	Actor PlayerActor 
	float fMinHeight =	StorageUtil.GetFloatValue(none, "_FT_fMinHeight")
	float fMaxHeight =	StorageUtil.GetFloatValue(none, "_FT_fMaxHeight")
	fHeight = fMax(fMin(fHeight, fMaxHeight), fMinHeight)

	PlayerActor = Game.getPlayer() as Actor
	PlayerActor.SetScale(fHeight)
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
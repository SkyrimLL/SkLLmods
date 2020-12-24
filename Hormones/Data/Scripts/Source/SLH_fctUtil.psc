Scriptname SLH_fctUtil extends Quest  

SLH_QST_HormoneGrowth Property SLH_Control Auto

GlobalVariable      Property GV_changeOverrideToggle	Auto

; SexLab Aroused
Int iOrigSLAExposureRank = -3
Faction  Property kfSLAExposure Auto
slaUtilScr Property slaUtil  Auto  
SexlabFramework Property SexLab Auto

GlobalVariable      Property GV_allowExhibitionist		Auto 
GlobalVariable      Property GV_isGagEquipped		Auto 
GlobalVariable      Property GV_isPlugEquipped		Auto 

bool property bIsPregnant = false auto
bool property bBeeingFemale = false auto
bool property bEstrusChaurus = false auto 

Int iCommentThrottle = 0

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

int function iRange(int val, int minVal, int maxVal)
	return iMin( iMax( val, minVal), maxVal)
endFunction

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

float function fRange(float val, float minVal, float maxVal)
	return fMin( fMax( val, minVal), maxVal)
endFunction


int Function HexToInt(string HexVal)  ; converts a 6 digit ascii hex string to integer; returns -1 in case of error
	int count=0
	int sum=0
	int DigitVal
	int SingleVal
	while (count<=5)
		DigitVal = StringUtil.AsOrd(StringUtil.GetNthChar(Hexval,count))
		if DigitVal>= 97
			DigitVal -= 32  ; switch to capitals
		endif
		if (DigitVal>=65) && (DigitVal<=70) ; A..F
			SingleVal = DigitVal - 55
		elseif (DigitVal>=48) && (DigitVal<=57) ; 0..9
			SingleVal = DigitVal - 48
		else		
			return -1
		endif
		sum = SingleVal+16*sum
		count += 1
	endwhile
	return sum
endFunction

String function IntToHex (int dec)
	String hex = ""
	int rest = dec
	while (rest > 0)
		int m16 = rest % 16
		rest = rest / 16
		String temp = ""
		if (m16 == 1)
			temp = "1"
		elseif (m16 == 2)
			temp = "2"
		elseif (m16 == 3)
			temp = "3"
		elseif (m16 == 4)
			temp = "4"
		elseif (m16 == 5)
			temp = "5"
		elseif (m16 == 6)
			temp = "6"
		elseif (m16 == 7)
			temp = "7"
		elseif (m16 == 8)
			temp = "8"
		elseif (m16 == 9)
			temp = "9"
		elseif (m16 == 10)
			temp = "A"
		elseif (m16 == 11)
			temp = "B"
		elseif (m16 == 12)
			temp = "C"
		elseif (m16 == 13)
			temp = "D"
		elseif (m16 == 14)
			temp = "E"
		elseif (m16 == 15)
			temp = "F"
		else
			temp = "0"
		endif
		hex = temp + hex
	endWhile
	return hex
endFunction


String Function actorName(Actor _person)
	return _person.GetLeveledActorBase().GetName()
EndFunction

String function notify(String _text)
	; If config.bDebugMsg
		debug.Notification(_text)
	; EndIf
EndFunction

function castSpell(Actor[] _actors, Actor _skip, Spell _spell)
	int idx = 0
	
	While idx < _actors.Length
		if _actors[idx] && _actors[idx] != _skip
			notify("Spell:" + _spell.GetName() + "->" + actorName(_actors[idx]))
			_spell.RemoteCast(_actors[idx], _actors[idx], _actors[idx])
		endif
		idx += 1
	EndWhile
EndFunction

function castSpell1st(Actor[] _actors, Spell _spell)
	int idx = 0
	
	if _actors.Length > 0
		if _actors[idx]
			notify("Spell:" + _spell.GetName() + "->" + actorName(_actors[idx]))
			_spell.RemoteCast(_actors[idx], _actors[idx], _actors[idx])
		endif
	EndIf
EndFunction


function listActors(String _txt, Actor[] _actors)
	int idx = 0
	While idx < _actors.Length
		; Debug.Notification(_txt + actorName(_actors[idx]))
		idx += 1
	EndWhile
EndFunction


Bool function hasPlayer(Actor[] _actors)
	ObjectReference PlayerREF= Game.GetPlayer()

	int idx = 0
	while idx < _actors.Length
		if _actors[idx] == PlayerRef
			return True
		endif
		idx += 1
	endwhile
	Return False
EndFunction

Bool function hasActor(Actor[] _actors, Actor thisActor)

	int idx = 0
	while idx < _actors.Length
		if _actors[idx] == thisActor as ObjectReference
			return True
		endif
		idx += 1
	endwhile
	Return False
EndFunction

Bool function hasFormKeyword(Actor[] _actors, Keyword thisKeyword)
	ActorBase aBase 
	Form kForm

	; debugTrace(" Keyword check:" + _actors.Length + " actors" )

	int idx = 0
	while idx < _actors.Length
		if (_actors[idx])
			kForm = _actors[idx] as Form

			; debugTrace(" Keyword check:" + thisKeyword + " / "  + kForm.HasKeyword(thisKeyword))
			
			if kForm.HasKeyword(thisKeyword)
				return True
			endif
		EndIf
		idx += 1
	endwhile
	Return False
EndFunction

Bool function hasRace(Actor[] _actors, Race thisRace)
	ActorBase aBase 
	Race aRace 

	; debugTrace(" Race check:" + _actors.Length + " actors" )

	int idx = 0
	while idx < _actors.Length
		if (_actors[idx])
			; aBase = _actors[idx].GetBaseObject() as ActorBase
			aRace = _actors[idx].GetRace()

			; debugTrace(" Race check:" + aRace + " / "  + thisRace)

			if aRace == thisRace
				return True
			endif
		EndIf
		idx += 1
	endwhile
	Return False
EndFunction

Actor function getRaceActor(Actor[] _actors, Race thisRace)
	ActorBase aBase 
	Race aRace 

	; debugTrace(" Race check:" + _actors.Length + " actors" )

	int idx = 0
	while idx < _actors.Length
		if (_actors[idx])
			; aBase = _actors[idx].GetBaseObject() as ActorBase
			aRace = _actors[idx].GetRace()

			; debugTrace(" Race check:" + aRace + " / "  + thisRace)

			if aRace == thisRace
				return _actors[idx]
			endif
		EndIf
		idx += 1
	endwhile
	Return None
EndFunction

function checkGender(actor kActor) 
	ActorBase kActorBase = kActor.GetActorBase()

	; Debug.Trace("[SLH] Sex from Actorbase:" + kActorBase.GetSex())
	; Debug.Trace("[SLH] Sex from Sexlab:" + Sexlab.GetGender(kActor))

	if (kActorBase.GetSex() == 1) ; female
		StorageUtil.SetIntValue(kActor, "_SLH_isFemale",  1) 
		StorageUtil.SetIntValue(kActor, "_SLH_isMale",  0) 
	Else
		StorageUtil.SetIntValue(kActor, "_SLH_isFemale",  0) 
		StorageUtil.SetIntValue(kActor, "_SLH_isMale",  1) 
	EndIf
 
EndFunction

Bool function isFemale(actor kActor)
	return (StorageUtil.GetIntValue(kActor, "_SLH_isFemale") as Bool)
EndFunction

Bool function isMale(actor kActor)
	return (StorageUtil.GetIntValue(kActor, "_SLH_isMale") as Bool)
EndFunction

Bool function isSameSex(actor kActor1, actor kActor2)
	Bool bIsSameSex = false

	bIsSameSex = (isFemale(kActor1) && isFemale(kActor2)) || (isMale(kActor1) && isMale(kActor2)) 

	return bIsSameSex
EndFunction

bool function isFHUCumFilledEnabled(actor kActor) 
  	return (StorageUtil.GetIntValue(Game.GetPlayer(), "CI_CumInflation_ON") == 1) 

endFunction

bool function isPregnantBySoulGemOven(actor kActor) 
  	return (StorageUtil.GetIntValue(Game.GetPlayer(), "sgo_IsBellyScaling") == 1) || (StorageUtil.GetIntValue(Game.GetPlayer(), "sgo_IsBreastScaling ") == 1)

endFunction

bool function isPregnantBySimplePregnancy(actor kActor) 
  	return StorageUtil.HasFloatValue(kActor, "SP_Visual")

endFunction

bool function isPregnantByBeeingFemale(actor kActor)
  if ( (StorageUtil.GetIntValue(none, "_SLS_isBeeingFemaleON")==1 ) &&  ( (StorageUtil.GetIntValue(kActor, "FW.CurrentState")>=4) && (StorageUtil.GetIntValue(kActor, "FW.CurrentState")<=8))  )
    return true
  endIf
  return false
endFunction
 
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

bool function isExternalChangeModActive(actor kActor)
	ObjectReference kActorREF = kActor as ObjectReference 
	ActorBase pActorBase = kActor.GetActorBase()
	Float fCurrentWeight = pActorBase.GetWeight()
	Actor kPlayer = Game.GetPlayer()

	bIsPregnant = ( isPregnantBySoulGemOven(kActor) || isPregnantBySimplePregnancy(kActor) || isPregnantByBeeingFemale(kActor) || isPregnantByEstrusChaurus(kActor) || ((StorageUtil.GetIntValue(kPlayer, "PSQ_SuccubusON") == 1) && (StorageUtil.GetIntValue(kPlayer, "PSQ_SoulGemPregnancyON") == 1)) )

	Return bIsPregnant || (GV_changeOverrideToggle.GetValue() == 0) || ((fCurrentWeight!=StorageUtil.GetFloatValue(kActor, "_SLH_fWeight")) && (StorageUtil.GetFloatValue(kActor, "_SLH_fManualWeightChange") == -1))

endFunction

function manageSexLabAroused(Actor kActor, int aiModRank = -1)
 
	Float Libido = StorageUtil.GetFloatValue(kActor, "_SLH_fLibido" ) 
	Float fAbsLibido = Math.abs(Libido)
	Float fArousalRateMod = StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneSexDrive" ) / 11.0 ; between 0 and 9.0
	
	If (Libido > 0)
		If (GV_allowExhibitionist.GetValue() == 1) && ((StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1) || (StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") == 1) || (StorageUtil.GetIntValue(kActor, "_SLH_isSuccubus") == 1))
			If (fAbsLibido >= 50)
				slaUtil.SetActorExhibitionist(kActor, True)
			Else
				slaUtil.SetActorExhibitionist(kActor, False)
			EndIf
		EndIf
	EndIf

	if (StorageUtil.GetIntValue(kActor, "_SLH_isSuccubus") == 1)
		fArousalRateMod = fMin( fMax( fArousalRateMod , 2.5), 9.0)
	EndIf

	if (StorageUtil.GetIntValue(kActor, "_SLH_isPregnant") == 1)
		fArousalRateMod = fMin( fMax( fArousalRateMod * 1.2, 1.1), 9.0)
	EndIf

	if ( StorageUtil.GetIntValue(kActor, "_SLH_isDrugged") == 1)
		fArousalRateMod = fMin( fMax( fArousalRateMod * 1.5, 1.1), 9.0)
	EndIf

	if (StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") == 1) && ((GV_isGagEquipped.GetValue()==1) || (GV_isPlugEquipped.GetValue()==1))
		fArousalRateMod = fMin( fMax( fArousalRateMod * 4.0, 1.1), 9.0)
	Elseif (StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") == 1)
		fArousalRateMod = fMin( fMax( fArousalRateMod * 2.0 , 1.1), 9.0)
	EndIf


	slaUtil.UpdateActorExposureRate(kActor, fArousalRateMod)

endFunction

function updateSexLabArousedExposure(Actor kActor, int iExposure)
	slaUtil.UpdateActorExposure(kActor, iExposure, " Updated from SL Hormones")
endFunction

; ------- Bimbo thoughts


function tryRandomBimboThoughts(String sTag)
 	Actor PlayerActor = Game.GetPlayer()
	Float fClumsyMod = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBimboClumsyMod" ) 
	float bimboArousal = slaUtil.GetActorArousal(PlayerActor) as float
	Int iBimboThreshold = ((bimboArousal * fClumsyMod) as Int)
	Int iBimboThrottle = StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimboThoughtsDelay")

	if (iBimboThreshold < 10)
		iBimboThreshold = 10
	endif

	if (iCommentThrottle > iBimboThrottle) || (sTag == "now")
		if (Utility.RandomInt(0,100) < iBimboThreshold ) 
			Debug.Trace("[SLH] Bimbo Thoughts:")
			Debug.Trace("[SLH] fClumsyMod:" + fClumsyMod)
			Debug.Trace("[SLH] bimboArousal:" + bimboArousal)
			Debug.Trace("[SLH] iBimboThreshold:" + iBimboThreshold)
			; Debug.Notification("[SLH] iCommentThrottle:" + iCommentThrottle)

			bimboRandomThoughts(PlayerActor)
			iCommentThrottle = 0   
		else
			; debug.notification("X")	
		endif
	else
	    ; debug.notification("Bimbo arousal:" + bimboArousal)
	    ; debug.notification(".")
		iCommentThrottle = iCommentThrottle + 1
	endif
endfunction


function bimboRandomThoughts(actor bimbo)
	Int rollMessage 
	Int rollFirstPerson 
	String bimboMessage = ""
	Float fHormoneBimbo = StorageUtil.GetFloatValue(bimbo, "_SLH_fHormoneBimbo" ) 	
	Float fHormoneMetabolism = StorageUtil.GetFloatValue(bimbo, "_SLH_fHormoneMetabolism" ) 

	rollMessage = Utility.RandomInt(0,140)
	rollFirstPerson = Utility.RandomInt(0,100)

	SLH_Control.playRandomSound(bimbo)

	;wait a little to show the messages, because on ragdoll the hud is hidden
	; Utility.Wait(2.0)

	If (StorageUtil.GetIntValue(bimbo, "_SLH_iShowStatus")==0)
		Return
	Endif

	; Under 50.0, only play a moaning sound
	if (fHormoneBimbo<50.0)
		Return
	Endif

	; Debug.Notification("[SLH] Bimbo First Person Roll: " + rollFirstPerson)
	; Debug.Notification("[SLH] Bimbo First Person: " + (StorageUtil.GetFloatValue(bimbo, "_SLH_fHormoneBimbo") as Int))

	If (rollFirstPerson <= (StorageUtil.GetFloatValue(bimbo, "_SLH_fHormoneBimbo") as Int))
		; First person thought
		if bimbo.IsOnMount() 
			if (rollMessage >= 120)
				bimboMessage = "My tits are so bouncy!"
			elseif (rollMessage >= 110)
				bimboMessage = "Riding is making me jiggle!"
			elseif (rollMessage >= 100)
				bimboMessage = "All this riding is making me horny..."
			elseif (rollMessage >= 90)
				bimboMessage = "I wish my tits were even bigger..."
			elseif (rollMessage >= 80)
				bimboMessage = "Gotta keep my tits out, and my legs open!"
			elseif (rollMessage >= 70)
				bimboMessage = "I'd love to be riding someone's cock right now."
			elseif (rollMessage >= 60)
				bimboMessage = "My boobies are bouncing! *Giggle*"
			elseif (rollMessage >= 50)
				bimboMessage = "Riding is making me tingle!"
			elseif (rollMessage >= 40)
				bimboMessage = "Rub myself"
			elseif (rollMessage >= 30)
				bimboMessage = "Bounce more"
			elseif (rollMessage >= 20)
				bimboMessage = "Tits out, legs open. Good girl."
			elseif (rollMessage >= 10)
				bimboMessage = "I wanna ride a cock."
			else 
				bimboMessage = "*Giggle*"
			endIf

		elseif (SexLab.ValidateActor( bimbo) <= 0)
			if (rollMessage >= 120)
				bimboMessage = "I, like, love being a slut!"
			elseif (rollMessage >= 115)
				bimboMessage = "Pleasure is all that matters"
			elseif (rollMessage >= 110)
				bimboMessage = "I'm totally getting my brains fucked out."
			elseif (rollMessage >= 109)
				bimboMessage = "My mouth is for sucking, not for talking."
			elseif (rollMessage >= 107)
				bimboMessage = "My tits are for grabbing, not hiding."
			elseif (rollMessage >= 105)
				bimboMessage = "Always wet, always horny."
			elseif (rollMessage >= 100)
				bimboMessage = "Think less. Suck more."
			elseif (rollMessage >= 90)
				bimboMessage = "Good girls fuck! I'm a good girl."
			elseif (rollMessage >= 80)
				bimboMessage = "I'm, like, such a little slut!"
			elseif (rollMessage >= 70)
				bimboMessage = "I could fuck all day long!"
			elseif (rollMessage >= 60)
				bimboMessage = "I wish they'd fuck me harder!"
			elseif (rollMessage >= 50)
				bimboMessage = "Blondes really do have more fun!"
			elseif (rollMessage >= 40)
				bimboMessage = "I'm such a little flirt!"
			elseif (rollMessage >= 30)
				bimboMessage = "Good girls always put out!"
			elseif (rollMessage >= 20)
				bimboMessage = "I totally love being a sex toy!"
			else 
				bimboMessage = "I totally love being a fuck puppet."
			endIf


		elseif	bimbo.IsRunning() || bimbo.IsSprinting() 
			if (rollMessage >= 90)
				bimboMessage = "Gotta jiggle my tits, just like this!"
			elseif (rollMessage >= 50)
				bimboMessage = "Is running around like this wrecking my hair?"
			else 
				bimboMessage = "Gosh, I'm horny..."
			endIf

		elseif	bimbo.IsInCombat() 
			if (rollMessage >= 90)
				bimboMessage = "Maybe I'll get fucked if I surrender."
			elseif (rollMessage >= 70)
				bimboMessage = "I need to be fucked."
			elseif (rollMessage >=30) 
				bimboMessage = "I need a good pounding."
			else 
				bimboMessage = "*Giggle*"
			endIf
			
		elseif	bimbo.IsWeaponDrawn() 
			if (rollMessage >= 90)
				bimboMessage = "I would rather hold a dildo."
			elseif (rollMessage >= 70)
				bimboMessage = "I would rather hold a cock."
			elseif (rollMessage >= 40) 
				bimboMessage = "I would rather fuck someone."
			else
				bimboMessage = "*Giggle*"
			endIf

		elseif (StorageUtil.GetIntValue(bimbo, "_SD_iEnslaved") == 1) 
			if (rollMessage >= 90)
				bimboMessage = "Obedience is pleasure."
			elseif (rollMessage >= 80)
				bimboMessage = "Obedience makes me free."
			elseif (rollMessage >= 70)
				bimboMessage = "Obedience is bliss."
			elseif (rollMessage >= 60)
				bimboMessage = "Surrender."
			elseif (rollMessage >= 50)
				bimboMessage = "Obey."
			elseif (rollMessage >= 40)
				bimboMessage = "Good girls obey."
			else 
				bimboMessage = "Stop resisting."
			endIf

		else
			if (rollmessage >= 118)
				bimboMessage = "I don't want to think, I'm just a girl!"		
			elseif (rollMessage >= 117)
				bimboMessage = "I'm just a sexy little toy!"
			elseif (rollMessage >= 116)
				bimboMessage = "I just wanna flirt with all the boys!"
			elseif (rollMessage >= 115)
				bimboMessage = "Thinking is like, totally hard..."
			elseif (rollMessage >= 114)
				bimboMessage = "I'm, like, just TOO cute in pink!"
			elseif (rollMessage >= 113)
				bimboMessage = "I'm such a little airhead!"
			elseif (rollMessage >= 112)
				bimboMessage = "I could go for some yummy cock..."
			elseif (rollMessage >= 111)
				bimboMessage = "Good girls always put out!"
			elseif (rollMessage >= 110)
				bimboMessage = "Good girls always swallow!"
			elseif (rollMessage >= 109)
				bimboMessage = "Oh my gosh, this makeup is just TOO cute!"
			elseif (rollMessage >= 108)
				bimboMessage = "There's nothing better than being a giggly little slut!"
			elseif (rollMessage >= 107)
				bimboMessage = "Giggling gets me so hot..."
			elseif (rollMessage >= 106)
				bimboMessage = "Being smart is, like, so totally boring!"
			elseif (rollMessage >= 105)
				bimboMessage = "Should I do my hair?"
			elseif (rollMessage >= 104)
				bimboMessage = "Please, somebody say I'm a good girl..."
			elseif (rollMessage >= 103)
				bimboMessage = "Would boys like me better if I giggled more?"
			elseif (rollMessage >= 102)
				bimboMessage = "Boys like dumb blondes!"
			elseif (rollMessage >= 101)
				bimboMessage = "I love being such a sexy little tramp!"
			elseif (rollMessage >= 100)
                bimboMessage = "Show off my body, turn off my brain."
            elseif (rollMessage >= 99)
                bimboMessage = "I'm a Good Girl."                
            elseif (rollMessage >= 98)
                bimboMessage = "*Giggle*  Like, whatever he wants."
            elseif (rollMessage >= 97)
                bimboMessage = "I love being a Good Girl."
            elseif (rollMessage >= 96)
                bimboMessage = "I should, like, go make a guy happy."
            elseif (rollMessage >= 95)
                bimboMessage = "Who, like, wants to fuck me?"
            elseif (rollMessage >= 94)
                bimboMessage = "Suck more cock."
            elseif (rollMessage >= 93)
                bimboMessage = "Lick more pussy."
            elseif (rollMessage >= 92)
                bimboMessage = "Think less, suck more."
            elseif (rollMessage >= 91)
                bimboMessage = "I love being on my knees."
            elseif (rollMessage >= 90)
                bimboMessage = "Spreading my legs is what I'm good for."
            elseif (rollMessage >= 89)
                bimboMessage = "I'm a fuck toy."
            elseif (rollMessage >= 88)
                bimboMessage = "I'm a fuck doll."
            elseif (rollMessage >= 87)
                bimboMessage = "I'm a slut."
            elseif (rollMessage >= 86)
                bimboMessage = "I'm a mindless toy."
            elseif (rollMessage >= 85)
                bimboMessage = "Good Girls want cock."
            elseif (rollMessage >= 84)
                bimboMessage = "Good Girls want pussy."
            elseif (rollMessage >= 83)
                bimboMessage = "Good Girls want sex."
            elseif (rollMessage >= 82)
                bimboMessage = "I love my huge tits."
            elseif (rollMessage >= 81)
                bimboMessage = "My ass is jiggling.  I hope someone's looking."
            elseif (rollMessage >= 80)
                bimboMessage = "I totally love my tan"
            elseif (rollMessage >= 79)
                bimboMessage = "I love the way my heels make my butt sway."
            elseif (rollMessage >= 78)
                bimboMessage = "Good Girls have hot bodies like mine."
            elseif (rollMessage >= 77)
                bimboMessage = "Blondes have more fun."
            elseif (rollMessage >= 76)
                bimboMessage = "I, like, need to check my hair."
            elseif (rollMessage >= 75)
                bimboMessage = "Blondes are dumber."
            elseif (rollMessage >= 74)
                bimboMessage = "I love being blonde and stupid."
            elseif (rollMessage >= 73)
                bimboMessage = "I, like, need to check my makeup."
            elseif (rollMessage >= 72)
                bimboMessage = "I need more lipstick."
            elseif (rollMessage >= 71)
                bimboMessage = "I need more eye liner"
            elseif (rollMessage >= 70)
                bimboMessage = "I need to polish my nails."
            elseif (rollMessage >= 69)
                bimboMessage = "I need to shave my pussy."
            elseif (rollMessage >= 68)
                bimboMessage = "Men love blondes"
            elseif (rollMessage >= 67)
                bimboMessage = "Wearing makeup makes me dumber."
            elseif (rollMessage >= 66)
                bimboMessage = "Shave my pussy, empty my mind."
            elseif (rollMessage >= 65)
                bimboMessage = "The smell of nail polish makes me dumber."
            elseif (rollMessage >= 64)
                bimboMessage = "The smell of nail polish makes me horny."
            elseif (rollMessage >= 63)
                bimboMessage = "Buy more makeup."
            elseif (rollMessage >= 62)
                bimboMessage = "Good Girls wear makeup."
            elseif (rollMessage >= 61)
                bimboMessage = "Good Girls keep their pussies shaved."
            elseif (rollMessage >= 60)
                bimboMessage = "Dumber is better."
            elseif (rollMessage >= 59)
                bimboMessage = "Thinking with my pussy."
            elseif (rollMessage >= 58)
                bimboMessage = "Don't think."
            elseif (rollMessage >= 57)
                bimboMessage = "Good Girl."
            elseif (rollMessage >= 56)
                bimboMessage = "Giggles make my mind empty."
            elseif (rollMessage >= 55)
                bimboMessage = "Thinking, like, makes my head hurt."
            elseif (rollMessage >= 54)
                bimboMessage = "Good Girls don't think."
            elseif (rollMessage >= 53)
                bimboMessage = "Thoughts are just noise."
            elseif (rollMessage >= 52)
                bimboMessage = "Dumber is sexier."
            elseif (rollMessage >= 51)
                bimboMessage = "Men like dumb girls."
            elseif (rollMessage >= 50)
                bimboMessage = "I've fucked my mind away, and I love it."
            elseif (rollMessage >= 49)
                bimboMessage = "Think Pink."
            elseif (rollMessage >= 48)
                bimboMessage = "Wear Pink."
            elseif (rollMessage >= 47)
                bimboMessage = "Pink makes me dumber. I love it!"
            elseif (rollMessage >= 46)
                bimboMessage = "Pink is sexy."
            elseif (rollMessage >= 45)
                bimboMessage = "Pink is my favorite color."
            elseif (rollMessage >= 44)
                bimboMessage = "Pink makes me horny."
            elseif (rollMessage >= 43)
                bimboMessage = "Pink is a slutty color."
            elseif (rollMessage >= 42)
                bimboMessage = "Good Girls wear pink."
            elseif (rollMessage >= 41)
                bimboMessage = "Spread my legs."
            elseif (rollMessage >= 40)
                bimboMessage = "My pussy wants cock."
            elseif (rollMessage >= 39)
                bimboMessage = "I want a cock up my ass."
            elseif (rollMessage >= 38)
                bimboMessage = "Sexy is better."
            elseif (rollMessage >= 37)
                bimboMessage = "I wanna suck a cock."
            elseif (rollMessage >= 36)
                bimboMessage = "My pussy is free to use."
            elseif (rollMessage >= 35)
                bimboMessage = "My mouth is for cocksucking."
            elseif (rollMessage >= 34)
                bimboMessage = "I exist for pleasure."
            elseif (rollMessage >= 33)
                bimboMessage = "I'm a slut."
            elseif (rollMessage >= 32)
                bimboMessage = "Good Girls are sluts."
            elseif (rollMessage >= 31)
                bimboMessage = "Show off my body."
            elseif (rollMessage >= 30)
                bimboMessage = "Turn off my brain."
            elseif (rollMessage >= 29)
                bimboMessage = "Why do I have all this heavy armor?"
            elseif (rollMessage >= 28)
                bimboMessage = "I need to be seen."
            elseif (rollMessage >= 27)
                bimboMessage = "Show more skin."
            elseif (rollMessage >= 26)
                bimboMessage = "I love being naked in public."
            elseif (rollMessage >= 25)
                bimboMessage = "Wear lingere...or nothing."
            elseif (rollMessage >= 24)
                bimboMessage = "Good Girls show off."
            elseif (rollMessage >= 23)
                bimboMessage = "Wear less."
            elseif (rollMessage >= 22)
                bimboMessage = "Skimpy clothes make my mind empty."
            elseif (rollMessage >= 21)
                bimboMessage = "I need high heels."
            elseif (rollMessage >= 20)
                bimboMessage = "My clothes show just how much of a slut I am."
            elseif (rollMessage >= 19)
                bimboMessage = "Thinking, like, makes my head hurt."
            elseif (rollMessage >= 18)
                bimboMessage = "Good Girls don't need to think."
            elseif (rollMessage >= 17)
                bimboMessage = "I want to obey."
            elseif (rollMessage >= 16)
                bimboMessage = "Men are like, so smart."
            elseif (rollMessage >= 15)
                bimboMessage = "I wanna listen to men."
            elseif (rollMessage >= 14)
                bimboMessage = "I'm not smart enough to decide."
            elseif (rollMessage >= 13)
                bimboMessage = "I love being a bimbo."
            elseif (rollMessage >= 12)
                bimboMessage = "I can't resist a man's voice."
            elseif (rollMessage >= 11)
                bimboMessage = "Giggles make me horny."
            elseif (rollMessage >= 10)
                bimboMessage = "Giggle more, think less."
            elseif (rollMessage >= 9)
                bimboMessage = "Giggles are pretty."
            elseif (rollMessage >= 8)
                bimboMessage = "Good Girls Giggle."
            elseif (rollMessage >= 7)
                bimboMessage = "*Giggle* Giggle my mind away. *Giggle*"
            elseif (rollMessage >= 6)
                bimboMessage = "I'd look good in a slave collar."
			else
				bimboMessage = "*Giggle*"
			endIf
		endif

	else
		; Third person thought
		If (SexLab.ValidateActor( bimbo) <= 0)
			if (rollMessage >= 90)
				bimboMessage = "You love being a slut."
			elseif (rollMessage >= 80)
				bimboMessage = "Pleasure is all you care about."
			elseif (rollMessage >= 70)
				bimboMessage = "You want them to fuck you harder."
			elseif (rollMessage >= 60)
				bimboMessage = "You are always horny."
			elseif (rollMessage >= 50)
				bimboMessage = "You need to think less and suck more."
			elseif (rollMessage >= 50)
				bimboMessage = "You desperately want to be a good girl."
			elseif (rollMessage >= 40)
				bimboMessage = "You were made for sex."
			else 
				bimboMessage = "Good girl.  You are a fuck puppet."
			endIf

		elseif bimbo.IsOnMount() 
			if (rollMessage >= 120)
				bimboMessage = "You love watching your tits bounce."
			elseif (rollMessage >= 10)
				bimboMessage = "Riding is making you horny."
			elseif (rollMessage >= 100)
				bimboMessage = "The heat between your legs is becoming unbearable..."
			elseif (rollMessage >= 90)
				bimboMessage = "You wish your tits were even bigger."
			elseif (rollMessage >= 80)
				bimboMessage = "Always remember: tits out, legs open."
			elseif (rollMessage >= 70)
				bimboMessage = "You want to ride somebody's cock."
			elseif (rollMessage >= 60)
				bimboMessage = "Your boobies are bouncing!  Good Girl."
			elseif (rollMessage >= 50)
				bimboMessage = "Riding is making me tingle!"
			elseif (rollMessage >= 40)
				bimboMessage = "Rub yourself"
			elseif (rollMessage >= 30)
				bimboMessage = "Bounce more"
			elseif (rollMessage >= 20)
				bimboMessage = "Tits out, legs open. Good girl."
			else 
				bimboMessage = "You need to ride a cock."
			endIf

		elseif	bimbo.IsRunning() || bimbo.IsSprinting() 
			if (rollMessage >= 100)
				bimboMessage = "Remember to jiggle your tits just like this."
			elseif (rollMessage >= 80)
				bimboMessage = "Running will ruin your hairdo. You don't want that, do you?"
			elseif (rollMessage >= 50)
				bimboMessage = "You're just always so horny..."
			elseif (rollMessage >= 40)
				bimboMessage = "Jiggle your tits, just like this."
			elseif (rollMessage >= 20)
				bimboMessage = "Running is ruining your hair.  You should stop."
			else 
				bimboMessage = "You're so horny."
			endIf

		elseif	bimbo.IsInCombat() 
			if (rollMessage >= 120)
				bimboMessage = "You want to give up and hope that they will fuck you."
			elseif (rollMessage >= 100)
				bimboMessage = "You would rather be their submissive toy."
			elseif (rollMessage >= 80) 
				bimboMessage = "You would rather let them have their way with you."
			elseif (rollMessage >= 60) 
				bimboMessage = "Maybe you will get fucked if you surrender."
			elseif (rollMessage >= 40)
				bimboMessage = "You need to be fucked."
			elseif (rollMessage >= 20) 
				bimboMessage = "You need a good pounding."
			else 
				bimboMessage = "*Giggle*"
			endIf
			
		elseif	bimbo.IsWeaponDrawn() 
			if (rollMessage >= 110)
				bimboMessage = "You would rather use both hands to cup your massive tits."
			elseif (rollMessage >= 100)
				bimboMessage = "You would rather be stroking a man's cock."
			elseif (rollMessage >= 80) 
				bimboMessage = "YOh my gods... do Reguards have curved cocks too?"
			elseif (rollMessage >= 60) 
				bimboMessage = "You would rather hold a dildo."
			elseif (rollMessage >= 40)
				bimboMessage = "You would rather hold a cock."
			elseif (rollMessage >= 20) 
				bimboMessage = "You would rather fuck someone."
			else
				bimboMessage = "*Giggle*"
			endIf

		elseif (StorageUtil.GetIntValue(bimbo, "_SD_iEnslaved") == 1) 
			if (rollMessage >= 90)
				bimboMessage = "Obedience is pleasure."
			elseif (rollMessage >= 80)
				bimboMessage = "Obedience makes you free."
			elseif (rollMessage >= 70)
				bimboMessage = "Obedience is bliss."
			elseif (rollMessage >= 60)
				bimboMessage = "Surrender."
			elseif (rollMessage >= 50)
				bimboMessage = "Obey."
			elseif (rollMessage >= 40)
				bimboMessage = "Good girls obey."
			else 
				bimboMessage = "Stop resisting."
			endIf

		else
			if (rollmessage >= 136) 
				bimboMessage = "Giggles are pretty"
			elseif (rollMessage >= 135)
				bimboMessage = "Thoughts are just noise"
			elseif (rollMessage >= 134)
				bimboMessage = "Suck cock"
			elseif (rollMessage >= 133)
				bimboMessage = "You are a mindless toy"
			elseif (rollMessage >= 132)
				bimboMessage = "You are a cocksucker"
			elseif (rollMessage >= 131)
				bimboMessage = "Good girls need cock"
			elseif (rollMessage >= 130)
				bimboMessage = "Good girls suck"
			elseif (rollMessage >= 129)
				bimboMessage = "You need to check your make up."
			elseif (rollMessage >= 128)
				bimboMessage = "Giggling makes you horny."
			elseif (rollMessage >= 127)
				bimboMessage = "Giggles make your mind empty"
			elseif (rollMessage >= 126)
				bimboMessage = "Brains are for boys"
			elseif (rollMessage >= 125)
				bimboMessage = "You need to check your hair."
			elseif (rollMessage >= 124)
				bimboMessage = "You are a good girl."
			elseif (rollMessage >= 123)
				bimboMessage = "Giggle more"
			elseif (rollMessage >= 122)
				bimboMessage = "Dumber is better"
			elseif (rollMessage >= 121)
				bimboMessage = "Sexy is better"
			elseif (rollMessage >= 120)
                bimboMessage = "Show off your body, turn off your brain."
			elseif (rollMessage >= 119)
				bimboMessage = "You don't want to think, because you're just a girl."		
			elseif (rollMessage >= 118)
				bimboMessage = "You are just a plaything."
			elseif (rollMessage >= 117)
				bimboMessage = "Boys will like you better if you giggle."
			elseif (rollMessage >= 116)
				bimboMessage = "Trying to think is hard and confusing."
			elseif (rollMessage >= 115)
				bimboMessage = "You look so much prettier in pink."
			elseif (rollMessage >= 114)
				bimboMessage = "You are nothing but an airhead."
			elseif (rollMessage >= 113)
				bimboMessage = "You want nothing more than to suck someone's cock."
			elseif (rollMessage >= 112)
				bimboMessage = "You are just a walking, talking sex toy."
			elseif (rollMessage >= 111)
				bimboMessage = "Good girls know their place."
			elseif (rollMessage >= 110)
				bimboMessage = "You always want your makeup to be perfect."
			elseif (rollMessage >= 109)
				bimboMessage = "Giggling makes you horny."
			elseif (rollMessage >= 108)
				bimboMessage = "You want to be somebody's submissive toy."
			elseif (rollMessage >= 107)
				bimboMessage = "Thinking is for boys."
			elseif (rollMessage >= 106)
				bimboMessage = "Remember that blondes have more fun."
			elseif (rollMessage >= 105)
				bimboMessage = "You want to be a good girl."
			elseif (rollMessage >= 104)
				bimboMessage = "You want to flirt with every man you see."
			elseif (rollMessage >= 103)
				bimboMessage = "Remember: boys don't like girls who are too smart."
			elseif (rollMessage >= 102)
				bimboMessage = "You want to be sexy for all the boys."
            elseif (rollMessage >= 101)
                bimboMessage = "You are a Good Girl."                
            elseif (rollMessage >= 100)
                bimboMessage = "Just giggle and nod."
            elseif (rollMessage >= 99)
                bimboMessage = "You love being a Good Girl."
            elseif (rollMessage >= 98)
                bimboMessage = "Just giggle and nod."
            elseif (rollMessage >= 97)
                bimboMessage = "Stop adventuring, start fucking."
            elseif (rollMessage >= 96)
                bimboMessage = "Suck more cock."
            elseif (rollMessage >= 95)
                bimboMessage = "Lick more pussy."
            elseif (rollMessage >= 94)
                bimboMessage = "Think less, suck more."
            elseif (rollMessage >= 93)
                bimboMessage = "You like being on your knees."
            elseif (rollMessage >= 92)
                bimboMessage = "Spreading your legs is what you're good for."
            elseif (rollMessage >= 91)
                bimboMessage = "You are a fuck toy."
            elseif (rollMessage >= 90)
                bimboMessage = "You are a fuck doll."
            elseif (rollMessage >= 89)
                bimboMessage = "You are a slut."
            elseif (rollMessage >= 88)
                bimboMessage = "You are a mindless toy."
            elseif (rollMessage >= 87)
                bimboMessage = "Good Girls want cock."
            elseif (rollMessage >= 86)
                bimboMessage = "Good Girls want pussy."
            elseif (rollMessage >= 85)
                bimboMessage = "Good Girls want sex."
            elseif (rollMessage >= 84)
                bimboMessage = "You need bigger tits."
            elseif (rollMessage >= 83)
                bimboMessage = "Your ass should jiggle when you walk."
            elseif (rollMessage >= 82)
                bimboMessage = "You love your tan"
            elseif (rollMessage >= 81)
                bimboMessage = "You love the way your heels make your butt sway."
            elseif (rollMessage >= 80)
                bimboMessage = "Good Girls have hot bodies like yours."
            elseif (rollMessage >= 79)
                bimboMessage = "Blondes have more fun."
            elseif (rollMessage >= 78)
                bimboMessage = "You need to check your hair."
            elseif (rollMessage >= 77)
                bimboMessage = "Blondes are dumber."
            elseif (rollMessage >= 76)
                bimboMessage = "You love being blonde."
            elseif (rollMessage >= 75)
                bimboMessage = "You need to check your makeup."
            elseif (rollMessage >= 74)
                bimboMessage = "You need more lipstick."
            elseif (rollMessage >= 73)
                bimboMessage = "You need more eye liner"
            elseif (rollMessage >= 72)
                bimboMessage = "You need to polish your nails."
            elseif (rollMessage >= 71)
                bimboMessage = "You need to shave your pussy."
            elseif (rollMessage >= 70)
                bimboMessage = "Men love blondes"
            elseif (rollMessage >= 69)
                bimboMessage = "Wearing makeup makes you dumber."
            elseif (rollMessage >= 68)
                bimboMessage = "Shave your pussy, empty your mind."
            elseif (rollMessage >= 67)
                bimboMessage = "The smell of nail polish makes you dumber."
            elseif (rollMessage >= 66)
                bimboMessage = "The smell of nail polish makes you horny."
            elseif (rollMessage >= 65)
                bimboMessage = "Buy more makeup."
            elseif (rollMessage >= 64)
                bimboMessage = "Good Girls wear makeup."
            elseif (rollMessage >= 63)
                bimboMessage = "Good Girls keep their pussies shaved."
            elseif (rollMessage >= 62)
                bimboMessage = "Dumber is better."
            elseif (rollMessage >= 61)
                bimboMessage = "Think with your pussy."
            elseif (rollMessage >= 60)
                bimboMessage = "Don't think."
            elseif (rollMessage >= 59)
                bimboMessage = "Good Girl."
            elseif (rollMessage >= 58)
                bimboMessage = "Giggles make your mind empty."
            elseif (rollMessage >= 57)
                bimboMessage = "You don't need to think."
            elseif (rollMessage >= 56)
                bimboMessage = "Good Girls don't think."
            elseif (rollMessage >= 55)
                bimboMessage = "Thoughts are just noise."
            elseif (rollMessage >= 54)
                bimboMessage = "Dumber is sexier."
            elseif (rollMessage >= 53)
                bimboMessage = "Men like dumb girls."
            elseif (rollMessage >= 52)
                bimboMessage = "Go fuck your mind away."
            elseif (rollMessage >= 51)
                bimboMessage = "Think Pink."
            elseif (rollMessage >= 50)
                bimboMessage = "Wear Pink."
            elseif (rollMessage >= 49)
                bimboMessage = "Pink makes you dumber."
            elseif (rollMessage >= 48)
                bimboMessage = "Pink is sexy."
            elseif (rollMessage >= 47)
                bimboMessage = "Pink is your favorite color."
            elseif (rollMessage >= 46)
                bimboMessage = "Pink makes you horny."
            elseif (rollMessage >= 45)
                bimboMessage = "Pink is a slutty color."
            elseif (rollMessage >= 44)
                bimboMessage = "Good Girls wear pink."
            elseif (rollMessage >= 43)
                bimboMessage = "Spread your legs."
            elseif (rollMessage >= 42)
                bimboMessage = "Your pussy wants cock."
            elseif (rollMessage >= 41)
                bimboMessage = "You want a cock up your ass."
            elseif (rollMessage >= 40)
                bimboMessage = "Sexy is better."
            elseif (rollMessage >= 39)
                bimboMessage = "You should be sucking a cock."
            elseif (rollMessage >= 38)
                bimboMessage = "Your pussy is free to use."
            elseif (rollMessage >= 37)
                bimboMessage = "Your mouth is for cocksucking."
            elseif (rollMessage >= 36)
                bimboMessage = "You exist for pleasure."
            elseif (rollMessage >= 35)
                bimboMessage = "You're a slut."
            elseif (rollMessage >= 34)
                bimboMessage = "Good Girls are sluts."
            elseif (rollMessage >= 33)
                bimboMessage = "Show off your body."
            elseif (rollMessage >= 32)
                bimboMessage = "Turn off your brain."
            elseif (rollMessage >= 31)
                bimboMessage = "Get rid of your armor."
            elseif (rollMessage >= 30)
                bimboMessage = "You need to be seen."
            elseif (rollMessage >= 29)
                bimboMessage = "Show more skin."
            elseif (rollMessage >= 28)
                bimboMessage = "You love being naked in public."
            elseif (rollMessage >= 27)
                bimboMessage = "Wear lingerie...or nothing."
            elseif (rollMessage >= 26)
                bimboMessage = "Good Girls show off."
            elseif (rollMessage >= 25)
                bimboMessage = "Wear less."
            elseif (rollMessage >= 24)
                bimboMessage = "Skimpy clothes are best."
            elseif (rollMessage >= 23)
                bimboMessage = "You need high heels."
            elseif (rollMessage >= 22)
                bimboMessage = "You are such a slut in these clothes."
            elseif (rollMessage >= 21)
                bimboMessage = "Thinking makes your head hurt."
            elseif (rollMessage >= 20)
                bimboMessage = "Good Girls don't need to think."
            elseif (rollMessage >= 19)
                bimboMessage = "You need to obey."
            elseif (rollMessage >= 18)
                bimboMessage = "Listen to men."
            elseif (rollMessage >= 17)
                bimboMessage = "Men will think for you."
            elseif (rollMessage >= 16)
                bimboMessage = "You're not smart enough to decide."
            elseif (rollMessage >= 15)
                bimboMessage = "You can't resist a man's voice."
            elseif (rollMessage >= 14)
                bimboMessage = "Giggles make you horny."
            elseif (rollMessage >= 13)
                bimboMessage = "Giggle more, think less."
            elseif (rollMessage >= 12)
                bimboMessage = "Giggles are pretty."
            elseif (rollMessage >= 11)
                bimboMessage = "Good Girls Giggle."
            elseif (rollMessage >= 10)
                bimboMessage = "Giggle your mind away."
            elseif (rollMessage >= 9)                
				bimboMessage = "It's fun to be a slut"
			elseif (rollMessage >= 8)
				bimboMessage = "Pleasure is all that matters"
			elseif (rollMessage >= 7)
				bimboMessage = "Get your brain fucked out now"
			elseif (rollMessage >= 6)
				bimboMessage = "Keep yourself wet"
			elseif (rollMessage >= 5)
				bimboMessage = "Think less. Suck more."
			elseif (rollMessage >= 4)
				bimboMessage = "Good girls fuck!"
			elseif (rollMessage >= 3)				
				bimboMessage = "Pink is for girls, brains are for boys."		
			elseif (rollMessage >= 2)
				bimboMessage = "You are a fuck doll"
			else
				bimboMessage = "*Giggle*"
			endIf
		endif
	endIf

	Debug.Notification(bimboMessage) ;temp messages
endfunction



; -------

Function debugTrace(string traceMsg)
	if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
		Debug.Trace("[SLH_fctUtil]" + traceMsg)
	endif
endFunction


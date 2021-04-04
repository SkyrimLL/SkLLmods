Scriptname SLS_QST_RedWaveController extends Quest  


SexLabFramework Property SexLab  Auto  

ReferenceAlias[] Property _SLS_RedWaveFollowerWhoresAliasRef  Auto  
ObjectReference[] Property _SLS_RedWaveFollowerWhores  Auto  

ObjectReference Property _SLS_TempWhore  Auto  


MiscObject Property Gold001  Auto  
GlobalVariable Property RedWavePlayerDebt  Auto  
GlobalVariable Property RedWavePlayerEarnings  Auto  

Function RedWaveStart()
	Actor PlayerActor = Game.GetPlayer()
	; Stop other mods like Deviously Enslaved while in RedWave
	SendModEvent("dhlp-Suspend")
	StorageUtil.SetIntValue(PlayerActor, "_SLS_iStoriesRedWaveJob", 1)
	SetPlayerStartingDebt(PlayerActor)
EndFunction

Function RedWaveStop()
	Actor PlayerActor = Game.GetPlayer()
	SendModEvent("dhlp-Resume")
	StorageUtil.SetIntValue(PlayerActor, "_SLS_iStoriesRedWaveJob", -1)
	RedWavePlayerDebt.SetValue(0)
	RedWavePlayerEarnings.SetValue(0)
EndFunction

Function RedWavePayPlayer(Int iGoldAmount)
	Actor PlayerActor = Game.GetPlayer()
	PlayerActor.AddItem(Gold001, iGoldAmount)
EndFunction

Function RedWavePayDebt(Int iGoldAmount)
	Actor PlayerActor = Game.GetPlayer()
	Int iCurrentDebt = RedWavePlayerDebt.GetValue() as Int

	iCurrentDebt = iCurrentDebt - iGoldAmount

	if (iCurrentDebt<0)
		iCurrentDebt = 0
	Endif

	RedWavePlayerDebt.SetValue(iCurrentDebt)
	RedWavePlayerEarnings.SetValue( (RedWavePlayerEarnings.GetValue() as Int ) + iGoldAmount )

	Debug.Notification("You now owe " + RedWavePlayerDebt.GetValue() as Int + " gold.")
EndFunction


Bool Function ReserveFollowerWhore()

	Bool bAdded = False
	Int iIdx = 0
	Int whoreArrayLen = 5

	While ( !bAdded && (iIdx < whoreArrayLen) )
		If ( _SLS_RedWaveFollowerWhores[iIdx] == None )
			bAdded = True
			_SLS_RedWaveFollowerWhores[iIdx] = _SLS_TempWhore 
			; _SLS_RedWaveFollowerWhoresAliasRef[iIdx].ForceRefTo( akObject )

			Debug.Trace("[Red Wave Whore list] Reserving whore: " +  iIdx )
		else
			Debug.Trace("[Red Wave Whore list] Whore sold: " +  _SLS_RedWaveFollowerWhores[iIdx].getName() )

		EndIf
		iIdx += 1
	EndWhile

	if (!bAdded)
			Debug.Trace("[Red Wave Whore list] Reservation not possible (maxed out)"  )
	endif

	Return bAdded

EndFunction

Bool Function AddFollowerWhore( ObjectReference akActorRef )

	Bool bAdded = False
	Int iIdx = 0
	Int whoreArrayLen = 5
	
	While ( !bAdded && (iIdx < whoreArrayLen) )
		If ( _SLS_RedWaveFollowerWhores[iIdx] == _SLS_TempWhore )
			bAdded = True
			_SLS_RedWaveFollowerWhores[iIdx] = akActorRef  
			_SLS_RedWaveFollowerWhoresAliasRef[iIdx].ForceRefTo( akActorRef )

			Debug.Trace("[Red Wave Whore list] Adding actor to queue: " + akActorRef.getName() )
		EndIf
		iIdx += 1
	EndWhile

	if (!bAdded)
			Debug.Trace("[Red Wave Whore list] Impossible to add (maxed out)"  )
	endif

	Return bAdded 
EndFunction

Function RedWaveSex(Actor akActor, Int goldAmount = 10, string sexTags = "Sex", Bool isSolo = False)
	Int randomNum = Utility.RandomInt(0,100)
	Actor PlayerActor = Game.GetPlayer()
	ActorBase PlayerBase = PlayerActor.GetBaseObject() as ActorBase
	ActorBase akActorBase = akActor.GetBaseObject() as ActorBase
	Int iRelationshipType = StorageUtil.GetIntValue(akActor, "_SD_iRelationshipType", -1)
	Int iRelationshipRank = akActor.GetRelationshipRank(PlayerActor)
	Int PlayerGender = PlayerBase.GetSex() ; 0 = Male ; 1 = Female

	Int ActorGender = akActorBase.GetSex() ; 0 = Male ; 1 = Female

;		Debug.MessageBox( "The Sister quietly peels off your clothes to reveal your beauty to the world." )
;  		SexLab.ActorLib.StripActor(Game.GetPlayer(), DoAnimate= false)

	If ( iRelationshipType >= 4 ) || (iRelationshipRank >= 4)
		if (randomNum <= 50)
			Debug.Notification("Anything for you honey..."  )
			PlayerActor.RemoveItem(Gold001, 1, akActor)
		else
			Debug.Notification("Hey sweetie.. so nice of you to come back."  )
			PlayerActor.RemoveItem(Gold001, goldAmount / 3)
		endif
		
	ElseIf ( iRelationshipType >= 2 ) || (iRelationshipRank >= 2)
		Debug.Notification("Hey sexy.. I like you a lot."  )
		PlayerActor.RemoveItem(Gold001, goldAmount / 2)
		
	ElseIf ( iRelationshipType == 1 ) || (iRelationshipRank == 1)
		PlayerActor.RemoveItem(Gold001, goldAmount)
		
	ElseIf ( iRelationshipType == 0 ) || (iRelationshipRank <= 0)
		PlayerActor.RemoveItem(Gold001, goldAmount)
		akActor.SendModEvent("OnSLDRobPlayer")

	Endif

	If  (SexLab.ValidateActor(PlayerActor) > 0) &&  (SexLab.ValidateActor(akActor) > 0) 

		sslThreadModel Thread = SexLab.NewThread()
		If (isSolo)	
			Thread.AddActor(akActor)
			If (ActorGender == 1)
				Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F,Sex","Estrus,Dwemer"))
			Else
				Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,M,Sex","Estrus,Dwemer"))
			EndIf
		Else
			If (PlayerGender == 1 && ActorGender == 1)
				Thread.AddActor(akActor)
				Thread.AddActor(PlayerActor)
				Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "Lesbian," + sexTags))
			elseIf (PlayerGender == 0 && ActorGender == 0)
				Thread.AddActor(akActor)
				Thread.AddActor(PlayerActor)
				Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "MM," + sexTags))
			else
				If PlayerGender == 1
					Thread.AddActor(PlayerActor)
					Thread.AddActor(akActor)
				else
					Thread.AddActor(akActor)
					Thread.AddActor(PlayerActor)
				endIf
				Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "MF," + sexTags))
			endIf
		Endif
		
		Thread.StartThread()

	Endif
Endfunction


float Function RedWavePlayerSex(Actor akActor, Int goldAmount = 10, string sexTags = "Sex", Bool isSolo = False)
	Int randomNum = Utility.RandomInt(0,100)
	Actor PlayerActor = Game.GetPlayer()
	ActorBase akActorBase = akActor.GetBaseObject() as ActorBase
	ActorBase PlayerBase = PlayerActor.GetBaseObject() as ActorBase
	Int iRelationshipType = StorageUtil.GetIntValue(akActor, "_SD_iRelationshipType" , -1)
	Int iRelationshipRank = akActor.GetRelationshipRank(PlayerActor)
	float Earnings = 0 
	Int PlayerGender = PlayerBase.GetSex() ; 0 = Male ; 1 = Female
	
	Int ActorGender = akActorBase.GetSex() ; 0 = Male ; 1 = Female

;		Debug.MessageBox( "The Sister quietly peels off your clothes to reveal your beauty to the world." )
;  		SexLab.ActorLib.StripActor(Game.GetPlayer(), DoAnimate= false)

	If ( iRelationshipType >= 4 ) || (iRelationshipRank >= 4)
		if (randomNum <= 50)
			Debug.Notification("Anything for you honey..."  )
			PlayerActor.AddItem(Gold001, 1)
		else
			Debug.Notification("Hey sweetie.. so nice of you to come back."  )
			PlayerActor.AddItem(Gold001, goldAmount / 3)
			Earnings = goldAmount / 3
		endif
		
	ElseIf ( iRelationshipType >= 2 ) || (iRelationshipRank >= 2)
		Debug.Notification("Hey sexy.. I like you a lot."  )
		PlayerActor.AddItem(Gold001, goldAmount / 2)
		Earnings = goldAmount / 2
	ElseIf ( iRelationshipType == 1 ) || (iRelationshipRank == 1)
		PlayerActor.AddItem(Gold001, goldAmount)
		Earnings = goldAmount
	ElseIf ( iRelationshipType == 0 ) || (iRelationshipRank <= 0)
		PlayerActor.AddItem(Gold001, goldAmount)
		Earnings = goldAmount
	Endif


	If  (SexLab.ValidateActor(PlayerActor) > 0) &&  (SexLab.ValidateActor(akActor) > 0) 

		sslThreadModel Thread = SexLab.NewThread()
		If (isSolo)	
			Thread.AddActor(akActor)
			If (ActorGender == 1)
				Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F,Sex","Estrus,Dwemer"))
			Else
				Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,M,Sex","Estrus,Dwemer"))
			EndIf
		Else
			If (PlayerGender == 1 && ActorGender == 1)
				Thread.AddActor(PlayerActor)
				Thread.AddActor(akActor)
				Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "Lesbian," + sexTags))
			elseIf (PlayerGender == 0 && ActorGender == 0)
				Thread.AddActor(PlayerActor)
				Thread.AddActor(akActor)
				Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "MM," + sexTags))
			else
				If PlayerGender == 1
					Thread.AddActor(PlayerActor)
					Thread.AddActor(akActor)
				else
					Thread.AddActor(akActor)
					Thread.AddActor(PlayerActor)
				endIf
				Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "MF," + sexTags))
			endIf
		Endif
		Thread.StartThread()
	Endif
	return Earnings
Endfunction

function SetPlayerStartingDebt(Actor kActor)
	int iDebtAmount = Utility.RandomInt(10) * 100 + 500

	iDebtAmount += GetPlayerValueModifier(kActor) * 100

    RedWavePlayerDebt.SetValue(iDebtAmount) 
	RedWavePlayerEarnings.SetValue(0)   

	Debug.Notification("You now owe " + RedWavePlayerDebt.GetValue() as Int + " gold.")

Endfunction

Int function GetPlayerValueModifier(Actor kActor)
	Int iPlayerValueMod = 0

	; Modifiers based on player's status
	if (isPregnant(kActor))
		iPlayerValueMod += 5
	endif


	if (StorageUtil.GetIntValue(kActor, "_SLP_toggleSpiderEgg" )==1) || (StorageUtil.GetIntValue(kActor, "_SLP_toggleChaurusWorm" )==1) || (StorageUtil.GetIntValue(kActor, "_SLP_toggleChaurusWormVag" )==1)
		iPlayerValueMod += 2
	endif

	if (StorageUtil.GetIntValue(kActor, "_SLP_toggleFaceHugger" )==1) || (StorageUtil.GetIntValue(kActor, "_SLP_toggleTentacleMonster" )==1) || (StorageUtil.GetIntValue(kActor, "_SLP_toggleLivingArmor" )==1) || (StorageUtil.GetIntValue(kActor, "_SLP_toggleBarnacles" )==1) || (StorageUtil.GetIntValue(kActor, "_SLP_toggleChaurusQueenVag" )==1) || (StorageUtil.GetIntValue(kActor, "_SLP_toggleChaurusQueenGag" )==1)
		iPlayerValueMod += 1
	endif

	If (StorageUtil.GetIntValue(kActor, "_SLH_iLactating") == 1)
		iPlayerValueMod += 1
	endif

	if (StorageUtil.GetIntValue(kActor, "_SLH_iSuccubus") == 1)
		iPlayerValueMod += 10
	endif

	if (StorageUtil.GetIntValue(kActor, "_SLH_iBimbo") == 1)
		iPlayerValueMod += 5
	endif

	if (StorageUtil.GetIntValue(kActor, "_SLH_iHRT") == 1) || (StorageUtil.GetIntValue(kActor, "_SLH_iTG") == 1)
		iPlayerValueMod += 2
	endif

	return iPlayerValueMod
Endfunction
 

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

bool function isPregnant(actor kActor)
	return ( isPregnantBySoulGemOven(kActor) || isPregnantBySimplePregnancy(kActor) || isPregnantByBeeingFemale(kActor) || isPregnantByEstrusChaurus(kActor) || ((StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SuccubusON") == 1) && (StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SoulGemPregnancyON") == 1)) )
 
EndFunction
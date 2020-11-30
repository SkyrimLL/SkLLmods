Scriptname SLS_PlayerRedWaveAlias extends ReferenceAlias  


ReferenceAlias Property PlayerAlias  Auto  
SexLabFramework     property SexLab Auto

SLS_QST_RedWaveController Property RedWaveController Auto

objectreference property SLS_PlayerRedWaveStartMarker auto
objectreference property SLS_PlayerRedWaveSorage auto

Faction Property RedWaveShipFaction  Auto  
Faction Property RedWaveFaction  Auto  
Faction Property RedWaveWhoreFaction  Auto  
Faction Property RedWaveCrimeFaction Auto

Armor Property WhoreCollar Auto
Armor Property WhoreDress Auto
Potion Property Skooma Auto
Potion Property AltoWine Auto

GlobalVariable Property PlayerCurrentEarnings Auto
GlobalVariable Property PlayerRedWaveDebt Auto
GlobalVariable Property PlayerDayPass Auto
Quest Property SLS_PlayerRedWaveQuest  Auto  

Location Property RedWaveLocation Auto

bool  bIsPregnant = false 
bool  bBeeingFemale = false 
bool  bEstrusChaurus = false 

int daysPassed
int iGameDateLastCheck = -1
int iDaysSinceLastCheck
int iDebtLastCheck
int iCurrentEarnings


Event OnInit()
	_maintenance()
	RegisterForSingleUpdate(10)
EndEvent

Event OnPlayerLoadGame()
	_maintenance()
	RegisterForSingleUpdate(10)
EndEvent


Function _Maintenance()
	Actor PlayerActor= Game.GetPlayer() as Actor

	If (!StorageUtil.HasIntValue(none, "_SLS_iStoriesPlayerRedWave"))
	 	StorageUtil.SetIntValue(none, "_SLS_iStoriesPlayerRedWave", 0)
	EndIf

	UnregisterForAllModEvents()
	; Debug.Trace("SexLab Stories: Reset SexLab events")
	; RegisterForModEvent("AnimationStart", "OnSexLabStart")
	; RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	; RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")

	RegisterForModEvent("_SLS_PlayerRedWave", "OnPlayerRedWave")

	RegisterForModEvent("RedWaveSex",   "OnSDStorySex")
	RegisterForModEvent("RedWaveEntertain",   "OnSDStoryEntertain")
	RegisterForModEvent("RedWaveWhip",   "OnSDStoryWhip")
	RegisterForModEvent("RedWavePunish",   "OnSDStoryPunish")
	
EndFunction

Event OnUpdate()
	Actor PlayerActor= Game.GetPlayer() as Actor

	If  !Self || !SexLab || (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerRedWave")==0)
		Return
	EndIf

	If (StorageUtil.GetIntValue(PlayerActor, "_SLS_iStoriesRedWaveJob") == -1)
		Return
	EndIf	

 	daysPassed = Game.QueryStat("Days Passed")

 	; Initial values
 	if (iGameDateLastCheck == -1)
 		iGameDateLastCheck = daysPassed
		iDebtLastCheck = (PlayerRedWaveDebt.GetValue() as Int) + (PlayerCurrentEarnings.GetValue() as Int)
		PlayerDayPass.SetValue(daysPassed - 2)
 	endIf
 
 	iCurrentEarnings = iDebtLastCheck - (PlayerRedWaveDebt.GetValue() as Int) 
	iDaysSinceLastCheck = (daysPassed - iGameDateLastCheck ) as Int

	PlayerCurrentEarnings.SetValue(iCurrentEarnings)

	If (iDaysSinceLastCheck > 0)
		iDebtLastCheck = PlayerRedWaveDebt.GetValue() as Int
	endIf

	iGameDateLastCheck = daysPassed  

	RegisterForSingleUpdate(10)
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	If  !Self || !SexLab || (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerRedWave")==0)
		Return
	EndIf

	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()
	Int daysSinceLastPass 
	Int iGold 

	If (StorageUtil.GetIntValue(akActor, "_SLS_iStoriesRedWaveJob") == -1)
		Return
	EndIf
	 
 	daysPassed = Game.QueryStat("Days Passed")
	daysSinceLastPass = daysPassed - (PlayerDayPass.GetValue() as Int )
	

	If (daysSinceLastPass < 1) &&  (PlayerRedWaveDebt.GetValue()>0) && (akOldLoc == RedWaveLocation) && (akNewLoc != RedWaveLocation)
		; Day pass is in effect - no penalty

	ElseIf (daysSinceLastPass >= 1) &&  (PlayerRedWaveDebt.GetValue()>0) && (akNewLoc == RedWaveLocation)  
		; Day pass is over but player returned to RedWave in time

		; Pay bounty and add to debt
		iGold = RedWaveCrimeFaction.GetCrimeGold()
		RedWaveCrimeFaction.PlayerPayCrimeGold( True, False )
		PlayerRedWaveDebt.SetValue( (PlayerRedWaveDebt.GetValue() as Int ) + iGold )

		Debug.Notification("Your bounty has been paid.")
		Debug.Notification("You now owe " + (PlayerRedWaveDebt.GetValue() as Int ) + " gold.")

	ElseIf (PlayerRedWaveDebt.GetValue()>0) && (akOldLoc == RedWaveLocation) && (akNewLoc != RedWaveLocation)
		Debug.Notification("Run away whores are not looked upon kindly.")
		if (RedWaveCrimeFaction.GetCrimeGold() < 5000)
			RedWaveCrimeFaction.ModCrimeGold(100)
		endif
	endif

EndEvent

Event OnPlayerRedWave(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	StorageUtil.SetIntValue(none, "_SLS_iStoriesPlayerRedWave", 1)

	If (!(StorageUtil.HasIntValue(none, "_SLS_iPlayerStartRedWave")))
		StorageUtil.SetIntValue(none, "_SLS_iPlayerStartRedWave", 0)
	EndIf

	; PlayerActor.MoveTo(SLS_PlayerRedWaveStartMarker)

	PlayerActor.RemoveAllItems(akTransferTo = SLS_PlayerRedWaveSorage, abKeepOwnership = True)

	PlayerActor.addtofaction(RedWaveShipFaction)  
	PlayerActor.addtofaction(RedWaveFaction) 
	PlayerActor.addtofaction(RedWaveWhoreFaction )  

	PlayerActor.EquipItem(WhoreCollar)
	PlayerActor.EquipItem(WhoreDress)
	Utility.Wait(1.0)
	PlayerActor.EquipItem(Skooma)
	PlayerActor.EquipItem(Skooma)
	PlayerActor.EquipItem(AltoWine)
	PlayerActor.EquipItem(AltoWine)

	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryLevel", 3)
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryExposure", 30)


	If (bBeeingFemale) && isFemale(PlayerActor) && (StorageUtil.GetIntValue(none, "_SLS_iPlayerStartRedWave") == 1) && (_args == "Pregnancy")
		PlayerActor.SendModEvent("BeeingFemale", "ChangeState", 5)  ;5, 6, 7 for 2nd, 3rd, labor
		StorageUtil.SetFloatValue(PlayerActor,"FW.UnbornHealth",100.0)
		StorageUtil.UnsetIntValue(PlayerActor,"FW.Abortus")
		StorageUtil.FormListClear(PlayerActor,"FW.ChildFather")
		StorageUtil.SetIntValue(PlayerActor,"FW.NumChilds", 1)
		StorageUtil.FormListAdd(PlayerActor,"FW.ChildFather", none )

		SLS_PlayerRedWaveQuest.SetStage(15)
	Else
		SLS_PlayerRedWaveQuest.SetStage(10)
	EndIf

	if PlayerRedWaveDebt.GetValue() <= 0
		PlayerRedWaveDebt.SetValue(2000)
	endIf

	RegisterForSingleUpdate(10)

EndEvent




Event OnSDStorySex(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer()
	Actor kTempAggressor = StorageUtil.GetFormValue( kPlayer, "_SD_TempAggressor") as Actor
	; int storyID = _argc as Int
	float fGold = 0

	if (kActor != None)
		; StorageUtil _SD_TempAggressor is deprecated
		; Use _sender through kActor.SendModEvent("") in priority instead 
		kTempAggressor = kActor
	EndIf

	Debug.Trace("[SLS_PlayerRedWaveAlias] Receiving sex story event [" + _args  + "] [" + _argc as Int + "]")

	If (kTempAggressor != None)
		StorageUtil.SetFormValue(kPlayer, "_SD_TempAggressor", None)
	; ElseIf (StorageUtil.GetIntValue(kPlayer, "_SD_iEnslaved") == 1)
	; 	kTempAggressor = _SD_Enslaved.GetMaster() as Actor
	Else
		Return
	EndIf
 
	if  (_args == "Gangbang") && (SexLab.GetAnimationByName("FunnyBizness Missionary Rape")!= None)
		fGold = RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = "FunnyBizness,Forced,", isSolo = False)
	Else 
		; Debug.Trace("[_sdras_player] Sending sex story")
		if  (_args == "") 
			_args = "Aggressive"
		endif

		fGold = RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = _args, isSolo = False)
	EndIf
	PlayerRedWaveDebt.SetValue(  PlayerRedWaveDebt.GetValue() -  (fGold - (fGold/10) ) )
	Debug.Notification("You now owe " + PlayerRedWaveDebt.GetValue() as Int + " gold.")
EndEvent

Event OnSDStoryEntertain(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer()
	Actor kTempAggressor = StorageUtil.GetFormValue( kPlayer, "_SD_TempAggressor") as Actor
	; int storyID = _argc as Int
	float fGold = 0

	if (kActor != None)
		; StorageUtil _SD_TempAggressor is deprecated
		; Use _sender through kActor.SendModEvent("") in priority instead 
		kTempAggressor = kActor
	EndIf

	; Debug.Notification("[_sdras_slave] Receiving dance story event [" + _args  + "] [" + _argc as Int + "]")
	Debug.Trace("[SLS_PlayerRedWaveAlias] Receiving dance story event [" + _args  + "] [" + _argc as Int + "]")

	If (kTempAggressor != None)
		StorageUtil.SetFormValue(kPlayer, "_SD_TempAggressor", None)
	; ElseIf (StorageUtil.GetIntValue(kPlayer, "_SD_iEnslaved") == 1)
	;	kTempAggressor = _SD_Enslaved.GetMaster() as Actor
	Else
		Return
	EndIf

	if  (_args == "Dance")
		; Debug.Notification("[_sdras_slave] Receiving Dance")
		Int iActorSpeech = kTempAggressor.GetActorValue("Speechcraft") As Int
		Float fActorStamina = kTempAggressor.getActorValuePercentage("Stamina") * 100
		Float fDance = (fActorStamina +(50 - (iActorSpeech - 50))) * 0.5
		
		If (fDance > 80)
			Debug.SendAnimationEvent(kTempAggressor, "FNISSPc20")
		elseIf (fDance > 60)
			Debug.SendAnimationEvent(kTempAggressor, "FNISSPc21")
		elseIf (fDance > 40)
			Debug.SendAnimationEvent(kTempAggressor, "FNISSPc22")
		elseIf (fDance > 20)
			Debug.SendAnimationEvent(kTempAggressor, "FNISSPc23")
		else
			Debug.SendAnimationEvent(kTempAggressor, "FNISSPc24")
		endIf
		fGold = 20
	Elseif (_args == "Soloshow")
		; Debug.Notification("[_sdras_slave] Receiving Show")

		fGold = RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 10, sexTags = "", isSolo = True)

	EndIf
	PlayerRedWaveDebt.SetValue(  PlayerRedWaveDebt.GetValue() -  (fGold - (fGold/10) ) )
	Debug.Notification("You now owe " + PlayerRedWaveDebt.GetValue() as Int + " gold.")

EndEvent

Event OnSDStoryWhip(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer()
	Actor kTempAggressor = StorageUtil.GetFormValue( kPlayer, "_SD_TempAggressor") as Actor
	float fGold = 0

	if (kActor != None)
		; StorageUtil _SD_TempAggressor is deprecated
		; Use _sender through kActor.SendModEvent("") in priority instead 
		kTempAggressor = kActor
	EndIf

	Debug.Trace("[SLS_PlayerRedWaveAlias] Receiving whip story event [" + _args  + "] [" + _argc as Int + "]")

	If (SexLab.GetAnimationByName("FB_DrugFuck")!= None)
		fGold = RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = "FunnyBizness,Forced,Sex", isSolo = False)

	ElseIf (SexLab.GetAnimationByName("BoundDoggyStyle")!= None)
		fGold = RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = "Wrists,DomSub", isSolo = False)

	Else
		fGold = RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = "Aggressive", isSolo = False)
	Endif

	PlayerRedWaveDebt.SetValue(  PlayerRedWaveDebt.GetValue() -  (fGold - (fGold/10) ) )
	Debug.Notification("You now owe " + PlayerRedWaveDebt.GetValue() as Int + " gold.")

EndEvent

Event OnSDStoryPunish(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer()
	Actor kTempAggressor = StorageUtil.GetFormValue( kPlayer, "_SD_TempAggressor") as Actor
	float fGold = 0
 
	if (kActor != None)
		; StorageUtil _SD_TempAggressor is deprecated
		; Use _sender through kActor.SendModEvent("") in priority instead 
		kTempAggressor = kActor
	EndIf

	Debug.Trace("[SLS_PlayerRedWaveAlias] Receiving punish story event [" + _args  + "] [" + _argc as Int + "]")

	If (kTempAggressor != None)
		StorageUtil.SetFormValue(kPlayer, "_SD_TempAggressor", None)
	; ElseIf (StorageUtil.GetIntValue(kPlayer, "_SD_iEnslaved") == 1)
	;	kTempAggressor = _SD_Enslaved.GetMaster() as Actor
	Else
		Return
	EndIf
 
	If (SexLab.GetAnimationByName("FB_ExtremeDoggy")!= None)
		fGold = RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = "FunnyBizness,Forced,Sex,Bound,Wrists", isSolo = False)

	ElseIf (SexLab.GetAnimationByName("BoundDoggyStyle")!= None)
		fGold = RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = "Pillory", isSolo = False)

	Else
		fGold = RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = "Aggressive", isSolo = False)
	Endif
	PlayerRedWaveDebt.SetValue(  PlayerRedWaveDebt.GetValue() -  (fGold - (fGold/10) ) )
	Debug.Notification("You now owe " + PlayerRedWaveDebt.GetValue() as Int + " gold.")
EndEvent


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
	bIsPregnant = ( isPregnantBySoulGemOven(kActor) || isPregnantBySimplePregnancy(kActor) || isPregnantByBeeingFemale(kActor) || isPregnantByEstrusChaurus(kActor) || ((StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SuccubusON") == 1) && (StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SoulGemPregnancyON") == 1)) )
	Return bIsPregnant
EndFunction

Bool function isFemale(actor kActor)
	Bool bIsFemale
	ActorBase kActorBase = kActor.GetActorBase()

	if (kActorBase.GetSex() == 1) ; female
		bIsFemale = True
	Else
		bIsFemale = False
	EndIf

	return bIsFemale
EndFunction

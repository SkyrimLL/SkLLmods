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
spell  BeeingFemalePregnancy 
spell  ChaurusBreeder 

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

	; UnregisterForAllModEvents()
	; Debug.Trace("SexLab Stories: Reset SexLab events")
	; RegisterForModEvent("AnimationStart", "OnSexLabStart")
	; RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	; RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")

	RegisterForModEvent("_SLS_PlayerRedWave", "OnPlayerRedWave")

	If (!StorageUtil.HasIntValue(none, "_SLD_version")) && (!StorageUtil.HasIntValue(none, "_SD_version"))
		RegisterForModEvent("PCSubSex",   "OnSDStorySex")
		RegisterForModEvent("PCSubEntertain",   "OnSDStoryEntertain")
		RegisterForModEvent("PCSubWhip",   "OnSDStoryWhip")
		RegisterForModEvent("PCSubPunish",   "OnSDStoryPunish")
	Endif
	
	_InitExternalPregancy()

EndFunction

Event OnUpdate()

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
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()
	Int daysSinceLastPass 
	Int iGold 

 	daysPassed = Game.QueryStat("Days Passed")
	daysSinceLastPass = daysPassed - (PlayerDayPass.GetValue() as Int )
	
	If  !Self || !SexLab || (StorageUtil.GetIntValue(none, "_SLS_iStoriesPlayerRedWave")==0)
		Return
	EndIf

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

	If (!StorageUtil.HasIntValue(none, "_SLS_iStoriesPlayerRedWave"))
	 	StorageUtil.SetIntValue(none, "_SLS_iStoriesPlayerRedWave", 1)
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

	If (bBeeingFemale) && isFemale(PlayerActor)
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

EndEvent




Event OnSDStorySex(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer()
	Actor kTempAggressor = StorageUtil.GetFormValue( kPlayer, "_SD_TempAggressor") as Actor
	; int storyID = _argc as Int

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
		RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = "FunnyBizness,Forced,", isSolo = False)

	Else 
		; Debug.Trace("[_sdras_player] Sending sex story")
		if  (_args == "") 
			_args = "Aggressive"
		endif

		RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = _args, isSolo = False)


	EndIf
EndEvent

Event OnSDStoryEntertain(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer()
	Actor kTempAggressor = StorageUtil.GetFormValue( kPlayer, "_SD_TempAggressor") as Actor
	; int storyID = _argc as Int

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

	if  (_args == "Gangbang")
		; Debug.Notification("[_sdras_slave] Receiving Gangbang")
		; funct.SanguineGangRape( kTempAggressor, kPlayer, True, False)

	Elseif (_args == "Soloshow")
		; Debug.Notification("[_sdras_slave] Receiving Show")

		RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 10, sexTags = "", isSolo = True)

	EndIf

EndEvent

Event OnSDStoryWhip(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer()
	Actor kTempAggressor = StorageUtil.GetFormValue( kPlayer, "_SD_TempAggressor") as Actor

	if (kActor != None)
		; StorageUtil _SD_TempAggressor is deprecated
		; Use _sender through kActor.SendModEvent("") in priority instead 
		kTempAggressor = kActor
	EndIf

	Debug.Trace("[SLS_PlayerRedWaveAlias] Receiving whip story event [" + _args  + "] [" + _argc as Int + "]")

	If (SexLab.GetAnimationByName("FB_DrugFuck")!= None)
		RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = "FunnyBizness,Forced,Sex", isSolo = False)

	ElseIf (SexLab.GetAnimationByName("BoundDoggyStyle")!= None)
		RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = "Wrists,DomSub", isSolo = False)

	Else
		RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = "Aggressive", isSolo = False)
	Endif

EndEvent

Event OnSDStoryPunish(String _eventName, String _args, Float _argc = 1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor kPlayer = Game.GetPlayer()
	Actor kTempAggressor = StorageUtil.GetFormValue( kPlayer, "_SD_TempAggressor") as Actor
 
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
		RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = "FunnyBizness,Forced,Sex,Bound,Wrists", isSolo = False)

	ElseIf (SexLab.GetAnimationByName("BoundDoggyStyle")!= None)
		RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = "Pillory", isSolo = False)

	Else
		RedWaveController.RedWavePlayerSex( akActor = kTempAggressor, goldAmount = 50, sexTags = "Aggressive", isSolo = False)
	Endif
EndEvent


Function _InitExternalPregancy()
	bEstrusChaurus = false
	bBeeingFemale = false
	int idx = Game.GetModCount()
	string modName = ""
	while idx > 0
	idx -= 1
	modName = Game.GetModName(idx)

	if modName == "EstrusChaurus.esp"
	  bEstrusChaurus = true
	  ChaurusBreeder = Game.GetFormFromFile(0x00019121, modName) as spell

	elseif modName == "BeeingFemale.esm"
	  bBeeingFemale = true
	  BeeingFemalePregnancy = Game.GetFormFromFile(0x000028A0, modName) as spell
	endif
	endWhile
EndFunction

bool function isPregnantBySoulGemOven(actor kActor) 
  	return (StorageUtil.GetIntValue(Game.GetPlayer(), "sgo_IsBellyScaling") == 1) || (StorageUtil.GetIntValue(Game.GetPlayer(), "sgo_IsBreastScaling ") == 1)

endFunction

bool function isPregnantBySimplePregnancy(actor kActor) 
  	return StorageUtil.HasFloatValue(kActor, "SP_Visual")

endFunction

bool function isPregnantByBeeingFemale(actor kActor)
	 if ( (bBeeingFemale==true) &&  ( (StorageUtil.GetIntValue(kActor, "FW.CurrentState")>=4) && (StorageUtil.GetIntValue(kActor, "FW.CurrentState")<=8))  )
    	return true
	endIf
	return false
endFunction
 
bool function isPregnantByEstrusChaurus(actor kActor)
	if bEstrusChaurus==true && ChaurusBreeder != none
	return kActor.HasSpell(ChaurusBreeder)
	endIf
	return false
endFunction

bool function isPregnant(actor kActor)
	bIsPregnant = ( isPregnantBySoulGemOven(kActor) || isPregnantBySimplePregnancy(kActor) || isPregnantByBeeingFemale(kActor) || isPregnantByEstrusChaurus(kActor) || ((StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SuccubusON") == 1) && (StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SoulGemPregnancyON") == 1)) )
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

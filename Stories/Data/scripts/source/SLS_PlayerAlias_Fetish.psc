Scriptname SLS_PlayerAlias_Fetish extends ReferenceAlias  

ReferenceAlias Property PlayerAlias  Auto  
SexLabFramework     property SexLab Auto

; slaUtil.SetActorExhibitionist(kSanguine, True)
; slaUtil.UpdateActorExposureRate(kSanguine, 10.0)

GlobalVariable Property _SLS_FetishID  Auto  
slaUtilScr Property slaUtil  Auto  

ObjectReference Property LotteRef Auto

 
Keyword Property ArmorOn  Auto  

Keyword Property ClothingOn  Auto  

AssociationType Property SpouseType  Auto  
GlobalVariable Property _SLS_NPCSexCount  Auto  
GlobalVariable Property _SLS_NPCRumorsON  Auto  
bool  bIsPregnant = false 
bool  bBeeingFemale = false 
bool  bEstrusChaurus = false 

Int iArousalThrottle ; Chance of success to consider updating arousal

;  0- No fetish
;  1- The Apprentice Stone - Craft / Hitting / Dom
;  2- The Atronach Stone - Killing monsters
;  3- The Lady Stone - Wearing Jewelry
;  4- The Lord Stone - Wearing Armor
;  5- The Lover Stone - Being Nude / Sex
;  6- The Mage Stone - Using magic
;  7- The Ritual Stone - Specific NPC / spouse
;  8- The Serpent Stone - Killing animals
;  9- The Shadow Stone - Killing humans
; 10- The Steed Stone - Bestiality
; 11- The Thief Stone - Stealing
; 12- The Tower Stone - Wearing leather / being hit / sub
; 13- The Warrior Stone - Using weapons

objectreference property SLS_PlayerRedWaveStartMarker auto
objectreference property SLS_PlayerSexbotStartMarker auto
objectreference property SLS_PlayerPetStartMarker auto
objectreference property SLS_PlayerMilkFarmStartMarker auto
objectreference property SLS_PlayerAliciaStartMarker auto
objectreference property SLS_PlayerSprigganStartMarker auto  ; Deprecated - had to create a dulicate because of Skyrim's shitty baked properties in saved games
objectreference property SLS_PlayerSprigganRootStartMarker auto
objectreference property SLS_PlayerKinStartMarker auto
objectreference property SLS_PlayerDibellaStartMarker auto
objectreference property SLS_PlayerNordicQueenStartMarker auto
objectreference property SLS_PlayerChaurusQueenStartMarker auto
objectreference property SLS_PlayerBroodMaidenStartMarker auto

Faction Property RedWaveShipFaction  Auto  
Faction Property RedWaveFaction  Auto  
Faction Property RedWaveWhoreFaction  Auto  
Faction Property FalmerFaction  Auto  
Faction Property ChaurusFaction  Auto  
Faction Property DremoraFaction  Auto  
Faction Property NecromancerFaction  Auto  
Faction Property ForswornFaction  Auto  
Faction Property HagravenFaction  Auto  
Faction Property DwemerBotFaction  Auto  
Faction Property DraugrFaction  Auto  
Faction Property AtronachFlameFaction  Auto  
Faction Property SprigganFaction  Auto  

Spell Property NordicQueenPolymorph Auto
Quest Property NordicQueenGauldurQuest Auto

Event OnInit()
	_maintenance()
	_getGameStats()
EndEvent	

Event OnPlayerLoadGame()
	_maintenance()
	_getGameStats()
EndEvent


Function _Maintenance()
	Actor PlayerActor= Game.GetPlayer() as Actor

	If (!StorageUtil.HasIntValue(none, "_SLS_iStories"))
		StorageUtil.SetIntValue(none, "_SLS_iStories", 1)
	EndIf

	Int iCurrentVersionNumber = 20210531
	Int iVersionNumber = StorageUtil.GetIntValue(none, "_SLP_iStoriesVersion")	
	
	If (iVersionNumber != iCurrentVersionNumber)
		Debug.Notification("[SLH] Upgrading Stories to " + iCurrentVersionNumber)

		If (iVersionNumber <= 20210531) 
			;
		Endif
 
		StorageUtil.SetIntValue(none, "_SLP_iStoriesVersion", iCurrentVersionNumber)	
	Endif

	UnregisterForAllModEvents()
	; Debug.Trace("SexLab Stories: Reset SexLab events")
	; RegisterForModEvent("AnimationStart", "OnSexLabStart")
	; RegisterForModEvent("AnimationEnd",   "OnSexLabEnd")
	; RegisterForModEvent("OrgasmStart",    "OnSexLabOrgasm")

	; Player holder registration of player start story events - will be replaced by their own quest eventually
	RegisterForModEvent("_SLS_PCStartRedWave", "OnPCStartRedWave")
	RegisterForModEvent("_SLS_PCStartSexbot", "OnPCStartSexbot")
	RegisterForModEvent("_SLS_PCStartPet", "OnPCStartPet")
	RegisterForModEvent("_SLS_PCStartMilkFarm", "OnPCStartMilkFarm")
	RegisterForModEvent("_SLS_PCStartAlicia", "OnPCStartAlicia")
	RegisterForModEvent("_SLS_PCStartSpriggan", "OnPCStartSpriggan")
	RegisterForModEvent("_SLS_PCStartKin", "OnPCStartKin")
	RegisterForModEvent("_SLS_PCStartDibella", "OnPCStartDibella")
	RegisterForModEvent("_SLS_PCStartNordicQueen", "OnPCStartNordicQueen")
	RegisterForModEvent("_SLS_PCStartChaurusQueen", "OnPCStartChaurusQueen")
	RegisterForModEvent("_SLS_PCStartBroodMaiden", "OnPCStartBroodMaiden")

	; _SLS_NPCSexCount.SetValue(-1)

	; Init during upgrade
	if !(StorageUtil.HasIntValue( PlayerActor, "_SLS_toggleNPCRumors" ))
		StorageUtil.SetIntValue(PlayerActor, "_SLS_toggleNPCRumors",1 )
		_SLS_NPCRumorsON.SetValue( 1 )
	endif
	
	If ( (_SLS_NPCRumorsON.GetValue() as Int) != StorageUtil.GetIntValue(PlayerActor, "_SLS_toggleNPCRumors" ))
	; 	Debug.Notification("[SLS] Updating Rumors valueiPad  ")
		_SLS_NPCRumorsON.SetValue( StorageUtil.GetIntValue(PlayerActor, "_SLS_toggleNPCRumors" ) )
	endIf

	StorageUtil.SetFormValue(none, "_SLS_UniqueActorLotte", LotteRef as Form)

	; Mod detection / compatibility
	StorageUtil.SetIntValue(none, "_SLS_isEstrusChaurusON",  0) 
	StorageUtil.SetIntValue(none, "_SLS_isBeeingFemaleON",  0) 
	StorageUtil.SetIntValue(none, "_SLS_isCagedFollowerON",  0) 

	int idx = Game.GetModCount()
	string modName = ""
	while idx > 0
		idx -= 1
		modName = Game.GetModName(idx)
		if modName == "EstrusChaurus.esp"
			StorageUtil.SetIntValue(none, "_SLS_isEstrusChaurusON",  1) 
			StorageUtil.SetFormValue(none, "_SLS_getEstrusChaurusBreederSpell",  Game.GetFormFromFile(0x00019121, modName)) ; as Spell

		elseif modName == "BeeingFemale.esm"
			StorageUtil.SetIntValue(none, "_SLS_isBeeingFemaleON",  1) 
			StorageUtil.SetFormValue(none, "_SLS_getBeeingFemalePregnancySpell",  Game.GetFormFromFile(0x000028A0, modName)) ; as Spell

		elseif modName == "CagedFollowers.esp"
			StorageUtil.SetIntValue(none, "_SLS_isCagedFollowerON",  1) 
			StorageUtil.SetFormValue(none, "_SLS_getCagedFollowerQuestKeyword",  Game.GetFormFromFile(0x0000184d, modName)) ; as Keyword

		endif
	endWhile
EndFunction

Event OnPCStartRedWave(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	StorageUtil.SetIntValue(none, "_SLS_iPlayerStartRedWave", 1)

	; Enable Hormone changes
	StorageUtil.SetIntValue(none, "_SLH_iHormonesSleepInit", 1)

	PlayerActor.MoveTo(SLS_PlayerRedWaveStartMarker)  
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryLevel", 3)
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryExposure", 30)

	SendModEvent("_SLS_PlayerRedWave", "Pregnancy")

	Debug.MessageBox("Ohhh my head. Another night of drunken stupor. Maybe today I will make enough for the crew to earn a pass and get some air. The stench of sex is everywhere.")

EndEvent

Event OnPCStartSexbot(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	StorageUtil.SetIntValue(none, "_SLS_iPlayerStartSexbot", 1)

	; Enable Hormone changes
	StorageUtil.SetIntValue(none, "_SLH_iHormonesSleepInit", 1)

	PlayerActor.MoveTo(SLS_PlayerSexBotStartMarker)
	PlayerActor.addtofaction(DwemerBotFaction) 
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryLevel", 5)
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryExposure", 500)

	SendModEvent("_SLS_PlayerSexBot")

	Debug.MessageBox(">Who am I?\nMemory banks corrupted.\n>Where am I?\nThe Forge.\n> Why am I here?\nMemory banks corrupted.")

EndEvent

Event OnPCStartPet(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	StorageUtil.SetIntValue(none, "_SLS_iPlayerStartPet", 1)

	; Enable Hormone changes
	StorageUtil.SetIntValue(none, "_SLH_iHormonesSleepInit", 1)

	PlayerActor.MoveTo(SLS_PlayerPetStartMarker)
	PlayerActor.addtofaction(NecromancerFaction) 
	PlayerActor.addtofaction(AtronachFlameFaction) 
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryLevel", 5)
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryExposure", 500)
	PlayerActor.SendModEvent("SDEquipDevice",   "Gag")
	PlayerActor.SendModEvent("SDEquipDevice",   "PlugAnal")
	PlayerActor.SendModEvent("SDEquipDevice",   "Plugvaginal")
	PlayerActor.SendModEvent("SDEquipDevice",   "Belt")
	PlayerActor.SendModEvent("SDEquipDevice",   "Armbinder")
	PlayerActor.SendModEvent("SDEquipDevice",   "Collar")
	; PlayerActor.SendModEvent("SDEquipDevice",   "Harness")
	; PlayerActor.SendModEvent("SDEquipDevice",   "Yoke")

	SendModEvent("_SLS_PlayerPet")

	Debug.MessageBox("There is your master and the fire repressed inside you. Nothing else. Your master gave you a new life. Who you were before doesn't matter anymore. Only your master and the fire.")

EndEvent

Event OnPCStartMilkFarm(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	StorageUtil.SetIntValue(none, "_SLS_iPlayerStartMilkFarm", 1)

	; Enable Hormone changes
	StorageUtil.SetIntValue(none, "_SLH_iHormonesSleepInit", 1)

	PlayerActor.MoveTo(SLS_PlayerMilkFarmStartMarker)

	; StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 2.0 ) 
	; StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 100.0 ) 
	; PlayerActor.SendModEvent("SLHRefresh") 
	; PlayerActor.SendModEvent("_SLSDDi_EquipMilkingDevice")

	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryLevel", 2)
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryExposure", 20)

	PlayerActor.SendModEvent("_SLSDDi_UpdateCow")

	SendModEvent("_SLS_PlayerMilkFarm")

	Debug.MessageBox("You are so excited to have been chosen as one of Mistress Leonara's special flock. Any day now, you are ready to feel milk flowing through your breasts. If only you could find a way to produce more milk for her Divine Cheese...")

EndEvent

Event OnPCStartAlicia(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	StorageUtil.SetIntValue(none, "_SLS_iPlayerStartAlicia", 1)

	; Enable Hormone changes
	StorageUtil.SetIntValue(none, "_SLH_iHormonesSleepInit", 1)

	If (!StorageUtil.HasIntValue(none, "_SD_iSanguine")) && (!StorageUtil.HasIntValue(none, "_SD_version"))
		PlayerActor.MoveTo(SLS_PlayerAliciaStartMarker)
	Else
		PlayerActor.SendModEvent("SDDreamworldStart", "", 5)
	EndIf

	; a - r - g - b
	; Int iAliciaHairColor = Math.LeftShift(255, 24) + Math.LeftShift(60, 16) + Math.LeftShift(16, 8) + 13
	; Int iAliciaHairColor = Math.LeftShift(60, 16) + Math.LeftShift(16, 8) + 13
	; StorageUtil.SetIntValue(PlayerActor, "_SLH_iHairColor", iAliciaHairColor ) 
	; StorageUtil.SetIntValue(PlayerActor, "_SLH_iHairColorDye", 1 ) 
	; StorageUtil.SetStringValue(PlayerActor, "_SLH_sHairColorName", "Alicia red" ) 
	; PlayerActor.SendModEvent("SLHRefreshColors")

	; PlayerActor.addtofaction(DremoraFaction) 

	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryLevel", 1)
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryExposure", 2)
	SendModEvent("SDSanguineBlessingMod", "", 2)  

	SendModEvent("_SLS_PlayerAlicia")

	Debug.MessageBox("You wake up in a strange place. You knew there was something off about the three stangers and their Honningbrew mead. The last thing you remember are drinks, banter, singing and drunken sex? This is so confusing. Is this a dream? or something else?")

EndEvent

Event OnPCStartSpriggan(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	StorageUtil.SetIntValue(none, "_SLS_iPlayerStartSpriggan", 1)

	; Enable Hormone changes
	StorageUtil.SetIntValue(none, "_SLH_iHormonesSleepInit", 1)

	; PlayerActor.MoveTo(SLS_PlayerSprigganStartMarker)
	PlayerActor.MoveTo(SLS_PlayerSprigganRootStartMarker)

	; PlayerActor.addtofaction(SprigganFaction) 

	; Int iSprigganSkinColor = Math.LeftShift(255, 24) + Math.LeftShift(196, 16) + Math.LeftShift(238, 8) + 218
	; StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", iSprigganSkinColor ) 
	; StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 0.8 ) 
	; StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 20.0 ) 
	; StorageUtil.SetIntValue(PlayerActor, "_SLH_iForcedHairLoss", 1)
	; PlayerActor.SendModEvent("SLHShaveHead")
	; PlayerActor.SendModEvent("SLHRefresh")
	; PlayerActor.SendModEvent("SLHRefreshColors")
	; StorageUtil.SetIntValue(PlayerActor, "_SD_iSprigganEnslavedCount",5)
	; SendModEvent("SDSprigganEnslave")
	PlayerActor.SendModEvent("SLPInfectSprigganRootArms")
	PlayerActor.SendModEvent("SLPInfectSprigganRootBody")
	; PlayerActor.SendModEvent("SLPInfectSprigganRootGag")

	SendModEvent("da_PacifyNearbyEnemies" )

	SendModEvent("_SLS_PlayerSpriggan")

	Debug.MessageBox("You have been blessed by Kyne and must tend to her flock. Her sweet sap pumps through your veins and makes you one with her creation.")

EndEvent

Event OnPCStartKin(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	StorageUtil.SetIntValue(none, "_SLS_iPlayerStartKin", 1)

	; Enable Hormone changes
	StorageUtil.SetIntValue(none, "_SLH_iHormonesSleepInit", 1)

	PlayerActor.MoveTo(SLS_PlayerKinStartMarker)
	PlayerActor.addtofaction(ForswornFaction) 
	PlayerActor.addtofaction(HagravenFaction) 
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryLevel", 2)
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryExposure", 20)

	If (StorageUtil.GetIntValue(none, "_SLS_isBeeingFemaleON")==1) && isFemale(PlayerActor)
	 	PlayerActor.SendModEvent("BeeingFemale", "ChangeState", 6)  ;5, 6, 7 for 2nd, 3rd, labor
		StorageUtil.SetFloatValue(PlayerActor,"FW.UnbornHealth",100.0)
		StorageUtil.UnsetIntValue(PlayerActor,"FW.Abortus")
		StorageUtil.FormListClear(PlayerActor,"FW.ChildFather")
		StorageUtil.SetIntValue(PlayerActor,"FW.NumChilds", 1)
		StorageUtil.FormListAdd(PlayerActor,"FW.ChildFather", none )
	EndIf

	SendModEvent("_SLS_PlayerKin")

	Debug.MessageBox("Times have been tough since Mother passed. Fortunately, Ri'Kin was there to take care of me and my adoptive siblings. As his sister-wives, I have to bear his children and continue the covenant he has made with the Hargavens. Soon, I will give birth and this child will be theirs to take. But no matter, there will be another child soon growing inside me.. another child to replace the void.")

EndEvent

Event OnPCStartDibella(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	StorageUtil.SetIntValue(none, "_SLS_iPlayerStartDibella", 1)

	; Enable Hormone changes
	StorageUtil.SetIntValue(none, "_SLH_iHormonesSleepInit", 1)

	PlayerActor.MoveTo(SLS_PlayerDibellaStartMarker)
 
	Debug.MessageBox("You made it... the Temple of Dibella in Markarth. Your childhood dream of becoming a servant of the Goddess is about to become reality. Talk to the Sister in charge in the Temple and ask her to join the Order.")

EndEvent


Event OnPCStartNordicQueen(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	StorageUtil.SetIntValue(none, "_SLS_iPlayerStartNordicQueen", 1)

	; Enable Hormone changes
	StorageUtil.SetIntValue(none, "_SLH_iHormonesSleepInit", 1)

	PlayerActor.MoveTo(SLS_PlayerNordicQueenStartMarker)
	PlayerActor.addtofaction(DraugrFaction) 
	NordicQueenGauldurQuest.SetStage(10)
	; StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryLevel", 1)
	; StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryExposure", 10)

	; ConsoleUtil.ExecuteCommand("psb")
	; ConsoleUtil.ExecuteCommand("player.setav dragonsouls 1")
	; PlayerActor.DoCombatSpellApply(NordicQueenPolymorph, PlayerActor)  

	SendModEvent("_SLS_PlayerNordQueen")

	Debug.MessageBox("A disturbance in the tomb woke you from your undying slumber. Echoes of an abduction and night after night of rapes and orgies are slowly coming back to you. What happened to Gauldur, your lover and mentor? You remember ... betrayal... so long ago. All gone to dust now. Your lover.. his murderers.. but not his legacy. You must reclaim his amulet and become who you were meant to be .. a true Nordic Queen.")

EndEvent

Event OnPCStartChaurusQueen(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	StorageUtil.SetIntValue(none, "_SLS_iPlayerStartChaurusQueen", 1)

	; Enable Hormone changes
	StorageUtil.SetIntValue(none, "_SLH_iHormonesSleepInit", 1)

	; Not needed - already covered by LAL start from Content Consumer
	; PlayerActor.MoveTo(SLS_PlayerChaurusQueenStartMarker)
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryLevel", 1)
	StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryExposure", 10)

	Int iFalmerSkinColor = Math.LeftShift(255, 24) + Math.LeftShift(100, 16) + Math.LeftShift(200, 8) + 255
	Float breastMod = 1.0
	Float weightMod = 0.0

	StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", iFalmerSkinColor ) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 3.0 ) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 100.0 ) 
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iForcedHairLoss", 1)
	PlayerActor.SendModEvent("SLHShaveHead")
	PlayerActor.SendModEvent("SLHRefresh")
	PlayerActor.SendModEvent("SLHRefreshColors")

	PlayerActor.SendModEvent("SLHModHormone", "Lactation", 50.0 )
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iMilkLevel", 80)

	SendModEvent("_SLP_PlayerChaurusQueen")

	Debug.MessageBox("Repeated exposure to the Falmer's foul touch changed your body. Your growing breasts and pale blue skin make your purpose clear... you are theirs to breed.")
EndEvent

Event OnPCStartBroodMaiden(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
 	Actor PlayerActor= Game.GetPlayer() as Actor

	StorageUtil.SetIntValue(none, "_SLS_iPlayerStartBroodMaiden", 1)

	; Enable Hormone changes
	StorageUtil.SetIntValue(none, "_SLH_iHormonesSleepInit", 1)

	; PlayerActor.MoveTo(SLS_PlayerBroodMaidenStartMarker)
	PlayerActor.addtofaction(ChaurusFaction) 
	; StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryLevel", 1)
	; StorageUtil.SetIntValue(PlayerActor, "_SD_iSlaveryExposure", 10)

	SendModEvent("_SLP_PlayerBroodMaiden")

	Debug.MessageBox("Your childhood friend, Lastelle, has convinced you to follow her in a more simple life, closer to the wildlife she loves so much. Especially the Chaurus for she now calls herself the Brood Maiden. Will you assist her in her new life?")

EndEvent



Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	; daysSinceEnslavement = (Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(akActor, "_SLMC_victimDateEnslaved") ) as Int
	; StorageUtil.SetIntValue(akActor, "_SLMC_victimGameDaysEnslaved", daysSinceEnslavement)

;  http://wiki.tesnexus.com/index.php/Skyrim_bodyparts_number
	; _SLS_NPCSexCount.SetValue(-1)

	; Debug.Notification("[SLS] Rumors global value: " + _SLS_NPCRumorsON.GetValue() as Int)
	; Debug.Notification("[SLS] Rumors storageUtil: " + StorageUtil.GetIntValue(akActor, "_SLS_toggleNPCRumors" ))

	iArousalThrottle = StorageUtil.GetFloatValue(akActor, "_SLS_fetishMod" ) as Int

	if (Utility.RandomInt(0, 100) > iArousalThrottle) ||  (StorageUtil.GetIntValue(akActor, "_SLS_toggleFetish" ) == 0)
		Return
	Endif
	
	If (_SLS_FetishID.GetValue() > 0)

		_refreshGameStats()

		If (_SLS_FetishID.GetValue() == 9 ) && (StorageUtil.GetIntValue(akActor, "_SLS_statPeopleKillDiff" )>0)
			slaUtil.UpdateActorExposure(akRef = akActor, val = StorageUtil.GetIntValue(akActor, "_SLS_statPeopleKillDiff" ), debugMsg = "killing people.")
		EndIf

		If (_SLS_FetishID.GetValue() == 8 ) && (StorageUtil.GetIntValue(akActor, "_SLS_statAnimalKillDiff" )>0)
			slaUtil.UpdateActorExposure(akRef = akActor, val = StorageUtil.GetIntValue(akActor, "_SLS_statAnimalKillDiff" ), debugMsg = "killing animals.")
		EndIf

		If (_SLS_FetishID.GetValue() == 2 ) && (StorageUtil.GetIntValue(akActor, "_SLS_statCreatureKillDiff" )>0)
			slaUtil.UpdateActorExposure(akRef = akActor, val = StorageUtil.GetIntValue(akActor, "_SLS_statCreatureKillDiff" ), debugMsg = "killing creatures.")
		EndIf

		If (_SLS_FetishID.GetValue() == 6 ) && (StorageUtil.GetIntValue(akActor, "_SLS_statMagicDiff" )>0)
			slaUtil.UpdateActorExposure(akRef = akActor, val = StorageUtil.GetIntValue(akActor, "_SLS_statMagicDiff" ), debugMsg = "using magic.")
		EndIf

		If (_SLS_FetishID.GetValue() == 1 ) && (StorageUtil.GetIntValue(akActor, "_SLS_statCraftDiff" )>0)
			slaUtil.UpdateActorExposure(akRef = akActor, val = StorageUtil.GetIntValue(akActor, "_SLS_statCraftDiff" ), debugMsg = "crafting items.")
		EndIf

		If (_SLS_FetishID.GetValue() == 11 ) && (StorageUtil.GetIntValue(akActor, "_SLS_statCrimeDiff" )>0)
			slaUtil.UpdateActorExposure(akRef = akActor, val = StorageUtil.GetIntValue(akActor, "_SLS_statCrimeDiff" ), debugMsg = "stealing and commiting crime.")
		EndIf

		If (_SLS_FetishID.GetValue() == 5 ) && !slaUtil.IsActorExhibitionist(akActor)
			slaUtil.SetActorExhibitionist(akActor, True)
		EndIf

		If (_SLS_FetishID.GetValue() == 9 ) && ((akActor.GetLightLevel()<50) || (akActor.IsSneaking() ))
			slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "being in darkness.")
		EndIf

		If (_SLS_FetishID.GetValue() == 10 ) && akActor.IsOnMount()
			slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "riding a horse.")
		EndIf

		Actor randomActor = Game.FindRandomActorFromRef(akActor, 10.0)
		If (randomActor != None)
			If (_SLS_FetishID.GetValue() == 7 ) && ( (akActor.HasFamilyRelationship(randomActor)) || (randomActor.IsPlayerTeammate()))
				slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "being close to a loved one.")
			ElseIf (_SLS_FetishID.GetValue() == 7 ) && ( (akActor.HasAssociation(SpouseType, randomActor)))
				slaUtil.UpdateActorExposure(akRef = akActor, val = 5, debugMsg = "being close to a spouse.")
			EndIf
		EndIf

		Bool bArmorOn = akActor.WornHasKeyword(ArmorOn)
		Bool bClothingOn = akActor.WornHasKeyword(ClothingOn)

		Int[] uiSlotMask = New Int[4]
		uiSlotMask[0]  = 0x00000004 ;32   - body (full)
		uiSlotMask[1]  = 0x00000020 ;35   - amulet
		uiSlotMask[2]  = 0x00000040 ;36   - ring
		uiSlotMask[3]  = 0x00001000 ;42   - circlet

		Int iFormIndex = uiSlotMask.Length
		While ( iFormIndex > 0 )
			iFormIndex -= 1
			Form kForm = akActor.GetWornForm( uiSlotMask[iFormIndex] ) 

			If ((_SLS_FetishID.GetValue() == 4 ) || (_SLS_FetishID.GetValue() == 5 ) || (_SLS_FetishID.GetValue() == 10 ) || (_SLS_FetishID.GetValue() == 11 ) || (_SLS_FetishID.GetValue() == 3 ))&& (iFormIndex==0)
				Armor kArmor = kForm as Armor
				If ( kArmor ) && (_SLS_FetishID.GetValue() == 4 )
					slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "wearing an armor.")
				ElseIf  ( kArmor ) && (_SLS_FetishID.GetValue() == 3 ) && (kForm.GetGoldValue() > 500) && (bClothingOn)
					slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "wearing expensive clothing.")
				ElseIf ( !kForm ) && ( (_SLS_FetishID.GetValue() == 5 ) || (_SLS_FetishID.GetValue() == 10 ) || (_SLS_FetishID.GetValue() == 11 ) || (_SLS_FetishID.GetValue() == 3 ) )
					slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "not wearing cloth or armor.")
				EndIf
			ElseIf (_SLS_FetishID.GetValue() == 3 ) && (iFormIndex!=0)	
				If (kForm)
					slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "wearing jewelry.")
				EndIf
			EndIf
		EndWhile	

		; See - http://www.creationkit.com/GetEquippedItemType_-_Actor - For specialization ideas

		Weapon krHand = akActor.GetEquippedWeapon()
		Weapon klHand = akActor.GetEquippedWeapon( True )
		If ( krHand ) && (_SLS_FetishID.GetValue() == 13 )
			slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "holding a weapon.")
		EndIf
		If ( klHand ) && (_SLS_FetishID.GetValue() == 13 )
			slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "holding a weapon.")
		EndIf
	EndIf
endEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	if (Utility.RandomInt(0, 100) > iArousalThrottle)
		Return
	Endif

	If (akTarget != None)

	    if (aeCombatState == 0)
	      	; Debug.Trace("We have left combat with the player!")

		  	If (_SLS_FetishID.GetValue() == 12 ) || (_SLS_FetishID.GetValue() == 8 )  || (_SLS_FetishID.GetValue() == 13 )  
				;  Debug.Trace("We were hit by " + akAggressor)

				slaUtil.UpdateActorExposure(akRef = akActor, val = 1, debugMsg = "leaving combat.")
			EndIf    	

	    elseif (aeCombatState == 1)
	      	; Debug.Trace("We have entered combat with the player!")

		  	If (_SLS_FetishID.GetValue() == 12 ) 

				slaUtil.UpdateActorExposure(akRef = akActor, val = 1, debugMsg = "starting combat.")
		  	ElseIf (_SLS_FetishID.GetValue() == 13 )

				slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "starting combat.")
			EndIf 

	    elseif (aeCombatState == 2)
	      	; Debug.Trace("We are searching for the player...")

		  	If (_SLS_FetishID.GetValue() == 8 ) 

				slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "going on a hunt.")
			EndIf 
	    endIf
	EndIf
EndEvent

; Too costly using OnHit events - Replace by alternate method of combat detection
; Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
; 	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
; 	Actor akActor= Game.GetPlayer()

; 	if (Utility.RandomInt(0, 100) > iArousalThrottle)
; 		Return
; 	Endif

; 	If (akAggressor != None) && (_SLS_FetishID.GetValue() == 12) 
		;  Debug.Trace("We were hit by " + akAggressor)

; 		slaUtil.UpdateActorExposure(akRef = akActor, val = 1, debugMsg = "being hit.")
; 	EndIf
; EndEvent



Event OnEnterBleedout()
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	if (Utility.RandomInt(0, 100) > iArousalThrottle)
		Return
	Endif
	
	If (_SLS_FetishID.GetValue() == 12)

		slaUtil.UpdateActorExposure(akRef = akActor, val = 5, debugMsg = "being knocked down.")
	EndIf
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()
	bool playerOwnsItem = False

	if (Utility.RandomInt(0, 100) > iArousalThrottle)
		Return
	Endif
	
	if (akItemReference) && (_SLS_FetishID.GetValue() == 11)
        playerOwnsItem = (akItemReference.GetActorOwner() == Game.GetPlayer().GetActorBase()) || (akItemReference.GetActorOwner() == None)
        
        If !playerOwnsItem
            slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "stealing.")

        EndIf
	EndIf

	Int iuType = akBaseItem.GetType()

	If (_SLS_FetishID.GetValue() == 3) && (akBaseItem.GetGoldValue() > 200)
		slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "getting jewelry or expensive item.")

	ElseIf (_SLS_FetishID.GetValue() == 13) && ( iuType == 41 )
		slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "getting a weapon.")

	ElseIf (_SLS_FetishID.GetValue() == 4) && ( iuType == 26 )
		slaUtil.UpdateActorExposure(akRef = akActor, val = 2, debugMsg = "getting an armor.")

	EndIf
EndEvent


Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 

	if !Self || !SexLab 
		Debug.Trace("SexLab Stories: Critical error on SexLab Start")
		Return
	EndIf
	
	; Debug.Notification("SexLab Hormones: Sex start")

	Actor[] actors = SexLab.HookActors(_args)
	Actor   victim = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim
	
	; Debug.Notification("Has player: " + _hasPlayer(actors))
	; Debug.Notification("Arousal trigger: " + (slaUtil.GetActorExposure(akRef = PlayerActor) / 3))

	; If (_hasPlayer(actors))

	; EndIf

	; Debug.Notification("SexLab Hormones: Forced refresh flag: " + StorageUtil.GetIntValue(none, "_SLH_iForcedRefresh"))
	
	If victim	;none consensual
		;

	Else        ;consensual
		;
		
	EndIf


EndEvent

Event OnSexLabEnd(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	ActorBase pActorBase = PlayerActor.GetActorBase()
    sslBaseAnimation animation = SexLab.HookAnimation(_args)
    Float fBreastScale 

	if !Self || !SexLab 
	;	Debug.Trace("SexLab Stories: Critical error on SexLab End")
		Return
	EndIf


	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim
	
	; if config.bDebugMsg
	; 	_listActors("End: ", actors)
	; EndIf

	; If (_hasPlayer(actors))
		;
	; EndIf

EndEvent 

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	ObjectReference PlayerREF= PlayerAlias.GetReference()
	Actor PlayerActor= PlayerAlias.GetReference() as Actor
	Float fBreastScale 

	if !Self || !SexLab 
	;	Debug.Trace("SexLab Stories: Critical error on SexLab Orgasm")
		Return
	EndIf

	Actor[] actors  = SexLab.HookActors(_args)
	Actor   victim  = SexLab.HookVictim(_args)
	Actor[] victims = new Actor[1]
	victims[0] = victim

	; If (_hasPlayer(actors))
	;	Debug.Trace("SexLab Stories: Orgasm!")

	; EndIf
	
EndEvent


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

Bool Function _hasPlayer(Actor[] _actors)
	ObjectReference PlayerREF= PlayerAlias.GetReference()

	int idx = 0
	while idx < _actors.Length
		if _actors[idx] == PlayerRef
			return True
		endif
		idx += 1
	endwhile
	Return False
EndFunction

Bool Function _hasActor(Actor[] _actors, Actor thisActor)

	int idx = 0
	while idx < _actors.Length
		if _actors[idx] == thisActor as ObjectReference
			return True
		endif
		idx += 1
	endwhile
	Return False
EndFunction

Bool Function _hasRace(Actor[] _actors, Race thisRace)
	ActorBase aBase 
	Race aRace 

	int idx = 0
	while idx < _actors.Length
		if (_actors[idx])
			; aBase = _actors[idx].GetBaseObject() as ActorBase
			aRace = _actors[idx].GetLeveledActorBase().GetRace()
			if aRace == thisRace
				return True
			endif
		EndIf
		idx += 1
	endwhile
	Return False
EndFunction

function _getGameStats()
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	; People Killed - Assaults - Murders  - Sneak Attacks - Backstabs
	int statPeopleKill = Game.QueryStat("People Killed") + Game.QueryStat("Assaults") + Game.QueryStat("Murders") + Game.QueryStat("Sneak Attacks") + Game.QueryStat("Backstabs") 

	; Animals Killed - Bunnies Slaughtered - Wings Plucked
	int statAnimalKill = Game.QueryStat("Animals Killed") + Game.QueryStat("Bunnies Slaughtered") + Game.QueryStat("Wings Plucked") 

	; Creatures Killed - Undead Killed - Daedra Killed - Automatons Killed
	int statCreatureKill = Game.QueryStat("Creatures Killed") + Game.QueryStat("Undead Killed") + Game.QueryStat("Daedra Killed") + Game.QueryStat("Automatons Killed") 

	; Spells Learned - Dragon Souls Collected - Words Of Power Learned - Words Of Power Unlocked - Shouts Learned - Shouts Unlocked - Shouts Mastered - Times Shouted - Soul Gems Used - Souls Trapped - Magic Items Made
	int statMagic = Game.QueryStat("Spells Learned") + Game.QueryStat("Dragon Souls Collected") +  Game.QueryStat("Words Of Power Learned") + Game.QueryStat("Words Of Power Unlocked") + Game.QueryStat("Shouts Learned") + Game.QueryStat("Shouts Unlocked") + Game.QueryStat("Shouts Mastered") + Game.QueryStat("Times Shouted") + Game.QueryStat("Soul Gems Used") + Game.QueryStat("Souls Trapped") + Game.QueryStat("Magic Items Made")

	; Weapons Improved - Weapons Made - Armor Improved - Armor Made - Potions Mixed - Poisons Mixed - Brawls Won - Critical Strikes
	int statCraft = Game.QueryStat("Weapons Improved") + Game.QueryStat("Weapons Made") + Game.QueryStat("Armor Improved") + Game.QueryStat("Armor Made") + Game.QueryStat("Potions Mixed") + Game.QueryStat("Poisons Mixed") + Game.QueryStat("Brawls Won") + Game.QueryStat("Critical Strikes")

	; Locks Picked - Pockets Picked - Items Pickpocketed - Times Jailed - Items Stolen - Trespasses
	int statCrime = Game.QueryStat("Locks Picked") + Game.QueryStat("Pockets Picked") + Game.QueryStat("Items Pickpocketed") + Game.QueryStat("Times Jailed") + Game.QueryStat("Items Stolen") + Game.QueryStat("Trespasses")

	StorageUtil.SetIntValue(akActor, "_SLS_statPeopleKillDiff", 0 )
	StorageUtil.SetIntValue(akActor, "_SLS_statAnimalKillDiff", 0 )
	StorageUtil.SetIntValue(akActor, "_SLS_statCreatureKillDiff", 0 )
	StorageUtil.SetIntValue(akActor, "_SLS_statMagicDiff", 0 )
	StorageUtil.SetIntValue(akActor, "_SLS_statCraftDiff", 0 )
	StorageUtil.SetIntValue(akActor, "_SLS_statCrimeDiff", 0 )

	StorageUtil.SetIntValue(akActor, "_SLS_statPeopleKill", statPeopleKill )
	StorageUtil.SetIntValue(akActor, "_SLS_statAnimalKill", statAnimalKill )
	StorageUtil.SetIntValue(akActor, "_SLS_statCreatureKill", statCreatureKill )
	StorageUtil.SetIntValue(akActor, "_SLS_statMagic", statMagic )
	StorageUtil.SetIntValue(akActor, "_SLS_statCraft", statCraft )
	StorageUtil.SetIntValue(akActor, "_SLS_statCrime", statCrime )

EndFunction

function _refreshGameStats()
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	; People Killed - Assaults - Murders  - Sneak Attacks - Backstabs
	int statPeopleKill = Game.QueryStat("People Killed") + Game.QueryStat("Assaults") + Game.QueryStat("Murders") + Game.QueryStat("Sneak Attacks") + Game.QueryStat("Backstabs") 

	; Animals Killed - Bunnies Slaughtered - Wings Plucked
	int statAnimalKill = Game.QueryStat("Animals Killed") + Game.QueryStat("Bunnies Slaughtered") + Game.QueryStat("Wings Plucked") 

	; Creatures Killed - Undead Killed - Daedra Killed - Automatons Killed
	int statCreatureKill = Game.QueryStat("Creatures Killed") + Game.QueryStat("Undead Killed") + Game.QueryStat("Daedra Killed") + Game.QueryStat("Automatons Killed") 

	; Spells Learned - Dragon Souls Collected - Words Of Power Learned - Words Of Power Unlocked - Shouts Learned - Shouts Unlocked - Shouts Mastered - Times Shouted - Soul Gems Used - Souls Trapped - Magic Items Made
	int statMagic = Game.QueryStat("Spells Learned") + Game.QueryStat("Dragon Souls Collected") +  Game.QueryStat("Words Of Power Learned") + Game.QueryStat("Words Of Power Unlocked") + Game.QueryStat("Shouts Learned") + Game.QueryStat("Shouts Unlocked") + Game.QueryStat("Shouts Mastered") + Game.QueryStat("Times Shouted") + Game.QueryStat("Soul Gems Used") + Game.QueryStat("Souls Trapped") + Game.QueryStat("Magic Items Made")

	; Weapons Improved - Weapons Made - Armor Improved - Armor Made - Potions Mixed - Poisons Mixed - Brawls Won - Critical Strikes
	int statCraft = Game.QueryStat("Weapons Improved") + Game.QueryStat("Weapons Made") + Game.QueryStat("Armor Improved") + Game.QueryStat("Armor Made") + Game.QueryStat("Potions Mixed") + Game.QueryStat("Poisons Mixed") + Game.QueryStat("Brawls Won") + Game.QueryStat("Critical Strikes")

	; Locks Picked - Pockets Picked - Items Pickpocketed - Times Jailed - Items Stolen - Trespasses
	int statCrime = Game.QueryStat("Locks Picked") + Game.QueryStat("Pockets Picked") + Game.QueryStat("Items Pickpocketed") + Game.QueryStat("Times Jailed") + Game.QueryStat("Items Stolen") + Game.QueryStat("Trespasses")

	StorageUtil.SetIntValue(akActor, "_SLS_statPeopleKillDiff", iMin(iMax(statPeopleKill - StorageUtil.GetIntValue(akActor, "_SLS_statPeopleKill"), 0), 5) )
	StorageUtil.SetIntValue(akActor, "_SLS_statAnimalKillDiff", iMin(iMax(statAnimalKill - StorageUtil.GetIntValue(akActor, "_SLS_statAnimalKill"), 0), 5) )
	StorageUtil.SetIntValue(akActor, "_SLS_statCreatureKillDiff", iMin(iMax(statCreatureKill - StorageUtil.GetIntValue(akActor, "_SLS_statCreatureKill"), 0), 5) )
	StorageUtil.SetIntValue(akActor, "_SLS_statMagicDiff", iMin(iMax(statMagic - StorageUtil.GetIntValue(akActor, "_SLS_statMagic"), 0), 5) )
	StorageUtil.SetIntValue(akActor, "_SLS_statCraftDiff", iMin(iMax(statCraft - StorageUtil.GetIntValue(akActor, "_SLS_statCraft"), 0), 5) )
	StorageUtil.SetIntValue(akActor, "_SLS_statCrimeDiff", iMin(iMax(statCrime - StorageUtil.GetIntValue(akActor, "_SLS_statCrime"), 0), 5) )

	StorageUtil.SetIntValue(akActor, "_SLS_statPeopleKill", statPeopleKill )
	StorageUtil.SetIntValue(akActor, "_SLS_statAnimalKill", statAnimalKill )
	StorageUtil.SetIntValue(akActor, "_SLS_statCreatureKill", statCreatureKill )
	StorageUtil.SetIntValue(akActor, "_SLS_statMagic", statMagic )
	StorageUtil.SetIntValue(akActor, "_SLS_statCraft", statCraft )
	StorageUtil.SetIntValue(akActor, "_SLS_statCrime", statCrime )

EndFunction


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
  if (StorageUtil.GetIntValue(none, "_SLS_isCagedFollowerON") ==  1) 
  	ChaurusBreeder = StorageUtil.GetFormValue(none, "_SLS_getCagedFollowerQuestKeyword") as Spell
  	if (ChaurusBreeder != none)
    	return kActor.HasSpell(ChaurusBreeder)
    endif
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


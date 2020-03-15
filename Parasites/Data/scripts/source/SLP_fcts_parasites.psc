Scriptname SLP_fcts_parasites extends Quest  
{ USED }
Import Utility
Import SKSE
zadLibs Property libs Auto
SexLabFrameWork Property SexLab Auto

ReferenceAlias Property PlayerAlias  Auto  
ReferenceAlias Property SpiderEggInfectedAlias  Auto  
ReferenceAlias Property ChaurusWormInfectedAlias  Auto  
ReferenceAlias Property BarnaclesInfectedAlias  Auto  
ReferenceAlias Property TentacleMonsterInfectedAlias  Auto  
ReferenceAlias Property LivingArmorInfectedAlias  Auto  
ReferenceAlias Property FaceHuggerInfectedAlias  Auto  
ReferenceAlias Property SpiderFollowerAlias  Auto  

Quest Property KynesBlessingQuest  Auto 

ObjectReference Property DummyAlias  Auto  
 
GlobalVariable Property _SLP_GV_numInfections  Auto 
GlobalVariable Property _SLP_GV_numSpiderEggInfections  Auto 
GlobalVariable Property _SLP_GV_numChaurusWormInfections  Auto 
GlobalVariable Property _SLP_GV_numChaurusWormVagInfections  Auto 
GlobalVariable Property _SLP_GV_numEstrusTentaclesInfections  Auto 
GlobalVariable Property _SLP_GV_numTentacleMonsterInfections  Auto 
GlobalVariable Property _SLP_GV_numEstrusSlimeInfections  Auto 
GlobalVariable Property _SLP_GV_numLivingArmorInfections  Auto 
GlobalVariable Property _SLP_GV_numFaceHuggerInfections  Auto 
GlobalVariable Property _SLP_GV_numBarnaclesInfections  Auto 

Faction Property PlayerFollowerFaction Auto

SPELL Property StomachRot Auto

Container Property EggSac  Auto  
Ingredient  Property TrollFat Auto
Ingredient  Property IngredientChaurusWorm Auto

Ingredient  Property SmallSpiderEgg Auto
Ingredient  Property BarnaclesCluster Auto

Keyword Property ArmorCuirass  Auto  
Keyword Property ClothingBody  Auto  

Keyword Property _SLP_ParasiteSpiderEgg  Auto  
Keyword Property _SLP_ParasiteSpiderPenis  Auto  
Keyword Property _SLP_ParasiteChaurusWorm  Auto  
Keyword Property _SLP_ParasiteChaurusWormVag Auto  
Keyword Property _SLP_ParasiteTentacleMonster  Auto  
Keyword Property _SLP_ParasiteLivingArmor  Auto  
Keyword Property _SLP_ParasiteFaceHugger  Auto  
Keyword Property _SLP_ParasiteFaceHuggerGag  Auto  
Keyword Property _SLP_ParasiteBarnacles  Auto  

Armor Property SLP_plugSpiderEggRendered Auto         ; Internal Device
Armor Property SLP_plugSpiderEggInventory Auto        	       ; Inventory Device
Armor Property SLP_plugSpiderPenisRendered Auto         ; Internal Device
Armor Property SLP_plugSpiderPenisInventory Auto        	       ; Inventory Device
Armor Property SLP_plugChaurusWormRendered Auto         ; Internal Device
Armor Property SLP_plugChaurusWormInventory Auto        	       ; Inventory Device
Armor Property SLP_plugChaurusWormVagRendered Auto         ; Internal Device
Armor Property SLP_plugChaurusWormVagInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessTentacleMonsterRendered Auto         ; Internal Device
Armor Property SLP_harnessTentacleMonsterInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessLivingArmorRendered Auto         ; Internal Device
Armor Property SLP_harnessLivingArmorInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessFaceHuggerRendered Auto         ; Internal Device
Armor Property SLP_harnessFaceHuggerInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessFaceHuggerGagRendered Auto         ; Internal Device
Armor Property SLP_harnessFaceHuggerGagInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessBarnaclesRendered Auto         ; Internal Device
Armor Property SLP_harnessBarnaclesInventory Auto        	       ; Inventory Device

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

Bool Property isNiOInstalled Auto
Bool Property isSlifInstalled Auto


;  http://wiki.tesnexus.com/index.php/Skyrim_bodyparts_number
;
;  This is the list of the body parts used by Bethesda and named in the Creation Kit:
;    30   - head
;    31     - hair
;    32   - body (full)
;    33   - hands
;    34   - forearms
;    35   - amulet
;    36   - ring
;    37   - feet
;    38   - calves
;    39   - shield
;    40   - tail
;    41   - long hair
;    42   - circlet
;    43   - ears
;    50   - decapitated head
;    51   - decapitate
;    61   - FX01
;  
;  Other body parts that exist in vanilla nif models
;    44   - Used in bloodied dragon heads, so it is free for NPCs
;    45   - Used in bloodied dragon wings, so it is free for NPCs
;    47   - Used in bloodied dragon tails, so it is free for NPCs
;    130   - Used in helmetts that conceal the whole head and neck inside
;    131   - Used in open faced helmets\hoods (Also the nightingale hood)
;    141   - Disables Hair Geometry like 131 and 31
;    142   - Used in circlets
;    143   - Disabled Ear geometry to prevent clipping issues?
;    150   - The gore that covers a decapitated head neck
;    230   - Neck, where 130 and this meets is the decapitation point of the neck
;  
;  Free body slots and reference usage
;    44   - face/mouth
;    45   - neck (like a cape, scarf, or shawl, neck-tie etc)
;    46   - chest primary or outergarment
;    47   - back (like a backpack/wings etc)
;    48   - misc/FX (use for anything that doesnt fit in the list)
;    49   - pelvis primary or outergarment
;    52   - pelvis secondary or undergarment
;    53   - leg primary or outergarment or right leg
;    54   - leg secondary or undergarment or leftt leg
;    55   - face alternate or jewelry
;    56   - chest secondary or undergarment
;    57   - shoulder
;    58   - arm secondary or undergarment or left arm
;    59   - arm primary or outergarment or right arm
;    60   - misc/FX (use for anything that doesnt fit in the list)



; Devious Devices 2.9
; Gags: 44
; Collars: 45
; Armbinder: 46
; Plugs (Anal): 48
; Chastity Belts: 49
; Vaginal Piercings: 50
; Nipple Piercings: 51
; Cuffs (Legs): 53
; Blindfold: 55
; Chastity Bra: 56
; Plugs (Vaginal): 57
; Body Harness: 58
; Cuffs (Arms): 59


;---------------------------------------------------
Function lockParasiteByString(Actor akActor, String sParasiteString = "")
	Keyword kwDeviceKeyword = 	getDeviousKeywordByString(sParasiteString)

	if (kwDeviceKeyword != none)
		libs.JamLock(akActor, kwDeviceKeyword)
	endIf
EndFunction

Function unLockParasiteByString(Actor akActor, String sParasiteString = "")
	Keyword kwDeviceKeyword = 	getDeviousKeywordByString(sParasiteString)

	if (kwDeviceKeyword != none)
		libs.UnJamLock(akActor, kwDeviceKeyword)
	endIf
EndFunction


Function equipParasiteByString ( String sParasiteString = "", bool skipEvents = false, bool skipMutex = false)

	equipParasiteNPCByString ( Game.GetPlayer(),  sParasiteString, skipEvents, skipMutex)
EndFunction

Function equipParasiteNPCByString ( Actor akActor, String sParasiteString = "", String sOutfitString = "", bool skipEvents = false, bool skipMutex = false)
	Keyword kwDeviceKeyword = none
	Armor aWornDevice = none
	Armor aRenderedDevice = none
	String sGenericDeviceTags = ""
	Form kForm	
	Bool bDeviceEquipSuccess = False

 	if (akActor == none)
 		Return
 	endif

	kwDeviceKeyword = 	getDeviousKeywordByString(sParasiteString)
	aWornDevice = none
	aRenderedDevice = none 

	If (kwDeviceKeyword != None)

		if !akActor.WornHasKeyword(kwDeviceKeyword)
			Debug.Trace("[SLP] equipParasiteByString: " + sParasiteString)  
			Debug.Trace("[SLP] 		keyword: " + kwDeviceKeyword)  

			aWornDevice = getParasiteByKeyword(kwDeviceKeyword) ; libs.GetWornDevice(akActor, kwDeviceKeyword) as Armor
			aRenderedDevice = getParasiteRenderedByKeyword(kwDeviceKeyword) ; libs.GetRenderedDevice(aWornDevice) as Armor

			If (aRenderedDevice!=None)
				equipParasiteNPC ( akActor, aWornDevice,  aRenderedDevice,  kwDeviceKeyword)
			Else
				Debug.Trace("[SLP]    Can't get worn device")
			endif

 
		else
			Debug.Trace("[SLP] player is already wearing: " + sParasiteString)  
		endIf

	else
		Debug.Trace("[SLP] unknown device to equip " )  

	endif
EndFunction



Function clearParasiteByString ( String sParasiteString = "", bool skipEvents = false, bool skipMutex = false )
 	clearParasiteNPCByString ( Game.GetPlayer(), sParasiteString, skipEvents, skipMutex )
EndFunction

Function clearParasiteNPCByString ( Actor akActor, String sParasiteString = "", bool skipEvents = false, bool skipMutex = false )
	Keyword kwDeviceKeyword = none 
	Armor aWornDevice = none
	Armor aRenderedDevice = none 
	Form kForm

	Debug.Trace("[SLP] clearParasiteByString - NO override detected")  
	kwDeviceKeyword = 	getDeviousKeywordByString(sParasiteString)
	aWornDevice = none
	aRenderedDevice = none 
 
	If (kwDeviceKeyword != None)

		if akActor.WornHasKeyword(kwDeviceKeyword)
			; RemoveDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool destroyDevice=false, bool skipEvents=false, bool skipMutex=false)

			Debug.Trace("[SLP] clearing device string: " + sParasiteString)  
			Debug.Trace("[SLP] clearing device keyword: " + kwDeviceKeyword)  
  
			aWornDevice = getParasiteByKeyword(kwDeviceKeyword) ; libs.GetWornDevice(akActor, kwDeviceKeyword) as Armor
			aRenderedDevice = libs.GetRenderedDevice(aWornDevice) as Armor ; getParasiteRenderedByKeyword(kwDeviceKeyword) 

			If (aRenderedDevice!=None)
				clearParasiteNPC ( akActor, aWornDevice,  aRenderedDevice,  kwDeviceKeyword)
			Else
				Debug.Trace("[SLP]    Can't get worn device")
			endif
			
			; libs.ManipulateGenericDeviceByKeyword(PlayerActor, kwDeviceKeyword, False, skipEvents,  skipMutex)
  

		else
			Debug.Trace("[SLP] player is not wearing: " + sParasiteString)  
		endIf

	else
		Debug.Trace("[SLP] unknown device to clear " )  

	endif
EndFunction

Bool Function equipParasite ( Armor ddArmorInventory, Armor ddArmorRendered, Keyword ddArmorKeyword)
	Actor kPlayer = Game.GetPlayer() as Actor
	Keyword kwWornKeyword
	Bool bDeviceEquipSuccess = False

	bDeviceEquipSuccess = equipParasiteNPC ( kPlayer, ddArmorInventory, ddArmorRendered, ddArmorKeyword)

	return bDeviceEquipSuccess
EndFunction

Bool Function equipParasiteNPC ( Actor akActor, Armor ddArmorInventory, Armor ddArmorRendered, Keyword ddArmorKeyword)
	Keyword kwWornKeyword
	Bool bDeviceEquipSuccess = False

	libs.Log("[SLP] equipParasite " )

	if (ddArmorKeyword != None)
		if (!akActor.WornHasKeyword(ddArmorKeyword))

			bDeviceEquipSuccess = libs.equipDevice(akActor, ddArmorInventory , ddArmorRendered , ddArmorKeyword)
			bDeviceEquipSuccess = True
		Else
			libs.Log("[SLP]   	skipped - device already equipped " )
		EndIf
	Else
		Debug.Notification("[SLP] equipParasite - bad keyword " )
	endIf

	return bDeviceEquipSuccess
EndFunction

Bool Function clearParasite ( Armor ddArmorInventory, Armor ddArmorRendered, Keyword ddArmorKeyword, Bool bDestroy = False)
	Actor kPlayer = Game.GetPlayer() as Actor
	Keyword kwWornKeyword
	Bool bDeviceRemoveSuccess = False
 
	bDeviceRemoveSuccess = clearParasiteNPC ( kPlayer, ddArmorInventory, ddArmorRendered, ddArmorKeyword,  bDestroy)
 
	return bDeviceRemoveSuccess
EndFunction

Bool Function clearParasiteNPC ( Actor akActor, Armor ddArmorInventory, Armor ddArmorRendered, Keyword ddArmorKeyword, Bool bDestroy = False) 
	Keyword kwWornKeyword
	Bool bDeviceRemoveSuccess = False

	If (bDestroy)
		libs.Log("[SLP] clearParasite - destroy: " + ddArmorKeyword )
	Else
		libs.Log("[SLP] clearParasite - remove: " + ddArmorKeyword  )
	endIf

	; RemoveDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool destroyDevice=false, bool skipEvents=false, bool skipMutex=false)
	libs.RemoveDevice(akActor, ddArmorInventory , ddArmorRendered , ddArmorKeyword, bDestroy, False, True)
 
	bDeviceRemoveSuccess = True
 
	return bDeviceRemoveSuccess
EndFunction

Armor Function getParasiteByKeyword(Keyword thisKeyword  )
	Armor thisArmor = None

	if (thisKeyword == _SLP_ParasiteSpiderEgg)
		thisArmor = SLP_plugSpiderEggInventory

	Elseif (thisKeyword == _SLP_ParasiteSpiderPenis)
		thisArmor = SLP_plugSpiderPenisInventory

	Elseif (thisKeyword == _SLP_ParasiteChaurusWorm)
		thisArmor = SLP_plugChaurusWormInventory

	Elseif (thisKeyword == _SLP_ParasiteChaurusWormVag)
		thisArmor = SLP_plugChaurusWormVagInventory

	Elseif (thisKeyword == _SLP_ParasiteTentacleMonster)
		thisArmor = SLP_harnessTentacleMonsterInventory

	Elseif (thisKeyword == _SLP_ParasiteLivingArmor)
		thisArmor = SLP_harnessLivingArmorInventory

	Elseif (thisKeyword == _SLP_ParasiteFaceHugger)
		thisArmor = SLP_harnessFaceHuggerInventory

	Elseif (thisKeyword == _SLP_ParasiteFaceHuggerGag)
		thisArmor = SLP_harnessFaceHuggerGagInventory

	Elseif (thisKeyword == _SLP_ParasiteBarnacles)
		thisArmor = SLP_harnessBarnaclesInventory
	EndIf

	return thisArmor
EndFunction

Armor Function getParasiteRenderedByKeyword(Keyword thisKeyword  )
	Armor thisArmor = None

	if (thisKeyword == _SLP_ParasiteSpiderEgg)
		thisArmor = SLP_plugSpiderEggRendered

	Elseif (thisKeyword == _SLP_ParasiteSpiderPenis)
		thisArmor = SLP_plugSpiderPenisRendered

	Elseif (thisKeyword == _SLP_ParasiteChaurusWorm)
		thisArmor = SLP_plugChaurusWormRendered

	Elseif (thisKeyword == _SLP_ParasiteChaurusWormVag)
		thisArmor = SLP_plugChaurusWormVagRendered

	Elseif (thisKeyword == _SLP_ParasiteTentacleMonster)
		thisArmor = SLP_harnessTentacleMonsterRendered

	Elseif (thisKeyword == _SLP_ParasiteLivingArmor)
		thisArmor = SLP_harnessLivingArmorRendered

	Elseif (thisKeyword == _SLP_ParasiteFaceHugger)
		thisArmor = SLP_harnessFaceHuggerRendered

	Elseif (thisKeyword == _SLP_ParasiteFaceHuggerGag)
		thisArmor = SLP_harnessFaceHuggerGagRendered

	Elseif (thisKeyword == _SLP_ParasiteBarnacles)
		thisArmor = SLP_harnessBarnaclesRendered
	EndIf

	return thisArmor
EndFunction


Keyword Function getDeviousKeywordByString(String deviousKeyword = ""  )
	Keyword thisKeyword = None
 
	if (deviousKeyword == "SpiderEgg" )  
		thisKeyword = _SLP_ParasiteSpiderEgg

	elseif (deviousKeyword == "SpiderPenis" )  
		thisKeyword = _SLP_ParasiteSpiderPenis

	elseif (deviousKeyword == "ChaurusWorm" )  
		thisKeyword = _SLP_ParasiteChaurusWorm
		
	elseif (deviousKeyword == "ChaurusWormVag" )  
		thisKeyword = _SLP_ParasiteChaurusWormVag
		
	elseif (deviousKeyword == "TentacleMonster" )  
		thisKeyword = _SLP_ParasiteTentacleMonster
		
	elseif (deviousKeyword == "LivingArmor" )  
		thisKeyword = _SLP_ParasiteLivingArmor
		
	elseif (deviousKeyword == "FaceHugger" )  
		thisKeyword = _SLP_ParasiteFaceHugger
		
	elseif (deviousKeyword == "FaceHuggerGag" )  
		thisKeyword = _SLP_ParasiteFaceHuggerGag
		
	elseif (deviousKeyword == "Barnacles" )  
		thisKeyword = _SLP_ParasiteBarnacles
		
	elseif (deviousKeyword == "zad_BlockGeneric")
		thisKeyword = libs.zad_BlockGeneric
		
	elseif (deviousKeyword == "zad_Lockable")
		thisKeyword = libs.zad_Lockable

	elseif (deviousKeyword == "zad_DeviousCollar") || (deviousKeyword == "Collar") 
		thisKeyword = libs.zad_DeviousCollar

	elseif (deviousKeyword == "zad_DeviousArmbinder") || (deviousKeyword == "Armbinder")  || (deviousKeyword == "Armbinders") 
		thisKeyword = libs.zad_DeviousArmbinder

	elseif (deviousKeyword == "zad_DeviousLegCuffs") || (deviousKeyword == "LegCuffs")  || (deviousKeyword == "LegCuff") 
		thisKeyword = libs.zad_DeviousLegCuffs

	elseif (deviousKeyword == "zad_DeviousGag") || (deviousKeyword == "Gag") 
		thisKeyword = libs.zad_DeviousGag

	elseif (deviousKeyword == "zad_DeviousBlindfold") || (deviousKeyword == "Blindfold") 
		thisKeyword = libs.zad_DeviousBlindfold

	elseif (deviousKeyword == "zad_DeviousBelt") || (deviousKeyword == "Belt") 
		thisKeyword = libs.zad_DeviousBelt

	elseif (deviousKeyword == "zad_DeviousPlugAnal") || (deviousKeyword == "PlugAnal") 
		thisKeyword = libs.zad_DeviousPlugAnal

	elseif (deviousKeyword == "zad_DeviousPlugVaginal") || (deviousKeyword == "PlugVaginal") 
		thisKeyword = libs.zad_DeviousPlugVaginal

	elseif (deviousKeyword == "zad_DeviousBra") || (deviousKeyword == "Bra") 
		thisKeyword = libs.zad_DeviousBra

	elseif (deviousKeyword == "zad_DeviousArmCuffs") || (deviousKeyword == "ArmCuffs")  || (deviousKeyword == "ArmCuff") 
		thisKeyword = libs.zad_DeviousArmCuffs

	elseif (deviousKeyword == "zad_DeviousYoke") || (deviousKeyword == "Yoke") 
		thisKeyword = libs.zad_DeviousYoke

	elseif (deviousKeyword == "zad_DeviousCorset") || (deviousKeyword == "Corset") 
		thisKeyword = libs.zad_DeviousCorset

	elseif (deviousKeyword == "zad_DeviousClamps") || (deviousKeyword == "Clamps") 
		thisKeyword = libs.zad_DeviousClamps

	elseif (deviousKeyword == "zad_DeviousGloves") || (deviousKeyword == "Gloves") 
		thisKeyword = libs.zad_DeviousGloves

	elseif (deviousKeyword == "zad_DeviousHood") || (deviousKeyword == "Hood") 
		thisKeyword = libs.zad_DeviousHood

	elseif (deviousKeyword == "zad_DeviousSuit") || (deviousKeyword == "Suits") 
		thisKeyword = libs.zad_DeviousSuit

	elseif (deviousKeyword == "zad_DeviousGagPanel") || (deviousKeyword == "GagPanel") 
		thisKeyword = libs.zad_DeviousGagPanel

	elseif (deviousKeyword == "zad_DeviousPlug") || (deviousKeyword == "Plug") 
		thisKeyword = libs.zad_DeviousPlug

	elseif (deviousKeyword == "zad_DeviousHarness") || (deviousKeyword == "Harness") 
		thisKeyword = libs.zad_DeviousHarness

	elseif (deviousKeyword == "zad_DeviousBoots") || (deviousKeyword == "Boots") 
		thisKeyword = libs.zad_DeviousBoots

	elseif (deviousKeyword == "zad_DeviousPiercingsNipple") || (deviousKeyword == "PiercingNipple")  || (deviousKeyword == "NipplePiercing")|| (deviousKeyword == "NipplePiercings") 
		thisKeyword = libs.zad_DeviousPiercingsNipple

	elseif (deviousKeyword == "zad_DeviousPiercingsVaginal") || (deviousKeyword == "PiercingVaginal")|| (deviousKeyword == "VaginalPiercing")|| (deviousKeyword == "VaginalPiercings") 
		thisKeyword = libs.zad_DeviousPiercingsVaginal

	else
		Debug.Notification("[SD] getDeviousKeywordByString: Unknown generic keyword: " + deviousKeyword)  
		Debug.Trace("[SD] getDeviousKeywordByString: Unknown generic keyword: " + deviousKeyword)  
	endIf

	return thisKeyword
EndFunction

Bool Function ActorHasKeywordByString(actor akActor, String deviousKeyword = "")
	return libs.ActorHasKeyword(akActor, getDeviousKeywordByString( deviousKeyword ))
EndFunction

Bool Function isInfectedByString( Actor akActor,  String sParasiteString  )

	Return akActor.WornHasKeyword(getDeviousKeywordByString(sParasiteString))
EndFunction

;------------------------------------------------------------------------------
Bool Function infectSpiderEgg( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()
  	Int iNumSpiderEggs
  
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
 	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "SpiderEgg" ))
		Debug.Trace("		Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "PlugVaginal"  ))
		Debug.Trace("		Already wearing a vaginal plug - Aborting")
		Return False
	Endif

	If (!isFemale( kActor))
		Debug.Trace("		Actor is not female - Aborting")
		Return False
	Endif

	iNumSpiderEggs = Utility.RandomInt(5,10)
	If (StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount")!=0)
		iNumSpiderEggs = StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount")
	Endif

	If (kActor == PlayerActor)
		SpiderEggInfectedAlias.ForceRefTo(PlayerActor)
	endIf
	if (iNumSpiderEggs>=8)
		StomachRot.RemoteCast(kActor as ObjectReference, kActor,kActor as ObjectReference)
	endIf

	equipParasiteNPCByString (kActor, "SpiderEgg")

	ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" ))

	If !StorageUtil.HasIntValue(kActor, "_SLP_iSpiderEggInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numSpiderEggInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections"))
	endIf

	SendModEvent("SLPSpiderEggInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureSpiderEgg( Actor kActor, String _args, Bool bHarvestParasite = False   )
  	Actor PlayerActor = Game.GetPlayer()
 	Int iNumSpiderEggs
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "SpiderEgg" ))
		iNumSpiderEggs = StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount") - Utility.RandomInt(2,8)

		if (iNumSpiderEggs < 0) || (_args == "All")
			If (kActor == PlayerActor)
				SpiderEggInfectedAlias.ForceRefTo(DummyAlias)
			endIf
			iNumSpiderEggs = 0
			StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", 0 )

			kActor.DispelSpell(StomachRot)

			StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 0)
			clearParasiteNPCByString (kActor, "SpiderEgg")

			If (bHarvestParasite)
				PlayerActor.AddItem(SLP_plugSpiderEggInventory,1)
			Endif
		Endif

		ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" ) )
 
		StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )
		SendModEvent("SLPSpiderEggInfection")
	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 0)
	EndIf
EndFunction


;------------------------------------------------------------------------------
Bool Function infectSpiderPenis( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()
  	Int iNumSpiderEggs
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderPenis" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "SpiderPenis" ))
		Debug.Trace("		Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "PlugVaginal"  ))
		Debug.Trace("		Already wearing a vaginal plug - Aborting")
		Return False
	Endif

	If (!isFemale( kActor))
		Debug.Trace("		Actor is not female - Aborting")
		Return False
	Endif
	
	iNumSpiderEggs = Utility.RandomInt(5,10)

	If (kActor == PlayerActor)
		SpiderEggInfectedAlias.ForceRefTo(PlayerActor)
	endIf
	if (iNumSpiderEggs>=4)
		StomachRot.RemoteCast(kActor as ObjectReference, kActor,kActor as ObjectReference)
	endIf

	equipParasiteNPCByString (kActor, "SpiderPenis")

	ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" ) )

	If !StorageUtil.HasIntValue(kActor, "_SLP_iSpiderEggInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderPenisDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numSpiderEggInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections"))
	endIf

	SendModEvent("SLPSpiderEggInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif

	
	Return True
EndFunction

Function cureSpiderPenis( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "SpiderPenis" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 0 )
		clearParasiteNPCByString (kActor, "SpiderPenis", true, true)

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_plugSpiderPenisInventory,1)
		Endif

		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 1 )
		equipParasiteNPCByString (kActor, "SpiderEgg")
	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 0)
	EndIf
EndFunction


;------------------------------------------------------------------------------
Bool Function infectChaurusWorm( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "ChaurusWorm" ))
		Debug.Trace("		Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "PlugAnal"  ))
		Debug.Trace("		Already wearing an anal plug - Aborting")
		Return False
	Endif

	equipParasiteNPCByString (kActor, "ChaurusWorm")

	If (kActor == PlayerActor)
		ChaurusWormInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	ApplyBodyChange( kActor, "ChaurusWorm", "Butt", 1.5, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusWormInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numChaurusWormInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormInfections"))
	endIf

	SendModEvent("SLPChaurusWormInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureChaurusWorm( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "ChaurusWorm" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 0)
		clearParasiteNPCByString (kActor, "ChaurusWorm")
		ApplyBodyChange( kActor, "ChaurusWorm", "Butt", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_plugChaurusWormInventory,1)
		Endif

		If (kActor == PlayerActor)
			ChaurusWormInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 0)
	EndIf
EndFunction

;------------------------------------------------------------------------------
Bool Function infectChaurusWormVag( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "ChaurusWormVag" ))
		Debug.Trace("		Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "PlugVaginal"  ))
		Debug.Trace("		Already wearing a vaginal plug - Aborting")
		Return False
	Endif

	If (!isFemale( kActor))
		Debug.Trace("		Actor is not female - Aborting")
		Return False
	Endif
	

	equipParasiteNPCByString (kActor, "ChaurusWormVag")

	If (kActor == PlayerActor)
		ChaurusWormInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	ApplyBodyChange( kActor, "ChaurusWormVag", "Belly", 1.5, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusWormVagInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormVagInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWormVag", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormVagDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormVagInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormVagInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numChaurusWormVagInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormVagInfections"))
	endIf

	SendModEvent("SLPChaurusWormVagInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureChaurusWormVag( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "ChaurusWormVag" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWormVag", 0)
		clearParasiteNPCByString (kActor, "ChaurusWormVag")
		ApplyBodyChange( kActor, "ChaurusWormVag", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_plugChaurusWormVagInventory,1)
		Endif

		If (kActor == PlayerActor)
			ChaurusWormInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWormVag", 0)
	EndIf
EndFunction

;------------------------------------------------------------------------------
Bool Function infectEstrusTentacles( Actor kActor   )
  	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusTentacles" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return False
	Endif

	If (!isFemale( kActor))
		Debug.Trace("		Actor is not female - Aborting")
		Return False
	Endif
	

	If (!ActorHasKeywordByString(kActor,  "PlugVaginal")) && (!ActorHasKeywordByString(kActor,  "Harness")) && (!isInfectedByString( kActor,  "TentacleMonster" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceTentacleMonster" )))
			; PlayerActor.SendModEvent("SLPInfectTentacleMonster")
			infectTentacleMonster(kActor)

			if (kActor==PlayerActor)
				Debug.MessageBox("The ground shakes around you as tentacles shoot around your body and a slimy, sticky creature attaches itself around your back.")
			else
				Debug.MessageBox("The ground shakes as slimy tentacles shoot up.")
			endif
	Else
		Debug.Trace("[SLP] Tentacle Monster infection failed")
		Debug.Trace("[SLP]   Vaginal Plug: " + ActorHasKeywordByString(kActor,  "PlugVaginal"))
		Debug.Trace("[SLP]   TentacleMonster: " + isInfectedByString( kActor,  "TentacleMonster" ))
		Debug.Trace("[SLP]   Chance infection: " + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceTentacleMonster" ))
	EndIf

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap, Game.GetPlayer())             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kActor)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, 0)    			; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
	endif

	If !StorageUtil.HasIntValue(kActor, "_SLP_iEstrusTentaclesInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iEstrusTentaclesInfections",  0)
	EndIf

	; StorageUtil.SetIntValue(kActor, "_SLP_toggleEstrusTentacle", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusTentaclseDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusTentaclesInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iEstrusTentaclesInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numEstrusTentaclesInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iEstrusTentaclesInfections"))
	endIf

	SendModEvent("SLPEstrusTentaclesInfection")


	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

;------------------------------------------------------------------------------
Bool Function infectTentacleMonster( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceTentacleMonster" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return False
	Endif

	If ((isInfectedByString( kActor,  "TentacleMonster" )) || (isInfectedByString( kActor,  "FaceHugger" )) )
		Debug.Trace("		Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "Harness"  ))
		Debug.Trace("		Already wearing a harness- Aborting")
		Return False
	Endif

	If (!isFemale( kActor))
		Debug.Trace("		Actor is not female - Aborting")
		Return False
	Endif
	

	equipParasiteNPCByString (kActor, "TentacleMonster")

	If (kActor == PlayerActor)
		TentacleMonsterInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iTentacleMonsterInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iTentacleMonsterInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iTentacleMonsterDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iTentacleMonsterInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iTentacleMonsterInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numTentacleMonsterInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iTentacleMonsterInfections"))
	endIf

	SendModEvent("SLPTentacleMonsterInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureTentacleMonster( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "TentacleMonster" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 0 )
		clearParasiteNPCByString (kActor, "TentacleMonster")
		ApplyBodyChange( kActor, "TentacleMonster", "Breast", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxTentacleMonster" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessTentacleMonsterInventory,1)
		Endif

		If (kActor == PlayerActor)
			TentacleMonsterInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 0)
	EndIf
EndFunction

;------------------------------------------------------------------------------
Bool Function infectEstrusSlime( Actor kActor   )
  	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusSlime" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return False
	Endif

	If (!isFemale( kActor))
		Debug.Trace("		Actor is not female - Aborting")
		Return False
	Endif
	

	If (!ActorHasKeywordByString(kActor,  "Harness")) && (!isInfectedByString( kActor,  "LivingArmor" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceLivingArmor" )))
			; PlayerActor.SendModEvent("SLPInfectLivingArmor")
			infectLivingArmor(kActor)
			if (kActor==PlayerActor)
				Debug.MessageBox("What looked like creepy clusters suddenly extends tentacles around your skin and strips you of your clothes. A deep shudder ripples down your spine as sharp hooks burry deep into the back of your neck.")
			else
				Debug.MessageBox("What looked like creepy clusters suddenly extends tentacles around.")
			endif
	Else
		Debug.Trace("[SLP] Living Armor infection failed")
		Debug.Trace("[SLP]   Harness: " + ActorHasKeywordByString(kActor,  "Harness"))
		Debug.Trace("[SLP]   LivingArmor: " + isInfectedByString( kActor,  "LivingArmor" ))
		Debug.Trace("[SLP]   Chance infection: " + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceLivingArmor" ))
	EndIf

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap, Game.GetPlayer())             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kActor)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, Utility.randomInt(3,4))    	; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
	endif

	If !StorageUtil.HasIntValue(kActor, "_SLP_iEstrusSlimeInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iEstrusSlimeInfections",  0)
	EndIf

	; StorageUtil.SetIntValue(kActor, "_SLP_toggleEstrusTentacle", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusSlimeDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusSlimeInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iEstrusSlimeInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numEstrusSlimeInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iEstrusSlimeInfections"))
	endIf

	SendModEvent("SLPEstrusSlimeInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True

EndFunction

;------------------------------------------------------------------------------
Bool Function infectLivingArmor( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceLivingArmor" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return False
	Endif

	If ((isInfectedByString( kActor,  "LivingArmor" )) || (isInfectedByString( kActor,  "FaceHugger" )) )
		Debug.Trace("		Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "Harness"  ))
		Debug.Trace("		Already wearing a corset - Aborting")
		Return False
	Endif

	If (!isFemale( kActor))
		Debug.Trace("		Actor is not female - Aborting")
		Return False
	Endif
	

	equipParasiteNPCByString (kActor, "LivingArmor")

	If (kActor == PlayerActor)
		LivingArmorInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iLivingArmorInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iLivingArmorInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleLivingArmor", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iLivingArmorDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iLivingArmorInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iLivingArmorInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numLivingArmorInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iLivingArmorInfections"))
	endIf

	SendModEvent("SLPLivingArmorInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureLivingArmor( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "LivingArmor" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleLivingArmor", 0 )
		clearParasiteNPCByString (kActor, "LivingArmor")
		ApplyBodyChange( kActor, "LivingArmor", "Breast", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxLivingArmor" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessLivingArmorInventory,1)
		Endif

		If (kActor == PlayerActor)
			LivingArmorInfectedAlias.ForceRefTo(DummyAlias)
		endIf
	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleLivingArmor", 0)
	EndIf
EndFunction

;------------------------------------------------------------------------------
Bool Function infectFaceHugger( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()
 	Cell kActorCell

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHugger" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return False
	Endif

	If (( isInfectedByString( kActor,  "FaceHugger" )) || (isInfectedByString( kActor,  "LivingArmor" )) || (isInfectedByString( kActor,  "TentacleMonster" )) )
		Debug.Trace("		Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "Belt"  ))
		Debug.Trace("		Already wearing a belt - Aborting")
		Return False
	Endif

	If (!isFemale( kActor))
		Debug.Trace("		Actor is not female - Aborting")
		Return False
	Endif
	

 	kActorCell = kActor.GetParentCell()
	If (kActorCell.IsInterior())
		Debug.Trace("		Location is outdoors (some locations falsely register as caves) - Aborting")
		Return False
	Endif

	equipParasiteNPCByString (kActor, "FaceHugger")

	If (kActor == PlayerActor)
		FaceHuggerInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iFaceHuggerInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numFaceHuggerInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerInfections"))
	endIf

	SendModEvent("SLPFaceHuggerInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureFaceHugger( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "FaceHugger" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 0 )
		clearParasiteNPCByString (kActor, "FaceHugger")
		ApplyBodyChange( kActor, "FaceHugger", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessFaceHuggerInventory,1)
		Endif

		If (kActor == PlayerActor) && !(isInfectedByString( kActor,  "FaceHugger" ))
			FaceHuggerInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 0)
	EndIf
EndFunction

Bool Function infectFaceHuggerGag( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()
	Cell kActorCell
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHugger" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "FaceHuggerGag" ))
		Debug.Trace("		Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "Gag"  ))
		Debug.Trace("		Already wearing a gag - Aborting")
		Return False
	Endif

 	kActorCell = kActor.GetParentCell()
	If (kActorCell.IsInterior())
		Debug.Trace("		Location is outdoors (some locations falsely register as caves) - Aborting")
		Return False
	Endif

	equipParasiteNPCByString (kActor, "FaceHuggerGag")

	If (kActor == PlayerActor)
		FaceHuggerInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iFaceHuggerInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numFaceHuggerInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerInfections"))
	endIf

	SendModEvent("SLPFaceHuggerInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureFaceHuggerGag( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
  	
	If (isInfectedByString( kActor,  "FaceHuggerGag" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 0 )
		clearParasiteNPCByString (kActor, "FaceHuggerGag")
		ApplyBodyChange( kActor, "FaceHugger", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessFaceHuggerGagInventory,1)
		Endif

		If (kActor == PlayerActor) && !(isInfectedByString( kActor,  "FaceHugger" ))
			FaceHuggerInfectedAlias.ForceRefTo(DummyAlias)
		endIf


	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 0)
	EndIf
EndFunction

;------------------------------------------------------------------------------
Bool Function infectBarnacles( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()
	Cell kActorCell

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf

	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceBarnacles" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "Barnacles" ))
		Debug.Trace("		Already infected - Aborting")
		Return False
	Endif

	If ((ActorHasKeywordByString( kActor, "Harness"  )) || (ActorHasKeywordByString( kActor, "Corset"  )) )
		Debug.Trace("		Already wearing a corset - Aborting")
		Return False
	Endif

 	kActorCell = kActor.GetParentCell()
	If (kActorCell.IsInterior())
		Debug.Trace("		Location is outdoors (some locations falsely register as caves) - Aborting")
		Return False
	Endif

	If (!isFemale( kActor))
		Debug.Trace("		Actor is not female - Aborting")
		Return False
	Endif
	

	equipParasiteNPCByString (kActor, "Barnacles")

	If (kActor == PlayerActor)
		BarnaclesInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iBarnaclesInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iBarnaclesInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleBarnacles", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iBarnaclesDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iBarnaclesInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iBarnaclesInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numBarnaclesInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iBarnaclesInfections"))
	endIf

	SendModEvent("SLPBarnaclesInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif

	Return True
EndFunction

Function cureBarnacles( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
  	

	If (isInfectedByString( kActor,  "Barnacles" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleBarnacles", 0 )
		clearParasiteNPCByString (kActor, "Barnacles")

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessBarnaclesInventory,1)
		Endif

		If (kActor == PlayerActor)
			BarnaclesInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleBarnacles", 0)
	EndIf
EndFunction

;------------------------------------------------------------------------------
Bool Function infectEstrusChaurusEgg( Actor kActor   )
  	Actor PlayerActor = Game.GetPlayer()

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf

	If (!isFemale( kActor))
		Debug.Trace("		Actor is not female - Aborting")
		Return False
	Endif
	

	; If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusChaurusEgg" )==0.0)
	;	Debug.Trace("		Parasite disabled - Aborting")
	;	Return
	; Endif

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap, Game.GetPlayer())             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kActor)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, -1)    	; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
	endif

	If !StorageUtil.HasIntValue(kActor, "_SLP_iEstrusChaurusEggInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iEstrusChaurusEggInfections",  0)
	EndIf
 
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusChaurusEggDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusChaurusEggInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iEstrusChaurusEggInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	endIf

	; _SLP_GV_numEstrusChaurusEggInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iEstrusChaurusEggInfections"))

	SendModEvent("SLPEstrusChaurusEggInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif

	Return True
EndFunction

;------------------------------------------------------------------------------
Function triggerEstrusChaurusBirth( Actor kActor, String  sParasite, Int iBirthItemCount  )
  	Actor PlayerActor = Game.GetPlayer()
  	Form fBirthItem = None

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	; If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusChaurusEgg" )==0.0)
	;	Debug.Trace("		Parasite disabled - Aborting")
	;	Return
	; Endif 

	If (sParasite == "SpiderEgg")
		fBirthItem = SmallSpiderEgg as Form

	ElseIf (sParasite == "Barnacles")
		fBirthItem = BarnaclesCluster as Form

	Endif

	If (fBirthItem != None)
		; Testing EC birth event
		;To call an EC Birth event use the following code:
		;
		int ECBirth = ModEvent.Create("ECGiveBirth") ; Int          Int does not have to be named "ECBirth" any name would do
		if (ECBirth)
		    ModEvent.PushForm(ECBirth, self)         ; Form         Pass the calling form to the event

		    ModEvent.PushForm(ECBirth, kActor)      ; Form         The Actor to give birth
		    ModEvent.PushForm(ECBirth, fBirthItem) ; Form    The Item to give birth to - if push None births Chaurus eg
		    ModEvent.PushInt(ECBirth, iBirthItemCount)            ; Int    The number of Items to give birth too
		    ModEvent.Send(ECBirth)
		else
		    ;EC is not installed
		endIf
		;
		;   **NB** The birth event will not fire if the actor is already infected with the Chaurus Parasite effect
		;               This birth event is unaware of calling mods effects on Breast/Belly/Butt nodes - Any changes to
		;               inflation of these nodes at birth must be handled by the calling mod.
	Endif

EndFunction

;------------------------------------------------------------------------------
Function refreshParasite(Actor kActor, String sParasite)

	If (sParasite == "SpiderPenis")
		If (isInfectedByString( kActor,  "SpiderPenis" )) && (!ActorHasKeywordByString( kActor, "PlugVaginal"  ))
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 1)
			equipParasiteNPCByString (kActor, "SpiderPenis")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 0)
			clearParasiteNPCByString (kActor, "SpiderPenis")
		Endif

	ElseIf (sParasite == "SpiderEgg")
		If (isInfectedByString( kActor,  "SpiderEgg" )) && (!ActorHasKeywordByString( kActor, "PlugVaginal"  ))
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 1)
			equipParasiteNPCByString (kActor, "SpiderEgg")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 0)
			clearParasiteNPCByString (kActor, "SpiderEgg")
		Endif

	ElseIf (sParasite == "ChaurusWorm")
		If (isInfectedByString( kActor,  "ChaurusWorm" )) && (!ActorHasKeywordByString( kActor, "PlugAnal"  ))
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 1)
			equipParasiteNPCByString (kActor, "ChaurusWorm")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 0)
			clearParasiteNPCByString (kActor, "ChaurusWorm")
		Endif

	ElseIf (sParasite == "ChaurusWormVag")
		If (isInfectedByString( kActor,  "ChaurusWormVag" )) && (!ActorHasKeywordByString( kActor, "PlugVaginal"  ))
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWormVag", 1)
			equipParasiteNPCByString (kActor, "ChaurusWormVag")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWormVag", 0)
			clearParasiteNPCByString (kActor, "ChaurusWormVag")
		Endif

	ElseIf (sParasite == "FaceHugger")
		If (isInfectedByString( kActor,  "FaceHugger" )) && (!ActorHasKeywordByString( kActor, "Belt"  ))
			StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 1)
			equipParasiteNPCByString (kActor, "FaceHugger")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 0)
			clearParasiteNPCByString (kActor, "FaceHugger")
		Endif

	ElseIf (sParasite == "FaceHuggerGag")
		If (isInfectedByString( kActor,  "FaceHuggerGag" )) && (!ActorHasKeywordByString( kActor, "Gag"  ))
			StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 1)
			equipParasiteNPCByString (kActor, "FaceHuggerGag")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 0)
			clearParasiteNPCByString (kActor, "FaceHuggerGag")
		Endif

	ElseIf (sParasite == "TentacleMonster")
		If (isInfectedByString( kActor,  "TentacleMonster" )) && (!ActorHasKeywordByString( kActor, "Harness"  )) && (!ActorHasKeywordByString( kActor, "Corset"  ))
			StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 1)
			equipParasiteNPCByString (kActor, "TentacleMonster")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 0)
			clearParasiteNPCByString (kActor, "TentacleMonster")
		Endif

	ElseIf (sParasite == "LivingArmor")
		If (isInfectedByString( kActor,  "LivingArmor" )) && (!ActorHasKeywordByString( kActor, "Harness"  )) && (!ActorHasKeywordByString( kActor, "Corset"  ))
			StorageUtil.SetIntValue(kActor, "_SLP_toggleLivingArmor", 1)
			equipParasiteNPCByString (kActor, "LivingArmor")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleLivingArmor", 0)
			clearParasiteNPCByString (kActor, "LivingArmor")
		Endif

	ElseIf (sParasite == "Barnacles")
		If (isInfectedByString( kActor,  "Barnacles" )) && (!ActorHasKeywordByString( kActor, "Harness"  )) && (!ActorHasKeywordByString( kActor, "Corset"  ))
			StorageUtil.SetIntValue(kActor, "_SLP_toggleBarnacles", 1)
			equipParasiteNPCByString (kActor, "Barnacles")

		Else
			StorageUtil.SetIntValue(kActor, "_SLP_toggleBarnacles", 0)
			clearParasiteNPCByString (kActor, "Barnacles")
		Endif
	Endif

EndFunction


;------------------------------------------------------------------------------
Function ApplyBodyChange(Actor kActor, String sParasite, String sBodyPart, Float fValue=1.0, Float fValueMax=1.0)
  	ActorBase pActorBase = kActor.GetActorBase()
 	Actor PlayerActor = Game.GetPlayer()
  	String NiOString = "SLP_" + sParasite

	if ( isNiOInstalled  )  

		Debug.Trace("[SLP] Receiving body change: " + sBodyPart)
		Debug.Trace("[SLP]  	Node string: " + sParasite)
		Debug.Trace("[SLP]  	Max node: " + fValueMax)

 		if (!isSlifInstalled)
			if (fValue < 1.0)
				fValue = 1.0     ; NiO node is reset with value of 1.0 - not 0.0!
			Endif		

			if (fValue > fValueMax)
				fValue = fValueMax
			Endif
		Endif


		if (( sBodyPart == "Breast"  ) && (pActorBase.GetSex()==1)) ; Female change
			Debug.Trace("[SLP]     Applying breast change: " + NiOString)
			Debug.Trace("[SLP]     Value: " + fValue)

			if (isSlifInstalled)
				SLIF_inflateMax(kActor, "slif_breast", fValue, fValueMax, NiOString)
			else
				XPMSELib.SetNodeScale(kActor, true, NINODE_LEFT_BREAST, fValue, NiOString)
				XPMSELib.SetNodeScale(kActor, true, NINODE_RIGHT_BREAST, fValue, NiOString)
			Endif

		Elseif (( sBodyPart == "Belly"  ) && (pActorBase.GetSex()==1)) ; Female change
			Debug.Trace("[SLP]     Applying belly change: " + NiOString)
			Debug.Trace("[SLP]     Value: " + fValue)

			if (isSlifInstalled)
				SLIF_inflateMax(kActor, "slif_belly", fValue, fValueMax, NiOString)
			else
				XPMSELib.SetNodeScale(kActor, true, NINODE_BELLY, fValue, NiOString)
			Endif


		Elseif (( sBodyPart == "Butt"  )) 
			Debug.Trace("[SLP]     Applying butt change: " + NiOString)
			Debug.Trace("[SLP]     Value: " + fValue)

			if (isSlifInstalled)
				SLIF_inflateMax(kActor, "slif_butt", fValue, fValueMax, NiOString)
			else
				XPMSELib.SetNodeScale(kActor, pActorBase.GetSex(), NINODE_LEFT_BUTT, fValue, NiOString)
				XPMSELib.SetNodeScale(kActor, pActorBase.GetSex(), NINODE_RIGHT_BUTT, fValue, NiOString)
			Endif


		Elseif (( sBodyPart == "Schlong"  ) ) 
			Debug.Trace("[SLP]     Applying schlong change: " + NiOString)
			Debug.Trace("[SLP]     Value: " + fValue)

			if (isSlifInstalled)
				SLIF_inflateMax(kActor, "slif_schlong", fValue, fValueMax, NiOString)
			else
				XPMSELib.SetNodeScale(kActor, pActorBase.GetSex(), NINODE_SCHLONG, fValue, NiOString)
			Endif

		Endif
	Else
		; Debug.Notification("[SLP] Receiving body change: NiO not installed")

	EndIf

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

;------------------------------------------------------------------------------
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

bool function isEstrusChaurusON()
	if (StorageUtil.GetFormValue(none, "_SLS_getEstrusChaurusBreederSpell")!=none)
		return true
	else
		return false
	endif
endFunction

;------------------------------------------------------------------------------
function SLIF_inflate(Actor kActor, String sKey, float value, String NiOString)
	int SLIF_event = ModEvent.Create("SLIF_inflate")
	If (SLIF_event)
		ModEvent.PushForm(SLIF_event, kActor)
		ModEvent.PushString(SLIF_event, "SexLab Parasites")
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
		ModEvent.PushString(SLIF_event, "SexLab Parasites")
		ModEvent.PushString(SLIF_event, sKey)
		ModEvent.PushFloat(SLIF_event, maximum)
		ModEvent.Send(SLIF_event)
	EndIf	
endFunction

function SLIF_inflateMax(Actor kActor, String sKey, float value, float maximum, String NiOString)
	SLIF_setMax(kActor, sKey, maximum)
	SLIF_inflate(kActor, sKey, value, NiOString)
endFunction

;------------------------------------------------------------------------------
Function ParasiteSex(Actor kActor, Actor kParasite)
	If  (SexLab.ValidateActor( kActor ) > 0) &&  (SexLab.ValidateActor(kParasite) > 0) 

		SexLab.QuickStart(kActor,  kParasite, AnimationTags = "Sex")
	EndIf
EndFunction
;------------------------------------------------------------------------------
Function FalmerBlue(Actor kActor, Actor kTarget)
	If (StorageUtil.GetIntValue(none, "_SLH_iHormones")==1)
		Int iFalmerSkinColor = Math.LeftShift(255, 24) + Math.LeftShift(100, 16) + Math.LeftShift(200, 8) + 255
		Float breastMod = 0.05
		Float weightMod = 2.0

		If (Utility.RandomInt(0,100)>60)
			Int randomNum = Utility.RandomInt(0,100)
			If (randomNum>80)
				Debug.MessageBox("Glowing fluids spread from the Falmer's skin across yours like quicksilver, making your nipples stiffen and tingle painfully with poisonous throbs. ")
				breastMod = 0.5
				weightMod = 15.0
				StorageUtil.SetIntValue(none, "_SLH_iForcedHairLoss", 1)
				kTarget.SendModEvent("SLHShaveHead")

			ElseIf (randomNum>60)
				Debug.MessageBox("The purpose of the glowing substance is clear to you now, fattening you up for breeding and turning you into an irresistible beacon for the Falmers and their pets.")
				breastMod = 0.25
				weightMod = 10.0
				StorageUtil.SetIntValue(none, "_SLH_iForcedHairLoss", 1)
				kTarget.SendModEvent("SLHShaveHead")

			ElseIf (randomNum>40)
				Debug.Notification("Your skin burns under glowing droplets.")
				breastMod = 0.1
				weightMod = 5.0

			ElseIf (randomNum>20)
				Debug.Notification("The tingling over your skin is driving you mad.")
				breastMod = 0.25
				weightMod = 2.0

			EndIf

		EndIf

		StorageUtil.SetIntValue(kTarget, "_SLH_iSkinColor", iFalmerSkinColor ) 
		StorageUtil.SetFloatValue(kTarget, "_SLH_fBreast", StorageUtil.GetFloatValue(kTarget, "_SLH_fBreast" ) + breastMod ) 
		StorageUtil.SetFloatValue(kTarget, "_SLH_fWeight", StorageUtil.GetFloatValue(kTarget, "_SLH_fWeight" ) + weightMod ) 
		kTarget.SendModEvent("SLHRefresh")
		kTarget.SendModEvent("SLHRefreshColors")


		if (Utility.RandomInt(0,100)>90)
			SendModEvent("SLHModHormoneRandom", "Chaurus")
		else
			SendModEvent("SLHModHormone", "Growth", 5.0)
			SendModEvent("SLHModHormone", "Female", 10.0)
			SendModEvent("SLHModHormone", "Male", -5.0)

			if (isFemale(kTarget))
				SendModEvent("SLHModHormone", "Metabolism", -15.0)
				SendModEvent("SLHModHormone", "Lactation", 5.0)
			else
				SendModEvent("SLHModHormone", "Metabolism", 15.0)
			endif
		endif
	Endif	
EndFunction
;------------------------------------------------------------------------------

bool Function CheckXPMSERequirements(Actor akActor, bool isFemale)
	return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction

Function _resetParasiteSettings()
	Actor kPlayer = Game.GetPlayer()

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSpiderEgg", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSpiderEgg", 50.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxSpiderEgg", 2.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleSpiderPenis", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceSpiderPenis", 10.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusWorm", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusWorm", 10.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_buttMaxChaurusWorm", 2.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleChaurusWormVag", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusWormVag", 10.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxChaurusWormVag", 2.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleEstrusTentacles", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceEstrusTentacles", 10.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleTentacleMonster", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceTentacleMonster", 30.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_breastMaxTentacleMonster", 2.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleEstrusSlime", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceEstrusSlime", 10.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleLivingArmor", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceLivingArmor", 30.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_breastMaxLivingArmor", 2.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleFaceHugger", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceFaceHugger", 30.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceFaceHuggerGag", 30.0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_bellyMaxFaceHugger", 2.0 )

	StorageUtil.SetIntValue(kPlayer, "_SLP_toggleBarnacles", 0 )
	StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceBarnacles", 30.0 )
EndFunction
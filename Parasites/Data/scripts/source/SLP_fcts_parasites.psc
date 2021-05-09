Scriptname SLP_fcts_parasites extends Quest  
{ USED }
Import Utility
Import SKSE
zadLibs Property libs Auto
SexLabFrameWork Property SexLab Auto

SLP_fcts_outfits Property fctOutfits  Auto
SLP_fcts_utils Property fctUtils  Auto

 
ReferenceAlias Property PlayerAlias  Auto  
ReferenceAlias Property SpiderEggInfectedAlias  Auto  
ReferenceAlias Property ChaurusWormInfectedAlias  Auto  
ReferenceAlias Property ChaurusQueenInfectedAlias  Auto  
ReferenceAlias Property BarnaclesInfectedAlias  Auto  
ReferenceAlias Property TentacleMonsterInfectedAlias  Auto  
ReferenceAlias Property LivingArmorInfectedAlias  Auto  
ReferenceAlias Property FaceHuggerInfectedAlias  Auto  
ReferenceAlias Property SpiderFollowerAlias  Auto  
ReferenceAlias Property ChaurusFollowerAlias  Auto  

Quest Property KynesBlessingQuest  Auto 
Quest Property QueenOfChaurusQuest  Auto 
Quest Property TentacleMonsterQuest  Auto 

ObjectReference Property DummyAlias  Auto  
ObjectReference Property LastelleRef  Auto  
ObjectReference Property LastelleCampOutside  Auto  

Sound Property SummonSoundFX  Auto
Sound Property VoicesFX  Auto
Sound Property CritterFX  Auto
Sound Property WetFX  Auto

Actor Property EncChaurusActor Auto 
Actor Property EncChaurusSpawnActor Auto 
Actor Property EncChaurusFledgelingActor Auto 
Actor Property EncChaurusHunterActor Auto 

 
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
GlobalVariable Property _SLP_GV_ZAPFuroTubOn  Auto  
GlobalVariable Property _SLP_GV_numCharmChaurus Auto
GlobalVariable Property _SLP_GV_numCharmSpider Auto


Faction Property PlayerFollowerFaction Auto

SPELL Property StomachRot Auto
SPELL Property SeedFlare Auto
SPELL Property SeedSpawnSpider Auto
SPELL Property SeedSpawnChaurus Auto
Spell Property SeedCalm Auto
Spell Property SeedChaurusBreeding Auto
Spell Property SeedSpiderBreeding Auto
Spell Property SeedTrack Auto

ImageSpaceModifier Property FalmerBlueImod  Auto  

Container Property EggSac  Auto

Ingredient  Property TrollFat Auto
Ingredient  Property IngredientChaurusWorm Auto

Ingredient  Property SmallSpiderEgg Auto
Ingredient  Property BarnaclesCluster Auto
Ingredient Property ChaurusEgg  Auto  
Ingredient Property GlowingMushrooms  Auto  

Potion Property SLP_CritterSemen Auto

Keyword Property ArmorCuirass  Auto  
Keyword Property ClothingBody  Auto  

Keyword Property _SLP_Parasite  Auto  
Keyword Property _SLP_ParasiteSpiderEgg  Auto  
Keyword Property _SLP_ParasiteSpiderPenis  Auto  
Keyword Property _SLP_ParasiteChaurusWorm  Auto  
Keyword Property _SLP_ParasiteChaurusWormVag Auto  
Keyword Property _SLP_ParasiteChaurusQueenGag Auto  
Keyword Property _SLP_ParasiteChaurusQueenSkin Auto  
Keyword Property _SLP_ParasiteChaurusQueenArmor Auto  
Keyword Property _SLP_ParasiteChaurusQueenBody Auto  
Keyword Property _SLP_ParasiteChaurusQueenVag Auto  
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
Armor Property SLP_plugChaurusQueenVagRendered Auto         ; Internal Device
Armor Property SLP_plugChaurusQueenVagInventory Auto        	       ; Inventory Device
Armor Property SLP_gagChaurusQueenRendered Auto         ; Internal Device
Armor Property SLP_gagChaurusQueenInventory Auto        	       ; Inventory Device
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
Armor Property SLP_harnessChaurusQueenSkinRendered Auto         ; Internal Device
Armor Property SLP_harnessChaurusQueenSkinInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessChaurusQueenArmorRendered Auto         ; Internal Device
Armor Property SLP_harnessChaurusQueenArmorInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessChaurusQueenBodyRendered Auto         ; Internal Device
Armor Property SLP_harnessChaurusQueenBodyInventory Auto        	       ; Inventory Device

Armor Property _SLP_skinChaurusQueenNaked Auto

Package Property _SLP_PKG_ZapFuroTub  Auto  



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
			Debug.Trace("[SLP]equipParasiteByString: " + sParasiteString)  
			Debug.Trace("[SLP]		keyword: " + kwDeviceKeyword)  

			aWornDevice = getParasiteByKeyword(kwDeviceKeyword) ; libs.GetWornDevice(akActor, kwDeviceKeyword) as Armor
			aRenderedDevice = getParasiteRenderedByKeyword(kwDeviceKeyword) ; libs.GetRenderedDevice(aWornDevice) as Armor

			If (aRenderedDevice!=None)
				equipParasiteNPC ( akActor, aWornDevice,  aRenderedDevice,  kwDeviceKeyword)
			Else
				Debug.Trace("[SLP]   Can't get worn device")
			endif

 
		else
			Debug.Trace("[SLP]player is already wearing: " + sParasiteString)  
		endIf

	else
		Debug.Trace("[SLP]unknown device to equip " )  

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

	Debug.Trace("[SLP]clearParasiteByString - NO override detected")  
	kwDeviceKeyword = 	getDeviousKeywordByString(sParasiteString)
	aWornDevice = none
	aRenderedDevice = none 
 
	If (kwDeviceKeyword != None)

		if akActor.WornHasKeyword(kwDeviceKeyword)
			; RemoveDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool destroyDevice=false, bool skipEvents=false, bool skipMutex=false)

			Debug.Trace("[SLP]clearing device string: " + sParasiteString)  
			Debug.Trace("[SLP]clearing device keyword: " + kwDeviceKeyword)  
  
			aWornDevice = getParasiteByKeyword(kwDeviceKeyword) ; libs.GetWornDevice(akActor, kwDeviceKeyword) as Armor
			aRenderedDevice = libs.GetRenderedDevice(aWornDevice) as Armor ; getParasiteRenderedByKeyword(kwDeviceKeyword) 

			If (aRenderedDevice!=None)
				clearParasiteNPC ( akActor, aWornDevice,  aRenderedDevice,  kwDeviceKeyword)
			Else
				Debug.Trace("[SLP]   Can't get worn device")
			endif
			
			; libs.ManipulateGenericDeviceByKeyword(PlayerActor, kwDeviceKeyword, False, skipEvents,  skipMutex)
  

		else
			Debug.Trace("[SLP]player is not wearing: " + sParasiteString)  
		endIf

	else
		Debug.Trace("[SLP]unknown device to clear " )  

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

	libs.Log("[SLP]equipParasite " )

	if (ddArmorKeyword != None)
		if (!akActor.WornHasKeyword(ddArmorKeyword))

			bDeviceEquipSuccess = libs.equipDevice(akActor, ddArmorInventory , ddArmorRendered , ddArmorKeyword)
			bDeviceEquipSuccess = True
		Else
			libs.Log("[SLP]  	skipped - device already equipped " )
		EndIf
	Else
		Debug.Notification("[SLP]equipParasite - bad keyword " )
	endIf

	return bDeviceEquipSuccess
EndFunction

Bool Function clearParasite ( Armor ddArmorInventory, Armor ddArmorRendered, Keyword ddArmorKeyword, Bool bDestroy = True)
	Actor kPlayer = Game.GetPlayer() as Actor
	Keyword kwWornKeyword
	Bool bDeviceRemoveSuccess = False
 
	bDeviceRemoveSuccess = clearParasiteNPC ( kPlayer, ddArmorInventory, ddArmorRendered, ddArmorKeyword,  bDestroy)
 
	return bDeviceRemoveSuccess
EndFunction

Bool Function clearParasiteNPC ( Actor akActor, Armor ddArmorInventory, Armor ddArmorRendered, Keyword ddArmorKeyword, Bool bDestroy = True) 
	Keyword kwWornKeyword
	Bool bDeviceRemoveSuccess = False

	If (bDestroy)
		libs.Log("[SLP]clearParasite - destroy: " + ddArmorKeyword )
	Else
		libs.Log("[SLP]clearParasite - remove: " + ddArmorKeyword  )
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

	Elseif (thisKeyword == _SLP_ParasiteChaurusQueenGag)
		thisArmor = SLP_gagChaurusQueenInventory

	Elseif (thisKeyword == _SLP_ParasiteChaurusQueenVag)
		thisArmor = SLP_plugChaurusQueenVagInventory

	Elseif (thisKeyword == _SLP_ParasiteChaurusQueenSkin)
		thisArmor = SLP_harnessChaurusQueenSkinInventory

	Elseif (thisKeyword == _SLP_ParasiteChaurusQueenArmor)
		thisArmor = SLP_harnessChaurusQueenArmorInventory

	Elseif (thisKeyword == _SLP_ParasiteChaurusQueenBody)
		thisArmor = SLP_harnessChaurusQueenBodyInventory

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

	Elseif (thisKeyword == _SLP_ParasiteChaurusQueenGag)
		thisArmor = SLP_gagChaurusQueenRendered

	Elseif (thisKeyword == _SLP_ParasiteChaurusQueenVag)
		thisArmor = SLP_plugChaurusQueenVagRendered

	Elseif (thisKeyword == _SLP_ParasiteChaurusQueenSkin)
		thisArmor = SLP_harnessChaurusQueenSkinRendered

	Elseif (thisKeyword == _SLP_ParasiteChaurusQueenArmor)
		thisArmor = SLP_harnessChaurusQueenArmorRendered

	Elseif (thisKeyword == _SLP_ParasiteChaurusQueenBody)
		thisArmor = SLP_harnessChaurusQueenBodyRendered

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
		
	elseif (deviousKeyword == "ChaurusQueenGag" )  
		thisKeyword = _SLP_ParasiteChaurusQueenGag
		
	elseif (deviousKeyword == "ChaurusQueenVag" )  
		thisKeyword = _SLP_ParasiteChaurusQueenVag
		
	elseif (deviousKeyword == "ChaurusQueenSkin" )  
		thisKeyword = _SLP_ParasiteChaurusQueenSkin
		
	elseif (deviousKeyword == "ChaurusQueenArmor" )  
		thisKeyword = _SLP_ParasiteChaurusQueenArmor
		
	elseif (deviousKeyword == "ChaurusQueenBody" )  
		thisKeyword = _SLP_ParasiteChaurusQueenBody
		
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

	elseif (deviousKeyword == "zad_DeviousPlug") || (deviousKeyword == "Plug") 
		thisKeyword = libs.zad_DeviousPlug

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
		Debug.Notification("[SLP] getDeviousKeywordByString: Unknown generic keyword: " + deviousKeyword)  
		Debug.Trace("[SLP] getDeviousKeywordByString: Unknown generic keyword: " + deviousKeyword)  
	endIf

	return thisKeyword
EndFunction

Bool Function ActorHasKeywordByString(actor akActor, String deviousKeyword = "")
	return libs.ActorHasKeyword(akActor, getDeviousKeywordByString( deviousKeyword ))
EndFunction

Bool Function isInfected( Actor akActor )
	Bool isInfected = False

	; By order of complexity

	if (akActor && akActor.WornHasKeyword(_SLP_Parasite) )
		isInfected = True
	Endif

	Return isInfected
EndFunction

Bool Function isInfectedByString( Actor akActor,  String sParasite  )
	Bool isInfected = False

	; By order of complexity

	if (akActor && sParasite && (StorageUtil.GetIntValue(akActor, "_SLP_toggle" + sParasite)==1) )
		isInfected = True

	elseif (akActor && sParasite && (StorageUtil.GetIntValue(akActor, "_SLP_iHiddenParasite_" + sParasite)==1) )
		isInfected = True

	elseif (akActor && sParasite && akActor.WornHasKeyword(getDeviousKeywordByString(sParasite)) )
		isInfected = True
	Endif

	Return isInfected
EndFunction

Function applyHiddenParasiteEffect(Actor akActor, String sParasite = ""  )
 
	if (sParasite == "SpiderEgg" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Belly", 2.0, 2.0 )

	elseif (sParasite == "SpiderPenis" )  
		; ApplyBodyChange( akActor, sParasite, "Belly", 2.0, 2.0 )

	elseif (sParasite == "ChaurusWorm" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Butt", 2.0, 2.0 )
		
	elseif (sParasite == "ChaurusWormVag" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Belly", 2.0, 2.0 )
		
	elseif (sParasite == "ChaurusQueenGag" )  
		; ApplyBodyChange( akActor, sParasite, "Belly", 2.0, 2.0 )
		
	elseif (sParasite == "ChaurusQueenVag" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Belly", 2.0, 2.0 )
		
	elseif (sParasite == "ChaurusQueenSkin" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Breast", 2.0, 2.0 )
		
	elseif (sParasite == "ChaurusQueenArmor" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Breast", 2.0, 2.0 )
		
	elseif (sParasite == "ChaurusQueenBody" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Breast", 2.0, 2.0 )
		fctUtils.ApplyBodyChange( akActor, sParasite, "Belly", 2.0, 2.0 )
		
	elseif (sParasite == "TentacleMonster" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Belly", 2.0, 2.0 )
		
	elseif (sParasite == "LivingArmor" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Belly", 2.0, 2.0 )
		
	elseif (sParasite == "FaceHugger" ) || (sParasite == "HipHugger" ) 
		; ApplyBodyChange( akActor, sParasite, "Belly", 2.0, 2.0 )
		
	elseif (sParasite == "FaceHuggerGag" )  
		; ApplyBodyChange( akActor, sParasite, "Belly", 2.0, 2.0 )
		
	elseif (sParasite == "Barnacles" )  
		; ApplyBodyChange( akActor, sParasite, "Belly", 2.0, 2.0 )

	endif

EndFunction

Function clearHiddenParasiteEffect(Actor akActor, String sParasite = ""  )
 
	if (sParasite == "SpiderEgg" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Belly", 0.5, 2.0 )

	elseif (sParasite == "SpiderPenis" )  
		; ApplyBodyChange( akActor, sParasite, "Belly", 0.5, 2.0 )

	elseif (sParasite == "ChaurusWorm" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Butt", 0.5, 2.0 )
		
	elseif (sParasite == "ChaurusWormVag" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Belly", 0.5, 2.0 )
		
	elseif (sParasite == "ChaurusQueenGag" )  
		; ApplyBodyChange( akActor, sParasite, "Belly", 0.5, 2.0 )
		
	elseif (sParasite == "ChaurusQueenVag" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Belly", 0.5, 2.0 )
		
	elseif (sParasite == "ChaurusQueenSkin" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Breast", 0.5, 2.0 )
		
	elseif (sParasite == "ChaurusQueenArmor" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Breast", 0.5, 2.0 )
		
	elseif (sParasite == "ChaurusQueenBody" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Belly", 0.5, 2.0 )
		fctUtils.ApplyBodyChange( akActor, sParasite, "Breast", 0.5, 2.0 )
		
	elseif (sParasite == "TentacleMonster" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Belly", 0.5, 2.0 )
		
	elseif (sParasite == "LivingArmor" )  
		fctUtils.ApplyBodyChange( akActor, sParasite, "Belly", 0.5, 2.0 )
		
	elseif (sParasite == "FaceHugger" )  || (sParasite == "HipHugger" )  
		; ApplyBodyChange( akActor, sParasite, "Belly", 0.5, 2.0 )
		
	elseif (sParasite == "FaceHuggerGag" )  
		; ApplyBodyChange( akActor, sParasite, "Belly", 0.5, 2.0 )
		
	elseif (sParasite == "Barnacles" )  
		; ApplyBodyChange( akActor, sParasite, "Belly", 0.5, 2.0 )

	endif

EndFunction

Function clearParasiteAlias(Actor akActor, String sParasite = ""  )
 
	if (sParasite == "SpiderEgg" )  
		SpiderEggInfectedAlias.ForceRefTo(DummyAlias)
		SpiderFollowerAlias.ForceRefTo(DummyAlias)  

	elseif (sParasite == "SpiderPenis" )  
		SpiderEggInfectedAlias.ForceRefTo(DummyAlias)
		SpiderFollowerAlias.ForceRefTo(DummyAlias)  

	elseif (sParasite == "ChaurusWorm" )  
		ChaurusWormInfectedAlias.ForceRefTo(DummyAlias)
		
	elseif (sParasite == "ChaurusWormVag" )  
		ChaurusWormInfectedAlias.ForceRefTo(DummyAlias)
		
	elseif (sParasite == "ChaurusQueenGag" )  
		;
		
	elseif (sParasite == "ChaurusQueenVag" )  
		;
		
	elseif (sParasite == "ChaurusQueenSkin" )  
		;
		
	elseif (sParasite == "ChaurusQueenArmor" )  
		;
		
	elseif (sParasite == "ChaurusQueenBody" )  
		;
		
	elseif (sParasite == "TentacleMonster" )  
		TentacleMonsterInfectedAlias.ForceRefTo(DummyAlias)
		
	elseif (sParasite == "LivingArmor" )  
		LivingArmorInfectedAlias.ForceRefTo(DummyAlias)
		
	elseif (sParasite == "FaceHugger" )  || (sParasite == "HipHugger" )  
		FaceHuggerInfectedAlias.ForceRefTo(DummyAlias)
		
	elseif (sParasite == "FaceHuggerGag" )  
		FaceHuggerInfectedAlias.ForceRefTo(DummyAlias)
		
	elseif (sParasite == "Barnacles" )  
		BarnaclesInfectedAlias.ForceRefTo(DummyAlias)

	endif

EndFunction


;------------------------------------------------------------------------------
Bool Function infectSpiderEgg( Actor kActor )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
 	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "SpiderEgg" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "PlugVaginal"  ))
		Debug.Trace("[SLP]	Already wearing a vaginal plug - Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif

	equipParasiteNPCByString (kActor, "SpiderEgg")

	Return true ; Return applySpiderEgg( kActor )

EndFunction

Bool Function applySpiderEgg( Actor kActor )
 	Actor PlayerActor = Game.GetPlayer()
  	Int iNumSpiderEggs

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

	fctUtils.ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" ))

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

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)

	SendModEvent("SLPSpiderEggInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

Function cureSpiderEgg( Actor kActor, String _args, Bool bHarvestParasite = False   )
  	Actor PlayerActor = Game.GetPlayer()
 	Int iNumSpiderEggs
 	Int iNumSpiderEggsRemoved
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf

  	If (isInfectedByString( kActor,  "SpiderPenis" )) 
  		; The spider penis is blocking the eggs
  		return
  	endif
 
	If (isInfectedByString( kActor,  "SpiderEgg" ))
		iNumSpiderEggsRemoved = Utility.RandomInt(2,8)
		iNumSpiderEggs = StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount") - iNumSpiderEggsRemoved

		if (iNumSpiderEggs < 0) || (_args == "All") || (bHarvestParasite)
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
			else
				PlayerActor.AddItem(SmallSpiderEgg,iNumSpiderEggsRemoved)
			Endif
		elseif (_args == "None") 
			If (kActor == PlayerActor)
				SpiderEggInfectedAlias.ForceRefTo(DummyAlias)
			endIf
			; clear parasite only - no harvest - for use with birth scene
			iNumSpiderEggs = 0
			StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", 0 )

			kActor.DispelSpell(StomachRot)

			StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 0)
			clearParasiteNPCByString (kActor, "SpiderEgg")
			
		else
			debug.notification("Some eggs detached from the cluster... more remain inside you.")
			PlayerActor.AddItem(SmallSpiderEgg,iNumSpiderEggsRemoved)
		Endif

		fctUtils.ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" ) )
 
		StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )
		SendModEvent("SLPSpiderEggInfection")
	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 0)
	EndIf
EndFunction


;------------------------------------------------------------------------------
Bool Function infectSpiderPenis( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderPenis" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "SpiderPenis" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "PlugVaginal"  ))
		Debug.Trace("[SLP]	Already wearing a vaginal plug - Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif

	equipParasiteNPCByString (kActor, "SpiderPenis")

	Return true ; Return applySpiderPenis( kActor  )
EndFunction

Bool Function applySpiderPenis( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()
  	Int iNumSpiderEggs

	iNumSpiderEggs = Utility.RandomInt(5,10)

	If (kActor == PlayerActor)
		SpiderEggInfectedAlias.ForceRefTo(PlayerActor)
	endIf
	if (iNumSpiderEggs>=4)
		StomachRot.RemoteCast(kActor as ObjectReference, kActor,kActor as ObjectReference)
	endIf

	fctUtils.ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" ) )

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

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
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
Bool Function infectChaurusWorm( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "ChaurusWorm" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "PlugAnal"  ))
		Debug.Trace("[SLP]	Already wearing an anal plug - Aborting")
		Return False
	Endif

	equipParasiteNPCByString (kActor, "ChaurusWorm")

	Return true ; Return applyChaurusWorm( kActor  )

EndFunction

Bool Function applyChaurusWorm( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
		ChaurusWormInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	fctUtils.ApplyBodyChange( kActor, "ChaurusWorm", "Butt", 1.5, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

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

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
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
		fctUtils.ApplyBodyChange( kActor, "ChaurusWorm", "Butt", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

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
Bool Function infectChaurusWormVag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWormVag", 0 )
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "ChaurusWormVag" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "PlugVaginal"  ))
		Debug.Trace("[SLP]	Already wearing a vaginal plug - Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	
	equipParasiteNPCByString (kActor, "ChaurusWormVag")

	Return true ; Return applyChaurusWormVag( kActor  )

EndFunction

Bool Function applyChaurusWormVag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
		ChaurusWormInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	fctUtils.ApplyBodyChange( kActor, "ChaurusWormVag", "Belly", 1.5, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

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

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
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
		fctUtils.ApplyBodyChange( kActor, "ChaurusWormVag", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

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
Bool Function infectEstrusTentacles( Actor kActor  )
  	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusTentacles" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
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
		Debug.Trace("[SLP]Estrust Tentacles / Tentacle Monster infection failed")
		Debug.Trace("[SLP]  Vaginal Plug: " + ActorHasKeywordByString(kActor,  "PlugVaginal"))
		Debug.Trace("[SLP]  TentacleMonster: " + isInfectedByString( kActor,  "TentacleMonster" ))
		Debug.Trace("[SLP]  Chance infection: " + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceTentacleMonster" ))
	EndIf

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap, PlayerActor)             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kActor)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, 0)    			; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
	else
		triggerFuroTub( PlayerActor, "")

	endif

	Return applyEstrusTentacles( kActor  )
EndFunction

Bool Function applyEstrusTentacles( Actor kActor  )
  	Actor PlayerActor = Game.GetPlayer()
 
	If !StorageUtil.HasIntValue(kActor, "_SLP_iEstrusTentaclesInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iEstrusTentaclesInfections",  0)
	EndIf

	; StorageUtil.SetIntValue(kActor, "_SLP_toggleEstrusTentacle", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusTentaclesDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusTentaclesInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iEstrusTentaclesInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numEstrusTentaclesInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iEstrusTentaclesInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPEstrusTentaclesInfection")


	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

;------------------------------------------------------------------------------
Bool Function infectTentacleMonster( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 0 )
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceTentacleMonster" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If ((isInfectedByString( kActor,  "LivingArmor" )) || (isInfectedByString( kActor,  "Barnacles" )) || (isInfectedByString( kActor,  "FaceHugger" )) || (isInfectedByString( kActor,  "TentacleMonster" )) || (isInfectedByString( kActor,  "ChaurusQueenSkin" )) || (isInfectedByString( kActor,  "ChaurusQueenArmor" )) || (isInfectedByString( kActor,  "ChaurusQueenBody" )) )
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "Harness"  ))
		Debug.Trace("[SLP]	Already wearing a harness- Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	
	equipParasiteNPCByString (kActor, "TentacleMonster")

	Return true ; Return applyTentacleMonster( kActor  )

EndFunction

Bool Function applyTentacleMonster( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

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

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
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
		fctUtils.ApplyBodyChange( kActor, "TentacleMonster", "Breast", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxTentacleMonster" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessTentacleMonsterInventory,1)
		Endif

		If (kActor == PlayerActor)
			TentacleMonsterInfectedAlias.ForceRefTo(DummyAlias)
		endIf

		TentacleMonsterQuest.Stop()

		if (!KynesBlessingQuest.GetStageDone(60)) && (kActor == PlayerActor)
			KynesBlessingQuest.SetStage(60)
		endif

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 0)
	EndIf
EndFunction

;------------------------------------------------------------------------------
Bool Function infectEstrusSlime( Actor kActor  )
  	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusSlime" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
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
		Debug.Trace("[SLP]Estrust Slime infection failed")
		Debug.Trace("[SLP]  Harness: " + ActorHasKeywordByString(kActor,  "Harness"))
		Debug.Trace("[SLP]  LivingArmor: " + isInfectedByString( kActor,  "LivingArmor" ))
		Debug.Trace("[SLP]  Chance infection: " + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceLivingArmor" ))
	EndIf

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap, PlayerActor)             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kActor)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, Utility.randomInt(2,3))    	; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
	else
		triggerFuroTub( PlayerActor, "")

	endif

	Return applyEstrusSlime( kActor  )
EndFunction

Bool Function applyEstrusSlime( Actor kActor  )
  	Actor PlayerActor = Game.GetPlayer()
 
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

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPEstrusSlimeInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True

EndFunction

;------------------------------------------------------------------------------
Bool Function infectLivingArmor( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleLivingArmor", 0 )
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceLivingArmor" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If ((isInfectedByString( kActor,  "LivingArmor" )) || (isInfectedByString( kActor,  "Barnacles" )) || (isInfectedByString( kActor,  "FaceHugger" )) || (isInfectedByString( kActor,  "TentacleMonster" )) || (isInfectedByString( kActor,  "ChaurusQueenSkin" )) || (isInfectedByString( kActor,  "ChaurusQueenArmor" )) || (isInfectedByString( kActor,  "ChaurusQueenBody" )) )		
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "Harness"  ))
		Debug.Trace("[SLP]	Already wearing a corset - Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	

	equipParasiteNPCByString (kActor, "LivingArmor")

	Return true ; Return applyLivingArmor( kActor  )
EndFunction

Bool Function applyLivingArmor( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()
 
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

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
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
		fctUtils.ApplyBodyChange( kActor, "LivingArmor", "Breast", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxLivingArmor" ))

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
Bool Function infectFaceHugger( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHugger" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If ((isInfectedByString( kActor,  "LivingArmor" )) || (isInfectedByString( kActor,  "Barnacles" )) || (isInfectedByString( kActor,  "FaceHugger" )) || (isInfectedByString( kActor,  "TentacleMonster" )) || (isInfectedByString( kActor,  "ChaurusQueenSkin" )) || (isInfectedByString( kActor,  "ChaurusQueenArmor" )) || (isInfectedByString( kActor,  "ChaurusQueenBody" )) )

		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "Belt"  ))
		Debug.Trace("[SLP]	Already wearing a belt - Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif

	equipParasiteNPCByString (kActor, "FaceHugger")

	Return true ; Return applyFaceHugger( kActor  )
EndFunction

Bool Function applyFaceHugger( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

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

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
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
		fctUtils.ApplyBodyChange( kActor, "FaceHugger", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessFaceHuggerInventory,1)
		Endif

		If (kActor == PlayerActor) && !(isInfectedByString( kActor,  "FaceHuggerGag" ))
			FaceHuggerInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 0)
	EndIf
EndFunction

;------------------------------------------------------------------------------
Bool Function infectFaceHuggerGag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHuggerGag" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "FaceHuggerGag" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "Gag"  ))
		Debug.Trace("[SLP]	Already wearing a gag - Aborting")
		Return False
	Endif

	equipParasiteNPCByString (kActor, "FaceHuggerGag")

	Return  applyFaceHuggerGag( kActor )
EndFunction

Bool Function applyFaceHuggerGag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
		FaceHuggerInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iFaceHuggerInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerGagDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerGagInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerGagInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numFaceHuggerInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerGagInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPFaceHuggerGagInfection")

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
		fctUtils.ApplyBodyChange( kActor, "FaceHugger", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ))

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
Bool Function infectBarnacles( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEggBarnacles", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf

	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceBarnacles" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If ((isInfectedByString( kActor,  "LivingArmor" )) || (isInfectedByString( kActor,  "Barnacles" )) || (isInfectedByString( kActor,  "FaceHugger" )) || (isInfectedByString( kActor,  "TentacleMonster" )) || (isInfectedByString( kActor,  "ChaurusQueenSkin" )) || (isInfectedByString( kActor,  "ChaurusQueenArmor" )) || (isInfectedByString( kActor,  "ChaurusQueenBody" )) )
		Return False
	Endif

	If ((ActorHasKeywordByString( kActor, "Harness"  )) || (ActorHasKeywordByString( kActor, "Corset"  )) )
		Debug.Trace("[SLP]	Already wearing a corset - Aborting")
		Return False
	Endif


	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	

	equipParasiteNPCByString (kActor, "Barnacles")

	Return true ; Return applyBarnacles( kActor  )
EndFunction

Bool Function applyBarnacles( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

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

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0) 
 
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
Function applyBaseChaurusQueenSkin()
 	Actor PlayerActor = Game.GetPlayer()
	ActorBase pActorBase = PlayerActor.GetActorBase()
	ActorBase pLeveledActorBase = PlayerActor.GetLeveledActorBase()
	Float fWeightOrig = pActorBase.GetWeight()
	Float fWeight
	Float NeckDelta

	pLeveledActorBase.SetWeight(fWeightOrig)
	pLeveledActorBase.SetSkin(_SLP_skinChaurusQueenNaked)
	; fWeight = pLeveledActorBase.GetWeight()
	; NeckDelta = (fWeightOrig / 100) - (fWeight / 100)
	; PlayerActor.UpdateWeight(NeckDelta) ;Apply the changes.


EndFunction


;------------------------------------------------------------------------------
Bool Function infectChaurusQueenVag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenVag", 0 )
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenVag" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "ChaurusQueenVag" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "PlugVaginal"  ))
		Debug.Trace("[SLP]	Already wearing a vaginal plug - Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif

	SeedFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
	equipParasiteNPCByString (kActor, "ChaurusQueenVag")

	Return true ; Return applyChaurusWormVag( kActor  )

EndFunction

Bool Function applyChaurusQueenVag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
	;	ChaurusQueenInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	; fctUtils.ApplyBodyChange( kActor, "ChaurusQueenVag", "Belly", 1.5, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusQueenVagInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenVagInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenVag", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenVagDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenVagInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenVagInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		; _SLP_GV_numChaurusWormVagInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenVagInfections"))
	endIf

	applyBaseChaurusQueenSkin()

	if (StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")<2)
		StorageUtil.SetIntValue(PlayerActor, "_SLP_iChaurusQueenStage",  2)
	endif

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPChaurusQueenVagInfection")

	; if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
	;	KynesBlessingQuest.SetStage(20)
	; endif
	
	Return True
EndFunction

Function cureChaurusQueenVag( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "ChaurusQueenVag" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenVag", 0)
		clearParasiteNPCByString (kActor, "ChaurusQueenVag")
		; fctUtils.ApplyBodyChange( kActor, "ChaurusQueenVag", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_plugChaurusQueenVagInventory,1)
		Endif

		If (kActor == PlayerActor)
		;	ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenVag", 0)
	EndIf
EndFunction


;------------------------------------------------------------------------------
Bool Function infectChaurusQueenGag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenGag", 0 )

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenGag" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (isInfectedByString( kActor,  "ChaurusQueenGag" ))
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If (ActorHasKeywordByString( kActor, "Gag"  ))
		Debug.Trace("[SLP]	Already wearing a gag - Aborting")
		Return False
	Endif

	SeedFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
	equipParasiteNPCByString (kActor, "ChaurusQueenGag")

	Return  true; applyFaceHuggerGag( kActor )
EndFunction

Bool Function applyChaurusQueenGag( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
	;	ChaurusQueenInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusQueenGagInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenGagInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenGag", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenGagDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenGagInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenGagInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		; _SLP_GV_numFaceHuggerInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenGagInfections"))
	endIf

	applyBaseChaurusQueenSkin()

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPChaurusQueenGagInfection")

	; if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
	;	KynesBlessingQuest.SetStage(20)
	; endif
	
	Return True
EndFunction

Function cureChaurusQueenGag( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
  	
	If (isInfectedByString( kActor,  "ChaurusQueenGag" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenGag", 0 )
		clearParasiteNPCByString (kActor, "ChaurusQueenGag")
		; fctUtils.ApplyBodyChange( kActor, "FaceHugger", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_gagChaurusQueenInventory,1)
		Endif

		If (kActor == PlayerActor) && !(isInfectedByString( kActor,  "ChaurusQueenGag" ))
		;	ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
		endIf


	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenGag", 0)
	EndIf
EndFunction



;------------------------------------------------------------------------------
Bool Function infectChaurusQueenSkin( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenSkin", 0 )
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenSkin" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If ((isInfectedByString( kActor,  "LivingArmor" )) || (isInfectedByString( kActor,  "Barnacles" )) || (isInfectedByString( kActor,  "FaceHugger" )) || (isInfectedByString( kActor,  "TentacleMonster" )) || (isInfectedByString( kActor,  "ChaurusQueenSkin" )) || (isInfectedByString( kActor,  "ChaurusQueenArmor" )) || (isInfectedByString( kActor,  "ChaurusQueenBody" )) )
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If ( (ActorHasKeywordByString( kActor, "Harness"  )) || (ActorHasKeywordByString( kActor, "Bra"  )))
		Debug.Trace("[SLP]	Already wearing a harness- Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	
	SeedFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
	equipParasiteNPCByString (kActor, "ChaurusQueenSkin")

	Return true ; Return applyChaurusQueenSkin( kActor  )

EndFunction

Bool Function applyChaurusQueenSkin( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
	;	ChaurusQueenInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusQueenSkinInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenSkinInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenSkin", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenSkinDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenSkinInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenSkinInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		; _SLP_GV_numChaurusQueenSkinInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenSkinInfections"))
	endIf

	applyBaseChaurusQueenSkin()

	if (StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")<3)
		StorageUtil.SetIntValue(PlayerActor, "_SLP_iChaurusQueenStage",  3)
	endif

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPChaurusQueenSkinInfection")

	if (!QueenOfChaurusQuest.GetStageDone(300)) && (kActor == PlayerActor)
		QueenOfChaurusQuest.SetStage(300)
	endif
	
	Return True
EndFunction

Function cureChaurusQueenSkin( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "ChaurusQueenSkin" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenSkin", 0 )
		clearParasiteNPCByString (kActor, "ChaurusQueenSkin")
		; fctUtils.ApplyBodyChange( kActor, "ChaurusQueenSkin", "Breast", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxChaurusQueenSkin" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessChaurusQueenSkinInventory,1)
		Endif

		If (kActor == PlayerActor)
		;	ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenSkin", 0)
	EndIf
EndFunction


;------------------------------------------------------------------------------
Bool Function infectChaurusQueenArmor( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenArmor", 0 )
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenArmor" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If ((isInfectedByString( kActor,  "LivingArmor" )) || (isInfectedByString( kActor,  "Barnacles" )) || (isInfectedByString( kActor,  "FaceHugger" )) || (isInfectedByString( kActor,  "TentacleMonster" )) || (isInfectedByString( kActor,  "ChaurusQueenSkin" )) || (isInfectedByString( kActor,  "ChaurusQueenArmor" )) || (isInfectedByString( kActor,  "ChaurusQueenBody" )) )
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If ( (ActorHasKeywordByString( kActor, "Harness"  )) || (ActorHasKeywordByString( kActor, "Bra"  )))
		Debug.Trace("[SLP]	Already wearing a harness- Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	
	SeedFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
	equipParasiteNPCByString (kActor, "ChaurusQueenArmor")

	Return true ; Return applyChaurusQueenArmor( kActor  )

EndFunction

Bool Function applyChaurusQueenArmor( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

	If (kActor == PlayerActor)
		if (QueenOfChaurusQuest.GetStageDone(395)) && (!QueenOfChaurusQuest.GetStageDone(400)) 
			; Do nothing - Queen privileges are suspended
			ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
		else
			ChaurusQueenInfectedAlias.ForceRefTo(PlayerActor)
		endif
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusQueenArmorInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenArmorInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenArmor", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenArmorDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenArmorInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenArmorInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		; _SLP_GV_numChaurusQueenArmorInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenArmorInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	applyBaseChaurusQueenSkin()

	if (StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")<4)
		StorageUtil.SetIntValue(PlayerActor, "_SLP_iChaurusQueenStage",  4)
	endif

	SendModEvent("SLPChaurusQueenArmorInfection")

	; if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
	; 	KynesBlessingQuest.SetStage(20)
	; endif
	
	Return True
EndFunction

Function cureChaurusQueenArmor( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "ChaurusQueenArmor" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenArmor", 0 )
		clearParasiteNPCByString (kActor, "ChaurusQueenArmor")
		; fctUtils.ApplyBodyChange( kActor, "ChaurusQueenArmor", "Breast", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxChaurusQueenArmor" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessChaurusQueenArmorInventory,1)
		Endif

		If (kActor == PlayerActor)
			ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenArmor", 0)
	EndIf
EndFunction



;------------------------------------------------------------------------------
Bool Function infectChaurusQueenBody( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()

 	; Setting toggle back to 0 in case equip fails - the 'apply' function sets it to 1 if it succeeds
	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenBody", 0 )
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusQueenBody" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If ((isInfectedByString( kActor,  "LivingArmor" )) || (isInfectedByString( kActor,  "Barnacles" )) || (isInfectedByString( kActor,  "FaceHugger" )) || (isInfectedByString( kActor,  "TentacleMonster" )) || (isInfectedByString( kActor,  "ChaurusQueenSkin" )) || (isInfectedByString( kActor,  "ChaurusQueenArmor" )) || (isInfectedByString( kActor,  "ChaurusQueenBody" )) )
		Debug.Trace("[SLP]	Already infected - Aborting")
		Return False
	Endif

	If ( (ActorHasKeywordByString( kActor, "Harness"  )) || (ActorHasKeywordByString( kActor, "Bra"  )))
		Debug.Trace("[SLP]	Already wearing a harness- Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	
	SeedFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
	equipParasiteNPCByString (kActor, "ChaurusQueenBody")

	Return true ; Return applyChaurusQueenBody( kActor  )

EndFunction

Bool Function applyChaurusQueenBody( Actor kActor  )
 	Actor PlayerActor = Game.GetPlayer()
 	ObjectReference PlayerActorRef = PlayerActor as ObjectReference
 	Potion DragonWingsPotion = None 

	If (kActor == PlayerActor)
		if (QueenOfChaurusQuest.GetStageDone(395)) && (!QueenOfChaurusQuest.GetStageDone(400)) 
			; Do nothing - Queen privileges are suspended
			ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
		else
			ChaurusQueenInfectedAlias.ForceRefTo(PlayerActor)
		endif
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusQueenBodyInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenBodyInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenBody", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenBodyDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusQueenBodyInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenBodyInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		; _SLP_GV_numChaurusQueenBodyInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenBodyInfections"))
	endIf

	applyBaseChaurusQueenSkin()

	debug.trace("[SLP]   Checking for Animated Wings " )
	debug.trace("[SLP]      _SLP_autoRemoveWings: " + StorageUtil.GetIntValue(none, "_SLP_autoRemoveWings" ))
	debug.trace("[SLP]      _SLP_AnimatedWingsEquipped: " + StorageUtil.GetIntValue(none, "_SLP_AnimatedWingsEquipped" ))

	if (StorageUtil.GetIntValue(none, "_SLP_AnimatedWingsEquipped")==0)
		if (StorageUtil.GetIntValue(none, "_SLP_isAnimatedWingsUltimate")==1) 
			DragonWingsPotion = StorageUtil.GetFormValue(none, "_SLS_getAnimatedWingsUltimatePotion") as Potion
			debug.trace("[SLP]   Real Flying Potion: " + DragonWingsPotion)
			PlayerActorRef.AddItem(DragonWingsPotion, 1, true)
			PlayerActor.EquipItem(DragonWingsPotion,abPreventRemoval = false, abSilent = true)
			StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 1 )
			
		elseif (StorageUtil.GetIntValue(none, "_SLP_isRealFlying")==1) 
			DragonWingsPotion = StorageUtil.GetFormValue(none, "_SLS_getRealFlyingPotion") as Potion
			debug.trace("[SLP]   Real Flying Potion: " + DragonWingsPotion)
			PlayerActorRef.AddItem(DragonWingsPotion, 1, true)
			PlayerActor.EquipItem(DragonWingsPotion,abPreventRemoval = false, abSilent = true)
			StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 1 )
			
		elseif (StorageUtil.GetIntValue(none, "_SLP_isAnimatedDragonWings")==1) 
			DragonWingsPotion = StorageUtil.GetFormValue(none, "_SLS_getDragonWingsPotion") as Potion
			debug.trace("[SLP]   Dragon Wings Friendly Potion: " + DragonWingsPotion)
			PlayerActorRef.AddItem(DragonWingsPotion, 1, true)
			PlayerActor.EquipItem(DragonWingsPotion,abPreventRemoval = false, abSilent = true)
			StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 1 )
			
		endif
	endif

	if (StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")<5)
		StorageUtil.SetIntValue(PlayerActor, "_SLP_iChaurusQueenStage",  5)
	endif

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPChaurusQueenBodyInfection")

	; if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
	;	KynesBlessingQuest.SetStage(20)
	; endif
	
	Return True
EndFunction

Function cureChaurusQueenBody( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()
 	ObjectReference PlayerActorRef = PlayerActor as ObjectReference
 	Potion DragonWingsCurePotion = None

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (isInfectedByString( kActor,  "ChaurusQueenBody" ))
		debug.trace("[SLP]   Checking for Animated Wings " )
		debug.trace("[SLP]      _SLP_autoRemoveWings: " + StorageUtil.GetIntValue(none, "_SLP_autoRemoveWings" ))
		debug.trace("[SLP]      _SLP_AnimatedWingsEquipped: " + StorageUtil.GetIntValue(none, "_SLP_AnimatedWingsEquipped" ))

		if (StorageUtil.GetIntValue(none, "_SLP_autoRemoveWings" )==1) && (StorageUtil.GetIntValue(none, "_SLP_AnimatedWingsEquipped")==1)
			
			debug.trace("[SLP]   Removing Animated Wings " )

			if (StorageUtil.GetIntValue(none, "_SLP_isAnimatedWingsUltimate")==1)
				DragonWingsCurePotion = StorageUtil.GetFormValue(none, "_SLS_getAnimatedWingsUltimateCurePotion") as Potion
				debug.trace("[SLP]   Real Flying Cure Potion: " + DragonWingsCurePotion)
				PlayerActorRef.AddItem(DragonWingsCurePotion, 1, true)
				PlayerActor.EquipItem(DragonWingsCurePotion,abPreventRemoval = false, abSilent = true)
				StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 0 )
				
			elseif (StorageUtil.GetIntValue(none, "_SLP_isRealFlying")==1)
				DragonWingsCurePotion = StorageUtil.GetFormValue(none, "_SLS_getRealFlyingCurePotion") as Potion
				debug.trace("[SLP]   Real Flying Cure Potion: " + DragonWingsCurePotion)
				PlayerActorRef.AddItem(DragonWingsCurePotion, 1, true)
				PlayerActor.EquipItem(DragonWingsCurePotion,abPreventRemoval = false, abSilent = true)
				StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 0 )
				
			elseif (StorageUtil.GetIntValue(none, "_SLP_isAnimatedDragonWings")==1) 
				DragonWingsCurePotion = StorageUtil.GetFormValue(none, "_SLS_getDragonWingsDispelPotion"  ) as Potion
				debug.trace("[SLP]   Dragon Wings Cure Potion: " + DragonWingsCurePotion)
				PlayerActorRef.AddItem(DragonWingsCurePotion, 1, true)
				PlayerActor.EquipItem(DragonWingsCurePotion,abPreventRemoval = false, abSilent = true)
				StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 0 )
				
			endif
		endif

		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenBody", 0 )
		clearParasiteNPCByString (kActor, "ChaurusQueenBody")
		; fctUtils.ApplyBodyChange( kActor, "ChaurusQueenBody", "Breast", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxChaurusQueenBody" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessChaurusQueenBodyInventory,1)
		Endif

		If (kActor == PlayerActor)
			ChaurusQueenInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	Else
		; Reset variables if called after device is removed
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusQueenBody", 0)
	EndIf
EndFunction

;------------------------------------------------------------------------------
Bool Function infectEstrusChaurusEgg( Actor kActor, Bool bSilent )
  	Actor PlayerActor = Game.GetPlayer()
  	Int iAnimation = -1

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	
	if (!bSilent)
		iAnimation = 0
	Endif

	; If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusChaurusEgg" )==0.0)
	;	Debug.Trace("		Parasite disabled - Aborting")
	;	Return
	; Endif

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap,PlayerActor)             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kActor)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, iAnimation)    	; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
	Else
		Debug.Trace("[SLP]Estrus Chaurus Egg infection failed")
		triggerFuroTub( PlayerActor, "")
	endif

	Return applyEstrusChaurusEgg( kActor  )

EndFunction

Bool Function applyEstrusChaurusEgg( Actor kActor  )
  	Actor PlayerActor = Game.GetPlayer()

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
Function displayChaurusSpawnList()
	int valueCount = StorageUtil.FormListCount(none, "_SLP_lChaurusSpawnsList")
	int i = 0
	Form thisActorForm
 
 	debug.trace("[SLP] displayChaurusSpawnList (" + valueCount + " actors)")

	while(i < valueCount)
		thisActorForm = StorageUtil.FormListGet(none, "_SLP_lChaurusSpawnsList", i)

		if (thisActorForm==None)
			Debug.Trace("	Actor [" + i + "] = "+ thisActorForm )
		else
			Debug.Trace("	Actor [" + i + "] = "+ thisActorForm +" - " + thisActorForm.GetName())
		endif

		; if (StorageUtil.FormListFind( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form) <0)
		;	StorageUtil.FormListAdd( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form )
		; endif

		i += 1
	endwhile
EndFunction

Function cleanChaurusSpawnList()
	int valueCount = StorageUtil.FormListCount(none, "_SLP_lChaurusSpawnsList")
	int i = 0
	Form thisActorForm
	Actor thisActor
 	ObjectReference thisActorRef
 
 	debug.trace("[SLP] cleanChaurusSpawnList (" + valueCount + " actors)")

	while(i < valueCount)
		thisActorForm = StorageUtil.FormListGet(none, "_SLP_lChaurusSpawnsList", i)

		if (thisActorForm==None)
			Debug.Trace("	Actor [" + i + "] = "+ thisActorForm )
		else
			Debug.Trace("	Actor [" + i + "] = "+ thisActorForm +" - " + thisActorForm.GetName())

			thisActor = thisActorForm as Actor
			thisActorRef = thisActor as ObjectReference

			if (thisActor.IsDead()) || (thisActorRef.IsDisabled())
				StorageUtil.FormListSet(none, "_SLP_lChaurusSpawnsList", i, None)
			endif
		endif


		; if (StorageUtil.FormListFind( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form) <0)
		;	StorageUtil.FormListAdd( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form )
		; endif

		i += 1
	endwhile

	valueCount = StorageUtil.FormListCount(none, "_SLP_lChaurusSpawnsList")
 	debug.trace("[SLP] cleanChaurusSpawnList (" + valueCount + " actors) after clean up ")

EndFunction


Actor Function getRandomChaurusSpawn(Actor kActor)
	Actor kPlayer = Game.Getplayer()
	ObjectReference kActorRef = kPlayer as ObjectReference
	Actor kChaurusSpawn
	ActorBase ChaurusSpawnActorBase
 	Int iChaurusSpawnLevel
	Int iRandomNum = utility.randomint(0,100)
	ObjectReference arPortal  
    Float afDistance = 150.0
    Float afZOffset = 0.0

	if (iRandomNum>90)
		ChaurusSpawnActorBase = EncChaurusHunterActor.GetBaseObject() as ActorBase
		iChaurusSpawnLevel = 4
	elseif (iRandomNum>60)
		ChaurusSpawnActorBase = EncChaurusSpawnActor.GetBaseObject() as ActorBase
		iChaurusSpawnLevel = 3
	else
		ChaurusSpawnActorBase = EncChaurusFledgelingActor.GetBaseObject() as ActorBase
		iChaurusSpawnLevel = 2
	endif

	arPortal = kActorRef.PlaceAtMe(Game.GetFormFromFile(0x000EBEB5, "Skyrim.ESM")) ; FXNecroTendrilRing 

	arPortal.MoveTo(kActorRef, Math.Sin(kActorRef.GetAngleZ()) * afDistance, Math.Cos(kActorRef.GetAngleZ()) * afDistance, afZOffset)
    SummonSoundFX.Play(kPlayer as ObjectReference)
	Utility.Wait(0.6)

	kChaurusSpawn = kActorRef.PlaceActorAtMe(ChaurusSpawnActorBase, iChaurusSpawnLevel)
	Utility.Wait(0.6)

	arPortal.MoveTo(kActorRef)
	Utility.Wait(0.6)

	arPortal.disable()
	return kChaurusSpawn
EndFunction

Function getRandomChaurusEggs(Actor kActor, int iMinEggs = 0, int iMaxEggs = 20 )
	Int iRandomNum = utility.randomint(iMinEggs,iMaxEggs)

	kActor.AddItem(ChaurusEgg, iRandomNum)
EndFunction


;------------------------------------------------------------------------------
Function triggerEstrusChaurusBirth( Actor kActor, String  sParasite, Int iBirthItemCount  )
  	ObjectReference PlayerRef = Game.GetPlayer()
  	Actor PlayerActor = PlayerRef as Actor
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

	ElseIf (sParasite == "ChaurusEgg")
		fBirthItem = ChaurusEgg as Form

	ElseIf (sParasite == "ChaurusWorm")
		fBirthItem = IngredientChaurusWorm as Form

	ElseIf (sParasite == "ChaurusWormVag")
		fBirthItem = IngredientChaurusWorm as Form

	ElseIf (sParasite == "Barnacles")
		fBirthItem = BarnaclesCluster as Form

	Endif

	Debug.Trace("[SLP] triggerEstrusChaurusBirth - Actor: " + kActor)
	Debug.Trace("[SLP] 		sParasite: " + sParasite)
	Debug.Trace("[SLP] 		fBirthItem: " + fBirthItem)
	Debug.Trace("[SLP] 		iBirthItemCount: " + iBirthItemCount)

	If (fBirthItem != None)
		; Testing EC birth event
		;To call an EC Birth event use the following code:
		;
		int ECBirth = ModEvent.Create("ECGiveBirth") ; Int          Int does not have to be named "ECBirth" any name would do
		if (ECBirth) && (!(fctUtils.isPregnantByEstrusChaurus( kActor)))
			Debug.Trace("[SLP] 		EC event detected - ECBirth")
		    ModEvent.PushForm(ECBirth, self)         ; Form         Pass the calling form to the event

		    ModEvent.PushForm(ECBirth, kActor)      ; Form         The Actor to give birth
		    ModEvent.PushForm(ECBirth, fBirthItem) ; Form    The Item to give birth to - if push None births Chaurus eg
		    ModEvent.PushInt(ECBirth, iBirthItemCount)            ; Int    The number of Items to give birth too
		    ModEvent.Send(ECBirth)
		else
			Debug.Trace("[SLP] 		Fallback animation")
		    ;EC is not installed
            Debug.SendAnimationEvent(PlayerRef, "bleedOutStart")
            utility.wait(4)
            Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
		    PlayerRef.PlaceAtMe(fBirthItem, iBirthItemCount)
		endIf
		;
		;   **NB** The birth event will not fire if the actor is already infected with the Chaurus Parasite effect
		;               This birth event is unaware of calling mods effects on Breast/Belly/Butt nodes - Any changes to
		;               inflation of these nodes at birth must be handled by the calling mod.
	Endif

EndFunction

;------------------------------------------------------------------------------
Function triggerFuroTub( Actor kActor, String  sParasite)
  	Actor PlayerActor = Game.GetPlayer()
  	Form fBirthItem = None

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf

	_SLP_GV_ZAPFuroTubOn.SetValue(1)
	 
	PlayerActor.EvaluatePackage()

	Utility.Wait(10.0)

	_SLP_GV_ZAPFuroTubOn.SetValue(0)

EndFunction


;------------------------------------------------------------------------------
Bool Function tryParasiteNextStage(Actor kActor, String sParasite)
 	Actor PlayerActor = Game.GetPlayer()
  	ObjectReference PlayerRef = Game.GetPlayer()
 	Bool bSuccess = False
 	Int iChaurusQueenStage = StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")
 	Int iChaurusEggsCount = PlayerActor.GetItemCount(ChaurusEgg)

 	If (kActor == PlayerActor)
 		If (PlayerActor.IsBleedingOut() || PlayerActor.IsDead() || PlayerActor.IsOnMount() || PlayerActor.IsFlying() || PlayerActor.IsUnconscious() || !Game.IsActivateControlsEnabled() || SexLab.IsActorActive(PlayerActor) )
 			debug.trace("[SLP] tryParasiteNextStage failed  " )
 			;debug.notification("[SLP]    Player is busy " )
 			debug.trace("[SLP]    Player is busy " )
 			debug.trace("[SLP]     IsBleedingOut: " + PlayerActor.IsBleedingOut()  )
 			debug.trace("[SLP]     IsDead: " + PlayerActor.IsDead()  )
 			debug.trace("[SLP]     IsOnMount: " + PlayerActor.IsOnMount()  )
 			debug.trace("[SLP]     IsFlying: " + PlayerActor.IsFlying()  )
 			debug.trace("[SLP]     IsUnconscious: " + PlayerActor.IsUnconscious()  )
 			debug.trace("[SLP]     Game.IsActivateControlsEnabled: " + Game.IsActivateControlsEnabled() )
 			debug.trace("[SLP]     SexLab.IsActorActive: " + SexLab.IsActorActive(PlayerActor) )
			Return bSuccess; Player is busy - try again later
 		Endif

		If (sParasite == "ChaurusQueen") && (QueenOfChaurusQuest.GetStageDone(290) && (!QueenOfChaurusQuest.GetStageDone(400)) )
			Int itriggerNextStageChaurusQueen = StorageUtil.GetIntValue(kActor, "_SLP_triggerNextStageChaurusQueen") +  (iChaurusQueenStage * 10)
			debug.trace("[SLP]    itriggerNextStageChaurusQueen = " + itriggerNextStageChaurusQueen)

			if (Utility.RandomInt(0,100) < itriggerNextStageChaurusQueen) 
				; INCUBATION 
				If (isInfectedByString( kActor,  "Barnacles" ))
					; SeedFlare.RemoteCast(kActor as ObjectReference, kActor,kActor as ObjectReference)		
					SeedFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
					debug.trace("[SLP]    Effect - cure Barnacles")
					debug.Notification("The Seed inside you flushes the barnacles away from your skin.")
					cureBarnacles( kActor  )
					bSuccess = True

				endif 

				If (!isInfectedByString( kActor,  "ChaurusQueenVag" )) && (Utility.RandomInt(0,100)<60)
					debug.trace("[SLP]    Effect - add Chaurus Queen Vag")
					if (iChaurusQueenStage==1)
						; First time: stage = 1
						debug.MessageBox("The Seed stirs through your womb and extends a tentacle between your legs.")
					else
						; Stage >= 2
						debug.Notification("The Seed stirs through your womb and extends a tentacle between your legs.")
					endif
					infectChaurusQueenVag( kActor  ) 
					bSuccess = True
					
				elseIf (isInfectedByString( kActor,  "ChaurusQueenVag" )) && (Utility.RandomInt(0,100)<40)
					debug.trace("[SLP]    Effect - cure Chaurus Queen Vag")
					debug.Notification("The tentacle receeds to the Seed inside your womb.")
					cureChaurusQueenVag( kActor  )
					bSuccess = True

				endif 
				
				If (!isInfectedByString( kActor,  "ChaurusQueenSkin" )) && (Utility.RandomInt(0,100)<80) && (iChaurusQueenStage>=2)
					debug.trace("[SLP]    Effect - add Chaurus Queen Skin")
					if (iChaurusQueenStage==2)
						; First time: stage = 2
						debug.MessageBox("The Seed flares up through your skin and your breasts.")
					else
						; Stage >= 3
						debug.Notification("The Seed flares up through your skin and your breasts.")
					endif
					infectChaurusQueenSkin( kActor  )
					bSuccess = True
					
				elseIf (isInfectedByString( kActor,  "ChaurusQueenSkin" )) && (Utility.RandomInt(0,100)<40)
					debug.trace("[SLP]    Effect - cure Chaurus Queen Skin")
					debug.Notification("The feelers in your breasts receed inside.")
					cureChaurusQueenSkin( kActor  )
					bSuccess = True
					
				else
					SeedFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
					debug.trace("[SLP]    Effect - cramps")
					debug.Notification("Sudden cramps flare up inside you.")
					bSuccess = True

				endif

				; check if player reached the Spider stage of the Chaurus Queen tranformation
				tryPlayerSpiderStage()

				; producing new eggs as a queen - revisit later
				; decrease chance of eggs with number of days since last sex with chaurus
				if (iChaurusQueenStage>=3) && (QueenOfChaurusQuest.GetStageDone(400)) && (Utility.RandomInt(0,100)<10)
				 	if (iChaurusEggsCount>5)
				 		triggerEstrusChaurusBirth(  kActor, "ChaurusEgg", 5  )
				 	elseif (iChaurusEggsCount>0)
				 		triggerEstrusChaurusBirth(  kActor, "ChaurusEgg", iChaurusEggsCount  )
				 	endif
				 	
				endif

				; HEAT

				StorageUtil.SetIntValue(kActor, "_SLP_triggerNextStageChaurusQueen", iChaurusQueenStage * 10)
			else
 				debug.trace("[SLP] tryParasiteNextStage failed  " )
 				debug.trace("[SLP]    Bad luck - try again later : " + itriggerNextStageChaurusQueen)

				itriggerNextStageChaurusQueen = itriggerNextStageChaurusQueen +  (iChaurusQueenStage * 10)
				StorageUtil.SetIntValue(kActor, "_SLP_triggerNextStageChaurusQueen",itriggerNextStageChaurusQueen)
			endif

		ElseIf (sParasite == "SpiderPenis")  
			Debug.MessageBox("The remains of the spider penis finally slide out of you.")
			; PlayerActor.SendModEvent("SLPCureSpiderPenis")
			cureSpiderPenis( PlayerActor   )
			bSuccess = True
		
		ElseIf (sParasite == "SpiderEgg")  
			Debug.Messagebox("Your whole body is convulsing as violent cramps force the eggs out of you.")
			cureSpiderEgg( PlayerActor, "None", false ) 
			triggerEstrusChaurusBirth( PlayerActor, "SpiderEgg", Utility.RandomInt(1, 5))
			bSuccess = True
		
		ElseIf (sParasite == "ChaurusWorm")  
			Debug.Messagebox("You feel nauseous as your body suddenly rejects the worm.")
			cureChaurusWorm( PlayerActor, false )
			triggerEstrusChaurusBirth( PlayerActor, "ChaurusWorm", 1)
			bSuccess = True
		
		ElseIf (sParasite == "ChaurusWormVag")  
			Debug.Messagebox("You feel nauseous as your body suddenly rejects the worm.")
			cureChaurusWormVag( PlayerActor, false ) 
			triggerEstrusChaurusBirth( PlayerActor, "ChaurusWormVag", 1)
			bSuccess = True
		
		ElseIf (sParasite == "FaceHugger")  
			Int iEvent = Utility.RandomInt(1, 20)
 			sslBaseVoice voice = SexLab.GetVoice(PlayerActor)

 			Sound.SetInstanceVolume(WetFX.Play(PlayerRef), 1.0)
 			Utility.Wait(1.0)
 			Sound.SetInstanceVolume(CritterFX.Play(PlayerRef), 1.0)
 			Utility.Wait(1.0)

			if (iEvent <= 10)
				Debug.Messagebox("The creature cripples you with rapid thrusts of its tail deep inside you.")
	 			voice.Moan(PlayerActor, 10 + (Utility.RandomInt(0,8) * 10 ), false)
           	 	Debug.SendAnimationEvent(PlayerRef, "bleedOutStart")
            	utility.wait(4)
           		Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
           	else
				Debug.Messagebox("The creature pumps your womb full of a thick milky liquid.")
           	endif

 			voice.Moan(PlayerActor, 10 + (Utility.RandomInt(0,8) * 10 ), false)
 			Sound.SetInstanceVolume(WetFX.Play(PlayerRef), 1.0)
 			Utility.Wait(1.0)
 			Sound.SetInstanceVolume(CritterFX.Play(PlayerRef), 1.0)
 			Utility.Wait(1.0)
 			           
            SexLab.AddCum(PlayerActor,  Vaginal = true,  Oral = false,  Anal = true)
			bSuccess = True
		
		ElseIf (sParasite == "FaceHuggerGag")  
			Int iEvent = Utility.RandomInt(1, 20)

 			Sound.SetInstanceVolume(WetFX.Play(PlayerRef), 1.0)
 			Utility.Wait(1.0)
 			Sound.SetInstanceVolume(CritterFX.Play(PlayerRef), 1.0)
 			Utility.Wait(1.0)

			if (iEvent <= 10)
				Debug.Messagebox("The creature grabs your face tight as its tail coils around your neck, leaving you light headed and breathless.")
	 			voice.Moan(PlayerActor, 10 + (Utility.RandomInt(0,8) * 10 ), false)
           	 	Debug.SendAnimationEvent(PlayerRef, "bleedOutStart")
            	utility.wait(4)
           		Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
           	else
				Debug.Notification("The creature pumps your throat full of a sweet and milky liquid.")
				PlayerActor.AddItem(SLP_CritterSemen, 1, abSilent = true)
				PlayerActor.EquipItem(SLP_CritterSemen,abPreventRemoval = false, abSilent = true)
           	endif

 			sslBaseVoice voice = SexLab.GetVoice(PlayerActor)
 			voice.Moan(PlayerActor, 10 + (Utility.RandomInt(0,8) * 10 ), false)
 			Sound.SetInstanceVolume(WetFX.Play(PlayerRef), 1.0)
 			Utility.Wait(1.0)
 			Sound.SetInstanceVolume(CritterFX.Play(PlayerRef), 1.0)
 			Utility.Wait(1.0)
 			           
            SexLab.AddCum(PlayerActor,  Vaginal = false,  Oral = true,  Anal = false)
			bSuccess = True
		
		ElseIf (sParasite == "TentacleMonster")  

			Int iEvent = Utility.RandomInt(1, 20)

 			Sound.SetInstanceVolume(VoicesFX.Play(PlayerRef), 1.0)
 			Utility.Wait(1.0)
 			Sound.SetInstanceVolume(WetFX.Play(PlayerRef), 1.0)
 			Utility.Wait(1.0) 

			sslBaseVoice voice = SexLab.GetVoice(PlayerActor)
 			voice.Moan(PlayerActor, 10 + (Utility.RandomInt(0,8) * 10 ), false)

 			Sound.SetInstanceVolume(VoicesFX.Play(PlayerRef), 1.0)
 			Utility.Wait(1.0)

			if (iEvent == 1)
				Debug.Messagebox("The ground suddenly shakes around you.")
				SendModEvent("SLHModHormone", "Lactation", 5.0)
				SendModEvent("SLHModHormone", "Metabolism", 5.0 * Utility.RandomInt(1,10))
				infectEstrusTentacles( PlayerActor )

			elseif (iEvent == 2)
				Debug.notification("FIND A COCK AND FUCK IT. OBEY")
				SendModEvent("SLHModHormone", "SexDrive", 2.0)
			elseif (iEvent == 3)
				Debug.notification("FIND A COCK AND SUCK IT. OBEY")
				SendModEvent("SLHModHormone", "SexDrive", 2.0)
			elseif (iEvent == 4)
				Debug.notification("LISTEN TO OUR VOICES AND OBEY")
				SendModEvent("SLHModHormone", "Bimbo", 2.0)
			elseif (iEvent == 5)
				Debug.notification("SURRENDER TO THE BLISS AND PLEASURE")
				SendModEvent("SLHModHormone", "Bimbo", 2.0)
			elseif (iEvent == 6)
				Debug.notification("LET US GUIDE YOU")
				SendModEvent("SLHModHormone", "Bimbo", 2.0)
			elseif (iEvent == 7)
				Debug.notification("WE CHOSE YOU. SUBMIT AND OBEY")
				SendModEvent("SLHModHormone", "Bimbo", 2.0)
			elseif (iEvent == 8)
				Debug.notification("OBEDIENCE IS PLEASURE. OBEY")
				SendModEvent("SLHModHormone", "Bimbo", 2.0)
			elseif (iEvent == 9)
				Debug.notification("LET GO OF YOUR THOUGHTS. OBEY")
				SendModEvent("SLHModHormone", "Bimbo", 2.0)
			elseif (iEvent == 10)
				Debug.Messagebox("The creature blurs your mind through constant stimulation of your nipples and your clit.")
				SendModEvent("SLHModHormone", "SexDrive", 5.0)

			elseif (iEvent >= 11)
				Debug.Notification("Needle-like tentacles fill your ears and burrow into your brain.")
				; Testing stop and restart of quest for random location aliases
				if (!(TentacleMonsterQuest.IsRunning()))
					TentacleMonsterQuest.Start()
				else
					; TentacleMonsterQuest.Stop()
					; Utility.Wait(1.0)
					; TentacleMonsterQuest.Start()
					TentacleMonsterQuest.SetStage(Utility.RandomInt(1, 4)*10)
				Endif
				; Utility.Wait(1.0)
				; TentacleMonsterQuest.Start()

				SendModEvent("SLHModHormone", "Bimbo", 5.0)
			endif

 			Sound.SetInstanceVolume(VoicesFX.Play(PlayerRef), 1.0)
 			Utility.Wait(1.0)

			bSuccess = True
		
		ElseIf (sParasite == "Barnacles")  
			Debug.Messagebox("The spores evaporated on their own.")
			cureBarnacles( PlayerActor, False  )
			bSuccess = True
			; PlayerActor.SendModEvent("SLPTriggerEstrusChaurusBirth", "Barnacles", Utility.RandomInt(1, 5))
		
		endif
	endif

	return bSuccess
EndFunction

Bool Function isPlayerInHeat()
 	Actor PlayerActor = Game.GetPlayer()
 	Bool bSuccess = true
 	Int iChaurusQueenStage = StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")

 	; Add detection of nearby spiders or chaurus

	If (isInfectedByString( PlayerActor,  "SpiderEgg" ))
		bSuccess = false
	endif

	if (PlayerActor.GetItemCount(SmallSpiderEgg) != 0) && (QueenOfChaurusQuest.GetStageDone(320))
		bSuccess = false
	endif

	if (PlayerActor.GetItemCount(ChaurusEgg) != 0) && (QueenOfChaurusQuest.GetStageDone(335))
		bSuccess = false
	endif

	; if (bSuccess)
 	;	debug.notification("[SLP] Player is in heat " )
 	; else
 	;	debug.notification("[SLP] Player is NOT in heat " )
 	; endif

 	Return bSuccess
Endfunction

Function tryCharmSpider(Actor Target)
	Actor kPlayer = Game.GetPlayer()
 	Int iChaurusQueenStage = StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage")
 	Int iCharmThreshold = 50

 	if (StorageUtil.GetIntValue(kPlayer, "_SLP_iSpiderCharmON")==1)
 		; Charm is in progress - no need for more checks (needed for magic attackes)
 		return
 	endif


	if fctUtils.checkIfSpider ( Target )

		; Add code using Hormones pheromone levels
		iCharmThreshold = iCharmThreshold + ((StorageUtil.GetFloatValue(kPlayer, "_SLH_fHormonePheromones") as Int) / 2)

		If (Utility.RandomInt(0,100)<=iCharmThreshold)  
			Debug.Notification("[SLP] Charm Spider" )
		    ;   Debug.Messagebox(" Spider Pheromone charm spell started") 
		 	; kPlayer.AddToFaction(SpiderFaction)
		    Target.StopCombat()   
		    Target.SetPlayerTeammate(true )
			SpiderFollowerAlias.ForceRefTo(Target as objectReference)
			StorageUtil.SetIntValue(kPlayer, "_SLP_iSpiderCharmON", 1)
			Utility.Wait(1.0)

		 	if (iChaurusQueenStage>=3) && (!kPlayer.HasSpell( SeedSpiderBreeding ))
		 		kPlayer.AddSpell( SeedTrack )
		 		kPlayer.AddSpell( SeedCalm )
		 		kPlayer.AddSpell( SeedSpiderBreeding )
		 		debug.messagebox("The Seed reacts strongly to the influence of the Spider pheromones and inflames your senses. As the pincers spread your vagina into a gaping hole for the spider to mate with, you feel your mind expand to new possibilities.")
			endif

			if (QueenOfChaurusQuest.GetStageDone(310)) && (!QueenOfChaurusQuest.GetStageDone(320)) 
				QueenOfChaurusQuest.SetStage(320)
				tryPlayerSpiderStage()
			endif

			_SLP_GV_numCharmSpider.Mod(1.0)
			fctUtils.ParasiteSex(kPlayer, Target)			
			
		endif

	else
		Debug.Notification("[SLP] Charm Spider - Failed" )
		Debug.Trace("[SLP] Charm Spider - Failed" )
		Debug.Trace("[SLP]       iCharmThreshold: " + iCharmThreshold)
		Debug.Trace("[SLP]       checkIfSpider: " + fctUtils.checkIfSpider ( Target ))
		Debug.Trace("[SLP]       _SLP_iSpiderPheromoneON: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iSpiderPheromoneON"))

	endif


Endfunction

Function tryPlayerSpiderStage()
 	Actor PlayerActor = Game.GetPlayer()
  	Int iChaurusQueenStage = StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")

	if (iChaurusQueenStage>=3) && (QueenOfChaurusQuest.GetStageDone(320))  
		if (!PlayerActor.HasSpell( SeedSpawnSpider ))
	 		PlayerActor.AddSpell( SeedSpawnSpider ) 
	 		PlayerActor.AddItem(SmallSpiderEgg,5)
	 		SeedSpawnSpider.Cast(PlayerActor as ObjectReference, PlayerActor as ObjectReference)

	 		debug.messagebox("The Seed throbs deep inside you and forces the now fertilized eggs out of your womb. In a sudden flash of understanding, you realize you hold power over your newly spawned eggs.")
	 		debug.messagebox("(Use the 'SEED SPAWN SPIDER' power to transmute spider eggs from your inventory.)")
	 	endif
		cureSpiderEgg( PlayerActor, "None", false )
	 	; triggerEstrusChaurusBirth(  PlayerActor, "SpiderEgg", RandomInt(5,15)  )

	endif
Endfunction

Function tryCharmChaurus(Actor Target)
	Actor kPlayer = Game.GetPlayer()
 	Int iChaurusQueenStage = StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage")
 	Int iCharmThreshold = 50

 	if (StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusCharmON")==1)
 		; Charm is in progress - no need for more checks (needed for magic attackes)
 		return
 	endif

	if fctUtils.checkIfChaurus ( Target )

		; Add code using Hormones pheromone levels
		iCharmThreshold = iCharmThreshold + ((StorageUtil.GetFloatValue(kPlayer, "_SLH_fHormonePheromones") as Int) / 2)

		If (Utility.RandomInt(0,100)<=iCharmThreshold)   
		    ; Debug.Messagebox(" Chaurus Pheromone charm spell started")    
		 	; kPlayer.AddToFaction(ChaurusFaction)
		    Target.StopCombat()   
		    Target.SetPlayerTeammate(true )
			ChaurusFollowerAlias.ForceRefTo(Target as objectReference)
			_SLP_GV_numCharmChaurus.Mod(1.0)
			; Debug.Notification("[SLP] Charm Chaurus" )
			StorageUtil.SetIntValue(kPlayer, "_SLP_iChaurusCharmON", 1)
			Utility.Wait(1.0)

			if (QueenOfChaurusQuest.GetStageDone(330)) 
			 	if (iChaurusQueenStage==3) && (!kPlayer.HasSpell( SeedChaurusBreeding ))
			 		kPlayer.AddSpell( SeedTrack )
			 		kPlayer.AddSpell( SeedCalm )
			 		kPlayer.AddSpell( SeedChaurusBreeding )
			 		debug.messagebox("The Seed blooms inside you from the influence of the Chaurus pheromones. The pincers extend a hungry mouth for the chaurus to mate with, making your skin tingles with power and giving you a new understanding of the Chaurus biology.")
				endif
			endif

			if (QueenOfChaurusQuest.GetStageDone(340)) && (!QueenOfChaurusQuest.GetStageDone(350)) 
				QueenOfChaurusQuest.SetStage(350)
				tryPlayerChaurusStage()
			endif

			fctUtils.ParasiteSex(kPlayer, Target)
		endif

	else
		; Debug.Notification("[SLP] Charm Chaurus - Failed" )
		Debug.Trace("[SLP] Charm Chaurus - Failed" )
		Debug.Trace("[SLP]       iCharmThreshold: " + iCharmThreshold)
		Debug.Trace("[SLP]       checkIfChaurus: " + fctUtils.checkIfChaurus ( Target ))
		Debug.Trace("[SLP]       _SLP_iChaurusPheromoneON: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusPheromoneON"))

	endif
EndFunction

Function tryPlayerChaurusStage()
 	Actor PlayerActor = Game.GetPlayer()
  	Int iChaurusQueenStage = StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")

	if (iChaurusQueenStage>=3) && (QueenOfChaurusQuest.GetStageDone(350))
		if (!PlayerActor.HasSpell( SeedSpawnChaurus ))
	 		PlayerActor.AddSpell( SeedSpawnChaurus ) 
	 		PlayerActor.AddItem(ChaurusEgg,5)

	 		SeedSpawnChaurus.Cast(PlayerActor as ObjectReference, PlayerActor as ObjectReference)
	 			
	 		debug.messagebox("The Seed expands inside you in response to the chaurus, flooding your mind with strange symbols and visions of alien skies. Your womb aches from the urge to fertilize and spawn chaurus eggs.")
	 		debug.messagebox("(Use the 'SEED SPAWN CHAURUS' power to transmute chaurus eggs from your inventory.)")
	 	endif 	
	endif
EndFunction
;------------------------------------------------------------------------------
; Maintenance function to keep Lastelle from wandering and clear visual effects on sleep
Function resetOnSleep()
	if (QueenOfChaurusQuest.GetStageDone(30)) && (!QueenOfChaurusQuest.GetStageDone(65))
		Actor kLastelle = LastelleRef as Actor

		debug.trace("[SLP] Lastelle came back while you were sleeping...")
		LastelleRef.moveto(LastelleCampOutside)
		kLastelle.EvaluatePackage()
	endif

	; Clear visual effect from Falmer Blue potion
	FalmerBlueImod.Remove( )
Endfunction
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



; -------------------------------------------------------
; Wrapper functions for compatibility 
Function ApplyBodyChange(Actor kActor, String sParasite, String sBodyPart, Float fValue=1.0, Float fValueMax=1.0)
	fctUtils.ApplyBodyChange( kActor,  sParasite,  sBodyPart,  fValue,  fValueMax)
EndFunction

Function FalmerBlue(Actor kActor, Actor kTarget)
	fctUtils.FalmerBlue( kActor,  kTarget)
EndFunction

; -------------------------------------------------------
Function maintenance()
 	Actor PlayerActor= Game.GetPlayer() as Actor
 	ActorBase pActorBase = PlayerActor.GetActorBase()

	if (!fctUtils.isNiOInstalled)
		fctUtils.isNiOInstalled = fctUtils.CheckXPMSERequirements(PlayerActor, pActorBase.GetSex())
	EndIf

	fctUtils.isSlifInstalled = Game.GetModbyName("SexLab Inflation Framework.esp") != 255

	If (!StorageUtil.HasIntValue(none, "_SLP_iSexLabParasites"))
		StorageUtil.SetIntValue(none, "_SLP_iSexLabParasites", 1)
		fctUtils._resetParasiteSettings()
	EndIf
EndFunction

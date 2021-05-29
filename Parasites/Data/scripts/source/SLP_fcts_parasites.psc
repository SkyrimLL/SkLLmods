Scriptname SLP_fcts_parasites extends Quest  
{ USED }
Import Utility
Import SKSE
zadLibs Property libs Auto
SexLabFrameWork Property SexLab Auto

SLP_fcts_parasites_devious Property fctDevious  Auto
SLP_fcts_parasites_devious Property fctParasitesDevious Auto
SLP_fcts_parasiteSpiderEgg Property fctParasiteSpiderEgg Auto
SLP_fcts_parasiteChaurusWorm Property fctParasiteChaurusWorm  Auto
SLP_fcts_parasiteFaceHugger Property fctParasiteFaceHugger  Auto
SLP_fcts_parasiteLivingArmor Property fctParasiteLivingArmor  Auto
SLP_fcts_parasiteTentacleMonster Property fctParasiteTentacleMonster  Auto
SLP_fcts_parasiteBarnacles Property fctParasiteBarnacles  Auto
SLP_fcts_parasiteSprigganRoot Property fctParasiteSprigganRoot  Auto
SLP_fcts_parasiteChaurusQueen Property fctParasiteChaurusQueen  Auto
SLP_fcts_parasiteEstrus Property fctParasiteEstrus  Auto

SLP_fcts_utils Property fctUtils  Auto

SLP_fcts_outfits Property fctOutfits  Auto

Quest Property KynesBlessingQuest  Auto 
Quest Property QueenOfChaurusQuest  Auto 

ReferenceAlias Property PlayerAlias  Auto  
ReferenceAlias Property SpiderFollowerAlias  Auto  
ReferenceAlias Property ChaurusFollowerAlias  Auto  

ObjectReference Property LastelleRef  Auto  
ObjectReference Property LastelleCampOutside  Auto  

Sound Property SummonSoundFX  Auto
Sound Property VoicesFX  Auto
Sound Property CritterFX  Auto
Sound Property WetFX  Auto

GlobalVariable Property _SLP_GV_numCharmChaurus Auto
GlobalVariable Property _SLP_GV_numCharmSpider Auto

Faction Property PlayerFollowerFaction Auto

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



Package Property _SLP_PKG_ZapFuroTub  Auto  


; -------------------------------------------------------
; OBSOLETE - Moved to individual scripts
 
Quest Property TentacleMonsterQuest  Auto 

ReferenceAlias Property SpiderEggInfectedAlias  Auto  
ReferenceAlias Property ChaurusWormInfectedAlias  Auto  
ReferenceAlias Property ChaurusQueenInfectedAlias  Auto  
ReferenceAlias Property BarnaclesInfectedAlias  Auto  
ReferenceAlias Property TentacleMonsterInfectedAlias  Auto  
ReferenceAlias Property LivingArmorInfectedAlias  Auto  
ReferenceAlias Property FaceHuggerInfectedAlias  Auto   
ReferenceAlias Property SprigganRootInfectedAlias  Auto   
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
GlobalVariable Property _SLP_GV_ZAPFuroTubOn  Auto  

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

Actor Property EncChaurusActor Auto 
Actor Property EncChaurusSpawnActor Auto 
Actor Property EncChaurusFledgelingActor Auto 
Actor Property EncChaurusHunterActor Auto 

SPELL Property StomachRot Auto

; -------------------------------------------------------
; -------------------------------------------------------
Bool Function infectParasiteByString(Actor kActor, String sParasiteKeyword = ""  )
	Armor thisArmor = None

	if (sParasiteKeyword == "SpiderEgg" ) 
		return fctParasiteSpiderEgg.infectSpiderEgg(kActor)

	elseif 	(sParasiteKeyword == "SpiderPenis" )  
		return fctParasiteSpiderEgg.infectSpiderPenis(kActor)

	elseif (sParasiteKeyword == "ChaurusWorm" ) 
		return fctParasiteChaurusWorm.infectChaurusWorm(kActor)

	elseif (sParasiteKeyword == "ChaurusWormVag" )  
		return fctParasiteChaurusWorm.infectChaurusWormVag(kActor)
		
	elseif (sParasiteKeyword == "EstrusTentacles" )  
		return fctParasiteEstrus.infectEstrusTentacles(kActor)
		
	elseif (sParasiteKeyword == "EstrusSlime" )  
		return fctParasiteEstrus.infectEstrusSlime(kActor)
		
	elseif (sParasiteKeyword == "ChaurusEgg" )  
		return fctParasiteEstrus.infectEstrusChaurusEgg(kActor)
		
	elseif (sParasiteKeyword == "ChaurusEggSilent" )  
		return fctParasiteEstrus.infectEstrusChaurusEggSilent(kActor)
		
	elseif (sParasiteKeyword == "ChaurusQueenGag" ) 
		return fctParasiteChaurusQueen.infectChaurusQueenGag(kActor)

	elseif (sParasiteKeyword == "ChaurusQueenVag" )
		return fctParasiteChaurusQueen.infectChaurusQueenVag(kActor)

	elseif (sParasiteKeyword == "ChaurusQueenSkin" ) 
		return fctParasiteChaurusQueen.infectChaurusQueenSkin(kActor)

	elseif (sParasiteKeyword == "ChaurusQueenArmor" )
		return fctParasiteChaurusQueen.infectChaurusQueenArmor(kActor)

	elseif (sParasiteKeyword == "ChaurusQueenBody" )  
		return fctParasiteChaurusQueen.infectChaurusQueenBody(kActor)
		
	elseif (sParasiteKeyword == "TentacleMonster" )  
		return fctParasiteTentacleMonster.infectTentacleMonster(kActor)
		
	elseif (sParasiteKeyword == "LivingArmor" )  
		return fctParasiteLivingArmor.infectLivingArmor(kActor)
		
	elseif (sParasiteKeyword == "FaceHugger" )  
		return fctParasiteFaceHugger.infectFaceHugger(kActor)

	elseif (sParasiteKeyword == "FaceHuggerGag" )  
		return fctParasiteFaceHugger.infectFaceHuggerGag(kActor)
		
	elseif (sParasiteKeyword == "Barnacles" )  
		return fctParasiteBarnacles.infectBarnacles(kActor)
 
	elseif (sParasiteKeyword == "SprigganRootGag" )  
		return fctParasiteSprigganRoot.infectSprigganRootGag(kActor)
 
	elseif (sParasiteKeyword == "SprigganRootArms" )  
		return fctParasiteSprigganRoot.infectSprigganRootArms(kActor)
 
	elseif (sParasiteKeyword == "SprigganRootFeet" )  
		return fctParasiteSprigganRoot.infectSprigganRootFeet(kActor)
 
	elseif (sParasiteKeyword == "SprigganRootBody" )  
		return fctParasiteSprigganRoot.infectSprigganRootBody(kActor)
 
	EndIf

	return  false

EndFunction

Bool Function applyParasiteByString(Actor kActor, String sParasiteKeyword = "" )
	Armor thisArmor = None

	if (sParasiteKeyword == "SpiderEgg" ) 
		return fctParasiteSpiderEgg.applySpiderEgg(kActor)

	elseif (sParasiteKeyword == "SpiderEggAll" ) 
	;	return fctParasiteSpiderEgg.applySpiderEggAll(kActor)

	elseif 	(sParasiteKeyword == "SpiderPenis" )  
		return fctParasiteSpiderEgg.applySpiderPenis(kActor)

	elseif (sParasiteKeyword == "ChaurusWorm" ) 
		return fctParasiteChaurusWorm.applyChaurusWorm(kActor)

	elseif (sParasiteKeyword == "ChaurusWormVag" )  
		return fctParasiteChaurusWorm.applyChaurusWormVag(kActor)
		
	elseif (sParasiteKeyword == "EstrusTentacles" )  
	;	return fctParasiteEstrus.applyEstrusTentacles(kActor)
		
	elseif (sParasiteKeyword == "EstrusSlime" )  
	;	return fctParasiteEstrus.applyEstrusSlime(kActor)
		
	elseif (sParasiteKeyword == "ChaurusEgg" )  
	;	return fctParasiteEstrus.applyChaurusEgg(kActor)
		
	elseif (sParasiteKeyword == "ChaurusQueenGag" ) 
		return fctParasiteChaurusQueen.applyChaurusQueenGag(kActor)

	elseif (sParasiteKeyword == "ChaurusQueenVag" )
		return fctParasiteChaurusQueen.applyChaurusQueenVag(kActor)

	elseif (sParasiteKeyword == "ChaurusQueenSkin" ) 
		return fctParasiteChaurusQueen.applyChaurusQueenSkin(kActor)

	elseif (sParasiteKeyword == "ChaurusQueenArmor" )
		return fctParasiteChaurusQueen.applyChaurusQueenArmor(kActor)

	elseif (sParasiteKeyword == "ChaurusQueenBody" )  
		return fctParasiteChaurusQueen.applyChaurusQueenBody(kActor)
		
	elseif (sParasiteKeyword == "TentacleMonster" )  
		return fctParasiteTentacleMonster.applyTentacleMonster(kActor)
		
	elseif (sParasiteKeyword == "LivingArmor" )  
		return fctParasiteLivingArmor.applyLivingArmor(kActor)
		
	elseif (sParasiteKeyword == "FaceHugger" )  
		return fctParasiteFaceHugger.applyFaceHugger(kActor)

	elseif (sParasiteKeyword == "FaceHuggerGag" )  
		return fctParasiteFaceHugger.applyFaceHuggerGag(kActor)
		
	elseif (sParasiteKeyword == "Barnacles" )  
		return fctParasiteBarnacles.applyBarnacles(kActor)

	elseif (sParasiteKeyword == "SprigganRootGag" )  
		return fctParasiteSprigganRoot.applySprigganRootGag(kActor)
 
	elseif (sParasiteKeyword == "SprigganRootArms" )  
		return fctParasiteSprigganRoot.applySprigganRootArms(kActor)
 
	elseif (sParasiteKeyword == "SprigganRootFeet" )  
		return fctParasiteSprigganRoot.applySprigganRootFeet(kActor)
 
	elseif (sParasiteKeyword == "SprigganRootBody" )  
		return fctParasiteSprigganRoot.applySprigganRootBody(kActor)
 
	EndIf

EndFunction

Function cureParasiteByString(Actor kActor, String sParasiteKeyword = "", Bool bHarvestParasite = False  )
	Armor thisArmor = None

	if (sParasiteKeyword == "SpiderEgg" ) 
		fctParasiteSpiderEgg.cureSpiderEgg(kActor, bHarvestParasite)

	elseif (sParasiteKeyword == "SpiderEggAll" ) 
		fctParasiteSpiderEgg.cureSpiderEggAll(kActor, bHarvestParasite)

	elseif 	(sParasiteKeyword == "SpiderPenis" )  
		fctParasiteSpiderEgg.cureSpiderPenis(kActor, bHarvestParasite)

	elseif (sParasiteKeyword == "ChaurusWorm" ) 
		fctParasiteChaurusWorm.cureChaurusWorm(kActor, bHarvestParasite)

	elseif (sParasiteKeyword == "ChaurusWormVag" )  
		fctParasiteChaurusWorm.cureChaurusWormVag(kActor, bHarvestParasite)
		
	elseif (sParasiteKeyword == "EstrusTentacles" )  
	;	fctParasiteEstrus.cureEstrusTentacles(kActor)
		
	elseif (sParasiteKeyword == "EstrusSlime" )  
	;	fctParasiteEstrus.cureEstrusSlime(kActor)
		
	elseif (sParasiteKeyword == "ChaurusEgg" )  
	;	fctParasiteEstrus.cureChaurusEgg(kActor)
		
	elseif (sParasiteKeyword == "ChaurusQueenGag" ) 
		fctParasiteChaurusQueen.cureChaurusQueenGag(kActor, bHarvestParasite)

	elseif (sParasiteKeyword == "ChaurusQueenVag" )
		fctParasiteChaurusQueen.cureChaurusQueenVag(kActor, bHarvestParasite)

	elseif (sParasiteKeyword == "ChaurusQueenSkin" ) 
		fctParasiteChaurusQueen.cureChaurusQueenSkin(kActor, bHarvestParasite)

	elseif (sParasiteKeyword == "ChaurusQueenArmor" )
		fctParasiteChaurusQueen.cureChaurusQueenArmor(kActor, bHarvestParasite)

	elseif (sParasiteKeyword == "ChaurusQueenBody" )  
		fctParasiteChaurusQueen.cureChaurusQueenBody(kActor, bHarvestParasite)
		
	elseif (sParasiteKeyword == "TentacleMonster" )  
		fctParasiteTentacleMonster.cureTentacleMonster(kActor, bHarvestParasite)
		
	elseif (sParasiteKeyword == "LivingArmor" )  
		fctParasiteLivingArmor.cureLivingArmor(kActor, bHarvestParasite)
		
	elseif (sParasiteKeyword == "FaceHugger" )  
		fctParasiteFaceHugger.cureFaceHugger(kActor, bHarvestParasite)

	elseif (sParasiteKeyword == "FaceHuggerGag" )  
		fctParasiteFaceHugger.cureFaceHuggerGag(kActor, bHarvestParasite)
		
	elseif (sParasiteKeyword == "Barnacles" )  
		fctParasiteBarnacles.cureBarnacles(kActor, bHarvestParasite)
 
	elseif (sParasiteKeyword == "SprigganRootGag" )  
		return fctParasiteSprigganRoot.cureSprigganRootGag(kActor)
 
	elseif (sParasiteKeyword == "SprigganRootArms" )  
		return fctParasiteSprigganRoot.cureSprigganRootArms(kActor)
 
	elseif (sParasiteKeyword == "SprigganRootFeet" )  
		return fctParasiteSprigganRoot.cureSprigganRootFeet(kActor)
 
	elseif (sParasiteKeyword == "SprigganRootBody" )  
		return fctParasiteSprigganRoot.cureSprigganRootBody(kActor)
	EndIf

EndFunction

Bool Function ActorHasKeywordByString(actor akActor, String sParasiteKeyword = "")
	if (sParasiteKeyword == "SpiderEgg" ) || (sParasiteKeyword == "SpiderPenis" )  
		return fctParasiteSpiderEgg.ActorHasKeywordByString(akActor, sParasiteKeyword)

	elseif (sParasiteKeyword == "ChaurusWorm" ) || (sParasiteKeyword == "ChaurusWormVag" )  
		return fctParasiteChaurusWorm.ActorHasKeywordByString(akActor, sParasiteKeyword)
		
	elseif (sParasiteKeyword == "ChaurusQueenGag" ) || (sParasiteKeyword == "ChaurusQueenVag" ) || (sParasiteKeyword == "ChaurusQueenSkin" ) ||  (sParasiteKeyword == "ChaurusQueenArmor" ) || (sParasiteKeyword == "ChaurusQueenBody" )  
		return fctParasiteChaurusQueen.ActorHasKeywordByString(akActor, sParasiteKeyword)
		
	elseif (sParasiteKeyword == "TentacleMonster" )  
		return fctParasiteTentacleMonster.ActorHasKeywordByString(akActor, sParasiteKeyword)
		
	elseif (sParasiteKeyword == "LivingArmor" )  
		return fctParasiteLivingArmor.ActorHasKeywordByString(akActor, sParasiteKeyword)
		
	elseif (sParasiteKeyword == "FaceHugger" )  || (sParasiteKeyword == "FaceHuggerGag" )  
		return fctParasiteFaceHugger.ActorHasKeywordByString(akActor, sParasiteKeyword)
		
	elseif (sParasiteKeyword == "Barnacles" )  
		return fctParasiteBarnacles.ActorHasKeywordByString(akActor, sParasiteKeyword)
		
	elseif (sParasiteKeyword == "SprigganRootGag" ) || (sParasiteKeyword == "SprigganRootArms" )  || (sParasiteKeyword == "SprigganRootFeet" )  || (sParasiteKeyword == "SprigganRootBody" )  
		return fctParasiteSprigganRoot.ActorHasKeywordByString(akActor, sParasiteKeyword)
 	else
 		return fctDevious.ActorHasKeywordByString(akActor, sParasiteKeyword)
	EndIf
EndFunction


Armor Function getParasiteByString(String sParasiteKeyword = ""  )
	Armor thisArmor = None

	if (sParasiteKeyword == "SpiderEgg" ) || (sParasiteKeyword == "SpiderPenis" )  
		thisArmor = fctParasiteSpiderEgg.getParasiteByString(sParasiteKeyword)

	elseif (sParasiteKeyword == "ChaurusWorm" ) || (sParasiteKeyword == "ChaurusWormVag" )  
		thisArmor = fctParasiteChaurusWorm.getParasiteByString(sParasiteKeyword)
		
	elseif (sParasiteKeyword == "ChaurusQueenGag" ) || (sParasiteKeyword == "ChaurusQueenVag" ) || (sParasiteKeyword == "ChaurusQueenSkin" ) ||  (sParasiteKeyword == "ChaurusQueenArmor" ) || (sParasiteKeyword == "ChaurusQueenBody" )  
		thisArmor = fctParasiteChaurusQueen.getParasiteByString(sParasiteKeyword)
		
	elseif (sParasiteKeyword == "TentacleMonster" )  
		thisArmor = fctParasiteTentacleMonster.getParasiteByString(sParasiteKeyword)
		
	elseif (sParasiteKeyword == "LivingArmor" )  
		thisArmor = fctParasiteLivingArmor.getParasiteByString(sParasiteKeyword)
		
	elseif (sParasiteKeyword == "FaceHugger" )  || (sParasiteKeyword == "FaceHuggerGag" )  
		thisArmor = fctParasiteFaceHugger.getParasiteByString(sParasiteKeyword)
		
	elseif (sParasiteKeyword == "Barnacles" )  
		thisArmor = fctParasiteBarnacles.getParasiteByString(sParasiteKeyword)
 		
	elseif (sParasiteKeyword == "SprigganRootGag" ) || (sParasiteKeyword == "SprigganRootArms" )  || (sParasiteKeyword == "SprigganRootFeet" )  || (sParasiteKeyword == "SprigganRootBody" )  
		thisArmor = fctParasiteSprigganRoot.getParasiteByString(sParasiteKeyword)

	EndIf

	return thisArmor
EndFunction

Armor Function getParasiteRenderedByString(String sParasiteKeyword = ""  )
	Armor thisArmor = None

	if (sParasiteKeyword == "SpiderEgg" ) || (sParasiteKeyword == "SpiderPenis" )  
		thisArmor = fctParasiteSpiderEgg.getParasiteRenderedByString(sParasiteKeyword)

	elseif (sParasiteKeyword == "ChaurusWorm" ) || (sParasiteKeyword == "ChaurusWormVag" )  
		thisArmor = fctParasiteChaurusWorm.getParasiteRenderedByString(sParasiteKeyword)
		
	elseif (sParasiteKeyword == "ChaurusQueenGag" ) || (sParasiteKeyword == "ChaurusQueenVag" ) || (sParasiteKeyword == "ChaurusQueenSkin" ) ||  (sParasiteKeyword == "ChaurusQueenArmor" ) || (sParasiteKeyword == "ChaurusQueenBody" )  
		thisArmor = fctParasiteChaurusQueen.getParasiteRenderedByString(sParasiteKeyword)
		
	elseif (sParasiteKeyword == "TentacleMonster" )  
		thisArmor = fctParasiteTentacleMonster.getParasiteRenderedByString(sParasiteKeyword)
		
	elseif (sParasiteKeyword == "LivingArmor" )  
		thisArmor = fctParasiteLivingArmor.getParasiteRenderedByString(sParasiteKeyword)
		
	elseif (sParasiteKeyword == "FaceHugger" )  || (sParasiteKeyword == "FaceHuggerGag" )  
		thisArmor = fctParasiteFaceHugger.getParasiteRenderedByString(sParasiteKeyword)
		
	elseif (sParasiteKeyword == "Barnacles" )  
		thisArmor = fctParasiteBarnacles.getParasiteRenderedByString(sParasiteKeyword)
 		
	elseif (sParasiteKeyword == "SprigganRootGag" ) || (sParasiteKeyword == "SprigganRootArms" )  || (sParasiteKeyword == "SprigganRootFeet" )  || (sParasiteKeyword == "SprigganRootBody" )  
		thisArmor = fctParasiteSprigganRoot.getParasiteRenderedByString(sParasiteKeyword)
 
	EndIf
	return thisArmor
EndFunction


Keyword Function getDeviousKeywordByString(String sParasiteKeyword = ""  )
	Keyword thisKeyword = None
 
	if (sParasiteKeyword == "SpiderEgg" )  || (sParasiteKeyword == "SpiderPenis" )  
		thisKeyword = fctParasiteSpiderEgg.getDeviousKeywordByString( sParasiteKeyword )

	elseif (sParasiteKeyword == "ChaurusWorm" )  || (sParasiteKeyword == "ChaurusWormVag" )  
		thisKeyword = fctParasiteChaurusWorm.getDeviousKeywordByString( sParasiteKeyword )
		
	elseif (sParasiteKeyword == "ChaurusQueenGag" ) || (sParasiteKeyword == "ChaurusQueenVag" )  || (sParasiteKeyword == "ChaurusQueenSkin" )  || (sParasiteKeyword == "ChaurusQueenArmor" ) || (sParasiteKeyword == "ChaurusQueenBody" )  
		thisKeyword = fctParasiteChaurusQueen.getDeviousKeywordByString( sParasiteKeyword )
		
	elseif (sParasiteKeyword == "TentacleMonster" )  
		thisKeyword = fctParasiteTentacleMonster.getDeviousKeywordByString( sParasiteKeyword )
		
	elseif (sParasiteKeyword == "LivingArmor" )  
		thisKeyword = fctParasiteLivingArmor.getDeviousKeywordByString( sParasiteKeyword )
		
	elseif (sParasiteKeyword == "FaceHugger" ) || (sParasiteKeyword == "FaceHuggerGag" )  
		thisKeyword = fctParasiteFaceHugger.getDeviousKeywordByString( sParasiteKeyword )
		
	elseif (sParasiteKeyword == "Barnacles" )  
		thisKeyword = fctParasiteBarnacles.getDeviousKeywordByString( sParasiteKeyword )
 		
	elseif (sParasiteKeyword == "SprigganRootGag" ) || (sParasiteKeyword == "SprigganRootArms" )  || (sParasiteKeyword == "SprigganRootFeet" )  || (sParasiteKeyword == "SprigganRootBody" )  
		thisKeyword = fctParasiteSprigganRoot.getDeviousKeywordByString(sParasiteKeyword)
 		
	else
		thisKeyword = fctParasitesDevious.getDeviousDeviceKeywordByString( sParasiteKeyword )
	endIf

	return thisKeyword
EndFunction

Function equipParasiteNPCByString(Actor kActor, String sParasiteKeyword = ""  )
 
	if (sParasiteKeyword == "SpiderEgg" )  || (sParasiteKeyword == "SpiderPenis" )  
		fctParasiteSpiderEgg.equipParasiteNPCByString(kActor,  sParasiteKeyword )

	elseif (sParasiteKeyword == "ChaurusWorm" )  || (sParasiteKeyword == "ChaurusWormVag" )  
		fctParasiteChaurusWorm.equipParasiteNPCByString(kActor,  sParasiteKeyword )
		
	elseif (sParasiteKeyword == "ChaurusQueenGag" ) || (sParasiteKeyword == "ChaurusQueenVag" )  || (sParasiteKeyword == "ChaurusQueenSkin" )  || (sParasiteKeyword == "ChaurusQueenArmor" ) || (sParasiteKeyword == "ChaurusQueenBody" )  
		fctParasiteChaurusQueen.equipParasiteNPCByString(kActor,  sParasiteKeyword )
		
	elseif (sParasiteKeyword == "TentacleMonster" )  
		fctParasiteTentacleMonster.equipParasiteNPCByString(kActor,  sParasiteKeyword )
		
	elseif (sParasiteKeyword == "LivingArmor" )  
		fctParasiteLivingArmor.equipParasiteNPCByString(kActor,  sParasiteKeyword )
		
	elseif (sParasiteKeyword == "FaceHugger" ) || (sParasiteKeyword == "FaceHuggerGag" )  
		fctParasiteFaceHugger.equipParasiteNPCByString(kActor,  sParasiteKeyword )
		
	elseif (sParasiteKeyword == "Barnacles" )  
		fctParasiteBarnacles.equipParasiteNPCByString(kActor,  sParasiteKeyword )
 		
	elseif (sParasiteKeyword == "SprigganRootGag" ) || (sParasiteKeyword == "SprigganRootArms" )  || (sParasiteKeyword == "SprigganRootFeet" )  || (sParasiteKeyword == "SprigganRootBody" )  
		fctParasiteSprigganRoot.equipParasiteNPCByString(kActor,  sParasiteKeyword )
		
	else
	; Function only available for custom parasite devices
	;	fctParasitesDevious.equipParasiteNPCByString(kActor,  sParasiteKeyword )
	endIf

EndFunction

Function clearParasiteNPCByString(Actor kActor, String sParasiteKeyword = ""  )
 
	if (sParasiteKeyword == "SpiderEgg" )  || (sParasiteKeyword == "SpiderPenis" )  
		fctParasiteSpiderEgg.clearParasiteNPCByString(kActor,  sParasiteKeyword )

	elseif (sParasiteKeyword == "ChaurusWorm" )  || (sParasiteKeyword == "ChaurusWormVag" )  
		fctParasiteChaurusWorm.clearParasiteNPCByString(kActor,  sParasiteKeyword )
		
	elseif (sParasiteKeyword == "ChaurusQueenGag" ) || (sParasiteKeyword == "ChaurusQueenVag" )  || (sParasiteKeyword == "ChaurusQueenSkin" )  || (sParasiteKeyword == "ChaurusQueenArmor" ) || (sParasiteKeyword == "ChaurusQueenBody" )  
		fctParasiteChaurusQueen.clearParasiteNPCByString(kActor,  sParasiteKeyword )
		
	elseif (sParasiteKeyword == "TentacleMonster" )  
		fctParasiteTentacleMonster.clearParasiteNPCByString(kActor,  sParasiteKeyword )
		
	elseif (sParasiteKeyword == "LivingArmor" )  
		fctParasiteLivingArmor.clearParasiteNPCByString(kActor,  sParasiteKeyword )
		
	elseif (sParasiteKeyword == "FaceHugger" ) || (sParasiteKeyword == "FaceHuggerGag" )  
		fctParasiteFaceHugger.clearParasiteNPCByString(kActor,  sParasiteKeyword )
		
	elseif (sParasiteKeyword == "Barnacles" )  
		fctParasiteBarnacles.clearParasiteNPCByString(kActor,  sParasiteKeyword )
		
 		
	elseif (sParasiteKeyword == "SprigganRootGag" ) || (sParasiteKeyword == "SprigganRootArms" )  || (sParasiteKeyword == "SprigganRootFeet" )  || (sParasiteKeyword == "SprigganRootBody" )  
		fctParasiteSprigganRoot.clearParasiteNPCByString(kActor,  sParasiteKeyword )
	else
	; Function only available for custom parasite devices
	;	fctParasitesDevious.clearParasiteNPCByString(kActor,  sParasiteKeyword )
	endIf

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
 
	if (sParasite == "SpiderEgg" ) || (sParasite == "SpiderPenis" )  
		SpiderEggInfectedAlias.ForceRefTo(DummyAlias)
		SpiderFollowerAlias.ForceRefTo(DummyAlias)  

	elseif (sParasite == "ChaurusWorm" )  || (sParasite == "ChaurusWormVag" )  
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
		
	elseif (sParasite == "FaceHugger" )  || (sParasite == "HipHugger" )  || (sParasite == "FaceHuggerGag" )  
		FaceHuggerInfectedAlias.ForceRefTo(DummyAlias)
		
	elseif (sParasite == "Barnacles" )  
		BarnaclesInfectedAlias.ForceRefTo(DummyAlias)
		
	elseif (sParasite == "SprigganRootGag" ) || (sParasite == "SprigganRootArms" )  || (sParasite == "SprigganRootFeet" )  || (sParasite == "SprigganRootBody" )  
		SprigganRootInfectedAlias.ForceRefTo(DummyAlias)

	endif

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
				If (fctParasiteBarnacles.isInfectedByString( kActor,  "Barnacles" ))
					; SeedFlare.RemoteCast(kActor as ObjectReference, kActor,kActor as ObjectReference)		
					SeedFlare.Cast(kActor as ObjectReference, kActor as ObjectReference)	
					debug.trace("[SLP]    Effect - cure Barnacles")
					debug.Notification("The Seed inside you flushes the barnacles away from your skin.")
					fctParasiteBarnacles.cureBarnacles( kActor  )
					bSuccess = True

				endif 

				If (!fctParasiteChaurusQueen.isInfectedByString( kActor,  "ChaurusQueenVag" )) && (Utility.RandomInt(0,100)<60)
					debug.trace("[SLP]    Effect - add Chaurus Queen Vag")
					if (iChaurusQueenStage==1)
						; First time: stage = 1
						debug.MessageBox("The Seed stirs through your womb and extends a tentacle between your legs.")
					else
						; Stage >= 2
						debug.Notification("The Seed stirs through your womb and extends a tentacle between your legs.")
					endif
					fctParasiteChaurusQueen.infectChaurusQueenVag( kActor  ) 
					bSuccess = True
					
				elseIf (fctParasiteChaurusQueen.isInfectedByString( kActor,  "ChaurusQueenVag" )) && (Utility.RandomInt(0,100)<40)
					debug.trace("[SLP]    Effect - cure Chaurus Queen Vag")
					debug.Notification("The tentacle receeds to the Seed inside your womb.")
					fctParasiteChaurusQueen.cureChaurusQueenVag( kActor  )
					bSuccess = True

				endif 
				
				If (!fctParasiteChaurusQueen.isInfectedByString( kActor,  "ChaurusQueenSkin" )) && (Utility.RandomInt(0,100)<80) && (iChaurusQueenStage>=2)
					debug.trace("[SLP]    Effect - add Chaurus Queen Skin")
					if (iChaurusQueenStage==2)
						; First time: stage = 2
						debug.MessageBox("The Seed flares up through your skin and your breasts.")
					else
						; Stage >= 3
						debug.Notification("The Seed flares up through your skin and your breasts.")
					endif
					fctParasiteChaurusQueen.infectChaurusQueenSkin( kActor  )
					bSuccess = True
					
				elseIf (fctParasiteChaurusQueen.isInfectedByString( kActor,  "ChaurusQueenSkin" )) && (Utility.RandomInt(0,100)<40)
					debug.trace("[SLP]    Effect - cure Chaurus Queen Skin")
					debug.Notification("The feelers in your breasts receed inside.")
					fctParasiteChaurusQueen.cureChaurusQueenSkin( kActor  )
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
				 		fctParasiteEstrus.triggerEstrusChaurusBirth(  kActor, "ChaurusEgg", 5  )
				 	elseif (iChaurusEggsCount>0)
				 		fctParasiteEstrus.triggerEstrusChaurusBirth(  kActor, "ChaurusEgg", iChaurusEggsCount  )
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
			fctParasiteSpiderEgg.cureSpiderPenis( PlayerActor   )
			bSuccess = True
		
		ElseIf (sParasite == "SpiderEgg")  
			Debug.Messagebox("Your whole body is convulsing as violent cramps force the eggs out of you.")
			fctParasiteSpiderEgg.cureSpiderEgg( PlayerActor, false ) 
			fctParasiteEstrus.triggerEstrusChaurusBirth( PlayerActor, "SpiderEgg", Utility.RandomInt(1, 5))
			bSuccess = True
		
		ElseIf (sParasite == "ChaurusWorm")  
			Debug.Messagebox("You feel nauseous as your body suddenly rejects the worm.")
			fctParasiteChaurusWorm.cureChaurusWorm( PlayerActor, false )
			fctParasiteEstrus.triggerEstrusChaurusBirth( PlayerActor, "ChaurusWorm", 1)
			bSuccess = True
		
		ElseIf (sParasite == "ChaurusWormVag")  
			Debug.Messagebox("You feel nauseous as your body suddenly rejects the worm.")
			fctParasiteChaurusWorm.cureChaurusWormVag( PlayerActor, false ) 
			fctParasiteEstrus.triggerEstrusChaurusBirth( PlayerActor, "ChaurusWormVag", 1)
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
				fctParasiteEstrus.infectEstrusTentacles( PlayerActor )

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
			fctParasiteBarnacles.cureBarnacles( PlayerActor, False  )
			bSuccess = True
			; PlayerActor.SendModEvent("SLPTriggerEstrusChaurusBirth", "Barnacles", Utility.RandomInt(1, 5))
		
		endif
	endif

	return bSuccess
EndFunction

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
			; Debug.Notification("[SLP] Charm Spider" )
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
			ParasiteSex(kPlayer, Target)			
			
		endif

	else
		Debug.Notification("[SLP] Charm Spider - Failed" )
		Debug.Trace("[SLP] Charm Spider - Failed" )
		Debug.Trace("[SLP]       iCharmThreshold: " + iCharmThreshold)
		Debug.Trace("[SLP]       checkIfSpider: " + fctUtils.checkIfSpider ( Target ))
		Debug.Trace("[SLP]       _SLP_iSpiderPheromoneON: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iSpiderPheromoneON"))
		Debug.Trace("[SLP]       _SLH_fHormonePheromones: " + StorageUtil.GetFloatValue(kPlayer, "_SLH_fHormonePheromones"))

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
		fctParasiteSpiderEgg.cureSpiderEgg( PlayerActor, false )
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
			Debug.Notification("[SLP] Charm Chaurus" )
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

			ParasiteSex(kPlayer, Target)
		endif

	else
		; Debug.Notification("[SLP] Charm Chaurus - Failed" )
		Debug.Trace("[SLP] Charm Chaurus - Failed" )
		Debug.Trace("[SLP]       iCharmThreshold: " + iCharmThreshold)
		Debug.Trace("[SLP]       checkIfChaurus: " + fctUtils.checkIfChaurus ( Target ))
		Debug.Trace("[SLP]       _SLP_iChaurusPheromoneON: " + StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusPheromoneON"))
		Debug.Trace("[SLP]       _SLH_fHormonePheromones: " + StorageUtil.GetFloatValue(kPlayer, "_SLH_fHormonePheromones"))

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


	if (StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")>=5)
		fctParasiteChaurusQueen.getRandomChaurusEggs(PlayerActor, 0, 20)
	endif
EndFunction

Bool Function tryPlayerLivingArmor()
 	Actor PlayerActor = Game.GetPlayer()
	Float	fChanceLivingArmor = StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceLivingArmor")

	If (!fctParasiteLivingArmor.ActorHasKeywordByString(PlayerActor, "Belt")) && (!fctParasiteLivingArmor.ActorHasKeywordByString(PlayerActor, "Plug"))
		if (Utility.RandomInt(1,100)<= (fChanceLivingArmor as Int) )
			; PlayerActor.SendModEvent("SLPInfectChaurusWorm")
			if (fctParasiteLivingArmor.infectLivingArmor( PlayerActor ))
				
				Debug.MessageBox("You moan helplessly as a creature suddenly wraps itself around you.")
				Return True
			Endif
		Endif

	EndIf

	Return False
EndFunction

Function triggerEstrusChaurusBirth( Actor kActor, String  sParasite, Int iBirthItemCount  )
	fctParasiteEstrus.triggerEstrusChaurusBirth(  kActor,   sParasite,  iBirthItemCount  )
EndFunction

Function triggerFuroTub( Actor kActor, String  sParasite)
	fctParasiteEstrus.triggerFuroTub(  kActor,   sParasite)
EndFunction


Bool Function isPlayerInHeat()
 	Actor PlayerActor = Game.GetPlayer()
 	Bool bSuccess = true
 	Int iChaurusQueenStage = StorageUtil.GetIntValue(PlayerActor, "_SLP_iChaurusQueenStage")

 	; Add detection of nearby spiders or chaurus

	If (fctParasiteSpiderEgg.isInfectedByString( PlayerActor,  "SpiderEgg" ))
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

;------------------------------------------------------------------------------
Function ParasiteSex(Actor kActor, Actor kParasite)
	If  (SexLab.ValidateActor( kActor ) > 0) &&  (SexLab.ValidateActor(kParasite) > 0) 

		SexLab.QuickStart(kActor,  kParasite, AnimationTags = "Sex")
	EndIf
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

	if (sParasite == "SpiderEgg" )  || (sParasite == "SpiderPenis" )  
		fctParasiteSpiderEgg.refreshParasite( kActor, sParasite )

	elseif (sParasite == "ChaurusWorm" )  || (sParasite == "ChaurusWormVag" )  
		fctParasiteChaurusWorm.refreshParasite(  kActor, sParasite )
		
	elseif (sParasite == "ChaurusQueenGag" ) || (sParasite == "ChaurusQueenVag" )  || (sParasite == "ChaurusQueenSkin" )  || (sParasite == "ChaurusQueenArmor" ) || (sParasite == "ChaurusQueenBody" )  
		; fctParasiteChaurusQueen.refreshParasite(  kActor,  sParasite )
		
	elseif (sParasite == "TentacleMonster" )  
		fctParasiteTentacleMonster.refreshParasite(  kActor, sParasite )
		
	elseif (sParasite == "LivingArmor" )  
		fctParasiteLivingArmor.refreshParasite(  kActor, sParasite )
		
	elseif (sParasite == "FaceHugger" ) || (sParasite == "FaceHuggerGag" )  
		fctParasiteFaceHugger.refreshParasite(  kActor, sParasite )
		
	elseif (sParasite == "Barnacles" )  
		fctParasiteBarnacles.refreshParasite(  kActor, sParasite )
		
	else
		; fctParasitesDevious.refreshParasite( deviousKeyword )
	endIf

EndFunction



; -------------------------------------------------------
; Wrapper functions for compatibility 
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

Function ApplyBodyChange(Actor kActor, String sParasite, String sBodyPart, Float fValue=1.0, Float fValueMax=1.0)
	fctUtils.ApplyBodyChange( kActor,  sParasite,  sBodyPart,  fValue,  fValueMax)
EndFunction

Function FalmerBlue(Actor kActor, Actor kTarget)
	fctUtils.FalmerBlue( kActor,  kTarget)
EndFunction

Function getRandomChaurusEggs(Actor kActor, int iMinEggs = 0, int iMaxEggs = 20 )
	fctParasiteChaurusQueen.getRandomChaurusEggs(kActor, iMinEggs , iMaxEggs )
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

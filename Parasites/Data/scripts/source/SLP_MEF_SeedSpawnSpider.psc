Scriptname SLP_MEF_SeedSpawnSpider extends activemagiceffect  


SLP_fcts_parasites Property fctParasites  Auto 

Scroll Property SpiderSpawnExploding Auto
Scroll Property SpiderSpawnCloak Auto
Scroll Property SpiderSpawnFrostCloak Auto
Scroll Property SpiderSpawnFireCloak Auto
Scroll Property SpiderSpawnShockCloak Auto
Scroll Property SpiderSpawnOil Auto
Scroll Property SpiderSpawnMind Auto
Scroll Property SpiderSpawnGlow Auto


Quest Property QueenOfChaurusQuest  Auto 

Ingredient  Property SmallSpiderEgg Auto
Ingredient  Property FireSalts Auto ; fire cloak spiders
Ingredient  Property FrostSalts Auto ; frost cloak spiders
Ingredient  Property VoidSalts Auto ; shock spiders
Ingredient  Property DeathBell Auto ; poison spiders - replaced by Salt Piles

Ingredient  Property SwampFungalPod01 Auto ; mind control spiders - moved to Chaurus Spawn
Ingredient  Property DwarvenOil Auto ; oil spiders - moved to Chaurus Spawn
Ingredient  Property FireflyThorax Auto ; glow spiders - moved to Chaurus Spawn


Event OnEffectStart(Actor Target, Actor Caster)
	Actor kPlayer = Game.GetPlayer()
 	Int iChaurusQueenStage = StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage")
 	Int iSpiderEggsCount
 	Int iSpiderScrollCount = 0
 	Int iRandomNum = utility.randomint(0,100)

	If (fctParasites.isInfectedByString( kPlayer,  "SpiderEgg" ))
		Debug.notification("[SLP] Hatching spider cluster.") 
		fctParasites.cureParasiteByString(kPlayer,  "SpiderEgg")
		; kPlayer.AddItem(SmallSpiderEgg, Utility.RandomInt(5,15))
	endif

	iSpiderEggsCount = kPlayer.GetItemCount(SmallSpiderEgg)

	if (iSpiderEggsCount>5)
		iSpiderScrollCount = 5
	elseif (iSpiderEggsCount>0)
		iSpiderScrollCount = iSpiderEggsCount 
	endif

	if (iSpiderScrollCount>0)
		Debug.notification("Spiders spawn from your egg sac.") 
		kPlayer.RemoveItem(SmallSpiderEgg, iSpiderScrollCount)

		
		if (iRandomNum>50) && (kPlayer.GetItemCount(FireSalts)>0)
			kPlayer.AddItem(SpiderSpawnFireCloak, iSpiderScrollCount)
			kPlayer.RemoveItem(FireSalts, 1)

		elseif (iRandomNum>50) && (kPlayer.GetItemCount(FrostSalts)>0)
			kPlayer.AddItem(SpiderSpawnFrostCloak, iSpiderScrollCount)
			kPlayer.RemoveItem(FrostSalts, 1)

		elseif (iRandomNum>50) && (kPlayer.GetItemCount(VoidSalts)>0)
			kPlayer.AddItem(SpiderSpawnShockCloak, iSpiderScrollCount)
			kPlayer.RemoveItem(VoidSalts, 1)

		elseif (iRandomNum>20) && (kPlayer.GetItemCount(DeathBell)>0)
			kPlayer.AddItem(SpiderSpawnCloak, iSpiderScrollCount)
			kPlayer.RemoveItem(DeathBell, 1)


		else
			kPlayer.AddItem(SpiderSpawnExploding, iSpiderScrollCount)
		endif
	else
		Debug.notification("Without spider eggs near you, the spell has no effect.") 
	endif
    ;   Debug.Messagebox(" Spider Pheromone charm spell started")    
	
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
    ;	SpiderFollowerAlias.Clear()
ENDEVENT
Scriptname SLP_MEF_SeedSpawnChaurus extends activemagiceffect  

SLP_fcts_parasites Property fctParasites  Auto 

Quest Property QueenOfChaurusQuest  Auto 

Scroll Property SpiderSpawnOil Auto
Scroll Property SpiderSpawnMind Auto
Scroll Property SpiderSpawnGlow Auto

Ingredient  Property ChaurusEgg Auto
Ingredient  Property SwampFungalPod01 Auto ; mind control spiders
Ingredient  Property DwarvenOil Auto ; oil spiders
Ingredient  Property FireflyThorax Auto ; glow spiders

SPELL Property ChaurusArmor Auto
SPELL Property ChaurusMask Auto
Spell Property CallSpawns Auto
Spell Property DismissSpawns Auto


Event OnEffectStart(Actor Target, Actor Caster)
	Actor kPlayer = Game.GetPlayer()
	Actorbase EncChaurusActorBase

 	Int iRandomNum = utility.randomint(0,100)
 	Int iChaurusQueenStage = StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage")
 	Int iChaurusSpawnCount
 	Int iChaurusEggsCount = kPlayer.GetItemCount(ChaurusEgg)
 	Int iChaurusSpawnListMax = 10

	if (!kPlayer.HasSpell( CallSpawns ))
		kPlayer.AddSpell( CallSpawns ) 
		kPlayer.AddSpell( DismissSpawns ) 
	endif

	if (iChaurusEggsCount>5)
		iChaurusSpawnCount = 5
	elseif (iChaurusEggsCount>0)
		iChaurusSpawnCount = iChaurusEggsCount 
	endif

	if (iChaurusSpawnCount>0)
		Debug.trace("[SLP] SLP_MEF_SeedSpawnChaurus") 


		if (!kPlayer.HasSpell( ChaurusArmor ))
			kPlayer.RemoveItem(ChaurusEgg, iChaurusSpawnCount)
	 		kPlayer.AddSpell( ChaurusArmor ) 
	 		kPlayer.AddSpell( ChaurusMask ) 

	 		; fctParasites.infectChaurusQueenArmor( kPlayer  )
	 		; fctParasites.infectChaurusQueenGag( kPlayer  )
	 		ChaurusArmor.Cast(kPlayer as ObjectReference, kPlayer as ObjectReference)	
			ChaurusMask.Cast(kPlayer as ObjectReference, kPlayer as ObjectReference)	

			Debug.messagebox("In a flash, the Seed ingests material from the egg and spreads it around your skin into a thin protective layer of mucus and chitin.") 

		else
			Debug.notification("Chaurus spawn from your egg sac.") 

			if (iRandomNum>90) && (kPlayer.GetItemCount(SwampFungalPod01)>0)
				kPlayer.RemoveItem(ChaurusEgg, iChaurusSpawnCount)
				kPlayer.AddItem(SpiderSpawnMind, iChaurusSpawnCount)
				kPlayer.RemoveItem(SwampFungalPod01, 1)

			elseif (iRandomNum>70) && (kPlayer.GetItemCount(DwarvenOil)>0)
				kPlayer.RemoveItem(ChaurusEgg, iChaurusSpawnCount)
				kPlayer.AddItem(SpiderSpawnOil, iChaurusSpawnCount)
				kPlayer.RemoveItem(DwarvenOil, 1)

			elseif (iRandomNum>80) && (kPlayer.GetItemCount(FireflyThorax)>0)
				kPlayer.RemoveItem(ChaurusEgg, iChaurusSpawnCount)
				kPlayer.AddItem(SpiderSpawnGlow, iChaurusSpawnCount)
				kPlayer.RemoveItem(FireflyThorax, 1)

			else
				; spawn chaurus helpers here 
				Int valueCount = StorageUtil.FormListCount(none, "_SLP_lChaurusSpawnsList")

				if (valueCount<iChaurusSpawnListMax)
					; if the list isn't full, add the chaurus
					
					kPlayer.RemoveItem(ChaurusEgg, iChaurusSpawnCount)
					fctParasites.getRandomChaurusSpawn(kPlayer)
				endif

				; Debug
				fctParasites.displayChaurusSpawnList()

			endif

	 	endif

 	else
		Debug.notification("Without chaurus eggs near you, the spell has no effect.") 

	endif

	; clean up list from dead actors  
	fctParasites.cleanChaurusSpawnList()
 
    ;   Debug.Messagebox(" Spider Pheromone charm spell started")    
	
EndEvent
 


Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
    ;	SpiderFollowerAlias.Clear()
ENDEVENT


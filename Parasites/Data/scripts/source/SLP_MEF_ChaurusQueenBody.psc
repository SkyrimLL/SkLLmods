Scriptname SLP_MEF_ChaurusQueenBody extends activemagiceffect  

SLP_fcts_parasites Property fctParasites  Auto
Ingredient  Property ChaurusEgg Auto
  
SPELL Property ChaurusSpit Auto
SPELL Property ChaurusAcid Auto


Event OnEffectStart(Actor Target, Actor Caster)
	Actor kPlayer = Game.GetPlayer()
 	Int iChaurusQueenStage = StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage")
 
 	Int iChaurusSpawnCount
 	Int iChaurusEggsCount = kPlayer.GetItemCount(ChaurusEgg)

	if (iChaurusEggsCount>6)
		iChaurusSpawnCount = 6
	; elseif (iChaurusEggsCount>0)
	;	iChaurusSpawnCount = iChaurusEggsCount 
	endif

	kPlayer.AddSpell( ChaurusSpit )  
	kPlayer.AddSpell( ChaurusAcid )  

	if (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenBody" ))

		if (iChaurusSpawnCount>0)
			kPlayer.RemoveItem(ChaurusEgg, iChaurusSpawnCount)

	 		if (fctParasites.isInfectedByString( kPlayer,  "LivingArmor" ))
	 			fctParasites.cureParasiteByString(kPlayer, "LivingArmor")
	 		endif

	 		if (fctParasites.isInfectedByString( kPlayer,  "TentacleMonster" ))
	 			fctParasites.cureParasiteByString(kPlayer, "TentacleMonster")
	 		endif

	 		if (fctParasites.isInfectedByString( kPlayer,  "Barnacles" ))
	 			fctParasites.cureParasiteByString(kPlayer, "Barnacles")
	 		endif

	 		if (fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenSkin" ))
	 			fctParasites.cureParasiteByString(kPlayer, "ChaurusQueenSkin")
	 		endif

	 		if (fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenArmor" ))
	 			fctParasites.cureParasiteByString(kPlayer, "ChaurusQueenArmor")
	 		endif

			fctParasites.infectParasiteByString(kPlayer, "ChaurusQueenBody")
	 	else
			Debug.notification("Without at least six chaurus egg near you, the spell has no effect.") 
		endif
	else
		fctParasites.cureParasiteByString(kPlayer, "ChaurusQueenBody")
	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
    ;	SpiderFollowerAlias.Clear()
ENDEVENT
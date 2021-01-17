Scriptname SLP_MEF_ChaurusQueenArmor extends activemagiceffect  

SLP_fcts_parasites Property fctParasites  Auto
Ingredient  Property ChaurusEgg Auto
 
Event OnEffectStart(Actor Target, Actor Caster)
	Actor kPlayer = Game.GetPlayer()
 	Int iChaurusQueenStage = StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage")
 	Int iChaurusSpawnCount
 	Int iChaurusEggsCount = kPlayer.GetItemCount(ChaurusEgg)

	if (iChaurusEggsCount>3)
		iChaurusSpawnCount = 3
	; elseif (iChaurusEggsCount>0)
	;	iChaurusSpawnCount = iChaurusEggsCount 
	endif


	if (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenArmor" ))

		if (iChaurusSpawnCount>0)
			kPlayer.RemoveItem(ChaurusEgg, iChaurusSpawnCount)
 
 	 		if (fctParasites.isInfectedByString( kPlayer,  "LivingArmor" ))
	 			fctParasites.cureLivingArmor( kPlayer )
	 		endif

	 		if (fctParasites.isInfectedByString( kPlayer,  "TentacleMonster" ))
	 			fctParasites.cureTentacleMonster( kPlayer )
	 		endif

	 		if (fctParasites.isInfectedByString( kPlayer,  "Barnacles" ))
	 			fctParasites.cureBarnacles( kPlayer )
	 		endif

	 		if (fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenSkin" ))
	 			fctParasites.cureChaurusQueenSkin( kPlayer )
	 		endif

	 		if (fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenBody" ))
	 			fctParasites.cureChaurusQueenBody( kPlayer )
	 		endif

			fctParasites.infectChaurusQueenArmor( kPlayer )
	 	else
			Debug.notification("Without at least three chaurus egg near you, the spell has no effect.") 
		endif

	else
		fctParasites.cureChaurusQueenArmor( kPlayer )
	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
    ;	SpiderFollowerAlias.Clear()
ENDEVENT
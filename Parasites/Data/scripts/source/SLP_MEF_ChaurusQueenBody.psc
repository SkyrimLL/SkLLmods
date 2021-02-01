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

	 		if (fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenArmor" ))
	 			fctParasites.cureChaurusQueenArmor( kPlayer )
	 		endif

			fctParasites.infectChaurusQueenBody( kPlayer )
	 	else
			Debug.notification("Without at least six chaurus egg near you, the spell has no effect.") 
		endif
	else
		fctParasites.cureChaurusQueenBody( kPlayer )
	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
    ;	SpiderFollowerAlias.Clear()
ENDEVENT
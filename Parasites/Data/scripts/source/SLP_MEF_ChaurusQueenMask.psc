Scriptname SLP_MEF_ChaurusQueenMask extends activemagiceffect  

SLP_fcts_parasites Property fctParasites  Auto
Ingredient  Property ChaurusEgg Auto
  

Event OnEffectStart(Actor Target, Actor Caster)
	Actor kPlayer = Game.GetPlayer()
 	Int iChaurusQueenStage = StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage")
 	Int iChaurusSpawnCount
 	Int iChaurusEggsCount = kPlayer.GetItemCount(ChaurusEgg)

	if (iChaurusEggsCount>1)
		iChaurusSpawnCount = 1
	; elseif (iChaurusEggsCount>0)
	;	iChaurusSpawnCount = iChaurusEggsCount 
	endif

	if (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenGag" ))

		if (iChaurusSpawnCount>0)
			kPlayer.RemoveItem(ChaurusEgg, iChaurusSpawnCount)

 	 		if (fctParasites.isInfectedByString( kPlayer,  "FaceHuggerGag" ))
	 			fctParasites.cureFaceHuggerGag( kPlayer )
	 		endif

			fctParasites.infectChaurusQueenGag( kPlayer )
		else
			Debug.notification("Without at least one chaurus egg near you, the spell has no effect.") 
		endif

	else
		fctParasites.cureChaurusQueenGag( kPlayer )
	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
    ;	SpiderFollowerAlias.Clear()
ENDEVENT
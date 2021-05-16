Scriptname SLP_TRG_CreepClusterHarvest extends ObjectReference  

SLP_fcts_parasites Property fctParasites  Auto
Ingredient Property CreepyCluster  Auto

Event OnActivate(ObjectReference akActionRef)
	Actor kPlayer = Game.GetPlayer()
	Int iChaurusQueenStage = StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage")

  	; Debug.Trace("Activated by " + akActionRef)

  	If (akActionRef==kPlayer) && (Utility.RandomInt(1,100) <= StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceEstrusTentacles")) && (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenArmor" )) && (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenBody" ))
  		fctParasites.infectParasiteByString(kPlayer, "EstrusTentacles")
  	Endif

  	kPlayer.AddItem(CreepyCluster, Utility.RandomInt(1,3) )

EndEvent
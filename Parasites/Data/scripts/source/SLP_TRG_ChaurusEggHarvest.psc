Scriptname SLP_TRG_ChaurusEggHarvest extends ObjectReference  

SLP_fcts_parasites Property fctParasites  Auto

Event OnActivate(ObjectReference akActionRef)
	Actor kPlayer = Game.GetPlayer()
  	; Debug.Trace("Activated by " + akActionRef)

  	If (akActionRef==kPlayer) && (Utility.RandomInt(1,100) <= StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceEstrusTentacles"))
		fctParasites.infectEstrusTentacles( kPlayer   )
  	Endif
EndEvent
Scriptname SLP_ChaurusQueenEnd extends ObjectReference  

Quest Property QueenOfChaurusQuest  Auto 

SLP_fcts_parasites Property fctParasites  Auto

SPELL Property ChaurusBody Auto

ObjectReference Property DimensionalRiftRef Auto

Event OnDeath(Actor akKiller) 
	Actor kPlayer = Game.GetPlayer()
	ObjectReference kPlayerRef = kPlayer as ObjectReference
	
	debug.messagebox("Once the Tonal device was activated, the Queen found herself on this side of the Rift. In the end, it was a fight for her own survival. Killing her was the only way to ensure the survival of her species... now yours. The Queen is dead, Long Live the Queen!")

 	QueenOfChaurusQuest.SetStage(400)

 	kPlayer.AddSpell(ChaurusBody)

 	fctParasites.getRandomChaurusEggs(kPlayer, 6, 10)

 	ChaurusBody.cast(kPlayerRef, kPlayerRef)
		
EndEvent
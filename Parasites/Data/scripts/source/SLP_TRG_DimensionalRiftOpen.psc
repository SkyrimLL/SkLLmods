Scriptname SLP_TRG_DimensionalRiftOpen extends ObjectReference  

ObjectReference Property DimensionalRiftDoorMarkerRef  Auto  

SLP_fcts_parasites Property fctParasites  Auto

Quest Property QueenOfChaurusQuest  Auto 

Event OnTriggerEnter(ObjectReference akActionRef)
 	Actor kPlayer = Game.GetPlayer()
 	ObjectReference kPlayerRef = kPlayer as ObjectReference

    if (akActionRef == kPlayerRef) 
		if (fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenArmor" )) && (fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenGag" )) && (QueenOfChaurusQuest.GetStageDone(380)==1) && (QueenOfChaurusQuest.GetStageDone(390)==0)
			DimensionalRiftDoorMarkerRef.enable()
		else
			DimensionalRiftDoorMarkerRef.disable()
		endif
 
	EndIf
EndEvent
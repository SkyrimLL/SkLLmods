Scriptname SLP_TRG_DimensionalRiftOpen extends ObjectReference  

ObjectReference Property DimensionalRiftDoorMarkerRef  Auto  

ObjectReference Property DimensionalRiftQueenMarkerRef  Auto  

SLP_fcts_parasites Property fctParasites  Auto

Quest Property QueenOfChaurusQuest  Auto 

Event OnTriggerEnter(ObjectReference akActionRef)
 	Actor kPlayer = Game.GetPlayer()
 	ObjectReference kPlayerRef = kPlayer as ObjectReference

    if (akActionRef == kPlayerRef) 
		if (fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenArmor" )) && (fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenGag" )) && (QueenOfChaurusQuest.GetStageDone(380)==1) && (QueenOfChaurusQuest.GetStageDone(400)==0)
			; 380 - After jumping into the Abyss and 400 - before closing the portal

			DimensionalRiftDoorMarkerRef.enable()

			Debug.notification("The Rift reacts to your armor and opens up.")

		elseif ( (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenArmor" )) || (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenGag" )) ) && (QueenOfChaurusQuest.GetStageDone(380)==1) && (QueenOfChaurusQuest.GetStageDone(390)==0)
			; 380 - After jumping into the Abyss and 400 - before closing the portal

			DimensionalRiftDoorMarkerRef.disable()

			Debug.Messagebox("The air flickers with echoes from the other side but the Rift remains closed to you. The Seed inside you churns and makes your skin shiver with the desire to wear the full chaurus armor and mask.")

		elseif ( (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenArmor" )) || (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenGag" )) ) && (QueenOfChaurusQuest.GetStageDone(380)==1) && (QueenOfChaurusQuest.GetStageDone(400)==0)
			; 380 - After jumping into the Abyss and 400 - before closing the portal

			DimensionalRiftDoorMarkerRef.disable()

			Debug.notification("The Rift is still there,but unreachable without your chaurus armor and mask.")

		elseif ( (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenArmor" )) || (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenGag" )) ) && (QueenOfChaurusQuest.GetStageDone(380)==0) 

			DimensionalRiftDoorMarkerRef.disable()

			Debug.notification("There is something unnatural about this place.")

		elseif (QueenOfChaurusQuest.GetStageDone(400)==1)

			DimensionalRiftDoorMarkerRef.disable()
			DimensionalRiftQueenMarkerRef.Disable()

			Debug.notification("The Rift seems to be closed for good.")

		else 
			; Debug.Messagebox("Without the chaurus armor and mask, you cannot understand what the Queen is trying to tell you.")
			DimensionalRiftDoorMarkerRef.disable()

		endif
 
	EndIf
EndEvent
Scriptname SLP_TRG_ChaurusQueenScene extends ObjectReference 

Quest Property QueenOfChaurusQuest  Auto 

SLP_fcts_parasites Property fctParasites  Auto

Sound Property SummonSoundFX  Auto

Event OnTriggerEnter(ObjectReference akActionRef)
 	Actor kPlayer = Game.GetPlayer()
 	ObjectReference kPlayerRef = kPlayer as ObjectReference

    if (akActionRef == kPlayerRef) 
		if (fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenArmor" )) && (fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenGag" ))
			; DimensionalRiftDoorMarkerRef.enable()

			if (QueenOfChaurusQuest.GetStageDone(380)) && (!QueenOfChaurusQuest.GetStageDone(390)) 

                SummonSoundFX.Play(kPlayer)
   				debug.messagebox("[The mask translates the Queen's speech directly inside your mind]")

   				Utility.wait(1.0)
				
                SummonSoundFX.Play(kPlayer)
				debug.messagebox("You are here.. at last.. my guard can come to an end. I have been trapped here for so long.")

   				Utility.wait(1.0)
				 
				debug.messagebox("It started with this doorway, between my world and yours. These aliens opened a bridge but they could not control it and our worlds collided.")

   				Utility.wait(1.0)

                SummonSoundFX.Play(kPlayer)
				debug.messagebox("Over the ages, I have tried to re build our homeworld, piece by piece. I sent seeds and spores, rocks and vines.. and of course, my children and my eggs. But their caretakers are corrupted and do not know what they must do to help my children thrive.")

   				Utility.wait(1.0)
				 
				debug.messagebox("I tried to protect my children and killed many. This one here was the last. I understood his task when I absorbed his mind, but it was too late. He is carrying a device, a key, that can close the rift from the other side. Go.. please.. correct my mistakes and care for our children.")

   				Utility.wait(1.0)				
				
                SummonSoundFX.Play(kPlayer)
				QueenOfChaurusQuest.SetStage(390)
			endif


		else
			; DimensionalRiftDoorMarkerRef.disable()
		endif
 
	EndIf
EndEvent
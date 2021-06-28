Scriptname SLP_aliasTentacleMonster extends ReferenceAlias  

; Effect
; Chance of estrus tentacles attack if hit

SLP_fcts_parasites Property fctParasites  Auto

Spell Property crSprigganCallCreatures Auto


Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	Actor kPlayer= Game.GetPlayer() as Actor

	If (akTarget == kPlayer)

		; 	debug.trace(self + "Dismissing follower because he is now attacking the player")

	    if (aeCombatState == 0)
	      	; Debug.Trace("We have left combat with the player!")

			If (Utility.RandomInt(0,100)>80)
				;

			EndIf
	    elseif (aeCombatState == 1)
	      	; Debug.Trace("We have entered combat with the player!")

			If (Utility.RandomInt(0,100)>20)
				; 

			EndIf

	    elseif (aeCombatState == 2)
	      	; Debug.Trace("We are searching for the player...")

			If (Utility.RandomInt(0,100)>50)
				; 

			EndIf

	    endIf

	EndIf


EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	Actor kPlayer = Game.GetPlayer()
	Actor kAgressor = akAggressor as Actor

	If (akAggressor != None) && (kAgressor != kPlayer)
		;  Debug.Trace("We were hit by " + akAggressor)
		; Debug.Notification("." )

		Cell akAggressorCell = akAggressor.GetParentCell()

		If (!akAggressorCell.IsInterior())
			if (!(fctParasites.isInfectedByString(kPlayer, "TentacleArmor"  )))
				Debug.Trace("[SLP_aliasTentacleMonster] Defense failed - not infected" )
				return
			endif

			If (Utility.RandomInt(0,100)>97)  
				Debug.Trace("[SLP_aliasTentacleMonster] Cast Call Creatures spell" )
				Debug.Notification("The Voices scream for help." )
				crSprigganCallCreatures.RemoteCast(kPlayer as ObjectReference , kPlayer , akAggressor ) 

			elseIf (Utility.RandomInt(0,100)>94)  
				Debug.Trace("[SLP_aliasTentacleMonster] Cast Tentacle attack spell" )
				Debug.Notification("The Voices extend their reach to your aggressor." ) 
				fctParasites.infectParasiteByString(akAggressor as Actor , "EstrusTentacles")

			endif
		EndIf
	EndIf

EndEvent



Scriptname SLP_aliasSprigganRoot extends ReferenceAlias  

; Effect
; Chance of estrus tentacles attack if hit

SLP_fcts_parasites Property fctParasites  Auto
SLP_fcts_utils Property fctUtils  Auto

Spell Property crSprigganCallCreatures Auto
Spell Property _SLP_SP_SprigganCallCreatures Auto


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

	If (akAggressor != None)
		;  Debug.Trace("We were hit by " + akAggressor)
		; Debug.Notification("." )

		Cell akAggressorCell = akAggressor.GetParentCell()

		If (!akAggressorCell.IsInterior()) && (kAgressor != kPlayer)
			if (fctUtils.CheckIfSprigganFaction( kAgressor ))
				; Debug.Notification("[SLP_aliasSprigganRoot] Spriggan friendly hit - Stop combat" )
				; Debug.Trace("[SLP_aliasSprigganRoot]  Spriggan friendly hit - Stop combat" )

				; SendModEvent("da_PacifyNearbyEnemies") 
				_SLP_SP_SprigganCallCreatures.Cast(kPlayer as ObjectReference ,  kPlayer as ObjectReference ) 

			else
				if (!(fctParasites.infectParasiteByString(kPlayer, "SprigganRoot"  )))
					return
				endif

				If (Utility.RandomInt(0,100)>97)  
					Debug.Trace("[SLP_aliasSprigganRoot] Cast Call Creatures spell" )
					; Debug.Notification("The Voices scream for help." )
					_SLP_SP_SprigganCallCreatures.Cast(kPlayer as ObjectReference ,  kPlayer as ObjectReference ) 

				elseIf (Utility.RandomInt(0,100)>94)  
					Debug.Trace("[SLP_aliasSprigganRoot] Cast Tentacle attack spell" )
					; Debug.Notification("The Voices extend their reach to your aggressor." )
					; fctParasites.infectEstrusTentacles( akAggressor as Actor )

				endif
			endif
		EndIf
	EndIf

EndEvent



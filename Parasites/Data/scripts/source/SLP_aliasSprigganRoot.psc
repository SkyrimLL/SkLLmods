Scriptname SLP_aliasSprigganRoot extends ReferenceAlias  

; Effect
; Chance of estrus tentacles attack if hit

SLP_fcts_parasites Property fctParasites  Auto
SLP_fcts_utils Property fctUtils  Auto

Spell Property crSprigganCallCreatures Auto
Spell Property _SLP_SP_SprigganCallCreatures Auto
Spell Property _SLP_SP_SprigganSwarm Auto
Spell Property _SLP_SP_SprigganAttack Auto
SPELL Property _SLP_SP_SprigganDefenseCloak  Auto  

Spell Property Oakflesh Auto

Sound Property CritterFX  Auto

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
	Int iRandomNum = Utility.RandomInt(0,100)

	If (akAggressor != None)
		;  Debug.Trace("We were hit by " + akAggressor)

		Cell akAggressorCell = akAggressor.GetParentCell()

		If (!akAggressorCell.IsInterior()) && (kAgressor != kPlayer)
			; Debug.Notification(":SPRIGGAN HIT:" )

			if (fctUtils.checkIfFriendlyFaction( kAgressor, "Spriggan" ))
				; Debug.Notification("[SLP_aliasSprigganRoot] Spriggan friendly hit - Stop combat" )
				Debug.Trace("[SLP_aliasSprigganRoot]  Spriggan friendly hit - Stop combat" )

				Sound.SetInstanceVolume(CritterFX.Play(kPlayer), 1.0)
				Utility.Wait(1.0)

				; SendModEvent("da_PacifyNearbyEnemies") 
				_SLP_SP_SprigganCallCreatures.Cast(kPlayer as ObjectReference ,  kPlayer as ObjectReference ) 

			else
				if (!(fctParasites.isInfectedByString(kPlayer, "SprigganRoot"  )))
					Debug.Trace("[SLP_aliasSprigganRoot] Defense failed - not infected" )
					return
				endif

				Sound.SetInstanceVolume(CritterFX.Play(kPlayer), 1.0)
				Utility.Wait(1.0)

				If (iRandomNum>97)  
					Debug.Trace("[SLP_aliasSprigganRoot] Cast Call Creatures spell" )
					Debug.Notification("The roots call out for help." )
					_SLP_SP_SprigganCallCreatures.Cast(kPlayer as ObjectReference ,  kPlayer as ObjectReference ) 

				elseIf (iRandomNum>80)  
					; Debug.Trace("[SLP_aliasSprigganRoot] Cast Tentacle attack spell" )
					Debug.Notification("The roots unleashes needles to protect you" )
					_SLP_SP_SprigganDefenseCloak.Cast(kPlayer as ObjectReference ,  kAgressor as ObjectReference ) 

				elseIf (iRandomNum>50)  
					Debug.Trace("[SLP_aliasSprigganRoot] Cast Tentacle attack spell" )
					Debug.Notification("The roots harden around you" )
					Oakflesh.Cast(kPlayer as ObjectReference ,  kPlayer as ObjectReference ) 

				else 
					Debug.trace("[SLP_aliasSprigganRoot] No protection - better luck next time" )

				endif
			endif
		EndIf
	EndIf

EndEvent




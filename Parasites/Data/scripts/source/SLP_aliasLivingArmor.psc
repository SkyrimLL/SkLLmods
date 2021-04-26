Scriptname SLP_aliasLivingArmor extends ReferenceAlias  

; Effect
; Chance of oakflash spell on self if hit
; Equivalent effect to squid ink? if hit

SLP_fcts_parasites Property fctParasites  Auto

Spell Property StoneFlesh Auto
Spell Property DA02PoisonCloakDmg Auto

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

	If (akAggressor != None)
		;  Debug.Trace("We were hit by " + akAggressor)
		; Debug.Notification("." )

		If (Utility.RandomInt(0,100)>97)  
			Debug.Trace("[SLP_aliasLivingArmor] Cast stone flesh" )
			Debug.MessageBox("The creature wraps you with a protective layer of slime." )
			StoneFlesh.Cast(kPlayer as ObjectReference , kPlayer as ObjectReference ) 

		elseIf (Utility.RandomInt(0,100)>94)  
			Debug.Trace("[SLP_aliasLivingArmor] Cast Poison cloak" )
			Debug.MessageBox("The creature releses a poisonous gas." )
			DA02PoisonCloakDmg.Cast(kPlayer as ObjectReference , kPlayer as ObjectReference ) 
			
		endif
	EndIf

EndEvent
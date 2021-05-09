Scriptname SLP_aliasBarnacles extends ReferenceAlias  

; Effect
; Chance of poison gas if hit

SLP_fcts_parasites Property fctParasites  Auto

Spell Property DLC2ExpSpiderShockCloakAb Auto
Spell Property MassParalysis Auto

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

		If (Utility.RandomInt(0,100)>80)  
			Debug.Trace("[SLP_aliasBarnacles] Cast Poison cloak" )
			Debug.Notification("The spores release a poisonous cloud." )

			MassParalysis.Cast(kPlayer as ObjectReference ,  kPlayer as ObjectReference ) 
			
		endif
	EndIf

EndEvent
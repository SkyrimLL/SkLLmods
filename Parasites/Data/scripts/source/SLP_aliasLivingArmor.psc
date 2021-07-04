Scriptname SLP_aliasLivingArmor extends ReferenceAlias  

; Effect
; Chance of oakflash spell on self if hit
; Equivalent effect to squid ink? if hit

SLP_fcts_parasites Property fctParasites  Auto

Spell Property StoneFlesh Auto
Spell Property DA02PoisonCloakDmg Auto
Spell Property MassParalysis Auto
Spell Property SchockCloak Auto

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

	If (akAggressor != None) && (kAgressor != kPlayer)
		;  Debug.Trace("We were hit by " + akAggressor)
		; Debug.Notification("." )
		if (!(fctParasites.isInfectedByString(kPlayer, "LivingArmor"  )))
			Debug.Trace("[SLP_aliasLivingArmor] Defense failed - not infected" )
			return
		endif

		Sound.SetInstanceVolume(CritterFX.Play(kPlayer), 1.0)
		Utility.Wait(1.0)

		If (iRandomNum>97)  
			Debug.Trace("[SLP_aliasLivingArmor] Cast stone flesh" )
			Debug.Notification("The creature wraps you with a protective layer of slime." )
			StoneFlesh.Cast(kPlayer as ObjectReference , kPlayer as ObjectReference ) 

		elseIf (iRandomNum>90)  
			Debug.Trace("[SLP_aliasLivingArmor] Cast Poison cloak" )
			Debug.Notification("The creature releases a surge of electricity." )
			SchockCloak.Cast(kPlayer as ObjectReference , kPlayer as ObjectReference ) 
			
		endif
	EndIf

EndEvent
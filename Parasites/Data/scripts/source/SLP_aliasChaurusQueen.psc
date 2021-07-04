Scriptname SLP_aliasChaurusQueen extends ReferenceAlias  

; Effect
; Chance of equip chaurus queen armor or body if hit
; Chance of creating or summoning spwans if hit

SLP_fcts_parasites Property fctParasites  Auto

SPELL Property ChaurusArmor Auto 
SPELL Property ChaurusBody Auto 
SPELL Property ChaurusMask Auto 
Spell Property CallSpawns Auto
SPELL Property SeedSpawnSpider Auto
SPELL Property SeedSpawnChaurus Auto

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

		Sound.SetInstanceVolume(CritterFX.Play(kPlayer), 1.0)
		Utility.Wait(1.0)

		If (iRandomNum>97) && (kPlayer.HasSpell( CallSpawns )) 
			Debug.Trace("[SLP_aliasChaurusQueen] Call chaurus spawns" )
			Debug.Notification("The Seed calls your brood for help." )
			CallSpawns.Cast(kPlayer as ObjectReference  , kPlayer as ObjectReference ) 

		elseIf (iRandomNum>94) && (kPlayer.HasSpell( CallSpawns )) 
			Debug.Trace("[SLP_aliasChaurusQueen] Call chaurus spawns" )
			Debug.Notification("The Seed calls your brood for help." )

			if (kPlayer.HasSpell( SeedSpawnChaurus ))
				SeedSpawnChaurus.Cast(kPlayer as ObjectReference  , kPlayer as ObjectReference ) 

			elseif (kPlayer.HasSpell( SeedSpawnSpider ))
				SeedSpawnSpider.Cast(kPlayer as ObjectReference  , kPlayer as ObjectReference ) 
			endif

		elseIf (iRandomNum>92) && (kPlayer.HasSpell( ChaurusMask )) 
			Debug.Trace("[SLP_aliasChaurusQueen] Cast Chaurus Body spell" )

			; if (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenBody" ))
			;	Debug.Notification("The Seed reacts to the attack with an armor around you." )
			;	ChaurusBody.Cast(kPlayer as ObjectReference , kPlayer as ObjectReference ) 
			; endif

			if (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenGag" ))
				ChaurusMask.Cast(kPlayer as ObjectReference , kPlayer as ObjectReference ) 
			endif
			
		elseIf (iRandomNum>88) && (kPlayer.HasSpell( ChaurusMask )) 
			Debug.Trace("[SLP_aliasChaurusQueen] Cast Chaurus Armor spell" )

			; if (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenArmor" ))
			;	Debug.Notification("The Seed reacts to the attack with an armor around you." )
			;	ChaurusArmor.Cast(kPlayer as ObjectReference , kPlayer as ObjectReference ) 
			; endif

			if (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenGag" ))
				ChaurusMask.Cast(kPlayer as ObjectReference , kPlayer as ObjectReference ) 
			endif
			
		endif
	EndIf

EndEvent
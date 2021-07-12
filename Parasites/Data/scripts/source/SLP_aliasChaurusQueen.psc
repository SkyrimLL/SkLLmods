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
SPELL Property ChaurusBlade Auto
SPELL Property ChaurusClaw Auto

Sound Property CritterFX  Auto



Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	Actor kPlayer = Game.GetPlayer()
	Actor kAgressor = akAggressor as Actor
	Int iRandomNum = Utility.RandomInt(0,100)

	If (akAggressor != None) && (kAgressor != kPlayer)
		;  Debug.Trace("We were hit by " + akAggressor)
		; Debug.Notification("." )

		Sound.SetInstanceVolume(CritterFX.Play(kPlayer), 1.0)
		Utility.Wait(1.0)

		; If (iRandomNum>95) && (kPlayer.HasSpell( CallSpawns )) 
		;	Debug.Trace("[SLP_aliasChaurusQueen] Call chaurus spawns" )
		;	Debug.Notification("The Seed calls your brood for help." )
		;	CallSpawns.Cast(kPlayer as ObjectReference  , kPlayer as ObjectReference ) 

		;else
		If (iRandomNum>90) && (kPlayer.HasSpell( CallSpawns )) 
			Debug.Trace("[SLP_aliasChaurusQueen] Seed spawns" )
			Debug.Notification("The Seed consumes eggs to protect you." )

			if (kPlayer.HasSpell( SeedSpawnChaurus ))
				SeedSpawnChaurus.Cast(kPlayer as ObjectReference  , kPlayer as ObjectReference ) 

			elseif (kPlayer.HasSpell( SeedSpawnSpider ))
				SeedSpawnSpider.Cast(kPlayer as ObjectReference  , kPlayer as ObjectReference ) 
			endif

		elseIf (iRandomNum>80) && (kPlayer.HasSpell( ChaurusMask )) 
			Debug.Trace("[SLP_aliasChaurusQueen] Cast Chaurus Armor spell" )

			; if (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenBody" ))
			;	Debug.Notification("The Seed reacts to the attack with an armor around you." )
			;	ChaurusBody.Cast(kPlayer as ObjectReference , kPlayer as ObjectReference ) 
			; endif

			if (!fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenGag" ))
				ChaurusMask.Cast(kPlayer as ObjectReference , kPlayer as ObjectReference ) 
			endif
			
		elseIf (iRandomNum>60) && (fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenArmor" )) && (StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusQueenWeapon")==0)
			Debug.Trace("[SLP_aliasChaurusQueen] Cast Chaurus Blade spell" )

			; ChaurusBlade.Cast(kPlayer as ObjectReference , kPlayer as ObjectReference ) 
			fctParasites.extendChaurusWeapon( kPlayer,  "ChaurusBlade") 

			
		elseIf (iRandomNum>60) && (fctParasites.isInfectedByString( kPlayer,  "ChaurusQueenBody" )) && (StorageUtil.GetIntValue(kPlayer, "_SLP_toggleChaurusQueenWeapon")==0)
			Debug.Trace("[SLP_aliasChaurusQueen] Cast Chaurus Claw spell" )

			; ChaurusClaw.Cast(kPlayer as ObjectReference , kPlayer as ObjectReference ) 
			fctParasites.extendChaurusWeapon( kPlayer,  "ChaurusClaw") 
			
		endif
	EndIf

EndEvent
Scriptname SLSDDi_SP_WabbajackSelfFF extends ActiveMagicEffect  


; the gold
MISCOBJECT PROPERTY gold AUTO

; the sweet roll
POTION PROPERTY sweetRoll AUTO
MISCOBJECT PROPERTY plate AUTO

; the heal spell
SPELL PROPERTY healSpell AUTO

; invisibilty spell
SPELL PROPERTY invis AUTO

; the fire/frost/storm spell
EXPLOSION PROPERTY fireSpell AUTO
EXPLOSION PROPERTY frostSpell AUTO
EXPLOSION PROPERTY stormSpell AUTO

; a skeever
ACTORBASE PROPERTY skeever AUTO
ACTORBASE PROPERTY wolf AUTO
ACTORBASE PROPERTY bandit AUTO
ACTORBASE PROPERTY draugr AUTO
ACTORBASE PROPERTY falmer AUTO
ACTORBASE PROPERTY dragonPriest AUTO
ACTORBASE PROPERTY atronach AUTO

; ally
FACTION PROPERTY playerFaction AUTO

; //THE STUFF FOR THE EXPLOSION
EXPLOSION PROPERTY forceExplosion AUTO
EXPLOSION PROPERTY visualExplosion AUTO

OBJECTREFERENCE PROPERTY explosionMarker AUTO
EFFECTSHADER PROPERTY wabbaHitEffect AUTO

SPELL PROPERTY ghostSpell AUTO

INT randEffect=0
ACTORBASE ghostNPC
OBJECTREFERENCE npcChanged
OBJECTREFERENCE newCreature

KEYWORD PROPERTY keyWabbajackExcluded Auto
KEYWORD PROPERTY keyGiant AUTO
KEYWORD PROPERTY keyDragon AUTO

; //TRANSMOGRIFY VARIABLES
OBJECTREFERENCE objStore
OBJECTREFERENCE newRefStore
ACTORBASE PROPERTY chicken AUTO
ACTORBASE PROPERTY mudcrab AUTO
ACTORBASE PROPERTY rabbit AUTO
ACTORBASE PROPERTY dremora AUTO
dunTransmogrifyAnimal mainScript

; //WE madwoman
ACTORBASE PROPERTY madWoman AUTO

; //////////
; //ASH PILE VARIABLES
; //////////
float property fDelay = 0.75 auto
{time to wait before Spawning Ash Pile}
float property fDelayEnd = 1.65 auto
{time to wait before Removing Base Actor}
float property ShaderDuration = 0.00 auto
{Duration of Effect Shader.}
Activator property pDefaultAshPileGhost auto
{The object we use as a pile.}
Bool property bSetAlphaZero = True auto
{The Effect Shader we want.}
FormList Property pDisintegrationMainImmunityList auto
{If the target is in this list, they will not be disintegrated.}
EFFECTSHADER PROPERTY pGhostDeathFXShader AUTO
{the shader to play while dying}

race VictimRace
ACTOR victim
bool TargetIsImmune = True

EVENT onEffectStart(Actor akTarget, Actor akCaster)
	Actor kPlayer =  game.getPlayer()
	victim = akTarget

	IF (akCaster == kPlayer) && (akTarget == kPlayer)
		; Debug.Notification("Wabbajack!")
		; If player casts on him/herself
		randEffect = utility.randomInt(1, 100)
		explosionMarker.moveTo(akTarget)

		; /////////////
		; //CHOOSE WHAT WE'RE RANDOMLY DOING
		IF(randEffect >= 1 && randEffect < 51)
			healSpell.cast(akTarget, akTarget)
		
		ELSEIF(randEffect >= 72 && randEffect < 77)
			castInvis(akTarget)

		ELSEIF(randEffect >= 89 && randEffect < 96)
			spawnGold(akTarget)
				
		ELSEIF(randEffect >= 96 && randEffect < 98)
			spawnSweetRoll(akTarget)
			
		ELSEIF(randEffect >= 98) && (StorageUtil.GetIntValue(none, "_SLH_iHormones")!=1)
		; 	cast hormone scrambling effect
			Debug.Notification("You feel dizzy and very hot.")
			kPlayer.SendModEvent("SLHModHormoneRandom", "Succubus")
		
		ENDIF

	else
	
		randEffect = utility.randomInt(1, 100)
		explosionMarker.moveTo(akTarget)
		
		IF(akTarget.isEssential())
			randEffect = 1
		ELSEIF(akTarget.hasKeyword(keyWabbajackExcluded))
			randEffect = 1
		ELSEIF(akTarget.hasKeyword(keyGiant))
			randEffect = 1
		ELSEIF(akTarget.hasKeyword(keyDragon))
			randEffect = 1
		ELSEIF(akTarget.isCommandedActor())
			randEffect = 1
		ELSEIF(akTarget.getBaseObject() == madwoman)
			randEffect = 60
		ENDIF

		; /////////////
		; //CHOOSE WHAT WE'RE RANDOMLY DOING
		IF(randEffect >= 1 && randEffect < 51)
			elementalEffect(akTarget)
		
		ELSEIF(randEffect >= 51 && randEffect < 58)
			randomCreatureChicken(akTarget)			
			
		ELSEIF(randEffect >= 58 && randEffect < 65)
			randomCreatureRabbit(akTarget)	
			
		ELSEIF(randEffect >= 65 && randEffect < 77)
			randomCreatureMudcrab(akTarget)	
		
		; ELSEIF(randEffect >= 72 && randEffect < 77)
		; 	castInvis(akTarget)

		ELSEIF(randEffect >= 77 && randEffect < 82)
			hsmTransfer(akTarget)
			
		ELSEIF(randEffect >= 82 && randEffect < 89)
			randomCreatureDremora(akTarget)

		ELSEIF(randEffect >= 89 && randEffect < 94)
			healSpell.cast(akTarget, akTarget)
			
		ELSEIF(randEffect >= 94 && randEffect < 96)
			spawnGold(akTarget)
				
		ELSEIF(randEffect >= 96 && randEffect < 98)
			spawnSweetRoll(akTarget)
			
		ELSEIF(randEffect >= 98)
			akTarget.kill(game.getPlayer())
		
		ENDIF
		
		
	ENDIF

ENDEVENT

FUNCTION basicDamage(ACTOR targ)

ENDFUNCTION

FUNCTION randomCreatureChicken(ACTOR targ)

	targ.disable()
			
	newRefStore = targ.placeAtMe(chicken)
	
	; //setting the master script to be the one with the stored vars
	mainScript = newRefstore AS dunTransmogrifyAnimal
	mainScript.storedActor = targ
	
	targ.stopCombat()
	
ENDFUNCTION

FUNCTION randomCreatureMudcrab(ACTOR targ)

	targ.disable()
			
	newRefStore = targ.placeAtMe(mudcrab)
	
	; //setting the master script to be the one with the stored vars
	mainScript = newRefstore AS dunTransmogrifyAnimal
	mainScript.storedActor = targ
	
	targ.stopCombat()
	
ENDFUNCTION

FUNCTION randomCreatureRabbit(ACTOR targ)

	targ.disable()
			
	newRefStore = targ.placeAtMe(rabbit)
	
	; //setting the master script to be the one with the stored vars
	mainScript = newRefstore AS dunTransmogrifyAnimal
	mainScript.storedActor = targ
	
	targ.stopCombat()
	
ENDFUNCTION

FUNCTION randomCreatureDremora(ACTOR targ)

	targ.disable()
			
	newRefStore = targ.placeAtMe(dremora)
	
	; //setting the master script to be the one with the stored vars
	mainScript = newRefstore AS dunTransmogrifyAnimal
	mainScript.storedActor = targ
	
	targ.stopCombat()
	
ENDFUNCTION

FUNCTION spawnGhostFriend(ACTOR targ)
	
	targ.placeAtMe(visualExplosion)
	
	ACTOR tempNPC = (targ.placeAtMe(targ.getBaseObject()) as ACTOR)
	tempNPC.addSpell(ghostSpell)
	tempNPC.removeFromAllFactions()
	tempNPC.setFactionRank(playerFaction, 5)
	tempNPC.setGhost(TRUE)
			
	utility.wait(10)
	
	explosionMarker.setPosition(tempNPC.x, tempNPC.y, (tempNPC.z + 75))
	tempNPC.placeAtMe(visualExplosion)
	
	utility.wait(0.5)
	
	tempNPC.disable()

ENDFUNCTION

FUNCTION elementalEffect(ACTOR targ)
	
	int rand = utility.randomInt(1,3)
	explosionMarker.setPosition(targ.x, targ.y, (targ.z + 75))
		
	IF(rand == 1)
		targ.placeAtMe(fireSpell)
		targ.damageAV("Health", 60)
	
	ELSEIF(rand == 2)
		targ.placeAtMe(frostSpell)
		targ.damageAV("Health", 60)
	
	ELSEIF(rand == 3)
		targ.placeAtMe(stormSpell)
		targ.damageAV("Health", 60)
	
	ENDIF

ENDFUNCTION

FUNCTION castInvis(ACTOR targ)

	float baseMagicka = targ.getAV("magicka")
	float baseIllusion = targ.getAV("Illusion")
	
	targ.setAV("magicka", 200)
	targ.setAV("Illusion", 200)
	invis.cast(targ, targ)
	
	utility.wait(0.5)
	
	targ.setAV("magicka", baseMagicka)
	targ.setAV("Illusion", baseIllusion)
		
ENDFUNCTION

FUNCTION hsmTransfer(ACTOR targ)
	Actor kPlayer = game.getPlayer()

	wabbaHitEffect.play(kPlayer)
	
	targ.damageAV("health", (targ.getBaseAV("health") * 0.5))
	kPlayer.restoreAV("health", (kPlayer.getBaseAV("health") * 0.5))

	targ.damageAV("stamina", (targ.getBaseAV("stamina") * 0.5))
	kPlayer.restoreAV("stamina", (kPlayer.getBaseAV("stamina") * 0.5))

	targ.damageAV("magicka", (targ.getBaseAV("magicka") * 0.5))
	kPlayer.restoreAV("magicka", (kPlayer.getBaseAV("magicka") * 0.5))
	
	utility.wait(1.5)
	
	wabbaHitEffect.stop(kPlayer)

ENDFUNCTION

FUNCTION spawnGold(ACTOR targ)
	targ.placeAtMe(visualExplosion)
	createAshPile()	
	explosionMarker.setPosition(targ.x, targ.y, (targ.z + 100))

	utility.wait(0.1)
	explosionMarker.placeAtMe(gold, 50)
	explosionMarker.placeAtMe(forceExplosion)

ENDFUNCTION

FUNCTION spawnSweetRoll(ACTOR targ)
	targ.placeAtMe(visualExplosion)
	
	utility.wait(0.7)
	explosionMarker.setPosition(targ.x, targ.y, (targ.z + 10))
	utility.wait(0.1)
	createAshPile()
	explosionMarker.placeAtMe(sweetRoll)


ENDFUNCTION

FUNCTION createAshPile()

	; //check to see if the target is in the immunity list
	IF(pDisintegrationMainImmunityList == none)
		TargetIsImmune = False
	ELSE
		ActorBase VictimBase = victim.GetBaseObject() as ActorBase
		VictimRace = VictimBase.GetRace()
		
		IF(pDisintegrationMainImmunityList.hasform(VictimRace) || pDisintegrationMainImmunityList.hasform(VictimBase))
			TargetIsImmune = True
		ELSE
			TargetIsImmune = False
		ENDIF
	ENDIF

	; //if the target is not immune, disintegrate them
	IF(TargetIsImmune == False)
; 		debug.trace("victim just died")

		
		victim.kill(game.getPlayer())
		victim.SetCriticalStage(victim.CritStage_DisintegrateStart)

		IF(pGhostDeathFXShader != none)
			pGhostDeathFXShader.play(victim,ShaderDuration)
		ENDIF
		
		victim.SetAlpha (0.0,True)
		
		; //attach the ash pile
		victim.AttachAshPile(pDefaultAshPileGhost)
		
		utility.wait(fDelayEnd)
		IF(pGhostDeathFXShader != none)
			pGhostDeathFXShader.stop(victim)
		ENDIF
		IF(bSetAlphaZero == True)
			victim.SetAlpha (0.0,True)
		ENDIF
		victim.SetCriticalStage(victim.CritStage_DisintegrateEnd)
	ENDIF
	
endFUNCTION

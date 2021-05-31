Scriptname SLP_MEF_SprigganCallEffect extends activeMagicEffect  

faction property creatureFaction auto
faction property sprigganFaction auto
faction property playerFaction auto
faction property MagicCharmFaction auto

actor caster
objectReference casterRef

float myConfidence
float myAggression

bool property bDebug = FALSE auto

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	Actor kPlayer = Game.GetPlayer()
	caster = akCaster
	casterRef = (caster as ObjectReference)
	
	if bDebug
 		; debug.notification("[SLP] applied Spriggan AoE to :"+akTarget)
 		; debug.trace("[SLP] AoE was cast by: "+casterRef)
 		; debug.trace("[SLP] AoE target: "+akTarget as Objectreference)
; 		debug.trace("TEST: Enemy of Spriggan: "+caster.getCombatTarget())
	endif
	
	; if akTarget.isInFaction(creatureFaction) == TRUE && !akTarget.isDead() 
	if ( (akTarget.isInFaction(creatureFaction) == TRUE) || (akTarget.isInFaction(sprigganFaction) == TRUE)) && !akTarget.isDead() 
		debug.trace("[SLP] AoE target is Creature or Spriggan " )
		
		; save my conf/aggro values so they can be reset
		myConfidence = akTarget.getActorValue("confidence")
		myAggression = akTarget.getActorValue("aggression")
		
		; make my enemies the spriggan's enemies temporarily
		akTarget.addToFaction(MagicCharmFaction)
		akTarget.addToFaction(playerFaction)
		kPlayer.addToFaction(sprigganFaction)
		
		; if the spriggan caster has a combat target (she should) then I will beeline to attack it!
		if (akTarget.getCombatTarget() == kPlayer)
			; akTarget.startCombat(caster.getCombatTarget())
			debug.Notification("[SLP] AoE target is in combat - Pacifying " )
			debug.trace("[SLP] AoE target is in combat - Pacifying " )
			kPlayer.stopCombat()
			akTarget.stopCombat()
			akTarget.stopCombatAlarm()
			akTarget.SetPlayerTeammate(true, false)
		endif

		; make this animal very aggressive/confident for the duration of the spell
		akTarget.setActorValue("confidence", 4)
		akTarget.setActorValue("aggression", 1)
		
	endif
	
endEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	Actor kPlayer = Game.GetPlayer()

; 	debug.trace("TEST: Released from Spriggan Enthrallment: "+self)

	akTarget.setActorValue("confidence", myConfidence)
	akTarget.setActorValue("aggression", myAggression)
	akTarget.RemoveFromFaction(MagicCharmFaction)
	akTarget.RemoveFromFaction(playerFaction)
	kPlayer.RemoveFromFaction(sprigganFaction)
	akTarget.SetPlayerTeammate(false, false)
	akTarget.evaluatePackage()
endEVENT
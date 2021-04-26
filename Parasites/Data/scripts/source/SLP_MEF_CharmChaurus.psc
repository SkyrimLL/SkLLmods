Scriptname SLP_MEF_CharmChaurus extends activemagiceffect  


Event OnEffectStart(Actor Target, Actor Caster)
 	Actor kPlayer = Game.GetPlayer()

	; Debug.Notification("Chaurus pheromones ON")
 	StorageUtil.SetIntValue(kPlayer, "_SLP_iChaurusPheromoneON", 1)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
 	Actor kPlayer = Game.GetPlayer()

	; Debug.Notification("Chaurus pheromones OFF")
 	StorageUtil.SetIntValue(kPlayer, "_SLP_iChaurusPheromoneON", 0)
	StorageUtil.SetIntValue(kPlayer, "_SLP_iChaurusCharmON", 0)

EndEvent
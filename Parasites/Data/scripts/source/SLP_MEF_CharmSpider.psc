Scriptname SLP_MEF_CharmSpider extends activemagiceffect  
 

Event OnEffectStart(Actor Target, Actor Caster)
 	Actor kPlayer = Game.GetPlayer()

	; Debug.Notification("Spider pheromones ON")
 	StorageUtil.SetIntValue(kPlayer, "_SLP_iSpiderPheromoneON", 1)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
 	Actor kPlayer = Game.GetPlayer()

	; Debug.Notification("Spider pheromones OFF")
 	StorageUtil.SetIntValue(kPlayer, "_SLP_iSpiderPheromoneON", 0)
	StorageUtil.SetIntValue(kPlayer, "_SLP_iSpiderCharmON", 0)
EndEvent
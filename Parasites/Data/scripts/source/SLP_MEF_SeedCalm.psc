Scriptname SLP_MEF_SeedCalm extends activemagiceffect  

Faction Property SpiderFaction Auto
Faction Property ChaurusFaction Auto

Event OnEffectStart(Actor Target, Actor Caster)
 	Actor kPlayer = Game.GetPlayer()

	; Debug.Notification("Spider pheromones ON")
 	StorageUtil.SetIntValue(kPlayer, "_SLP_iSpiderPheromoneON", 1)
 	kPlayer.AddToFaction(SpiderFaction)

 	; Debug.Notification("Chaurus pheromones ON")
 	StorageUtil.SetIntValue(kPlayer, "_SLP_iChaurusPheromoneON", 1)
 	kPlayer.AddToFaction(ChaurusFaction)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
 	Actor kPlayer = Game.GetPlayer()

	; Debug.Notification("Spider pheromones OFF")
 	StorageUtil.SetIntValue(kPlayer, "_SLP_iSpiderPheromoneON", 0)
	StorageUtil.SetIntValue(kPlayer, "_SLP_iSpiderCharmON", 0)
 	kPlayer.RemoveFromFaction(SpiderFaction)

	; Debug.Notification("Chaurus pheromones OFF")
 	StorageUtil.SetIntValue(kPlayer, "_SLP_iChaurusPheromoneON", 0)
	StorageUtil.SetIntValue(kPlayer, "_SLP_iChaurusCharmON", 0)
 	kPlayer.RemoveFromFaction(ChaurusFaction)
EndEvent
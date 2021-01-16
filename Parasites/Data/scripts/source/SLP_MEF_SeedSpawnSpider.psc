Scriptname SLP_MEF_SeedSpawnSpider extends activemagiceffect  


SLP_fcts_parasites Property fctParasites  Auto 

Scroll Property SpiderSpawnExploding Auto
Scroll Property SpiderSpawnCloak Auto
Scroll Property SpiderSpawnMind Auto

Quest Property QueenOfChaurusQuest  Auto 

Ingredient  Property SmallSpiderEgg Auto

Event OnEffectStart(Actor Target, Actor Caster)
	Actor kPlayer = Game.GetPlayer()
 	Int iChaurusQueenStage = StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage")
 	Int iSpiderEggsCount

	If (fctParasites.isInfectedByString( kPlayer,  "SpiderEgg" ))
		Debug.notification("[SLP] Hatching spider cluster.") 
		fctParasites.cureSpiderEgg( kPlayer, "All", false )
		; kPlayer.AddItem(SmallSpiderEgg, Utility.RandomInt(5,15))
	endif

	iSpiderEggsCount = kPlayer.GetItemCount(SmallSpiderEgg)

	if (iSpiderEggsCount>5)
		Debug.notification("Spiders spawn from your egg sac.") 
		kPlayer.RemoveItem(SmallSpiderEgg, 5)
		kPlayer.AddItem(SpiderSpawnExploding, 5)
	elseif (iSpiderEggsCount>0)
		Debug.notification("Spiders spawn from your egg sac.") 
		kPlayer.RemoveItem(SmallSpiderEgg, iSpiderEggsCount)
		kPlayer.AddItem(SpiderSpawnExploding, iSpiderEggsCount)
	else
		Debug.notification("Without spider eggs near you, the spell has no effect.") 
	endif
    ;   Debug.Messagebox(" Spider Pheromone charm spell started")    
	
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
    ;	SpiderFollowerAlias.Clear()
ENDEVENT
Scriptname SLP_MEF_CharmSpider extends activemagiceffect  

SLP_fcts_parasites Property fctParasites  Auto

ReferenceAlias Property SpiderFollowerAlias  Auto  
GlobalVariable Property SLP_numCharmSpider Auto

Event OnEffectStart(Actor Target, Actor Caster)
    ;   Debug.Messagebox(" Spider Pheromone charm spell started")    
	SpiderFollowerAlias.ForceRefTo(Target as objectReference)
	SLP_numCharmSpider.Mod(1.0)
	fctParasites.ParasiteSex(Game.GetPlayer(), Target)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
    ;	SpiderFollowerAlias.Clear()
ENDEVENT
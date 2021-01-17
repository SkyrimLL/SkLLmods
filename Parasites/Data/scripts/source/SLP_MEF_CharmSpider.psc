Scriptname SLP_MEF_CharmSpider extends activemagiceffect  

SLP_fcts_parasites Property fctParasites  Auto

ReferenceAlias Property SpiderFollowerAlias  Auto  
GlobalVariable Property SLP_numCharmSpider Auto

Spell Property _SLP_SP_SeedTrack Auto
Spell Property _SLP_SP_SeedCalm Auto
Spell Property _SLP_SP_SeedSpiderBreeding Auto

Quest Property QueenOfChaurusQuest  Auto 


Event OnEffectStart(Actor Target, Actor Caster)
	Actor kPlayer = Game.GetPlayer()
 	Int iChaurusQueenStage = StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage")

 	if (iChaurusQueenStage==3) && (!kPlayer.HasSpell( _SLP_SP_SeedSpiderBreeding ))
 		kPlayer.AddSpell( _SLP_SP_SeedTrack )
 		kPlayer.AddSpell( _SLP_SP_SeedCalm )
 		kPlayer.AddSpell( _SLP_SP_SeedSpiderBreeding )
 		debug.messagebox("The Seed reacts strongly to the influence of the Spider pheromones and inflames your senses. As the pincers spread your vagina into a gaping hole for the spider to mate with, you feel your mind expand to new possibilities.")
	endif

	if (QueenOfChaurusQuest.GetStageDone(310)) && (!QueenOfChaurusQuest.GetStageDone(320)) 
		QueenOfChaurusQuest.SetStage(320)
	endif

    ;   Debug.Messagebox(" Spider Pheromone charm spell started") 
    Target.StopCombat()   
	SpiderFollowerAlias.ForceRefTo(Target as objectReference)
	SLP_numCharmSpider.Mod(1.0)
	fctParasites.ParasiteSex(kPlayer, Target)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
    ;	SpiderFollowerAlias.Clear()
ENDEVENT
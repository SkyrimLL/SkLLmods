Scriptname SLP_MEF_CharmChaurus extends activemagiceffect  

SLP_fcts_parasites Property fctParasites  Auto

ReferenceAlias Property ChaurusFollowerAlias  Auto  
GlobalVariable Property SLP_numCharmChaurus Auto

Spell Property _SLP_SP_SeedTrack Auto
Spell Property _SLP_SP_SeedCalm Auto
Spell Property _SLP_SP_SeedChaurusBreeding Auto

Quest Property QueenOfChaurusQuest  Auto 


Event OnEffectStart(Actor Target, Actor Caster)
	Actor kPlayer = Game.GetPlayer()
 	Int iChaurusQueenStage = StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage")

	if (QueenOfChaurusQuest.GetStageDone(330)) 
	 	if (iChaurusQueenStage==3) && (!kPlayer.HasSpell( _SLP_SP_SeedChaurusBreeding ))
	 		kPlayer.AddSpell( _SLP_SP_SeedTrack )
	 		kPlayer.AddSpell( _SLP_SP_SeedCalm )
	 		kPlayer.AddSpell( _SLP_SP_SeedChaurusBreeding )
	 		debug.messagebox("The Seed blooms inside you from the influence of the Chaurus pheromones. The pincers extend a hungry mouth for the chaurus to mate with, making your skin tingles with power and giving you a new understanding of the Chaurus biology.")
		endif
	endif

	if (QueenOfChaurusQuest.GetStageDone(340)) && (!QueenOfChaurusQuest.GetStageDone(350)) 
		QueenOfChaurusQuest.SetStage(350)
	endif

    ;   Debug.Messagebox(" Chaurus Pheromone charm spell started")    
    Target.StopCombat()   
	ChaurusFollowerAlias.ForceRefTo(Target as objectReference)
	SLP_numCharmChaurus.Mod(1.0)
	fctParasites.ParasiteSex(kPlayer, Target)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
    ;	ChaurusFollowerAlias.Clear()
ENDEVENT
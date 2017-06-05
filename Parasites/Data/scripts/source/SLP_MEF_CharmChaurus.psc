Scriptname SLP_MEF_CharmChaurus extends activemagiceffect  

SLP_fcts_parasites Property fctParasites  Auto

ReferenceAlias Property ChaurusFollowerAlias  Auto  
GlobalVariable Property SLP_numCharmChaurus Auto

Event OnEffectStart(Actor Target, Actor Caster)
    ;   Debug.Messagebox(" spell started")    
	ChaurusFollowerAlias.ForceRefTo(Target as objectReference)
	SLP_numCharmChaurus.Mod(1.0)
	fctParasites.ParasiteSex(Game.GetPlayer(), Target)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
    ;	ChaurusFollowerAlias.Clear()
ENDEVENT
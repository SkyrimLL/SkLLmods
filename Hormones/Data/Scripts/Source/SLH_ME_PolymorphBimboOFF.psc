Scriptname SLH_ME_PolymorphBimboOFF extends activemagiceffect  

SLH_fctPolymorph Property fctPolymorph Auto
 
ActorBase pActorBase
 
Event OnEffectStart(Actor Target, Actor Caster)

    pActorBase = Target.GetActorBase()

    fctPolymorph.bimboTransformEffectOFF(Target)
    Game.ShowRaceMenu()
 
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox("Bimbo spell ended")    
ENDEVENT

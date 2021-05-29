Scriptname SLH_ME_HRT_OFF extends activemagiceffect  

SLH_fctPolymorph Property fctPolymorph Auto
 
ActorBase pActorBase
 
Event OnEffectStart(Actor Target, Actor Caster)

    if Target != none
		Target.SendModEvent("SLHCureHRTCurse")
	endIf
   
    ; Game.ShowRaceMenu()
 
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox("Bimbo spell ended")    
ENDEVENT


Scriptname SLP_MEF_FalmerBlue extends ActiveMagicEffect  

SLP_fcts_parasites Property fctParasites  Auto
ImageSpaceModifier Property  FalmerBlueImod Auto

Event OnEffectStart(Actor Target, Actor Caster)
    ;   Debug.Messagebox(" spell started")    
	fctParasites.FalmerBlue(Target, Game.GetPlayer())
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
    ;	ChaurusFollowerAlias.Clear()
    FalmerBlueImod.Remove( )
ENDEVENT

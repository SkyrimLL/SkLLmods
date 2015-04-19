Scriptname SL_Hypnosis_FX extends activemagiceffect  

VisualEffect Property FXMindControlMultiEffect auto
VisualEffect Property FXMindControlEyeGlowEffect auto

Actor selfRef

	EVENT OnEffectStart(Actor Target, Actor Caster)	
		selfRef = caster	
		FXMindControlMultiEffect.play(selfRef, -1)
		; FXMindControlEyeGlowEffect .play(selfRef, -1)
	ENDEVENT

	Event OnEffectFinish(Actor akTarget, Actor akCaster)		
		FXMindControlMultiEffect.Stop(selfRef)
		; FXMindControlEyeGlowEffect .Stop(selfRef)
	ENDEVENT
	
	EVENT OnDying(actor myKiller)	
		FXMindControlMultiEffect.Stop(selfRef)
		; FXMindControlEyeGlowEffect .Stop(selfRef)
	ENDEVENT
	

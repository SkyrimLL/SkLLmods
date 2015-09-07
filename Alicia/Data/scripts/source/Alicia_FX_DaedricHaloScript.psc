Scriptname Alicia_FX_DaedricHaloScript extends activemagiceffect  

VisualEffect Property FXNecroSkeletonMultiEffect auto
VisualEffect Property FXSkeletonNecroEyeGlowEffect auto
EffectShader Property SkeletonNecroDeathFXS auto

EffectShader Property AliciaCumFX  auto

Actor selfRef

	EVENT OnEffectStart(Actor Target, Actor Caster)	
		selfRef = caster	
		If (selfRef.Is3DLoaded())
			FXNecroSkeletonMultiEffect.play(selfRef, -1)
			FXSkeletonNecroEyeGlowEffect.play(selfRef, -1)
		EndIf
	ENDEVENT

	Event OnEffectFinish(Actor akTarget, Actor akCaster)		
		If (selfRef.Is3DLoaded())
			FXNecroSkeletonMultiEffect.Stop(selfRef)
			FXSkeletonNecroEyeGlowEffect.Stop(selfRef)
		EndIf
	ENDEVENT
	
	EVENT OnDying(actor myKiller)	
		; FXNecroSkeletonMultiEffect.stop(selfRef)
		; FXSkeletonNecroEyeGlowEffect.stop(selfRef)
		; SkeletonNecroDeathFXS.play(selfRef)
		
		; selfRef.SetCriticalStage(selfRef.CritStage_DisintegrateStart)
		; selfRef.AttachAshPile(AshPileObject)		

		; utility.wait(2)	
		; selfRef.SetAlpha (0.0)
		; selfRef.SetCriticalStage(selfRef.CritStage_DisintegrateEnd)
	ENDEVENT
	

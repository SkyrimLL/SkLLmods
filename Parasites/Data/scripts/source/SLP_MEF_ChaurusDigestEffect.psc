Scriptname SLP_MEF_ChaurusDigestEffect extends activemagiceffect  

SPELL Property HealEffect Auto
EffectShader Property WebbedFXS Auto

Armor Property Stage1 auto
Armor Property Stage2 auto
Armor Property Stage3 auto
Armor Property Stage4 auto
Armor Property Stage5 auto

Potion Property SLP_CritterFood Auto

Armor aWebType 
Float fWebDuration = 0.0

Event OnEffectStart(Actor Target, Actor Caster)
	Actor kPlayer = Game.GetPlayer()
	ObjectReference TargetRef = Target as ObjectReference
	Int iRandomNum = Utility.RandomInt(0,100)

	; Event doesn't fire if actor is dead - need to look for another solution
	; WebbedFXS.Play(TargetRef  , 120)

	debug.trace("[SLP] SLP_MEF_ChaurusDigestEffect")
	debug.trace("[SLP]    Target actor: " + Target)
	debug.trace("[SLP]    Is Target actor dead: " + Target.IsDead())

	if (Target.IsDead())
		debug.trace("[SLP]    Attaching ash pile")
		Target.AttachAshPile()

		Utility.wait(0.1)

		debug.trace("[SLP]    Healing effect")
		HealEffect.Cast(kPlayer as ObjectReference, kPlayer as ObjectReference)	
		kPlayer.EquipItem(SLP_CritterFood, true,true)
		kPlayer.EquipItem(SLP_CritterFood, true,true)
	else
		; debug.notification("[SLP]  Target invalid or not dead")	

		if (iRandomNum > 95)
			aWebType = Stage5
			fWebDuration = 20.0		
		elseif (iRandomNum > 90)
			aWebType = Stage4
			fWebDuration = 10.0		
		elseif (iRandomNum > 80)
			aWebType = Stage3
			fWebDuration = 10.0		
		elseif (iRandomNum > 70)
			aWebType = Stage2
			fWebDuration = 5.0		
		elseif (iRandomNum > 50)
			aWebType = Stage1
			fWebDuration = 3.0	
		else	
			aWebType = None
			fWebDuration = 0.0	
		endif

		if (fWebDuration>0.0)
			Target.SetRestrained(true)
			Target.EquipItem(aWebType, true, true)
			Debug.SendAnimationEvent(Target, "ZaZAPC223")
			Target.SetUnconscious(true)
			Utility.wait(fWebDuration)
			self.dispel()	
		endif

		kPlayer.EquipItem(SLP_CritterFood, true,true)

	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
    ;	SpiderFollowerAlias.Clear()
    ClearVictimStatus(akTarget)
ENDEVENT

Function ClearVictimStatus(Actor Victim)
	; Game.EnablePlayerControls(abmenu = true)
	if (fWebDuration>0.0)
		Victim.RemoveItem(Stage1, 99, true)
		Victim.RemoveItem(Stage2, 99, true)
		Victim.RemoveItem(Stage3, 99, true)
		Victim.RemoveItem(Stage4, 99, true)
		Victim.RemoveItem(Stage5, 99, true)
		WebbedFXS.Play(Victim, 120)
		Victim.SetUnconscious(false)
		Victim.SetRestrained(false)
		Debug.SendAnimationEvent(Victim, "IdleForceDefaultState")
	endif
EndFunction
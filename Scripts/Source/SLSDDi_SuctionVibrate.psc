Scriptname SLSDDi_SuctionVibrate extends zadBaseLinkedEvent  

Int Function GetChanceModified(actor akActor, int chanceMod)
	; include both tags for truely active effects
	float ret = Probability
	if akActor.HasMagicEffectWithKeyword(libs.zad_EffectLively)
		ret *= 1.5
	EndIf
	if akActor.HasMagicEffectWithKeyword(libs.zad_EffectVeryLively)
		ret *= 2
	EndIf
	return ((ret - Probability) as Int)
EndFunction

Bool Function Filter(actor akActor, int chanceMod=0)
	if !libs.Config.HardcoreEffects && akActor == libs.PlayerRef && akActor.GetCombatState() >= 1
		libs.Log("Player is in combat, and HardCoreEffects == false. Not starting new vibration effect.")
		return false	
	EndIf
	if akActor.IsInFaction(libs.Sexlab.ActorLib.AnimatingFaction)
		libs.Log("Player is in a sexlab scene. Not starting new vibration effect.")
		return false
	EndIf
	return (HasKeywords(akActor) && akActor.WornHasKeyword(SLSD_CowHarness) && Parent.Filter(akActor, GetChanceModified(akActor, chanceMod)))
EndFunction

bool Function HasKeywords(actor akActor)
	return (akActor.HasMagicEffectWithKeyword(libs.zad_EffectVibratingRandom) || akActor.HasMagicEffectWithKeyword(libs.zad_EffectVibratingVeryStrong) || akActor.HasMagicEffectWithKeyword(libs.zad_EffectVibratingStrong) || akActor.HasMagicEffectWithKeyword(libs.zad_EffectVibrating) || akActor.HasMagicEffectWithKeyword(libs.zad_EffectVibratingWeak) || akActor.HasMagicEffectWithKeyword(libs.zad_EffectVibratingVeryWeak))
EndFunction

Function Execute(actor akActor)
	;libs.Log("VibrateEffect("+chance+")")
	int vibStrength = 0
	int duration = 0
		if akActor.HasMagicEffectWithKeyword(libs.zad_EffectVibratingRandom)
			vibStrength = utility.RandomInt(1,5)
		elseif akActor.HasMagicEffectWithKeyword(libs.zad_EffectVibratingVeryStrong)
			vibStrength = 5
		elseIf akActor.HasMagicEffectWithKeyword(libs.zad_EffectVibratingStrong)
			vibStrength = 4
		elseIf akActor.HasMagicEffectWithKeyword(libs.zad_EffectVibrating)
			vibStrength = 3
		elseIf akActor.HasMagicEffectWithKeyword(libs.zad_EffectVibratingWeak)
			vibStrength = 2
		elseIf akActor.HasMagicEffectWithKeyword(libs.zad_EffectVibratingVeryWeak)
			vibStrength = 1
		else
			return
		EndIf

		if akActor.WornHasKeyword(SLSD_CowMilker ) && (vibStrength >= 1)

			if (akActor == Game.GetPlayer())
				Debug.Notification("Your breasts are aching from a rush of milk.")
			Else
				Debug.Notification("The cow's breasts are aching from a rush of milk.")
			Endif

			StorageUtil.SetIntValue(akActor, "_SLH_iMilkLevel", StorageUtil.GetIntValue(akActor, "_SLH_iMilkLevel") + 1)
		endif

		libs.VibrateEffect(akActor, vibStrength, duration, teaseOnly=libs.shouldEdgeActor(akActor))
EndFunction

Keyword Property SLSD_CowHarness Auto
Keyword Property SLSD_CowMilker Auto

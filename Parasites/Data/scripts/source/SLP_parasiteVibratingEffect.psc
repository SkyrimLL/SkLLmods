Scriptname SLP_parasiteVibratingEffect extends zadBaseLinkedEvent  

Keyword Property _SLPKP_OrganicVibrate Auto
Keyword Property _SLPKP_Parasite Auto
Keyword Property _SLPKP_SpiderEgg Auto
Keyword Property _SLPKP_SpiderPenis Auto
Keyword Property _SLPKP_ChaurusWorm Auto
Keyword Property _SLPKP_ChaurusWormVag Auto
Keyword Property _SLPKP_TentacleMonster Auto
Keyword Property _SLPKP_LivingArmor Auto
Keyword Property _SLPKP_FaceHugger Auto
Keyword Property _SLPKP_FaceHuggerGag Auto

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
	; if !libs.Config.HardcoreEffects && akActor == libs.PlayerRef && akActor.GetCombatState() >= 1
	if akActor == libs.PlayerRef && akActor.GetCombatState() >= 1
		libs.Log("Player is in combat, and HardCoreEffects == false. Not starting new vibration effect.")
		return false	
	EndIf
	if akActor.IsInFaction(libs.Sexlab.ActorLib.AnimatingFaction)
		libs.Log("Player is in a sexlab scene. Not starting new vibration effect.")
		return false
	EndIf
	return (HasKeywords(akActor) && (akActor.WornHasKeyword(_SLPKP_Parasite)) && Parent.Filter(akActor, GetChanceModified(akActor, chanceMod)))
EndFunction

bool Function HasKeywords(actor akActor)
	return (akActor.HasMagicEffectWithKeyword( _SLPKP_OrganicVibrate  )  )
EndFunction

Function Execute(actor akActor)
	;libs.Log("VibrateEffect("+chance+")")
	int vibStrength = 0
	int duration = utility.RandomInt(1,5)

	; Passive effects from parasites - side effect on host from invasion by parasites

	if akActor.WornHasKeyword ( _SLPKP_SpiderEgg )
		libs.NotifyPlayer("The eggs roll against each other inside your womb.")
		libs.Moan(akActor)	

	elseif akActor.WornHasKeyword ( _SLPKP_SpiderPenis )
		libs.NotifyPlayer("The barbs of the spider penis bite into your tender flesh.")
		libs.Moan(akActor)	

	Elseif akActor.WornHasKeyword ( _SLPKP_ChaurusWorm  )
		libs.NotifyPlayer("The worm stretches your anal opening as it pokes through.")
		libs.Moan(akActor)	

	Elseif akActor.WornHasKeyword ( _SLPKP_ChaurusWormVag  )
		libs.NotifyPlayer("The worm throbs against the walls of your vagina.")
		libs.Moan(akActor)	

	Elseif akActor.WornHasKeyword ( _SLPKP_TentacleMonster  )
		libs.NotifyPlayer("The slimy tentacles make your skin tingle.")
		libs.SexlabMoan(akActor)	

	Elseif akActor.WornHasKeyword ( _SLPKP_LivingArmor  )
		libs.NotifyPlayer("The oozing tendrils are glued to your tender skin.")
		libs.SexlabMoan(akActor)	

	Elseif akActor.WornHasKeyword ( _SLPKP_FaceHugger  )
		libs.NotifyPlayer("The hug of the critter around your waist is impossible to ignore.")
		libs.Pant(akActor)	

	Elseif akActor.WornHasKeyword ( _SLPKP_FaceHuggerGag  )
		libs.NotifyPlayer("The sweaty stench of the critter is impossible to ignore.")
		libs.SexlabMoan(akActor)	

	EndIf


	if akActor.HasMagicEffectWithKeyword ( _SLPKP_OrganicVibrate  )
		vibStrength = utility.RandomInt(1,5)
	else
		return
	EndIf

	libs.VibrateEffect(akActor, vibStrength, duration, teaseOnly=libs.shouldEdgeActor(akActor))
EndFunction
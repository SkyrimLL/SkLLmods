Scriptname SLP_parasiteOrganicBaseEvent extends zadBaseEvent  


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
		ret *= 2
	EndIf
	if akActor.HasMagicEffectWithKeyword(libs.zad_EffectVeryLively)
		ret *= 4
	EndIf
	return ((ret - Probability) as Int)
EndFunction

Bool Function Filter(actor akActor, int chanceMod=0)
	; if !libs.Config.HardcoreEffects && akActor == libs.PlayerRef && akActor.GetCombatState() >= 1
	if  akActor == libs.PlayerRef && akActor.GetCombatState() >= 1
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
	 return (akActor.WornHasKeyword(_SLPKP_OrganicVibrate) )
EndFunction

Function Execute(actor akActor)
	if libs.Aroused.GetActorExposure(akActor) >= libs.ArousalThreshold("Horny")
		; libs.NotifyPlayer("Your hard nipples rub uncomfortably against the cold steel of the Chastity Bra.")
		libs.UpdateExposure(akActor, 0.10)
	else
		; libs.NotifyPlayer("Your Chastity Bra is uncomfortably restricts your movements.")
	EndIf	

	; Active effects from parasites - living creatures taking action

	if akActor.WornHasKeyword ( _SLPKP_ChaurusWorm  )
		libs.NotifyPlayer("The worm gaping mouth nibbles at your anal opening.")
		libs.Moan(akActor)	

	Elseif akActor.WornHasKeyword ( _SLPKP_ChaurusWormVag  )
		libs.NotifyPlayer("The worm blindly  licks and sucks at your vaginal juices.")
		libs.Moan(akActor)	

	Elseif akActor.WornHasKeyword ( _SLPKP_TentacleMonster  ) 
		If (Utility.RandomInt(0,100)>40)
			libs.NotifyPlayer("A tentacle cups your breast and stimulates your tit.")
			libs.Pant(akActor)	

		Else
			libs.NotifyPlayer("Slimy tentacles rub slowly against your swollen lips.")
			libs.SexlabMoan(akActor)
		Endif	

	Elseif akActor.WornHasKeyword ( _SLPKP_LivingArmor  ) 
		If (Utility.RandomInt(0,100)>40)
			libs.NotifyPlayer("Squirming tentacle tips caress your inner thighs.")
			libs.SexlabMoan(akActor)	

		Else
			libs.NotifyPlayer("Suction cups pull at your tender nipples.")
			libs.Pant(akActor)	
		EndIf

	Elseif akActor.WornHasKeyword ( _SLPKP_FaceHugger  ) 
		If (Utility.RandomInt(0,100)>40)
			libs.NotifyPlayer("The critter pumps thick fluids deep inside you.")
			libs.Pant(akActor)	

		Else 
			libs.NotifyPlayer("The mouth of the critter is hopelessly locked around your sex.")
			libs.SexlabMoan(akActor)
		Endif	

	Elseif akActor.WornHasKeyword ( _SLPKP_FaceHuggerGag  ) 
		If (Utility.RandomInt(0,100)>40)
			libs.NotifyPlayer("The tail of the critter squeezes your throat.")
			libs.Pant(akActor)	

		Else 
			libs.NotifyPlayer("The mouth of the critter keeps feeding you thick, white fluids.")
			libs.SexlabMoan(akActor)	
		Endif

	EndIf
	 	
EndFunction
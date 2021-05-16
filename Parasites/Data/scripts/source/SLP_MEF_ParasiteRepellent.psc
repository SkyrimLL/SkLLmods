Scriptname SLP_MEF_ParasiteRepellent extends activemagiceffect  

SexLabFramework     property SexLab Auto

SLP_fcts_parasites Property fctParasites  Auto
SLP_fcts_utils Property fctUtils  Auto

Quest Property KynesBlessingQuest  Auto 


Event OnEffectStart(Actor Target, Actor Caster)
 	Actor kPlayer = Game.GetPlayer()
 	Int iRandumNum = Utility.RandomInt(0,100)
 	Bool bHarvestParasite = False

	; Debug.Notification("[SLP] SLP_MEF_ParasiteRepellent ON - " + iRandumNum)

	if (Caster==kPlayer)
        Debug.SendAnimationEvent(kPlayer as ObjectReference, "bleedOutStart")
        utility.wait(4)
        Debug.SendAnimationEvent(kPlayer as ObjectReference, "IdleForceDefaultState")

        if (fctUtils.isInfected( Caster )) 
            SexLab.AddCum(Caster,  Vaginal = true,  Oral = true,  Anal = true)
		endif

		if (iRandumNum >= 90) && (fctUtils.isInfected( Caster )) 
			; Chance to remove all
			; debug.Notification("[SLP] Chance to remove all parasites. " + iRandumNum)
			debug.MessageBox("You are overwhelmed by convulsions as your body suddenly rejects all parasites.")

			SendModEvent("SLPClearParasites")

		elseif (iRandumNum >= 60) 
			; Chance to remove full body parasites
			; debug.Notification("[SLP] Chance to remove full body parasites. " + iRandumNum)

			if (fctParasites.isInfectedByString( Caster,  "TentacleMonster" )) 
				debug.MessageBox("Under the effect of the potion, the tentacles melt in a pool of slime.") 
				fctParasites.cureParasiteByString(Caster, "TentacleMonster")


			elseif (fctParasites.isInfectedByString( Caster,  "LivingArmor" )) 
				debug.MessageBox("Under the effect of the potion, the tentacles melt in a pool of slime.")

		        if (!KynesBlessingQuest.GetStageDone(70))
		        	KynesBlessingQuest.SetStage(70)
		        endif

				fctParasites.cureParasiteByString(Caster, "LivingArmor")
			
 			elseif (fctParasites.isInfectedByString( Caster,  "Barnacles" )) 
				debug.MessageBox("The poisonous potion turn the spores into ash.")
				fctParasites.cureParasiteByString(Caster, "Barnacles")
			endif

		elseif (iRandumNum >= 40) 
			; chance to remove big parasites
			; debug.Notification("[SLP] Chance to remove Face and Hip Hugger. " + iRandumNum)

			if (fctParasites.isInfectedByString( Caster,  "FaceHugger" )) 
				debug.MessageBox("The creature releases its grasp and scurries away from the poison in your veins.")
				fctParasites.cureParasiteByString(Caster, "FaceHugger")
			endif

			if (fctParasites.isInfectedByString( Caster,  "FaceHuggerGag" )) 
				debug.MessageBox("The creature releases its grasp and scurries away from the poison in your veins.")
				fctParasites.cureParasiteByString(Caster, "FaceHuggerGag")
			endif

		elseif (iRandumNum >= 20) 
			; Chance to remove small parasites
			; debug.Notification("[SLP] Chance to remove Eggs and Worms. " + iRandumNum)

			if (fctParasites.isInfectedByString( Caster,  "SpiderEgg" ))  && (!fctParasites.isInfectedByString( Caster,  "SpiderPenis" )) 
				debug.MessageBox("Wracked by powerful cramps, your body rejects the eggs")
				fctParasites.cureParasiteByString(Caster, "SpiderEgg") 

			elseif ( (fctParasites.isInfectedByString( Caster,  "ChaurusWorm" )) || (fctParasites.isInfectedByString( Caster,  "ChaurusWormVag" )) )
				debug.MessageBox("Powerful cramps expel the worms inside you.")
				fctParasites.cureParasiteByString(Caster, "ChaurusWorm")  
				fctParasites.cureParasiteByString(Caster, "ChaurusWormVag")  
			 endif

		else 
			debug.MessageBox("The potion made you nauseous but the effect wasn't strong enough to reject the parasites.")
		endif
	else 
		debug.Trace("[SLP] SLP_MEF_ParasiteRepellent - Caster is not the player.")
		debug.Notification("[SLP] SLP_MEF_ParasiteRepellent - Caster is not the player. ")
 	endif

EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)       
 	Actor kPlayer = Game.GetPlayer()

	; Debug.Notification("[LP] SLP_MEF_ParasiteRepellent OFF")
 
	if (Target==kPlayer)
 	endif

EndEvent
Scriptname SLP_MEF_ParasiteRepellent extends activemagiceffect  

SexLabFramework     property SexLab Auto

SLP_fcts_parasites Property fctParasites  Auto
Quest Property KynesBlessingQuest  Auto 


Event OnEffectStart(Actor Target, Actor Caster)
 	Actor kPlayer = Game.GetPlayer()
 	Int iRandumNum = Utility.RandomInt(0,100)
 	Bool bHarvestParasite = False

	Debug.Notification("[SLP] SLP_MEF_ParasiteRepellent ON - " + iRandumNum)

	if (Target==kPlayer)
        Debug.SendAnimationEvent(kPlayer as ObjectReference, "bleedOutStart")
        utility.wait(4)
        Debug.SendAnimationEvent(kPlayer as ObjectReference, "IdleForceDefaultState")

        if (fctParasites.isInfected( Target )) 
            SexLab.AddCum(Target,  Vaginal = true,  Oral = true,  Anal = true)
		endif

		if (iRandumNum >= 90) && (fctParasites.isInfected( Target )) 
			; Chance to remove all
			debug.MessageBox("You are overwhelmed by convulsions as your body suddenly rejects all parasites.")

			SendModEvent("SLPClearParasites")

		elseif (iRandumNum >= 80) 
			; Chance to remove full body parasites
			if (fctParasites.isInfectedByString( Target,  "TentacleMonster" )) 
				debug.MessageBox("Under the effect of the potion, the tentacles melt in a pool of slime.")
				fctParasites.cureTentacleMonster( Target )

			elseif (fctParasites.isInfectedByString( Target,  "LivingArmor" )) 
				debug.MessageBox("Under the effect of the potion, the tentacles melt in a pool of slime.")

		        if (!KynesBlessingQuest.GetStageDone(70))
		        	KynesBlessingQuest.SetStage(70)
		        endif

				fctParasites.cureLivingArmor( Target )
 			
 			elseif (fctParasites.isInfectedByString( Target,  "Barnacles" )) 
				debug.MessageBox("The poisonous potion turn the spores into ash.")
				fctParasites.cureBarnacles( Target )
			endif

		elseif (iRandumNum >= 60) 
			; chance to remove big parasites
			if (fctParasites.isInfectedByString( Target,  "FaceHugger" )) 
				debug.MessageBox("The creature releases its grasp and scurries away from the poison in your veins.")
			  	fctParasites.cureFaceHugger(Target, bHarvestParasite)
			endif

			if (fctParasites.isInfectedByString( Target,  "FaceHuggerGag" )) 
				debug.MessageBox("The creature releases its grasp and scurries away from the poison in your veins.")
				fctParasites.cureFaceHuggerGag(Target, bHarvestParasite)
			endif

		elseif (iRandumNum >= 20) 
			; Chance to remove small parasites
			if (fctParasites.isInfectedByString( Target,  "SpiderEgg" ))  && (!fctParasites.isInfectedByString( Target,  "SpiderPenis" )) 
				debug.MessageBox("Wracked by powerful cramps, your body rejects the eggs")
				fctParasites.cureSpiderEgg(Target,"All", bHarvestParasite) 

			elseif ( (fctParasites.isInfectedByString( Target,  "ChaurusWorm" )) || (fctParasites.isInfectedByString( Target,  "ChaurusWormVag" )) )
				debug.MessageBox("Powerful cramps expel the worms inside you.")
			 	fctParasites.cureChaurusWorm(Target, bHarvestParasite)
			 	fctParasites.cureChaurusWormVag(Target, bHarvestParasite)
			 endif

		else 
			debug.MessageBox("The potion made you nauseous but the effect wasn't strong enough to reject the parasites.")
		endif
 	endif

EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)       
 	Actor kPlayer = Game.GetPlayer()

	; Debug.Notification("[LP] SLP_MEF_ParasiteRepellent OFF")
 
	if (Target==kPlayer)
 	endif

EndEvent
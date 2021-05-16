Scriptname SLP_fcts_parasiteEstrus extends Quest  

zadLibs Property libs Auto

SLP_fcts_utils Property fctUtils  Auto
SLP_fcts_parasites_devious Property fctDevious  Auto
SLP_fcts_parasiteTentacleMonster Property fctParasiteTentacleMonster  Auto
SLP_fcts_parasiteLivingArmor Property fctParasiteLivingArmor  Auto

Quest Property KynesBlessingQuest  Auto 
Quest Property QueenOfChaurusQuest  Auto 

ObjectReference Property DummyAlias  Auto  

GlobalVariable Property _SLP_GV_numInfections  Auto 
GlobalVariable Property _SLP_GV_numEstrusTentaclesInfections  Auto 
GlobalVariable Property _SLP_GV_numEstrusSlimeInfections  Auto 
GlobalVariable Property _SLP_GV_ZAPFuroTubOn  Auto  

Sound Property CritterFX  Auto
Sound Property WetFX  Auto

Ingredient  Property IngredientChaurusWorm Auto
Ingredient  Property SmallSpiderEgg Auto
Ingredient  Property BarnaclesCluster Auto
Ingredient  Property ChaurusEgg  Auto 

;------------------------------------------------------------------------------
Keyword Function getDeviousKeywordByString(String deviousKeyword = ""  )
	Keyword thisKeyword = None
 
	thisKeyword = fctDevious.getDeviousDeviceKeywordByString( deviousKeyword  )

	return thisKeyword
EndFunction

;------------------------------------------------------------------------------
Bool Function infectEstrusTentacles( Actor kActor  )
  	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusTentacles" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	

	If (!ActorHasKeywordByString(kActor,  "PlugVaginal")) && (!ActorHasKeywordByString(kActor,  "Harness")) && (!isInfectedByString( kActor,  "TentacleMonster" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceTentacleMonster" )))
			; PlayerActor.SendModEvent("SLPInfectTentacleMonster")
			fctParasiteTentacleMonster.infectTentacleMonster(kActor)

			if (kActor==PlayerActor)
				Debug.MessageBox("The ground shakes around you as tentacles shoot around your body and a slimy, sticky creature attaches itself around your back.")
			else
				Debug.MessageBox("The ground shakes as slimy tentacles shoot up.")
			endif
	Else
		Debug.Trace("[SLP]Estrust Tentacles / Tentacle Monster infection failed")
		Debug.Trace("[SLP]  Vaginal Plug: " + ActorHasKeywordByString(kActor,  "PlugVaginal"))
		Debug.Trace("[SLP]  TentacleMonster: " + isInfectedByString( kActor,  "TentacleMonster" ))
		Debug.Trace("[SLP]  Chance infection: " + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceTentacleMonster" ))
	EndIf

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap, PlayerActor)             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kActor)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, 0)    			; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
	else
		triggerFuroTub( PlayerActor, "")

	endif

	Return applyEstrusTentacles( kActor  )
EndFunction

Bool Function applyEstrusTentacles( Actor kActor  )
  	Actor PlayerActor = Game.GetPlayer()
 
	If !StorageUtil.HasIntValue(kActor, "_SLP_iEstrusTentaclesInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iEstrusTentaclesInfections",  0)
	EndIf

	; StorageUtil.SetIntValue(kActor, "_SLP_toggleEstrusTentacle", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusTentaclesDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusTentaclesInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iEstrusTentaclesInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numEstrusTentaclesInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iEstrusTentaclesInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPEstrusTentaclesInfection")


	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True
EndFunction

;------------------------------------------------------------------------------
Bool Function infectEstrusSlime( Actor kActor  )
  	Actor PlayerActor = Game.GetPlayer()
 
  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusSlime" )==0.0)
		Debug.Trace("[SLP]	Parasite disabled - Aborting")
		Return False
	Endif

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif
	

	If (!ActorHasKeywordByString(kActor,  "Harness")) && (!isInfectedByString( kActor,  "LivingArmor" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceLivingArmor" )))
			; PlayerActor.SendModEvent("SLPInfectLivingArmor")
			fctParasiteLivingArmor.infectLivingArmor(kActor)
			if (kActor==PlayerActor)
				Debug.MessageBox("What looked like creepy clusters suddenly extends tentacles around your skin and strips you of your clothes. A deep shudder ripples down your spine as sharp hooks burry deep into the back of your neck.")
			else
				Debug.MessageBox("What looked like creepy clusters suddenly extends tentacles around.")
			endif
	Else
		Debug.Trace("[SLP]Estrust Slime infection failed")
		Debug.Trace("[SLP]  Harness: " + ActorHasKeywordByString(kActor,  "Harness"))
		Debug.Trace("[SLP]  LivingArmor: " + isInfectedByString( kActor,  "LivingArmor" ))
		Debug.Trace("[SLP]  Chance infection: " + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceLivingArmor" ))
	EndIf

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap, PlayerActor)             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kActor)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, Utility.randomInt(2,3))    	; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
	else
		triggerFuroTub( PlayerActor, "")

	endif

	Return applyEstrusSlime( kActor  )
EndFunction

Bool Function applyEstrusSlime( Actor kActor  )
  	Actor PlayerActor = Game.GetPlayer()
 
	If !StorageUtil.HasIntValue(kActor, "_SLP_iEstrusSlimeInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iEstrusSlimeInfections",  0)
	EndIf

	; StorageUtil.SetIntValue(kActor, "_SLP_toggleEstrusTentacle", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusSlimeDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusSlimeInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iEstrusSlimeInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
		_SLP_GV_numEstrusSlimeInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iEstrusSlimeInfections"))
	endIf

	Sound.SetInstanceVolume(WetFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
	Sound.SetInstanceVolume(CritterFX.Play(PlayerActor), 1.0)
	Utility.Wait(1.0)
 
	SendModEvent("SLPEstrusSlimeInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif
	
	Return True

EndFunction


;------------------------------------------------------------------------------
Bool Function infectEstrusChaurusEgg( Actor kActor )
  	Actor PlayerActor = Game.GetPlayer()
  	Int iAnimation = 0

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif

	; If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusChaurusEgg" )==0.0)
	;	Debug.Trace("		Parasite disabled - Aborting")
	;	Return
	; Endif

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap,PlayerActor)             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kActor)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, iAnimation)    	; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
	Else
		Debug.Trace("[SLP]Estrus Chaurus Egg infection failed")
		triggerFuroTub( PlayerActor, "")
	endif

	Return applyEstrusChaurusEgg( kActor  )

EndFunction

Bool Function infectEstrusChaurusEggSilent( Actor kActor )
  	Actor PlayerActor = Game.GetPlayer()
  	Int iAnimation = -1

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf

	If (!fctUtils.isFemale( kActor))
		Debug.Trace("[SLP]	Actor is not female - Aborting")
		Return False
	Endif

	; If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusChaurusEgg" )==0.0)
	;	Debug.Trace("		Parasite disabled - Aborting")
	;	Return
	; Endif

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap,PlayerActor)             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kActor)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, iAnimation)    	; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
	Else
		Debug.Trace("[SLP]Estrus Chaurus Egg infection failed")
		triggerFuroTub( PlayerActor, "")
	endif

	Return applyEstrusChaurusEgg( kActor  )

EndFunction


Bool Function applyEstrusChaurusEgg( Actor kActor  )
  	Actor PlayerActor = Game.GetPlayer()

	If !StorageUtil.HasIntValue(kActor, "_SLP_iEstrusChaurusEggInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iEstrusChaurusEggInfections",  0)
	EndIf
 
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusChaurusEggDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusChaurusEggInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iEstrusChaurusEggInfections") + 1)

	If (kActor == PlayerActor)
		_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	endIf

	; _SLP_GV_numEstrusChaurusEggInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iEstrusChaurusEggInfections"))

	SendModEvent("SLPEstrusChaurusEggInfection")

	if (!KynesBlessingQuest.GetStageDone(20)) && (kActor == PlayerActor)
		KynesBlessingQuest.SetStage(20)
	endif

	Return True
EndFunction



;------------------------------------------------------------------------------
Function triggerEstrusChaurusBirth( Actor kActor, String  sParasite, Int iBirthItemCount  )
  	ObjectReference PlayerRef = Game.GetPlayer()
  	Actor PlayerActor = PlayerRef as Actor
  	Form fBirthItem = None

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf
 
	; If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusChaurusEgg" )==0.0)
	;	Debug.Trace("		Parasite disabled - Aborting")
	;	Return
	; Endif 

	If (sParasite == "SpiderEgg")
		fBirthItem = SmallSpiderEgg as Form

	ElseIf (sParasite == "ChaurusEgg")
		fBirthItem = ChaurusEgg as Form

	ElseIf (sParasite == "ChaurusWorm")
		fBirthItem = IngredientChaurusWorm as Form

	ElseIf (sParasite == "ChaurusWormVag")
		fBirthItem = IngredientChaurusWorm as Form

	ElseIf (sParasite == "Barnacles")
		fBirthItem = BarnaclesCluster as Form

	Endif

	Debug.Trace("[SLP] triggerEstrusChaurusBirth - Actor: " + kActor)
	Debug.Trace("[SLP] 		sParasite: " + sParasite)
	Debug.Trace("[SLP] 		fBirthItem: " + fBirthItem)
	Debug.Trace("[SLP] 		iBirthItemCount: " + iBirthItemCount)

	If (fBirthItem != None)
		; Testing EC birth event
		;To call an EC Birth event use the following code:
		;
		int ECBirth = ModEvent.Create("ECGiveBirth") ; Int          Int does not have to be named "ECBirth" any name would do
		if (ECBirth) && (!(fctUtils.isPregnantByEstrusChaurus( kActor)))
			Debug.Trace("[SLP] 		EC event detected - ECBirth")
		    ModEvent.PushForm(ECBirth, self)         ; Form         Pass the calling form to the event

		    ModEvent.PushForm(ECBirth, kActor)      ; Form         The Actor to give birth
		    ModEvent.PushForm(ECBirth, fBirthItem) ; Form    The Item to give birth to - if push None births Chaurus eg
		    ModEvent.PushInt(ECBirth, iBirthItemCount)            ; Int    The number of Items to give birth too
		    ModEvent.Send(ECBirth)
		else
			Debug.Trace("[SLP] 		Fallback animation")
		    ;EC is not installed
            Debug.SendAnimationEvent(PlayerRef, "bleedOutStart")
            utility.wait(4)
            Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
		    PlayerRef.PlaceAtMe(fBirthItem, iBirthItemCount)
		endIf
		;
		;   **NB** The birth event will not fire if the actor is already infected with the Chaurus Parasite effect
		;               This birth event is unaware of calling mods effects on Breast/Belly/Butt nodes - Any changes to
		;               inflation of these nodes at birth must be handled by the calling mod.
	Endif

EndFunction

;------------------------------------------------------------------------------
Function triggerFuroTub( Actor kActor, String  sParasite)
  	Actor PlayerActor = Game.GetPlayer()
  	Form fBirthItem = None

  	if (kActor == None)
  		kActor = PlayerActor
  	endIf

	_SLP_GV_ZAPFuroTubOn.SetValue(1)
	 
	PlayerActor.EvaluatePackage()

	Utility.Wait(10.0)

	_SLP_GV_ZAPFuroTubOn.SetValue(0)

EndFunction

;------------------------------------------------------------------------------
Bool Function isInfectedByString( Actor akActor,  String sParasite  )
	Bool isInfected = False

	; By order of complexity

	if (akActor && sParasite && (StorageUtil.GetIntValue(akActor, "_SLP_toggle" + sParasite)==1) )
		isInfected = True

	elseif (akActor && sParasite && (StorageUtil.GetIntValue(akActor, "_SLP_iHiddenParasite_" + sParasite)==1) )
		isInfected = True

	elseif (akActor && sParasite && akActor.WornHasKeyword(getDeviousKeywordByString(sParasite)) )
		isInfected = True
	Endif

	Return isInfected
EndFunction

Bool Function ActorHasKeywordByString(actor akActor, String deviousKeyword = "")
	return libs.ActorHasKeyword(akActor, getDeviousKeywordByString( deviousKeyword ))
EndFunction
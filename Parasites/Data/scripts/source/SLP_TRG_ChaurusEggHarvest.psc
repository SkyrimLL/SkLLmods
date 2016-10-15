Scriptname SLP_TRG_ChaurusEggHarvest extends ObjectReference  

SLP_fcts_parasites Property fctParasites  Auto

Event OnActivate(ObjectReference akActionRef)
	Actor kPlayer = Game.GetPlayer()
  	; Debug.Trace("Activated by " + akActionRef)

  	If (akActionRef==kPlayer)
  		If (Utility.RandomInt(1,100) <= StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceEstrusTentacles"))
			If (!fctParasites.ActorHasKeywordByString(kPlayer,  "PlugVaginal")) && (!fctParasites.isInfectedByString( kPlayer,  "TentacleMonster" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceTentacleMonster" )))
					kPlayer.SendModEvent("SLPInfectTentacleMonster")
			Else
				Debug.Trace("[SLP] Tentacle Monster infection failed")
				Debug.Trace("[SLP]   Vaginal Plug: " + fctParasites.ActorHasKeywordByString(kPlayer,  "PlugVaginal"))
				Debug.Trace("[SLP]   TentacleMonster: " + fctParasites.isInfectedByString( kPlayer,  "TentacleMonster" ))
				Debug.Trace("[SLP]   Chance infection: " + StorageUtil.GetFloatValue(kPlayer, "_SLP_chanceTentacleMonster" ))
			EndIf

			int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

			if (ECTrap) 
			    ModEvent.PushForm(ECTrap, self)             ; Form (Some SendModEvent scripting "black magic" - required)
			    ModEvent.PushForm(ECTrap, kPlayer)          ; Form The animation target
			    ModEvent.PushInt(ECTrap, 0)    ; Int  The animation required    0 = Tentacles, 1 = Machine
			    ModEvent.PushBool(ECTrap, true)             ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
			    ModEvent.Pushint(ECTrap, 500)               ; Int  Alarm radius in units (0 to disable) 
			    ModEvent.PushBool(ECTrap, true)             ; Bool Use EC (basic) crowd control on hostiles 
			    ModEvent.Send(ECtrap)
			endif

  		Endif
  	Endif
EndEvent
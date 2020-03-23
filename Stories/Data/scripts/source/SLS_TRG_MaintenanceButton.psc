Scriptname SLS_TRG_MaintenanceButton extends ObjectReference  

ObjectReference Property SexBotRefRef  Auto  
ObjectReference Property LexiconMarkerRef  Auto  
ObjectReference Property WorkerBotRef  Auto  
Spell Property TonalAdjustmentSpell  Auto 

Auto STATE Waiting
Event OnActivate(ObjectReference akActionRef)
	Actor akActor = akActionRef as Actor
	Actor akPlayer = Game.getPlayer() as Actor
	Actor SexBotActor = SexBotRefRef as Actor

	If (akActor == akPlayer)  
		; Debug.Notification("Sybil  is in the Sanctum : Initiation Level " + SybilLevel.GetValue())
		; Debug.Notification("Initiation quest stage: " + InitiationQuest.GetStage() )

		; If (InitiationQuest.GetStage() == 0)
		; 	InitiationQuest.SetStage(5)
		; 	InitiationFX.Cast(akActor ,akActor )
		; EndIf

		LexiconMarkerRef.Enable()

		SexBotActor.MoveTo( LexiconMarkerRef )
		; Debug.SendAnimationEvent(SexBotRefRef, "bleedOutStart")
		Utility.Wait(1.0)

		Debug.Notification("Tonal alignment procedure - Initiating... Please stand back from the platform.'")
			
		TonalAdjustmentSpell.cast(WorkerBotRef, SexBotRefRef)

		 int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

		  if (ECTrap) 
		        ModEvent.PushForm(ECTrap, self)             ; Form (Some SendModEvent scripting "black magic" - required)
		        ModEvent.PushForm(ECTrap, SexBotRefRef)          ; Form The animation target
		        ModEvent.PushInt(ECTrap, 1)    ; Int  The animation required    0 = Tentacles, 1 = Machine
		        ModEvent.PushBool(ECTrap, true)             ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
		        ModEvent.Pushint(ECTrap, 500)               ; Int  Alarm radius in units (0 to disable) 
		        ModEvent.PushBool(ECTrap, true)             ; Bool Use EC (basic) crowd control on hostiles 
		        ModEvent.Send(ECtrap)
		  else

			TonalAdjustmentSpell.cast(WorkerBotRef, SexBotRefRef)

		  endIf

	EndIf

EndEvent
endState
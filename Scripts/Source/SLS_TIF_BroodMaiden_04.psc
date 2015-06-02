;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_BroodMaiden_04 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor PlayerRef = Game.GetPlayer()

Game.ForceThirdPerson()
; Debug.SendAnimationEvent( PlayerRef , "bleedOutStart")

  int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

  if (ECTrap) 
        ModEvent.PushForm(ECTrap, self)             ; Form (Some SendModEvent scripting "black magic" - required)
        ModEvent.PushForm(ECTrap, Game.GetPlayer())          ; Form The animation target
        ModEvent.PushInt(ECTrap, 0)    ; Int  The animation required    0 = Tentacles, 1 = Machine
        ModEvent.PushBool(ECTrap, true)             ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
        ModEvent.Pushint(ECTrap, 500)               ; Int  Alarm radius in units (0 to disable) 
        ModEvent.PushBool(ECTrap, true)             ; Bool Use EC (basic) crowd control on hostiles 
        ModEvent.Send(ECtrap)
  else
		ChaurusSpitFX.Cast( akSpeaker ,Game.GetPlayer() )

		Utility.Wait(6.0)

    ; EC is not installed
    ; Try SD events as backup
    SendModEvent("SDParasiteVag")

    Game.FadeOutGame(true, true, 0.1, 15)
		PlayerRef.moveTo( _SLS_BreedinggroundMarker )
		Game.FadeOutGame(false, true, 0.01, 10)

  endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SPELL Property ChaurusSpitFX  Auto  

ObjectReference Property _SLS_BreedingGroundMarker  Auto  

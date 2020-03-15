;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_SexBotSex2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()
 int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

  if (ECTrap) && (Utility.RandomInt(0,100) > 80)
        ModEvent.PushForm(ECTrap, self)             ; Form (Some SendModEvent scripting "black magic" - required)
        ModEvent.PushForm(ECTrap, Game.GetPlayer())          ; Form The animation target
        ModEvent.PushInt(ECTrap, 1)    ; Int  The animation required    0 = Tentacles, 1 = Machine
        ModEvent.PushBool(ECTrap, true)             ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
        ModEvent.Pushint(ECTrap, 500)               ; Int  Alarm radius in units (0 to disable) 
        ModEvent.PushBool(ECTrap, true)             ; Bool Use EC (basic) crowd control on hostiles 
        ModEvent.Send(ECtrap)
  else
	If  (SexLab.ValidateActor( kPlayer ) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 

		SexLab.QuickStart(akSpeaker , kPlayer ,  AnimationTags = "Sex")
	EndIf

  endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

 

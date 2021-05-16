;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_PKG_ZapFuroTub Extends Package Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(Actor akActor)
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()

_SLP_WhiterunSanctuaryPlayerAltarEffect.Enable()

MUSCombatBoss.Add()

kPlayer.SendModEvent("SLPCureBarnacles")

Utility.Wait(2)

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap, kPlayer)             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kPlayer)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, Utility.randomInt(3,4))    	; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
	endif


kPlayer.SendModEvent("SLPInfectChaurusQueenVag")

Utility.Wait(2)

_SLP_WhiterunSanctuaryPlayerAltarEffect.Disable()

StorageUtil.SetIntValue(kPlayer, "_SLP_iChaurusQueenStage",  1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property _SLP_WhiterunSanctuaryPlayerAltarEffect  Auto  
MusicType Property MUSCombatBoss  Auto  

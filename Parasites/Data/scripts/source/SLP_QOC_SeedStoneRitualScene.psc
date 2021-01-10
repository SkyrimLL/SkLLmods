;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 16
Scriptname SLP_QOC_SeedStoneRitualScene Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
; debug.messagebox("[SLP] Scene ends")
	_SLP_WhiterunSanctuaryPlayerAltarEffect.Disable()

;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
debug.trace("[SLP] Scene phase 2")
; debug.messagebox("[SLP] Scene phase 2")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; debug.messagebox("[SLP] Scene starts")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
debug.trace("[SLP] Scene phase 1")
debug.messagebox("[Danica motions you to follow her to the Sanctuary]")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()
Actor kDanicaPurespring = DanicaPurespring as Actor

_SLP_WhiterunSanctuaryPlayerAltarEffect.Enable()

kDanicaPurespring.EvaluatePackage()

StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenVag", 100.0 )
StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenGag", 100.0 )
StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenSkin", 100.0 )
StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenArmor", 100.0 )
StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenBody", 100.0 )

MUSCombatBoss.Add()

kPlayer.SendModEvent("SLPCureBarnacles")

Utility.Wait(2)

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap, kPlayer)             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kPlayer)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, Utility.randomInt(2,3))    	; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
		debug.messagebox("The ground shakes around you as the Elder Roots extend their grasp and force the Seed Stone inside you.")
      else
	  ;  kPlayer.SendModEvent("SLPTriggerFuroTub")
	  	kDanicaPurespring.SendModEvent("SLPSexCure","fisting")
		debug.messagebox("Danica pulls you to the ground with her and forces the Seed Stone inside you.")
	endif


	; kPlayer.SendModEvent("SLPInfectChaurusQueenVag")

	Utility.Wait(2)


	StorageUtil.SetIntValue(kPlayer, "_SLP_iChaurusQueenStage",  1)
	StorageUtil.SetIntValue(kPlayer, "_SLP_iChaurusQueenDate", Game.QueryStat("Days Passed"))
	_SLP_QueenOfChaurusQuest.SetStage(289)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property _SLP_WhiterunSanctuaryPlayerAltarEffect  Auto  
MusicType Property MUSCombatBoss  Auto  

ObjectReference Property DanicaPureSpring  Auto  

Quest Property _SLP_QueenOfChaurusQuest  Auto  
 

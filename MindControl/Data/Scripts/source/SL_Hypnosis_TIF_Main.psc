;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Hypnosis_TIF_Main Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int daysSinceEnslavement = (Game.QueryStat("Days Passed") -  StorageUtil.GetIntValue(akSpeaker, "_SLMC_victimGameDaysEnslaved"))

_SLMC_GV_IsVictimSub.SetValue( StorageUtil.GetIntValue(akSpeaker, "_SLMC_IsVictimSub") )

_SLMC_GV_GameDaysPassed.SetValue( daysSinceEnslavement  )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property _SLMC_GV_IsVictimSub  Auto  

GlobalVariable Property _SLMC_GV_GameDaysPassed  Auto  

GlobalVariable Property _SMLC_GV_GameDatePassed  Auto  

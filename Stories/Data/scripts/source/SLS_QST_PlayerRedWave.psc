;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 13
Scriptname SLS_QST_PlayerRedWave Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLS_RedWavePlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLS_RedWavePlayerRef Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveDisplayed(10, false) 
SetObjectiveDisplayed(12, false)
SetObjectiveDisplayed(14, false)
SetObjectiveDisplayed(16, false)
SetObjectiveDisplayed(18, false)
;SetObjectiveDisplayed(20)
RedWaveQuest.RedWaveStop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveDisplayed(10)
RedWaveQuest.RedWaveStart()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(10)
RedWaveQuest.RedWaveStart()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
SetObjectiveDisplayed(10,false)
SetObjectiveDisplayed(18)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_QST_RedWaveController Property RedWaveQuest Auto

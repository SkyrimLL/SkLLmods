;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname SLP_QST_TentacleMonster Extends Quest Hidden

;BEGIN ALIAS PROPERTY _SLP_TargetCityAlias
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias__SLP_TargetCityAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLP_TargetTownAlias
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias__SLP_TargetTownAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLP_TargetInnAlias
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias__SLP_TargetInnAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLP_TargetSettlementAlias
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias__SLP_TargetSettlementAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
; Settlement
SetObjectiveDisplayed(40)
Debug.Messagebox("The creature burns your mind with vision of hot sex with women of a certain Settlement.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
; Inn
SetObjectiveDisplayed(20)
Debug.Messagebox("The creature compels you to find a suitable host in a certain Inn.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(10, false)
SetObjectiveDisplayed(20, false)
SetObjectiveDisplayed(30, false)
SetObjectiveDisplayed(40, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; Town
SetObjectiveDisplayed(10)
Debug.Messagebox("Your mind flashes with the desire to go to a certain Town and find a suitable host for the next stage of the creature's journey")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
; City
setObjectiveDisplayed(30)
Debug.Messagebox("Women in a particular city would make perfect hosts for the creature.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveDisplayed(10, false)
SetObjectiveDisplayed(20, false)
SetObjectiveDisplayed(30, false)
SetObjectiveDisplayed(40, false)
SetObjectiveDisplayed(50)
SetObjectiveDisplayed(50,false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

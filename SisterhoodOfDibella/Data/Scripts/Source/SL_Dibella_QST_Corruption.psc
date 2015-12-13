;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 36
Scriptname SL_Dibella_QST_Corruption Extends Quest Hidden

;BEGIN ALIAS PROPERTY AnwenRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AnwenRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HamalRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HamalRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SennaRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SennaRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY OrlaRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_OrlaRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FjotraREF
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FjotraREF Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
SetObjectiveDisplayed(32, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(5, true)
; SetStage(10)

_SLD_DibellaInitiationQuest.SetStage(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
SetObjectiveDisplayed(21, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveDisplayed(20, false)
SetObjectiveDisplayed(29, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
SetObjectiveDisplayed(21, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
SetObjectiveDisplayed(35, false)
SetObjectiveDisplayed(36, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
SetObjectiveDisplayed(34, false)
SetObjectiveDisplayed(35, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveDisplayed(5, false)
SetObjectiveDisplayed(10, true)
SetObjectiveDisplayed(20, true)
SetObjectiveDisplayed(30, true)
SetObjectiveDisplayed(40, true)
SetObjectiveDisplayed(50, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveDisplayed(30, false)
SetObjectiveDisplayed(36, false)
SetObjectiveDisplayed(39, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_33
Function Fragment_33()
;BEGIN CODE
SetObjectiveDisplayed(51, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
SetObjectiveDisplayed(31, false)
SetObjectiveDisplayed(32, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_31
Function Fragment_31()
;BEGIN CODE
SetObjectiveDisplayed(41, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
SetObjectiveDisplayed(31, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_35
Function Fragment_35()
;BEGIN CODE
SetObjectiveDisplayed(19,false)
SetObjectiveDisplayed(29,false)
SetObjectiveDisplayed(39,false)
SetObjectiveDisplayed(49,false)
SetObjectiveDisplayed(59,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveDisplayed(10, false)
SetObjectiveDisplayed(19, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
SetObjectiveDisplayed(40, false)
SetObjectiveDisplayed(42, false)
SetObjectiveDisplayed(49, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
SetObjectiveDisplayed(33, false)
SetObjectiveDisplayed(34, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN CODE
SetObjectiveDisplayed(41, false)
SetObjectiveDisplayed(42, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
SetObjectiveDisplayed(32, false)
SetObjectiveDisplayed(33, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
SetObjectiveDisplayed(50, false)
SetObjectiveDisplayed(51, false)
SetObjectiveDisplayed(59, true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property _SLD_DibellaInitiationQuest  Auto  

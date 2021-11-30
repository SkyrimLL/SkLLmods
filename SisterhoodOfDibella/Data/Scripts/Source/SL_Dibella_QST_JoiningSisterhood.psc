;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 13
Scriptname SL_Dibella_QST_JoiningSisterhood Extends Quest Hidden

;BEGIN ALIAS PROPERTY _SLSD_SisterSatchelRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSD_SisterSatchelRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLSD_SennaRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSD_SennaRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLSD_SisterSackRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSD_SisterSackRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLSD_REF_DeadSisterElenaNote
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSD_REF_DeadSisterElenaNote Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLSD_REF_DeadSisterElena
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSD_REF_DeadSisterElena Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLSD_REF_DeadSisterElsa
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSD_REF_DeadSisterElsa Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLSD_REF_DeadSisterElsaLetter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSD_REF_DeadSisterElsaLetter Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
SetObjectiveDisplayed(22)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveDisplayed(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveDisplayed(15, abDisplayed=False)
SetObjectiveDisplayed(20, abDisplayed=False)
SetObjectiveDisplayed(21, abDisplayed=False)
SetObjectiveDisplayed(22, abDisplayed=False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
SetObjectiveDisplayed(10, abDisplayed=False)
SetObjectiveDisplayed(15, abDisplayed=True)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveDisplayed(10)
SetObjectiveDisplayed(5, abDisplayed=False )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
SetObjectiveDisplayed(21)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

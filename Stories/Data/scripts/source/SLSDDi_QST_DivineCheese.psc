;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 43
Scriptname SLSDDi_QST_DivineCheese Extends Quest Hidden

;BEGIN ALIAS PROPERTY _SLSDDi_SnowShodCowAltmer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSDDi_SnowShodCowAltmer Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLSDDi_SnowShodCowNord
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSDDi_SnowShodCowNord Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLSDDi_SnowShodCowBosmer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSDDi_SnowShodCowBosmer Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLSDDi_SnowShodCowRedguard
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSDDi_SnowShodCowRedguard Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLSDDi_SnowShodCowImperial
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSDDi_SnowShodCowImperial Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLSDDi_SnowShodCowDunmer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSDDi_SnowShodCowDunmer Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLSDDi_SnowShodCowBreton
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSDDi_SnowShodCowBreton Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLSDDi_SnowShodCowOrc
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSDDi_SnowShodCowOrc Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLSDDi_SnowShodCowCustom
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLSDDi_SnowShodCowCustom Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(5, false)
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
; Learn about Divine Milk
SetObjectiveDisplayed(200, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveDisplayed(47, false)
SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
; Come back later - harness will be ready next time
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_41
Function Fragment_41()
;BEGIN CODE
; Door back to farm is locked
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN CODE
SetObjectiveDisplayed(59, false)
SetObjectiveDisplayed(310, false)
SetObjectiveDisplayed(320)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
; Get Leonara's notes
SetObjectiveDisplayed(100, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SetObjectiveDisplayed(47, false)
SetObjectiveDisplayed(55)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_34
Function Fragment_34()
;BEGIN CODE
; Doughall has the plans
SetObjectiveDisplayed(322,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
; Stages 500 - 600: Meet the Patron
SetObjectiveDisplayed(310, false)
SetObjectiveDisplayed(500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42()
;BEGIN CODE
; Door back to farm is open
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
; First harness is ready
SetObjectiveDisplayed(50, false)
SetObjectiveDisplayed(55, false)
SetObjectiveDisplayed(59)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
SetObjectiveDisplayed(300, false)
SetObjectiveDisplayed(310)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
; Stages 400 - 500: Enroll Unique Cows
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_39
Function Fragment_39()
;BEGIN CODE
; Milk machines Mk II are unlocked
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
SetObjectiveDisplayed(40, false)
SetObjectiveDisplayed(42)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30()
;BEGIN CODE
; Redguard cow is recruited
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
SetObjectiveDisplayed(42, false)
SetObjectiveDisplayed(45)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
; Come back later - harness is not ready
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_37
Function Fragment_37()
;BEGIN CODE
; Doughall has the new plans
SetObjectiveDisplayed(332, false)
; SetObjectiveDisplayed(334)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveDisplayed(20, false)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN CODE
; Stages 200 - 300 : Boost milk production and learn about Divine Cheese
SetObjectiveDisplayed(59, false)
SetObjectiveDisplayed(200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
; Stages 100 - 200: Use manual harness to enroll other cows (or yourself if female)
SetObjectiveDisplayed(20, false)
SetObjectiveDisplayed(48, false)
SetObjectiveDisplayed(49, false)
SetObjectiveDisplayed(50, false)
SetObjectiveDisplayed(55, false)
SetObjectiveDisplayed(59, false)
SetObjectiveDisplayed(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28()
;BEGIN CODE
; Meet potential unique Reguard cow
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
; Activate door to Shivering Grove for the first time
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
SetObjectiveDisplayed(45, false)
SetObjectiveDisplayed(47)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_35
Function Fragment_35()
;BEGIN CODE
SetObjectiveDisplayed(59, false)
SetObjectiveDisplayed(330)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_38
Function Fragment_38()
;BEGIN CODE
; Milk machines are unlocked
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
; Stages 300 - 400 : Milking machines
SetObjectiveDisplayed(59, false)
SetObjectiveDisplayed(300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_36
Function Fragment_36()
;BEGIN CODE
SetObjectiveDisplayed(330, false)
SetObjectiveDisplayed(332)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
; Ask the cow to join the farm
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
SetObjectiveDisplayed(48)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveDisplayed(30, false)
SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
; Enable Balimund Milk Farm items for sale
SetObjectiveDisplayed(48, false)
SetObjectiveDisplayed(49)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_33
Function Fragment_33()
;BEGIN CODE
SetObjectiveDisplayed(320, false)
SetObjectiveDisplayed(322)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetObjectiveDisplayed(10, false)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 22
Scriptname SLP_QST_QueenOfChaurus Extends Quest Hidden

;BEGIN ALIAS PROPERTY _SLP_ChaurusStudLastelle
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLP_ChaurusStudLastelle Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLP_ChaurusStudPlayer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLP_ChaurusStudPlayer Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLP_QOF_PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLP_QOF_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLP_LastelleRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLP_LastelleRef Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
SetObjectiveDisplayed(5,false)
SetObjectiveDisplayed(10,false)
SetObjectiveDisplayed(11,false)
SetObjectiveDisplayed(15)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
SetObjectiveDisplayed(70,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
EggSackOutsideMarker.enable()
SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
Actor kLastelle = Alias__SLP_LastelleRef.GetReference() as Actor
fctParasites.infectTentacleMonster( kLastelle )
fctParasites.infectEstrusChaurusEgg( kLastelle )

EggSackOutsideMarker.disable()
EggSackInsideMarker.enable()
_SLP_BroodCaveEntranceMarker.disable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveDisplayed(10,false)
SetObjectiveDisplayed(19,false)
SetObjectiveDisplayed(20,false)
SetObjectiveDisplayed(25)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
SetObjectiveDisplayed(30,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(10)
SetObjectiveDisplayed(11)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveDisplayed(5,false)
SetObjectiveDisplayed(6,false)
SetObjectiveDisplayed(15,false)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
SetObjectiveDisplayed(70)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
SetObjectiveDisplayed(65,false)
SetObjectiveDisplayed(20,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN CODE
SetObjectiveDisplayed(45)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
SetObjectiveDisplayed(50,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
SetObjectiveDisplayed(40,false)
SetObjectiveDisplayed(45,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
SetObjectiveDisplayed(60)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
SetObjectiveDisplayed(5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property EggSackOutsideMarker  Auto  

ObjectReference Property EggSackInsideMarker  Auto  

ObjectReference Property _SLP_BroodCaveEntranceMarker  Auto  
SLP_fcts_parasites Property fctParasites  Auto

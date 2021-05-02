;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname SLP_QST_KyneBlessing Extends Quest Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
SetObjectiveDisplayed(50,false)
SetObjectiveDisplayed(59)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SetObjectiveDisplayed(49)
SetObjectiveDisplayed(40,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
SetObjectiveDisplayed(79)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveDisplayed(11,false)
SetObjectiveDisplayed(12)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
KyneSanctuaryDoor.Lock()
KyneSanctuaryDoorNew.Lock()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveDisplayed(30,false)
SetObjectiveDisplayed(39)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
SetObjectiveDisplayed(90)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
SetObjectiveDisplayed(69)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
KyneSanctuaryDoor.Lock()
KyneSanctuaryDoorNew.Lock()
SetObjectiveDisplayed(10)
SetObjectiveDisplayed(11)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
KyneSanctuaryDoor.Lock()
KyneSanctuaryDoorNew.Lock()
SetObjectiveDisplayed(10, false)
SetObjectiveDisplayed(11, false)
SetObjectiveDisplayed(12, false)
SetObjectiveDisplayed(14, false)
SetObjectiveDisplayed(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(10,false)
SetObjectiveDisplayed(11,false)
SetObjectiveDisplayed(12,false)
; SetObjectiveDisplayed(14)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
SetObjectiveDisplayed(89)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveDisplayed(10, false)
SetObjectiveDisplayed(11, false)
SetObjectiveDisplayed(12, false)
SetObjectiveDisplayed(14, false)
SetObjectiveDisplayed(100, false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property KyneSanctuaryDoor  Auto  
ObjectReference Property KyneSanctuaryDoorNew  Auto  

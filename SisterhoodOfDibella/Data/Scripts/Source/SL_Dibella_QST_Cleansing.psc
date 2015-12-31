;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 42
Scriptname SL_Dibella_QST_Cleansing Extends Quest Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
SetObjectiveDisplayed(20, false)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(10, false)
SetObjectiveDisplayed(12)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN CODE
SetObjectiveDisplayed( 72 , false)
SetObjectiveDisplayed( 75 )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_34
Function Fragment_34()
;BEGIN CODE
SetObjectiveDisplayed( 61 , false)
SetObjectiveDisplayed( 62 )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_36
Function Fragment_36()
;BEGIN CODE
SetObjectiveDisplayed( 60 , false)
SetObjectiveDisplayed( 61 )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_38
Function Fragment_38()
;BEGIN CODE
SetObjectiveDisplayed( 70 , false)
SetObjectiveDisplayed( 72 )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28()
;BEGIN CODE
SetObjectiveDisplayed( 50 , false)
SetObjectiveDisplayed( 55 )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
SetObjectiveDisplayed(79, false)
SetObjectiveDisplayed(80)

_SLD_DibellaPathQuest.SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
SetObjectiveDisplayed(59, false)
SetObjectiveDisplayed(60)
_SLD_DibellaPathQuest.SetStage(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30()
;BEGIN CODE
SetObjectiveDisplayed( 62 , false)
SetObjectiveDisplayed( 65 )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
SetObjectiveDisplayed( 40 , false)
SetObjectiveDisplayed( 49 )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
SetObjectiveDisplayed(80, false)
SetObjectiveDisplayed(90)

_SLD_DibellaPathQuest.SetStage(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(5, false)
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
SetObjectiveDisplayed(90, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
SetObjectiveDisplayed(69, false)
SetObjectiveDisplayed(70)
_SLD_DibellaPathQuest.SetStage(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveDisplayed(10, false)
SetObjectiveDisplayed(12, false)
SetObjectiveDisplayed(14)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
SetObjectiveDisplayed(30, false)
SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
SetObjectiveDisplayed( 55 , false)
SetObjectiveDisplayed( 59 )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetObjectiveDisplayed(5, true)
; SetStage(10)

_SLD_DibellaInitiationQuest.SetStage(200)

SvanaFX.Play( SvanaRef, 5)
Utility.Wait(6.0)

SvanaRef.Disable()   
_SLSD_NPC_SvanaCorrupted.Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SetObjectiveDisplayed(14, false)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
SetObjectiveDisplayed( 65 , false)
SetObjectiveDisplayed( 69 )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
SetObjectiveDisplayed( 75  , false)
SetObjectiveDisplayed( 79 )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
SetObjectiveDisplayed(49, false)
SetObjectiveDisplayed(50)
_SLD_DibellaPathQuest.SetStage(40)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property _SLD_DibellaInitiationQuest  Auto  

ObjectReference Property SanguineRedLightRef  Auto  

ObjectReference Property _SLSD_NPC_SvanaCorrupted  Auto  

ObjectReference Property SvanaRef  Auto  

VisualEffect Property SvanaFX  Auto  

ObjectReference Property AnwenRef  Auto  

Key Property AnwenKey  Auto  

Outfit Property SisterBound  Auto  

Quest Property _SLD_DibellaPathQuest  Auto  

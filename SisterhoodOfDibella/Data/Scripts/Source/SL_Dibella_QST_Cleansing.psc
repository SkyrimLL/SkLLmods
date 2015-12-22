;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname SL_Dibella_QST_Cleansing Extends Quest Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetObjectiveDisplayed(5, true)
; SetStage(10)

SanguineRedLightRef.Disable()
_SLD_DibellaInitiationQuest.SetStage(200)

SvanaFX.Play( SvanaRef, 5)
Utility.Wait(6.0)

SvanaRef.Disable()   
_SLSD_NPC_SvanaCorrupted.Enable()
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

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property _SLD_DibellaInitiationQuest  Auto  

ObjectReference Property SanguineRedLightRef  Auto  

ObjectReference Property _SLSD_NPC_SvanaCorrupted  Auto  

ObjectReference Property SvanaRef  Auto  

VisualEffect Property SvanaFX  Auto  

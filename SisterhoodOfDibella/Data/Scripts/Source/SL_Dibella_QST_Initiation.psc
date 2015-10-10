;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 24
Scriptname SL_Dibella_QST_Initiation Extends Quest Hidden

;BEGIN ALIAS PROPERTY SybilREF
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SybilREF Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HamalRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HamalRef Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
SetObjectiveDisplayed(0)
SetStage(10)

; _SLD_DibellaPathQuest.Start()
; _SLD_DibellaPathQuest.SetStage(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
; Alias_SybilREF.GetActorRef().SetOutfit( SybilInitiateOutfit)
SetObjectiveDisplayed(10, abDisplayed=False)
SetObjectiveDisplayed(20, abDisplayed=False)
SetObjectiveDisplayed(30, abDisplayed=False)
SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
_SLD_DibellaPathQuest.SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
; SetObjectiveDisplayed(20, abDisplayed=False)
; SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
; Alias_SybilREF.GetActorRef().SetOutfit( SybilNoviceOutfit)
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
; Alias_SybilREF.GetActorRef().SetOutfit( SybilMotherOutfit)
SetObjectiveDisplayed(60)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
; Alias_SybilREF.GetActorRef().SetOutfit( SybilAccolyteOutfit)
SetObjectiveDisplayed(10, abDisplayed=False)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
SanguineRedLightRef.Enable()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Outfit Property SybilNoviceOutfit  Auto  
Outfit Property SybilAccolyteOutfit  Auto  
Outfit Property SybilInitiateOutfit  Auto  
Outfit Property SybilMotherOutfit  Auto  

Quest Property _SLD_DibellaPathQuest  Auto  

ObjectReference Property SanguineRedLightRef  Auto  

;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname SLH_QST_Bimbo Extends Quest Hidden

;BEGIN ALIAS PROPERTY _SLH_REF_BimboShape
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLH_REF_BimboShape Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLH_REF_OutcastSpeaker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLH_REF_OutcastSpeaker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveDisplayed(20,0)
SetObjectiveDisplayed(30,1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(10, 0)
SetObjectiveDisplayed(15, 0)
SetObjectiveDisplayed(20,1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Actor Player = Game.GetPlayer()
    ActorBase pActorBase = Player.GetActorBase()
   SetObjectiveDisplayed(10,1)

    if (pActorBase.GetSex() == 1) ; female
        setstage(12)
    Else
        setstage(14)
    EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveDisplayed(30,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
Actor Player = Game.GetPlayer()
    ActorBase pActorBase = Player.GetActorBase()
   SetObjectiveDisplayed(15,1)

    if (pActorBase.GetSex() == 1) ; female
        setstage(12)
    Else
        setstage(14)
    EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

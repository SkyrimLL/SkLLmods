;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 19
Scriptname SLH_QST_Bimbo Extends Quest Hidden

;BEGIN ALIAS PROPERTY _SLH_REF_BimboFollowerShape01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLH_REF_BimboFollowerShape01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLH_REF_OutcastSpeaker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLH_REF_OutcastSpeaker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLH_REF_BimboFollowerShape02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLH_REF_BimboFollowerShape02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLH_REF_BimboPlayerShape
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLH_REF_BimboPlayerShape Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLH_REF_BimboFollowerShape03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLH_REF_BimboFollowerShape03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLH_REF_BimboFollowerShape05
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLH_REF_BimboFollowerShape05 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLH_REF_BimboFollowerShape04
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLH_REF_BimboFollowerShape04 Auto
;END ALIAS PROPERTY

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

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
Debug.Messagebox("My cock has finished shrinking down to the size of a very sensitive clit. Keeping my fingers away from stroking it feels like torture. The slit between my legs feels wet and inviting. I am now fully transformed into a woman.")
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

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(10, 0)
SetObjectiveDisplayed(15, 0)
SetObjectiveDisplayed(20,1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveDisplayed(20,0)
SetObjectiveDisplayed(30,1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
Debug.Messagebox("Something is definitely wrong... It is not just that my hair is turning more blonde and by breasts filling in with each sex act. There is a deeper need for sex. A deeper hunger for flirtation and fun. I need to find out more about what is happening to me.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
Debug.Messagebox("Boobs? A wet slit between my legs? my cock shrinking a little more with each sex act? I must find someone who knows about this gender bending curse and hopefully, find a way to end it before it is too late.")
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

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
Debug.Messagebox("My clit has finished growing into a full size cock. Keeping my hands away from stroking it until I release another load of sperm feels like torture. ")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

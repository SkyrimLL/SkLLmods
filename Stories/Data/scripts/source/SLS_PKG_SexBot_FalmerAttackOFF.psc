;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_PKG_SexBot_FalmerAttackOFF Extends Package Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(Actor akActor)
;BEGIN CODE
; Actor akActor = SexBotRef as Actor

akActor.AddToFaction(FalmerFaction)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property FalmerFaction  Auto  

ObjectReference Property SexBotREF  Auto  

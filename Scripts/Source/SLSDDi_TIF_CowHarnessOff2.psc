;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLSDDi_TIF_CowHarnessOff2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor pActor =  SexLab.PlayerRef
ActorBase pActorBase = pActor.GetActorBase()
; Game.GetPlayer().RemoveItem(Milk, 1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property Milk  Auto  

MiscObject Property Gold  Auto  

SexLabFramework Property SexLab  Auto  

GlobalVariable Property MilkProduced  Auto  

GlobalVariable Property MilkProducedTotal  Auto  

SLS_QST_CowLife Property CowLife Auto

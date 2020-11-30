;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLSDDi_TIF_PetStore04 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().RemoveItem(Gold, 500, akSpeaker)

PetBelethorBought.SetValue(0)
PetFollow.SetValue(1)

Actor PetSlaveActor= _SLSD_PetSlaveREF.GetReference() as Actor
PetSlaveActor.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property Gold  Auto  

GlobalVariable Property PetBelethorBought  Auto  

ReferenceAlias Property _SLSD_PetSlaveREF  Auto  

GlobalVariable Property PetFollow  Auto  

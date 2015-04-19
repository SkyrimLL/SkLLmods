;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLSDDi_TIF_PetStore03 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().AddItem(Gold, 300 )

PetFollow.SetValue(0)
PetBelethorBought.SetValue(1)
PetBelethorBuyBack.Mod(1)

Actor PetSlaveActor= _SLSD_PetSlaveREF.GetReference() as Actor
PetSlaveActor.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property Gold  Auto  

GlobalVariable Property PetBelethorBuyBack  Auto  

GlobalVariable Property PetBelethorBought  Auto  

GlobalVariable Property PetFollow  Auto  

ReferenceAlias Property _SLSD_PetSlaveREF  Auto  

;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLSDDi_TIF_PetRelease Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor PetSlaveActor= _SLSD_PetSlaveREF.GetReference() as Actor

_SLSD_PetSlaveREF.GetActorRef().SetOutfit( _SLSD_PetOutfit )
_SLSD_PetOutfitNumber.SetValue(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Outfit Property _SLSD_PetOutfit  Auto  

GlobalVariable Property _SLSD_PetOutfitNumber  Auto  

ReferenceAlias Property _SLSD_PetSlaveREF  Auto  

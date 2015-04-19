;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Hypnosis_TIF_ReturnCirclet Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ObjectReference akActorREF= Alias_HypnosisVictimREF.GetReference()

	akActorREF.removeitem(HypnosisCircletArmor,1,true,Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Alias_HypnosisVictimREF  Auto  

Armor Property HypnosisCircletArmor  Auto  

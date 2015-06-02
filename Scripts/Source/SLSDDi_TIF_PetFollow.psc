;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLSDDi_TIF_PetFollow Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
_SLSD_PetFollow.SetValue(1)
akSpeaker.EvaluatePackage()

	If !(StorageUtil.HasIntValue(akSpeaker, "_SD_iRelationshipType"))
		StorageUtil.SetIntValue(akSpeaker, "_SD_iRelationshipType" , 5 )
	EndIf	
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property _SLSD_PetFollow  Auto  

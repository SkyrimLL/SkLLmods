;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLSDDi_TIF_MilkSexZad Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if (Utility.RandomInt(0,100)>70)
	akSpeaker.SendModEvent("SLHModHormone", "Lactation", 0.1 * Utility.RandomInt(0,10) )
	libs.SexlabMoan(akSpeaker)	
	debug.notification("Her breasts are getting warm")
	; debug.notification(" Lactation: " + StorageUtil.GetFloatValue( akSpeaker , "_SLH_fHormoneLactation") )
else
	akSpeaker.SendModEvent("SLHModHormone", "Lactation", 0.1 )

endif

if (Utility.RandomInt(0,100)>40)
	akSpeaker.SendModEvent("_SLSDDi_GropeCow")
endif

CowLife.checkIfLactating(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SexLabFramework     property SexLab Auto
zadLibs Property libs Auto
SLSDDi_QST_CowLife Property CowLife Auto

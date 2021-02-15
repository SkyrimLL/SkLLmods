;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLSDDi_TIF_DrinkEnrolled Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Form fActorForm = akSpeaker as Form
String sActorName 

if (fActorForm != None)
	sActorName = fActorForm.GetName()
else
	sActorName = "She"
endif

Debug.Notification( sActorName + " moans with relief..." )
akSpeaker.SendModEvent("_SLSDDi_DrinkCow")
CowLife.PayEnrolledCow(akSpeaker)

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

Potion Property Milk  Auto  

SLSDDi_QST_CowLife Property CowLife Auto

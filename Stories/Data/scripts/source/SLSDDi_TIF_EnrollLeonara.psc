;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname SLSDDi_TIF_EnrollLeonara Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
pFDS.Persuade(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer() 
Debug.Notification( "She eagerly strips and lets you inspect her breasts." )
Form fActorForm = akSpeaker as Form
String sActorName 

if (fActorForm != None)
	sActorName = fActorForm.GetName()
else
	sActorName = "She"
endif

Debug.Notification( sActorName + " moans with relief..." )
akSpeaker.SendModEvent("_SLSDDi_GropeCow")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

FavorDialogueScript Property pFDS  Auto  
SexLabFramework Property SexLab  Auto  

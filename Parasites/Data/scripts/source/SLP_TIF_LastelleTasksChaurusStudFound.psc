;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_LastelleTasksChaurusStudFound Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kChaurus =  ChaurusFollowerAlias.GetRef() as Actor

SLP_ChaurusStudWithLastelle.SetValue(1)
kChaurus .EvaluatePackage()
fctParasites.ParasiteSex(akSpeaker,kChaurus )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLP_fcts_parasites Property fctParasites  Auto
ReferenceAlias Property ChaurusFollowerAlias  Auto 

GlobalVariable Property SLP_ChaurusStudWithLastelle  Auto  

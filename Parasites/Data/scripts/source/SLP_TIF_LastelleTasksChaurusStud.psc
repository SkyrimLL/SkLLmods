;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_LastelleTasksChaurusStud Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; ObjectReference kChaurus =  ChaurusFollowerAlias.GetRef() as Actor
; ObjectReference kChaurusLastelle =  ChaurusLastelleFollowerAlias.GetRef() as Actor

ChaurusFollowerAlias.ForceRefTo(DummyMudcrabRef)
ChaurusLastelleFollowerAlias.ForceRefTo(DummyMudcrabRef)


SLP_ChaurusStudWithLastelle.SetValue(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLP_fcts_parasites Property fctParasites  Auto
ReferenceAlias Property ChaurusFollowerAlias  Auto 
ReferenceAlias Property ChaurusLastelleFollowerAlias  Auto 

GlobalVariable Property SLP_ChaurusStudWithLastelle  Auto  

ObjectReference Property DummyMudcrabRef  Auto  

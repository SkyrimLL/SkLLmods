;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_LastelleTasks59 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ObjectReference ChaurusPlayerRef = ChaurusFollowerAlias.GetRef() as ObjectReference
ObjectReference ChaurusLastelleRef = ChaurusFollowerLastelleAlias.GetRef() as ObjectReference

Actor kChaurus 

ChaurusFollowerLastelleAlias.ForceRefTo(ChaurusPlayerRef )
ChaurusFollowerAlias.clear()

kChaurus =  ChaurusFollowerLastelleAlias.GetRef() as Actor
self.GetOwningQuest().setstage(59)

SLP_ChaurusStudWithLastelle.SetValue(1)
kChaurus .EvaluatePackage()

fctParasites.infectChaurusWorm( akSpeaker )

fctParasites.ParasiteSex(akSpeaker,kChaurus )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


SLP_fcts_parasites Property fctParasites  Auto
ReferenceAlias Property ChaurusFollowerAlias  Auto 
ReferenceAlias Property ChaurusFollowerLastelleAlias  Auto 
GlobalVariable Property SLP_ChaurusStudWithLastelle  Auto  

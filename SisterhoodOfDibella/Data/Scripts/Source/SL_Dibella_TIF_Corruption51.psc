;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Corruption51 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetStage(51)

(HamalRef as Actor).EvaluatePackage()
(FjotraRef as Actor).EvaluatePackage()
(OrlaRef as Actor).EvaluatePackage()
(AnwenRef as Actor).EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property HamalRef  Auto  

ObjectReference Property FjotraREF  Auto  

ObjectReference Property OrlaRef  Auto  

ObjectReference Property AnwenRef  Auto  

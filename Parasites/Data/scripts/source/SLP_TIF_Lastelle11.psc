;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_Lastelle11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
fctParasites.infectParasiteByString(akSpeaker, "EstrusTentacles")
fctParasites.infectParasiteByString(akSpeaker, "ChaurusEggSilent")


self.GetOwningQuest().setstage(11)
self.GetOwningQuest().setstage(19)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLP_fcts_parasites Property fctParasites  Auto

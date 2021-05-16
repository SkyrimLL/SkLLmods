;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_LastelleTasks70 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kChaurus = CaveChaurusRef as Actor
Actor kPlayer = Game.GetPlayer()

self.GetOwningQuest().setstage(70)

Debug.Messagebox("Lastelle comes closer and kisses you deeply, forcing a mouthful of milky fluids down your throat and inserting something slimy down your lower back.")
 
fctParasites.infectParasiteByString(kPlayer, "ChaurusWorm")

fctParasites.ParasiteSex(kPlayer,kChaurus )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLP_fcts_parasites Property fctParasites  Auto
ObjectReference Property CaveChaurusRef  Auto  

;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_KyneBlessing250a Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; Actor kPlayer = Game.GetPlayer()

; kPlayer.AddItem(FireSalts, 1)

; SLP_WhiterunSanctuaryFollower.ForceRefTo(akSpeaker)

; akSpeaker.SendModEvent("SLPInfectFaceHuggerGag")
; kPlayer.SendModEvent("SLPSexCure","FaceHugger")

self.GetOwningQuest().SetStage(252)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property SLP_WhiterunSanctuaryFollower  Auto  

Ingredient Property FireSalts  Auto  

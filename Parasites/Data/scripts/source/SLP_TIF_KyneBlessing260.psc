;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_KyneBlessing260 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()

kPlayer.AddItem(FireSalts, 1)

; akSpeaker.SendModEvent("SLPCureFaceHuggerGag")
kPlayer.SendModEvent("SLPSexCure","FaceHuggerGag")

SLP_WhiterunSanctuaryFollower.ForceRefTo(DummyRef)

KynesBlessingQuest.SetObjectiveDisplayed(12, false)
KynesBlessingQuest.SetObjectiveDisplayed(14, false)
KynesBlessingQuest.SetObjectiveDisplayed(50, false)

self.GetOwningQuest().SetStage(260)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property SLP_WhiterunSanctuaryFollower  Auto  

Ingredient Property FireSalts  Auto  

ObjectReference Property DummyRef  Auto  

Quest Property KynesBlessingQuest  Auto  

;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_KyneBlessing250 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()

kPlayer.AddItem(FireSalts, 1)
kPlayer.AddItem(WhiteRunSanctuaryKey, 1)

SLP_WhiterunSanctuaryFollower.ForceRefTo(akSpeaker as ObjectReference)

akSpeaker.SendModEvent("SLPInfectFaceHuggerGag")
kPlayer.SendModEvent("SLPSexCure","FaceHugger")

WhiterunSanctuaryDoorRef.lock(false,true)

KynesBlessingQuest.SetStage(50)
KynesBlessingQuest.SetStage(21)
self.GetOwningQuest().SetStage(250)

DanicaSanctuaryCorruption.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property SLP_WhiterunSanctuaryFollower  Auto  

Ingredient Property FireSalts  Auto  
Quest Property KynesBlessingQuest  Auto 

ObjectReference Property WhiterunSanctuaryDoorRef  Auto  

Key Property WhiteRunSanctuaryKey  Auto  

ObjectReference Property WhiterunSanctuaryEntrance  Auto  

Scene Property DanicaSanctuaryCorruption  Auto  

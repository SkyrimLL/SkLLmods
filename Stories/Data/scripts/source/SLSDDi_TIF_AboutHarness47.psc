;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLSDDi_TIF_AboutHarness47 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()

kPlayer.RemoveItem(MilkHarnessContainer, 1)

akSpeaker.moveto(MilkHarnessMarker)

Self.GetOwningQuest().SetStage(47)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property MilkHarnessContainer  Auto  

ObjectReference Property MilkHarnessMarker  Auto  

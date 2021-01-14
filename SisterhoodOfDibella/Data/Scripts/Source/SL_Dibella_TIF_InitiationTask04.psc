;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SL_Dibella_TIF_InitiationTask04 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()

kPlayer.AddItem(_SLSD_DibellaFlute, 1)

Self.GetOwningQuest().SetObjectiveDisplayed(15, abDisplayed=False)
Self.GetOwningQuest().SetObjectiveDisplayed(16)
Self.GetOwningQuest().SetStage(12)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property _SLSD_DibellaFlute  Auto  

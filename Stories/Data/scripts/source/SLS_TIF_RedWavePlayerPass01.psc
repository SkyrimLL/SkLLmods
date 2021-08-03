;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_RedWavePlayerPass01 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()

kPlayer.RemoveItem(Gold001, 100)
PlayerDayPass.SetValue(Game.QueryStat("Days Passed"))
StorageUtil.SetIntValue(kPlayer , "_SLS_iStoriesRedWaveDayPass", 1)

self.GetOwningQuest().SetObjectiveDisplayed(16)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property PlayerDayPass Auto

MiscObject Property Gold001  Auto  

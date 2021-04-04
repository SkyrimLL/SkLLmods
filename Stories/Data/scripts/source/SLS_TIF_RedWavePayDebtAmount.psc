;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_RedWavePayDebtAmount Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()
Int iGoldAmount = kPlayer.GetItemCount(Gold001)

kPlayer.RemoveItem(Gold001, iGoldAmount )

RedWaveController.RedWavePayDebt(iGoldAmount)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property PlayerDayPass Auto

MiscObject Property Gold001  Auto  
SLS_QST_RedWaveController Property RedWaveController Auto

;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_RedWavePlayerTask01 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int randomNum = Utility.RandomInt(0, 100)
; StorageUtil.SetFormValue( Game.getPlayer() , "_SD_TempAggressor", akSpeaker)
StorageUtil.SetIntValue( Game.GetPlayer() , "_SD_iSub", StorageUtil.GetIntValue( Game.GetPlayer(), "_SD_iSub") + 1)
StorageUtil.SetIntValue( akSpeaker, "_SD_iDisposition", StorageUtil.GetIntValue( akSpeaker, "_SD_iDisposition"  ) + 1  )
 

if(Quest.GetQuest("_SD_controller"))
	If (randomNum > 95)
		akSpeaker.SendModEvent("PCSubEntertain", "Dance")
	ElseIf (randomNum > 90)
		akSpeaker.SendModEvent("PCSubEntertain", "Gangbang")
	ElseIf (randomNum > 80)
		akSpeaker.SendModEvent("PCSubSex", "Aggressive,Anal") 
	ElseIf (randomNum > 70)
		akSpeaker.SendModEvent("PCSubSex", "Dirty") 
	Else
		akSpeaker.SendModEvent("PCSubSex") ; Sex
	EndIf
	Game.GetPlayer().AddItem(Gold, (randomNum/10) + 10)
	RedWaveDebt.SetValue(  RedWaveDebt.GetValue() -  (randomNum - (randomNum/10) ) )
	Debug.Notification("You now owe " + RedWaveDebt.GetValue() as Int + " gold.")
else
	If (randomNum > 95)
		akSpeaker.SendModEvent("RedWaveEntertain", "Dance")
	ElseIf (randomNum > 90)
		akSpeaker.SendModEvent("RedWaveEntertain", "Soloshow")
	ElseIf (randomNum > 80)
		akSpeaker.SendModEvent("RedWaveSex", "Aggressive,Anal") 
	ElseIf (randomNum > 70)
		akSpeaker.SendModEvent("RedWaveSex", "Dirty") 
	Else
		akSpeaker.SendModEvent("RedWaveSex") ; Sex
	EndIf
endif

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property Gold  Auto  

GlobalVariable Property RedWaveDebt  Auto  

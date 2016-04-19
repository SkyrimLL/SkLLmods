;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname SLS_TIF_RedWavePlayerGoods01 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int randomNum = Utility.RandomInt(150, 300)

StorageUtil.SetIntValue( akSpeaker, "_SD_iDisposition", StorageUtil.GetIntValue( akSpeaker, "_SD_iDisposition"  ) + 1  )


Game.GetPlayer().AddItem(Gold, (randomNum/10) + 10)

RedWaveDebt.SetValue(  RedWaveDebt.GetValue() -  (randomNum - (randomNum/10) ) )

Debug.Notification("You now owe " + RedWaveDebt.GetValue() as Int + " gold.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
pFDS.Persuade(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

favordialoguescript Property pFDS  Auto  
GlobalVariable Property RedWaveDebt  Auto  

MiscObject Property Gold  Auto  
Potion Property Goods Auto

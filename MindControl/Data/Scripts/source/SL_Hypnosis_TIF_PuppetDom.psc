;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Hypnosis_TIF_PuppetDom Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int randomNum = Utility.RandomInt(0, 100)
StorageUtil.SetIntValue(akSpeaker, "_SD_iRelationshipType" , -5 )

StorageUtil.SetIntValue( Game.GetPlayer() , "_SD_iSub", StorageUtil.GetIntValue( Game.GetPlayer(), "_SD_iSub") + 1)

If (randomNum > 90)
	akSpeaker.SendModEvent("PCSubTransfer")
elseIf (randomNum > 60)
	akSpeaker.SendModEvent("PCSubPunish") ; Punishment
ElseIf (randomNum > 20)
	akSpeaker.SendModEvent("PCSubWhip") ; Whipping
Else
	akSpeaker.SendModEvent("PCSubSex") ; Sex
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

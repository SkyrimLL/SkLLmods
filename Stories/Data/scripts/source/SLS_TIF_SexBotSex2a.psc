;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLS_TIF_SexBotSex2a Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor SexBotActor = SexBotRef as Actor
Int iOilLevel = SexBotOilLevel.GetValue() as Int
 
SexBotOilLevel.SetValue(iOilLevel - 1)

StorageUtil.SetIntValue(SexBotActor, "_SLS_SexBotOilLevel", SexBotOilLevel.GetValue() as Int)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property SexBotOilLevel  Auto  

ObjectReference Property SexBotREF  Auto  

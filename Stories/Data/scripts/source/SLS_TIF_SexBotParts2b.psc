;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_SexBotParts2b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor SexBotActor = SexBotRef as Actor
Debug.Notification("Energy level - " + StorageUtil.GetIntValue(SexBotActor, "_SLS_SexBotEnergyLevel") )
Debug.Notification("Lubrication level - " + StorageUtil.GetIntValue(SexBotActor, "_SLS_SexBotOilLevel") )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property SexBotREF  Auto  

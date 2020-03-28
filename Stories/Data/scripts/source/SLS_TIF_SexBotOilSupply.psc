;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_SexBotOilSupply Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor SexBotActor = SexBotRef as Actor
Int iOilLevel = SexBotOilLevel.GetValue() as Int
Game.GetPlayer().RemoveItem(DwarvenOil, 1 )

SexBotOilLevel.SetValue(iOilLevel + 1)

StorageUtil.SetIntValue(SexBotActor, "_SLS_SexBotOilLevel", SexBotOilLevel.GetValue() as Int)

Debug.Notification("Energy level - " + StorageUtil.GetIntValue(SexBotActor, "_SLS_SexBotEnergyLevel") )
Debug.Notification("Lubrication level - " + StorageUtil.GetIntValue(SexBotActor, "_SLS_SexBotOilLevel") )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SexBotOilLevel  Auto  

ObjectReference Property SexBotREF  Auto  
 
Ingredient Property DwarvenOil  Auto  

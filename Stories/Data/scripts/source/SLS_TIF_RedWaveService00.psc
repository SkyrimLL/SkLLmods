;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_RedWaveService00 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int randomNum = Utility.RandomInt(0,100)

ActorBase PlayerBase = Game.GetPlayer().GetBaseObject() as ActorBase
Int PlayerGender = PlayerBase.GetSex() ; 0 = Male ; 1 = Female

SexLab.ActorLib.StripActor( akSpeaker, DoAnimate= true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


MiscObject Property Gold001  Auto  

SexLabFramework Property SexLab  Auto  

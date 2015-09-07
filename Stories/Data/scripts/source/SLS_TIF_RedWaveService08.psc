;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_RedWaveService08 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int randomNum = Utility.RandomInt(0,100)

ActorBase PlayerBase = Game.GetPlayer().GetBaseObject() as ActorBase
Int PlayerGender = PlayerBase.GetSex() ; 0 = Male ; 1 = Female

if (randomNum<=97)
	Game.GetPlayer().RemoveItem(Gold001, 150)
	Game.GetPlayer().AddItem(Skooma, 2)

else
	Debug.Notification("Here... this is on the house..")
	Game.GetPlayer().AddItem(Skooma, 1)

endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


MiscObject Property Gold001  Auto  

SexLabFramework Property SexLab  Auto  

Potion Property Skooma  Auto  

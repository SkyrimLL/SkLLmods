;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_RedWaveService12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int randomNum = Utility.RandomInt(0,100)

ActorBase PlayerBase = Game.GetPlayer().GetBaseObject() as ActorBase
Int PlayerGender = PlayerBase.GetSex() ; 0 = Male ; 1 = Female


; Check if whores available in _SLS_RedWaveFollowerWhores[]

Bool bWhoreAvailable = RedWaveQuest.ReserveFollowerWhore()

If (bWhoreAvailable )
	Game.GetPlayer().AddItem(Gold001, 1000)
	Game.GetPlayer().AddItem(_SLS_RedWaveWhoreCollar, 1)

	Debug.Messagebox("Thanks... We are always looking for new talents.\n Here.. put this collar around the neck of your whore to complete the transaction. ")

Else
	Debug.Messagebox("You have sold us five whores already. There is only so much room on this boat.")
Endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


MiscObject Property Gold001  Auto  

SexLabFramework Property SexLab  Auto  

Potion Property Skooma  Auto  



Armor Property _SLS_RedWaveWhoreCollar  Auto  


SLS_QST_RedWaveController Property RedWaveQuest Auto

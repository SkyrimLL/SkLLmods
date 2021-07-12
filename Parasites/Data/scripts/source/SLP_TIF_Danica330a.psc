;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_Danica330a Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()

kPlayer.AddItem(WhiteRunSanctuaryKey, 1)
WhiterunSanctuaryDoorRef.lock(false,true)

self.getowningquest().setstage(330)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Key Property WhiteRunSanctuaryKey  Auto  

ObjectReference Property WhiterunSanctuaryDoorRef  Auto  

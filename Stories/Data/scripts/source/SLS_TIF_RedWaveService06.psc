;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_RedWaveService06 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akActor = Game.GetPlayer()
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

	If  (SexLab.ValidateActor(akActor) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		Game.GetPlayer().RemoveItem(Gold001, 100)
		SexLab.QuickStart(akSpeaker, akActor, Victim=akSpeaker, AnimationTags="Pole,Pillory,Stockade,Xcross")
	else
		Debug.Notification("Ask me again when both be found less occupied!")
	endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


MiscObject Property Gold001  Auto  

SexLabFramework Property SexLab  Auto  
 

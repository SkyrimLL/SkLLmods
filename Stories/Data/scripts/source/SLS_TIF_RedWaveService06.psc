;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_RedWaveService06 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akActor = kPlayer
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()

	If  (SexLab.ValidateActor(kPlayer) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		kPlayer.RemoveItem(Gold001, 100)
		SexLab.QuickStart(akSpeaker, kPlayer, Victim=akSpeaker, AnimationTags="Pole,Pillory,Stockade,Xcross")
	else
		Debug.Notification("Ask me again when we are both less occupied!")
	endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


MiscObject Property Gold001  Auto  

SexLabFramework Property SexLab  Auto  
 

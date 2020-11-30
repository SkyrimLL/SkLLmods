;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_RedWaveService10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akActor = SexLab.PlayerRef
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

ActorBase PlayerBase = Game.GetPlayer().GetBaseObject() as ActorBase
ActorBase SpeakerBase = akSpeaker.GetBaseObject() as ActorBase
Int PlayerGender = PlayerBase.GetSex() ; 0 = Male ; 1 = Female
Int SpeakerGender = SpeakerBase.GetSex() ; 0 = Male ; 1 = Female
;		Debug.MessageBox( "The Sister quietly peels off your clothes to reveal your beauty to the world." )
;  		SexLab.ActorLib.StripActor(Game.GetPlayer(), DoAnimate= false)

	If  (SexLab.ValidateActor(akActor) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		
		Game.GetPlayer().RemoveItem(Skooma, 1)
		
		If (PlayerGender == 1 && SpeakerGender == 1)
			SexLab.QuickStart(akSpeaker, akActor, Victim=akSpeaker, AnimationTags="FemDom,Lesbian")
		elseIf (PlayerGender == 0 && SpeakerGender == 0)
			SexLab.QuickStart(akSpeaker, akActor, Victim=akSpeaker, AnimationTags="Gay,MM")
		else
			SexLab.QuickStart(akSpeaker, akActor, Victim=akSpeaker, AnimationTags="FM,MF")
		endIf
	else
		Debug.Notification("Ask me again when both be found less occupied!")
	endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


MiscObject Property Gold001  Auto  

SexLabFramework Property SexLab  Auto  

Potion Property Skooma  Auto  

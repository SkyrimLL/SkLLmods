;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_RedWaveService01 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int randomNum = Utility.RandomInt(0,100)

ActorBase PlayerBase = Game.GetPlayer().GetBaseObject() as ActorBase
Int PlayerGender = PlayerBase.GetSex() ; 0 = Male ; 1 = Female

;		Debug.MessageBox( "The Sister quietly peels off your clothes to reveal your beauty to the world." )
;  		SexLab.ActorLib.StripActor(Game.GetPlayer(), DoAnimate= false)

Game.GetPlayer().RemoveItem(Gold001, 10)

	If  (SexLab.ValidateActor( SexLab.PlayerRef ) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 

		Actor akActor = akSpeaker
		
		sslThreadModel Thread = SexLab.NewThread()
		Thread.AddActor(akActor,IsVictim = true) ; // IsVictim = true

		If (akActor.GetActorBase().getSex() == 1)
			Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F","Estrus,Dwemer"))
		Else
			Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,M","Estrus,Dwemer"))
		EndIf

		Thread.StartThread()
	Endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


MiscObject Property Gold001  Auto  

SexLabFramework Property SexLab  Auto  

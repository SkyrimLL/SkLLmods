;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_FemaleService01 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int randomNum = Utility.RandomInt(0,100)

ActorBase PlayerBase = Game.GetPlayer().GetBaseObject() as ActorBase
Int PlayerGender = PlayerBase.GetSex() ; 0 = Male ; 1 = Female

If (randomNum > 95)
		Debug.MessageBox( "The Sister quietly peels off your clothes to reveal your beauty to the world." )
    		SexLab.ActorLib.StripActor(Game.GetPlayer(), DoAnimate= false)

ElseIf (randomNum > 90) && (PlayerGender >= 0)
	If  (SexLab.ValidateActor( SexLab.PlayerRef ) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		Debug.Notification( "[Smiles] Let your beauty shine..." )

		Actor akActor = SexLab.PlayerRef
		
		sslThreadModel Thread = SexLab.NewThread()
		Thread.AddActor(akActor) ; // IsVictim = true
		Thread.AddActor(akSpeaker) ; // IsVictim = true

		If (PlayerGender  == 1)
			Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "Lesbian", "Aggressive"))
		Else
			Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "Oral,MF", "Aggressive"))
		EndIf

		Thread.StartThread()


	EndIf
ElseIf (randomNum > 85)
	If  (SexLab.ValidateActor(akSpeaker) > 0) 
		Debug.Notification( "The Goddess smiles upon you. Enjoy..." )

		Actor akActor = akSpeaker
		
		sslThreadModel Thread = SexLab.NewThread()
		Thread.AddActor(akActor) ; // IsVictim = true

		If (akActor.GetActorBase().getSex() == 1)
			Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F","Estrus,Dwemer"))
		Else
			Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,M","Estrus,Dwemer"))
		EndIf

		Thread.StartThread()
	EndIf
; ElseIf (randomNum > 40)
;      Debug.Notification( "[Kneels down] I will be good.... I promise." )

Else 
	Debug.Notification( "Here... isn't this beautiful?" )

	Game.GetPlayer().AddItem(DibellaSisterGift)

EndIf

Game.GetPlayer().RemoveItem(Gold001, 30)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

LeveledItem Property DibellaSisterGift  Auto  

MiscObject Property Gold001  Auto  

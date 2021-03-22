;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLSDDi_TIF_CowMilkerOff Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()
Actor pActor =  SexLab.PlayerRef
ActorBase pActorBase = pActor.GetActorBase()

; Game.GetPlayer().RemoveItem(Milk, 1)

Debug.Notification( "Leonara removes your harness with a smile..." )

CowLife.PlayerRemovedAutoCowharness( kPlayer )

kPlayer.AddItem(Gold, ( (pActorBase.GetWeight() as Int) + 10 )  )

Utility.Wait(1.0)

If  (SexLab.ValidateActor(  kPlayer  ) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
	actor[] sexActors = new actor[2]
	sexActors[0] =  kPlayer 
	sexActors[1] = akSpeaker

	sslBaseAnimation[] anims
	anims = new sslBaseAnimation[1]
	anims[0] = SexLab.GetAnimationByName("3J Straight Breastfeeding")

	if (anims[0] ==None)
		anims = SexLab.GetAnimationsByTags(2, "Breast","Estrus,Dwemer")
	endif

	SexLab.StartSex(sexActors, anims)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property Milk  Auto  

MiscObject Property Gold  Auto  

SexLabFramework Property SexLab  Auto  

GlobalVariable Property MilkProduced  Auto  

GlobalVariable Property MilkProducedTotal  Auto  

SLSDDi_QST_CowLife Property CowLife Auto

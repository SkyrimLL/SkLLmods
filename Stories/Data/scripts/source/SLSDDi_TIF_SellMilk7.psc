;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLSDDi_TIF_SellMilk7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor pActor =  Game.GetPlayer()

; Debug.Notification( "Leonara unhooks your suction cups eagerly..." )
; Game.GetPlayer().AddItem(Gold,  pActorBase.GetWeight() as Int)

; If (Utility.RandomInt(0,100) <  ( (pActorBase.GetWeight() as Int) / 10 + 5 ) ) 
;	Game.AddPerkPoints(1)
;	RedeemFX.Cast(Game.GetPlayer(),Game.GetPlayer())
; EndIf

pActor.SendModEvent("_SLSDDi_UpdateCow")

If  (SexLab.ValidateActor( pActor  ) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
	actor[] sexActors = new actor[2]
	sexActors[0] = pActor 
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

SPELL Property RedeemFX  Auto  

GlobalVariable Property MilkProduced  Auto  

GlobalVariable Property MilkProducedTotal  Auto  
 

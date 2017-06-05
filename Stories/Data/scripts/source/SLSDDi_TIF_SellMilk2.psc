;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLSDDi_TIF_SellMilk2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor pActor =  SexLab.PlayerRef
ActorBase pActorBase = pActor.GetActorBase()
; Game.GetPlayer().RemoveItem(Milk, 1)

Debug.Notification( "Leonara opens your top excitedly..." )


Game.GetPlayer().AddItem(Gold, ( (pActorBase.GetWeight() as Int) + 10 )  )

MilkProduced.SetValue( 0 )
MilkProducedTotal.SetValue( MilkProducedTotal.GetValue() + 1 )

Float fBreastScale = StorageUtil.GetFloatValue(none, "_SLH_fBreast") 
StorageUtil.SetFloatValue(none, "_SLH_fBreast",  fBreastScale * 0.8) 
StorageUtil.SetIntValue(none, "_SLH_iForcedRefresh", 1) 


If  (SexLab.ValidateActor( Game.GetPlayer()) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
	actor[] sexActors = new actor[2]
	sexActors[0] = Game.GetPlayer()
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
 

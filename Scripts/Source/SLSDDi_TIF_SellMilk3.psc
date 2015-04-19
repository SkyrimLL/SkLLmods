;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLSDDi_TIF_SellMilk3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor pActor =  SexLab.PlayerRef
ActorBase pActorBase = pActor.GetActorBase()
; Game.GetPlayer().RemoveItem(Milk, 1)

Debug.Notification( "Leonara unhooks your suction cups roughly..." )
Game.GetPlayer().AddItem(Gold,  pActorBase.GetWeight() as Int)

If (Utility.RandomInt(0,100) <  ( (pActorBase.GetWeight() as Int) / 10 + 5 ) ) 
	Game.AddPerkPoints(1)
	RedeemFX.Cast(Game.GetPlayer(),Game.GetPlayer())
EndIf

	Float fBreastScale = StorageUtil.GetFloatValue(none, "_SLH_fBreast") 
	StorageUtil.SetFloatValue(none, "_SLH_fBreast",  fBreastScale * 0.4) 
	StorageUtil.SetIntValue(none, "_SLH_iForcedRefresh", 1) 

MilkProduced.SetValue( MilkProduced.GetValue() + 1 )
MilkProducedTotal.SetValue( MilkProducedTotal.GetValue() + 1 )

If  (SexLab.ValidateActor( SexLab.PlayerRef ) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 

	SexLab.QuickStart(akSpeaker, SexLab.PlayerRef, AnimationTags = "Breast")
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
 

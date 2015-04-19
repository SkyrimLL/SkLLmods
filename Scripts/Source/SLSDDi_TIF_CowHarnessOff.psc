;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLSDDi_TIF_CowHarnessOff Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor pActor =  SexLab.PlayerRef
ActorBase pActorBase = pActor.GetActorBase()
; Game.GetPlayer().RemoveItem(Milk, 1)

Debug.Notification( "Leonara removes your harness with a smile..." )

CowLife.PlayerRemovedCowharness()

Game.GetPlayer().AddItem(Gold, ( (pActorBase.GetWeight() as Int) + 10 )  )

MilkProduced.SetValue( 0 )
MilkProducedTotal.SetValue( MilkProducedTotal.GetValue() + 1 )

Utility.Wait(1.0)

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

GlobalVariable Property MilkProduced  Auto  

GlobalVariable Property MilkProducedTotal  Auto  

SLS_QST_CowLife Property CowLife Auto

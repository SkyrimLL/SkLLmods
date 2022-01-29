;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Donation05 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ObjectReference kSatchel = _SLSD_SisterSatchelRef.GetReference()
Int randomNum = Utility.RandomInt(0,100)

ActorBase aBase = akSpeaker.GetBaseObject() as ActorBase
Int actorGender = aBase.GetSex() ; 0 = Male ; 1 = Female


If (randomNum >=10)
	kSatchel.AddItem(DibellaDonationGift)
	kSatchel.AddItem(DibellaDonationGift)
EndIf

kSatchel.AddItem(Gold, Utility.RandomInt(20,50) )
SatchelItemsCount.SetValue( kSatchel.GetNumItems() )  

Debug.Notification("You have " + SatchelItemsCount.GetValue() as Int + " items for the Temple.")
; TempleDonations.SetValue( TempleDonations.GetValue( ) + 1)
Self.GetOwningQuest().ModObjectiveGlobal( 1, TempleDonations, 10, 10, True, True, True )

String animTag = ""
if (TempleDonations.GetValue()<=2)
	animTag = "Foreplay"
elseif  (TempleDonations.GetValue()<=6)
	animTag = "Oral"
elseif  (TempleDonations.GetValue()<=10)
	animTag = "Vaginal"
endif

akSpeaker.SendModEvent("SLSDDibellaSex",animTag,0.0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

LeveledItem Property DibellaDonationGift  Auto  

MiscObject Property Gold  Auto 
ReferenceAlias Property _SLSD_SisterSatchelRef Auto
GlobalVariable Property SatchelItemsCount  Auto  
GlobalVariable Property TempleDonations  Auto  


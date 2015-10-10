;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Donation01a Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ObjectReference kSatchel = _SLSD_SisterSatchelRef.GetReference()
int iNumDonations =TempleDonations.GetValue( ) as Int

If (iNumDonations > 10)
	iNumDonations = 10
	TempleDonations.SetValue( 10 )
EndIf

TempleDonations.SetValue(  iNumDonations )

Debug.Notification("You give " + SatchelItemsCount.GetValue() as Int + " items to the Temple.")

If (Self.GetOwningQuest().GetStage() == 10)
	Self.GetOwningQuest().SetStage(15)

EndIf

Self.GetOwningQuest().ModObjectiveGlobal( iNumDonations , TempleDonations, 10, 10, True, True, True )

kSatchel.RemoveAllItems(akTransferTo = TempleDonationsChest, abKeepOwnership = True, abRemoveQuestItems = false)

SatchelItemsCount.SetValue( kSatchel.GetNumItems() )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


LeveledItem Property DibellaDonationGift  Auto  

MiscObject Property Gold  Auto 
ReferenceAlias Property _SLSD_SisterSatchelRef Auto

ObjectReference Property TempleDonationsChest  Auto  

GlobalVariable Property TempleDonations  Auto  
GlobalVariable Property SatchelItemsCount  Auto  

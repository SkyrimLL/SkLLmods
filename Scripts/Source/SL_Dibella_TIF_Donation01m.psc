;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Donation01m Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akSpeaker.ShowGiftMenu( True  )
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

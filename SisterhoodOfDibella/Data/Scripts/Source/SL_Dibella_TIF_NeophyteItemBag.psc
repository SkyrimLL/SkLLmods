;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_NeophyteItemBag Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer=game.getPlayer()
ObjectReference kSack= _SLSD_SisterSackRef.GetReference() 

; Self.GetOwningQuest().SetStage(10)
; Game.GetPlayer().AddItem( Wreath, 1)
kPlayer.AddItem( kSack, 1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property Wreath  Auto  

ReferenceAlias Property _SLSD_SisterSatchelRef  Auto  
ReferenceAlias Property _SLSD_SisterSackRef  Auto  

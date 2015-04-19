;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_SexBotSellOil Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int oilCount = 1 ; Game.GetPlayer().GetItemCount( DwemerOil ) 

if (oilCount > 0)
	Game.GetPlayer().RemoveItem( DwemerOil , oilCount )
	Game.GetPlayer().AddItem( Gold , oilCount * 50 )

Self.GetOwningQuest().SetObjectiveDisplayed(10,0)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Ingredient Property DwemerOil  Auto  

MiscObject Property Gold  Auto  

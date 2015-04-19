;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SL_Dibella_TIF_NeophyteSearch02 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetStage(30)

Game.GetPlayer().AddItem(WenchDress  , 1) 

Game.GetPlayer().AddItem(AgentOfDibellaDress  , 1) 

Game.GetPlayer().AddItem( TravellingSisterHood  , 1)

InnerSanctumLockList.AddForm(Game.GetPlayer() as Form)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property WenchDress  Auto  

Armor Property AgentOfDibellaDress  Auto  

Armor Property TravellingSisterHood  Auto  

FormList Property InnerSanctumLockList  Auto  

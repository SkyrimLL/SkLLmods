;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SL_Dibella_TIF_NeophyteSearch02a Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()

Self.GetOwningQuest().SetObjectiveDisplayed(21, abDisplayed=False )

Self.GetOwningQuest().SetObjectiveDisplayed(22, abDisplayed=False )

LetterElenaRef.Clear()
LetterElsaRef.Clear()  

kPlayer.RemoveItem(LetterElsa, 2, false)
kPlayer.RemoveItem(LetterElena, 2, false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property WenchDress  Auto  

Armor Property AgentOfDibellaDress  Auto  

Armor Property TravellingSisterHood  Auto  

FormList Property InnerSanctumLockList  Auto  

Book Property LetterElena  Auto  

Book Property LetterElsa  Auto  

ReferenceAlias Property LetterElenaRef  Auto  

ReferenceAlias Property LetterElsaRef  Auto  

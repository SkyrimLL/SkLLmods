;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_RedWavePlayerDebt02 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()
kPlayer.RemoveFromFaction(RedWaveWhore)

if (kPlayer.GetItemCount(WhoreCollar)>=1)
	kPlayer.RemoveItem(WhoreCollar)
endif

Debug.MessageBox("You are free to leave the Red Wave. Don't forget to pick up your things in a sack by the bedrolls in the lower decks.")

Self.GetOwningQuest().Setstage(20)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property RedWaveWhore  Auto  

Armor Property WhoreCollar  Auto  

GlobalVariable Property RedWaveDebt  Auto  
SLS_QST_RedWaveController Property RedWaveController Auto

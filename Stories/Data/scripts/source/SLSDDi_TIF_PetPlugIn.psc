;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLSDDi_TIF_PetPlugIn Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
_SLSD_PlugFree.SetValue(0)

Game.GetPlayer().RemoveItem( AnalPlug, 1)
Game.GetPlayer().RemoveItem( VaginalPlug, 1)

Debug.Messagebox("The plugs slide in as easily as hot irons in melting butter.")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property _SLSD_PlugFree  Auto  

Armor Property AnalPlug  Auto  

Armor Property VaginalPlug  Auto  

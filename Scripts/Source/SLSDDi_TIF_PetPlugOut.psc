;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLSDDi_TIF_PetPlugOut Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
_SLSD_PlugFree.SetValue(1)

Game.GetPlayer().AddItem( AnalPlug, 1)
Game.GetPlayer().AddItem( VaginalPlug, 1)

Debug.Messagebox("The plugs are steaming hot as they pull out.")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property _SLSD_PlugFree  Auto  

Armor Property AnalPlug  Auto  

Armor Property VaginalPlug  Auto  

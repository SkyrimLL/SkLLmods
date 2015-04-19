;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_SennaMakeOver Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
bool[] strip = new bool[33]
; // Strip body
strip[2] = true 
; // Strip feet
strip[7] = true

; // Strip our actor of their shirt and shoes
form[] ActorEquipment = SexLab.StripSlots(SexLab.PlayerRef, strip)

Game.ShowLimitedRaceMenu()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

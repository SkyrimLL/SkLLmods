;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname Alicia_TIF_02 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; TO DO - Find way to stop combat first - code ignored otherwise
; Debug.Notification( "Alicia drops to her knees and begs you to give her relief..." )
; actor[] sexActors = new actor[2]
; sexActors[0] = SexLab.PlayerRef
; sexActors[1] = akSpeaker
; sslBaseAnimation[] animations = SexLab.GetAnimationsByTag(2, "Aggressive")
; SexLab.StartSex(sexActors, animations)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  



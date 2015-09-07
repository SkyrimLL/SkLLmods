;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname Alicia_TIF_GoHomeMute Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; don't dismiss the follower again if I've already dismissed them
If !(akspeaker.IsInFaction(DismissedFollowerFaction))
  (pDialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)

  AliciaCutCount.Setvalue( 0 )
  AliciaCutGameDaysPassed.Setvalue( GameDaysPassed.Getvalue() )

EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property AliciaCutCount  Auto  

GlobalVariable Property AliciaCutGameDaysPassed  Auto  

Quest Property pDialogueFollower  Auto  

Faction Property DismissedFollowerFaction  Auto  

GlobalVariable Property GameDaysPassed  Auto  

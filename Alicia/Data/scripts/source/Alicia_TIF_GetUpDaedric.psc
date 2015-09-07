;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname Alicia_TIF_GetUpDaedric Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; AliciaRef.GetActorRef().PlayIdle(AliciaKneel)

	; Debug.MessageBox("Alicia presents herself to you \n You hit her " + AliciaCutCount.GetValue() as Int + " times \n Arousal level: " + AliciaLustLevel.GetValue() as Int  + " \n Days since last beating: " + AliciaCutGameDaysDiff.GetValue() as Int  + " \n Day of last beating: " + AliciaCutGameDaysPassed.GetValue() as Int)
	; akSpeaker.PlayIdle(AliciaKneel)
 Debug.SendAnimationEvent(akSpeaker as ObjectReference, "IdleForceDefaultState")

	; AliciaFollowerFunct.CheckAliciaLust()

	if (IsAliciaKneeling.Getvalue() == 0)
	     ; Debug.Notification("Alicia presents herself to you")
	     IsAliciaKneeling.Setvalue(1) 
	else
	     ; Debug.Notification("Alicia gets up")
	     IsAliciaKneeling.Setvalue(0)
	    ;  akSpeaker.PlayIdle(AliciaStand)
	   ; Debug.SendAnimationEvent(akSpeaker as ObjectReference, "IdleForceDefaultState")
	endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property AliciaRef  Auto  

GlobalVariable Property IsAliciaKneeling  Auto  
GlobalVariable Property AliciaLustLevel  Auto  
GlobalVariable Property AliciaCutCount  Auto  
GlobalVariable Property AliciaCutGameDaysPassed  Auto  
GlobalVariable Property AliciaCutGameDaysDiff  Auto  

Alicia_AliasFollowerDaedric Property AliciaFollowerFunct Auto

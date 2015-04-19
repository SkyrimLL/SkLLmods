;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname Alicia_TIF_Kneel Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

	Debug.MessageBox("Alicia presents herself to you \n You hit her " + AliciaCutCount.GetValue() as Int + " times \n Arousal level: " + AliciaLustLevel.GetValue() as Int  + " \n Days since last beating: " + AliciaCutGameDaysDiff.GetValue() as Int  + " \n Day of last beating: " + AliciaCutGameDaysPassed.GetValue() as Int)
	; akSpeaker.PlayIdle(AliciaKneel)
	Debug.SendAnimationEvent(akSpeaker as ObjectReference, "ZazAPC058")
	utility.wait(10)
	AliciaFollowerFunct.CheckAliciaLust()

	if (IsAliciaKneeling.Getvalue() == 0)
	     ; Debug.Notification("Alicia presents herself to you")
	     IsAliciaKneeling.Setvalue(1) 
	else
	     ; Debug.Notification("Alicia gets up")
	     IsAliciaKneeling.Setvalue(0)
	   Debug.SendAnimationEvent(akSpeaker as ObjectReference, "IdleForceDefaultState")
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

Alicia_AliasFollower Property AliciaFollowerFunct Auto

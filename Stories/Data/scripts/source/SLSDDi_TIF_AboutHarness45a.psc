;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLSDDi_TIF_AboutHarness45a Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int iItemReadyChance = _SLSDDi_BalimundItemReadyCheck.GetValueInt() 

iItemReadyChance = iItemReadyChance + 10

_SLSDDi_BalimundItemReadyCheck.SetValueInt( iItemReadyChance ) 

; Debug.Messagebox("Balimund chance is now " + _SLSDDi_BalimundItemReadyCheck.getValue() as Int)

if (utility.RandomInt(0,100) <= iItemReadyChance  )
	; random chance to clear the next check
	Self.GetOwningQuest().SetStage(44)
else
	Self.GetOwningQuest().SetStage(43)

endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property _SLSDDi_BalimundItemReadyCheck  Auto  

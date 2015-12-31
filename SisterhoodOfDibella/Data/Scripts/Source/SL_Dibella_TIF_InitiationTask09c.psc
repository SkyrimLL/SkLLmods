;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_InitiationTask09c Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SanguineAgentFX.Cast(akSpeaker, akSpeaker)

If ( StorageUtil.GetIntValue( Game.GetPlayer(), "_SD_iAPIInit") == 1 )
	SD_ON.SetValue(1)
Else
	SD_ON.SetValue(0)
EndIf


if ( SybilLevel.GetValue() < 5 ) 
	SybilLevel.SetValue( 5 )
	StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iDibellaSybilLevel" , 5)

EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property SD_ON  Auto  

SPELL Property SanguineAgentFX  Auto  

GlobalVariable Property SybilLevel  Auto  

;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_SybilRedeemFemale Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()
int marksCount = kPlayer.GetItemCount(DibellaToken) 

if (marksCount > 0)
	kPlayer.RemoveItem(DibellaToken, marksCount )
 
EndIf
 
RedeemCount.SetValue( RedeemCount.GetValue() + marksCount)

MarksBuffer.SetValue( MarksBuffer.GetValue() + marksCount)

While ( MarksBuffer.GetValue() >= 5)
	InitiationLevelBuffer.SetValue( InitiationLevelBuffer.GetValue() + 1)
	Debug.Notification("Dibella's Grace is with you.." )

	If (StorageUtil.GetIntValue( kPlayer, "_SLSD_iTogglePerkPoints")==0)
		Game.AddPerkPoints(1)
	endif

	RedeemFX.Cast(kPlayer,kPlayer)
	MarksBuffer.SetValue( MarksBuffer.GetValue() - 5)

	Debug.Trace("Sybil initiation buffer: " + InitiationLevelBuffer.GetValue())
	Debug.Trace(MarksBuffer.GetValue() + " marks remain.")
EndWhile


While (InitiationLevelBuffer.GetValue() >= 10)
	SybilLevel.SetValue( SybilLevel.GetValue() + 1)
	if ( SybilLevel.GetValue() > 5 ) 
		SybilLevel.SetValue( 5 )
	EndIf

	InitiationLevelBuffer.SetValue(InitiationLevelBuffer.GetValue() - 10)
	Debug.Trace("Sybil level: " + SybilLevel.GetValue() )
	Debug.Trace(MarksBuffer.GetValue() + " marks remain.")
EndWhile
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property Gold001  Auto  

MiscObject Property DibellaToken  Auto  

GlobalVariable Property RedeemCount  Auto  

SPELL Property RedeemFX  Auto  

GlobalVariable Property InitiationLevelBuffer  Auto  

GlobalVariable Property MarksBuffer  Auto  

GlobalVariable Property SybilLevel  Auto  

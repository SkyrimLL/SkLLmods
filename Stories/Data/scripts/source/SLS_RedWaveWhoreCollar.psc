Scriptname SLS_RedWaveWhoreCollar extends ObjectReference  

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	Actor kContainer = akNewContainer as Actor

	If ( akOldContainer == Game.GetPlayer() )
;		Self.DeleteWhenAble()
	EndIf
	
	If (  akNewContainer == Game.GetPlayer() )
		; Debug.Notification("[SLS] Whore collar in player")

	Else
		; Debug.Notification("[SLS] Whore collar in NPC")

		RedWaveQuest.AddFollowerWhore(akNewContainer)

	EndIf	
EndEvent

SLS_QST_RedWaveController Property RedWaveQuest Auto
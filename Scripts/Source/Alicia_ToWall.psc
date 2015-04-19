Scriptname Alicia_ToWall extends ObjectReference  

ReferenceAlias Property Alias_Alicia  Auto  
ReferenceAlias Property Alias_AliciaDaedric  Auto  
ReferenceAlias Property Alias_AliciaCured  Auto  
ReferenceAlias Property Alias_AliciaGhost  Auto  
Quest Property AliciaControlQuest  Auto  
Quest Property AliciaStoryQuest  Auto  

GlobalVariable Property AliciaSoulLocked  Auto  
GlobalVariable Property AliciaDaedricSoulLocked  Auto  

Spell Property DeviceActivation Auto

Faction Property pDismissedFollower Auto  
Faction Property pCurrentHireling Auto  
DialogueFollowerScript Property DialogueFollower Auto
Quest Property pDialogueFollower  Auto  

Auto STATE Waiting
	EVENT onActivate (objectReference triggerRef)
   		ObjectReference AliciaREF= Alias_Alicia.GetReference() 
		Actor AliciaActor = AliciaREF as Actor
   		ObjectReference AliciaCuredREF= Alias_AliciaCured.GetReference() 
		Actor AliciaCuredActor = AliciaCuredREF as Actor
   		ObjectReference AliciaGhostREF= Alias_AliciaGhost.GetReference() 
		Actor AliciaGhostActor = AliciaGhostREF as Actor
		ObjectReference AliciaDaedricREF= Alias_AliciaDaedric.GetReference() 
		Actor AliciaDaedricActor = AliciaREF as Actor

		Debug.Notification("Activating..."  )
		DeviceActivation.RemoteCast(Game.GetPlayer() , Game.GetPlayer() as Actor,Game.GetPlayer() )

		If (AliciaSoulLocked.GetValue() == 1)
			Debug.Notification("Alicia's soul shard is locked")
		Else
			Debug.Notification("Alicia's soul shard is free")
		EndIf

		If (AliciaDaedricSoulLocked.GetValue() == 1)
			Debug.Notification("Ali's soul shard is locked")
		Else
			Debug.Notification("Ali's soul shard is free")
		EndIf

		AliciaControlQuest.SetObjectiveDisplayed(10,false)
		AliciaControlQuest.SetObjectiveDisplayed(20,false)
		AliciaControlQuest.SetObjectiveDisplayed(30,false)
		AliciaControlQuest.SetObjectiveDisplayed(40,false)

		AliciaStoryQuest.SetStage(60)
		AliciaStoryQuest.SetObjectiveDisplayed(60, true)
 

		If (AliciaDaedricSoulLocked.GetValue() == 1) && (AliciaSoulLocked.GetValue() == 1)     ; both souls locked - Alicia is cured
			; control quest stage = 40
			AliciaControlQuest.SetStage(40)
			AliciaControlQuest.SetObjectiveDisplayed(40)

            If !(AliciaDaedricActor.IsInFaction(pDismissedFollower))
                (pDialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)
            EndIf

            AliciaDaedricActor.AddToFaction(pDismissedFollower)
            AliciaDaedricActor.SetPlayerTeammate(false)
            AliciaDaedricActor.RemoveFromFaction(pCurrentHireling)
            AliciaDaedricActor.SetAV("WaitingForPlayer", 0) 

            Utility.Wait(1.0)

            If !(AliciaActor.IsInFaction(pDismissedFollower))
                (pDialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)
            EndIf

            AliciaActor.AddToFaction(pDismissedFollower)
            AliciaActor.SetPlayerTeammate(false)
            AliciaActor.RemoveFromFaction(pCurrentHireling)
            AliciaActor.SetAV("WaitingForPlayer", 0) 

            Utility.Wait(1.0)

			AliciaREF.disable()
			AliciaDaedricREF.disable()
			AliciaGhostREF.disable()
			AliciaCuredREF.enable()


		ElseIf (AliciaDaedricSoulLocked.GetValue() == 1) && (AliciaSoulLocked.GetValue() == 0) ; Ali soul is locked - Keep Alicia only
			; control quest stage = 30
			AliciaControlQuest.SetStage(30)
			AliciaControlQuest.SetObjectiveDisplayed(30)

            If !(AliciaDaedricActor.IsInFaction(pDismissedFollower))
                (pDialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)
            EndIf

            AliciaDaedricActor.AddToFaction(pDismissedFollower)
            AliciaDaedricActor.SetPlayerTeammate(false)
            AliciaDaedricActor.RemoveFromFaction(pCurrentHireling)
            AliciaDaedricActor.SetAV("WaitingForPlayer", 0) 

			AliciaREF.enable()
			AliciaDaedricREF.disable()
			AliciaGhostREF.enable()
			AliciaCuredREF.disable()

            (pDialogueFollower as DialogueFollowerScript).SetFollower(AliciaREF)
            (pDialogueFollower as DialogueFollowerScript).FollowerFollow()

		ElseIf (AliciaDaedricSoulLocked.GetValue() == 0) && (AliciaSoulLocked.GetValue() == 1) ; Alicia soul is locked - Keep Ali only
			; control quest stage = 20
			AliciaControlQuest.SetStage(20)
			AliciaControlQuest.SetObjectiveDisplayed(20)

            If !(AliciaActor.IsInFaction(pDismissedFollower))
                (pDialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)
            EndIf

            AliciaActor.AddToFaction(pDismissedFollower)
            AliciaActor.SetPlayerTeammate(false)
            AliciaActor.RemoveFromFaction(pCurrentHireling)
            AliciaActor.SetAV("WaitingForPlayer", 0) 

			AliciaREF.disable()
			AliciaDaedricREF.enable()
			AliciaGhostREF.enable()
			AliciaCuredREF.disable()


            (pDialogueFollower as DialogueFollowerScript).SetFollower(AliciaDaedricREF)
            (pDialogueFollower as DialogueFollowerScript).FollowerFollow()

		Else                                                                                   ; Both souls are free - Keep Alicia and Ali
			; control quest stage = 10
			AliciaControlQuest.SetStage(10)
			AliciaControlQuest.SetObjectiveDisplayed(10)
			
			AliciaREF.enable()
			AliciaDaedricREF.enable()
			AliciaGhostREF.enable()
			AliciaCuredREF.disable()
		EndIf
	endEVENT
endState



       

 





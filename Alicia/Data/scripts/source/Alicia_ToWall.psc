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

MusicType Property MUSdrama  Auto  

Auto STATE Waiting
	EVENT onActivate (objectReference triggerRef)
		Actor kPlayer = Game.getPlayer()
   		ObjectReference AliciaREF= Alias_Alicia.GetReference() 
		Actor AliciaActor = AliciaREF as Actor
   		ObjectReference AliciaCuredREF= Alias_AliciaCured.GetReference() 
		Actor AliciaCuredActor = AliciaCuredREF as Actor
   		ObjectReference AliciaGhostREF= Alias_AliciaGhost.GetReference() 
		Actor AliciaGhostActor = AliciaGhostREF as Actor
		ObjectReference AliciaDaedricREF= Alias_AliciaDaedric.GetReference() 
		Actor AliciaDaedricActor = AliciaREF as Actor

		; Debug.Notification("Activating..."  )
		SendModEvent("da_PacifyNearbyEnemies")

		DeviceActivation.RemoteCast(kPlayer, kPlayer, kPlayer )

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
		AliciaStoryQuest.SetObjectiveDisplayed(60, false)

		MUSdrama.Add()


		If (AliciaDaedricSoulLocked.GetValue() == 1) && (AliciaSoulLocked.GetValue() == 1)     ; both souls locked - Alicia is cured
			; control quest stage = 40
			AliciaControlQuest.SetStage(40)
			AliciaControlQuest.SetObjectiveDisplayed(40)

            ; If !(AliciaDaedricActor.IsInFaction(pDismissedFollower))
            ;    (pDialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)
            ; EndIf

            AliciaDaedricActor.AddToFaction(pDismissedFollower)
            AliciaDaedricActor.SetPlayerTeammate(false)
            AliciaDaedricActor.RemoveFromFaction(pCurrentHireling)
            AliciaDaedricActor.SetAV("WaitingForPlayer", 0) 

        ; Review follower dismiss code 

		;	pFollowerAlias.Clear()
		;	iFollowerDismiss = 0
		;	pPlayerFollowerCount.SetValue(0)


            Utility.Wait(1.0)

            ; If !(AliciaActor.IsInFaction(pDismissedFollower))
            ;   (pDialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)
            ; EndIf

            AliciaActor.AddToFaction(pDismissedFollower)
            AliciaActor.SetPlayerTeammate(false)
            AliciaActor.RemoveFromFaction(pCurrentHireling)
            AliciaActor.SetAV("WaitingForPlayer", 0) 

            Utility.Wait(1.0)

			AliciaREF.disable()
			AliciaDaedricREF.disable()
			AliciaGhostREF.disable()
			AliciaCuredREF.enable()

			debug.messagebox("Alicia and her tormentor scream in agony as their souls are pulled into the gems inside the chest. Is this it? Is Alicia cured?")


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
			AliciaGhostREF.disable()
			AliciaCuredREF.disable()

            (pDialogueFollower as DialogueFollowerScript).SetFollower(AliciaREF)
            (pDialogueFollower as DialogueFollowerScript).FollowerFollow()

			debug.messagebox("Alicia smiles wickedly as the soul of her tormentor is pulled into the gem inside the chest. She is free to experience pain on her own terms now.")

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
			AliciaGhostREF.disable()
			AliciaCuredREF.disable()


            (pDialogueFollower as DialogueFollowerScript).SetFollower(AliciaDaedricREF)
            (pDialogueFollower as DialogueFollowerScript).FollowerFollow()

			debug.messagebox("Alicia cries out in agony as her soul is pulled into the gem inside the chest, leaving only her tormentor behind. Her daedric self is smiling wickedly at her victory over her weaker self.")

		Else                                                                                   ; Both souls are free - Keep Alicia and Ali
			; control quest stage = 10
			AliciaControlQuest.SetStage(10)
			AliciaControlQuest.SetObjectiveDisplayed(10)
			
			AliciaREF.enable()
			AliciaDaedricREF.disable()
			AliciaGhostREF.disable()
			AliciaCuredREF.disable()

			debug.messagebox("Both Alicia and her tormentor react to the shockwave of energy from the chest. They stand there, ready to serve you at your pleasure.")
		EndIf

	endEVENT
endState



       

 





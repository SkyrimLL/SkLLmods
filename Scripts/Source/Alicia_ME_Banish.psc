Scriptname Alicia_ME_Banish extends activemagiceffect  

ReferenceAlias Property Alias_Alicia  Auto  
ReferenceAlias Property Alias_AliciaDaedric  Auto  

Quest Property AliciaScenes Auto
Quest Property AliciaDaedricScenes Auto
Quest Property AliciaStory Auto

GlobalVariable Property AliciaInWorld  Auto  
GlobalVariable Property AliciaDaedricInWorld  Auto  

Faction Property pDismissedFollower Auto  
Faction Property pCurrentHireling Auto  
DialogueFollowerScript Property DialogueFollower Auto
Quest Property pDialogueFollower  Auto  
 
Event OnEffectStart(Actor akTarget, Actor akCaster)
    ObjectReference AliciaREF= Alias_Alicia.GetReference() 
    Actor AliciaActor = AliciaREF as Actor

    ObjectReference AliciaDaedricREF= Alias_AliciaDaedric.GetReference() 
    Actor AliciaDaedricActor = AliciaDaedricREF as Actor

    ObjectReference akSummoner = akCaster  as ObjectReference

    ObjectReference arPortal = None
    Float afDistance = 150.0
    Float afZOffset = 0.0
    Int aiStage = 0


	; This spell will only work on Alicia
	if ((akTarget == AliciaActor ) || (akTarget == AliciaDaedricActor ))

                While aiStage < 6
                        aiStage += 1
                        If aiStage == 1 ; Shroud summon with portal
                            if ( (akTarget == AliciaActor ) && (AliciaInWorld.GetValue() == 1))
                                Debug.SendAnimationEvent(AliciaREF, "bleedOutStart")
                                utility.wait(1)
                                Debug.SendAnimationEvent(AliciaREF, "IdleForceDefaultState")

                                arPortal = AliciaREF.PlaceAtMe(Game.GetFormFromFile(0x0007CD55, "Skyrim.ESM")) ; SummonTargetFXActivator disables and deletes itself shortly after stage 5
                            EndIf

                            if ( (akTarget == AliciaDaedricActor ) && (AliciaDaedricInWorld.GetValue() == 1))
                                Debug.SendAnimationEvent(AliciaDaedricREF, "bleedOutStart")
                                utility.wait(1)
                                Debug.SendAnimationEvent(AliciaDaedricREF, "IdleForceDefaultState")
    
                                arPortal = AliciaDaedricREF.PlaceAtMe(Game.GetFormFromFile(0x0007CD55, "Skyrim.ESM")) 
                            EndIf
                        ElseIf aiStage == 2 ; Disable Summon
                            ; Not necessary for banishment
                        ElseIf aiStage == 3 ; Move portal in front of summoner
                            ; arPortal.MoveTo(akSummoner, Math.Sin(akSummoner.GetAngleZ()) * afDistance, Math.Cos(akSummoner.GetAngleZ()) * afDistance, afZOffset)
                        ElseIf aiStage == 4 ; Move summon to portal
                            ; Not necessary for banishment
                        ElseIf aiStage == 5 ; Disable summon as the portal dissipates
         			        if ( (akTarget == AliciaActor ) && (AliciaInWorld.GetValue() == 1))
                				Debug.Notification("Sanguine pulls Alicia back to under his thumb")

                                If !(AliciaActor.IsInFaction(pDismissedFollower))
                                    (pDialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)
                                EndIf

                                AliciaActor.AddToFaction(pDismissedFollower)
                                AliciaActor.SetPlayerTeammate(false)
                                AliciaActor.RemoveFromFaction(pCurrentHireling)
                                AliciaActor.SetAV("WaitingForPlayer", 0) 

                				AliciaREF.Disable()

                                AliciaInWorld.SetValue(0)

                            EndIf

                            if ( (akTarget == AliciaDaedricActor ) && (AliciaDaedricInWorld.GetValue() == 1))
                                Debug.Notification("Sanguine pulls Alicia's twin by his side")

                                If !(AliciaDaedricActor.IsInFaction(pDismissedFollower))
                                    (pDialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)
                                EndIf
                        
                                AliciaDaedricActor.AddToFaction(pDismissedFollower)
                                AliciaDaedricActor.SetPlayerTeammate(false)
                                AliciaDaedricActor.RemoveFromFaction(pCurrentHireling)
                                AliciaDaedricActor.SetAV("WaitingForPlayer", 0) 

                                AliciaDaedricREF.Disable()

                                AliciaDaedricInWorld.SetValue(0)

                           EndIf

            				; AliciaScenes.Stop()
                            if (AliciaStory.IsObjectiveDisplayed(5))
                                AliciaStory.SetObjectiveDisplayed(6, True, True)
                                AliciaStory.SetObjectiveDisplayed(5, False, True)  ; Hide previous objective
				            EndIf
         		      
                        EndIf
                        Utility.Wait(0.6)
                EndWhile
        EndIf
EndEvent

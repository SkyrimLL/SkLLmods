Scriptname Alicia_ME_Call extends activemagiceffect  

Quest Property AliciaScenes Auto
Quest Property AliciaDaedricScenes Auto
Quest Property AliciaStory Auto

ReferenceAlias Property Alias_Alicia  Auto  
ReferenceAlias Property Alias_AliciaDaedric  Auto  

GlobalVariable Property AliciaInWorld  Auto  
GlobalVariable Property AliciaDaedricInWorld  Auto  
GlobalVariable Property AliciaSoulLocked  Auto  
GlobalVariable Property AliciaDaedricSoulLocked  Auto  

GlobalVariable Property AliciaInit  Auto 

Spell Property AliciaBloodSpell Auto

Faction Property pDismissedFollower Auto  
Faction Property pCurrentHireling Auto  
Quest Property  pDialogueFollower Auto

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

    
 	; Debug.Notification("Calling Alicia...") 
      While aiStage < 6
                aiStage += 1
                If aiStage == 1 ; Shroud summon with portal
                        arPortal = akSummoner.PlaceAtMe(Game.GetFormFromFile(0x0007CD55, "Skyrim.ESM")) ; SummonTargetFXActivator disables and deletes itself shortly after stage 5
                ElseIf aiStage == 2 ; Disable Summon
                        AliciaREF.Disable()
                        AliciaInWorld.SetValue(0)

                        AliciaDaedricREF.Disable()
                        AliciaDaedricInWorld.SetValue(0)

                ElseIf aiStage == 3 ; Move portal in front of summoner
                        ; arPortal.MoveTo(akSummoner, Math.Sin(akSummoner.GetAngleZ()) * afDistance, Math.Cos(akSummoner.GetAngleZ()) * afDistance, afZOffset)
                ElseIf aiStage == 4 ; Move summon to portal
                        if (AliciaSoulLocked.GetValue() == 0)
                            AliciaREF.MoveTo(arPortal)
                        Else
                            AliciaDaedricREF.MoveTo(arPortal)
                        EndIf

                ElseIf (aiStage == 5) && (AliciaStory.GetStage() != 40) ; Enable summon as the portal dissipates
         	  	 	; Debug.Notification("Calling Alicia... - stage 5") 
     				Debug.Trace("Enabling Alicia...") 
                    Debug.Trace("IsInWorld: " + AliciaInWorld.GetValue() )
                    Debug.Trace("IsDisabled: " + AliciaREF.IsDisabled()) 
                    Debug.Trace("AliciaREF: " + AliciaREF) 

                    if (AliciaSoulLocked.GetValue() == 0)
                        Debug.Notification("Sanguine returns Alicia to her favorite caretaker")
                        AliciaREF.Enable()

                        AliciaInWorld.SetValue(1)

                        AliciaActor.UnequipAll()

                        AliciaActor.UnequipAll()
                        if (StorageUtil.GetIntValue(none, "_SD_iSanguine")==1)
                            Debug.Trace("[Alicia] SD+ detected - equip devices")
                            If (Utility.RandomInt(0,100)> 90)
                            ;    AliciaActor.SendModEvent("SDEquipDevice",   "Blindfold|Dremora")
                            Else
                            ;    AliciaActor.SendModEvent("SDClearDevice",   "Blindfold")
                            endif
                            If (Utility.RandomInt(0,100)> 90)
                                AliciaActor.SendModEvent("SDEquipDevice",   "WristRestraints")
                            Else
                                AliciaActor.SendModEvent("SDClearDevice",   "WristRestraints")
                            endif
                            If (Utility.RandomInt(0,100)> 10)
                                AliciaActor.SendModEvent("SDEquipDevice",   "VaginalPiercing")
                            Else
                                AliciaActor.SendModEvent("SDClearDevice",   "VaginalPiercing")
                            endif
                            If (Utility.RandomInt(0,100)> 60)
                                AliciaActor.SendModEvent("SDEquipDevice",   "PlugAnal|Dremora")
                                AliciaActor.SendModEvent("SDEquipDevice",   "PlugVaginal|Dremora")
                                AliciaActor.SendModEvent("SDEquipDevice",   "Belt|Dremora") 
                            Else
                                AliciaActor.SendModEvent("SDClearDevice",   "Belt")
                                AliciaActor.SendModEvent("SDClearDevice",   "Plugvaginal")
                                AliciaActor.SendModEvent("SDClearDevice",   "PlugAnal")
                            Endif
                            If (Utility.RandomInt(0,100)> 30)
                                AliciaActor.SendModEvent("SDEquipDevice",   "Gag|Dremora")
                            Else
                                AliciaActor.SendModEvent("SDClearDevice",   "Gag")
                            endif
                            If (Utility.RandomInt(0,100)> 70)
                                AliciaActor.SendModEvent("SDEquipDevice",   "Collar", 1) 
                                AliciaActor.SendModEvent("SDEquipDevice",   "LegCuffs", 1)
                            Else
                                AliciaActor.SendModEvent("SDClearDevice",   "Collar", 1)
                                AliciaActor.SendModEvent("SDClearDevice",   "LegCuffs", 1)
                            endif
                         endif

                        AliciaBloodSpell.RemoteCast(AliciaRef , AliciaActor ,AliciaRef )

                        (pDialogueFollower as DialogueFollowerScript).SetFollower(AliciaREF)
                        (pDialogueFollower as DialogueFollowerScript).FollowerFollow()

                        if (AliciaStory.IsObjectiveDisplayed(6))
                            AliciaStory.SetObjectiveDisplayed(5, True, True)
                            AliciaStory.SetObjectiveDisplayed(6, False, True)  ; Hide previous objective
                        EndIf

                        ; Debug.Notification("Alicia rises")
                    ElseIf  (AliciaDaedricSoulLocked.GetValue() == 0)
                        Debug.Notification("Ali returns reluctantly")
                        AliciaDaedricREF.Enable()

                        AliciaDaedricInWorld.SetValue(1)

                        (pDialogueFollower as DialogueFollowerScript).SetFollower(AliciaDaedricREF)
                        (pDialogueFollower as DialogueFollowerScript).FollowerFollow()

                        if (AliciaStory.IsObjectiveDisplayed(6))
                            AliciaStory.SetObjectiveDisplayed(5, True, True)
                            AliciaStory.SetObjectiveDisplayed(6, False, True)  ; Hide previous objective
                        EndIf

                        ; Debug.Notification("Alicia rises")                   
                    EndIf
                      
                 ElseIf (aiStage == 5) && (AliciaStory.GetStage() == 40) 
                     Debug.MessageBox("Alicia does not answer your call.") 
                 EndIf
                Utility.Wait(0.6)
        EndWhile
EndEvent
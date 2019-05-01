Scriptname Alicia_ME_DaedricChangeFX extends ActiveMagicEffect  

ReferenceAlias Property Alias_Alicia  Auto  
ReferenceAlias Property Alias_AliciaDaedric  Auto  

Quest Property AliciaScenes Auto
Quest Property AliciaDaedricScenes Auto
Quest Property AliciaStory Auto

GlobalVariable Property AliciaInWorld  Auto  
GlobalVariable Property AliciaDaedricInWorld  Auto  
GlobalVariable Property AliciaSoulLocked  Auto  
GlobalVariable Property AliciaDaedricSoulLocked  Auto  

Armor  Property AliciaClothingToken  Auto  
Spell Property AliciaBloodSpell Auto

LeveledItem Property AliciaTortureDevice  Auto  
LeveledItem Property AliciaBondage  Auto  

ObjectReference Property AliciaChestREF  Auto  

Quest Property pDialogueFollower  Auto  

Faction  Property pCurrentHireling Auto  
Faction  Property pDismissedFollower Auto  


Event OnEffectStart(Actor akTarget, Actor akCaster)
    ObjectReference AliciaREF= Alias_Alicia.GetReference() 
    Actor AliciaActor = AliciaREF as Actor
    ObjectReference AliciaDaedricREF= Alias_AliciaDaedric.GetReference() 
    Actor AliciaDaedricActor = AliciaREF as Actor
    ObjectReference akSummoner = akCaster  as ObjectReference

    ObjectReference arPortal = None

    Float afDistance = 150.0
    Float afZOffset = 0.0
    Int aiStage = 0
    Int AliciaState

    if ((AliciaSoulLocked.GetValue() == 1) || (AliciaDaedricSoulLocked.GetValue() == 1))
        return
    EndIf

    ; enable transformation only if one avatar is in world at a time
    if ((AliciaInWorld.GetValue() == 1) || (AliciaDaedricInWorld.GetValue() == 1))
      While aiStage < 6
                aiStage += 1
                If aiStage == 1 ; Shroud summon with portal
                        ; Let her glow for a while 
                        ; TO DO: Send hovering animation (ritual?)
                    if (AliciaInWorld.GetValue() == 1)
                        Debug.SendAnimationEvent(AliciaREF, "bleedOutStart")
                        utility.wait(1)
                        Debug.SendAnimationEvent(AliciaREF, "IdleForceDefaultState")
                    EndIf

                    If (AliciaDaedricInWorld.GetValue() == 1)
                        Debug.SendAnimationEvent(AliciaDaedricREF, "bleedOutStart")
                        utility.wait(1)
                        Debug.SendAnimationEvent(AliciaDaedricREF, "IdleForceDefaultState")
                    EndIF
                    
                    arPortal = akSummoner.PlaceAtMe(Game.GetFormFromFile(0x0007CD55, "Skyrim.ESM")) ; SummonTargetFXActivator disables and deletes itself shortly after stage 5
                ElseIf aiStage == 2 ; Disable Summon
                    if (AliciaInWorld.GetValue() == 1)
                        If !(AliciaActor.IsInFaction(pDismissedFollower))
                            (pDialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)
                        EndIf

                        ; Debug.Notification("Dispatching Alicia") 
                        AliciaActor.AddToFaction(pDismissedFollower)
                        AliciaActor.SetPlayerTeammate(false)
                        AliciaActor.RemoveFromFaction(pCurrentHireling)
                        AliciaActor.SetAV("WaitingForPlayer", 1)  

            			AliciaREF.Disable()
                   EndIf

                    If (AliciaDaedricInWorld.GetValue() == 1)
                        If !(AliciaDaedricActor.IsInFaction(pDismissedFollower))
                            (pDialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)
                        EndIf

                        ; Debug.Notification("Dispatching Alicia's evil twin...") 

                        AliciaDaedricActor.AddToFaction(pDismissedFollower)
                        AliciaDaedricActor.SetPlayerTeammate(false)
                        AliciaDaedricActor.RemoveFromFaction(pCurrentHireling)
                        AliciaDaedricActor.SetAV("WaitingForPlayer", 1) 

                        AliciaDaedricREF.Disable()
                    EndIf
                ElseIf aiStage == 3 ; Move portal in front of summoner
                        ; arPortal.MoveTo(Game.GetPlayer(), Math.Sin(akSummoner.GetAngleZ()) * afDistance, Math.Cos(akSummoner.GetAngleZ()) * afDistance, afZOffset)
                        ; arPortal = akSummoner.PlaceAtMe(Game.GetFormFromFile(0x0007CD55, "Skyrim.ESM"))
                ElseIf aiStage == 4 ; Move summon to portal

                    if (AliciaInWorld.GetValue() == 1)
                        ; Debug.Notification("Calling Alicia's evil twin...") 
                        ; Debug.Notification("Alicia's twin:" + AliciaDaedricREF)
                       AliciaDaedricREF.MoveTo(Game.GetPlayer())
                    EndIf

                    If (AliciaDaedricInWorld.GetValue() == 1)
                        ; Debug.Notification("Calling Alicia...") 
                       AliciaREF.MoveTo(Game.GetPlayer())
                    EndIf
                ElseIf aiStage == 5 ; Enable summon as the portal dissipates
         	  	 	; Debug.Notification("Calling Alicia... - stage 5") 
     				; Debug.Notification("Enabling Alicia...") 

                    if (AliciaInWorld.GetValue() == 1)
                        AliciaState = 1 ; Daedric
                    ElseIf (AliciaDaedricInWorld.GetValue() == 1)
                        AliciaState = 0 ; Human 
                    EndIf

                    If (AliciaState == 0)
                         Debug.Notification("Sanguine returns a new Alicia to her favorite caretaker")
                        AliciaREF.Enable()

                        ; undress Alicia 
                        ; to do: add blood effect to Alicia
                        ; AliciaREF.additem(AliciaClothingToken)
                        utility.wait(0.5)
                        ; AliciaREF.removeitem(AliciaClothingToken)

                        (pDialogueFollower as DialogueFollowerScript).SetFollower(AliciaREF)
                        (pDialogueFollower as DialogueFollowerScript).FollowerFollow()

                        ; If (Utility.RandomInt(0,100)> 0)
                        Debug.Trace("[Alicia] Undress")
                        AliciaActor.UnequipAll()
                        if (StorageUtil.GetIntValue(none, "_SD_iSanguine")==1)
                            Debug.Trace("[Alicia] SD+ detected - equip devices")
                            If (Utility.RandomInt(0,100)> 90)
                            ;    AliciaActor.SendModEvent("SDEquipDevice",   "Blindfold|blindfold,leather,zap")
                            Else
                            ;   AliciaActor.SendModEvent("SDClearDevice",   "Blindfold")
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
                                AliciaActor.SendModEvent("SDEquipDevice",   "PlugAnal|plug,anal,heretic,ddx")
                                AliciaActor.SendModEvent("SDEquipDevice",   "Plugvaginal|plug,vaginal,heretic,ddx")
                                AliciaActor.SendModEvent("SDEquipDevice",   "Belt|belt,metal,iron") 
                            Else
                                AliciaActor.SendModEvent("SDClearDevice",   "Belt")
                                AliciaActor.SendModEvent("SDClearDevice",   "Plugvaginal")
                                AliciaActor.SendModEvent("SDClearDevice",   "PlugAnal")
                            Endif
                            If (Utility.RandomInt(0,100)> 30)
                                AliciaActor.SendModEvent("SDEquipDevice",   "Gag|gag,heretic,ddx")
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
                     
                        else
                            Debug.Trace("[Alicia] No SD+ - equip outfits")
                            ; AliciaActor.removeallitems(AliciaChestREF)
                            ; utility.wait(0.5)
                            
                            AliciaREF.additem(AliciaBondage)
                            AliciaActor.equipitem(AliciaBondage,False)
                            utility.wait(0.5)

                            AliciaREF.additem(AliciaTortureDevice)
                            AliciaActor.equipitem(AliciaTortureDevice,False)

                            ; AliciaActor.QueueNiNodeUpdate()
                        endif
                        
                        utility.wait(0.5)
                        ; Else
                        ; EndIf
                        
                        Debug.Trace("[Alicia] Cast blood effect")
                        AliciaBloodSpell.RemoteCast(AliciaRef , AliciaActor ,AliciaRef )

                        AliciaActor.SetAV("WaitingForPlayer", 0)  

                        AliciaInWorld.SetValue(1)
                        AliciaDaedricInWorld.SetValue(0)

                      ; Debug.Notification("Alicia is back...")
                    ElseIf (AliciaState == 1)
                        Debug.Notification("Sanguine returns a new and improved Alicia to her favorite caretaker")
                        AliciaDaedricREF.Enable()

                        AliciaDaedricREF.IgnoreFriendlyHits(true)
                        (AliciaDaedricREF as Actor).AllowBleedoutDialogue(true)

                        (pDialogueFollower as DialogueFollowerScript).SetFollower(AliciaDaedricREF)
                        (pDialogueFollower as DialogueFollowerScript).FollowerFollow()

                        ; dress up Alicia's evil twin
                        AliciaDaedricREF.additem(AliciaClothingToken)
                        utility.wait(0.5)
                        AliciaDaedricREF.removeitem(AliciaClothingToken)

                        AliciaDaedricActor.SetAV("WaitingForPlayer", 0)  

                        AliciaInWorld.SetValue(0)
                        AliciaDaedricInWorld.SetValue(1)
                    EndIf



                    ; Debug.Notification("Alicia rises")
                      
                EndIf
                Utility.Wait(0.6)
        EndWhile
EndIf

EndEvent





Scriptname Alicia_TRG_MistyGrove extends ObjectReference  


Quest Property AliciaStory Auto
 
ReferenceAlias Property Alias_Alicia  Auto  
ReferenceAlias Property Alias_AliciaDaedric  Auto  

GlobalVariable Property AliciaInWorld  Auto  
GlobalVariable Property AliciaDaedricInWorld  Auto  

ObjectReference Property AliciaCageMarker Auto
ObjectReference Property AliciaDaedricStartMarker Auto

Faction Property pDismissedFollower Auto  
Faction Property pCurrentHireling Auto  
Spell Property AliciaBloodSpell Auto
LeveledItem Property AliciaTortureDevice  Auto  
LeveledItem Property AliciaBondage  Auto  

ObjectReference Property AliciaChestREF  Auto  

Event OnTriggerEnter(ObjectReference akActionRef)
	; Debug.Notification("Alicia: Someone enters basement")
    ObjectReference AliciaREF= Alias_Alicia.GetReference() 
    Actor AliciaActor = AliciaREF as Actor
    ObjectReference AliciaDaedricREF= Alias_AliciaDaedric.GetReference() 
    Actor AliciaDaedricActor = AliciaDaedricREF as Actor

    if ( (akActionRef == Game.GetPlayer())  && (AliciaStory.GetStage() == 50)) 
        ; Debug.Notification("Alicia: Start quest ")
        Utility.Wait(1)

        AliciaREF.Disable()
        AliciaDaedricREF.Disable()

        AliciaREF.MoveTo(AliciaCageMarker )
        AliciaDaedricREF.MoveTo(AliciaDaedricStartMarker )

        Utility.Wait(1.0)

        AliciaREF.Enable()
        AliciaDaedricREF.Enable()

        Utility.Wait(1.0)

        AliciaActor.AddToFaction(pDismissedFollower)
        AliciaActor.SetPlayerTeammate(false)
        AliciaActor.RemoveFromFaction(pCurrentHireling)
        AliciaActor.SetAV("WaitingForPlayer", 0) 

        AliciaDaedricActor.AddToFaction(pDismissedFollower)
        AliciaDaedricActor.SetPlayerTeammate(false)
        AliciaDaedricActor.RemoveFromFaction(pCurrentHireling)
        AliciaDaedricActor.SetAV("WaitingForPlayer", 0) 

        ; AliciaActor.removeallitems(AliciaChestREF)
        ; utility.wait(0.5)
                              
        ; AliciaREF.additem(AliciaBondage)
        ; AliciaActor.equipitem(AliciaBondage,False)
        ; utility.wait(0.5)

        ; AliciaREF.additem(AliciaTortureDevice)
        ; AliciaActor.equipitem(AliciaTortureDevice,False)

        ; AliciaActor.QueueNiNodeUpdate()

        ; utility.wait(0.5)

        ; AliciaBloodSpell.RemoteCast(AliciaRef , AliciaActor ,AliciaRef )

        ; AliciaActor.EvaluatePackage()
        ; AliciaDaedricActor.EvaluatePackage()

        AliciaInWorld.SetValue(1)
        AliciaDaedricInWorld.SetValue(1)

        Utility.Wait(0.6)

        AliciaStory.SetStage(55)  ; Prevent repeated triggers of scene between alicia and ali

    endif

EndEvent

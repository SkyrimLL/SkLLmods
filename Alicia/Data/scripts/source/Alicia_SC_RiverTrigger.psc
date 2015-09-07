Scriptname Alicia_SC_RiverTrigger extends ObjectReference  

Quest Property AliciaStory Auto
 
ReferenceAlias Property Alias_Alicia  Auto  
ReferenceAlias Property Alias_AliciaDaedric  Auto  

GlobalVariable Property AliciaInWorld  Auto  

ObjectReference Property AliciaGhostPrisonMarker Auto

Event OnTriggerEnter(ObjectReference akActionRef)
	; Debug.Notification("Alicia: Someone enters basement")
	Actor AliciaActor= Alias_Alicia.GetReference() as Actor
	Actor AliciaDaedricActor= Alias_AliciaDaedric.GetReference() as Actor

     if ( (akActionRef == Game.GetPlayer())  && (AliciaInWorld.Getvalue() == 1)) 
        ; Debug.Notification("Alicia: Start quest ")
		Utility.Wait(1)

	; On enter, Disable Alicia Ghost
	; Move Ghost to prison entrance marker
	; Enable ghost
	; Move ghost inside prison
	

     endif

EndEvent

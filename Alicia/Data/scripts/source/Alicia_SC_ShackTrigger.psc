Scriptname Alicia_SC_ShackTrigger extends ObjectReference  


Quest Property AliciaStory Auto
 
ReferenceAlias Property Alias_Alicia  Auto  
ReferenceAlias Property Alias_AliciaDaedric  Auto  

GlobalVariable Property AliciaInWorld  Auto  

ObjectReference Property AliciaGhostRiverMarker Auto

Event OnTriggerEnter(ObjectReference akActionRef)
	; Debug.Notification("Alicia: Someone enters basement")
	Actor AliciaActor= Alias_Alicia.GetReference() as Actor
	Actor AliciaDaedricActor= Alias_AliciaDaedric.GetReference() as Actor

     if ( (akActionRef == Game.GetPlayer())  && (AliciaInWorld.Getvalue() == 1)) 
        ; Debug.Notification("Alicia: Start quest ")
		Utility.Wait(1)

	; Player enters shack
	; Move Alicia Ghost to river marker
	; Move Alicia to river marker
	; Banish alicia
	; Set quest stage (disable Call Alicia spell until quest is finished)

 

     endif

EndEvent
 

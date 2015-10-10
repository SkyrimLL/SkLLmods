Scriptname SL_Dibella_TRG_RemoveBondage extends ObjectReference  

Event OnTriggerEnter(ObjectReference akActionRef)
	ObjectReference SybilREF= SybilAlias.GetReference()
	Actor SybilActor= SybilAlias.GetActorRef() 

     ;  if ( (akActionRef == Game.GetPlayer())  && (SybilREF != None)  ) 
     		; Debug.Notification("Sybil is enabled:" + SybilREF)

      		SybilActor.setoutfit(SybilMinerOutfit )
      		utility.wait(0.5)

		; Run once
		SybilInitTrigger.disable()
	; EndIf
EndEvent
ReferenceAlias Property SybilAlias  Auto  

Outfit Property SybilMinerOutfit  Auto  

ObjectReference Property SybilInitTrigger  Auto  

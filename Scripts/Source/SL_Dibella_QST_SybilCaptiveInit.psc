Scriptname SL_Dibella_QST_SybilCaptiveInit extends ObjectReference  

ReferenceAlias Property SybilAlias  Auto  

LeveledItem Property TortureDevice  Auto  
LeveledItem Property BondageItem  Auto  
Armor Property MinerOutfit Auto

Event OnTriggerEnter(ObjectReference akActionRef)
	ObjectReference SybilREF= SybilAlias.GetReference()
	Actor SybilActor= SybilAlias.GetActorRef() 

      if ( (akActionRef == Game.GetPlayer())  && (SybilREF != None)  ) 
     		; Debug.Notification("Sybil is enabled:" + SybilREF)

             ; SybilActor.removeallitems(CaptorsChestREF  )
             ; utility.wait(0.5)

      		SybilREF.additem(BondageItem  )
      		SybilActor.equipitem(BondageItem  ,False,False)
      		utility.wait(0.5)

      		SybilREF.additem(TortureDevice  )
      		SybilActor.equipitem(TortureDevice  ,False,False)
      		utility.wait(0.5)

      		SybilREF.additem(MinerOutfit )
      		SybilActor.equipitem(MinerOutfit ,False,False)
      		utility.wait(0.5)

		; Run once
		SybilReleaseTrigger.enable() 
		SybilInitTrigger.disable()
	EndIf
EndEvent


ObjectReference Property SybilInitTrigger  Auto  

ObjectReference Property CaptorsChestREF  Auto  

ObjectReference Property SybilReleaseTrigger  Auto  

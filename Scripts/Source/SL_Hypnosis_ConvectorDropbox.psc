Scriptname SL_Hypnosis_ConvectorDropbox extends ObjectReference  

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
    if !akSourceContainer
      ;  Debug.Notification("I picked up " + aiItemCount + "x " + akBaseItem.GetName() + " from the world")
    elseif akSourceContainer == Game.GetPlayer()
    ;    Debug.Notification("The player gave me " + aiItemCount + "x " + akBaseItem.GetName())
    ;    Debug.Notification("Reference is " + akItemReference)
    else
      ;  Debug.Notification("I got " + aiItemCount + "x " + akBaseItem.GetName() + " from another container")
    endIf
endEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
    if !akDestContainer
       ; Debug.Notification("I dropped " + aiItemCount + "x " + akBaseItem.GetName() + " into the world")
    elseif akDestContainer == Game.GetPlayer()
      ; Debug.Notification("I gave the player " + aiItemCount + "x " + akBaseItem.GetName() )
  
      ; Debug.Notification("Control device set to " + akItemReference)
      ; if ((akBaseItem as Armor).GetEnchantment() == kMyMindControlEnchantment)
          ; do stuff
        ;  Alias_MCDevice.Clear()
        ;  Alias_MCDevice.ForceRefTo(akItemReference as Actor)
        ;  Debug.Notification("[MC] MC effect transfered to " + (Alias_MCDevice.GetReference() as Actor).GetLeveledActorBase().GetName())
      ; endIf
	    

    else
       ; Debug.Notification("I gave " + aiItemCount + "x " + akBaseItem.GetName() + " to another container")
    endIf
endEvent

ReferenceAlias Property Alias_MCDevice  Auto  
; Enchantment Property kMyMindControlEnchantment Auto
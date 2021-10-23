Scriptname SLP_TRG_DwemerTonalDeviceContainer extends ObjectReference  
 

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)

    if !akSourceContainer
        ; Debug.Notification("I picked up " + aiItemCount + "x " + akBaseItem.GetName() + " from the world")
    elseif akSourceContainer == Game.GetPlayer()
        ; Debug.Notification("The player gave me " + aiItemCount + "x " + akBaseItem.GetName())
        If (akBaseItem.GetName() == "Tonal Key") || akBaseItem.hasKeywordString("_SLP_DwemerTonalKeyword")
    		Debug.MessageBox("[The button flashes blue]")
            StorageUtil.SetIntValue(none, "_SLP_toggleTonalKey", 1 )
        EndIf
    else
        ; Debug.Notification("I got " + aiItemCount + "x " + akBaseItem.GetName() + " from another container")
    endIf
endEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
    if !akDestContainer
        ; Debug.Notification("I dropped " + aiItemCount + "x " + akBaseItem.GetName() + " into the world")
    elseif akDestContainer == Game.GetPlayer()
        ; Debug.Notification("I gave the player " + aiItemCount + "x " + akBaseItem.GetName() )
        If (akBaseItem.GetName() == "Tonal Key") || akBaseItem.hasKeywordString("_SLP_DwemerTonalKeyword")
    		Debug.MessageBox("[The button flashes red]")
            StorageUtil.SetIntValue(none, "_SLP_toggleTonalKey", 0 )
        EndIf
    else
        ; Debug.Notification("I gave " + aiItemCount + "x " + akBaseItem.GetName() + " to another container")
    endIf
endEvent
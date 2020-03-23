Scriptname SLS_TRG_SexBotAssemblyLocker extends ObjectReference  

Keyword Property SLS_SexBotPartKw Auto

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
    if !akSourceContainer
        ; Debug.Notification("I picked up " + aiItemCount + "x " + akBaseItem.GetName() + " from the world")
    elseif akSourceContainer == Game.GetPlayer()
        ; Debug.Notification("The player gave me " + aiItemCount + "x " + akBaseItem.GetName())
        ; If (akBaseItem.GetName() == "Alicia's soul shard")
        ;   AliciaSoulLocked.SetValue(1)
        ;ElseIf (akBaseItem.GetName() == "Daedric soul shard")
        ;    AliciaDaedricSoulLocked.SetValue(1)
        ;EndIf
    else
        ; Debug.Notification("I got " + aiItemCount + "x " + akBaseItem.GetName() + " from another container")
    endIf
endEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
    if !akDestContainer
        ; Debug.Notification("I dropped " + aiItemCount + "x " + akBaseItem.GetName() + " into the world")
    elseif akDestContainer == Game.GetPlayer()
        ; Debug.Notification("I gave the player " + aiItemCount + "x " + akBaseItem.GetName() )
        ;If (akBaseItem.GetName() == "Alicia's soul shard")
        ;    AliciaSoulLocked.SetValue(0)
        ;ElseIf (akBaseItem.GetName() == "Daedric soul shard")
        ;    AliciaDaedricSoulLocked.SetValue(0)
        ;EndIf
    else
        ; Debug.Notification("I gave " + aiItemCount + "x " + akBaseItem.GetName() + " to another container")
    endIf
endEvent
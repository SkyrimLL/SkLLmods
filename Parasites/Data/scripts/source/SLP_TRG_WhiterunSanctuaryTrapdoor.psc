Scriptname SLP_TRG_WhiterunSanctuaryTrapdoor extends ObjectReference  


Event OnTriggerEnter(ObjectReference akActionRef)
	Actor akPlayer = Game.GetPlayer()
	Form RightHandWeapon 
	Form LeftHandWeapon  

     if (akActionRef == Game.GetPlayer()) 
		RightHandWeapon = akPlayer.GetEquippedWeapon(0) 
		LeftHandWeapon = akPlayer.GetEquippedWeapon(1)

     		; Debug.Notification("Player walking through - Eggs: " + eggsCount)
     		if (QueenOfChaurusQuest.GetStageDone(250)==0)
     			KyneSanctuaryDoor.Lock()
     		else
				if ((RightHandWeapon as Weapon) != Nettlebane) && ((LeftHandWeapon as Weapon) != Nettlebane) && (QueenOfChaurusQuest.GetStageDone(255)==0)
				    Debug.Messagebox("Danica told me to use Nettlebane inside the Sanctuary. I should be holding it.")
				endif
     			KyneSanctuaryDoor.Lock(false, true)
     		Endif
 
	EndIf
EndEvent

Quest Property QueenOfChaurusQuest Auto
WEAPON Property Nettlebane  Auto  

ObjectReference Property KyneSanctuaryDoor  Auto  

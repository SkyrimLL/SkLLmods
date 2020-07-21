Scriptname SLP_TRG_BroodMaiden extends ObjectReference  

Event OnTriggerEnter(ObjectReference akActionRef)

     if (akActionRef == Game.GetPlayer()) 
     		; Debug.Notification("Player walking through - Eggs: " + eggsCount)
     		if (QueenOfChaurusQuest.GetStageDone(210)==1) && (QueenOfChaurusQuest.GetStageDone(220)==0)
     			Debug.MessageBox("The corpse of Lastelle lies in the murky water, surrounded by the eggs she cared so much about. Her skin is covered with strange, glowing growths. A star shaped object is firmly lodges in her vagina.. similar to the Seed Stone, but softer, almost melted away and with tendrils reaching deep inside her body. Maybe Danica PureSpring will know what happened.")
     			QueenOfChaurusQuest.SetStage(220)
     		Endif
 
	EndIf
EndEvent

Quest Property QueenOfChaurusQuest Auto
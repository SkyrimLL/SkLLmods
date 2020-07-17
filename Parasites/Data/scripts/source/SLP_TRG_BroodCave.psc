Scriptname SLP_TRG_BroodCave extends ObjectReference  


Event OnTriggerEnter(ObjectReference akActionRef)
	int eggsCount = SLP_GV_ChaurusEggsLastelle.GetValue() as Int

     if (akActionRef == Game.GetPlayer()) 
     		; Debug.Notification("Player walking through - Eggs: " + eggsCount)

     		if (eggsCount>=20) 
     			EggSack01.enable()
     		endif

     		if (eggsCount>=40) 
     			EggSack02.enable()
     		endif

     		if (eggsCount>=60) 
     			EggSack03.enable()
     		endif

     		if (eggsCount>=80) 
     			EggSack04.enable()
     		endif

	EndIf
EndEvent

GlobalVariable Property SLP_GV_ChaurusEggsLastelle  Auto  

ObjectReference Property EggSack01 Auto
ObjectReference Property EggSack02 Auto
ObjectReference Property EggSack03 Auto
ObjectReference Property EggSack04 Auto

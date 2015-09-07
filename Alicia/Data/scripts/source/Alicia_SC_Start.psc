Scriptname Alicia_SC_Start extends ObjectReference  

Actor  Property Alicia  Auto 
GlobalVariable Property AliciaInit  Auto  

Event  OnTriggerEnter(ObjectReference akActionRef)

	if  (akActionRef == (Alicia as ObjectReference))
	    ; Debug.Notification("Alicia rises")

		if (AliciaInit.GetValue() == 0)
			; Alicia.IgnoreFriendlyHits(true)
			; Alicia.AllowBleedoutDialogue(true)
			; Alicia.ForceAV("HealRate", 0.1)
			; Alicia.unequipall()

			; Debug.Notification("Alicia is ready")
		EndIf
	endIf
endEvent

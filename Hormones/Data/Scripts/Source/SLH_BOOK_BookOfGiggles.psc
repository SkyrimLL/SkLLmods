Scriptname SLH_BOOK_BookOfGiggles extends ObjectReference  


event onRead()
	Actor kPlayer = Game.GetPlayer()

	if (sCurse == "")
		sCurse = "Bimbo"
	Endif
	
	; Heal the player - useful action to invite player to read the book often
	kPlayer.resethealthandlimbs()

	; Mess with Hormone levels - similar to sex with Daedra
	; This will move the player along toward a gradual transformation
	kPlayer.SendModEvent("SLHModHormoneRandom",sCurse , 1.5)

	if (sCurse == "Bimbo")
		Debug.Notification("The spiral makes you feel fuzzy and giggly... read the scroll again.")

		; Play a bimbo moan or thought - the "now" parameter is use to bypass the random thought throttling mechanism
		kPlayer.SendModEvent("SLHBimboThoughts","now")

		; 1% chance of instant transformation
		If (Utility.RandomInt(0,100)>95)
			kPlayer.SendModEvent("SLHCastBimboCurse")
		Endif

	elseif (sCurse == "HRT")
		Debug.Notification("The drawing on the scroll is slowly pushing you to the opposite gender.")

		; 1% chance of instant transformation
		If (Utility.RandomInt(0,100)>95)
			kPlayer.SendModEvent("SLHCastHRTCurse")
		Endif

	elseif (sCurse == "TG")
		Debug.Notification("The drawing on the scroll is changing you to the core.")

		; 1% chance of instant transformation
		If (Utility.RandomInt(0,100)>95)
			kPlayer.SendModEvent("SLHCastHRTCurse")
		Endif
	endif


endEvent

String Property sCurse Auto
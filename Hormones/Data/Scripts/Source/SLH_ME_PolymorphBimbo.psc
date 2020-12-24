Scriptname SLH_ME_PolymorphBimbo extends activemagiceffect  

Event OnEffectStart(Actor Target, Actor Caster)

	Actor kPlayer = Game.GetPlayer()

	Debug.Notification("The potion makes you feel so fuzzy and tingly.")
	
	; Heal the player - useful action to invite player to read the book often
	kPlayer.resethealthandlimbs()

	; Mess with Hormone levels - similar to sex with Daedra
	; This will move the player along toward a gradual transformation
	kPlayer.SendModEvent("SLHModHormoneRandom")

	; Play a bimbo moan or thought - the "now" parameter is use to bypass the random thought throttling mechanism
	kPlayer.SendModEvent("SLHBimboThoughts","now")

	; 1% chance of instant transformation
	If (Utility.RandomInt(0,100)>99)
		kPlayer.SendModEvent("SLHCastBimboCurse")
	Endif
 
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox("Bimbo spell ended")    
ENDEVENT


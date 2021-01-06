Scriptname SLH_ME_HormoneMetabolismUp extends activemagiceffect  


Event OnEffectStart(Actor Target, Actor Caster)

	Actor kPlayer = Game.GetPlayer()

	Debug.Notification("The potion is very bitter.")
	
	; Mess with Hormone levels - similar to sex with Daedra
	; This will move the player along toward a gradual transformation
	kPlayer.SendModEvent("SLHModHormone", "Metabolism", 10.0 + Utility.RandomFloat(0.0,10.0))

 
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox("Bimbo spell ended")    
ENDEVENT


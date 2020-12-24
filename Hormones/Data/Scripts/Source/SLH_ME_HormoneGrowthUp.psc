Scriptname SLH_ME_HormoneGrowthUp extends activemagiceffect  

Event OnEffectStart(Actor Target, Actor Caster)

	Actor kPlayer = Game.GetPlayer()

	Debug.Notification("The potion makes you feel warm.")
	
	; Mess with Hormone levels - similar to sex with Daedra
	; This will move the player along toward a gradual transformation
	kPlayer.SendModEvent("SLHModHormone", "Growth", 10 + Utility.RandomInt(0,10))

 
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox("Bimbo spell ended")    
ENDEVENT


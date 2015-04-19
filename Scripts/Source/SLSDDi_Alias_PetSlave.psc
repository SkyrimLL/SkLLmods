Scriptname SLSDDi_Alias_PetSlave extends ReferenceAlias  

Event OnEnterBleedout()
  	; Debug.Trace("We entered bleedout...")

	if (Utility.RandomInt(0,100) > 50)
		FreeSlaveScene.Start()
	endif
endEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  	bool abBashAttack, bool abHitBlocked)
	Actor PetSlaveActor= _SLSD_PetSlaveREF.GetReference() as Actor

	float petSlaveHealth = PetSlaveActor.GetAVPercentage("Health")
 	; Debug.Notification("[SL Stories] Pet Slave hit. Pct Health:  " + petSlaveHealth)
	if (petSlaveHealth < 0.5)
  	;	Debug.Trace("Bob has less then 10% health remaining")
		FreeSlaveScene.Start()
	endIf
EndEvent

ReferenceAlias Property _SLSD_PetSlaveREF Auto
Scene Property FreeSlaveScene Auto
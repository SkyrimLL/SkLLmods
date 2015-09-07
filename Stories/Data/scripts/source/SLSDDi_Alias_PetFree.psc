Scriptname SLSDDi_Alias_PetFree extends ReferenceAlias  

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  	bool abBashAttack, bool abHitBlocked)
	Actor PetFreeActor= _SLSD_PetFreeREF.GetReference() as Actor
 	; Debug.Trace("We were hit by " + akAggressor)

	float petFreeHealth = PetFreeActor.GetAVPercentage("Health")
	if (_SLSD_PetPlugFree.GetValue() == 1) &&  (petFreeHealth < 0.2)
  	;	Debug.Trace("Bob has less then 10% health remaining")
		PetSlaveFreeScene.Start()
	endIf
EndEvent

ReferenceAlias Property _SLSD_PetFreeREF Auto

Scene Property PetSlaveFreeScene  Auto  
GlobalVariable Property _SLSD_PetPlugFree  Auto  
Scriptname SLSDDi_MEF_LactationSupplement extends activemagiceffect  


Event OnEffectStart(Actor Target, Actor Caster)
	Actor kPlayer = Game.GetPlayer()
	Float fLactationHormoneMod

	fLactationHormoneMod = Utility.RandomFloat(2.0, 10.0)
	
	; StorageUtil.SetIntValue(kActor, "_SLH_iProlactinLevel", iProlactinLevel )
 	Target.SendModEvent("SLHModHormone", "Lactation", fLactationHormoneMod )
 	Target.SendModEvent("SLHModHormone", "Fertility", fLactationHormoneMod )
 	Target.SendModEvent("SLHModHormone", "Female", fLactationHormoneMod / 2.0 )
 	Target.SendModEvent("SLHModHormone", "Male", -1.0 * fLactationHormoneMod / 2.0 )

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
ENDEVENT
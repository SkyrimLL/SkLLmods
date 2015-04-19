Scriptname SL_Hypnosis_controlAlias extends ReferenceAlias  

SPELL Property DetectVictimSpell  Auto  
SPELL Property ShowVictimStatus  Auto  

Event OnEquipped(Actor akActor)

; 	Debug.Trace(self + "OnEquipped()")

	if  akActor == Game.GetPlayer()
		Game.GetPlayer().AddSpell(DetectVictimSpell  )
		; Game.GetPlayer().AddSpell(ShowVictimStatus  )
		Utility.Wait(0.5)
		StorageUtil.SetIntValue(Game.GetPlayer(), "Puppet_SpellON", 1)
		StorageUtil.SetIntValue(Game.GetPlayer(), "_SLMC_controlDeviceON", 1)
	endIf
endEvent


Event OnUnequipped(Actor akActor)
	
	if  akActor == Game.GetPlayer()
		Game.GetPlayer().RemoveSpell(DetectVictimSpell  )
		; Game.GetPlayer().RemoveSpell(ShowVictimStatus  )
		Utility.Wait(0.5)

		if (StorageUtil.GetIntValue(Game.GetPlayer(), "_SLH_succubusMC")!=1)
			StorageUtil.SetIntValue(Game.GetPlayer(), "Puppet_SpellON", -1)
		EndIf

		StorageUtil.SetIntValue(Game.GetPlayer(), "_SLMC_controlDeviceON", 0)
	EndIf
EndEvent


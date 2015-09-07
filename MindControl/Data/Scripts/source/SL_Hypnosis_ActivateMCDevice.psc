Scriptname SL_Hypnosis_ActivateMCDevice extends ReferenceAlias  

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)

  	; Debug.Notification("[MC] Device equipped: " + (akReference as Actor).GetLeveledActorBase().GetName())


 	 if akBaseObject as Armor
   		; Debug.Notification("This actor just equipped an armor")
  		; Debug.Notification("[MC] Armor enchantment: " + (akBaseObject as Armor).GetEnchantment() )
  		; Debug.Notification("[MC] Looking for " + kMyMindControlEnchantment)

		if ((akBaseObject as Armor).GetEnchantment() == kMyMindControlEnchantment)
			; Debug.Notification("This actor just equipped a Mind Control device")

			; Alias_MCDevice.ForceRefTo(akReference)
		EndIf
	else
		; Debug.Notification("This actor just equipped something")
  	endIf

endEvent

Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
  	; Debug.Notification("[MC] " + akEffect + " detected")

		if ( akEffect == _SLMC_MCEffect )
			; Debug.Notification("[MC] MC effect detected from " + (akCaster as Actor).GetLeveledActorBase().GetName())
			Debug.Notification("This actor just equipped a Mind Control device")

			int slot = 0
			int i
			while i <= 32
			  armor nth = Game.GetPlayer().GetWornForm( math.pow(2.0, i as float) as int ) as armor
			  if nth && nth.GetEnchantment() == kMyMindControlEnchantment
			    ; do stuff
			    ; Alias_MCDevice.ForceRefTo(nth as ObjectReference)
			  endIf
			  i += 1
			endWhile

			; Alias_MCDevice.ForceRefTo(akCaster)
		EndIf
EndEvent

Enchantment Property kMyMindControlEnchantment Auto
ReferenceAlias Property Alias_MCDevice  Auto  

MagicEffect Property _SLMC_MCEffect  Auto  

Scriptname SL_Hypnosis_SetControlDevice extends activemagiceffect  

Quest Property _SLMC_controlQuest  Auto  

ReferenceAlias Property Alias_controlDevice  Auto  
ReferenceAlias Property Alias_victimMC Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Actor akMCDevice= Alias_controlDevice.GetReference() as Actor

  	Debug.Notification("MC: Set effect Caster: " + akCaster.GetLeveledActorBase().GetName() )
 	Debug.Notification("MC: Set effect Target:  " + akTarget.GetLeveledActorBase().GetName())


	if ( akTarget != akMCDevice)
  		Debug.MessageBox("The object is now infused with Mind Control power.")
		; Alias_controlDevice.ForceRefTo(akCaster)
		; Alias_victimMC.Clear()
	EndIf
endEvent
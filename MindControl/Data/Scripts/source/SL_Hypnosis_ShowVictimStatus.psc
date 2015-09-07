Scriptname SL_Hypnosis_ShowVictimStatus extends activemagiceffect  

Quest Property _SLMC_controlQuest  Auto  

 
ReferenceAlias Property Alias_victimMC Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
 

  	Debug.Notification("Magic effect was received: " + akTarget)

 
endEvent
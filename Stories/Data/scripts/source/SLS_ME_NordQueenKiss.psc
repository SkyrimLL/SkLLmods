Scriptname SLS_ME_NordQueenKiss extends activemagiceffect  

Event OnEffectStart(Actor Target, Actor Caster)
	ActorBase aBase = Target.GetBaseObject() as ActorBase
	Race aRace = aBase.GetRace()

	if (aRace == DraugrRace)
		NordQueenFollowerRef.Forcerefto( Target )
	endif
EndEvent

ReferenceAlias Property NordQueenFollowerRef  Auto  
Race Property DraugrRace Auto

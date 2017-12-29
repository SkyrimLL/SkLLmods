Scriptname SLS_ME_NordQueenKingSlayer extends activemagiceffect  

Event OnEffectStart(Actor Target, Actor Caster)
	ActorBase aBase = Target.GetBaseObject() as ActorBase
	Race aRace = aBase.GetRace()

	Debug.Notification("[SLS] King Slayer - Set target essential status off")
	Target.GetActorBase().SetEssential(false)
EndEvent
Scriptname SLH_ME_Undress extends activemagiceffect  

SexLabFramework Property SexLab  Auto  

Event OnEffectStart(Actor akTarget, Actor akCaster)
    Actor kPlayer = Game.GetPlayer()

	If  (SexLab.ValidateActor(kPlayer) > 0) 
		Debug.Notification( "You peel off your clothes excitedly..." )

		SexLab.ActorLib.StripActor(kPlayer, DoAnimate= false)
	EndIf

EndEvent
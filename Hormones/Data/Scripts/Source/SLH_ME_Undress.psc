Scriptname SLH_ME_Undress extends ActiveMagicEffect

SexLabFramework Property SexLab Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If (SexLab.ValidateActor(SexLab.PlayerRef) > 0)
		Debug.Notification("You peel off your clothes excitedly...")
		SexLab.ActorLib.StripActor(SexLab.PlayerRef, DoAnimate= false)
	EndIf
EndEvent

Scriptname SLH_ME_Masturbation extends activemagiceffect  

SexLabFramework Property SexLab  Auto  

Event OnEffectStart(Actor akTarget, Actor akCaster)

	; Game.FadeOutGame(true, true, 0.1, 15)
	; Console("sexchange")
	; Game.FadeOutGame(false, true, 0.01, 10)
	; Return

	; Debug.Notification("PSQ integration - " + StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_SpellON"))
	; StorageUtil.SetIntValue(Game.GetPlayer(), "PSQ_SpellON", 1)

	If  (SexLab.ValidateActor( SexLab.PlayerRef) > 0) 
		Debug.Notification( "You can't hold back any longer..." )
		Actor akActor = SexLab.PlayerRef as Actor
		sslThreadModel Thread = SexLab.NewThread()
		Thread.AddActor(akActor) ; // IsVictim = true

		If (akActor.GetActorBase().getSex() == 1)
			Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F","Estrus,Dwemer"))
		Else
			Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,M","Estrus,Dwemer"))
		EndIf

		Thread.StartThread()
		SexLab.ApplyCum(SexLab.PlayerRef, 1)
	Else
		Debug.Notification( "Not in the mood [SexLab not ready]" )
	EndIf


EndEvent


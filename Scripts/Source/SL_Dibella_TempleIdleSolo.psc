Scriptname SL_Dibella_TempleIdleSolo extends ObjectReference  

SexLabFramework Property SexLab  Auto  

SPELL Property ApplySweatFX  Auto  
ObjectReference Property DibellaTempleBed Auto

GlobalVariable Property AltarGameTime  Auto  
 

Event OnTriggerLeave(ObjectReference akActionRef)
	Int AltarGameTimeValue = AltarGameTime.GetValue() as Int
       Float fCurrentTimeValue = Utility.GetCurrentRealTime()  
       Int iCurrentTimeValue = fCurrentTimeValue  as Int
	Int timeSinceLastBlessing 

	If UI.IsMenuOpen("Console") || UI.IsMenuOpen("Main Menu") || UI.IsMenuOpen("Loading Menu") || UI.IsMenuOpen("MessageBoxMenu")
		return
	EndIf
	
	; 3d will not be loaded in some situations, such as werewolf transformations.
	; Skip body update if 3d not loaded.
	If ( !(akActionRef as Actor).Is3DLoaded() )
		return
	EndIf

 	; compare to previous day count - if difference >0 reduce number of cut counts
	If (AltarGameTimeValue  == 0) 
		AltarGameTimeValue = iCurrentTimeValue ; Game.QueryStat("Days Passed")
		AltarGameTime.SetValue(fCurrentTimeValue )
	EndIf

	timeSinceLastBlessing = (iCurrentTimeValue - AltarGameTimeValue  ) as Int

	; Debug.Notification("Time since last activation: " + timeSinceLastBlessing )


	if (false) && ( (akActionRef != Game.GetPlayer() ) && (timeSinceLastBlessing > 100) )

	;      Debug.Notification("Activated by " + akActionRef)

		if (DibellaTempleBed.IsFurnitureInUse())
		;	Debug.Notification("Bed is being used")

			If  ( (SexLab.ValidateActor(akActionRef as Actor) > 0)  && (Utility.RandomInt(0,100) > 80) )
				AltarGameTime.SetValue(Utility.GetCurrentRealTime())

				Actor akActor = akActionRef as Actor
				
				sslThreadModel Thread = SexLab.NewThread()
				Thread.AddActor(akActor, true) ; // IsVictim = true

				If (akActor.GetActorBase().getSex() == 1)
					Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F","Estrus,Dwemer"))
				Else
					Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,M","Estrus,Dwemer"))
				EndIf

				Thread.StartThread()

			EndIf
		Else

     			(akActionRef as Actor).PathToReference(DibellaTempleBed, 0.5)
	
			If  ( (SexLab.ValidateActor(akActionRef as Actor) > 0)  && (Utility.RandomInt(0,100) > 80) )
				AltarGameTime.SetValue(Utility.GetCurrentRealTime())

				Actor akActor = akActionRef as Actor
				
				sslThreadModel Thread = SexLab.NewThread()
				Thread.AddActor(akActor, true) ; // IsVictim = true

				If (akActor.GetActorBase().getSex() == 1)
					Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F","Estrus,Dwemer"))
				Else
					Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,M","Estrus,Dwemer"))
				EndIf

				Thread.StartThread()

			EndIf

		EndIf

	ElseIf (false) && ( (akActionRef == Game.GetPlayer() )  && (timeSinceLastBlessing > 100) )

			If  (  (SexLab.ValidateActor(akActionRef as Actor) > 0)  && (Utility.RandomInt(0,100) > 80) )
				 Debug.MessageBox("You feel compelled to the altar by Dibella's overwhelming presence..." )
				AltarGameTime.SetValue(Utility.GetCurrentRealTime())
 

				Actor akActor = Game.GetPlayer()
				
				sslThreadModel Thread = SexLab.NewThread()
				Thread.AddActor(akActor, true) ; // IsVictim = true

				If (akActor.GetActorBase().getSex() == 1)
					Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F","Estrus,Dwemer"))
				Else
					Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,M","Estrus,Dwemer"))
				EndIf

				Thread.StartThread()

			EndIf

	EndIf

      ApplySweatFX.RemoteCast(akActionRef, akActionRef as Actor,akActionRef)

EndEvent



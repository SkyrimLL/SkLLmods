Scriptname SLS_QST_RedWaveController extends Quest  


SexLabFramework Property SexLab  Auto  

ReferenceAlias[] Property _SLS_RedWaveFollowerWhoresAliasRef  Auto  
ObjectReference[] Property _SLS_RedWaveFollowerWhores  Auto  

ObjectReference Property _SLS_TempWhore  Auto  


MiscObject Property Gold001  Auto  


Bool Function ReserveFollowerWhore()

	Bool bAdded = False
	Int iIdx = 0
	Int whoreArrayLen = 5

	While ( !bAdded && (iIdx < whoreArrayLen) )
		If ( _SLS_RedWaveFollowerWhores[iIdx] == None )
			bAdded = True
			_SLS_RedWaveFollowerWhores[iIdx] = _SLS_TempWhore 
			; _SLS_RedWaveFollowerWhoresAliasRef[iIdx].ForceRefTo( akObject )

			Debug.Trace("[Red Wave Whore list] Reserving whore: " +  iIdx )
		else
			Debug.Trace("[Red Wave Whore list] Whore sold: " +  _SLS_RedWaveFollowerWhores[iIdx].getName() )

		EndIf
		iIdx += 1
	EndWhile

	if (!bAdded)
			Debug.Trace("[Red Wave Whore list] Reservation not possible (maxed out)"  )
	endif

	Return bAdded

EndFunction

Bool Function AddFollowerWhore( ObjectReference akActorRef )

	Bool bAdded = False
	Int iIdx = 0
	Int whoreArrayLen = 5
	
	While ( !bAdded && (iIdx < whoreArrayLen) )
		If ( _SLS_RedWaveFollowerWhores[iIdx] == _SLS_TempWhore )
			bAdded = True
			_SLS_RedWaveFollowerWhores[iIdx] = akActorRef  
			_SLS_RedWaveFollowerWhoresAliasRef[iIdx].ForceRefTo( akActorRef )

			Debug.Trace("[Red Wave Whore list] Adding actor to queue: " + akActorRef.getName() )
		EndIf
		iIdx += 1
	EndWhile

	if (!bAdded)
			Debug.Trace("[Red Wave Whore list] Impossible to add (maxed out)"  )
	endif

	Return bAdded 
EndFunction

Function RedWaveSex(Actor akActor, Int goldAmount = 10, string sexTags = "Sex", Bool isSolo = False)
	Int randomNum = Utility.RandomInt(0,100)
	Actor PlayerActor = Game.GetPlayer()
	ActorBase PlayerBase = PlayerActor.GetBaseObject() as ActorBase
	Int PlayerGender = PlayerBase.GetSex() ; 0 = Male ; 1 = Female
	Int iRelationshipType = StorageUtil.GetIntValue(akActor, "_SD_iRelationshipType" )
	Int iRelationshipRank = akActor.GetRelationshipRank(PlayerActor)

;		Debug.MessageBox( "The Sister quietly peels off your clothes to reveal your beauty to the world." )
;  		SexLab.ActorLib.StripActor(Game.GetPlayer(), DoAnimate= false)

	If ( iRelationshipType <= 0 ) || (iRelationshipRank<=0)
		PlayerActor.RemoveItem(Gold001, goldAmount)
		akActor.SendModEvent("OnSLDRobPlayer")

	ElseIf ( iRelationshipType <= 1 ) || (iRelationshipRank<=1)
		PlayerActor.RemoveItem(Gold001, goldAmount)
		
	ElseIf ( iRelationshipType <= 3 ) || (iRelationshipRank<=3)
			Debug.Notification("Hey sexy.. I like you a lot."  )
		PlayerActor.RemoveItem(Gold001, goldAmount / 2)
		
	ElseIf ( iRelationshipType >= 4 ) || (iRelationshipRank>=4)
		if (randomNum <= 50)
			Debug.Notification("Anything for you honey..."  )
			PlayerActor.RemoveItem(Gold001, 1)
		else
			Debug.Notification("Hey sweetie.. so nice of you to come back."  )
			PlayerActor.RemoveItem(Gold001, goldAmount / 3)
		endif
		
	Endif

	If  (SexLab.ValidateActor( Game.GetPlayer() ) > 0) &&  (SexLab.ValidateActor(akActor) > 0) 

		If (isSolo)	

			sslThreadModel Thread = SexLab.NewThread()
			Thread.AddActor(akActor,IsVictim = true) ; // IsVictim = true

			If (akActor.GetActorBase().getSex() == 1)
				Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F","Estrus,Dwemer"))
			Else
				Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,M","Estrus,Dwemer"))
			EndIf

			Thread.StartThread()
		Else

			sslThreadModel Thread = SexLab.NewThread()
			Thread.AddActor(akActor, IsVictim = true) ; // IsVictim = true
			Thread.AddActor(PlayerActor) ; // IsVictim = true

			If (PlayerGender  == 1)
				Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "Lesbian" + sexTags))
			Else
				Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "MF" + sexTags))
			EndIf

			Thread.StartThread()

		Endif

	Endif
Endfunction
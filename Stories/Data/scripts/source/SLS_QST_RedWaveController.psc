Scriptname SLS_QST_RedWaveController extends Quest  


SexLabFramework Property SexLab  Auto  

ReferenceAlias[] Property _SLS_RedWaveFollowerWhoresAliasRef  Auto  
ObjectReference[] Property _SLS_RedWaveFollowerWhores  Auto  

ObjectReference Property _SLS_TempWhore  Auto  


MiscObject Property Gold001  Auto  

Function RedWaveStart()
	Actor PlayerActor = Game.GetPlayer()
	; Stop other mods like Deviously Enslaved while in RedWave
	SendModEvent("dhlp-Suspend")
	StorageUtil.SetIntValue(PlayerActor, "_SLS_iStoriesRedWaveJob", 1)
EndFunction

Function RedWaveStop()
	Actor PlayerActor = Game.GetPlayer()
	SendModEvent("dhlp-Resume")
	StorageUtil.SetIntValue(PlayerActor, "_SLS_iStoriesRedWaveJob", -1)
EndFunction

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
	ActorBase akActorBase = akActor.GetBaseObject() as ActorBase
	Int iRelationshipType = StorageUtil.GetIntValue(akActor, "_SD_iRelationshipType", -1)
	Int iRelationshipRank = akActor.GetRelationshipRank(PlayerActor)
	Int PlayerGender = PlayerBase.GetSex() ; 0 = Male ; 1 = Female

	Int ActorGender = akActorBase.GetSex() ; 0 = Male ; 1 = Female

;		Debug.MessageBox( "The Sister quietly peels off your clothes to reveal your beauty to the world." )
;  		SexLab.ActorLib.StripActor(Game.GetPlayer(), DoAnimate= false)

	If ( iRelationshipType >= 4 ) || (iRelationshipRank >= 4)
		if (randomNum <= 50)
			Debug.Notification("Anything for you honey..."  )
			PlayerActor.RemoveItem(Gold001, 1, akActor)
		else
			Debug.Notification("Hey sweetie.. so nice of you to come back."  )
			PlayerActor.RemoveItem(Gold001, goldAmount / 3)
		endif
		
	ElseIf ( iRelationshipType >= 2 ) || (iRelationshipRank >= 2)
		Debug.Notification("Hey sexy.. I like you a lot."  )
		PlayerActor.RemoveItem(Gold001, goldAmount / 2)
		
	ElseIf ( iRelationshipType == 1 ) || (iRelationshipRank == 1)
		PlayerActor.RemoveItem(Gold001, goldAmount)
		
	ElseIf ( iRelationshipType == 0 ) || (iRelationshipRank <= 0)
		PlayerActor.RemoveItem(Gold001, goldAmount)
		akActor.SendModEvent("OnSLDRobPlayer")

	Endif

	If  (SexLab.ValidateActor(PlayerActor) > 0) &&  (SexLab.ValidateActor(akActor) > 0) 

		sslThreadModel Thread = SexLab.NewThread()
		If (isSolo)	
			Thread.AddActor(akActor)
			If (ActorGender == 1)
				Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F,Sex","Estrus,Dwemer"))
			Else
				Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,M,Sex","Estrus,Dwemer"))
			EndIf
		Else
			If (PlayerGender == 1 && ActorGender == 1)
				Thread.AddActor(akActor)
				Thread.AddActor(PlayerActor)
				Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "Lesbian," + sexTags))
			elseIf (PlayerGender == 0 && ActorGender == 0)
				Thread.AddActor(akActor)
				Thread.AddActor(PlayerActor)
				Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "MM," + sexTags))
			else
				If PlayerGender == 1
					Thread.AddActor(PlayerActor)
					Thread.AddActor(akActor)
				else
					Thread.AddActor(akActor)
					Thread.AddActor(PlayerActor)
				endIf
				Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "MF," + sexTags))
			endIf
		Endif
		
		Thread.StartThread()

	Endif
Endfunction


float Function RedWavePlayerSex(Actor akActor, Int goldAmount = 10, string sexTags = "Sex", Bool isSolo = False)
	Int randomNum = Utility.RandomInt(0,100)
	Actor PlayerActor = Game.GetPlayer()
	ActorBase akActorBase = akActor.GetBaseObject() as ActorBase
	ActorBase PlayerBase = PlayerActor.GetBaseObject() as ActorBase
	Int iRelationshipType = StorageUtil.GetIntValue(akActor, "_SD_iRelationshipType" , -1)
	Int iRelationshipRank = akActor.GetRelationshipRank(PlayerActor)
	float Earnings = 0 
	Int PlayerGender = PlayerBase.GetSex() ; 0 = Male ; 1 = Female
	
	Int ActorGender = akActorBase.GetSex() ; 0 = Male ; 1 = Female

;		Debug.MessageBox( "The Sister quietly peels off your clothes to reveal your beauty to the world." )
;  		SexLab.ActorLib.StripActor(Game.GetPlayer(), DoAnimate= false)

	If ( iRelationshipType >= 4 ) || (iRelationshipRank >= 4)
		if (randomNum <= 50)
			Debug.Notification("Anything for you honey..."  )
			PlayerActor.AddItem(Gold001, 1)
		else
			Debug.Notification("Hey sweetie.. so nice of you to come back."  )
			PlayerActor.AddItem(Gold001, goldAmount / 3)
			Earnings = goldAmount / 3
		endif
		
	ElseIf ( iRelationshipType >= 2 ) || (iRelationshipRank >= 2)
		Debug.Notification("Hey sexy.. I like you a lot."  )
		PlayerActor.AddItem(Gold001, goldAmount / 2)
		Earnings = goldAmount / 2
	ElseIf ( iRelationshipType == 1 ) || (iRelationshipRank == 1)
		PlayerActor.AddItem(Gold001, goldAmount)
		Earnings = goldAmount
	ElseIf ( iRelationshipType == 0 ) || (iRelationshipRank <= 0)
		PlayerActor.AddItem(Gold001, goldAmount)
		Earnings = goldAmount
	Endif


	If  (SexLab.ValidateActor(PlayerActor) > 0) &&  (SexLab.ValidateActor(akActor) > 0) 

		sslThreadModel Thread = SexLab.NewThread()
		If (isSolo)	
			Thread.AddActor(akActor)
			If (ActorGender == 1)
				Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F,Sex","Estrus,Dwemer"))
			Else
				Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,M,Sex","Estrus,Dwemer"))
			EndIf
		Else
			If (PlayerGender == 1 && ActorGender == 1)
				Thread.AddActor(PlayerActor)
				Thread.AddActor(akActor)
				Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "Lesbian," + sexTags))
			elseIf (PlayerGender == 0 && ActorGender == 0)
				Thread.AddActor(PlayerActor)
				Thread.AddActor(akActor)
				Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "MM," + sexTags))
			else
				If PlayerGender == 1
					Thread.AddActor(PlayerActor)
					Thread.AddActor(akActor)
				else
					Thread.AddActor(akActor)
					Thread.AddActor(PlayerActor)
				endIf
				Thread.SetAnimations(SexLab.GetAnimationsByTags(2, "MF," + sexTags))
			endIf
		Endif
		Thread.StartThread()
	Endif
	return Earnings
Endfunction
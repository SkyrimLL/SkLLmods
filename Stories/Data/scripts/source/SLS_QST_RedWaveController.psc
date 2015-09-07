Scriptname SLS_QST_RedWaveController extends Quest  

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


ReferenceAlias[] Property _SLS_RedWaveFollowerWhoresAliasRef  Auto  
ObjectReference[] Property _SLS_RedWaveFollowerWhores  Auto  

ObjectReference Property _SLS_TempWhore  Auto  
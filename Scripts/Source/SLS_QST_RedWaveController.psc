Scriptname SLS_QST_RedWaveController extends Quest  

Function ReserveFollowerWhore()

	Bool bAdded = False
	Int iIdx = 0

	While ( !bAdded && iIdx < _SLS_RedWaveFollowerWhores.Length )
		If ( _SLS_RedWaveFollowerWhores[iIdx] == None )
			bAdded = True
			_SLS_RedWaveFollowerWhores[iIdx] = _SLS_TempWhore 
			; _SLS_RedWaveFollowerWhoresAliasRef[iIdx].ForceRefTo( akObject )

			Debug.Notification("[Red Wave Whore list] Reserving whore: " +  iIdx )
		EndIf
		iIdx += 1
	EndWhile

	if (!bAdded)
			Debug.Notification("[Red Wave Whore list] Reservation not possible (maxed out)"  )
	endif

EndFunction

Bool Function AddFollowerWhore( ObjectReference akActorRef )

	Bool bAdded = False
	Int iIdx = 0

	While ( !bAdded && iIdx < _SLS_RedWaveFollowerWhores.Length )
		If ( _SLS_RedWaveFollowerWhores[iIdx] == _SLS_TempWhore )
			bAdded = True
			_SLS_RedWaveFollowerWhores[iIdx] = akActorRef  
			_SLS_RedWaveFollowerWhoresAliasRef[iIdx].ForceRefTo( akActorRef )

			Debug.Notification("[Red Wave Whore list] Adding actor to queue: " + akActorRef )
		EndIf
		iIdx += 1
	EndWhile

	if (!bAdded)
			Debug.Notification("[Red Wave Whore list] Impossible to add (maxed out)"  )
	endif

	Return bAdded 
EndFunction


ReferenceAlias[] Property _SLS_RedWaveFollowerWhoresAliasRef  Auto  
ObjectReference[] Property _SLS_RedWaveFollowerWhores  Auto  

ObjectReference Property _SLS_TempWhore  Auto  
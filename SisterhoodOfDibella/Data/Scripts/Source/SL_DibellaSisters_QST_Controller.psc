Scriptname SL_DibellaSisters_QST_Controller extends ReferenceAlias  

ReferenceAlias Property PlayerAlias  Auto  


Event OnPlayerLoadGame()
	_maintenance()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	; Only runs going in or out of Markarth Temple
	If ((akNewLoc != TempleLocation) && (akOldLoc == TempleLocation))
		Return
	Endif



	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()
	Int iTempleCorruption = StorageUtil.GetIntValue( akActor, "_SLSD_iDibellaTempleCorruption")
	Int iSybilLevel = StorageUtil.GetIntValue( akActor, "_SLSD_iDibellaSybilLevel" )

	; Check if new location is Temple or Inner Sanctum
	; Check value of temple corruption from StorageUtil
	; Set outfits accordingly

	If ((akNewLoc == TempleLocation) || (akOldLoc == TempleLocation))  && (iSybilLevel < 5)
		Debug.Trace("[SLSD] Temple corruption: " + iTempleCorruption )
		; Debug.Notification("[SLSD] Temple corruption: " + iTempleCorruption )
		Debug.Trace("[SLSD] Sybil Level: " + iSybilLevel )
		; Debug.Notification("[SLSD] SennaRef: " + SennaRef)
		; Debug.Notification("[SLSD] OrlaRef: " + OrlaRef)
		; Debug.Notification("[SLSD] AnwenRef: " + AnwenRef)
		; Debug.Notification("[SLSD] HamalRef: " + HamalRef)
		; Debug.Notification("[SLSD] SybilRef: " + SybilRef)

		If (iTempleCorruption == 0)
			(SennaRef as Actor).SetOutfit(SisterPureOutfit)
			_corruptNPCShape(SennaRef as Actor, 1.0)

			(OrlaRef as Actor).SetOutfit(SisterPureOutfit)
			_corruptNPCShape(SennaRef as Actor, 1.0)

			(AnwenRef as Actor).SetOutfit(SisterPureOutfit)
			_corruptNPCShape(SennaRef as Actor, 1.0)

			(HamalRef as Actor).SetOutfit(HamalPureOutfit)
			_corruptNPCShape(SennaRef as Actor, 1.5)

			(SybilRef as Actor).SetOutfit(FjotraPureOutfit)

		ElseIf (iTempleCorruption >= 1) && (iTempleCorruption <= 4)
			(SennaRef as Actor).SetOutfit(SisterPureOutfit)
			_corruptNPCShape(SennaRef as Actor, 1.5)

			(OrlaRef as Actor).SetOutfit(SisterCorruptedOutfit)
			_corruptNPCShape(OrlaRef as Actor, 1.5)

			(AnwenRef as Actor).SetOutfit(SisterCorruptedOutfit)
			_corruptNPCShape(AnwenRef as Actor, 1.5)

			(HamalRef as Actor).SetOutfit(HamalCorruptedOutfit)
			_corruptNPCShape(HamalRef as Actor, 2.5)


			If (SybilRef != None) 
				If (iSybilLevel == 1) 
					(SybilRef as Actor).SetOutfit(FjotraNoviceOutfit)
					; Debug.Notification("[SLSD] Fjotra is a Novice")
					_corruptNPCShape(SybilRef as Actor, 1.0)

				ElseIf (iSybilLevel == 2)
					(SybilRef as Actor).SetOutfit(FjotraAccolyteOutfit)
					; Debug.Notification("[SLSD] Fjotra is a Accolyte")
					_corruptNPCShape(SybilRef as Actor, 1.3)
					
				ElseIf (iSybilLevel == 3)
					(SybilRef as Actor).SetOutfit(FjotraInitiateOutfit)
					; Debug.Notification("[SLSD] Fjotra is a Initiate")
					_corruptNPCShape(SybilRef as Actor, 1.6)
					
				ElseIf (iSybilLevel >= 4)
					(SybilRef as Actor).SetOutfit(FjotraCorruptedOutfit)
					; Debug.Notification("[SLSD] Fjotra is a Mother")
					_corruptNPCShape(SybilRef as Actor, 2.5)
					
				EndIf
			EndIf

		ElseIf (iTempleCorruption > 4)
			(SennaRef as Actor).SetOutfit(SisterCorruptedOutfit)
			_corruptNPCShape(SennaRef as Actor, 2.0)

			(OrlaRef as Actor).SetOutfit(SisterCorruptedOutfit)
			_corruptNPCShape(OrlaRef as Actor, 2.0)

			(AnwenRef as Actor).SetOutfit(SisterCorruptedOutfit)
			_corruptNPCShape(AnwenRef as Actor, 2.0)

			(HamalRef as Actor).SetOutfit(HamalCorruptedOutfit)
			_corruptNPCShape(HamalRef as Actor, 3.0)

			(SybilRef as Actor).SetOutfit(FjotraCorruptedOutfit)
			_corruptNPCShape(SybilRef as Actor, 2.5)

		EndIf
	EndIf

EndEvent

Function _corruptNPCShape(Actor kActor, Float fBreast)

	If (StorageUtil.GetIntValue(none, "_SLH_iHormones")!=1)  

		kActor.SendModEvent("SLHSetNiNode","Breast", fBreast )      
		kActor.SendModEvent("SLHRefresh")
			
	endif

EndFunction

Function _Maintenance()
;
	Int iTempleCorruption = StorageUtil.GetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption")

	RegisterForModEvent("SLSDEquipOutfit",   "OnSLSDEquipOutfit")

	If (iTempleCorruption <= 2)
 		_SLS_SisterClothingDresserPurified.Enable()
 		_SLS_SisterClothingDresserCorrupted.Disable()

	ElseIf  (iTempleCorruption >=3)
 		_SLS_SisterClothingDresserPurified.Disable()
 		_SLS_SisterClothingDresserCorrupted.Enable()
	Endif
EndFunction



Event OnSLSDEquipOutfit(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
	String sOutfit = _args

	Debug.Trace("[SL_DibellaSisters_QST_controller] Receiving equip outfit story event [" + _args  + "] [" + _argc as Int + "]")

	if (sOutfit == "SisterPure")
		kActor.SetOutfit(SisterPureOutfit)

	elseif (sOutfit == "SisterCorrupted")
		kActor.SetOutfit(SisterCorruptedOutfit)

	elseif (sOutfit == "HamalPure")
		kActor.SetOutfit(HamalPureOutfit)

	elseif (sOutfit == "HamalCorrupted")
		kActor.SetOutfit(HamalCorruptedOutfit)

	elseif (sOutfit == "FjotraPure")
		kActor.SetOutfit(FjotraPureOutfit)

	elseif (sOutfit == "FjotraNovice")
		kActor.SetOutfit(FjotraNoviceOutfit )

	elseif (sOutfit == "FjotraAccolyte")
		kActor.SetOutfit(FjotraAccolyteOutfit)

	elseif (sOutfit == "FjotraInitiate")
		kActor.SetOutfit(FjotraInitiateOutfit)

	elseif (sOutfit == "FjotraCorrupted")
		kActor.SetOutfit(FjotraCorruptedOutfit)
		
	elseif (sOutfit == "TravelingSister")
		kActor.SetOutfit(TravelingSisterOutfit  )
		
	else
		Debug.Trace("[SL_DibellaSisters_QST_controller] Unknow outfit [" + sOutfit  + "]")
	Endif
EndEvent

ObjectReference Property SennaRef Auto
ObjectReference Property OrlaRef Auto
ObjectReference Property AnwenRef Auto
ObjectReference Property HamalRef Auto
; ObjectReference Property FjotraRef Auto
ObjectReference Property SybilRef Auto

Outfit Property SisterPureOutfit Auto
Outfit Property SisterCorruptedOutfit Auto
Outfit Property HamalPureOutfit Auto
Outfit Property HamalCorruptedOutfit Auto
Outfit Property FjotraPureOutfit Auto
Outfit Property FjotraCorruptedOutfit Auto

Outfit Property FjotraNoviceOutfit Auto
Outfit Property FjotraAccolyteOutfit Auto
Outfit Property FjotraInitiateOutfit Auto

Location Property TempleLocation Auto



Outfit Property TravelingSisterOutfit  Auto  

ObjectReference Property _SLS_SisterClothingDresserPurified  Auto  

ObjectReference Property _SLS_SisterClothingDresserCorrupted  Auto  

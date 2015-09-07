Scriptname SL_DibellaSisters_QST_Controller extends ReferenceAlias  

ReferenceAlias Property PlayerAlias  Auto  


Event OnPlayerLoadGame()
	_maintenance()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()
	Int iTempleCorruption = StorageUtil.GetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption")
	Int iSybilLevel = StorageUtil.GetIntValue( Game.GetPlayer(), "_SLSD_iDibellaSybilLevel" )

	; Check if new location is Temple or Inner Sanctum
	; Check value of temple corruption from StorageUtil
	; Set outfits accordingly

	If (akNewLoc == TempleLocation) || (akOldLoc == TempleLocation)
		; Debug.Notification("[SLSD] Temple corruption: " + iTempleCorruption )
		; Debug.Notification("[SLSD] Sybil Level: " + iSybilLevel )
		; Debug.Notification("[SLSD] SennaRef: " + SennaRef)
		; Debug.Notification("[SLSD] OrlaRef: " + OrlaRef)
		; Debug.Notification("[SLSD] AnwenRef: " + AnwenRef)
		; Debug.Notification("[SLSD] HamalRef: " + HamalRef)
		; Debug.Notification("[SLSD] SybilRef: " + SybilRef)

		If (iTempleCorruption == 0)
			(SennaRef as Actor).SetOutfit(SisterPureOutfit)
			(OrlaRef as Actor).SetOutfit(SisterPureOutfit)
			(AnwenRef as Actor).SetOutfit(SisterPureOutfit)
			(HamalRef as Actor).SetOutfit(HamalPureOutfit)
			(SybilRef as Actor).SetOutfit(FjotraPureOutfit)

		ElseIf (iTempleCorruption >= 1) && (iTempleCorruption < 4)
			(SennaRef as Actor).SetOutfit(SisterPureOutfit)
			(OrlaRef as Actor).SetOutfit(SisterCorruptedOutfit)
			(AnwenRef as Actor).SetOutfit(SisterCorruptedOutfit)
			(HamalRef as Actor).SetOutfit(HamalCorruptedOutfit)

			If (SybilRef != None) 
				If (iSybilLevel == 1) || (iSybilLevel == 2)
					(SybilRef as Actor).SetOutfit(FjotraNoviceOutfit)
					; Debug.Notification("[SLSD] Fjotra is a Novice")

				ElseIf (iSybilLevel == 3) || (iSybilLevel == 4)
					(SybilRef as Actor).SetOutfit(FjotraAccolyteOutfit)
					; Debug.Notification("[SLSD] Fjotra is a Accolyte")
					
				ElseIf (iSybilLevel == 5)
					(SybilRef as Actor).SetOutfit(FjotraInitiateOutfit)
					; Debug.Notification("[SLSD] Fjotra is a Initiate")
					
				ElseIf (iSybilLevel == 6)
					(SybilRef as Actor).SetOutfit(FjotraCorruptedOutfit)
					; Debug.Notification("[SLSD] Fjotra is a Mother")
					
				EndIf
			EndIf

		ElseIf (iTempleCorruption >= 4)
			(SennaRef as Actor).SetOutfit(SisterCorruptedOutfit)
			(OrlaRef as Actor).SetOutfit(SisterCorruptedOutfit)
			(AnwenRef as Actor).SetOutfit(SisterCorruptedOutfit)
			(HamalRef as Actor).SetOutfit(HamalCorruptedOutfit)
			(SybilRef as Actor).SetOutfit(FjotraCorruptedOutfit)
		EndIf
	EndIf

EndEvent

Function _Maintenance()
;

EndFunction

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



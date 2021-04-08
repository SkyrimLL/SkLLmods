Scriptname bpwMatchCardScript extends ObjectReference  

;each of the possible cards faces when flipped
OBJECTREFERENCE PROPERTY HeartsA AUTO
OBJECTREFERENCE PROPERTY HeartsB AUTO
OBJECTREFERENCE PROPERTY ClubsA AUTO
OBJECTREFERENCE PROPERTY ClubsB AUTO
OBJECTREFERENCE PROPERTY SpadesA AUTO
OBJECTREFERENCE PROPERTY SpadesB AUTO
OBJECTREFERENCE PROPERTY DiamondsA AUTO
OBJECTREFERENCE PROPERTY DiamondsB AUTO
OBJECTREFERENCE PROPERTY SheoA AUTO
OBJECTREFERENCE PROPERTY SheoB AUTO

BOOL PROPERTY HEARTS AUTO     ; Trophies
BOOL PROPERTY CLUBS AUTO      ; Grummites
BOOL PROPERTY SPADES AUTO     ; Skeevers
BOOL PROPERTY DIAMONDS AUTO   ; Knights
BOOL PROPERTY SHEO AUTO       ; Wabbajack

;the script keeping track
OBJECTREFERENCE PROPERTY controllerScript AUTO

;the master script
bwpMatchCardMasterSCRIPT mainScript

;the door
OBJECTREFERENCE PROPERTY portDoor AUTO
OBJECTREFERENCE PROPERTY skeevDoor AUTO

ObjectReference Property  SheoBoxCards Auto  


Quest Property _SLSDDi_QST_DivineCheese Auto

 EVENT onLoad()
	
	mainScript = controllerScript as bwpMatchCardMasterSCRIPT
			 
 ENDEVENT

EVENT onACTIVATE(objectReference obj)

	IF(obj as ACTOR == game.getPlayer())
		ObjectReference CurrentCard = self
		ObjectReference LastCard = StorageUtil.GetFormValue(none, "_SLSDDi_fSheoLastCard") as ObjectReference

		
		if (_SLSDDi_QST_DivineCheese.GetStageDone(520)==0)
			debug.messageBox("The card is so heavy! You can't pull it off the table.")
			return
		Endif

		if (CurrentCard == LastCard)
			debug.messageBox("Picking the same card twice is cheating!")
			return
		Endif

		; //////////////////////
		; If it's a Hearts card
		IF(HEARTS)
			
			IF(mainScript.flippedCard == 0)
				mainScript.flippedCard = 2
				debug.messageBox("I *HEART* my trophies")
			
			ELSEIF(mainScript.flippedCard == 2)
				LastCard.PlaceAtMe(Game.GetForm(0x0003AD5B))
				CurrentCard.PlaceAtMe(Game.GetForm(0x0003AD5B))
				LastCard.MoveTo(SheoBoxCards)
				CurrentCard.MoveTo(SheoBoxCards)
				StorageUtil.SetIntValue(none, "_SLSDDi_fSheoHeartsCard", 1)
 
				debug.messageBox("Match!")
				mainScript.flippedCard = 0

				_SLSDDi_QST_DivineCheese.SetStage(521)
							
			ELSE
				mainScript.flippedCard = 0
				debug.messageBox("Boo!")
				SendModEvent("_SLSDDi_TriggerCard","Random")
			
			ENDIF
		
		; /////////////////////
		; If it's a clubs card
		ELSEIF(CLUBS)
			
			IF(mainScript.flippedCard == 0)
				mainScript.flippedCard = 4
				debug.messageBox("Slimy things. CLUB them!")
			
			ELSEIF(mainScript.flippedCard == 4)
				LastCard.PlaceAtMe(Game.GetForm(0x0007e8b7))
				CurrentCard.PlaceAtMe(Game.GetForm(0x0007e8b7)) 
				LastCard.MoveTo(SheoBoxCards)
				CurrentCard.MoveTo(SheoBoxCards)
				StorageUtil.SetIntValue(none, "_SLSDDi_fSheoClubsCard", 1)

				debug.messageBox("Match!")
				mainScript.flippedCard = 0

				_SLSDDi_QST_DivineCheese.SetStage(522)
			
			ELSE
				mainScript.flippedCard = 0
				debug.messageBox("Boo!")
				SendModEvent("_SLSDDi_TriggerCard","Random")
			
			ENDIF
		
		; //////////////////////
		; If it's a spades card
		ELSEIF(SPADES)
			
			IF(mainScript.flippedCard == 0)
				mainScript.flippedCard = 1
				debug.messageBox("Ghastly critters. They come here in SPADES.")
			
			ELSEIF(mainScript.flippedCard == 1)
				LastCard.PlaceAtMe(Game.GetForm(0x0003ad6f))
				CurrentCard.PlaceAtMe(Game.GetForm(0x0003ad6f)) 
				LastCard.MoveTo(SheoBoxCards)
				CurrentCard.MoveTo(SheoBoxCards)
				StorageUtil.SetIntValue(none, "_SLSDDi_fSheoSpadesCard", 1)

				debug.messageBox("Match!")
				mainScript.flippedCard = 0

				_SLSDDi_QST_DivineCheese.SetStage(523)
			
			ELSE
				mainScript.flippedCard = 0
				debug.messageBox("Boo!")
				SendModEvent("_SLSDDi_TriggerCard","Random")
			
			ENDIF
		
		; ////////////////////////
		; If it's a diamonds card
		ELSEIF(DIAMONDS)
			
			IF(mainScript.flippedCard == 0)
				mainScript.flippedCard = 3
				debug.messageBox("Shiny toys! like DIAMONDS.")
			
			ELSEIF(mainScript.flippedCard == 3)
				LastCard.PlaceAtMe(Game.GetForm(0x00063b47))
				CurrentCard.PlaceAtMe(Game.GetForm(0x00063b47)) 
				LastCard.MoveTo(SheoBoxCards)
				CurrentCard.MoveTo(SheoBoxCards)
				StorageUtil.SetIntValue(none, "_SLSDDi_fSheoDiamondsCard", 1)

				debug.messageBox("Match!")
				mainScript.flippedCard = 0

				_SLSDDi_QST_DivineCheese.SetStage(524)
			
			ELSE
				mainScript.flippedCard = 0
				debug.messageBox("Boo!")
				SendModEvent("_SLSDDi_TriggerCard","Random")
			
			ENDIF
		
		; ////////////////////
		; If it's a sheo card
		ELSEIF(SHEO)
			IF(mainScript.flippedCard == 0)
				mainScript.flippedCard = 5
				debug.messageBox("Who knows?")
			
			ELSEIF(mainScript.flippedCard == 5)
				; SheoA.disable()
				; SheoB.disable()
				StorageUtil.SetIntValue(none, "_SLSDDi_fSheoWabbaCard", 1)

				debug.messageBox("Match!")
				mainScript.flippedCard = 0

				_SLSDDi_QST_DivineCheese.SetStage(525)
			
			ELSE
				mainScript.flippedCard = 0
				debug.messageBox("Boo!")
				SendModEvent("_SLSDDi_TriggerCard","Random")
			
			ENDIF
		
		ELSE
			; debug.messageBox("we haven't been set!")
		ENDIF
	
		;puzzle is complete, open the door
		IF (StorageUtil.GetIntValue(none, "_SLSDDi_fSheoHeartsCard")==1) && (StorageUtil.GetIntValue(none, "_SLSDDi_fSheoClubsCard")==1) && (StorageUtil.GetIntValue(none, "_SLSDDi_fSheoSpadesCard")==1) && (StorageUtil.GetIntValue(none, "_SLSDDi_fSheoDiamondsCard")==1) && (StorageUtil.GetIntValue(none, "_SLSDDi_fSheoWabbaCard")==1)
			; portDoor.activate(controllerScript)
			; skeevDoor.activate(controllerScript)

			; debug.messageBox("Card game complete!")
			if (!(_SLSDDi_QST_DivineCheese.IsStageDone(526)))
				_SLSDDi_QST_DivineCheese.SetStage(526)
			endif
		ENDIF
	
		StorageUtil.SetFormValue(none, "_SLSDDi_fSheoLastCard", self as Form)


	ENDIF


ENDEVENT 

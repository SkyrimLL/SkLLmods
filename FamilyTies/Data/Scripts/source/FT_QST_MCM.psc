Scriptname FT_QST_MCM extends SKI_ConfigBase  

; PRIVATE VARIABLES -------------------------------------------------------------------------------

; base age, start, stop, pause, days till next birthday

; State
int  		baseAge
int 		yearsCount
int 		playerAge

bool 		_startAging = false
bool 		_pauseAging = false
bool 		_resetRace = false

float		_baseAge = 18.0
float		_anniversaryFrequency = 364.0
float		_agingFrequency = 364.0

Actor kPlayer

; INITIALIZATION ----------------------------------------------------------------------------------

; @overrides SKI_ConfigBase
event OnConfigInit()
	Pages = new string[2]
	Pages[0] = "FamilyTies"
	Pages[1] = "Quests"

endEvent

; @implements SKI_QuestBase
event OnVersionUpdate(int a_version)
	{Called when a version update of this script has been detected}

	; Version 2 specific updating code
	if (a_version >= 2 && CurrentVersion < 2)
	;	Debug.Trace(self + ": Updating script to version 2")
	;	_color = Utility.RandomInt(0x000000, 0xFFFFFF) ; Set a random color
	endIf

	; Version 3 specific updating code
	if (a_version >= 3 && CurrentVersion < 3)
	;	Debug.Trace(self + ": Updating script to version 3")
	;	_myKey = Input.GetMappedKey("Jump")
	endIf
endEvent


; EVENTS ------------------------------------------------------------------------------------------

; @implements SKI_ConfigBase
event OnPageReset(string a_page)
	{Called when a new page is selected, including the initial empty page}
	Int playerAgeDays

	; Load custom logo in DDS format
	if (a_page == "")
		; Image size 512x512
		; X offset = 376 - (height / 2) = 120
		; Y offset = 223 - (width / 2) = 0
		LoadCustomContent("FamilyTies/logo.dds", 120, 0)
		return
	else
		UnloadCustomContent()
	endIf

	kPlayer = Game.GetPlayer()
	; ObjectReference PlayerREF= PlayerAlias.GetReference()
	; Actor PlayerActor= PlayerAlias.GetReference() as Actor
	; ActorBase pActorBase = PlayerActor.GetActorBase()


	If (StorageUtil.GetIntValue(none, "_FT_initMCM" )!=1)
		StorageUtil.SetIntValue(none, "_FT_initMCM", 1 )
	EndIf

	StorageUtil.SetIntValue(none, "_FT_versionMCM", 20190319 )

	_baseAge = StorageUtil.GetFloatValue(kPlayer, "_FT_baseAge" )
	_anniversaryFrequency = StorageUtil.GetFloatValue(kPlayer, "_FT_anniversaryFrequency" ) 

	If (StorageUtil.GetFloatValue(kPlayer, "_FT_agingFrequency" )==0)
		StorageUtil.SetFloatValue(kPlayer, "_FT_agingFrequency",_anniversaryFrequency )
	Endif	
	_agingFrequency = StorageUtil.GetFloatValue(kPlayer, "_FT_agingFrequency" ) 



	_startAging = StorageUtil.GetIntValue(none, "_FT_startAging" )
 	_pauseAging = StorageUtil.GetIntValue(none, "_FT_pauseAging" )
 	_resetRace = false ; StorageUtil.GetIntValue(none, "_FT_resetRace" )

 	playerAgeDays = (_agingFrequency as Int) - (StorageUtil.GetIntValue(kPlayer, "_FT_iPlayerDaysCount") as Int)

	baseAge = StorageUtil.GetFloatValue(kPlayer, "_FT_baseAge" ) as Int
	yearsCount = StorageUtil.GetIntValue(kPlayer, "_FT_iPlayerYearsCount") as Int
	playerAge = baseAge + yearsCount

	If (a_page == "FamilyTies")

		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption(" Player age : " + 	playerAge )
		AddHeaderOption(" Days count : " + StorageUtil.GetIntValue(kPlayer, "_FT_iPlayerDaysCount" ) )
		AddHeaderOption(" Years count : " + StorageUtil.GetIntValue(kPlayer, "_FT_iPlayerYearsCount") )
		AddHeaderOption(" Days to birthday : " + playerAgeDays as Int )
		AddSliderOptionST("STATE_BASE_AGE","Base age", _baseAge,"{0}")
		AddSliderOptionST("STATE_ANNIV_FREQ","Anniversary frequency", _anniversaryFrequency,"{0}")
		AddSliderOptionST("STATE_AGING_FREQ","Aging frequency", _agingFrequency,"{0}")

		SetCursorPosition(1)
		AddToggleOptionST("STATE_AGING_TOGGLE","Start/Stop aging", _startAging as Float)
		AddToggleOptionST("STATE_AGING_PAUSE","Pause aging", _pauseAging as Float)
		AddToggleOptionST("STATE_RACE_RESET","Reset Race", _resetRace as Float)
	

	ElseIf (a_page == "Quests")
		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption(" Placeholder - No option yet")


	endIf
endEvent


; AddSliderOptionST("STATE_BASE_AGE","Base age", _baseAge,"{0}")
state STATE_BASE_AGE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_FT_baseAge" ) )
		SetSliderDialogDefaultValue( 18.0 )
		SetSliderDialogRange( 16.0, 80.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_FT_baseAge", thisValue )

		baseAge = StorageUtil.GetFloatValue(kPlayer, "_FT_baseAge" ) as Int
		yearsCount = StorageUtil.GetIntValue(kPlayer, "_FT_iPlayerYearsCount") as Int
		playerAge = baseAge + yearsCount

		SetSliderOptionValueST( thisValue,"{1}" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_FT_baseAge", 18.0 )

		baseAge = StorageUtil.GetFloatValue(kPlayer, "_FT_baseAge" ) as Int
		yearsCount = StorageUtil.GetIntValue(kPlayer, "_FT_iPlayerYearsCount") as Int
		playerAge = baseAge + yearsCount

		SetSliderOptionValueST( 18.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Player age at start of the game (in years)")
	endEvent
endState

; AddSliderOptionST("STATE_ANNIV_FREQ","Anniverasy frequency", _anniversaryFrequency,"{0}")
state STATE_ANNIV_FREQ ; SLIDER
	event OnSliderOpenST()
		_agingFrequency = StorageUtil.GetFloatValue(kPlayer, "_FT_agingFrequency" ) 
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_FT_anniversaryFrequency" ) )
		SetSliderDialogDefaultValue( 364.0 )
		SetSliderDialogRange( 1.0, _agingFrequency )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_FT_anniversaryFrequency", thisValue )
		SetSliderOptionValueST( thisValue,"{1}" )
	endEvent

	event OnDefaultST()
		_agingFrequency = StorageUtil.GetFloatValue(kPlayer, "_FT_agingFrequency" ) 
		StorageUtil.SetFloatValue(kPlayer, "_FT_anniversaryFrequency", _agingFrequency )
		SetSliderOptionValueST( _agingFrequency,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Frequency of anniversary treats (in days)")
	endEvent
endState

; AddSliderOptionST("STATE_AGING_FREQ","Aging frequency", _anniversaryFrequency,"{0}")
state STATE_AGING_FREQ ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( StorageUtil.GetFloatValue(kPlayer, "_FT_agingFrequency" ) )
		SetSliderDialogDefaultValue( 364.0 )
		SetSliderDialogRange( 7.0, 364.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		StorageUtil.SetFloatValue(kPlayer, "_FT_agingFrequency", thisValue )
		SetSliderOptionValueST( thisValue,"{1}" )
	endEvent

	event OnDefaultST()
		StorageUtil.SetFloatValue(kPlayer, "_FT_agingFrequency", 364.0 )
		SetSliderOptionValueST( 364.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Frequency of age changes (in days)")
	endEvent
endState

; AddToggleOptionST("STATE_AGING_TOGGLE","Start/Stop aging", _startAging as Float)
state STATE_AGING_TOGGLE ; TOGGLE
	event OnSelectST()
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(none, "_FT_startAging" )  )  
		_startAging = toggle
		StorageUtil.SetIntValue(none, "_FT_startAging", toggle )
		SetToggleOptionValueST( toggle as Bool )

		if (_startAging==1)
			Debug.MessageBox("Family ties: Player aging started")
		else
			Debug.MessageBox("Family ties: Player aging stopped")
		Endif
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("Start/Stop aging.")
	endEvent

endState

; AddToggleOptionST("STATE_AGING_PAUSE","Pause aging", _pauseAging as Float)
state STATE_AGING_PAUSE ; TOGGLE
	event OnSelectST()
		Int toggle = Math.LogicalXor( 1,  StorageUtil.GetIntValue(none, "_FT_pauseAging" )  )  
		_pauseAging = toggle
		StorageUtil.SetIntValue(none, "_FT_pauseAging", toggle )
		SetToggleOptionValueST( toggle as Bool )

		if (_pauseAging==1)
			Debug.MessageBox("Family ties: Player aging paused")
		Endif
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("Pause aging (useful if changing race or during special quests)")
	endEvent

endState

; AddToggleOptionST("STATE_RACE_RESET","Race reset", _resetRace as Float)
state STATE_RACE_RESET ; TOGGLE
	event OnSelectST()
		Actor PlayerActor 
		Race rPlayerRealRace 
		Race rPlayerCurrentRace 
		float fMinHeight =	StorageUtil.GetFloatValue(none, "_FT_fMinHeight") 

		StorageUtil.SetIntValue(none, "_FT_resetRace", 0 )
		SetToggleOptionValueST( false )

		PlayerActor = Game.getPlayer() as Actor
		rPlayerRealRace = PlayerActor.getrace()
		StorageUtil.SetFormValue(PlayerActor, "_FT_fPlayerRealRace", rPlayerRealRace as Form)
		StorageUtil.SetFormValue(PlayerActor, "_FT_fPlayerCurrentRace", rPlayerRealRace as Form)

		; Add an MCM checkbox later to disable morphs
		If (playerAge <= 20)
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast", 0.1 ) 
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBelly", 1.5 ) 
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButt", 0.8 ) 
			StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight", 20.0 ) 
			PlayerActor.SendModEvent("SLHRefresh")

			_changePlayerScale(fMinHeight + ((playerAge - baseAge) * 0.01 ) )
		endif

		PlayerActor.SendModEvent("SLHSetShape")

		Debug.MessageBox("Family ties: Player race reset")
	
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("Reset default player race (to detect race transformations accordingly)")
	endEvent

endState

Function _changePlayerScale(float fHeight)
	Actor PlayerActor 
	float fMinHeight =	StorageUtil.GetFloatValue(none, "_FT_fMinHeight")
	float fMaxHeight =	StorageUtil.GetFloatValue(none, "_FT_fMaxHeight")
	fHeight = fMax(fMin(fHeight, fMaxHeight), fMinHeight)

	PlayerActor = Game.getPlayer() as Actor
	PlayerActor.SetScale(fHeight)
EndFunction

float function fMin(float  a, float b)
	if (a<=b)
		return a
	else
		return b
	EndIf
EndFunction

float function fMax(float a, float b)
	if (a<b)
		return b
	else
		return a
	EndIf
EndFunction
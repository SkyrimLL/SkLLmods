Scriptname SL_Dibella_TRG_sexchangeConfig extends ObjectReference  

Event OnActivate(ObjectReference akActionRef)
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	Int IButton = SexchangeConfigMenu.Show()

	If (IButton == 0 ) 
		If (_SLSD_HormonesSexChange.GetValue()==0)
			Debug.Notification("[SL Dibella] Sex change blessing enabled")
			_SLSD_HormonesSexChange.SetValue(1)

		Else
			Debug.Notification("[SL Dibella] Sex change blessing disabled")
			_SLSD_HormonesSexChange.SetValue(0)
		Endif

	ElseIf (IButton == 1 ) 
		If (_SLSD_TempleSweatON.GetValue()==0)
			Debug.Notification("[SL Dibella] Temple Sweat effect enabled")
			_SLSD_TempleSweatON.SetValue(1)

		Else
			Debug.Notification("[SL Dibella] Temple Sweat effect disabled")
			_SLSD_TempleSweatON.SetValue(0)
		Endif

	ElseIf (IButton == 2 ) 
		If ( _SLSD_GV_BardsCollegeQuestON.GetValue()==0)
			Debug.Notification("[SL Dibella] Bards college quest enabled")
			 _SLSD_GV_BardsCollegeQuestON.SetValue(1)

		Else
			Debug.Notification("[SL Dibella] Bards college quest disabled")
			 _SLSD_GV_BardsCollegeQuestON.SetValue(0)
		Endif

	ElseIf (IButton == 3 ) 
		If (_SLSD_GV_MaraLoveQuestON.GetValue()==0)
			Debug.Notification("[SL Dibella] Mara's Love quest enabled")
			_SLSD_GV_MaraLoveQuestON.SetValue(1)

		Else
			Debug.Notification("[SL Dibella] Mara's Love quest disabled")
			_SLSD_GV_MaraLoveQuestON.SetValue(0)
		Endif

	ElseIf (IButton == 4 ) 
		If (StorageUtil.GetIntValue( akActor, "_SLSD_iTogglePerkPoints")==0)
			Debug.Notification("[SL Dibella] Perk points for Dibella tokens enabled")
			StorageUtil.SetIntValue( akActor, "_SLSD_iTogglePerkPoints", 1 )

		Else
			Debug.Notification("[SL Dibella] Perk points for Dibella tokens disabled")
			StorageUtil.SetIntValue( akActor, "_SLSD_iTogglePerkPoints", 0 )
		Endif
	Endif

endevent


Message Property SexchangeConfigMenu  Auto  
GlobalVariable Property _SLSD_HormonesSexChange  Auto  
GlobalVariable Property _SLSD_TempleSweatON  Auto  

GlobalVariable Property _SLSD_GV_BardsCollegeQuestON  Auto  

GlobalVariable Property _SLSD_GV_MaraLoveQuestON  Auto  

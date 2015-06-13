Scriptname SL_Hypnosis_item extends ReferenceAlias  

Faction Property pCurrentFollower Auto
Faction Property pPotentialFollower Auto
Faction Property pPotentialMarriage Auto
Faction Property pDismissedFollower Auto
Faction Property pCurrentHireling Auto
Faction Property pDunPlayerAllyFaction Auto

GlobalVariable Property pPlayerFollowerCount Auto

ReferenceAlias Property pHypnosisVictimAlias Auto
ReferenceAlias Property pFollowerAlias Auto
Message Property  FollowerDismissMessage Auto
Quest Property pDialogueFollower  Auto  

Faction Property HypnosisVictimFaction  Auto  

SPELL Property DetectVictimSpell  Auto  
SPELL Property CircletActivationSpell  Auto  
SPELL Property CircletRemovalSpell  Auto  


;This script assumes that the only way to get the armor is to kill the champion. If this assumption becomes incorrect, we will likely need handling and extra objectives for seperating out the killing and getting of Armor

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	Actor akActor = None
	Int daysSinceEnslavement	
	Race ContainerRace = None
	Bool IsActorValid

	Debug.Notification("[MC] Device changed container.")
 
	akActor = akNewContainer as Actor
	ContainerRace = akActor.GetRace()

	; IsPlayable = ContainerRace.IsRaceFlagSet(0x00000001) 
	If (akActor != None)
		IsActorValid = ( akActor.GetLeveledActorBase().GetSex() == 0 ) || ( akActor.GetLeveledActorBase().GetSex() == 1 ) 
	Else
		IsActorValid = False
	EndIf

	if ((akNewContainer != Game.GetPlayer()) && (IsActorValid == True)) && (akNewContainer != None) && (ContainerRace!=None)
		akActor = akNewContainer as Actor

		CircletActivationSpell.Cast(akNewContainer,akNewContainer)

		Debug.Notification("[MC] Device In NPC: " + akActor.GetLeveledActorBase().GetName() )
		; "Actor: " + Debug.Notification(self )

		; Briefly dismiss NPC if already follower
		; If !(akActor.IsInFaction(pDismissedFollower ))
		(pDialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)
		; EndIf

		; Save previous NPC state
		If (akActor.IsInFaction(pCurrentFollower ))
			StorageUtil.SetIntValue(akActor, "_SLMC_inCurrentFollowerFaction", 1)
		Else
			StorageUtil.SetIntValue(akActor, "_SLMC_inCurrentFollowerFaction", 0)
			akActor.AddToFaction(pCurrentFollower)
		EndIf

		StorageUtil.SetIntValue(akActor, "_SLMC_currentFollowerRank", akActor.GetFactionRank(pCurrentFollower))
		akActor.SetFactionRank(pCurrentFollower, -1)

		StorageUtil.SetIntValue(akActor, "_SLMC_relationshipRank", akActor.GetRelationshipRank(Game.GetPlayer()))
		akActor.SetRelationshipRank(Game.GetPlayer(), 4)
		(Game.GetPlayer() as Actor).SetRelationshipRank(akActor, 4)

		If !(StorageUtil.HasIntValue(akActor, "_SD_iRelationshipType"))
			StorageUtil.SetIntValue(akActor, "_SD_iRelationshipType" , akActor.GetRelationshipRank(Game.GetPlayer()) )
		EndIf				

		If (akActor.IsInFaction(pPotentialFollower ))
			StorageUtil.SetIntValue(akActor, "_SLMC_inPotentialFollowerFaction", 1)
		Else
			StorageUtil.SetIntValue(akActor, "_SLMC_inPotentialFollowerFaction", 0)
			akActor.AddToFaction(pPotentialFollower)
		EndIf

		If (akActor.IsInFaction(pPotentialMarriage ))
			StorageUtil.SetIntValue(akActor, "_SLMC_inPotentialMarriageFaction", 1)
		Else
			StorageUtil.SetIntValue(akActor, "_SLMC_inPotentialMarriageFaction", 0)
			akActor.AddToFaction(pPotentialMarriage)
		EndIf

		If (akActor.IsInFaction(pDunPlayerAllyFaction ))
			StorageUtil.SetIntValue(akActor, "_SLMC_inDunPlayerAllyFaction", 1)
		Else
			StorageUtil.SetIntValue(akActor, "_SLMC_inDunPlayerAllyFaction", 0)
			akActor.AddToFaction(pDunPlayerAllyFaction)
		EndIf

		akActor.AddToFaction(HypnosisVictimFaction)

		If (akActor.IsInFaction(HypnosisVictimFaction ))
			Debug.Notification("[NPC is now under mind control]")
		EndIf

		int subTrigger = GV_chanceOfDom.GetValue()  as Int ; 10 + (akActor.GetBaseAV("Assistance") as Int) * 40
		If (Utility.RandomInt(0,100)<subTrigger)
		;	Debug.Notification("[Side effect] NPC is Dominant")
			StorageUtil.SetIntValue(akActor, "_SLMC_isVictimSub", 0)   ; Victim is Dom 
			StorageUtil.SetIntValue(akActor, "_SD_iRelationshipType" , -5 )
		Else
		;	Debug.Notification("[Mind Control] NPC is Submissive")
			StorageUtil.SetIntValue(akActor, "_SLMC_isVictimSub", 1)   ; Victim is Sub
			; StorageUtil.SetIntValue(Game.GetPlayer(), "Puppet_SpellON", 1)
			akActor.SendModEvent("PMCharmPuppet")
			SendModEvent("PMGrantControlSpells")
			StorageUtil.SetIntValue(akActor, "_SD_iRelationshipType" , 5 )
		EndIf

		int sexChangeTrigger = GV_isHRT.GetValue() as Int
		Int victimGender = akActor.GetLeveledActorBase().GetSex() as Int
		If (Utility.RandomInt(0,100)<sexChangeTrigger)
			If (victimGender == 0)
			;	Debug.Notification("[Side effect] NPC treated as Female")
				SexLab.TreatAsFemale(akActor)
			ElseIf  (victimGender == 1)
			;	Debug.Notification("[Side effect] NPC treated as Male")
				SexLab.TreatAsMale(akActor)

				_refreshNPCSchlong(akActor)
			EndIf
		EndIf

		_changeNPCShape ( akActor )

		StorageUtil.SetIntValue(akActor, "_SLMC_victimAggression",akActor.GetBaseAV("Aggression") as Int)
		StorageUtil.SetIntValue(akActor, "_SLMC_victimConfidence",akActor.GetBaseAV("Confidence") as Int)
		StorageUtil.SetIntValue(akActor, "_SLMC_victimAssistance",akActor.GetBaseAV("Assistance") as Int)

		(pDialogueFollower as DialogueFollowerScript).SetFollower(akNewContainer)

		pHypnosisVictimAlias.ForceRefTo(akActor)
		; Debug.Notification("Actor: " + pFollowerAlias.GetActorRef())

		StorageUtil.SetIntValue(akActor, "_SLMC_victimDateEnslaved", Game.QueryStat("Days Passed") )
		StorageUtil.SetIntValue(akActor, "_SLMC_victimGameDaysEnslaved", 0)
		StorageUtil.SetIntValue(akActor, "_SLMC_victimBleedCount", 0)
		StorageUtil.SetIntValue(akActor, "_SLMC_victimFreeze", 0)


	ElseIf (akNewContainer == Game.GetPlayer()) || (akNewContainer == None)

		if (akNewContainer == None) 
			Debug.Notification("[MC] Device was dropped to the ground")
		EndIf

		Debug.Notification("[MC] Device in Player inventory")

		if (akOldContainer != None)
			if (pFollowerAlias)			
				(pDialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)
			EndIf
			
			akActor = akOldContainer as Actor

			; ContainerRace = akActor.GetRace()
			; IsPlayable = ContainerRace.IsRaceFlagSet(0x00000001) 
			IsActorValid = ( akActor.GetLeveledActorBase().GetSex() == 0 ) || ( akActor.GetLeveledActorBase().GetSex() == 1 ) 

			If (IsActorValid)
				CircletActivationSpell.Cast(akNewContainer,akNewContainer)
			EndIf
			
			Debug.Notification("[MC] Previous owner: " + (akOldContainer as Actor).GetLeveledActorBase().GetName()  )

			; Debug.Notification("Actor: " + pFollowerAlias.GetActorRef())

			daysSinceEnslavement = (Game.QueryStat("Days Passed") - StorageUtil.GetIntValue(akActor, "_SLMC_victimGameDaysEnslaved") ) as Int
			Debug.Notification("[MC] NPC released after " + daysSinceEnslavement + " days")

			actor DismissedFollowerActor =  pHypnosisVictimAlias.GetActorRef() as Actor ; akOldContainer as Actor  

			Debug.SendAnimationEvent(pHypnosisVictimAlias.GetActorRef(), "IdleForceDefaultState")

			DismissedFollowerActor.StopCombatAlarm()
			DismissedFollowerActor.SetPlayerTeammate(false)
			DismissedFollowerActor.RemoveFromFaction(pCurrentHireling)
			DismissedFollowerActor.SetAV("WaitingForPlayer", 0)	

			; Restore previous NPC state
			; DismissedFollowerActor.SetFactionRank(pCurrentFollower, pHypnosisNPCCurrentFollowerRank.GetValue() as Int)
			DismissedFollowerActor.SetFactionRank(pCurrentFollower, -1)

			If (StorageUtil.GetIntValue(akActor, "_SLMC_inCurrentFollowerFaction") == 0)
				DismissedFollowerActor.RemoveFromFaction(pCurrentFollower)
			EndIf

			DismissedFollowerActor.RemoveFromFaction(pDismissedFollower)

			; After 2 days, these faction changes are permanent
			If (daysSinceEnslavement<2)

				If (StorageUtil.GetIntValue(akActor, "_SLMC_inPotentialFollowerFaction") == 0)
					DismissedFollowerActor.RemoveFromFaction(pPotentialFollower)
				EndIf

				DismissedFollowerActor.SetRelationshipRank(Game.GetPlayer(), StorageUtil.GetIntValue(akActor, "_SLMC_relationshipRank") )
				(Game.GetPlayer() as Actor).SetRelationshipRank(DismissedFollowerActor, StorageUtil.GetIntValue(akActor, "_SLMC_relationshipRank") )
				StorageUtil.SetIntValue(akActor, "_SD_iRelationshipType" , DismissedFollowerActor.GetRelationshipRank(Game.GetPlayer()) )

				; DismissedFollowerActor.RemoveFromFaction(HypnosisVictimFaction)
				
				DismissedFollowerActor.SetActorValue("Aggression", StorageUtil.GetIntValue(akActor, "_SLMC_victimAggression") as Float)
				DismissedFollowerActor.SetActorValue("Confidence", StorageUtil.GetIntValue(akActor, "_SLMC_victimConfidence") as Float)
				DismissedFollowerActor.SetActorValue("Assistance", StorageUtil.GetIntValue(akActor, "_SLMC_victimAssistance") as Float)

				; Restore health and remove essential status in case it was changed
				DismissedFollowerActor.ForceAV("Health", 100)
				DismissedFollowerActor.EndDeferredKill()

			Else
				akActor.SetRelationshipRank(Game.GetPlayer(), 3)
				(Game.GetPlayer() as Actor).SetRelationshipRank(akActor, 3)
			EndIf

			; After 5 days, these faction changes are permanent
			If (daysSinceEnslavement<5)
		 		If (StorageUtil.GetIntValue(akActor, "_SLMC_inPotentialMarriageFaction") == 0)
					DismissedFollowerActor.RemoveFromFaction(pPotentialMarriage)
				EndIf

		 		If (StorageUtil.GetIntValue(akActor, "_SLMC_inDunPlayerAllyFaction") == 0)
					DismissedFollowerActor.RemoveFromFaction(pDunPlayerAllyFaction)
				EndIf

				SexLab.ClearForcedGender(akActor)
			Else
				; Force essential status after 5 days
				DismissedFollowerActor.StartDeferredKill()

				akActor.SetRelationshipRank(Game.GetPlayer(), 4)
				(Game.GetPlayer() as Actor).SetRelationshipRank(akActor, 4)
			EndIf


			; Additional reactions to having circlet removed 
			If (daysSinceEnslavement<1)
				; - Unconscious for a while?
				DismissedFollowerActor.ForceAV("Health", 5)
				If (Utility.RandomInt(0, 100)>30)
					CircletRemovalSpell.Cast(akNewContainer,akOldContainer)
				EndIf

			ElseIf (daysSinceEnslavement<2)
			; - Bleedout?
				DismissedFollowerActor.ForceAV("Health", 100)
				DismissedFollowerActor.SetAlert(true)
				DismissedFollowerActor.SetIntimidated(true)
				If (Utility.RandomInt(0, 100)>60)
					CircletRemovalSpell.Cast(akNewContainer,akOldContainer)
				EndIf

			ElseIf (daysSinceEnslavement<5)
			; - Hostile to player?
				DismissedFollowerActor.ForceAV("Health", 100)
				DismissedFollowerActor.StartCombat(Game.GetPlayer())
				If (Utility.RandomInt(0, 100)>90)
					CircletRemovalSpell.Cast(akNewContainer,akOldContainer)
				EndIf
			EndIf

			_restoreNPCShape ( akActor )

		Else
			Debug.Notification("[MC] Previous container was empty")
		EndIf

		pHypnosisVictimAlias.Clear()

		if (pFollowerAlias)
			pFollowerAlias.Clear()
		EndIf
		; StorageUtil.SetIntValue(Game.GetPlayer(), "Puppet_SpellON", -1)
	Else
		Debug.Notification("[MC] Device not in compatible host")
	EndIf
endEvent


Event OnEquipped(Actor akActor)

; 	Debug.Trace(self + "OnEquipped()")

	if  akActor == Game.GetPlayer()
;		Game.GetPlayer().AddSpell(DetectVictimSpell  )
;		StorageUtil.SetIntValue(Game.GetPlayer(), "Puppet_SpellON", 1)
	endIf
endEvent


Event OnUnequipped(Actor akActor)
	
	if  akActor == Game.GetPlayer()
;		Game.GetPlayer().RemoveSpell(DetectVictimSpell  )
;		StorageUtil.SetIntValue(Game.GetPlayer(), "Puppet_SpellON", -1)
	EndIf
EndEvent

Function _changeNPCShape ( Actor akActor )
	Float fBreast  = 0.0
	Float fButt  = 0.0
	Float fSchlong = 0.0
	Bool bEnableBreast  = NetImmerse.HasNode(akActor, "NPC L Breast", false)
	Bool bEnableButt  = NetImmerse.HasNode(akActor, "NPC L Butt", false)
	Bool bEnableSchlong     = NetImmerse.HasNode(akActor, "NPC GenitalsBase [GenBase]", false)

	Bool bBreastEnabled     = ( bEnableBreast as bool )
	Bool bButtEnabled     = ( bEnableButt as bool )
	Bool bSchlongEnabled     = ( bEnableSchlong as bool )

	Debug.Notification("[MC] Change body: " + GV_useBodyChanges.GetValue() as Bool)
	Debug.Notification("[MC] Change eyes: " + GV_useEyesChanges.GetValue() as Bool)

	If (GV_useBodyChanges.GetValue() == 1)  

		if ( bBreastEnabled && akActor.GetLeveledActorBase().GetSex() == 1 )
			StorageUtil.SetFloatValue(akActor, "_SLMC_victimBreastScale", NetImmerse.GetNodeScale(akActor, "NPC L Breast", false))
			float fBreastBase = GV_breastMax.GetValue() as Float
			fBreast  = Utility.RandomFloat( fBreastBase - (fBreastBase * 0.5), fBreastBase + ( fBreastBase * 1.5) )
			StorageUtil.SetFloatValue(akActor, "_SLMC_victimNewBreastScale", fBreast)

			; Debug.Notification("[MC] New breast scale: " + fBreast)

			NetImmerse.SetNodeScale(akActor, "NPC L Breast", fBreast  , false)
			NetImmerse.SetNodeScale(akActor, "NPC R Breast", fBreast  , false)
			NetImmerse.SetNodeScale(akActor, "NPC L Breast", fBreast  , true)
			NetImmerse.SetNodeScale(akActor, "NPC R Breast", fBreast  , true)
		EndIf

		if ( bButtEnabled && akActor.GetLeveledActorBase().GetSex() == 1 )
			StorageUtil.SetFloatValue(akActor, "_SLMC_victimButtScale", NetImmerse.GetNodeScale(akActor, "NPC L Butt", false))
			float fButtBase = GV_buttMax.GetValue() as Float
			fButt = Utility.RandomFloat( fButtBase - (fButtBase * 0.2), fButtBase + ( fButtBase * 0.8) )
			StorageUtil.SetFloatValue(akActor, "_SLMC_victimNewButtScale", fButt)

			; Debug.Notification("[MC] New butt scale: " + fButt)

			NetImmerse.SetNodeScale(akActor, "NPC L Butt", fButt  , false)
			NetImmerse.SetNodeScale(akActor, "NPC R Butt", fButt  , false)
			NetImmerse.SetNodeScale(akActor, "NPC L Butt", fButt  , true)
			NetImmerse.SetNodeScale(akActor, "NPC R Butt", fButt  , true)
		EndIf

		if ( bSchlongEnabled && akActor.GetLeveledActorBase().GetSex() == 0 )
			StorageUtil.SetFloatValue(akActor, "_SLMC_victimSchlongScale", NetImmerse.GetNodeScale(akActor, "NPC GenitalsBase [GenBase]", false))
			float fSchlongBase = GV_schlongMax.GetValue() as Float
			fSchlong = Utility.RandomFloat( fSchlongBase - (fSchlongBase * 0.1), fSchlongBase + ( fSchlongBase * 0.8) )
			StorageUtil.SetFloatValue(akActor, "_SLMC_victimNewSchlongScale", fSchlong)

			; Debug.Notification("[MC] New schlong scale: " + fSchlong)

			NetImmerse.SetNodeScale(akActor, "NPC GenitalsBase [GenBase]", fSchlong , false)
			NetImmerse.SetNodeScale(akActor, "NPC GenitalsBase [GenBase]", fSchlong , true)
		EndIf
	EndIf

	If (GV_useEyesChanges.GetValue()  == 1) 
		Int eyesIndex = 0
		if (akActor.GetLeveledActorBase().GetSex() == 1)
			eyesIndex = 2
		Else
			eyesIndex = 0
		EndIf

		HeadPart EyesHP = _SLMC_EyesMC.GetAt(eyesIndex) as HeadPart
	  	akActor.ChangeHeadPart(EyesHP)
	 	; akActor.RegenerateHead()
	 EndIf

	If (GV_useBodyChanges.GetValue()  == 1)  || (GV_useEyesChanges.GetValue()  == 1)
		while ( akActor.IsOnMount() || Utility.IsInMenuMode() )
			Utility.Wait( 2.0 )
		endWhile

		; 3d will not be loaded in some situations, such as werewolf transformations.
		; Skip body update if 3d not loaded.
		If ( !akActor.Is3DLoaded() )
			return
		EndIf

		Utility.Wait(2.0)
		akActor.QueueNiNodeUpdate()
		Utility.Wait(2.0)	
	EndIf


EndFunction

Function _restoreNPCShape ( Actor akActor )
	Float fBreast  = 0.0
	Float fButt  = 0.0
	Float fSchlong = 0.0
	Bool bEnableBreast  = NetImmerse.HasNode(akActor, "NPC L Breast", false)
	Bool bEnableButt  = NetImmerse.HasNode(akActor, "NPC L Butt", false)
	Bool bEnableSchlong     = NetImmerse.HasNode(akActor, "NPC GenitalsBase [GenBase]", false)

	Bool bBreastEnabled     = ( bEnableBreast as bool )
	Bool bButtEnabled     = ( bEnableButt as bool )
	Bool bSchlongEnabled     = ( bEnableSchlong as bool )

	If (GV_useBodyChanges.GetValue()  == 1) 
		if ( bBreastEnabled && akActor.GetLeveledActorBase().GetSex() == 1 )
			
			fBreast  = StorageUtil.GetFloatValue(akActor, "_SLMC_victimBreastScale")

			NetImmerse.SetNodeScale(akActor, "NPC L Breast", fBreast  , false)
			NetImmerse.SetNodeScale(akActor, "NPC R Breast", fBreast  , false)
			NetImmerse.SetNodeScale(akActor, "NPC L Breast", fBreast  , true)
			NetImmerse.SetNodeScale(akActor, "NPC R Breast", fBreast  , true)
		EndIf

		if ( bButtEnabled && akActor.GetLeveledActorBase().GetSex() == 1 )
			fButt  = StorageUtil.GetFloatValue(akActor, "_SLMC_victimButtScale")

			NetImmerse.SetNodeScale(akActor, "NPC L Butt", fButt  , false)
			NetImmerse.SetNodeScale(akActor, "NPC R Butt", fButt  , false)
			NetImmerse.SetNodeScale(akActor, "NPC L Butt", fButt  , true)
			NetImmerse.SetNodeScale(akActor, "NPC R Butt", fButt  , true)
		EndIf

		if ( bSchlongEnabled && akActor.GetLeveledActorBase().GetSex() == 0 )
			fSchlong = StorageUtil.GetFloatValue(akActor, "_SLMC_victimSchlongScale")


			NetImmerse.SetNodeScale(akActor, "NPC GenitalsBase [GenBase]", fSchlong , false)
			NetImmerse.SetNodeScale(akActor, "NPC GenitalsBase [GenBase]", fSchlong , true)
		EndIf
	EndIf

	If (GV_useEyesChanges.GetValue()  == 1) 
		Int eyesIndex = 1
		if (akActor.GetLeveledActorBase().GetSex() == 1)
			eyesIndex = 3
		Else
			eyesIndex = 1
		EndIf

		HeadPart EyesHP = _SLMC_EyesMC.GetAt(eyesIndex) as HeadPart
	  	akActor.ChangeHeadPart(EyesHP)
	 	; akActor.RegenerateHead()
	EndIf

	If (GV_useBodyChanges.GetValue() == 1)  || (GV_useEyesChanges.GetValue()  == 1) 
		while ( akActor.IsOnMount() || Utility.IsInMenuMode() )
			Utility.Wait( 2.0 )
		endWhile

		; 3d will not be loaded in some situations, such as werewolf transformations.
		; Skip body update if 3d not loaded.
		If ( !akActor.Is3DLoaded() )
			return
		EndIf

		Utility.Wait(2.0)
		akActor.QueueNiNodeUpdate()
		Utility.Wait(2.0)	
	EndIf


EndFunction

Function _refreshVictimShape ( )
	actor akActor =  pHypnosisVictimAlias.GetActorRef() as Actor

	if (akActor != None)
		_refreshNPCShape ( akActor )
	EndIf
EndFunction

Function _refreshNPCShape ( Actor akActor )
	Float fBreast  = 0.0
	Float fButt  = 0.0
	Float fSchlong = 0.0
	Bool bEnableBreast  = NetImmerse.HasNode(akActor, "NPC L Breast", false)
	Bool bEnableButt  = NetImmerse.HasNode(akActor, "NPC L Butt", false)
	Bool bEnableSchlong     = NetImmerse.HasNode(akActor, "NPC GenitalsBase [GenBase]", false)

	Bool bBreastEnabled     = ( bEnableBreast as bool )
	Bool bButtEnabled     = ( bEnableButt as bool )
	Bool bSchlongEnabled     = ( bEnableSchlong as bool )

	If (GV_useBodyChanges.GetValue()  == 1) 
		if ( bBreastEnabled && akActor.GetLeveledActorBase().GetSex() == 1 )
			
			fBreast  = StorageUtil.GetFloatValue(akActor, "_SLMC_victimNewBreastScale")

			NetImmerse.SetNodeScale(akActor, "NPC L Breast", fBreast  , false)
			NetImmerse.SetNodeScale(akActor, "NPC R Breast", fBreast  , false)
			NetImmerse.SetNodeScale(akActor, "NPC L Breast", fBreast  , true)
			NetImmerse.SetNodeScale(akActor, "NPC R Breast", fBreast  , true)
		EndIf

		if ( bButtEnabled && akActor.GetLeveledActorBase().GetSex() == 1 )
			fButt  = StorageUtil.GetFloatValue(akActor, "_SLMC_victimNewButtScale")

			NetImmerse.SetNodeScale(akActor, "NPC L Butt", fButt  , false)
			NetImmerse.SetNodeScale(akActor, "NPC R Butt", fButt  , false)
			NetImmerse.SetNodeScale(akActor, "NPC L Butt", fButt  , true)
			NetImmerse.SetNodeScale(akActor, "NPC R Butt", fButt  , true)
		EndIf

		if ( bSchlongEnabled && akActor.GetLeveledActorBase().GetSex() == 0 )
			fSchlong = StorageUtil.GetFloatValue(akActor, "_SLMC_victimNewSchlongScale")

			NetImmerse.SetNodeScale(akActor, "NPC GenitalsBase [GenBase]", fSchlong , false)
			NetImmerse.SetNodeScale(akActor, "NPC GenitalsBase [GenBase]", fSchlong , true)
		EndIf
	EndIf

	If (GV_useEyesChanges.GetValue()   == 1) 
		Int eyesIndex = 0
		if (akActor.GetLeveledActorBase().GetSex() == 1)
			eyesIndex = 2
		Else
			eyesIndex = 0
		EndIf

		HeadPart EyesHP = _SLMC_EyesMC.GetAt(eyesIndex) as HeadPart
	  	akActor.ChangeHeadPart(EyesHP)
	 	; akActor.RegenerateHead()
	 EndIf

	If (GV_useBodyChanges.GetValue() == 1)  || (GV_useEyesChanges.GetValue()  == 1)  
		while ( akActor.IsOnMount() || Utility.IsInMenuMode() )
			Utility.Wait( 2.0 )
		endWhile

		; 3d will not be loaded in some situations, such as werewolf transformations.
		; Skip body update if 3d not loaded.
		If ( !akActor.Is3DLoaded() )
			return
		EndIf

		Utility.Wait(2.0)
		akActor.QueueNiNodeUpdate()
		Utility.Wait(2.0)	
	EndIf


EndFunction

Function _refreshNPCSchlong ( Actor akActor )
	; ObjectReference akActorRef = akActor as ObjectReference
	bool isSOSPresent = Quest.GetQuest("SOS_SetupQuest")
	 
	If isSOSPresent
		Quest SOSQuest = Quest.GetQuest("SOS_SetupQuest")
		SOS_SetupQuest_Script SOSScript = SOSQuest as SOS_SetupQuest_Script

		; If MenuName != "RaceSex Menu" || SOS_Data.CountAddons() == 0
		;	Return
		; EndIf
		
		; Debug.Trace("SOS RaceSwitchComplete: " + PlayerRef.GetLeveledActorBase().GetName() + " switched to race " + PlayerRef.GetRace().GetName())

		int size = 1
		Faction addonFaction = None
		Form oldAddon = None
		Form addon = SOSScript.GetActiveAddon(akActor)
		
		If addon
			; actor was already schlonged, retrieve SOS data
			addonFaction = SOS_Data.GetFaction(addon)
			size = akActor.GetFactionRank(addonFaction)
			oldAddon = addon
			
			If !SOSScript.IsSchlongGenderAllowed(addon, akActor.GetLeveledActorBase().GetSex())
				addon = None ; invalidate schlong due gender change
				Debug.Trace("SOS RaceSwitchComplete: " + akActor.GetLeveledActorBase().GetName() + " lost schlong due to gender change")
			EndIf
		EndIf
		
		If !addon
			; switched race and had no schlong, or switched gender, lets see if we can find a new schlong
			addon = SOSScript.DetermineSchlongType(akActor)
			If addon
				; Debug.Trace("SOS RaceSwitchComplete: new schlong for " + PlayerRef.GetLeveledActorBase().GetName() + ", schlong index " + SOS_Data.FindAddon(addon))
				SOSScript.SetSchlongType(addon, akActor) ; factions and genitals
				SOSScript.RegisterNewSchlongifiedActor(akActor, addon) ; addon formlist
			EndIf
		endif
		
		If !addon
			; no schlong available, clean
			SOSScript.RemoveSchlongFromActor(oldAddon, akActor)
		Else
			SOSScript.ScaleSchlongBones(addon, akActor, size) ; bone scales
			SOSScript.UpdateNiNodes(akActor)
			SOSScript.CheckActorSpell(akActor, true, true)
		EndIf


	Else ;If it is not installed only one other possibility. 
		Debug.Trace("Schlongs was not present.")
	EndIf


EndFunction

FormList  Property _SLMC_EyesMC Auto  
GlobalVariable      Property GV_chanceOfDom 			Auto
GlobalVariable      Property GV_isHRT 					Auto

GlobalVariable      Property GV_breastMax      			Auto
GlobalVariable      Property GV_buttMax       	 		Auto
GlobalVariable      Property GV_schlongMax       	 	Auto

GlobalVariable      Property GV_useBodyChanges	 		Auto
GlobalVariable      Property GV_useEyesChanges	 		Auto

SexLabFrameWork Property SexLab Auto
Scriptname SLP_MEF_SeedSpawnChaurus extends activemagiceffect  

SLP_fcts_parasites Property fctParasites  Auto 

Quest Property QueenOfChaurusQuest  Auto 

Activator Property arPortalFX Auto

Actor Property EncChaurusActor Auto 
Actor Property EncChaurusSpawnActor Auto 
Actor Property EncChaurusFledgelingActor Auto 
Actor Property EncChaurusHunterActor Auto 

Scroll Property SpiderSpawnOil Auto
Scroll Property SpiderSpawnMind Auto
Scroll Property SpiderSpawnGlow Auto

Ingredient  Property ChaurusEgg Auto
Ingredient  Property SwampFungalPod01 Auto ; mind control spiders
Ingredient  Property DwarvenOil Auto ; oil spiders
Ingredient  Property FireflyThorax Auto ; glow spiders

SPELL Property ChaurusArmor Auto
SPELL Property ChaurusMask Auto
Spell Property DismissSpawns Auto


Event OnEffectStart(Actor Target, Actor Caster)
	Actor kPlayer = Game.GetPlayer()
	Actorbase EncChaurusActorBase
	Actor kChaurusSpawn
 	Int iRandomNum = utility.randomint(0,100)
 	Int iChaurusQueenStage = StorageUtil.GetIntValue(kPlayer, "_SLP_iChaurusQueenStage")
 	Int iChaurusSpawnCount
 	Int iChaurusEggsCount = kPlayer.GetItemCount(ChaurusEgg)
 	Int iChaurusSpawnLevel
 	Int iChaurusSpawnListMax = 10
 	
	if (!kPlayer.HasSpell( DismissSpawns ))
		kPlayer.AddSpell( DismissSpawns ) 
	endif

	if (iChaurusEggsCount>5)
		iChaurusSpawnCount = 5
	elseif (iChaurusEggsCount>0)
		iChaurusSpawnCount = iChaurusEggsCount 
	endif

	if (iChaurusSpawnCount>0)
		Debug.trace("[SLP] SLP_MEF_SeedSpawnChaurus") 


		if (!kPlayer.HasSpell( ChaurusArmor ))
			kPlayer.RemoveItem(ChaurusEgg, iChaurusSpawnCount)
	 		kPlayer.AddSpell( ChaurusArmor ) 
	 		kPlayer.AddSpell( ChaurusMask ) 

	 		; fctParasites.infectChaurusQueenArmor( kPlayer  )
	 		; fctParasites.infectChaurusQueenGag( kPlayer  )
	 		ChaurusArmor.Cast(kPlayer as ObjectReference, kPlayer as ObjectReference)	
			ChaurusMask.Cast(kPlayer as ObjectReference, kPlayer as ObjectReference)	

			Debug.messagebox("In a flash, the Seed ingests material from the egg and spreads it around your skin into a thin protective layer of mucus and chitin.") 

		else
			Debug.notification("Chaurus spawn from your egg sac.") 

			if (iRandomNum>90) && (kPlayer.GetItemCount(SwampFungalPod01)>0)
				kPlayer.RemoveItem(ChaurusEgg, iChaurusSpawnCount)
				kPlayer.AddItem(SpiderSpawnMind, iChaurusSpawnCount)
				kPlayer.RemoveItem(SwampFungalPod01, 1)

			elseif (iRandomNum>70) && (kPlayer.GetItemCount(DwarvenOil)>0)
				kPlayer.RemoveItem(ChaurusEgg, iChaurusSpawnCount)
				kPlayer.AddItem(SpiderSpawnOil, iChaurusSpawnCount)
				kPlayer.RemoveItem(DwarvenOil, 1)

			elseif (iRandomNum>80) && (kPlayer.GetItemCount(FireflyThorax)>0)
				kPlayer.RemoveItem(ChaurusEgg, iChaurusSpawnCount)
				kPlayer.AddItem(SpiderSpawnGlow, iChaurusSpawnCount)
				kPlayer.RemoveItem(FireflyThorax, 1)

			else
				; spawn chaurus helpers here 
				if (iRandomNum>90)
					EncChaurusActorBase = EncChaurusHunterActor.GetBaseObject() as ActorBase
					iChaurusSpawnLevel = 4
				elseif (iRandomNum>60)
					EncChaurusActorBase = EncChaurusSpawnActor.GetBaseObject() as ActorBase
					iChaurusSpawnLevel = 3
				else
					EncChaurusActorBase = EncChaurusFledgelingActor.GetBaseObject() as ActorBase
					iChaurusSpawnLevel = 2
				endif
				

				Int valueCount = StorageUtil.FormListCount(none, "_SLP_lChaurusSpawnsList")
				; clean up list from dead actors  
				cleanChaurusSpawnList()
				summonChaurusSpawnList()

				if (valueCount<iChaurusSpawnListMax)
					; if the list isn't full, add the chaurus
					kPlayer.RemoveItem(ChaurusEgg, iChaurusSpawnCount)
					kChaurusSpawn = kPlayer.PlaceActorAtMe(EncChaurusActorBase, iChaurusSpawnLevel)
				 	debug.notification("[SLP] Adding actor to _SLP_lChaurusSpawnsList - " + kChaurusSpawn )
					StorageUtil.FormListAdd( none, "_SLP_lChaurusSpawnsList", kChaurusSpawn as Form )
				endif

				; Debug
				displayChaurusSpawnList()

			endif

	 	endif

 	else
		Debug.notification("Without chaurus eggs near you, the spell has no effect.") 
		cleanChaurusSpawnList()
		summonChaurusSpawnList()

	endif
    ;   Debug.Messagebox(" Spider Pheromone charm spell started")    
	
EndEvent

Function displayChaurusSpawnList()
	int valueCount = StorageUtil.FormListCount(none, "_SLP_lChaurusSpawnsList")
	int i = 0
	Form thisActorForm
 
 	debug.trace("[SLP] displayChaurusSpawnList (" + valueCount + " actors)")

	while(i < valueCount)
		thisActorForm = StorageUtil.FormListGet(none, "_SLP_lChaurusSpawnsList", i)
		Debug.Trace("	Actor [" + i + "] = "+ thisActorForm +" - " + thisActorForm.GetName())

		; if (StorageUtil.FormListFind( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form) <0)
		;	StorageUtil.FormListAdd( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form )
		; endif

		i += 1
	endwhile
EndFunction

Function cleanChaurusSpawnList()
	int valueCount = StorageUtil.FormListCount(none, "_SLP_lChaurusSpawnsList")
	int i = 0
	Form thisActorForm
	Actor thisActor
 	ObjectReference thisActorRef
 
 	debug.trace("[SLP] cleanChaurusSpawnList (" + valueCount + " actors)")

	while(i < valueCount)
		thisActorForm = StorageUtil.FormListGet(none, "_SLP_lChaurusSpawnsList", i)

		Debug.Trace("	Actor [" + i + "] = "+ thisActorForm +" - " + thisActorForm.GetName())

		thisActor = thisActorForm as Actor
		thisActorRef = thisActor as ObjectReference

		if (thisActor.IsDead()) || (thisActorRef.IsDisabled())
			StorageUtil.FormListRemoveAt(none, "_SLP_lChaurusSpawnsList", i)
		endif

		; if (StorageUtil.FormListFind( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form) <0)
		;	StorageUtil.FormListAdd( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form )
		; endif

		i += 1
	endwhile

	valueCount = StorageUtil.FormListCount(none, "_SLP_lChaurusSpawnsList")
 	debug.trace("[SLP] cleanChaurusSpawnList (" + valueCount + " actors) after clean up ")

EndFunction

Function summonChaurusSpawnList()
	Actor kPlayer = Game.GetPlayer()
	ObjectReference kPlayerRef
	int valueCount = StorageUtil.FormListCount(none, "_SLP_lChaurusSpawnsList")
	int i = 0
	Form thisActorForm
	Actor thisActor
 	ObjectReference thisActorRef

 	debug.trace("[SLP] summonChaurusSpawnList (" + valueCount + " actors)")

	while(i < valueCount)
		thisActorForm = StorageUtil.FormListGet(none, "_SLP_lChaurusSpawnsList", i)
		Debug.Trace("	Actor [" + i + "] = "+ thisActorForm +" - " + thisActorForm.GetName())
		thisActor = thisActorForm as Actor
		thisActorRef = thisActor as ObjectReference

		if (thisActorRef.GetDistance(kPlayerRef) > 100.0)
			Debug.Trace("	Moving Actor to player [" + i + "] = "+ thisActorForm +" - " + thisActorForm.GetName())
			summonChaurusSpawn(thisActorRef)
		endif

		; if (StorageUtil.FormListFind( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form) <0)
		;	StorageUtil.FormListAdd( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form )
		; endif

		i += 1
	endwhile
EndFunction

Function summonChaurusSpawn(ObjectReference ChaurusSpawnRef)
    ObjectReference akSummoner = Game.getPlayer()  as ObjectReference
    ObjectReference arPortal = None

    Float afDistance = 150.0
    Float afZOffset = 0.0
    Int aiStage = 0

    While aiStage < 6
        aiStage += 1
        If aiStage == 1 ; Shroud summon with portal
        		; Use this for burrow effect? find better FX activator
                arPortal = akSummoner.PlaceAtMe(arPortalFX as Form) ; SummonTargetFXActivator 
                ; arPortal = akSummoner.PlaceAtMe(Game.GetFormFromFile(0x0007CD55, "Skyrim.ESM")) ; SummonTargetFXActivator 
                ; arPortal = akSummoner.PlaceAtMe(Game.GetFormFromFile(0x0000481A, "Dragonborn.ESM")) ; FXDraugrEmergeGround01
                ; arPortal = akSummoner.PlaceAtMe(Game.GetFormFromFile(0x0000001B, "Skyrim.ESM")) ; DefaultAshPile1 
                ; arPortal = akSummoner.PlaceAtMe(Game.GetFormFromFile(0x0009F290, "Skyrim.ESM")) ; TrapPoisonGas 
                ; arPortal = akSummoner.PlaceAtMe(Game.GetFormFromFile(0x000BD6B8, "Skyrim.ESM")) ; DA13VinePustule01 
                ; arPortal = akSummoner.PlaceAtMe(Game.GetFormFromFile(0x000EBEB5, "Skyrim.ESM")) ; FXNecroTendrilRing 
                ; arPortal = akSummoner.PlaceAtMe(Game.GetFormFromFile(0x0010D6EF, "Skyrim.ESM")) ; DefaultAshPileGhostBlack 
        ElseIf aiStage == 2 ; Disable Summon
                ChaurusSpawnRef.Disable()  

        ElseIf aiStage == 3 ; Move portal in front of summoner
                arPortal.MoveTo(akSummoner, Math.Sin(akSummoner.GetAngleZ()) * afDistance, Math.Cos(akSummoner.GetAngleZ()) * afDistance, afZOffset)
        ElseIf aiStage == 4 ; Move summon to portal
                ChaurusSpawnRef.MoveTo(arPortal)

        ElseIf (aiStage == 5)
                ChaurusSpawnRef.Enable()
                arPortal.disable()

                ; Use this for burrow effect?
                ; AliciaBloodSpell.RemoteCast(AliciaRef , AliciaActor ,AliciaRef )

         EndIf
        Utility.Wait(0.6)
    EndWhile
EndFunction

Event OnEffectFinish(Actor akTarget, Actor akCaster)        
    ;   Debug.Messagebox(" spell ended")    
    ;	SpiderFollowerAlias.Clear()
ENDEVENT


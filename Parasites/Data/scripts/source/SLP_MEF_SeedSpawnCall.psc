Scriptname SLP_MEF_SeedSpawnCall extends ActiveMagicEffect  

SLP_fcts_parasites Property fctParasites  Auto 

Quest Property QueenOfChaurusQuest  Auto 
ObjectReference Property pocketDimensionRef Auto

Activator Property arPortalFX Auto 
Sound Property SummonSoundFX  Auto

Event OnEffectStart(Actor Target, Actor Caster)
    ;   Debug.Messagebox(" Spider Pheromone charm spell started")    

	Actor kPlayer = Game.GetPlayer()
	ObjectReference kPlayerRef
	int valueCount = StorageUtil.FormListCount(none, "_SLP_lChaurusSpawnsList")
	int i = 0
	Form thisActorForm
	Actor thisActor
	ActorBase thisActorBase
 	ObjectReference thisActorRef
 	Actor kChaurusSpawn
 	Int iChaurusSpawnListMax = 10

 	debug.notification("[SLP] summonChaurusSpawnList (" + valueCount + " actors)")
 	debug.trace("[SLP] summonChaurusSpawnList (" + valueCount + " actors)")

	while(i < valueCount)
		thisActorForm = StorageUtil.FormListGet(none, "_SLP_lChaurusSpawnsList", i)
		thisActor = thisActorForm as Actor
		thisActorRef = thisActor as ObjectReference

		if (thisActorRef==None)
			Debug.Trace("[SLP] 	Actor [" + i + "] = "+ thisActorForm )
			Debug.Trace("[SLP] 		Actor is None - Calling a replacement actor") 
			kChaurusSpawn = fctParasites.getRandomChaurusSpawn(kPlayer)
			
			if (kChaurusSpawn != None)
				debug.trace("[SLP] Adding actor to _SLP_lChaurusSpawnsList - " + kChaurusSpawn )
				StorageUtil.FormListSet( none, "_SLP_lChaurusSpawnsList", i, kChaurusSpawn as Form )
			else
				debug.trace("[SLP]    Problem with fctParasites.getRandomChaurusSpawn - returned a None actor" )
			endif

		else
			Debug.Trace("[SLP] 	Actor [" + i + "] = "+ thisActorForm +" - " + thisActorForm.GetName())

			if (thisActorRef.GetDistance(kPlayerRef) > 100.0)
				Debug.Trace("[SLP] 		Moving Actor to player [" + i + "] = "+ thisActorForm +" - " + thisActorForm.GetName())
				summonChaurusSpawn(thisActorRef)
			endif

		endif

		; if (StorageUtil.FormListFind( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form) <0)
		;	StorageUtil.FormListAdd( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form )
		; endif

		i += 1
	endwhile

	fctParasites.displayChaurusSpawnList()

EndEvent


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
                SummonSoundFX.Play(akSummoner)
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


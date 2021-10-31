Scriptname SLH_ME_SuccubusBody extends activemagiceffect  

Armor Property BoundSuccubusBody Auto
Keyword Property SuccubusBodyKeyword Auto

Event OnEffectStart(Actor ckTarget, Actor ckCaster)
	Actor PlayerActor = Game.GetPlayer()
	Int iDaedricInfluence = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneSuccubus") as Int
	; debug.notification("[SLH]   SLH_ME_SuccubusBody -  OnEffectStart" )

	; if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubusLevel") >=4)
	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubusLevel") >=5)
		if (iDaedricInfluence>70) 
			if (StorageUtil.GetIntValue(none, "_SLH_SuccubusBodyEquipped") == 0 ) && (!PlayerActor.WornHasKeyword(SuccubusBodyKeyword) )
				; debug.notification("[SLH]   EQUIP body" )
				PlayerActor.SendModEvent("SLHModHormone","Succubus", -40.0)
				equipBody()
			else
				; debug.notification("[SLH]   REMOVE body" )
				PlayerActor.SendModEvent("SLHModHormone","Succubus", -40.0)
				removeBody()
			endif
		else
			debug.notification("Your sexual energy is depleted." )

		endif
	else
		debug.notification("You are not powerful enough to change shape." )
	endif

	; endif

EndEvent

Event OnEffectFinish(Actor ckTarget, Actor ckCaster)
	; debug.notification("[SLH]   SLH_ME_SuccubusBody -  OnEffectFinish" )

	; removeBody()
EndEvent

Function equipBody()
	Actor PlayerActor = Game.GetPlayer()
	ObjectReference PlayerActorRef = Game.GetPlayer() as ObjectReference

	Utility.Wait(0.2)
	PlayerActor.EquipItem(BoundSuccubusBody, true, true)

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubusLevel") >=5)

	 	Potion DragonWingsPotion = None 

		debug.trace("[SLH]   Checking for Animated Wings " )
		debug.trace("[SLH]      _SLP_autoRemoveWings: " + StorageUtil.GetIntValue(none, "_SLP_autoRemoveWings" ))
		debug.trace("[SLH]      _SLP_AnimatedWingsEquipped: " + StorageUtil.GetIntValue(none, "_SLP_AnimatedWingsEquipped" ))

		if (StorageUtil.GetIntValue(none, "_SLP_AnimatedWingsEquipped")==0)
			if (StorageUtil.GetIntValue(none, "_SLP_isAnimatedWingsUltimate")==1) 
				DragonWingsPotion = StorageUtil.GetFormValue(none, "_SLH_getWingsPotion") as Potion
				debug.trace("[SLH]   Real Flying Potion: " + DragonWingsPotion)
				PlayerActorRef.AddItem(DragonWingsPotion, 1, true)
				PlayerActor.EquipItem(DragonWingsPotion,abPreventRemoval = false, abSilent = true)
				StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 1 )
				
			elseif (StorageUtil.GetIntValue(none, "_SLP_isRealFlying")==1) 
				DragonWingsPotion = StorageUtil.GetFormValue(none, "_SLH_getWingsPotion") as Potion
				debug.trace("[SLH]   Real Flying Potion: " + DragonWingsPotion)
				PlayerActorRef.AddItem(DragonWingsPotion, 1, true)
				PlayerActor.EquipItem(DragonWingsPotion,abPreventRemoval = false, abSilent = true)
				StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 1 )
				
			elseif (StorageUtil.GetIntValue(none, "_SLP_isAnimatedDragonWings")==1) 
				DragonWingsPotion = StorageUtil.GetFormValue(none, "_SLH_getWingsPotion") as Potion
				debug.trace("[SLH]   Dragon Wings Friendly Potion: " + DragonWingsPotion)
				PlayerActorRef.AddItem(DragonWingsPotion, 1, true)
				PlayerActor.EquipItem(DragonWingsPotion,abPreventRemoval = false, abSilent = true)
				StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 1 )
				
			endif
		endif
	endif

	; wash player automatically if Bathing in Skyrim is on (remove dirt)'
	Int WashActor = ModEvent.Create("BiS_WashActor")
	if (WashActor)
		Debug.trace("[SLH] Washing Succubus")
		ModEvent.PushForm(WashActor, (PlayerActor as Form))
		ModEvent.PushBool(WashActor, false) ; animate
		ModEvent.PushBool(WashActor, true) ; full clean
		ModEvent.PushBool(WashActor, false) ; soap
		ModEvent.Send(WashActor)
	else
		Debug.trace("[SLH] Washing Succubus - FAILED")

    endIf

	Utility.Wait(0.2)
	; Check to play nice with Devious Devices
	if (PlayerActor.WornHasKeyword(SuccubusBodyKeyword) )
		; Equip was successful
		StorageUtil.SetIntValue(none, "_SLH_SuccubusBodyEquipped", 1 )
	endif

Endfunction

Function removeBody()
	Actor PlayerActor = Game.GetPlayer()
	ObjectReference PlayerActorRef = Game.GetPlayer() as ObjectReference

	; Check to play nice with Devious Devices
	if (PlayerActor.WornHasKeyword(SuccubusBodyKeyword) )
		PlayerActor.UnequipItem(BoundSuccubusBody, true)
	endif
 
	debug.trace("[SLH]   Checking for Animated Wings " )
	debug.trace("[SLH]      _SLP_autoRemoveWings: " + StorageUtil.GetIntValue(none, "_SLP_autoRemoveWings" ))
	debug.trace("[SLH]      _SLP_AnimatedWingsEquipped: " + StorageUtil.GetIntValue(none, "_SLP_AnimatedWingsEquipped" ))

	if (StorageUtil.GetIntValue(none, "_SLP_autoRemoveWings" )==1) && (StorageUtil.GetIntValue(none, "_SLP_AnimatedWingsEquipped")==1)
 		Potion DragonWingsCurePotion = None 
		
		debug.trace("[SLH]   Removing Animated Wings " )

		if (StorageUtil.GetIntValue(none, "_SLP_isAnimatedWingsUltimate")==1)
			DragonWingsCurePotion = StorageUtil.GetFormValue(none, "_SLH_getWingsCurePotion") as Potion
			debug.trace("[SLH]   Real Flying Cure Potion: " + DragonWingsCurePotion)
			PlayerActorRef.AddItem(DragonWingsCurePotion, 1, true)
			PlayerActor.EquipItem(DragonWingsCurePotion,abPreventRemoval = false, abSilent = true)
			StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 0 )
			
		elseif (StorageUtil.GetIntValue(none, "_SLP_isRealFlying")==1)
			DragonWingsCurePotion = StorageUtil.GetFormValue(none, "_SLH_getWingsCurePotion") as Potion
			debug.trace("[SLH]   Real Flying Cure Potion: " + DragonWingsCurePotion)
			PlayerActorRef.AddItem(DragonWingsCurePotion, 1, true)
			PlayerActor.EquipItem(DragonWingsCurePotion,abPreventRemoval = false, abSilent = true)
			StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 0 )
			
		elseif (StorageUtil.GetIntValue(none, "_SLP_isAnimatedDragonWings")==1) 
			DragonWingsCurePotion = StorageUtil.GetFormValue(none, "_SLH_getWingsCurePotion"  ) as Potion
			debug.trace("[SLH]   Dragon Wings Cure Potion: " + DragonWingsCurePotion)
			PlayerActorRef.AddItem(DragonWingsCurePotion, 1, true)
			PlayerActor.EquipItem(DragonWingsCurePotion,abPreventRemoval = false, abSilent = true)
			StorageUtil.SetIntValue(none, "_SLP_AnimatedWingsEquipped", 0 )
			
		endif
	endif

	StorageUtil.SetIntValue(none, "_SLH_SuccubusBodyEquipped", 0 )
Endfunction

Scriptname Alicia_AliasFollowerDaedric extends ReferenceAlias  

 

DialogueFollowerScript Property DialogueFollower Auto

GlobalVariable Property AliciaLustLevel  Auto  
GlobalVariable Property AliciaCutCount  Auto  
GlobalVariable Property AliciaCutGameDaysPassed  Auto  
GlobalVariable Property AliciaCutGameDaysDiff  Auto  
GlobalVariable Property AliciaKeepClothesOn  Auto  

GlobalVariable Property PlayerFollowerCount  Auto  
GlobalVariable Property GameDaysPassed  Auto  
GlobalVariable Property NPCVictimDays  Auto  
GlobalVariable Property NPCVictimActive  Auto 

SexLabFramework Property SexLab  Auto  

ReferenceAlias Property Alias_Alicia  Auto  
ReferenceAlias Property Alias_AliciaDaedric  Auto  

ObjectReference Property AliciaRef  Auto  
ObjectReference Property AliciaDaedricRef  Auto  

Quest Property AliciaKeepClothesOnQuest Auto

Location Property WindhelmArea Auto

Spell Property RaceOrcBerserk Auto
Spell Property Calm Auto
Spell Property Hysteria Auto
Spell Property Mayhem Auto
Spell Property Rally  Auto
Spell Property Stagger  Auto  
Spell Property AliciaDaedricChange  Auto  

Keyword Property ClothKeyword Auto
Keyword Property ArmorKeyword Auto

GlobalVariable Property AliciaInWorld  Auto  
GlobalVariable Property AliciaDaedricInWorld  Auto  

Quest Property BackStoryQuest  Auto  
Quest Property ControlQuest  Auto  

Function UpdateAliciaStats()
	Actor AliciaDaedricActor= AliciaDaedricRef as Actor

	Int iAliciaCutCountValue = AliciaCutCount.Getvalue() as Int
	Float  fAliciaCutCountValue = AliciaCutCount.Getvalue() as Float
	Int iAVMod
	Float  fAVMod

	; Evil Alicia is linked to player level - no need for updates yet

EndFunction

Function CheckAliciaLust()
	Actor AliciaDaedricActor= AliciaDaedricRef as Actor

	Int daysSinceLastVictim
	Int AliciaLustValue = AliciaLustLevel.Getvalue() as Int
	int avHealthLevel = ( AliciaDaedricActor.GetAVPercentage("Health") * 100) as Int
	int sexTrigger = 150 - AliciaLustValue - (100 - avHealthLevel)
	int daedricTrigger

	If !(StorageUtil.HasIntValue(AliciaDaedricActor, "_SD_iRelationshipType"))
		StorageUtil.SetIntValue(AliciaDaedricActor, "_SD_iRelationshipType" , -5 )
	EndIf		

	; Disable orgasm effects when both Alicia and Ali are in Misty Grove
	if (BackstoryQuest.GetStage() == 50) || (BackstoryQuest.GetStage() == 55)
		return
	EndIf
	
	; Debug.Notification( "Health level:" + avHealthLevel )
	; Debug.Notification( "Sex trigger:" + sexTrigger  )
	; Debug.Notification( "." )

	If ( (Utility.RandomInt(0,100)>sexTrigger) && (SexLab.ValidateActor(AliciaDaedricActor) > 0) )
		; Debug.Notification( "Alicia lust:"  + AliciaLustValue)

		; Chance Alicia will turn back into her normal self on orgasm
		daedricTrigger = 10 + (AliciaCutCount.GetValue() as Int) / 100
		if (daedricTrigger > 50)
			daedricTrigger = 50
		EndIf

		; daedricTrigger = 0 ; Testing 
		If ((AliciaLustValue>6000) && (Utility.RandomInt(0,100)>50))
			daedricTrigger = 0
		EndIf

		Debug.Trace( "Alicia twin daedric trigger:"  + daedricTrigger)
		If ((Utility.RandomInt(0,100)>daedricTrigger) && (!AliciaDaedricActor.IsInCombat()))
			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(50,90))

			; Debug.Notification( "Alicia slips away to Oblivion" )
			AliciaDaedricChange.RemoteCast(AliciaDaedricRef , AliciaDaedricActor ,AliciaDaedricRef )
			return
		Else
			; Debug.Notification( "Alicia shudders... still here" )
		EndIf

		int randomNum = Utility.RandomInt(0,100)

		If (randomNum >95)
			AliciaDaedricActor.IgnoreFriendlyHits(false)
			
		ElseIf (randomNum >90)
			If  (SexLab.ValidateActor( SexLab.PlayerRef ) > 0) &&  (SexLab.ValidateActor(AliciaDaedricActor) > 0) 
				Debug.Notification( "Alicia pins you down..." )

				SexLab.QuickStart(SexLab.PlayerRef, AliciaDaedricActor, Victim = SexLab.PlayerRef, AnimationTags = "Aggressive")

			EndIf

			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(20,40))
			AliciaDaedricActor.IgnoreFriendlyHits(true)

		ElseIf (randomNum >80) && (AliciaDaedricActor.IsInCombat())
			Debug.Notification( "Alicia cries out and goes on a rampage..." )
			RaceOrcBerserk.RemoteCast(AliciaDaedricRef , AliciaDaedricActor ,AliciaDaedricRef )

			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(50,90))
			AliciaDaedricActor.IgnoreFriendlyHits(true)

		ElseIf (randomNum >70) && (AliciaDaedricActor.IsInCombat())
			Debug.Notification( "Alicia's screams are terrifying" )
			Hysteria.RemoteCast(AliciaDaedricRef , AliciaDaedricActor ,AliciaDaedricRef )

			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(50,90))
			AliciaDaedricActor.IgnoreFriendlyHits(true)

		ElseIf (randomNum >60) && (AliciaDaedricActor.IsInCombat())
			Debug.Notification( "Alicia's screams cause confusion and chaos around her" )
			Mayhem.RemoteCast(AliciaDaedricRef , AliciaDaedricActor ,AliciaDaedricRef )

			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(50,90))
			AliciaDaedricActor.IgnoreFriendlyHits(true)

		ElseIf (randomNum >50) && (AliciaDaedricActor.IsInCombat())
			Debug.Notification( "Alicia's moans are awe inspiring..." )
			Rally.RemoteCast(AliciaDaedricRef , AliciaDaedricActor ,AliciaDaedricRef )

			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(50,90))
			AliciaDaedricActor.IgnoreFriendlyHits(true)

		ElseIf (randomNum >40)

			if (Utility.RandomInt(0,100)>90)
				If  (SexLab.ValidateActor(AliciaDaedricActor) > 0) 
					Debug.Notification( "Alicia screams in ecstasy..." )

					sslThreadModel Thread = SexLab.NewThread()
					Thread.AddActor(AliciaDaedricActor) ; // IsVictim = true
					Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F","Estrus,Dwemer"))
					Thread.StartThread()
				EndIf
			Else
				Debug.Notification( "Alicia moans..." )
			EndIf

			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(30,60))
			AliciaDaedricActor.IgnoreFriendlyHits(true)

		Else
			Debug.Notification( "Alicia shakes and cries out..." )
			; Calm.RemoteCast(AliciaDaedricRef , AliciaDaedricActor ,AliciaDaedricRef )

			; AliciaDaedricActor.StopCombat()

			; Stagger.RemoteCast(AliciaDaedricRef , AliciaDaedricActor ,AliciaDaedricRef )

			Debug.SendAnimationEvent(AliciaDaedricActor as ObjectReference, "bleedOutStart")
			Utility.Wait(5)
			Debug.SendAnimationEvent(AliciaDaedricActor as ObjectReference, "IdleForceDefaultState")

			; Attempt at bleedout effect - revisit later with solution for duration of bleedout
			If (Utility.RandomInt(0,100)>30)
				AliciaDaedricActor.SetAV("Health", Utility.RandomInt(5,10)) 
			Else
				; AliciaDaedricActor.SetAV("Health", 0) 
			EndIf

			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(50,90))
			AliciaDaedricActor.IgnoreFriendlyHits(true)

		EndIf

		SexLab.ApplyCum(AliciaDaedricActor, 1)
	Else
		; Debug.Notification( "Ali lust:"  + AliciaLustValue)
		; Debug.Notification( "Ali groans .. so close..." )
		; Release ?
		If (Utility.RandomInt(0,100)>30)
			; chance to be pushed over the edge
			AliciaLustLevel.Setvalue(AliciaLustValue + Utility.RandomInt(15,25))
		Else
			; chance of setback
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(15,25))
		EndIf

	EndIf

	; Safety checks
	AliciaLustValue = AliciaLustLevel.Getvalue() as Int

	If (AliciaLustValue>=500)
		; Alicia is sated after forced release from the Rose
		AliciaLustLevel.Setvalue(-100)
	ElseIf  (AliciaLustValue< -200)
		AliciaLustLevel.Setvalue(-200)
	EndIf

	; Chance Alicia will ignore command to stay dressed during combat
	If (Utility.RandomInt(0,100)> (180 - AliciaLustValue) )
		AliciaKeepClothesOn.SetValue(0)
	EndIf

EndFunction

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	; Debug.Trace("Player went to sleep at: " + Utility.GameTimeToString(afSleepStartTime))
	; Debug.Trace("Player wants to wake up at: " + Utility.GameTimeToString(afDesiredSleepEndTime))

	; TO DO: Chance of dream sequence 

	; Debug.Trace("Player went to sleep at: " + Utility.GameTimeToString(afSleepStartTime))
	; Debug.Trace("Player wants to wake up at: " + Utility.GameTimeToString(afDesiredSleepEndTime))

	; If player sleeps in Windhelm and enough time since last victim
	; AND Alicia is enabled
	if ((Game.GetPlayer().GetCurrentLocation() == WindhelmArea) && !(AliciaDaedricREF.IsDisabled())) 

		If (Utility.RandomInt(0,100)>60) && (StorageUtil.GetIntValue(Game.getPlayer(), "_SD_iDisableDreamworldOnSleep") == 0) && ( StorageUtil.GetIntValue(Game.getPlayer(), "_SD_iSanguineBlessings") > 0)
			SendModEvent("SDDreamworldPull")
		EndIf
	EndIf
endEvent

Event OnSleepStop(bool abInterrupted)

	if abInterrupted
	    ; Debug.Trace("Player was woken by something!")
	else
	    ; Debug.Trace("Player woke up naturally")
	endIf

endEvent

Event OnInit()
	Actor AliciaDaedricActor= AliciaDaedricRef as Actor

	AliciaDaedricActor.IgnoreFriendlyHits(true)
	AliciaDaedricActor.AllowBleedoutDialogue(true)
	AliciaDaedricActor.ForceAV("HealRate", 0.1)
	AliciaDaedricActor.unequipall()

	AliciaDaedricInWorld.SetValue(0)

	StorageUtil.SetIntValue(AliciaDaedricActor, "_SD_iCanBeStripped", -1)

	AliciaDaedricActor.SetAv("WaitingForPlayer", 1) 
	;follower will wait 3 days
	Alias_AliciaDaedric.RegisterForUpdateGameTime(72)	

	; Debug.Notification( "Ali is initialized...")
	; Register for when the player goes to sleep and wakes up
	RegisterForSleep()
EndEvent

Event OnUpdateGameTime()

	;kill the update if the follower isn't waiting anymore
	If Self.GetActorRef().GetAv("WaitingforPlayer") == 0
		UnRegisterForUpdateGameTime()
	Else
; 		debug.trace(self + "Dismissing the follower because he is waiting and 3 days have passed.")
		DialogueFollower.DismissFollower(5)

		AliciaCutCount.Setvalue( 0 )
		AliciaCutGameDaysPassed.Setvalue( Game.QueryStat("Days Passed") )

		; Add teleport home?

		UnRegisterForUpdateGameTime()
	EndIf	
	
EndEvent

Event OnUnload()

	;if follower unloads while waiting for the player, wait three days then dismiss him.
	If Self.GetActorRef().GetAv("WaitingforPlayer") == 1
		(GetOwningQuest() as DialogueFollowerScript).FollowerWait()
	EndIf

EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	Actor AliciaDaedricActor= AliciaDaedricRef as Actor
	Int AliciaLustValue = AliciaLustLevel.Getvalue() as Int

	If (akTarget == Game.GetPlayer())

		; SexLab Alicia: Use this to add bonus on friendly fire

		; 	debug.trace(self + "Dismissing follower because he is now attacking the player")

		; Debug.Notification( "Alicia gasps...")
		; Debug.Notification( "Alicia lust:"  + AliciaLustValue)

	    if (aeCombatState == 0)
	      	; Debug.Trace("We have left combat with the player!")

			; Chance of disappointment on combat stop
			If (Utility.RandomInt(0,100)>80)
				; Variable decrease in lust
				AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(10,20))
			EndIf
	    elseif (aeCombatState == 1)
	      	; Debug.Trace("We have entered combat with the player!")

			; Chance of lust on combat start
			If (Utility.RandomInt(0,100)>20)
				; Variable increase in lust
				AliciaLustLevel.Setvalue(AliciaLustValue + Utility.RandomInt(5,10))

				CheckAliciaLust()
			EndIf

	    elseif (aeCombatState == 2)
	      	; Debug.Trace("We are searching for the player...")

			; Chance of lust on search
			If (Utility.RandomInt(0,100)>50)
				; Variable increase in lust
				AliciaLustLevel.Setvalue(AliciaLustValue + Utility.RandomInt(1,5))
			EndIf

	    endIf
	Else
	    if (aeCombatState == 0)
	      	; Debug.Trace("We have left combat with the NPC!")

			; Chance of disappointment on combat stop
			If (Utility.RandomInt(0,100)>80)
				; Variable decrease in lust
				AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(10,20))

			EndIf
			; Check for release
			If (Utility.RandomInt(0,100)>50)
				CheckAliciaLust()
			EndIf

	    elseif (aeCombatState == 1)
	      	; Debug.Trace("We have entered combat with the NPC!")
			; Update stats for this combat

			 UpdateAliciaStats()

	    EndIf
	EndIf


EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	Actor AliciaDaedricActor= AliciaDaedricRef as Actor
	Actor kPlayer = Game.GetPlayer()

	Float GameDaysPassedValue = GameDaysPassed.Getvalue() as Float
	Float  AliciaCutGameDaysPassedValue = AliciaCutGameDaysPassed.Getvalue() as Float
	Int AliciaLustValue = AliciaLustLevel.Getvalue() as Int
	Int AliciaCutCountValue = AliciaCutCount.Getvalue() as Int
	Int daysSinceLastBeating

	If (akAggressor == Game.GetPlayer())
		Weapon wSourceWeapon = akSource as Weapon
		Keyword kwControlRod = Keyword.GetKeyword("_Alicia_ControlRod")
		if(wSourceWeapon && wSourceWeapon.HasKeyword(kwControlRod))
		  	Debug.Notification("[Alicia] Control rod is used on Daedric Alicia")
			AliciaLustLevel.Setvalue(10000)
		 
		  	; Debug.Trace("Magic effect was started on " + akTarget)
			; StorageUtil.SetIntValue(Game.GetPlayer(), "Puppet_SpellON", 1)
			StorageUtil.SetIntValue(kPlayer, "Puppet_CastTarget", 1)
			StorageUtil.SetFormValue(kPlayer, "Puppet_NewTarget", AliciaDaedricActor)
		endif
		; SexLab Alicia: Use this to add bonus on friendly fire

		; debug.trace(self + "Dismissing follower because he is now attacking the player")
		Int AliciaLustValueIncrement = 1 +  ((abPowerAttack as Int) * Utility.RandomInt(1,6) ) + ((abSneakAttack as Int)  * Utility.RandomInt(2,8) ) + ((abBashAttack as Int)  * Utility.RandomInt(1,5) ) - ((abHitBlocked as Int)  * Utility.RandomInt(3,10) )

		; Debug.Notification( "Alicia lust:"  + AliciaLustValue)
		; Debug.Notification( "Alicia cuts count:"  + AliciaCutCountValue )

		; Progression of Lust is slower when she wears armor
		if  ((AliciaDaedricActor.WornHasKeyword(ClothKeyword)) || (AliciaDaedricActor.WornHasKeyword(ArmorKeyword)))
			AliciaLustValueIncrement = AliciaLustValueIncrement / 2
		EndIf

		; Chance of lust on combat
		If (Utility.RandomInt(0,100)>60)
			; Debug.Notification( "Alicia mewls in pain")
			; Variable increase in lust
			AliciaLustLevel.Mod ( AliciaLustValueIncrement )

			CheckAliciaLust()
		EndIf

		; Change of wake up if hit by Master
		If ( (AliciaDaedricActor.IsUnconscious())  || (AliciaDaedricActor.IsBleedingOut()) ) && (Utility.RandomInt(0,100)>60)
			AliciaDaedricActor.RestoreAV("Health", Utility.RandomInt(5,10)) 
		EndIf

 		; compare to previous day count - if difference >0 reduce number of cut counts
		If (AliciaCutGameDaysPassedValue  == 0) 
			AliciaCutGameDaysPassedValue = Game.QueryStat("Days Passed") ; GameDaysPassedValue  
		EndIf

		daysSinceLastBeating = (Game.QueryStat("Days Passed") - AliciaCutGameDaysPassedValue ) as Int
		AliciaCutGameDaysDiff.SetValue(daysSinceLastBeating) 


		; Debug.Notification("GameDaysDiff:" + daysSinceLastBeating )

		AliciaCutCountValue = AliciaCutCountValue + 1 - ( daysSinceLastBeating * Utility.RandomInt(10,30) )

		If (AliciaCutCountValue  < 0)
			AliciaCutCountValue = 0
		EndIf

		AliciaCutCount.Setvalue(AliciaCutCountValue  )

		AliciaCutGameDaysPassed.Setvalue( GameDaysPassed.Getvalue() )

	ElseIf (akAggressor != None)
		;  Debug.Trace("We were hit by " + akAggressor)

		If (Utility.RandomInt(0,100)>60)
			Debug.Notification( "Alicia moans in pain")
			; Variable increase in lust

			; Progression of Lust is slower when she wears armor
			if  ((AliciaDaedricActor.WornHasKeyword(ClothKeyword)) || (AliciaDaedricActor.WornHasKeyword(ArmorKeyword)))
				AliciaLustLevel.Setvalue(AliciaLustValue + 1 )
			Else
				AliciaLustLevel.Setvalue(AliciaLustValue + 2 )
			EndIf
		EndIf
	EndIf

EndEvent


Event OnDeath(Actor akKiller)

; 	debug.trace(self + "Clearing the follower because the player killed him.")
	CheckAliciaLust()
	
EndEvent

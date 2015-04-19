Scriptname Alicia_AliasFollower extends ReferenceAlias  

DialogueFollowerScript Property DialogueFollower Auto

GlobalVariable Property AliciaLustLevel  Auto  
GlobalVariable Property AliciaCutCount  Auto  
GlobalVariable Property AliciaCutGameDaysPassed  Auto  
GlobalVariable Property AliciaCutGameDaysDiff  Auto  
GlobalVariable Property AliciaKeepClothesOn  Auto  
GlobalVariable Property IsAliciaKneeling Auto

GlobalVariable Property PlayerFollowerCount  Auto  
GlobalVariable Property GameDaysPassed  Auto  
GlobalVariable Property NPCVictimDays  Auto  
GlobalVariable Property NPCVictimActive  Auto 

Actor Property AliciaNPCVictim  Auto  

SexLabFramework Property SexLab  Auto  
ReferenceAlias Property Alias_Alicia  Auto  
ReferenceAlias Property Alias_AliciaDaedric  Auto  

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
	Actor AliciaActor= Alias_Alicia.GetReference() as Actor

	Int iAliciaCutCountValue = AliciaCutCount.Getvalue() as Int
	Float  fAliciaCutCountValue = AliciaCutCount.Getvalue() as Float
	Int iAVMod
	Float  fAVMod

	if (BackstoryQuest.GetStage() != 50) && (BackstoryQuest.GetStage() != 55)
		Debug.Trace(":: Alicia stats -------" )
		Debug.Trace("Cut count:" + iAliciaCutCountValue )

		; calculate modified AV for health, stamina, onehanded, lightarmor, HealRate, attackDamageMult, MeleeDamage, DamageResist, ElectricResist,CritChance
		iAVMod = 10 + (iAliciaCutCountValue / 10)  + ((Game.GetPlayer().GetBaseAV("Health") as Int) * 3 / 4) 

		If (iAVMod < 300)
			AliciaActor.ForceAV("Health", iAVMod)
			AliciaActor.ForceAV("Stamina", iAVMod)
		Else 
			AliciaActor.ForceAV("Health", 300)
			AliciaActor.ForceAV("Stamina", 300)
		EndIf

		Debug.Trace("iAVMod:" + iAVMod)
		Debug.Trace("Health:" + AliciaActor.GetBaseAV("Health"))

		iAVMod = 10 + (iAliciaCutCountValue / 40) + ((Game.GetPlayer().GetBaseAV("OneHanded") as Int) * 3 / 4) 

		If (iAVMod < 60)
			AliciaActor.ForceAV("OneHanded", iAVMod)
			AliciaActor.ForceAV("LightArmor", iAVMod)
		Else 
			AliciaActor.ForceAV("OneHanded", 60)
			AliciaActor.ForceAV("LightArmor", 60)
		EndIf

		Debug.Trace("iAVMod:" + iAVMod)
		Debug.Trace("OneHanded:" + AliciaActor.GetBaseAV("OneHanded"))

		fAVMod = 0.1 + ( 0.1 *  (fAliciaCutCountValue  / 100.0) )

		If (fAVMod < 1)
			AliciaActor.ForceAV("HealRate", fAVMod )
		Else 
			AliciaActor.ForceAV("HealRate", 1)
		EndIf

		Debug.Trace("fAVMod:" + fAVMod)
		Debug.Trace("HealRate:" + AliciaActor.GetAV("HealRate"))

	EndIf
EndFunction

Function CheckAliciaLust()
	Actor AliciaActor= Alias_Alicia.GetReference() as Actor
	ObjectReference AliciaRef = Alias_Alicia.GetReference()

	Int daysSinceLastVictim
	Int AliciaLustValue = AliciaLustLevel.Getvalue() as Int
	int avHealthLevel = ( AliciaActor.GetAVPercentage("Health") * 100) as Int
	int sexTrigger = 150 - AliciaLustValue - (100 - avHealthLevel)
	int daedricTrigger

	; Disable orgasm effects when both Alicia and Ali are in Misty Grove
	if (BackstoryQuest.GetStage() == 50) || (BackstoryQuest.GetStage() == 55)
		return
	EndIf

	; Debug.Notification( "Health level:" + avHealthLevel )
	; Debug.Notification( "Sex trigger:" + sexTrigger  )
	; Debug.Notification( "." )

	If ( (Utility.RandomInt(0,100)>sexTrigger) && (SexLab.ValidateActor(AliciaActor) > 0) )
		; Debug.Notification( "Alicia lust:"  + AliciaLustValue)

		; Chance Alicia will turn into her evil twin on orgasm
		daedricTrigger = 90 - (AliciaCutCount.GetValue() as Int) / 100
		if (daedricTrigger < 50)
			daedricTrigger = 50
		EndIf

		; daedricTrigger = 0 ; Testing 
		If ((AliciaLustValue>6000) && (Utility.RandomInt(0,100)>50))
			daedricTrigger = 0
		EndIf

		Debug.Trace( "Alicia daedric trigger:"  + daedricTrigger)
		If ((Utility.RandomInt(0,100)>daedricTrigger) && (!AliciaActor.IsInCombat()))
			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(50,90))

			; Debug.Notification( "Alicia slips away to Oblivion" )
			AliciaDaedricChange.RemoteCast(AliciaREF , AliciaActor ,AliciaREF )
			return
		Else
			; Debug.Notification( "Alicia shudders... still here" )
		EndIf

		int randomNum = Utility.RandomInt(0,100)

		If (randomNum >95)
			AliciaActor.IgnoreFriendlyHits(false)

		ElseIf (randomNum >90)

			If  (SexLab.ValidateActor( SexLab.PlayerRef ) > 0) &&  (SexLab.ValidateActor(AliciaActor) > 0) 
				Debug.Notification( "Alicia collapses and begs for release..." )

				SexLab.QuickStart(AliciaActor, SexLab.PlayerRef,  AnimationTags = "Aggressive")

			EndIf

			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(20,40))
			AliciaActor.IgnoreFriendlyHits(true)

		ElseIf (randomNum >80) && (AliciaActor.IsInCombat())
			Debug.Notification( "Alicia cries out and goes on a rampage..." )
			RaceOrcBerserk.RemoteCast(AliciaRef , AliciaActor ,AliciaRef )

			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(50,90))
			AliciaActor.IgnoreFriendlyHits(true)

		ElseIf (randomNum >70) && (AliciaActor.IsInCombat())
			Debug.Notification( "Alicia's screams are terrifying" )
			Hysteria.RemoteCast(AliciaRef , AliciaActor ,AliciaRef )

			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(50,90))
			AliciaActor.IgnoreFriendlyHits(true)

		ElseIf (randomNum >60) && (AliciaActor.IsInCombat())
			Debug.Notification( "Alicia's screams cause confusion and chaos around her" )
			Mayhem.RemoteCast(AliciaRef , AliciaActor ,AliciaRef )

			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(50,90))
			AliciaActor.IgnoreFriendlyHits(true)

		ElseIf (randomNum >55) && (AliciaActor.IsInCombat())
			Debug.Notification( "Alicia's moans are awe inspiring..." )
			Rally.RemoteCast(AliciaRef , AliciaActor ,AliciaRef )

			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(50,90))
			AliciaActor.IgnoreFriendlyHits(true)

		ElseIf (randomNum >40)

			if ((Utility.RandomInt(0,100)>60)  && !((AliciaActor.WornHasKeyword(ClothKeyword)) || (AliciaActor.WornHasKeyword(ArmorKeyword))) )
				Debug.Notification( "Alicia screams in ecstasy..." )
				If  (SexLab.ValidateActor(AliciaActor) > 0) 

					sslThreadModel Thread = SexLab.NewThread()
					Thread.AddActor(AliciaActor) ; // IsVictim = true
					Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F","Estrus,Dwemer"))
					Thread.StartThread()

				EndIf
			Else
				Debug.Notification( "Alicia moans..." )
			EndIf

			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(30,60))
			AliciaActor.IgnoreFriendlyHits(true)

		Else
			Debug.Notification( "Alicia shakes and cries out..." )
			; Calm.RemoteCast(AliciaRef , AliciaActor ,AliciaRef )

			; AliciaActor.StopCombat()

			; Stagger.RemoteCast(AliciaRef , AliciaActor ,AliciaRef )

			Debug.SendAnimationEvent(AliciaActor as ObjectReference, "bleedOutStart")
			Utility.Wait(5)
			Debug.SendAnimationEvent(AliciaActor as ObjectReference, "IdleForceDefaultState")

			; Attempt at bleedout effect - revisit later with solution for duration of bleedout
			If (Utility.RandomInt(0,100)>30)
				AliciaActor.SetAV("Health", Utility.RandomInt(5,10)) 
			Else
				; AliciaActor.SetAV("Health", 0) 
			EndIf

			; Chance Alicia will ignore command to stay dressed during combat
			If (Utility.RandomInt(0,100)> 90 )
				AliciaKeepClothesOn.SetValue(0)
			EndIf

			; Release
			AliciaLustLevel.Setvalue(AliciaLustValue - Utility.RandomInt(50,90))
			AliciaActor.IgnoreFriendlyHits(true)

		EndIf

		SexLab.ApplyCum(AliciaActor, 1)
	Else
		; Debug.Notification( "Alicia lust:"  + AliciaLustValue)
		; Debug.Notification( "Alicia groans .. so close..." )
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




EndFunction

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	ObjectReference AliciaREF = Alias_Alicia.GetReference()
	; Debug.Trace("Player went to sleep at: " + Utility.GameTimeToString(afSleepStartTime))
	; Debug.Trace("Player wants to wake up at: " + Utility.GameTimeToString(afDesiredSleepEndTime))

	; If player sleeps in Windhelm and enough time since last victim
	; AND Alicia is enabled
	if ((Game.GetPlayer().GetCurrentLocation() == WindhelmArea) && ( !(AliciaREF.IsDisabled())) && (NPCVictimActive.GetValue()==0))
		NPCVictimActive.SetValue(1)
	EndIf
endEvent

Event OnSleepStop(bool abInterrupted)
	ObjectReference AliciaREF = Alias_Alicia.GetReference()

	if abInterrupted
	    ; Debug.Trace("Player was woken by something!")
	else
	    ; Debug.Trace("Player woke up naturally")
	endIf

	if ((Game.GetPlayer().GetCurrentLocation() == WindhelmArea) && ( !(AliciaREF.IsDisabled())) && (NPCVictimActive.GetValue()==1) && (!AliciaNPCVictim.IsDead()))
		IsAliciaKneeling.Setvalue(0)
	   	Debug.SendAnimationEvent(AliciaREF, "IdleForceDefaultState")
		Debug.MessageBox("Alicia brought you a present")
	EndIf
endEvent

Event OnInit()
	ObjectReference AliciaREF = Alias_Alicia.GetReference()
	Actor AliciaActor= AliciaREF as Actor

	AliciaActor.IgnoreFriendlyHits(true)
	AliciaActor.AllowBleedoutDialogue(true)
	AliciaActor.ForceAV("HealRate", 0.1)
	AliciaActor.unequipall()

	AliciaInWorld.SetValue(1)

	AliciaActor.SetAv("WaitingForPlayer", 1) 
	;follower will wait 3 days
	Alias_Alicia.RegisterForUpdateGameTime(72)

	; Debug.Notification( "Alicia is initialized...")

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
	Actor AliciaActor= Alias_Alicia.GetReference() as Actor
	Int AliciaLustValue = AliciaLustLevel.Getvalue() as Int
	Int undressTrigger

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

			; Chance of undressing before combat
			If ((Utility.RandomInt(0,100)>60) && ((AliciaActor.WornHasKeyword(ClothKeyword)) || (AliciaActor.WornHasKeyword(ArmorKeyword))) )
				; AliciaActor.unequipall()
				form[] FemaleEquipment = SexLab.StripActor(AliciaActor)
			EndIf

			; Chance of triggering 00AliciaKeepclotheson quest topics
			undressTrigger = 90 - (AliciaCutCount.GetValue() as Int) / 100
			if (undressTrigger < 70)
				undressTrigger = 70
			EndIf

			If (Utility.RandomInt(0,100)>undressTrigger)
				
				If (AliciaKeepClothesOnQuest.GetStage()!= 10)
          				AliciaKeepClothesOnQuest.Start()
					Utility.Wait(1)
          				AliciaKeepClothesOnQuest.SetStage(10)
				EndIf
			EndIf

	    EndIf
	EndIf


EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	Actor AliciaActor= Alias_Alicia.GetReference() as Actor

	Float GameDaysPassedValue = GameDaysPassed.Getvalue() as Float
	Float  AliciaCutGameDaysPassedValue = AliciaCutGameDaysPassed.Getvalue() as Float
	Int AliciaLustValue = AliciaLustLevel.Getvalue() as Int
	Int AliciaCutCountValue = AliciaCutCount.Getvalue() as Int
	Int daysSinceLastBeating

	If (akAggressor == Game.GetPlayer())

		; SexLab Alicia: Use this to add bonus on friendly fire

		; debug.trace(self + "Dismissing follower because he is now attacking the player")
		Int AliciaLustValueIncrement = 1 +  ((abPowerAttack as Int) * Utility.RandomInt(1,6) ) + ((abSneakAttack as Int)  * Utility.RandomInt(2,8) ) + ((abBashAttack as Int)  * Utility.RandomInt(1,5) ) - ((abHitBlocked as Int)  * Utility.RandomInt(3,10) )

		; Debug.Notification( "Alicia lust:"  + AliciaLustValue)
		; Debug.Notification( "Alicia cuts count:"  + AliciaCutCountValue )

		; Progression of Lust is slower when she wears armor
		if  ((AliciaActor.WornHasKeyword(ClothKeyword)) || (AliciaActor.WornHasKeyword(ArmorKeyword)))
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
		If ( (AliciaActor.IsUnconscious())  || (AliciaActor.IsBleedingOut()) ) && (Utility.RandomInt(0,100)>60)
			AliciaActor.RestoreAV("Health", Utility.RandomInt(5,10)) 
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
			if  ((AliciaActor.WornHasKeyword(ClothKeyword)) || (AliciaActor.WornHasKeyword(ArmorKeyword)))
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



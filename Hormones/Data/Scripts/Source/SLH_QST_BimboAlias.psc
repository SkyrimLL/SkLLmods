Scriptname SLH_QST_BimboAlias extends ReferenceAlias  

SLH_fctPolymorph Property fctPolymorph Auto
SLH_fctBodyshape Property fctBodyshape Auto
SLH_fctUtil Property fctUtil Auto
SLH_fctColor Property fctColor Auto
SLH_QST_HormoneGrowth Property SLH_Control Auto

slaUtilScr Property slaUtil  Auto  
SexLabFramework Property SexLab  Auto  

Quest Property _SLH_QST_Bimbo  Auto  

GlobalVariable      Property GV_isTG                   Auto
GlobalVariable      Property GV_isHRT                   Auto
GlobalVariable      Property GV_isBimbo                 Auto
GlobalVariable      Property GV_allowTG                Auto
GlobalVariable      Property GV_allowHRT                Auto
GlobalVariable      Property GV_allowBimbo              Auto
GlobalVariable      Property GV_hornyBegArousal              Auto

GlobalVariable      Property GV_bimboClumsinessMod              Auto
GlobalVariable      Property GV_bimboClumsinessDrop    	Auto

Weapon Property ReturnItem Auto

ReferenceAlias Property BimboAliasRef  Auto  
Actor BimboActor 

int iGameDateLastCheck
int daysSinceEnslavement
int iDaysSinceLastCheck
int iDaysPassed


Float fRFSU = 0.1
Bool isUpdating = False

Bool isMale 
Bool isMaleToBimbo
Float fSchlongMin
Float fSchlongMax

;===========================================================================
;mod variables
Race Property _SLH_BimboRace Auto
Int bimboClumsyBuffer = 0
Bool isBimboClumsyLegs = false
Bool isBimboClumsyHands = false
Bool isBimboFrailBody = false
Bool isClumsyHandsRegistered = False
Bool isClumsyLegsRegistered = False
;===========================================================================

;how much gold hypnosis victim earns each day
Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	; Safeguard - Exit if alias not set
	if (Game.GetPlayer().GetActorBase().GetRace() != _SLH_BimboRace)
		Return
	Endif

	BimboActor= BimboAliasRef.GetReference() as Actor

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == 0)
		Return
	Endif

	; debug.Notification("[SLH] Bimbo changing location")
	; if (!isUpdating)
    	RegisterForSingleUpdate( fRFSU )
    ; endif
endEvent

;===========================================================================
;Hack! Recover lost saves where the tf was done on day zero
;===========================================================================
Event OnPlayerLoadGame()
	; if (!isUpdating)
		debug.trace("[slh+] game loaded, registering for update")
		if Game.GetPlayer().GetActorBase().GetRace() == _SLH_BimboRace && StorageUtil.GetIntValue(Game.GetPlayer(), "_SLH_bimboTransformDate") == 0
			StorageUtil.SetIntValue(Game.GetPlayer(), "_SLH_bimboTransformDate", 1)
			debug.trace("[slh+] poor bimbo, are you lost?")
		endif

		isMaleToBimbo =  StorageUtil.GetIntValue(none, "_SLH_bimboIsOriginalActorMale") as Bool

    	RegisterForSingleUpdate( 10 )
    ; else
	; 	debug.trace("[slh+] game loaded, is already updating (is it?)")
    ; endif
EndEvent

;===========================================================================
;[mod] stumbling happens here
;===========================================================================
Event OnUpdateGameTime()
	; Safeguard - Exit if alias not set
	if (Game.GetPlayer().GetActorBase().GetRace() != _SLH_BimboRace)
		; try again later
    	RegisterForSingleUpdate( 10 )
		Return
	Endif
	; debug.Notification("[SLH] Bimbo update game time")

	BimboActor= BimboAliasRef.GetReference() as Actor

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == 0)
		Return
	Endif

	if (isBimboClumsyLegs)
    	clumsyBimboLegs(BimboActor)
    	RegisterForSingleUpdateGameTime(0.03)
    endif
EndEvent

Event OnActorAction(int actionType, Actor akActor, Form source, int slot)
	; Safeguard - Exit if alias not set
	if (Game.GetPlayer().GetActorBase().GetRace() != _SLH_BimboRace)
		;debug.trace("[slh+] bimbo OnActorAction, None")
		Return
	Endif

	BimboActor= BimboAliasRef.GetReference() as Actor

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == 0)
		Return
	Endif

	if (akActor == BimboActor)
		clumsyBimboHands(actionType, akActor, source, slot)
	EndIf
EndEvent

Event OnUpdate()
	; Safeguard - Exit if alias not set

	if (Game.GetPlayer().GetActorBase().GetRace() != _SLH_BimboRace)
		; Debug.Notification( "[SLH] Bimbo status update: " + StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") as Int )
		Debug.Trace( "[SLH] Bimbo alias is None: " )
		; try again later
    	RegisterForSingleUpdate( 10 )
		Return
	Endif

	isUpdating = True
	; debug.Notification(".")

	BimboActor= BimboAliasRef.GetReference() as Actor

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == 0)
		; debug.trace("[slh+] bimbo OnUpdate, No TF Date")
		Return
	Endif

	if ((GV_hornyBegArousal.GetValue() as Int) > 80)
		GV_hornyBegArousal.SetValue(80)
	endif

    iDaysPassed = Game.QueryStat("Days Passed")

    
    StorageUtil.SetIntValue(BimboActor, "_SLH_bimboTransformGameDays", iDaysPassed - (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") as Int ))    

    daysSinceEnslavement = StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformGameDays")


    if (iGameDateLastCheck == -1)
        iGameDateLastCheck = iDaysPassed
    EndIf

    iDaysSinceLastCheck = (iDaysPassed - iGameDateLastCheck ) as Int
       
    ; Debug.Notification( "[SLH] Bimbo status update - Days: " + daysSinceEnslavement )
    ; Debug.Notification( "[SLH] iDaysSinceLastCheck: " + iDaysSinceLastCheck )

    ; Exit conditions
    If (iDaysSinceLastCheck >= 1)
        Debug.Trace( "[SLH] Bimbo status update - Days transformed: " + daysSinceEnslavement )
        isMale = fctUtil.isMale(BimboActor)
        fSchlongMin = StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlongMin")
        fSchlongMax = StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlongMax")

    ;     BimboActor.AddItem(ReturnItem, 1 , True)

        ; StorageUtil.SetFloatValue(BimboActor, "_SLH_fBreast", 0.8 ) 
        ; StorageUtil.SetFloatValue(BimboActor, "_SLH_fBelly", 0.8 ) 
        ; StorageUtil.SetFloatValue(BimboActor, "_SLH_fWeight", 0 ) 
        ; If (GV_isTG.GetValue() == 1) && (!isMale) && (daysSinceEnslavement==1)
        ;    _SLH_QST_Bimbo.SetStage(14)
        ; ElseIf (GV_isTG.GetValue() == 1) && (isMale) && (daysSinceEnslavement==1)
        ;    _SLH_QST_Bimbo.SetStage(12)
        ; Endif

        ;[mod] progressive tf - start
        ; if (daysSinceEnslavement<=5) ; !(_SLH_QST_Bimbo.IsStageDone(18) || _SLH_QST_Bimbo.IsStageDone(16) )
        	bimboDailyProgressiveTransformation(BimboActor, GV_isTG.GetValue() == 1)
        ; endif
        ;[mod] progressive tf - end

        If (isMaleToBimbo) && (daysSinceEnslavement<=6) ; !_SLH_QST_Bimbo.IsStageDone(18) 
            fctBodyshape.alterBodyByPercent(BimboActor, "Weight", 50.0)
            fctBodyshape.alterBodyByPercent(BimboActor, "Breast", 50.0)

            ; Male to female bimbo
            if (daysSinceEnslavement==1)
            	debug.messagebox("Your boobs are growing larger every day. You find it more and more difficult to resist cupping them and feeling their weight in your hand. If they grow any larger, they will make using bows and armors a lot more difficult. That's alright though.. bimbos don't need to fight. They get others to fight for the right to use them.")
            elseif (daysSinceEnslavement==2)
            	debug.messagebox("Your lips are full and feel parched if they are not frequently coated with semen. Who knew semen tasted so good. A good bimbo doesn't let a drop go to waste. It has to land on her or better, deep inside.")
            elseif (daysSinceEnslavement==3)
            	debug.messagebox("Your cock is shrinking and getting more sensitive every day. Squeezing your legs and rubbing it frequently only provide temporary relief and wets your expanding vagina. Don't worry about your cock little bimbo... you will get plenty of cocks to squeeze.")
            elseif (daysSinceEnslavement==4)
            	debug.messagebox("Everything around you looks so confusing and difficult. Except for sex. Sex is easy and fun. Being horny makes your hand shake and your legs weak with anticipation. Being a slut is one of the many perks of being a bimbo.")
            endif
        	
            if (GV_isTG.GetValue() == 1) && (StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlong") >= fSchlongMin ) && ( daysSinceEnslavement < 5 )
                ; StorageUtil.SetFloatValue(BimboActor, "_SLH_fSchlong", StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlong") * 0.65 - 0.1) 
                fctBodyshape.alterBodyByPercent(BimboActor, "Schlong", -30.0)
                BimboActor.SendModEvent("SLHRefresh")

            elseIf (GV_isTG.GetValue() == 1) && (daysSinceEnslavement >= 5 )
                BimboActor.SendModEvent("SLHRemoveSchlong")
                Sexlab.TreatAsFemale(BimboActor)
                _SLH_QST_Bimbo.SetStage(18)

                SLH_Control.setTGState(BimboActor, FALSE)
            endif

        ElseIf (!isMaleToBimbo) && (daysSinceEnslavement<=6) ; !_SLH_QST_Bimbo.IsStageDone(16) 
 
            fctBodyshape.alterBodyByPercent(BimboActor, "Weight", 50.0)
            fctBodyshape.alterBodyByPercent(BimboActor, "Breast", 50.0)

            ; Female to female bimbo
            if (daysSinceEnslavement==1)
            	debug.messagebox("Your boobs are growing larger every day and your hair is definitely blonde now. Forget about wearing armor and using bows, you will soon have to rely on your charms to get a strong warrior to fight for you... maybe he will give you a good fuck too.")
            elseif (daysSinceEnslavement==2)
            	debug.messagebox("The constant tingle in your tits is only relieved after they have been sucked on for a long time, or tweaked.. or pinched with your long pink nails. Damn.. just thinking about it made them tingle again.")
            elseif (daysSinceEnslavement==3)
            	debug.messagebox("Forget about using swords as well. You constantly crave only one kind of sword now... the hard and throbbing kind. There is nothing a good bimbo wouldn't do for a good cock in her hand.. or lips.. or loged deep inside her.")
            elseif (daysSinceEnslavement==4)
            	debug.messagebox("Sex is all you can think about now.. you crave it.. your tits crave it.. you lips crave it. Being horny makes your hand shake and your legs weak with anticipation. Being a slut is one of the many perks of being a bimbo.")
            endif
  
            ; bimboDailyProgressiveTransformation(BimboActor, true) ;[mod]
            if (GV_isTG.GetValue() == 1) && (StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlong") <= fSchlongMax )  && ( daysSinceEnslavement < 5 )
                ; StorageUtil.SetFloatValue(BimboActor, "_SLH_fSchlong", 0.1 + StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlong") * 1.2 ) 
                fctBodyshape.alterBodyByPercent(BimboActor, "Schlong", -30.0)
                BimboActor.SendModEvent("SLHRefresh")

            elseif (GV_isTG.GetValue() == 1) && (daysSinceEnslavement >= 5 )
                _SLH_QST_Bimbo.SetStage(16)

                SLH_Control.setTGState(BimboActor, FALSE)
            endif

        endif

        iGameDateLastCheck = iDaysPassed

    Endif

    If (StorageUtil.GetIntValue(BimboActor, "_SD_iSlaveryLevel") != 6)
        StorageUtil.SetIntValue(BimboActor, "_SD_iSlaveryExposure", 150)
        StorageUtil.SetIntValue(BimboActor, "_SD_iSlaveryLevel", 6)
    EndIf
        
    If (StorageUtil.GetIntValue(BimboActor, "_SD_iDom") != 0)
        StorageUtil.SetIntValue(BimboActor, "_SD_iDom", 0)
    EndIf

    updateClumsyBimbo() ;[mod] clumsy bimbo
    isUpdating = false
    ;RegisterForSingleUpdate( fRFSU )
    RegisterForSingleUpdate( fRFSU * 2 ) ;performance
	;debug.trace("[slh+] bimbo OnUpdate, Done")
EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	; Safeguard - Exit if alias not set
	if (Game.GetPlayer().GetActorBase().GetRace() != _SLH_BimboRace)
		Return
	Endif

	BimboActor= BimboAliasRef.GetReference() as Actor

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == 0)
		Return
	Endif
	
	; debug.Notification("[SLH] Bimbo in combat")

	If (akTarget == BimboActor)

	    if (aeCombatState == 0)
	      	; Debug.Trace("We have left combat with the player!")

	    elseif (aeCombatState == 1)
	      	; Debug.Trace("We have entered combat with the player!")

	    elseif (aeCombatState == 2)
	      	; Debug.Trace("We are searching for the player...")

	    endIf
	Else
	    if (aeCombatState == 0)
	      	; Debug.Trace("We have left combat with the NPC!")
			;
			If (BimboActor.IsUnconscious())
			;	BimboActor.SetUnconscious(false)
			EndIf	
	    elseif (aeCombatState == 1)
	      	; Debug.Trace("We have entered combat with the NPC!")

			; BimboActor.SetActorValue("Aggression", 1.0)
			; BimboActor.SetActorValue("Confidence", 3.0)
			; BimboActor.SetActorValue("Assistance", 2.0)

			; If (BimboActor.GetActorValue("Confidence") <= 1) ; NPC still a coward
			; 	CourageSpell.Cast(Game.GetPlayer(),akActorREF)
			; EndIf

			; Debug.Notification("Actor: " + BimboActor)
			; Debug.Notification("Aggression: " + BimboActor.GetActorValue("Aggression"))
			; Debug.Notification("Confidence: " + BimboActor.GetActorValue("Confidence"))
			; Debug.Notification("Assistance: " + BimboActor.GetActorValue("Assistance"))

	    EndIf
	EndIf


EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	; Safeguard - Exit if alias not set
	if (Game.GetPlayer().GetActorBase().GetRace() != _SLH_BimboRace)
		Return
	Endif

	BimboActor= BimboAliasRef.GetReference() as Actor

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == 0)
		Return
	Endif
	
	If (akAggressor == BimboActor)
		;
		; If (BimboActor.IsUnconscious())
		;	BimboActor.SetUnconscious(false)
		; EndIf	


	ElseIf (akAggressor != None && isBimboFrailBody) ;[mod] check if is a weak bimbo
		;  Debug.Trace("We were hit by " + akAggressor)
		; debug.Notification("[SLH] Bimbo is hit")
      	;If ((randomNum>90) && (BimboActor.GetActorValuePercentage("health")<0.3)) ; && (!(akAggressor as Actor).IsInFaction(pCreatureFaction)))

		float bimboArousal = slaUtil.GetActorArousal(BimboActor) as float
		float dropchance = 1.0 + (bimboArousal / 30.0 ) * (GV_bimboClumsinessMod.GetValue() as Float)
		; Debug.Trace("[slh+] bimbo beeing hit, drop chance: " + dropchance)
      	If Utility.RandomInt() <= dropchance ; && (!(akAggressor as Actor).IsInFaction(pCreatureFaction)))
				;

			Debug.Notification("The enemy made you lose your grip!")
			Debug.Notification("They are so mean hitting you like that!")
			dropWeapons(BimboActor, both = false, chanceMult = 1.0) ;only the weapon
		    ;if(BimboActor.IsWeaponDrawn())
		    ;    BimboActor.SheatheWeapon()
		    ;    Utility.Wait(2.0)
		    ;endif

		    ; unequip weapons
		    ;Weapon wleft = BimboActor.GetEquippedWeapon(0)
		    ;Weapon wright = BimboActor.GetEquippedWeapon(1)
		    ;if (wleft != None)
		    ;    BimboActor.UnequipItem(wleft, 0)
		    ;endif
		    ;if (wright != None)
		    ;    BimboActor.UnequipItem(wright, 1)
		    ;endif

		EndIf



	EndIf

EndEvent


Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	; Safeguard - Exit if alias not set
	if (Game.GetPlayer().GetActorBase().GetRace() != _SLH_BimboRace)
		Return
	Endif

	BimboActor= BimboAliasRef.GetReference() as Actor
    
 	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == 0)
		Return
	Endif
	
    ; Debug.Trace("[SLH] Bimbo received something - " + aiItemCount + "x " + akBaseItem.GetName() + " from the world")

	; debug.Notification("[SLH] Bimbo received something")

      ; If ( (akBaseItem as Armor) == HypnosisCircletArmor  )
      ;  BimboActor.Equipitem(HypnosisCirclet)
      ; EndIf

    ; Obsolete - cure token replaced by spell.
    ; if (akBaseItem == (ReturnItem)) 
        
    ; 	fctPolymorph.bimboTransformEffectOFF(BimboActor)
 
    ;   BimboActor.RemoveItem(ReturnItem, 1, True)

    ; EndIf
endEvent

;===========================================================================
;should really drop the weapons or just unequip it?
;move this to a mcm option
;===========================================================================
Function DropOrUnequip(Actor akActor, Form akObject, bool drop = true)
	If drop && (GV_bimboClumsinessDrop.GetValue() == 1) 
		akActor.DropObject(akObject)
	else
		akActor.UnequipItem(akObject, false, true)
	EndIf
EndFunction

;===========================================================================
;This makes the actor drop his weapons, with a chance based on his stamina
;credit: copied from devious hepless, with some changes
;parameters:
;Actor pl = actor who will drop the weapons
;bool both = should drop both weapons
;float chanceMult = increase the chance to drop
;===========================================================================
int[] function dropWeapons(Actor pl, bool both = false, float chanceMult = 1.0)
	; By default, drops only stuff on left hand, if both == true, also right hand
	; returns an array of dropped item counts, weapon & shield at 0, spells at 1
	; debug.trace("[slh+] dropWeapons(both = "+both+", chanceMult = "+chanceMult+")")
	
	; Calculate the drop chance
	float spellDropChance = ( 100.0 - ( pl.GetAvPercentage("Stamina") * 100.0 ) ) ; inverse of stamina percentage
	;int arousal = 0
	;if (pl != None)
	;	arousal = slaUtil.GetActorArousal(pl)
	;else
	;	Debug.Trace("[sla] null player on dropWeapons")
	;endif
	;if arousal >= 30 ; If arousal is over 30, increase the drop chance
	;	arousal = ( arousal - 30 ) / 2 ; 0 - 35% extra
	;	spellDropChance = spellDropChance + arousal
	;endIf
	
	spellDropChance *= chanceMult
	
	if spellDropChance > 100
		spellDropChance = 100
	elseif spellDropChance < 0
		spellDropChance = 0
	endif

	; debug.trace("[slh+] weapon drop chance: " + spellDropChance)
	
	int[] drops = new int[2]
	drops[0] = 0
	drops[1] = 0
		
	float chance = Utility.RandomInt(0, 99)
	Spell spl
	Weapon weap
	Armor sh
	
	int i = 2
	bool drop = true
	While i > 0
		i -= 1
		if i == 0
			Utility.Wait(1.0) ; Equipping the secondary set takes a while...
		EndIf
		if both
			spl = pl.getEquippedSpell(1)
			if spl && chance < spellDropChance
				pl.unequipSpell(spl, 1)
				drops[1] = drops[1] + 1
			endIf
			
			weap = pl.GetEquippedWeapon(true)
			if weap && pl.IsWeaponDrawn()
				DropOrUnequip(pl, weap, drop)
				drops[0] = drops[0] + 1
			endIf
			
			sh = pl.GetEquippedShield()
			if sh && pl.IsWeaponDrawn()
				DropOrUnequip(pl, sh, drop)
				drops[0] = drops[0] + 1
			endIf
		endIf
		
		spl = pl.getEquippedSpell(0)
		if spl && chance < spellDropChance
			pl.unequipSpell(spl, 0)
			drops[1] = drops[1] + 1
		endIf
		
		weap = pl.GetEquippedWeapon(false)
		if weap && pl.IsWeaponDrawn()
			both = both || weap.GetWeaponType() >= 5 ; if this is a two handed weapon, unequip both hands on the 2nd loop
			DropOrUnequip(pl, weap, drop)
			drops[0] = drops[0] + 1
		endIf
		
		drop = false
		If drops[0] > 0
		; Some weapons are dropped already, make sure to unequip any spells on the second iteration as well
			spellDropChance = 100
		EndIf
	EndWhile

	return drops
endFunction

;===========================================================================
;called to start the clumsiness
;===========================================================================
function updateClumsyBimbo()
    if (isBimboClumsyHands && !isClumsyHandsRegistered)
    	isClumsyHandsRegistered = True
		RegisterForActorAction(0) ; Weapon Swing
		RegisterForActorAction(5) ; Bow Draw
		Debug.Notification("Your hands feel weak, trembling with arousal.")
	endif

	if (isBimboClumsyLegs && !isClumsyLegsRegistered)
    	isClumsyLegsRegistered = True
    	RegisterForSingleUpdateGameTime(0.015) ;walking
		Debug.Notification("You feel clumsy, your hips swaying without control.")
    endif
endfunction

;===========================================================================
; messages shown when the player drop his weapons trying to attack
; TOOD change this messages, was just a quick thing
;===========================================================================
string Function randomBimboHandsMessage(float bimboArousal, int actionType)
	int chance = Utility.RandomInt(0, 5)
	String handMessage
	if bimboArousal > 40
		if chance < 1
			handMessage = "You fantasize about caressing your tits."
		elseif chance < 2
			handMessage = "You fantasize about holding dicks all around."
		elseif chance < 3
			handMessage = "For a moment you try to finger your pussy."
		elseif chance < 4
			handMessage = "Your tight nipples beg for attention."
		else
			handMessage = "You need to feel a cock in your hand..now!"
		endif
	elseif chance < 1
		handMessage = "You daydream about holding a fat dick."
	elseif chance < 2
		handMessage = "You fantasize about holding a dick with each hand."
	elseif chance < 3
		handMessage = "Your dainty hands feel so weak and tingly."
	elseif chance < 4
		handMessage = "You feel lightheaded and breathless."
	elseif chance < 5
		handMessage = "You worry about chipping your nails."
	endif
	return handMessage
EndFunction

;===========================================================================
; clumsy hands, called with every player attack or bow draw
; - the chances should be tweaked
; - TODO i've saw this beeing called without the player doing attacks. Why??
;===========================================================================
function clumsyBimboHands(int actionType, Actor bimbo, Form source, int slot)
	;debug: checking why this is beeing called without doing an attack
	BimboActor= BimboAliasRef.GetReference() as Actor
	if (bimbo != BimboActor)
		; debug.trace("[slh+] bimbo clumsy hands, not the bimbo")
		return
	endif

	;not clumsy anymore? stop it!
	if !isBimboClumsyHands
		UnregisterForActorAction(0)
		UnregisterForActorAction(5)
		isClumsyHandsRegistered = false
		return
	endif

	float bimboArousal = slaUtil.GetActorArousal(bimbo) as float
	float dropchance = 1.0 + (bimboArousal / 10 )
	string handMessage
	int[] drops

	;...but bow draw chances are bigger (using both hands)
	if actionType == 5
		dropchance *= 3.0 * (GV_bimboClumsinessMod.GetValue() as Float)
	endif

	;TODO check long nails (equipped at the bad end), dropchance *= 2 
	int roll = Utility.RandomInt()
	; debug.trace("[slh+] bimbo clumsy hands, drop chance/roll = " + dropchance + "/" + roll)
	if roll <= (dropchance) as int
		handMessage = randomBimboHandsMessage(bimboArousal, actionType)
		if actionType == 5
			; bow fumble
			Input.TapKey(Input.GetMappedKey("Ready Weapon"))
			roll = Utility.RandomInt()
			dropchance = dropchance * 0.33
			if roll <= (dropchance as int)
				drops = dropWeapons(bimbo, both = false ) ;may drop the bow too
			endif
		elseif slot == 1
			; right hand
			drops = dropWeapons(bimbo, both = true)
		else
			drops = dropWeapons(bimbo, both = false)
		endif
		bimbo.CreateDetectionEvent(bimbo, 20)
		if drops[0] > 0 ;dropped weapons
			handMessage = handMessage + "... and lose grip. Oopsy!"
		endif
		Debug.Notification(handMessage)
		SLH_Control.playMoan(bimbo)
	endif


	;TODO stop it for a while, register again on another update after some time
	;UnregisterForActorAction(0)
	;UnregisterForActorAction(5)
	;RegisterForSingleUpdate( fRFSU )
endfunction

;===========================================================================
;this makes the bimbo stumble when running/sprinting/sneaking
;called with OnUpdate
; - the stumbling chances should be tweaked
;===========================================================================
function clumsyBimboLegs(Actor bimbo)
	string bimboTripMessage = ""

	;not clumsy anymore?
	if !isBimboClumsyLegs
		isClumsyLegsRegistered = false
		return
	endif

	;is pressing the movement keys?
	if Input.IsKeyPressed(Input.GetMappedKey("Forward")) || Input.IsKeyPressed(Input.GetMappedKey("Back")) || Input.IsKeyPressed(Input.GetMappedKey("Strafe Left")) || Input.IsKeyPressed(Input.GetMappedKey("Strafe Right"))
		;isn't on the menu?
		bool IsMenuOpen = Utility.IsInMenuMode() || UI.IsMenuOpen("Dialogue Menu")
		if !IsMenuOpen && !bimbo.IsOnMount() && !bimbo.IsSwimming()
		    float tumbleForce = 0.1
			float bimboArousal = 0.0
			if bimbo != None
				bimboArousal = slaUtil.GetActorArousal(bimbo) as float
				; debug.trace("[slh+] ---- is aroused: " + bimboArousal)
			else
				; Debug.Trace("[sla+] null player on clumsyBimboLegs")
			endif
		    float tumbleChance = 1.0 + (bimboArousal / 20.0)

			;ok, lets check what is the bimbo doing and increase the chances
			;TODO is using HDT heels and the tf ended, decrease the chances (a good bimbo always use heels)
			if bimbo.IsSprinting()
				tumbleChance *= 4.00 
				tumbleForce *= 1.10
			elseif bimbo.IsRunning()
				tumbleChance *= 2.00 
				tumbleForce *= 1.00
			elseif bimbo.IsSneaking()
				tumbleChance *= 0.33 
				tumbleForce *= 0.50
			else
				;just walking, no stumbling
				tumbleChance = 0.0
			endif

			int roll = Utility.RandomInt()
			; debug.trace("[slh+] ------- stumble [" + roll + " < " + tumbleChance + "]?")
			if (roll <= tumbleChance)
				If (bimboClumsyBuffer < ( 7 - (GV_bimboClumsinessMod.GetValue() as Int) * 6) )
					bimboClumsyBuffer = bimboClumsyBuffer + 1
				else
					bimboClumsyBuffer = 0
					Game.ForceThirdPerson()
					If bimbo.IsSneaking()
						bimbo.StartSneaking()
					EndIf
					bimbo.CreateDetectionEvent(bimbo, 20)
					bimbo.PushActorAway(bimbo, tumbleForce) ;how to push only to the bimbo movement direction?
					Utility.Wait(1.0)
					int[] drop = dropWeapons(bimbo, both = true, chanceMult = 0.1)
					if drop[0] > 0 ;if dropped anything, play a moan sound
						SLH_Control.playMoan(bimbo)
					endif

					;wait a little to show the messages, because on ragdoll the hud is hidden
					Utility.Wait(2.0)

					int rollMessage = Utility.RandomInt()

					if (rollMessage >= 80)
						bimboTripMessage = "You notice a chipped nail and skip a step."
					elseif (rollMessage >= 60)
						bimboTripMessage = "You know what you need? a hard pounding.."
					elseif (rollMessage >= 40)
						bimboTripMessage = "Semen coating your lips. That's what you need right now."
					elseif (rollMessage >= 20)
						bimboTripMessage = "Oh.. What you would give to have all your holes filled..."
					else 
						bimboTripMessage = "Your clit demands to be licked.. right now!"
					endIf

					if drop[0] > 0
						Debug.Notification("You trip and drop your weapons!") ;temp messages
					else
						Debug.Notification("You tripped! Clumsy bimbo!") ;temp messages
					endif
					
					Debug.Notification(bimboTripMessage) ;temp messages

					;alternative to the ragdoll: trigger the bleedout animation for 2 seconds
					;Debug.SendAnimationEvent(bimbo, "BleedOutStart")
					;if util.config.dropWeapons
					;	util.dropWeapons(both = true, chanceMult = 2.0)
					;endif
					;Utility.Wait(2.0)
					;Debug.SendAnimationEvent(bimbo, "BleedOutStop")
				endIf

			elseif bimboArousal > 80 && roll <= 20 ;warn the player
				Debug.Notification("You squeeze your legs with arousal.")
				SLH_Control.playMoan(bimbo)
				bimbo.CreateDetectionEvent(bimbo, 10)
			endif
		endif
	endif
endfunction

;===========================================================================
;[mod] progressive transformation here, called every day
;TODO move all the stuff here, each thing with its own trigger
;
;
;===========================================================================
function bimboDailyProgressiveTransformation(actor bimbo, bool isTG)
	; debug.trace("[slh+] bimbo progressive transformation: " + iDaysPassed)
	if (bimbo == None)
		return
	endIf

	;bimbo = Game.GetPlayer()
	;transformationlevel is the same as the number of days
	int transformationLevel = StorageUtil.GetIntValue(bimbo, "_SLH_bimboTransformGameDays")
	bool showSchlongMessage = true
	float fButtMax
	float fButtActual
	float fButtMin

	int transformCycle = transformationLevel/5
	transformationLevel = transformationLevel - (transformCycle * 5)

	debug.trace("[slh+] bimbo transformation level: " + transformationLevel)

	;no tg = always female, never has a schlong
	;tg:
	; - female + tg = schlong enlarges every day, permanent on day 5
	; - male + tg = schlong shrinks every day, lost on day 5

	if !isTG
		showSchlongMessage = false
	endif

	Int iBimboHairColor = Math.LeftShift(255, 24) + Math.LeftShift(30, 16) + Math.LeftShift(80, 8) + 80
	StorageUtil.SetIntValue(BimboActor, "_SLH_iHairColor", iBimboHairColor ) 
	BimboActor.SendModEvent("SLHRefresh")

	;level 1: permanent makeup
	if (transformationLevel == 1) 
		;lipstick: pink, or should it be red? or random?
		;eyelids shadow: pink too
		Debug.Notification("You feel a little tingling on your face.")
		; SlaveTats.simple_add_tattoo(bimbo, "Bimbo", "Lipstick", color = 0x66FF0984, last = false, silent = true)
		fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Lipstick", iColor = 0x66FF0984)
		fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Eye Shadow", iColor = 0x99000000)

	;level 2, nails, weak body (can drop weapons when hit)
	elseif transformationLevel == 2
		Debug.Notification("Your body feels weak and your boobs are sizzling.")
		fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Feet Nails", iColor = 0x00FF0984 )
		fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Hand Nails", iColor = 0x00FF0984 )
		fctBodyshape.alterBodyByPercent(bimbo, "Breast", 20.0)
		isBimboFrailBody = true

	;level 3: back tattoo, clumsy hands
	elseif transformationLevel == 3
		Debug.Notification("A naughty shiver runs down your back.")
		fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Tramp Stamp" )
		isBimboClumsyHands = true

	;level 4: belly tattoo, bigger butt, clumsy legs
	elseif transformationLevel == 4
		Debug.Notification("Your butt feels bloated, your belly craves cock.")
		fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Belly" )
 
		;butt
		fButtMin = StorageUtil.GetFloatValue(bimbo, "_SLH_fButtMin")
		fButtMax = StorageUtil.GetFloatValue(bimbo, "_SLH_fButtMax")
		fButtActual = StorageUtil.GetFloatValue(bimbo, "_SLH_fButt")
		if (fButtActual < fButtMax )
			Debug.SendAnimationEvent(bimbo, "BleedOutStart")
			SLH_Control.playMoan(bimbo)

			fButtActual = 0.1 + fButtActual * 1.5 ;now with 50% more butt!
			if fButtActual > fButtMax
				fButtActual = fButtMax
			endif
            StorageUtil.SetFloatValue(bimbo, "_SLH_fButt", fButtActual ) 
            Bimbo.SendModEvent("SLHRefresh")

			Utility.Wait(1.0)
			Debug.SendAnimationEvent(bimbo, "BleedOutStop")
        endif
		isBimboClumsyLegs = true

	;level 5,  pubic tattoo
	elseif transformationLevel == 5
		;i'm handling this as a bad end, on CK
		;should equip long nails, but i dont know how to create quest items here, so 
		;^    this is beeing handled on CK, slh_qst_bimbo
		;^    .... and my ck crashes if i try to open this script >:(
		;^    .... and i can't edit the quest dialogs, if i try everything will be blank (need to remove the 'is a cure' dialogs!!)
		if !isMale ;no schlong on the way
			; SlaveTats.simple_add_tattoo(bimbo, "Bimbo", "Pubic Tattoo", last = true, silent = true)
			Debug.Notification("Your pussy feels so hot and empty.")
			fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Pubic Tattoo"  )
		endif
	endif

	;--------------------------------------------
	;TODO
	;- almost done: moving the clumsy stuff here, progressing each day too (hands, legs, combat hits)
	;- the long nails, and the very long nails too should be here
	;- done: better tramp stamp
	;- make the bimbo scream when the combat starts (sometimes)
	;- better makeup
	;- create curses status, so the player can know about it
	;
	;IDEAS
	;- some kind of sex need? or leave it for other mods?
	;- the bad end should be better: an fx should play, trigger as masturbation too
	;- move the clumsiness to the nails (enchantment)?
	;- or move it all to spells, each curse should be a spell
	;
	;FINAL EXPANSION - turning this into a new mod: curses of skyrim - items with curses on them and move this into a plugin, using sl_hormones api and the new mod api
	;- move everything to a second quest caused by the player choices:
	;  ask Honey if she has a better solution after talking with the dremora (her ideas of "solution" are not the same as yours) 
	;  then she will randomly seek the player and give (force equip) him surprise cursed gifts every day (maybe she only visits the player after sleep, or during sex so he cant avoid her):
	;  - permanent makeup and a haircut = causes random thoughts of sex
	;  - long nails = clumsy hands
	;  - hoops earrings = block helmets
	;  - bracelets = block forearm armor
	;  - an anal dildo = butt growth until removed, can only be removed after a day (she could do it on the next visit)
	;  - vaginal dildo = start the player tripping on equip, then after removed the player will stumble less but will forever do it (same, she removes it on the next visit)
	;  - nipple piercings = boob expansion, increases arousal each minute
	;  - more piercings? navel, clit?
	;  - as a parting gift some kind of outfit (heels, skirt and a tube top, or something like that), all enchanted. These can be removed, but causes the player to be conditioned to use heels (stumble a lot more if not)
	;  - this quest will not have a good end, only makes the curse worse
	;
	;
	;BUG CHECK
	;check if the cure is still possible
	;check why, WHY, WHYYYY the honey hello dialog disappears when i save the esp!!
	;check what happens after the player is cured
	;--------------------------------------------
endfunction




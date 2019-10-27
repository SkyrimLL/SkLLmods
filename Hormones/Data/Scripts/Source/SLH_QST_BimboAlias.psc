Scriptname SLH_QST_BimboAlias extends ReferenceAlias  

SLH_fctPolymorph Property fctPolymorph Auto
SLH_fctBodyshape Property fctBodyshape Auto
SLH_fctUtil Property fctUtil Auto
SLH_fctColor Property fctColor Auto
SLH_QST_HormoneGrowth Property SLH_Control Auto

slaUtilScr Property slaUtil  Auto  
SexLabFramework Property SexLab  Auto  

Quest Property _SLH_QST_Bimbo  Auto  

Keyword Property ClothingOn Auto
Keyword Property ArmorOn Auto

Bool bArmorOn = false
Bool bClothingOn = false

GlobalVariable      Property GV_isTG                   Auto
GlobalVariable      Property GV_isHRT                   Auto
GlobalVariable      Property GV_isBimbo                 Auto

GlobalVariable      Property GV_isBimboFinal                 Auto
GlobalVariable      Property GV_isBimboLocked                 Auto

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
Int iCommentThrottle = 0

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
Bool isBimboPermanent = false
Bool isClumsyHandsRegistered = False
Bool isClumsyLegsRegistered = False
;===========================================================================

;===========================================================================
;Hack! Recover lost saves where the tf was done on day zero
;===========================================================================
Event OnPlayerLoadGame()
	Actor kPlayer = Game.GetPlayer()
	; if (!isUpdating)
		debugTrace(" game loaded, registering for update")
		if (StorageUtil.GetIntValue(kPlayer, "_SLH_iBimbo")==0) && StorageUtil.GetIntValue(kPlayer, "_SLH_bimboTransformDate") == 0
			StorageUtil.SetIntValue(kPlayer, "_SLH_bimboTransformDate", -1)
			debugTrace(" poor bimbo, are you lost?")
		endif

		isMaleToBimbo =  StorageUtil.GetIntValue(none, "_SLH_bimboIsOriginalActorMale") as Bool

		BimboActor= BimboAliasRef.GetReference() as Actor
		debugTrace(" BimboActor: " + BimboActor)
		debugTrace(" Bimbo Transform date: " + StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") )
		debugTrace(" Player is bimbo: " + StorageUtil.GetIntValue(kPlayer, "_SLH_iBimbo"))

		SLH_Control._updatePlayerState()
		; debug.Notification(" Clumsy mod: " + StorageUtil.GetFloatValue(kPlayer, "_SLH_fBimboClumsyMod" ))

    	RegisterForSingleUpdate( 10 )
    ; else
	; 	debugTrace(" game loaded, is already updating (is it?)")
    ; endif
EndEvent

Function initBimbo()
	Actor kPlayer = Game.GetPlayer()
	isMaleToBimbo =  StorageUtil.GetIntValue(none, "_SLH_bimboIsOriginalActorMale") as Bool

	BimboActor= BimboAliasRef.GetReference() as Actor
	debugTrace(" Init BimboActor: " + BimboActor)
	debugTrace(" Bimbo Transform date: " + StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") )
	debugTrace(" Player is bimbo: " + StorageUtil.GetIntValue(kPlayer, "_SLH_iBimbo"))

	debug.notification("(Giggle)")
	
	RegisterForSingleUpdate( 10 )
EndFunction

;===========================================================================
;[mod] stumbling happens here
;===========================================================================
Event OnUpdateGameTime()
	Actor kPlayer = Game.GetPlayer()
	; Safeguard - Exit if alias not set
	if (StorageUtil.GetIntValue(kPlayer, "_SLH_iBimbo")==0)
		; try again later
    	RegisterForSingleUpdate( 10 )
		Return
	Endif
	; debug.Notification("[SLH] Bimbo update game time")

	BimboActor= BimboAliasRef.GetReference() as Actor

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == -1)
    	RegisterForSingleUpdate( 10 )
		Return
	Endif

	if (isBimboClumsyLegs)
    	clumsyBimboLegs(BimboActor)
    	RegisterForSingleUpdateGameTime(0.03)
    endif
EndEvent

Event OnActorAction(int actionType, Actor akActor, Form source, int slot)
	; Safeguard - Exit if alias not set
	if (StorageUtil.GetIntValue(Game.GetPlayer(), "_SLH_iBimbo")==0)
		;debugTrace(" bimbo OnActorAction, None")
		Return
	Endif

	BimboActor= BimboAliasRef.GetReference() as Actor

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == -1)
		Return
	Endif

	if (akActor == BimboActor)
		clumsyBimboHands(actionType, akActor, source, slot)
	EndIf
EndEvent

Event OnUpdate()
	; Safeguard - Exit if alias not set
	float bimboArousal = slaUtil.GetActorArousal(BimboActor) as float
	Actor kPlayer = Game.GetPlayer()
	Int rollFirstPerson 


	if (StorageUtil.GetIntValue(kPlayer, "_SLH_iBimbo")==0)
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
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == -1)
		; debugTrace(" bimbo OnUpdate, No TF Date")
    	RegisterForSingleUpdate( 10 )
		Return
	Endif

	; if ((GV_hornyBegArousal.GetValue() as Int) > 80)
	;	GV_hornyBegArousal.SetValue(80)
	; endif

    iDaysPassed = Game.QueryStat("Days Passed")

    
    StorageUtil.SetIntValue(BimboActor, "_SLH_bimboTransformGameDays", iDaysPassed - (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") as Int ))    
    StorageUtil.SetIntValue(kPlayer, "_SLH_iAllowBimboThoughts", 1)

    daysSinceEnslavement = StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformGameDays")


    if (iGameDateLastCheck == -1)
        iGameDateLastCheck = iDaysPassed
    EndIf

    iDaysSinceLastCheck = (iDaysPassed - iGameDateLastCheck ) as Int
       
    ; Debug.Notification( "[SLH] Bimbo status update - Days: " + daysSinceEnslavement )
    ; Debug.Notification( "[SLH] iDaysSinceLastCheck: " + iDaysSinceLastCheck )
	rollFirstPerson = Utility.RandomInt(0,100)

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
 			if (StorageUtil.GetIntValue(BimboActor, "_SLH_allowBimboRace")==0)
	            fctBodyshape.alterBodyByPercent(BimboActor, "Weight", 20.0)
	            fctBodyshape.alterBodyByPercent(BimboActor, "Breast", 20.0)
	        else
	            fctBodyshape.alterBodyByPercent(BimboActor, "Weight", 10.0)
	            fctBodyshape.alterBodyByPercent(BimboActor, "Breast", 10.0)
	        endif

			If (rollFirstPerson <= (StorageUtil.GetFloatValue(BimboActor, "_SLH_fHormoneBimbo") as Int))
				; First person thought

	            ; Male to female bimbo
	            if (daysSinceEnslavement==1)
	            	debug.messagebox("I have boobs now and they are growing larger every day. It feels so good cupping them and feeling their weight. If they grow any larger, they will make using bows and armors a lot more difficult. That's alright though.. I guess I can find someone to fight for me. That's kind of hot actually.")
	            elseif (daysSinceEnslavement==2)
	            	debug.messagebox("My lips are full and feel parched if they are not frequently coated with semen. Oh my gods.. who knew semen tasted so good! I just can't get enough of the stuff. I need to feel it on my skin, inside me and down my throat.")
	            elseif (daysSinceEnslavement==3)
	            	debug.messagebox("My cock is shrinking and getting more sensitive every day. Squeezing my legs and rubbing it frequently only provide temporary relief. And my balls.. I can feel them sink into a deep, wet slit. That's okay I suppose, as long as I can find big fat cocks to fill me.")
	            elseif (daysSinceEnslavement==4)
	            	debug.messagebox("Everything now looks so confusing and difficult. Except for sex. Sex is easy and fun. Being horny makes my hands shake and my legs weak with anticipation. Being a slut is one of the many perks of being a bimbo.")
	            endif
	        else
				; Third person thought

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
	        endIf
        	
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
 
 			if (StorageUtil.GetIntValue(BimboActor, "_SLH_allowBimboRace")==0)
	            fctBodyshape.alterBodyByPercent(BimboActor, "Weight", 20.0)
	            fctBodyshape.alterBodyByPercent(BimboActor, "Breast", 20.0)
	        else
	            fctBodyshape.alterBodyByPercent(BimboActor, "Weight", 10.0)
	            fctBodyshape.alterBodyByPercent(BimboActor, "Breast", 10.0)
	        endif

			If (rollFirstPerson <= (StorageUtil.GetFloatValue(BimboActor, "_SLH_fHormoneBimbo") as Int))
				; First person thought
	            ; Female to female bimbo
	            if (daysSinceEnslavement==1)
	            	debug.messagebox("My boobs are growing larger every day and my hair is definitely blonde now. Armors and weapons are like, so heavy now. I need to find me a strong buy to carry all my stuff and fight for mw. Maybe he will give me a good fuck too. That would be totally worth it.")
	            elseif (daysSinceEnslavement==2)
	            	debug.messagebox("The constant tingle in your tits driving me mad. They need to be sucked on for a long time, or tweaked.. or pinched with my long pink nails. Damn.. just thinking about it made them tingle again.")
	            elseif (daysSinceEnslavement==3)
	            	debug.messagebox("I constantly crave only one kind of sword now... the hard, curved and throbbing kind. There is nothing I wouldn't do for a good cock in her hand.. or lips.. or lodged deep inside me.")
	            elseif (daysSinceEnslavement==4)
	            	debug.messagebox("Sex is all that matters now.. I need it.. my tits crave it.. my lips crave it. Being horny makes my hand shake and my legs weak with anticipation. Making men hard and receiving their cum is my only purpose in life now... or and maybe doing quests too.. but mostly being fucked.")
	            endif
	        Else
                ; Third person thought
	            if (daysSinceEnslavement==1)
	            	debug.messagebox("Your boobs are growing larger every day and your hair is definitely blonde now. Forget about wearing armor and using bows, you will soon have to rely on your charms to get a strong warrior to fight for you... maybe he will give you a good fuck too.")
	            elseif (daysSinceEnslavement==2)
	            	debug.messagebox("The constant tingle in your tits is only relieved after they have been sucked on for a long time, or tweaked.. or pinched with your long pink nails. Damn.. just thinking about it made them tingle again.")
	            elseif (daysSinceEnslavement==3)
	            	debug.messagebox("Forget about using swords as well. You constantly crave only one kind of sword now... the hard and throbbing kind. There is nothing a good bimbo wouldn't do for a good cock in her hand.. or lips.. or lodged deep inside her.")
	            elseif (daysSinceEnslavement==4)
	            	debug.messagebox("Sex is all you can think about now.. you crave it.. your tits crave it.. you lips crave it. Being horny makes your hand shake and your legs weak with anticipation. Being a slut is one of the many perks of being a bimbo.")
	            endif
	        Endif
  
            ; bimboDailyProgressiveTransformation(BimboActor, true) ;[mod]
            if (GV_isTG.GetValue() == 1) && (StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlong") <= fSchlongMax )  && ( daysSinceEnslavement < 5 )
                ; StorageUtil.SetFloatValue(BimboActor, "_SLH_fSchlong", 0.1 + StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlong") * 1.2 ) 
                fctBodyshape.alterBodyByPercent(BimboActor, "Schlong", 30.0)
                BimboActor.SendModEvent("SLHRefresh")

            elseif (GV_isTG.GetValue() == 1) && (daysSinceEnslavement >= 5 )
                _SLH_QST_Bimbo.SetStage(16)

                SLH_Control.setTGState(BimboActor, FALSE)
            endif

        endif

        iGameDateLastCheck = iDaysPassed

    else
		; fctUtil.tryRandomBimboThoughts()
    Endif

    If (StorageUtil.GetIntValue(BimboActor, "_SD_iSlaveryExposure") <= 150)
        StorageUtil.SetIntValue(BimboActor, "_SD_iSlaveryExposure", 150)
    EndIf
        
    StorageUtil.SetIntValue(BimboActor, "_SD_iSlaveryLevel", 6)
    If (StorageUtil.GetIntValue(BimboActor, "_SD_iDom") > 0)
    	Debug.Messagebox("A wave of submissiveness washes over you. A bimbo doesn't need to think, she needs only to server her master as a perfect slave. Remember your place little slut.")
        StorageUtil.SetIntValue(BimboActor, "_SD_iDom", 0)
    EndIf
    If (StorageUtil.GetIntValue(BimboActor, "_SD_iSub") < 0)
        StorageUtil.SetIntValue(BimboActor, "_SD_iSub", 0)
    EndIf

    updateClumsyBimbo() ;[mod] clumsy bimbo
    isUpdating = false
    ;RegisterForSingleUpdate( fRFSU )
    RegisterForSingleUpdate( fRFSU * 2 ) ;performance
	;debugTrace(" bimbo OnUpdate, Done")
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	; Safeguard - Exit if alias not set
	if (StorageUtil.GetIntValue(Game.GetPlayer(), "_SLH_iBimbo")==0)
		Return
	Endif

	Actor kPlayer = Game.GetPlayer()
	Float fClumsyMod = StorageUtil.GetFloatValue(kPlayer, "_SLH_fBimboClumsyMod" ) 
	BimboActor= BimboAliasRef.GetReference() as Actor

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == -1)
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
		float dropchance = 1.0 + (bimboArousal / 30.0 ) * (GV_bimboClumsinessMod.GetValue() as Float) * fClumsyMod
		; debugTrace(" bimbo beeing hit, drop chance: " + dropchance)
      	If (Utility.RandomInt(0,100) <= dropchance) &&  (GV_bimboClumsinessMod.GetValue()!=0); && (!(akAggressor as Actor).IsInFaction(pCreatureFaction)))
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
	; debugTrace(" dropWeapons(both = "+both+", chanceMult = "+chanceMult+")")
	
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

	; debugTrace(" weapon drop chance: " + spellDropChance)
	
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
	int rollFirstPerson  = Utility.RandomInt(0,100)
	If (rollFirstPerson <= (StorageUtil.GetFloatValue(Game.GetPlayer(), "_SLH_fHormoneBimbo") as Int))
		; First person thought
	    if (isBimboClumsyHands && !isClumsyHandsRegistered)
	    	isClumsyHandsRegistered = True
			RegisterForActorAction(0) ; Weapon Swing
			RegisterForActorAction(5) ; Bow Draw
			Debug.Notification("I'm so horny I can't carry a thing.")
		endif

		if (isBimboClumsyLegs && !isClumsyLegsRegistered)
	    	isClumsyLegsRegistered = True
	    	RegisterForSingleUpdateGameTime(0.015) ;walking
			Debug.Notification("I need to fuck. Now!")
	    endif
	else
		; Third person thought
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
	endIf
endfunction

;===========================================================================
; messages shown when the player drop his weapons trying to attack
; TOOD change this messages, was just a quick thing
;===========================================================================
string Function randomBimboHandsMessage(float bimboArousal, int actionType)
	int chance = Utility.RandomInt(0, 5)
	int rollFirstPerson  = Utility.RandomInt(0,100)
	String handMessage

	If (rollFirstPerson <= (StorageUtil.GetFloatValue(Game.GetPlayer(), "_SLH_fHormoneBimbo") as Int))
		; First person thought
		if bimboArousal > 40
			if chance < 1
				handMessage = "My tits feel so full and soft."
			elseif chance < 2
				handMessage = "I could use cock like.. right now."
			elseif chance < 3
				handMessage = "Mmm..  my pussy feel so wet."
			elseif chance < 4
				handMessage = "My tits are tingly!"
			else
				handMessage = "A cock in my mouth would feel so good."
			endif
		elseif chance < 1
			handMessage = "I need a male companion with a big fat dick."
		elseif chance < 2
			handMessage = "I haven't had two dicks at once in like .. forever."
		elseif chance < 3
			handMessage = "I need to find someone to carry all my stuff."
		elseif chance < 4
			handMessage = "Running makes me feel so horny."
		elseif chance < 5
			handMessage = "I can't use weapons or I will chip a nail."
		endif
	else
		; Third person thought
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
	endIf

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
		; debugTrace(" bimbo clumsy hands, not the bimbo")
		return
	endif

	;not clumsy anymore? stop it!
	if !isBimboClumsyHands
		UnregisterForActorAction(0)
		UnregisterForActorAction(5)
		isClumsyHandsRegistered = false
		return
	endif


	Actor kPlayer = Game.GetPlayer()
	float bimboArousal = slaUtil.GetActorArousal(bimbo) as float
	float dropchance = 1.0 + (bimboArousal / 10 )
	Float fClumsyMod = StorageUtil.GetFloatValue(kPlayer, "_SLH_fBimboClumsyMod" ) 
	string handMessage
	int[] drops

	;...but bow draw chances are bigger (using both hands)
	if actionType == 5
		dropchance *= 3.0 * (GV_bimboClumsinessMod.GetValue() as Float)
	endif

	dropchance *= fClumsyMod

	;TODO check long nails (equipped at the bad end), dropchance *= 2 
	int roll = Utility.RandomInt(0,100)
	; debugTrace(" bimbo clumsy hands, drop chance/roll = " + dropchance + "/" + roll)
	if (roll <= (dropchance) as int) && (GV_bimboClumsinessMod.GetValue() != 0)

		; Debug.Notification("[SLH] dropchance: " + dropchance)
		; Debug.Notification("[SLH] fClumsyMod: " + fClumsyMod)

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

		If (StorageUtil.GetIntValue(bimbo, "_SLH_iShowStatus")!=0)
			Debug.Notification(handMessage)
		Endif
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
	Actor kPlayer = Game.GetPlayer()
	string bimboTripMessage = ""
	Float fClumsyMod = StorageUtil.GetFloatValue(kPlayer, "_SLH_fBimboClumsyMod" ) 

	;not clumsy anymore?
	if !isBimboClumsyLegs
		isClumsyLegsRegistered = false
		return
	endif

	bArmorOn = kPlayer.WornHasKeyword(ArmorOn)
	bClothingOn = kPlayer.WornHasKeyword(ClothingOn)

	;is pressing the movement keys?
	if Input.IsKeyPressed(Input.GetMappedKey("Forward")) || Input.IsKeyPressed(Input.GetMappedKey("Back")) || Input.IsKeyPressed(Input.GetMappedKey("Strafe Left")) || Input.IsKeyPressed(Input.GetMappedKey("Strafe Right"))
		;isn't on the menu?
		bool IsMenuOpen = Utility.IsInMenuMode() || UI.IsMenuOpen("Dialogue Menu")
		if !IsMenuOpen && !bimbo.IsOnMount() && !bimbo.IsSwimming() && (StorageUtil.GetIntValue(kPlayer,"DCUR_SceneRunning") == 0)
			SendModEvent("dhlp-Suspend")
		    float tumbleForce = 0.1
			float bimboArousal = 0.0
			if bimbo != None
				bimboArousal = slaUtil.GetActorArousal(bimbo) as float
				; debugTrace(" ---- is aroused: " + bimboArousal)
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

			tumbleChance *= fClumsyMod

			int roll = Utility.RandomInt()
			Int rollFirstPerson = Utility.RandomInt(0,100)
			; debugTrace(" ------- stumble [" + roll + " < " + tumbleChance + "]?")
			if (roll <= tumbleChance) && (GV_bimboClumsinessMod.GetValue()!=0)
				If (bimboClumsyBuffer < ( 7 - (GV_bimboClumsinessMod.GetValue() as Int) * 6) )
					bimboClumsyBuffer = bimboClumsyBuffer + 1
				else
					bimboClumsyBuffer = 0
					Game.ForceThirdPerson()
					If bimbo.IsSneaking()
						bimbo.StartSneaking()
					EndIf
					bimbo.CreateDetectionEvent(bimbo, 20)

					int rollMessage = Utility.RandomInt(0,100)

					if ((bArmorOn && (rollMessage >30)) || (bClothingOn && (rollMessage >90)))
						bimbo.PushActorAway(bimbo, tumbleForce) ;how to push only to the bimbo movement direction?
						Utility.Wait(1.0)
						Debug.Notification("You tripped! Clumsy bimbo!") ;temp messages
					endIf

					int[] drop = dropWeapons(bimbo, both = true, chanceMult = 0.1)
					if drop[0] > 0 ;if dropped anything, play a moan sound
						SLH_Control.playMoan(bimbo)
					endif

					;wait a little to show the messages, because on ragdoll the hud is hidden
					Utility.Wait(2.0)

					rollMessage = Utility.RandomInt(0,100)

					If (rollFirstPerson <= (StorageUtil.GetFloatValue(bimbo, "_SLH_fHormoneBimbo") as Int))
						; First person thought
						if (rollMessage >= 80)
							bimboTripMessage = "Oh My Gods.. is that a chipped nail?!"
						elseif (rollMessage >= 60)
							bimboTripMessage = "I need a hard pounding so bad!"
						elseif (rollMessage >= 40)
							bimboTripMessage = "I need to taste cum soon."
						elseif (rollMessage >= 20)
							bimboTripMessage = "I haven't had cock inside me in like.. forever."
						else 
							bimboTripMessage = "My clitty needs to be licked.. like right now!"
						endIf
					else
						; Third person thought
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
					endif

					if drop[0] > 0
						If (rollFirstPerson <= (StorageUtil.GetFloatValue(bimbo, "_SLH_fHormoneBimbo") as Int))
							Debug.Notification("Oopsies... that weapon is so heavy.") ;temp messages
						Else
							Debug.Notification("You got distracted and dropped your weapons!") ;temp messages
						Endif
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
				If (rollFirstPerson <= (StorageUtil.GetFloatValue(bimbo, "_SLH_fHormoneBimbo") as Int))
					; First person thought
					Debug.Notification("I'm so horny.")
				else
					Debug.Notification("You squeeze your legs with arousal.")
				endif

				SLH_Control.playMoan(bimbo)
				bimbo.CreateDetectionEvent(bimbo, 10)
			endif

			SendModEvent("dhlp-Resume")

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
 	Actor PlayerActor = Game.GetPlayer()
	; debugTrace(" bimbo progressive transformation: " + iDaysPassed)
	if (bimbo == None)
		return
	endIf

	;bimbo = Game.GetPlayer() 
	int transformationDays = StorageUtil.GetIntValue(bimbo, "_SLH_bimboTransformGameDays")
	int transformCycle = transformationDays/5
	int transformationLevel = transformationDays - (transformCycle * 5)
	int hairLength = StorageUtil.GetIntValue(none, "YpsCurrentHairLengthStage")
	isBimboPermanent = StorageUtil.GetIntValue(bimbo, "_SLH_bimboTransformLocked") as Bool

	bool showSchlongMessage = true
	float fButtMax
	float fButtActual
	float fButtMin

	debugTrace(" bimbo transformation days: " + transformationDays)
	debugTrace(" bimbo transformation level: " + transformationLevel)
	debugTrace(" bimbo transformation cycle: " + transformCycle)
	debugTrace(" bimbo hair length: " + hairLength)

	;no tg = always female, never has a schlong
	;tg:
	; - female + tg = schlong enlarges every day, permanent on day 5
	; - male + tg = schlong shrinks every day, lost on day 5

	if !isTG
		showSchlongMessage = false
	endif

	; Int iBimboHairColor = Math.LeftShift(255, 24) + Math.LeftShift(92, 16) + Math.LeftShift(80, 8) + 80
	Int iBimboHairColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimboHairColor") ; Math.LeftShift(92, 16) + Math.LeftShift(80, 8) + 80

	if (StorageUtil.GetIntValue(BimboActor, "_SD_iAliciaHair")== 1 )  
		iBimboHairColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubusHairColor") ; Math.LeftShift(247, 16) + Math.LeftShift(163, 8) + 240  ; Pink
		StorageUtil.SetStringValue(BimboActor, "_SLH_sHairColorName", "Pink" ) 

	else
		StorageUtil.SetStringValue(BimboActor, "_SLH_sHairColorName", "Platinum Blonde" ) 
	EndIf

	StorageUtil.SetIntValue(BimboActor, "_SLH_iHairColor", iBimboHairColor )  
	debugTrace(" 	bimbo hair color: " + iBimboHairColor)
	if (transformationDays>15) 
		BimboActor.SendModEvent("SLHRefreshHairColor","Base")
	else
		BimboActor.SendModEvent("SLHRefreshHairColor","Dye")
	endif
	; BimboActor.SendModEvent("SLHRefreshColors")


	;level 1: makeup
	if (transformationLevel == 1)  
		Debug.Notification("You feel a little tingling on your face.")

		If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
			If (!isBimboPermanent) 
				SendModEvent("yps-LipstickEvent", "", -1)  ; -1 = use custom color defined in YPS Fashion
				SendModEvent("yps-EyeshadowEvent", "", -1)   

				if (hairLength<5)
					SendModEvent("yps-SetHaircutEvent", "", 5)
				endif
			Endif
		else
			; SlaveTats.simple_add_tattoo(bimbo, "Bimbo", "Lipstick", color = 0x66FF0984, last = false, silent = true)
			fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Lipstick", iColor = 0x66FF0984)
			fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Eye Shadow", iColor = 0x99000000, bRefresh = True)
		Endif

		fctBodyshape.alterBodyByPercent(bimbo, "Breast", 2.0)

	;level 2, nails, weak body (can drop weapons when hit)
	elseif transformationLevel == 2
		Debug.Notification("Your body feels weak and your boobs are sizzling.")
		If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
			If (!isBimboPermanent) 
				SendModEvent("yps-FingerNailsEvent", "", 29) 
				SendModEvent("yps-ToeNailsEvent",  "", 29)

				if (hairLength<6)
					SendModEvent("yps-SetHaircutEvent", "", 6)
				endif
			Endif
		else
			fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Feet Nails", iColor = 0x00FF0984 )
			fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Hand Nails", iColor = 0x00FF0984, bRefresh = True )
		Endif

		fctBodyshape.alterBodyByPercent(bimbo, "Breast", 2.0)
		isBimboClumsyHands = true

	;level 3: back tattoo, clumsy hands
	elseif transformationLevel == 3
		Debug.Notification("A naughty shiver runs down your back.")
		fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Tramp Stamp", bRefresh = True )

		If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
			if (hairLength<8)
				SendModEvent("yps-SetHaircutEvent", "", 8)
			endif
		Endif

		fctBodyshape.alterBodyByPercent(bimbo, "Breast", 2.0)

	;level 4: belly tattoo, bigger butt, clumsy legs
	elseif transformationLevel == 4
		Debug.Notification("Your butt feels bloated, your belly craves cock.")
		fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Belly", bRefresh = True )
 
 		If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
 			SendModEvent("yps-ArchedFeetEvent")

			if (hairLength<11)
				SendModEvent("yps-SetHaircutEvent", "", 11)
			endif
		EndIf

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

		fctBodyshape.alterBodyByPercent(bimbo, "Breast", 2.0)
		isBimboClumsyLegs = true

	;level 5,  pubic tattoo
	elseif transformationLevel == 5
		if !isMale ;no schlong on the way
			; SlaveTats.simple_add_tattoo(bimbo, "Bimbo", "Pubic Tattoo", last = true, silent = true)
			Debug.Notification("Your pussy feels so hot and empty.")
			fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Pubic Tattoo", bRefresh = True  )
		endif

 		If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1) 
			if (hairLength>13) || (hairLength<13)
				SendModEvent("yps-SetHaircutEvent", "", 13)
			endif

		EndIf

		fctBodyshape.alterBodyByPercent(bimbo, "Breast", 2.0)
		isBimboFrailBody = true
		fctPolymorph.bimboFinalON(bimbo)

	endif

	if (transformationDays>15) 

		if (StorageUtil.GetIntValue(none, "ypsPubicHairEnabled") == 1)
			SendModEvent("yps-SetPubicHairLengthEvent", "", 0)
		Endif

		if (StorageUtil.GetIntValue(none, "ypsArmpitHairEnabled")==1)
			SendModEvent("yps-SetArmpitsHairLengthEvent", "", 0)
		endif

		Float fBimboHormoneLevel = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneBimbo") 

		if (!isBimboPermanent) && (Utility.RandomInt(0,100)< (fBimboHormoneLevel as Int))
			SendModEvent("yps-LipstickEvent", "", -1 )  
			SendModEvent("yps-EyeshadowEvent", "", -1 )   
			SendModEvent("yps-DisableSmudgingEvent")
			SendModEvent("yps-LockMakeupEvent")
			SendModEvent("yps-PermanentMakeupEvent")

			isBimboPermanent = true
			fctPolymorph.bimboLockedON(bimbo)
			Debug.Messagebox("The curse has rewired your brain and transformed your body it its core. The changes are now irreversible. Enjoy your new life little Bimbo.")
		endif
	else
		Debug.Notification("Every day as a Bimbo drains your mind away.")
	endif
	;--------------------------------------------
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



Function debugTrace(string traceMsg)
	if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
		Debug.Trace("[SLH_QST_BimboAlias]" + traceMsg)
	endif
endFunction
Scriptname SLH_QST_BimboAlias extends ReferenceAlias  

SLH_fctPolymorph Property fctPolymorph Auto
SLH_fctUtil Property fctUtil Auto
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
Float fSchlongMin
Float fSchlongMax

;how much gold hypnosis victim earns each day
Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	; Safeguard - Exit if alias not set
	if (BimboAliasRef == None)
		Return
	Endif

	BimboActor= BimboAliasRef.GetReference() as Actor

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == 0)
		Return
	Endif

	; debug.Notification("[SLH] Bimbo changing location")
	if (!isUpdating)
    	RegisterForSingleUpdate( fRFSU )
    endif
endEvent

Event OnUpdateGameTime()
	; Safeguard - Exit if alias not set
	if (BimboAliasRef == None)
		Return
	Endif

	BimboActor= BimboAliasRef.GetReference() as Actor

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == 0)
		Return
	Endif
	
	; debug.Notification("[SLH] Bimbo update game time")

EndEvent

Event OnUpdate()
	; Safeguard - Exit if alias not set
	if (BimboAliasRef == None)
		Return
	Endif

	isUpdating = True
	; debug.Notification(".")

	BimboActor= BimboAliasRef.GetReference() as Actor

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == 0)
		Return
	Endif

    iDaysPassed = Game.QueryStat("Days Passed")

    
    StorageUtil.SetIntValue(BimboActor, "_SLH_bimboTransformGameDays", iDaysPassed - (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") as Int ))    


    if (iGameDateLastCheck == -1)
        iGameDateLastCheck = iDaysPassed
    EndIf

    iDaysSinceLastCheck = (iDaysPassed - iGameDateLastCheck ) as Int

    ; Exit conditions
    If (iDaysSinceLastCheck >= 1)
        Debug.Trace( "[SLH] Bimbo status update - Days transformed: " + StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformGameDays") as Int )
        isMale = fctUtil.isMale(BimboActor)
        fSchlongMin = StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlongMin")
        fSchlongMax = StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlongMax")

    ;     BimboActor.AddItem(ReturnItem, 1 , True)

        ; StorageUtil.SetFloatValue(BimboActor, "_SLH_fBreast", 0.8 ) 
        ; StorageUtil.SetFloatValue(BimboActor, "_SLH_fBelly", 0.8 ) 
        ; StorageUtil.SetFloatValue(BimboActor, "_SLH_fWeight", 0 ) 
        If (GV_isTG.GetValue() == 1) && (!isMale) && !_SLH_QST_Bimbo.IsStageDone(14)
            _SLH_QST_Bimbo.SetStage(14)
        ElseIf (GV_isTG.GetValue() == 1) && (isMale) && !_SLH_QST_Bimbo.IsStageDone(12)
            _SLH_QST_Bimbo.SetStage(12)
        Endif

        If (GV_isTG.GetValue() == 1) && (!isMale) && ( !_SLH_QST_Bimbo.IsStageDone(18) || ( (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformGameDays") as Int) >= 5 ))
            if (StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlong") >= fSchlongMin ) && ( (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformGameDays") as Int) < 5 )
                StorageUtil.SetFloatValue(BimboActor, "_SLH_fSchlong", StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlong") * 0.8 - 0.1) 
                SendModEvent("SLHRefresh")
            else
                BimboActor.SendModEvent("SLHRemoveSchlong")
                Sexlab.TreatAsFemale(BimboActor)
                _SLH_QST_Bimbo.SetStage(18)
            endif

        ElseIf (GV_isTG.GetValue() == 1) && (isMale) && ( !_SLH_QST_Bimbo.IsStageDone(16) || ( (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformGameDays") as Int) >= 5 ))
            if (StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlong") <= fSchlongMax )  && ( (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformGameDays") as Int) < 5 )
                StorageUtil.SetFloatValue(BimboActor, "_SLH_fSchlong", 0.1 + StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlong") * 1.2 ) 
                SendModEvent("SLHRefresh")
                _SLH_QST_Bimbo.SetStage(16)
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
        
    RegisterForSingleUpdate( fRFSU )
EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	; Safeguard - Exit if alias not set
	if (BimboAliasRef == None)
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
	if (BimboAliasRef == None)
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


	ElseIf (akAggressor != None)
		;  Debug.Trace("We were hit by " + akAggressor)
		; debug.Notification("[SLH] Bimbo is hit")
		Int randomNum = Utility.RandomInt(0,100)	

      	If ((randomNum>90) && (BimboActor.GetActorValuePercentage("health")<0.3)) ; && (!(akAggressor as Actor).IsInFaction(pCreatureFaction)))
				;

		    if(BimboActor.IsWeaponDrawn())
		        BimboActor.SheatheWeapon()
		        Utility.Wait(2.0)
		    endif

		    ; unequip weapons
		    Weapon wleft = BimboActor.GetEquippedWeapon(0)
		    Weapon wright = BimboActor.GetEquippedWeapon(1)
		    if (wleft != None)
		        BimboActor.UnequipItem(wleft, 0)
		    endif
		    if (wright != None)
		        BimboActor.UnequipItem(wright, 1)
		    endif

		EndIf



	EndIf

EndEvent


Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	; Safeguard - Exit if alias not set
	if (BimboAliasRef == None)
		Return
	Endif

	BimboActor= BimboAliasRef.GetReference() as Actor
    
 	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == 0)
		Return
	Endif
	
   Debug.Trace("[SLH] Bimbo received something - " + aiItemCount + "x " + akBaseItem.GetName() + " from the world")

	; debug.Notification("[SLH] Bimbo received something")

      ; If ( (akBaseItem as Armor) == HypnosisCircletArmor  )
      ;  BimboActor.Equipitem(HypnosisCirclet)
      ; EndIf

    if (akBaseItem == (ReturnItem)) 
        
    	fctPolymorph.bimboTransformEffectOFF(BimboActor)
 
        BimboActor.RemoveItem(ReturnItem, 1, True)

    EndIf
endEvent




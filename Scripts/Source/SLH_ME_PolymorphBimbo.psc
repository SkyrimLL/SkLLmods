Scriptname SLH_ME_PolymorphBimbo extends activemagiceffect  

{Transforms the player into a monster.  Created by Jared Bangerter 2012.}

;======================================================================================;

; PROPERTIES /

;=============/


Race Property PlayerOriginalRace auto

ObjectReference Property Bimbo Auto
SLH_QST_HormoneGrowth Property SLH_Control Auto

Race Property ArgonianRace auto
Race Property ArgonianRaceVampire auto
Race Property BretonRace auto
Race Property BretonRaceVampire auto
Race Property DarkElfRace auto
Race Property DarkElfRaceVampire auto
Race Property HighElfRace auto
Race Property HighElfRaceVampire auto
Race Property ImperialRace auto
Race Property ImperialRaceVampire auto
Race Property KhajiitRace auto
Race Property KhajiitRaceVampire auto
Race Property NordRace auto
Race Property NordRaceVampire auto
Race Property OrcRace auto
Race Property OrcRaceVampire auto
Race Property RedguardRace auto
Race Property RedguardRaceVampire auto
Race Property WoodElfRace auto
Race Property WoodElfRaceVampire auto

ObjectReference Property PolymorphChest  Auto  
Quest Property CompanionsTrackingQuest auto
Faction Property PlayerWerewolfFaction auto
Shout Property MonsterShout auto
Race Property PolymorphRace auto
Spell Property PolymorphSpell auto
Faction Property MonsterFaction auto
Weapon Property MonsterWeapon auto
VisualEffect Property VFX1  Auto
VisualEffect Property VFX2  Auto   
Weapon Property ReturnItem Auto
VisualEffect Property VFX3 Auto
float playerArousalRate
float PlayerHP
float PlayerMG
float PlayerST

float PlayerOneHanded   
float PlayerTwoHanded  
float PlayerMarksman  
float PlayerHeavyArmor  
float PlayerLightArmor  
float PlayerPickpocket

Spell Property TransformationSpell Auto
Spell Property TransformationEffect Auto
Spell Property DiseaseSanguinareVampiris Auto
Spell Property VampireSunDamage01 auto
Spell Property VampireSunDamage02 auto
Spell Property VampireSunDamage03 auto
Spell Property VampireSunDamage04 auto

Spell Property PolymorphBimboFX auto

Actor Player 
;======================================================================================;

; EVENTS /

;=============/
int[] _playerPresets 
float[] _playerMorphs  
int[] _bimboPresets  
float[] _bimboMorphs 

Float fRFSU = 0.1
Int   iDaysPassed 
int   iGameDateLastCheck = -1
Int   iDaysSinceLastCheck

Bool setSchlong = False
Bool isPlayerMale = False

Bool isPlayerExhibitionist = False
 
Event OnEffectStart(Actor Target, Actor Caster)
    Player = Game.GetPlayer()
    ActorBase pActorBase = Player.GetActorBase()

    ; Abort if no gender/bimbo option checked in MCM
    If (GV_allowBimbo.GetValue()==0) && (GV_allowHRT.GetValue()==0) && (GV_allowTG.GetValue()==0)
        Player.AddItem(ReturnItem, 1 , True)
        Return
    Endif

    _playerPresets = new int[4]
    _playerMorphs = new float[19]
    _bimboPresets = new int[4]
    _bimboMorphs = new float[19]

    Game.ForceThirdPerson()
 
    If (SLH_Control.isSchlongSet(Game.GetPlayer() )) ; add check for isGenderChangeON
        setSchlong = True
    endif

    if (pActorBase.GetSex() == 1) ; female
        isPlayerMale = False
    Else
        isPlayerMale = True
    EndIf        

    ; Abort is sex change is not turned on and player is Male
    If (isPlayerMale) && (GV_allowHRT.GetValue()==0) && (GV_allowTG.GetValue()==0)
        Player.AddItem(ReturnItem, 1 , True)
        Return
    EndIf

    If (!isPlayerMale) && (GV_allowBimbo.GetValue()==0)
        Player.AddItem(ReturnItem, 1 , True)
        Return
    EndIf

    SLH_Control._SaveFaceValues( Player, _playerPresets,  _playerMorphs )
    SLH_Control._SaveFaceValues( Bimbo as Actor , _bimboPresets,  _bimboMorphs )

    Player.UnequipAll()

    ; Player.RemoveAllItems(LycanStash)

	; get player's race so we have it permanently for werewolf switch back
	PlayerOriginalRace = Player.GetRace()
; 	Debug.Trace("CSQ: Storing player's race as " + PlayerOriginalRace)

	if     (PlayerOriginalRace == ArgonianRaceVampire)
; 		Debug.Trace("CSQ: Player was Argonian Vampire; storing as Argonian.")
		PlayerOriginalRace = ArgonianRace
	elseif (PlayerOriginalRace == BretonRaceVampire)
; 		Debug.Trace("CSQ: Player was Breton Vampire; storing as Breton.")
		PlayerOriginalRace = BretonRace
	elseif (PlayerOriginalRace == DarkElfRaceVampire)
; 		Debug.Trace("CSQ: Player was Dark Elf Vampire; storing as Dark Elf.")
		PlayerOriginalRace = DarkElfRace
	elseif (PlayerOriginalRace == HighElfRaceVampire)
; 		Debug.Trace("CSQ: Player was Hiegh Elf Vampire; storing as High Elf.")
		PlayerOriginalRace = HighElfRace
	elseif (PlayerOriginalRace == ImperialRaceVampire)
; 		Debug.Trace("CSQ: Player was Imperial Vampire; storing as Imperial.")
		PlayerOriginalRace = ImperialRace
	elseif (PlayerOriginalRace == KhajiitRaceVampire)
; 		Debug.Trace("CSQ: Player was Khajiit Vampire; storing as Khajiit.")
		PlayerOriginalRace = KhajiitRace
	elseif (PlayerOriginalRace == NordRaceVampire)
; 		Debug.Trace("CSQ: Player was Nord Vampire; storing as Nord.")
		PlayerOriginalRace = NordRace
	elseif (PlayerOriginalRace == OrcRaceVampire)
; 		Debug.Trace("CSQ: Player was Orc Vampire; storing as Orc.")
		PlayerOriginalRace = OrcRace
	elseif (PlayerOriginalRace == RedguardRaceVampire)
; 		Debug.Trace("CSQ: Player was Redguard Vampire; storing as Redguard.")
		PlayerOriginalRace = RedguardRace
	elseif (PlayerOriginalRace == WoodElfRaceVampire)
; 		Debug.Trace("CSQ: Player was Wood Elf Vampire; storing as Wood Elf.")
		PlayerOriginalRace = WoodElfRace
	endif

    ; 	Debug.Trace("CSQ: Storing player's race as " + PlayerOriginalRace)

    ; unequip magic
    Spell left = Player.GetEquippedSpell(0)
    Spell right = Player.GetEquippedSpell(1)
    Spell power = Player.GetEquippedSpell(2)
    Shout voice = Player.GetEquippedShout()
    if (left != None)
        Player.UnequipSpell(left, 0)
    endif
    if (right != None)
        Player.UnequipSpell(right, 1)
    endif
    if (power != None)
        ; some players are overly clever and sneak a power equip between casting
        ;  beast form and when we rejigger them there. this will teach them.
        ;         Debug.Trace("WEREWOLF: " + power + " was equipped; removing.")
        Player.UnequipSpell(power, 2)
    else
        ;         Debug.Trace("WEREWOLF: No power equipped.")
    endif
    if (voice != None)
        ; same deal here, but for shouts
        ;         Debug.Trace("WEREWOLF: " + voice + " was equipped; removing.")
        Player.UnequipShout(voice)
    else
        ;         Debug.Trace("WEREWOLF: No shout equipped.")
    endif

    if(Player.IsWeaponDrawn())
        Player.SheatheWeapon()
        Utility.Wait(2.0)
    endif

    ; unequip weapons
    Weapon wleft = Player.GetEquippedWeapon(0)
    Weapon wright = Player.GetEquippedWeapon(1)
    if (left != None)
        Player.UnequipItem(wleft, 0)
    endif
    if (right != None)
        Player.UnequipItem(wright, 1)
    endif
   


    if (GV_allowBimbo.GetValue()==1) &&  (Target.GetActorBase().GetRace() != PolymorphRace)
        Debug.SetGodMode(true)
        Player.ResetHealthAndLimbs()

        Player.RestoreActorValue("magicka", 999999999999)
        Player.RestoreActorValue("stamina", 999999999999)
        Player.RestoreActorValue("health", 999999999999)

        Player.DispelSpell (DiseaseSanguinareVampiris)
        Player.DispelSpell (VampireSunDamage01)
        Player.DispelSpell (VampireSunDamage02)
        Player.DispelSpell (VampireSunDamage03)
        Player.DispelSpell (VampireSunDamage04)

        ;======= CHANGING RACE HERE
        Player.SetRace(PolymorphRace)
        ;=======

        Player.SetHeadTracking(false)
        Player.AddSpell(SPELLCLEAR1)
        Player.EquipSpell(SPELLCLEAR1, 0)
        Player.AddSpell(SPELLCLEAR2)
        Player.EquipSpell(SPELLCLEAR2, 1)
        Player.AddItem(WEAPONCLEAR1)
        Player.EquipItem(WEAPONCLEAR1, 0)
        Player.AddItem(WEAPONCLEAR2)
        Player.EquipItem(WEAPONCLEAR2, 1)
        ; Player.EquipSpell(PolymorphSpell, 1)
        ; Player.AddSpell(PolymorphSpell)
        ; Player.EquipSpell(PolymorphSpell, 1)
        Player.AddToFaction(MonsterFaction)
        ; Player.AddItem(MonsterWeapon, 0, true)
        ; Player.EquipItem(MonsterWeapon, 0, true)
        ; Player.AddItem(MonsterAmmo, 99, true)
        ; Player.EquipItem(MonsterAmmo, 99, true)
        ; Player.AddItem(MonsterArmor, 1, true)
        ; Player.EquipItem(MonsterArmor, 1, true)
        ; Game.DisablePlayerControls(false, false, false, false, false, true, false)
        ; Game.SetPlayerReportCrime(false)
        ; Player.SetAttackActorOnSight(true)
        ; Player.AddToFaction(PlayerWerewolfFaction)
        ; Player.AddShout(MonsterShout)
        ; Player.EquipShout(MonsterShout)

        isPlayerExhibitionist = slaUtil.IsActorExhibitionist(Player)
        playerArousalRate = slaUtil.GetActorExposureRate(Player)
        slaUtil.SetActorExhibitionist(Player, True)

        if (playerArousalRate < 8.0 )
            slaUtil.SetActorExposureRate(Player, 8.0)
        Endif
   
        int iTmpAV 
        iTmpAV = Player.GetActorValue("health") as int
        PlayerHP = iTmpAV

        iTmpAV = Player.GetActorValue("magicka") as int
        PlayerMG = iTmpAV

        iTmpAV = Player.GetActorValue("stamina") as int
        PlayerST = iTmpAV

        iTmpAV = Player.GetActorValue("OneHanded") as int 
        PlayerOneHanded = iTmpAV 

        iTmpAV = Player.GetActorValue("TwoHanded") as int 
        PlayerTwoHanded = iTmpAV  

        iTmpAV = Player.GetActorValue("Marksman") as int  
        PlayerMarksman = iTmpAV  

        iTmpAV = Player.GetActorValue("HeavyArmor") as int   
        PlayerHeavyArmor = iTmpAV  

        iTmpAV = Player.GetActorValue("LightArmor") as int  
        PlayerLightArmor = iTmpAV  

        iTmpAV = Player.GetActorValue("Pickpocket") as int 
        PlayerPickpocket = iTmpAV

        Player.SetActorValue("health", (PlayerHP/4 + HP))
        Player.SetActorValue("magicka", (PlayerMG/4 + Magicka))
        Player.SetActorValue("stamina", (PlayerST/4 + Stamina))
        Player.SetActorValue("healrate", 1)

        Player.SetActorValue("OneHanded", PlayerOneHanded / 5)
        Player.SetActorValue("TwoHanded", PlayerTwoHanded / 3)
        Player.SetActorValue("Marksman", PlayerMarksman / 2) 
        Player.SetActorValue("HeavyArmor", PlayerHeavyArmor / 5)  
        Player.SetActorValue("LightArmor", PlayerLightArmor / 2) 
        Player.SetActorValue("Pickpocket", PlayerPickpocket * 3)

        Player.RestoreActorValue("health", 999999999999)
        ; VFX1.Play(Caster)
        ; VFX2.Play(Caster)
        Debug.SetGodMode(false)

        BimboAliasRef.ForceRefTo(Player as ObjectReference)

        ; debug.messagebox("[SLH] Casting long term effect: " + TransformationEffect.GetName())
        ; TransformationEffect.Cast(Player,Player)
        ; Player.DoCombatSpellApply(TransformationEffect, Player)

        ; SprigganFX.Play( Player, 30 )
    Endif

    Debug.Messagebox("A heatwave of pure lust suddenly rips through your body, molding your features and turning your skin into liquid fire. The shock leaves you breathless... light headed... panting even.")
    Debug.Messagebox("[Technical note - Once the transformation is complete, you should reset SexLab using the Clean Up option.]")

    If (isPlayerMale) && ((GV_allowHRT.GetValue()==1) || (GV_allowTG.GetValue()==1))
        ; Male to Female if Sex Change is allowed (HRT)  
        ConsoleUtil.ExecuteCommand("player.sexchange")

        If (GV_allowBimbo.GetValue()==1)
            SLH_Control._LoadFaceValues( Player, _bimboPresets,  _bimboMorphs ) 
            SLH_Control._setHormonesStateDefault()

            GV_isBimbo.SetValue(1)
            StorageUtil.SetIntValue(Player, "_SLH_iBimbo", 1)

            StorageUtil.SetIntValue(Player, "_SD_iSlaveryLevel", 6)
            StorageUtil.SetIntValue( Player , "_SD_iDom", 0)
            StorageUtil.SetIntValue( Player , "_SD_iSub", -10)

        else
            GV_isBimbo.SetValue(0)
            StorageUtil.SetIntValue(Player, "_SLH_iBimbo", 0)
        endif

        if (GV_allowTG.GetValue()==1)                
            Player.SendModEvent("SLHSetSchlong", "UNP Bimbo")
            GV_isTG.SetValue(1)
            StorageUtil.SetIntValue(Player, "_SLH_iTG", 1)
        Else
            Player.SendModEvent("SLHRemoveSchlong")
            Sexlab.TreatAsFemale(Player)
            GV_isTG.SetValue(0)
            StorageUtil.SetIntValue(Player, "_SLH_iTG", 0)
        endif

        if (GV_allowHRT.GetValue()==1)
            GV_isHRT.SetValue(1)
            StorageUtil.SetIntValue(Player, "_SLH_iHRT", 1)
        endif

    elseif (!isPlayerMale)
        ; Female to Female 

        If (GV_allowBimbo.GetValue()==1)
            SLH_Control._LoadFaceValues( Player, _bimboPresets,  _bimboMorphs ) 
            GV_isBimbo.SetValue(1)
            StorageUtil.SetIntValue(Player, "_SLH_iBimbo", 1)
        else
            GV_isBimbo.SetValue(0)
            StorageUtil.SetIntValue(Player, "_SLH_iBimbo", 0)
        endif

        if (GV_allowTG.GetValue()==1)
            Player.SendModEvent("SLHSetSchlong", "UNP Bimbo")
            StorageUtil.SetFloatValue(none, "_SLH_fSchlong", (SLH_Control.GV_schlongMin.GetValue() as Float) ) 
            SendModEvent("SLHRefresh")

            Sexlab.TreatAsMale(Player)
            GV_isTG.SetValue(1)
            StorageUtil.SetIntValue(Player, "_SLH_iTG", 1)
        else
            Sexlab.TreatAsFemale(Player)
            GV_isTG.SetValue(0)
            StorageUtil.SetIntValue(Player, "_SLH_iTG", 0)
        endif

        GV_isHRT.SetValue(0)
        StorageUtil.SetIntValue(Player, "_SLH_iHRT", 0)

    endif

    StorageUtil.SetIntValue(Player, "_SLH_bimboTransformDate", Game.QueryStat("Days Passed"))
    StorageUtil.SetIntValue(Player, "_SLH_bimboTransformGameDays", 0)   

    Game.ShowRaceMenu()

    RegisterForSingleUpdate( fRFSU )

EndEvent

Event OnUpdate()
    iDaysPassed = Game.QueryStat("Days Passed")

    if (iGameDateLastCheck == -1)
        iGameDateLastCheck = iDaysPassed
    EndIf

    iDaysSinceLastCheck = (iDaysPassed - iGameDateLastCheck ) as Int

    ; Exit conditions
    If (iDaysSinceLastCheck >= 1)
        Debug.Notification( "[SLH] Bimbo status update"  )
    ;     Player.AddItem(ReturnItem, 1 , True)

        ; StorageUtil.SetFloatValue(none, "_SLH_fBreast", 0.8 ) 
        ; StorageUtil.SetFloatValue(none, "_SLH_fBelly", 0.8 ) 
        ; StorageUtil.SetFloatValue(none, "_SLH_fWeight", 0 ) 
        If (GV_isTG.GetValue() == 1) && (isPlayerMale) && !_SLH_QST_Bimbo.IsStageDone(14)
            _SLH_QST_Bimbo.SetStage(14)
        ElseIf (GV_isTG.GetValue() == 1) && (!isPlayerMale) && !_SLH_QST_Bimbo.IsStageDone(12)
            _SLH_QST_Bimbo.SetStage(12)
        Endif

        If (GV_isTG.GetValue() == 1) && (isPlayerMale) && !_SLH_QST_Bimbo.IsStageDone(18)
            if (StorageUtil.GetFloatValue(none, "_SLH_fSchlong") >= (SLH_Control.GV_schlongMin.GetValue() as Float) ) 
                StorageUtil.SetFloatValue(none, "_SLH_fSchlong", StorageUtil.GetFloatValue(none, "_SLH_fSchlong") * 0.8 - 0.1) 
                SendModEvent("SLHRefresh")
            else
                Player.SendModEvent("SLHRemoveSchlong")
                Sexlab.TreatAsFemale(Player)
                _SLH_QST_Bimbo.SetStage(18)
            endif

        ElseIf (GV_isTG.GetValue() == 1) && (!isPlayerMale) && !_SLH_QST_Bimbo.IsStageDone(16)
            if (StorageUtil.GetFloatValue(none, "_SLH_fSchlong") <= (SLH_Control.GV_schlongMax.GetValue() as Float) ) 
                StorageUtil.SetFloatValue(none, "_SLH_fSchlong", 0.1 + StorageUtil.GetFloatValue(none, "_SLH_fSchlong") * 1.2 ) 
                SendModEvent("SLHRefresh")
                _SLH_QST_Bimbo.SetStage(16)
            endif

        endif

        iGameDateLastCheck = iDaysPassed

    Endif

    If (StorageUtil.GetIntValue(Player, "_SD_iSlaveryLevel") != 6)
        StorageUtil.SetIntValue(Player, "_SD_iSlaveryExposure", 150)
        StorageUtil.SetIntValue(Player, "_SD_iSlaveryLevel", 6)
    EndIf
        
    If (StorageUtil.GetIntValue(Player, "_SD_iDom") != 0)
        StorageUtil.SetIntValue(Player, "_SD_iDom", 0)
    EndIf
        
    RegisterForSingleUpdate( fRFSU )
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
    Player = Game.GetPlayer()

    if (akBaseItem == (ReturnItem)) 
        Player.RemoveItem(ReturnItem, 1, True)

        If (GV_allowBimbo.GetValue()==1) && (GV_isBimbo.GetValue()==1)
            Debug.Trace("I picked up " + aiItemCount + "x " + akBaseItem + " from the world")
            ; TransformationEffect.Cast(Player,Player)

    	    PolymorphBimboFX.Cast(Player,Player) 
      
            ; Player.RemoveSpell(PolymorphSpell)
            ; Player.UnEquipSpell(PolymorphSpell, 0)
            Player.RemoveFromFaction(MonsterFaction)
            ; Player.RemoveItem(MonsterWeapon)
            ; Player.UnEquipItem(MonsterWeapon, 1)
            ; Player.RemoveShout(MonsterShout)
            ; Player.UnEquipShout(MonsterShout)
            ; Player.RemoveItem(MonsterAmmo, 99)
            ; Player.UnEquipItem(MonsterAmmo)
            ; Player.RemoveItem(MonsterArmor)
            ; Player.UnEquipItem(MonsterArmor)
            Player.AddSpell(SPELLCLEAR1)
            Player.EquipSpell(SPELLCLEAR1, 0)
            Player.AddSpell(SPELLCLEAR2)
            Player.EquipSpell(SPELLCLEAR2, 1)
            Player.AddItem(WEAPONCLEAR1)
            Player.EquipItem(WEAPONCLEAR1, 0)
            Player.AddItem(WEAPONCLEAR2)
            Player.EquipItem(WEAPONCLEAR2, 1)
            Game.EnablePlayerControls()
            Game.SetPlayerReportCrime(true)
            Player.SetAttackActorOnSight(false)
            Player.RemoveFromFaction(PlayerWerewolfFaction)
            Debug.Trace("[SLH] Bimbo - Setting race " + (CompanionsTrackingQuest as CompanionsHousekeepingScript).PlayerOriginalRace + " on " + Player)

            ; VFX3.Play(Player, afTime = 3)
            ; VFX1.Stop(Player)
            ; VFX2.Stop(Player)
            ; Player.DispelSpell(TransformationEffect)
            

            Player.SetRace(PlayerOriginalRace)

            if (!isPlayerExhibitionist)
                slaUtil.SetActorExhibitionist(Player, False)
            EndIf

            slaUtil.SetActorExposureRate(Player, playerArousalRate)

            Player.SetActorValue("health", (PlayerHP))
            Player.SetActorValue("magicka", (PlayerMG))
            Player.SetActorValue("stamina", (PlayerST))
            Player.SetActorValue("healrate", 1)
            Player.RestoreActorValue("health", 999999999999999999999999999)

            Player.SetActorValue("OneHanded", PlayerOneHanded)
            Player.SetActorValue("TwoHanded", PlayerTwoHanded)
            Player.SetActorValue("Marksman", PlayerMarksman)
            Player.SetActorValue("HeavyArmor", PlayerHeavyArmor)
            Player.SetActorValue("LightArmor", PlayerLightArmor)
            Player.SetActorValue("Pickpocket", PlayerPickpocket)
            
            Player.SetScale (1.0)

            SprigganFX.Play( Player, 30 )

            BimboAliasRef.ForceRefTo(None)

            Debug.Messagebox("The heatwave returns... hopefully restoring most of your normal self.")

        Endif

        StorageUtil.SetIntValue(Player, "_SLH_bimboTransformDate", Game.QueryStat("Days Passed"))
        StorageUtil.SetIntValue(Player, "_SLH_bimboTransformGameDays", 0)   

        If (isPlayerMale) && (GV_allowHRT.GetValue()==1)
            ; MiscUtil.ExecuteBat("SLH_sexchange.bat")
            ConsoleUtil.ExecuteCommand("player.sexchange")

            If (GV_allowBimbo.GetValue()==1)
                SLH_Control._LoadFaceValues( Player, _playerPresets,  _playerMorphs ) 
                GV_isBimbo.SetValue(0)
                StorageUtil.SetIntValue(Player, "_SLH_iBimbo", 0)
            endif

            if (GV_allowTG.GetValue()==1)
                Player.SendModEvent("SLHSetSchlong", "")
                GV_isTG.SetValue(0)
                StorageUtil.SetIntValue(Player, "_SLH_iTG", 0)
            endif

            GV_isHRT.SetValue(0)
            StorageUtil.SetIntValue(Player, "_SLH_iHRT", 0)

            ; Debug.Messagebox("[Remember to change the sex of your character in the Racemenu or later in the console using 'sexchange' or armors will still show with the female model on your male form].")

            SLH_Control._resetHormonesState()

            Game.ShowLimitedRaceMenu()


        elseif (!isPlayerMale)
            ; Female to Female 

            If (GV_allowBimbo.GetValue()==1)
                SLH_Control._LoadFaceValues( Player, _playerPresets,  _playerMorphs )  
                GV_isBimbo.SetValue(0)
                StorageUtil.SetIntValue(Player, "_SLH_iBimbo", 0) 
            endif

            if (GV_allowTG.GetValue()==1)
                Player.SendModEvent("SLHRemoveSchlong")
                Sexlab.TreatAsFemale(Player)
                GV_isTG.SetValue(0)
                StorageUtil.SetIntValue(Player, "_SLH_iTG", 0)
            endif

            GV_isHRT.SetValue(0)
            StorageUtil.SetIntValue(Player, "_SLH_iHRT", 0)

            SLH_Control._resetHormonesState()

            Game.ShowRaceMenu()

        endif                


     	; Player.RegenerateHead()
     	; Player.QueueNiNodeUpdate()

    EndIf
endEvent

slaUtilScr Property slaUtil  Auto  


Ammo Property MonsterAmmo Auto
Armor Property MonsterArmor Auto
SPELL Property SPELLCLEAR1  Auto  
SPELL Property SPELLCLEAR2  Auto  
WEAPON Property WEAPONCLEAR1  Auto  
WEAPON Property WEAPONCLEAR2  Auto  
Int Property HP  Auto  
Int Property Magicka  Auto  
Int Property Stamina  Auto  

VisualEffect Property SprigganFX  Auto  
 
SexLabFramework Property SexLab  Auto  

GlobalVariable      Property GV_isTG                   Auto
GlobalVariable      Property GV_isHRT                   Auto
GlobalVariable      Property GV_isBimbo                 Auto
GlobalVariable      Property GV_allowTG                Auto
GlobalVariable      Property GV_allowHRT                Auto
GlobalVariable      Property GV_allowBimbo              Auto
ReferenceAlias Property BimboAliasRef  Auto  


Quest Property _SLH_QST_Bimbo  Auto  
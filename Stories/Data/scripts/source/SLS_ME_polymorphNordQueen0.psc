Scriptname SLS_ME_polymorphNordQueen0 extends activemagiceffect  

{Transforms the player into a monster.  Created by Jared Bangerter 2012.}

;======================================================================================;

; PROPERTIES /

;=============/

Race Property PlayerOriginalRace auto

Race Property NordRace auto
Race Property NordRaceVampire auto


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
float PlayerHP
float PlayerMG
float PlayerST
Spell Property TransformationSpell Auto
Spell Property TransformationEffect Auto


Actor Player 
;======================================================================================;

; EVENTS /

;=============/

Float fRFSU = 0.1
Int   iDaysPassed 
int   iGameDateLastCheck = -1
Int   iDaysSinceLastCheck

Event OnEffectStart(Actor Target, Actor Caster)
    Player = Game.GetPlayer()

    if (Target.GetActorBase().GetRace() != PolymorphRace)
        TransformationEffect.Cast(Player,Player)
        Player.UnequipAll()

        ; Player.RemoveAllItems(LycanStash)

    	; get player's race so we have it permanently for werewolf switch back
    	PlayerOriginalRace = Player.GetRace()
    ; 	Debug.Trace("CSQ: Storing player's race as " + PlayerOriginalRace)

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

     ; unequip weapons
        Weapon wleft = Player.GetEquippedWeapon(0)
        Weapon wright = Player.GetEquippedWeapon(1)
        if (left != None)
            Player.UnequipItem(wleft, 0)
        endif
        if (right != None)
            Player.UnequipItem(wright, 1)
        endif
       
        Debug.SetGodMode(true)
        Player.ResetHealthAndLimbs()

        Game.ForceThirdPerson()

        Player.RestoreActorValue("magicka", 999999999999)
        Player.RestoreActorValue("stamina", 999999999999)
        Player.RestoreActorValue("health", 999999999999)
        Target.SetRace(PolymorphRace)
        Player.SetHeadTracking(false)
        Player.AddSpell(SPELLCLEAR1)
        Player.EquipSpell(SPELLCLEAR1, 0)
        Player.AddSpell(SPELLCLEAR2)
        Player.EquipSpell(SPELLCLEAR2, 1)
        Player.AddItem(WEAPONCLEAR1)
        Player.EquipItem(WEAPONCLEAR1, 0)
        Player.AddItem(WEAPONCLEAR2)
        Player.EquipItem(WEAPONCLEAR2, 1)
        Player.EquipSpell(PolymorphSpell, 1)
        Player.AddSpell(PolymorphSpell)
        Player.EquipSpell(PolymorphSpell, 1)
        Player.AddToFaction(MonsterFaction)
        Player.AddItem(MonsterWeapon, 0, true)
        Player.EquipItem(MonsterWeapon, 0, true)
        Player.AddItem(MonsterAmmo, 99, true)
        Player.EquipItem(MonsterAmmo, 99, true)
        Player.AddItem(MonsterArmor, 1, true)
        Player.EquipItem(MonsterArmor, 1, true)
        ; Game.DisablePlayerControls(false, false, false, false, false, true, false)
        Game.SetPlayerReportCrime(false)
        Player.SetAttackActorOnSight(true)
        Player.AddToFaction(PlayerWerewolfFaction)
        Player.AddShout(MonsterShout)
        Player.EquipShout(MonsterShout)
        int playersHealth = Player.GetActorValue("health") as int
        PlayerHP = playersHealth
        int playersMagicka = Player.GetActorValue("magicka") as int
        PlayerMG = playersMagicka
        int playersStamina = Player.GetActorValue("stamina") as int
        PlayerST = playersStamina
        Player.SetActorValue("health", (PlayerHP/4 + HP))
        Player.SetActorValue("magicka", (PlayerMG/4 + Magicka))
        Player.SetActorValue("stamina", (PlayerST/4 + Stamina))
        Player.SetActorValue("healrate", 1)
        Player.RestoreActorValue("health", 999999999999)
        VFX1.Play(Caster)
        VFX2.Play(Caster)
        Debug.SetGodMode(false)

        SprigganFX.Play( Player, 30 )

        If StorageUtil.HasIntValue(Player, "_SLSL_iNordQueenPolymorphStage")
            StorageUtil.SetIntValue(Player, "_SLSL_iNordQueenPolymorphStage", StorageUtil.GetIntValue(Player, "_SLSL_iNordQueenPolymorphStage") + 1)
        Else
            StorageUtil.SetIntValue(Player, "_SLSL_iNordQueenPolymorphStage", 1)
        EndIf

        RegisterForSingleUpdate( fRFSU )

    endif
EndEvent

Event OnUpdate()
    iDaysPassed = Game.QueryStat("Days Passed")

    if (iGameDateLastCheck == -1)
        iGameDateLastCheck = iDaysPassed
    EndIf

    iDaysSinceLastCheck = (iDaysPassed - iGameDateLastCheck ) as Int
    ; Debug.Notification( "[SD] Player status - days: " + iDaysSinceLastCheck + " > " + StorageUtil.GetIntValue(Player, "_SD_iSprigganTransformCount") )

    If (iDaysSinceLastCheck >= StorageUtil.GetIntValue(Player, "_SLSL_iNordQueenPolymorphStage"))
        Player.AddItem(ReturnItem, 1 , True)
    Endif

    RegisterForSingleUpdate( fRFSU )
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
    Player = Game.GetPlayer()

    if akBaseItem == (ReturnItem)
        Debug.Trace("I picked up " + aiItemCount + "x " + akBaseItem + " from the world")
         TransformationEffect.Cast(Player,Player)
  
        Player.RemoveItem(ReturnItem, 1, True)
        Player.RemoveSpell(PolymorphSpell)
        Player.UnEquipSpell(PolymorphSpell, 0)
        Player.RemoveFromFaction(MonsterFaction)
        Player.RemoveItem(MonsterWeapon)
        Player.UnEquipItem(MonsterWeapon, 1)
        Player.RemoveShout(MonsterShout)
        Player.UnEquipShout(MonsterShout)
        Player.RemoveItem(MonsterAmmo, 99)
        Player.UnEquipItem(MonsterAmmo)
        Player.RemoveItem(MonsterArmor)
        Player.UnEquipItem(MonsterArmor)
        Player.AddSpell(SPELLCLEAR1)
        Player.EquipSpell(SPELLCLEAR1, 0)
        Player.AddSpell(SPELLCLEAR2)
        Player.EquipSpell(SPELLCLEAR2, 1)
        Player.AddItem(WEAPONCLEAR1)
        Player.EquipItem(WEAPONCLEAR1, 0)
        Player.AddItem(WEAPONCLEAR2)
        Player.EquipItem(WEAPONCLEAR2, 1)
        ; Game.EnablePlayerControls()
        Game.SetPlayerReportCrime(true)
        Player.SetAttackActorOnSight(false)
        Player.RemoveFromFaction(PlayerWerewolfFaction)
        Debug.Trace("WEREWOLF: Setting race " + (CompanionsTrackingQuest as CompanionsHousekeepingScript).PlayerOriginalRace + " on " + Player)
        VFX3.Play(Player, afTime = 3)
        Player.SetRace(PlayerOriginalRace)
        Player.SetActorValue("health", (PlayerHP))
        Player.SetActorValue("magicka", (PlayerMG))
        Player.SetActorValue("stamina", (PlayerST))
        Player.SetActorValue("healrate", 1)
        VFX1.Stop(Player)
        VFX2.Stop(Player)
        Player.RestoreActorValue("health", 999999999999999999999999999)
        Player.DispelSpell(TransformationSpell)
        
        Player.SetScale (1.0)

        SprigganFX.Play( Player, 30 )

        if (StorageUtil.GetIntValue(Player, "_SLSL_iNordQueenPolymorphStage")==1)
           Player.DoCombatSpellApply(NordicQueenPolymorph1, Player)  
        elseif (StorageUtil.GetIntValue(Player, "_SLSL_iNordQueenPolymorphStage")==2)
           Player.DoCombatSpellApply(NordicQueenPolymorph2, Player)  
       endif
    endif
endEvent



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

SPELL Property NordicQueenPolymorph1  Auto  
SPELL Property NordicQueenPolymorph2  Auto  
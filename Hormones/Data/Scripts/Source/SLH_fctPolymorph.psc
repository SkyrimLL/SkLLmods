Scriptname SLH_fctPolymorph extends Quest  

Import Utility
Import Math

SLH_fctBodyShape Property fctBodyShape Auto
SLH_fctColor Property fctColor Auto
SLH_fctUtil Property fctUtil Auto

slaUtilScr Property slaUtil  Auto  
SexLabFramework Property SexLab  Auto  

SLH_QST_HormoneGrowth Property SLH_Control Auto
SLH_QST_BimboAlias Property SLH_BimboControl Auto

Quest Property _SLH_QST_Bimbo  Auto  

ReferenceAlias Property BimboAliasRef  Auto  

ObjectReference Property Bimbo Auto
ObjectReference Property PolymorphChest  Auto  

GlobalVariable      Property GV_isBimboFinal                 Auto
GlobalVariable      Property GV_isBimboLocked                 Auto

Race Property ActorOriginalRace auto
Race Property PolymorphRace auto

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

Quest Property CompanionsTrackingQuest auto

Faction Property actorWerewolfFaction auto
Faction Property MonsterFaction auto

Shout Property MonsterShout auto

Spell Property PolymorphSpell auto
Spell Property PolymorphBimboFX auto
Spell Property TransformationSpell Auto
Spell Property TransformationEffect Auto
Spell Property DiseaseSanguinareVampiris Auto
Spell Property VampireSunDamage01 auto
Spell Property VampireSunDamage02 auto
Spell Property VampireSunDamage03 auto
Spell Property VampireSunDamage04 auto
SPELL Property SPELLCLEAR1  Auto  
SPELL Property SPELLCLEAR2  Auto  

VisualEffect Property VFX1  Auto
VisualEffect Property VFX2  Auto   
VisualEffect Property VFX3 Auto
VisualEffect Property SprigganFX  Auto  
 
Weapon Property ReturnItem Auto
Weapon Property MonsterWeapon auto
WEAPON Property WEAPONCLEAR1  Auto  
WEAPON Property WEAPONCLEAR2  Auto  

Ammo Property MonsterAmmo Auto

Armor Property MonsterArmor Auto

Int Property HP  Auto  
Int Property Magicka  Auto  
Int Property Stamina  Auto  

ObjectReference Property BimboDummyRef  Auto  

GlobalVariable      Property GV_isTG                   Auto
GlobalVariable      Property GV_isHRT                   Auto
GlobalVariable      Property GV_isBimbo                 Auto
GlobalVariable      Property GV_allowTG                Auto
GlobalVariable      Property GV_allowHRT                Auto
GlobalVariable      Property GV_allowBimbo              Auto
GlobalVariable      Property GV_allowBimboRace              Auto
GlobalVariable      Property GV_isPolymorphON           Auto

GlobalVariable      Property GV_allowExhibitionist      Auto 

float actorArousalRate
float actorHP
float actorMG
float actorST

float actorOneHanded   
float actorTwoHanded  
float actorMarksman  
float actorHeavyArmor  
float actorLightArmor  
float actorPickpocket

int[] _actorPresets 
float[] _actorMorphs  
int[] _bimboPresets  
float[] _bimboMorphs 

Int   iDaysPassed 
int   iGameDateLastCheck = -1
Int   iDaysSinceLastCheck

Bool setSchlong = False
Bool isActorMale = False

Bool isActorExhibitionist = False

Bool function bimboTransformEffectON(actor kActor)
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()

    GV_allowTG.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowTG") as Int)
    GV_allowHRT.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowHRT") as Int)
    GV_allowBimbo.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowBimbo") as Int)

    isActorMale = fctUtil.isMale(kActor)

    ; Abort if no gender/bimbo option checked in MCM
    If (GV_allowBimbo.GetValue()==0) 
        debugTrace(" Bimbo Transform Aborted - Bimbo curse is OFF")
       Return False
    Endif

    If ((GV_allowHRT.GetValue()==0) && (isActorMale))
        debugTrace(" Bimbo Transform Aborted - Player is male and sex change is OFF")
        Return False
    Endif

    ;; Abort if enslaved - to preserve slave related variables
    If (StorageUtil.GetIntValue(kActor, "_SD_iEnslaved") == 1)
        debugTrace(" Bimbo Transform Aborted - Player is enslaved")
        Return False
    endif

    StorageUtil.SetIntValue(none, "_SLH_bimboIsOriginalActorMale", isActorMale as Int)

    debugTrace(" Bimbo Transform Init")
    debugTrace(" Bimbo Transform ON")

    ActorOriginalRace = kActor.GetRace()
    StorageUtil.SetFormValue(none, "_SLH_bimboOriginalActor", kActor)           
    StorageUtil.SetFormValue(none, "_SLH_bimboOriginalRace", ActorOriginalRace)           

    Game.ForceThirdPerson()
    TransformationEffect.Cast(kActor,kActor)
 
    If (fctBodyShape.isSchlongSet(kActor )) ; add check for isGenderChangeON
        setSchlong = True
    endif

    ; kActor.UnequipAll()

    ; kActor.RemoveAllItems(LycanStash)

    ; 	debugTrace("CSQ: Storing actor's race as " + ActorOriginalRace)

    ; unequip magic
    Spell left = kActor.GetEquippedSpell(0)
    Spell right = kActor.GetEquippedSpell(1)
    Spell power = kActor.GetEquippedSpell(2)
    Shout voice = kActor.GetEquippedShout()
    if (left != None)
        kActor.UnequipSpell(left, 0)
    endif
    if (right != None)
        kActor.UnequipSpell(right, 1)
    endif
    if (power != None)
        ; some actors are overly clever and sneak a power equip between casting
        ;  beast form and when we rejigger them there. this will teach them.
        ;         debugTrace("WEREWOLF: " + power + " was equipped; removing.")
        kActor.UnequipSpell(power, 2)
    else
        ;         debugTrace("WEREWOLF: No power equipped.")
    endif
    if (voice != None)
        ; same deal here, but for shouts
        ;         debugTrace("WEREWOLF: " + voice + " was equipped; removing.")
        kActor.UnequipShout(voice)
    else
        ;         debugTrace("WEREWOLF: No shout equipped.")
    endif

    if(kActor.IsWeaponDrawn())
        kActor.SheatheWeapon()
        Utility.Wait(2.0)
    endif

    ; unequip weapons
    Weapon wleft = kActor.GetEquippedWeapon(0)
    Weapon wright = kActor.GetEquippedWeapon(1)
    if (wleft != None)
        kActor.UnequipItem(wleft, 0)
    endif
    if (wright != None)
        kActor.UnequipItem(wright, 1)
    endif
   

    If (isActorMale) 
        ; Do not switch sex for female -> bimbo
        Utility.Wait(1.0)
        HRTEffectON( kActor)

        Utility.Wait(1.0)
        TGEffectON( kActor)

        StorageUtil.SetFloatValue(kActor, "_SLH_fWeight",  0.0)
        StorageUtil.SetFloatValue(kActor, "_SLH_fBreast",  0.9)
        StorageUtil.SetFloatValue(kActor, "_SLH_fButt",  0.9)

    ElseIf (!isActorMale) && (GV_allowBimbo.GetValue()==0)
        ; Allow sex change if bimbo effect is OFF
        Utility.Wait(1.0)
        HRTEffectON( kActor)

        Utility.Wait(1.0)
        TGEffectON( kActor)

    ElseIf (!isActorMale) 
        ; Allow sex change if bimbo effect is OFF

        Utility.Wait(1.0)
        TGEffectON( kActor)

    EndIf

    If (GV_allowBimboRace.GetValue()==1)
        _actorPresets = new int[4]
        _actorMorphs = new float[19]
        _bimboPresets = new int[4]
        _bimboMorphs = new float[19]

        fctBodyShape.SaveFaceValues( kActor, _actorPresets,  _actorMorphs )
        fctBodyShape.SaveFaceValues( Bimbo as Actor , _bimboPresets,  _bimboMorphs )

        ; get actor's race so we have it permanently for werewolf switch back
        ; ActorOriginalRace = kActor.GetRace()
        ;   debugTrace("CSQ: Storing actor's race as " + ActorOriginalRace)

        if     (ActorOriginalRace == ArgonianRaceVampire)
        ;       debugTrace("CSQ: actor was Argonian Vampire; storing as Argonian.")
            ActorOriginalRace = ArgonianRace
        elseif (ActorOriginalRace == BretonRaceVampire)
        ;       debugTrace("CSQ: actor was Breton Vampire; storing as Breton.")
            ActorOriginalRace = BretonRace
        elseif (ActorOriginalRace == DarkElfRaceVampire)
        ;       debugTrace("CSQ: actor was Dark Elf Vampire; storing as Dark Elf.")
            ActorOriginalRace = DarkElfRace
        elseif (ActorOriginalRace == HighElfRaceVampire)
        ;       debugTrace("CSQ: actor was Hiegh Elf Vampire; storing as High Elf.")
            ActorOriginalRace = HighElfRace
        elseif (ActorOriginalRace == ImperialRaceVampire)
        ;       debugTrace("CSQ: actor was Imperial Vampire; storing as Imperial.")
            ActorOriginalRace = ImperialRace
        elseif (ActorOriginalRace == KhajiitRaceVampire)
        ;       debugTrace("CSQ: actor was Khajiit Vampire; storing as Khajiit.")
            ActorOriginalRace = KhajiitRace
        elseif (ActorOriginalRace == NordRaceVampire)
        ;       debugTrace("CSQ: actor was Nord Vampire; storing as Nord.")
            ActorOriginalRace = NordRace
        elseif (ActorOriginalRace == OrcRaceVampire)
        ;       debugTrace("CSQ: actor was Orc Vampire; storing as Orc.")
            ActorOriginalRace = OrcRace
        elseif (ActorOriginalRace == RedguardRaceVampire)
        ;       debugTrace("CSQ: actor was Redguard Vampire; storing as Redguard.")
            ActorOriginalRace = RedguardRace
        elseif (ActorOriginalRace == WoodElfRaceVampire)
        ;       debugTrace("CSQ: actor was Wood Elf Vampire; storing as Wood Elf.")
            ActorOriginalRace = WoodElfRace
        endif


        if (pActorBase.GetRace() != PolymorphRace)

            Debug.SetGodMode(true)
            kActor.ResetHealthAndLimbs()

            kActor.RestoreActorValue("magicka", 999999999999)
            kActor.RestoreActorValue("stamina", 999999999999)
            kActor.RestoreActorValue("health", 999999999999)

            kActor.DispelSpell (DiseaseSanguinareVampiris)
            kActor.DispelSpell (VampireSunDamage01)
            kActor.DispelSpell (VampireSunDamage02)
            kActor.DispelSpell (VampireSunDamage03)
            kActor.DispelSpell (VampireSunDamage04)

            ;======= CHANGING RACE HERE
            debugTrace(" Bimbo Transform - Change Race")
            kActor.SetRace(PolymorphRace)
            ;=======

            kActor.SetHeadTracking(false)
            kActor.AddSpell(SPELLCLEAR1)
            kActor.EquipSpell(SPELLCLEAR1, 0)
            kActor.AddSpell(SPELLCLEAR2)
            kActor.EquipSpell(SPELLCLEAR2, 1)
            kActor.AddItem(WEAPONCLEAR1)
            kActor.EquipItem(WEAPONCLEAR1, 0)
            kActor.AddItem(WEAPONCLEAR2)
            kActor.EquipItem(WEAPONCLEAR2, 1)
            ; kActor.EquipSpell(PolymorphSpell, 1)
            ; kActor.AddSpell(PolymorphSpell)
            ; kActor.EquipSpell(PolymorphSpell, 1)
            kActor.AddToFaction(MonsterFaction)
            ; kActor.AddItem(MonsterWeapon, 0, true)
            ; kActor.EquipItem(MonsterWeapon, 0, true)
            ; kActor.AddItem(MonsterAmmo, 99, true)
            ; kActor.EquipItem(MonsterAmmo, 99, true)
            ; kActor.AddItem(MonsterArmor, 1, true)
            ; kActor.EquipItem(MonsterArmor, 1, true)
            ; Game.DisablePlayerControls(false, false, false, false, false, true, false)
            ; Game.SetPlayerReportCrime(false)
            ; kActor.SetAttackActorOnSight(true)
            ; kActor.AddToFaction(ActorWerewolfFaction)
            ; kActor.AddShout(MonsterShout)
            ; kActor.EquipShout(MonsterShout)
        EndIf

        fctBodyShape.LoadFaceValues( StorageUtil.GetFormValue(none, "_SLH_bimboOriginalActor") as Actor, _bimboPresets,  _bimboMorphs ) 
    Endif

    Int iBimboHairColor = Math.LeftShift(255, 24) + Math.LeftShift(92, 16) + Math.LeftShift(80, 8) + 80
    StorageUtil.SetIntValue(kActor, "_SLH_iHairColor", iBimboHairColor ) 

    If (GV_allowBimboRace.GetValue()==0)
        ; Using Hormones changes to compensate for lack of Bimbo race
        fctBodyshape.alterBodyByPercent(kActor, "Weight", 5.0)
        fctBodyshape.alterBodyByPercent(kActor, "Breast", 5.0)
    endif

    isActorExhibitionist = slaUtil.IsActorExhibitionist(kActor)
    actorArousalRate = slaUtil.GetActorExposureRate(kActor)

    If (GV_allowExhibitionist.GetValue() == 1) 
        slaUtil.SetActorExhibitionist(kActor, True)
    EndIf

    if (actorArousalRate < 8.0 )
        slaUtil.SetActorExposureRate(kActor, 8.0)
    Endif

    int iTmpAV 
    iTmpAV = kActor.GetActorValue("health") as int
    actorHP = iTmpAV
    StorageUtil.SetFloatValue(none, "_SLH_bimboOriginalHP", actorHP)           

    iTmpAV = kActor.GetActorValue("magicka") as int
    actorMG = iTmpAV
    StorageUtil.SetFloatValue(none, "_SLH_bimboOriginalMG", actorMG)           

    iTmpAV = kActor.GetActorValue("stamina") as int
    actorST = iTmpAV
    StorageUtil.SetFloatValue(none, "_SLH_bimboOriginalST", actorST)           

    iTmpAV = kActor.GetActorValue("OneHanded") as int 
    actorOneHanded = iTmpAV 
    StorageUtil.SetFloatValue(none, "_SLH_bimboOriginalOneHanded", actorOneHanded)           

    iTmpAV = kActor.GetActorValue("TwoHanded") as int 
    actorTwoHanded = iTmpAV  
    StorageUtil.SetFloatValue(none, "_SLH_bimboOriginalTwoHanded", actorTwoHanded)           

    iTmpAV = kActor.GetActorValue("Marksman") as int  
    actorMarksman = iTmpAV  
    StorageUtil.SetFloatValue(none, "_SLH_bimboOriginalMarksman", actorMarksman)           

    iTmpAV = kActor.GetActorValue("HeavyArmor") as int   
    actorHeavyArmor = iTmpAV  
    StorageUtil.SetFloatValue(none, "_SLH_bimboOriginalHeavyArmor", actorHeavyArmor)           

    iTmpAV = kActor.GetActorValue("LightArmor") as int  
    actorLightArmor = iTmpAV  
    StorageUtil.SetFloatValue(none, "_SLH_bimboOriginalLightArmor", actorLightArmor)           

    iTmpAV = kActor.GetActorValue("Pickpocket") as int 
    actorPickpocket = iTmpAV
    StorageUtil.SetFloatValue(none, "_SLH_bimboOriginalPickpocket", actorPickpocket)           

    kActor.SetActorValue("health", (actorHP/4 + HP))
    kActor.SetActorValue("magicka", (actorMG/4 + Magicka))
    kActor.SetActorValue("stamina", (actorST/4 + Stamina))
    kActor.SetActorValue("healrate", 1)

    kActor.SetActorValue("OneHanded", actorOneHanded / 5)
    kActor.SetActorValue("TwoHanded", actorTwoHanded / 3)
    kActor.SetActorValue("Marksman", actorMarksman / 2) 
    kActor.SetActorValue("HeavyArmor", actorHeavyArmor / 5)  
    kActor.SetActorValue("LightArmor", actorLightArmor / 2) 
    kActor.SetActorValue("Pickpocket", actorPickpocket * 3)

    kActor.RestoreActorValue("health", 999999999999)
    ; VFX1.Play(Caster)
    ; VFX2.Play(Caster)
    Debug.SetGodMode(false)

    BimboAliasRef.ForceRefTo(kActor as ObjectReference)

    SLH_Control.setHormonesStateDefault(kActor)

    ; debug.messagebox("[SLH] Casting long term effect: " + TransformationEffect.GetName())
    ; kActor.DoCombatSpellApply(TransformationEffect, kActor)

    ; SprigganFX.Play( kActor, 30 )


    Debug.Messagebox("A heatwave of pure lust suddenly rips through your body, molding your features and turning your skin into liquid fire. The shock leaves you breathless... light headed... panting even.")
    Debug.Messagebox("[Technical note - Once the transformation is complete, you should reset SexLab using the Clean Up option.]")

    SLH_Control.playMoan(kActor)

    StorageUtil.SetIntValue(kActor, "_SLH_bimboTransformDate", Game.QueryStat("Days Passed"))
    StorageUtil.SetIntValue(kActor, "_SLH_bimboTransformGameDays", 0)   

    GV_isPolymorphON.SetValue(1)
    StorageUtil.SetIntValue(kActor, "_SLH_isPolymorph", 1)   

    SLH_Control.setBimboState(kActor, TRUE)
    kActor.SendModEvent("SLHRefresh")
    ; fctColor.sendSlaveTatModEvent(kActor, "Bimbo","Feet Nails", bRefresh = True )

    SLH_BimboControl.initBimbo()

    debugTrace(" Bimbo ON")

    debugTrace(" Bimbo Curse Start - IsBimbo: " + GV_isBimbo.GetValue() as Int)
    debugTrace(" Bimbo Curse Start - IsHRT: " + GV_isHRT.GetValue() as Int)
    debugTrace(" Bimbo Curse Start - IsTG: " + GV_isTG.GetValue() as Int)

    Return True

endFunction

function bimboTransformEffectOFF(actor kActor)
    GV_allowTG.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowTG") as Int)
    GV_allowHRT.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowHRT") as Int)
    GV_allowBimbo.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowBimbo") as Int)

    ; PolymorphBimboFX.Cast(kActor,kActor) 
    debugTrace(" Bimbo Curse Shutdown - IsBimbo: " + GV_isBimbo.GetValue() as Int)
    debugTrace(" Bimbo Curse Shutdown - IsHRT: " + GV_isHRT.GetValue() as Int)
    debugTrace(" Bimbo Curse Shutdown - IsTG: " + GV_isTG.GetValue() as Int)

    If (GV_allowBimbo.GetValue()==1) && (GV_isBimbo.GetValue()==1)
        TransformationEffect.Cast(kActor,kActor)
        debugTrace(" Bimbo Transform OFF")
  
        If (GV_allowBimboRace.GetValue()==1)
            ; kActor.RemoveSpell(PolymorphSpell)
            ; kActor.UnEquipSpell(PolymorphSpell, 0)
            kActor.RemoveFromFaction(MonsterFaction)
            ; kActor.RemoveItem(MonsterWeapon)
            ; kActor.UnEquipItem(MonsterWeapon, 1)
            ; kActor.RemoveShout(MonsterShout)
            ; kActor.UnEquipShout(MonsterShout)
            ; kActor.RemoveItem(MonsterAmmo, 99)
            ; kActor.UnEquipItem(MonsterAmmo)
            ; kActor.RemoveItem(MonsterArmor)
            ; kActor.UnEquipItem(MonsterArmor)
            kActor.AddSpell(SPELLCLEAR1)
            kActor.EquipSpell(SPELLCLEAR1, 0)
            kActor.AddSpell(SPELLCLEAR2)
            kActor.EquipSpell(SPELLCLEAR2, 1)
            kActor.AddItem(WEAPONCLEAR1)
            kActor.EquipItem(WEAPONCLEAR1, 0)
            kActor.AddItem(WEAPONCLEAR2)
            kActor.EquipItem(WEAPONCLEAR2, 1)
            Game.EnablePlayerControls()
            Game.SetPlayerReportCrime(true)
            kActor.SetAttackActorOnSight(false)
            kActor.RemoveFromFaction(ActorWerewolfFaction)
            debugTrace(" Bimbo - Setting race " + (CompanionsTrackingQuest as CompanionsHousekeepingScript).PlayerOriginalRace + " on " + kActor)

            ; VFX3.Play(kActor, afTime = 3)
            ; VFX1.Stop(kActor)
            ; VFX2.Stop(kActor)
            kActor.DispelSpell(TransformationSpell)

            debugTrace(" Original race - " + ActorOriginalRace)

            ActorOriginalRace = StorageUtil.GetFormValue(none, "_SLH_bimboOriginalRace") as Race
            If (ActorOriginalRace == None)
                ; In case of upgrade while in Bimbo mode
                Debug.MessageBox("[Transformation cannot continue. Try going back to an earlier version of Hormones and update after being cured from the Bimbo curse.]")
                Return
            Endif

            kActor.SetRace(ActorOriginalRace)
            _actorPresets = new int[4]
            _actorMorphs = new float[19]
            _bimboPresets = new int[4]
            _bimboMorphs = new float[19]

            fctBodyShape.SaveFaceValues( StorageUtil.GetFormValue(none, "_SLH_bimboOriginalActor") as Actor, _actorPresets,  _actorMorphs )
            fctBodyShape.SaveFaceValues( Bimbo as Actor , _bimboPresets,  _bimboMorphs )

            fctBodyShape.LoadFaceValues( kActor, _actorPresets,  _actorMorphs ) 
        EndIf

        if (!isActorExhibitionist) && (GV_allowExhibitionist.GetValue() == 1) 
            slaUtil.SetActorExhibitionist(kActor, False)
        EndIf

        slaUtil.SetActorExposureRate(kActor, actorArousalRate)

        kActor.SetActorValue("health", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalHP") )
        kActor.SetActorValue("magicka", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalMG"))
        kActor.SetActorValue("stamina", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalST"))
        kActor.SetActorValue("healrate", 1)
        kActor.RestoreActorValue("health", 999999999999999999999999999)

        kActor.SetActorValue("OneHanded", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalOneHanded") )
        kActor.SetActorValue("TwoHanded", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalTwoHanded"))
        kActor.SetActorValue("Marksman", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalMarksman"))
        kActor.SetActorValue("HeavyArmor", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalHeavyArmor"))
        kActor.SetActorValue("LightArmor", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalLightArmor"))
        kActor.SetActorValue("Pickpocket", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalPickpocket"))
        
        kActor.SetScale (1.0)

        SprigganFX.Play( kActor, 30 )

        BimboAliasRef.ForceRefTo(BimboDummyRef)
		
		if StorageUtil.GetIntValue(kActor, "_SLH_bimboTransformGameDays") > 15
			SendModEvent("yps-EnableSmudgingEvent")
			SendModEvent("yps-UnlockMakeupEvent")
			SendModEvent("yps-NoPermanentMakeupEvent")
		endif
		
        SLH_Control.setHormonesStateDefault(kActor)

        Debug.Messagebox("The heatwave returns... hopefully restoring most of your normal self.")

    Endif

    Debug.Messagebox("[Technical note - If your face and eyes are messed up in the Race Menu, use the presets for your race to clear that up.]")
    Debug.Messagebox("[Technical note - Once the transformation is complete, you should reset SexLab using the Clean Up option.]")

    If (StorageUtil.GetIntValue(none, "_SLH_bimboIsOriginalActorMale"))
        ; Race change is enough for Bimbo -> female
        Utility.Wait(1.0)
        HRTEffectOFF( kActor)

        Utility.Wait(1.0)
        TGEffectOFF( kActor)

    Elseif !(StorageUtil.GetIntValue(none, "_SLH_bimboIsOriginalActorMale")) && (GV_allowBimbo.GetValue()==0)
        ; Race change is enough for Bimbo -> female
        Utility.Wait(1.0)
        HRTEffectOFF( kActor)

        Utility.Wait(1.0)
        TGEffectOFF( kActor)

    Elseif !(StorageUtil.GetIntValue(none, "_SLH_bimboIsOriginalActorMale"))
        Utility.Wait(1.0)
        TGEffectOFF( kActor)

    EndIf

    SLH_Control.playMoan(kActor)

    StorageUtil.SetIntValue(kActor, "_SLH_bimboTransformDate", 0)
    StorageUtil.SetIntValue(kActor, "_SLH_bimboTransformGameDays", 0)   
    GV_isPolymorphON.SetValue(0)
    StorageUtil.SetIntValue(kActor, "_SLH_isPolymorph", 0)   
    fctColor.sendSlaveTatModEvent(kActor, "Bimbo","Feet Nails", bRefresh = True )
 
    SLH_Control.setBimboState(kActor, FALSE)
    debugTrace(" Bimbo OFF")

 	; kActor.RegenerateHead()
 	; kActor.QueueNiNodeUpdate()

endFunction

function bimboFinalON(actor kActor)
    GV_isBimboFinal.SetValue(1)
    StorageUtil.SetIntValue(kActor, "_SLH_bimboTransformFinal", 1)
endFunction

function bimboLockedON(actor kActor)
    GV_isBimboLocked.SetValue(1)
    StorageUtil.SetIntValue(kActor, "_SLH_bimboTransformLocked", 1)
endFunction

Bool function HRTEffectON(actor kActor)
    ObjectReference kActorREF= kActor as ObjectReference
    ActorBase pActorBase = kActor.GetActorBase()

    GV_allowTG.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowTG") as Int)
    GV_allowHRT.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowHRT") as Int)
    GV_allowBimbo.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowBimbo") as Int)

    debugTrace(" HRT Start - IsHRT: " + GV_isHRT.GetValue() as Int)

    If (GV_allowHRT.GetValue()==0) 
        debugTrace(" Sex Change Transform Aborted - HRT curse is OFF")
        Return False
    Endif

    debugTrace(" SexChange Init")
 
    If (fctBodyShape.isSchlongSet(kActor )) ; add check for isGenderChangeON
        setSchlong = True
    endif

    debugTrace(" SexChange - Change Gender")
    ConsoleUtil.ExecuteCommand("player.sexchange")

    SLH_Control.playMoan(kActor)
    fctColor.sendSlaveTatModEvent(kActor, "Bimbo","Feet Nails", bRefresh = True )

    SLH_Control.setHRTState(kActor, TRUE)

    Utility.Wait(1.0)
    If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
        fctUtil.checkGender(kActor) 
        if (fctUtil.isMale(kActor))
            SendModEvent("yps-SetPlayerGenderEvent", "male")
        Else
            SendModEvent("yps-SetPlayerGenderEvent", "female")
        Endif
    EndIf

    debugTrace(" HRT ON")
    Return True

endFunction

function HRTEffectOFF(actor kActor)
    GV_allowTG.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowTG") as Int)
    GV_allowHRT.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowHRT") as Int)
    GV_allowBimbo.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowBimbo") as Int)

    debugTrace(" HRT Shutdown - IsHRT: " + GV_isHRT.GetValue() as Int)

    If (GV_allowHRT.GetValue()==0) 
        Return
    Endif

    SexLab.ClearForcedGender(kActor)

    ; MiscUtil.ExecuteBat("SLH_sexchange.bat")
    debugTrace(" Sexchange")
    ConsoleUtil.ExecuteCommand("player.sexchange")

    SLH_Control.playMoan(kActor)
    fctColor.sendSlaveTatModEvent(kActor, "Bimbo","Feet Nails", bRefresh = True )

    debugTrace(" HRT OFF")
    SLH_Control.setHRTState(kActor, FALSE)
         
endFunction

Bool function TGEffectON(actor kActor)
    ObjectReference kActorREF= kActor as ObjectReference
    ActorBase pActorBase = kActor.GetActorBase()

    GV_allowTG.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowTG") as Int)
    GV_allowHRT.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowHRT") as Int)
    GV_allowBimbo.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowBimbo") as Int)

    If (GV_allowTG.GetValue()==0)
        debugTrace(" Transgender Transform Aborted - Transgender curse is OFF")
        Return False
    Endif

    debugTrace(" TG Init")

    If (fctBodyShape.isSchlongSet(kActor )) ; add check for isGenderChangeON
        setSchlong = True
    endif

    isActorMale = fctUtil.isMale(kActor)

    If (isActorMale)
        ; Reserved for later - Find a way to add boobs to a male character
           
        ;    kActor.SendModEvent("SLHSetSchlong", "UNP Bimbo")
        ;    SLH_Control.setTGState(kActor, TRUE)
        ;    debugTrace(" TG ON")

    elseif (!isActorMale) 
        ; Female to Female + Schlong

        kActor.SendModEvent("SLHSetSchlong", "UNP Bimbo")
        StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong",0.7 ) 
        kActor.SendModEvent("SLHRefresh")

        Sexlab.TreatAsMale(kActor)
        SLH_Control.setTGState(kActor, TRUE)
        debugTrace(" TG ON")

    endif

    debugTrace(" TG Start - IsTG: " + GV_isTG.GetValue() as Int)
    Return True
endFunction

function TGEffectOFF(actor kActor)
    GV_allowTG.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowTG") as Int)
    GV_allowHRT.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowHRT") as Int)
    GV_allowBimbo.SetValue( StorageUtil.GetIntValue(kActor, "_SLH_allowBimbo") as Int)
    
    debugTrace(" TG Shutdown - IsTG: " + GV_isTG.GetValue() as Int)

    If (GV_allowTG.GetValue()==0)
        Return
    Endif

    isActorMale = fctUtil.isMale(kActor)

    If (isActorMale) 
        ; Reserved - Remove boobs from male

        SexLab.ClearForcedGender(kActor)

        debugTrace(" TG OFF")
        kActor.SendModEvent("SLHSetSchlong", "")
        SLH_Control.setTGState(kActor, FALSE)

        SLH_Control.playMoan(kActor)

    elseif (!isActorMale) 
        ; Female to Female 

        SexLab.ClearForcedGender(kActor)

        kActor.SendModEvent("SLHRemoveSchlong")
        Sexlab.TreatAsFemale(kActor)
        SLH_Control.setTGState(kActor, FALSE)
        debugTrace(" TG OFF")

        SLH_Control.playMoan(kActor)

    endif                

endFunction

Function debugTrace(string traceMsg)
    if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
        Debug.Trace("[SLH_fctPolymorph]" + traceMsg)
    endif
endFunction
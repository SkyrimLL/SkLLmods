Scriptname SLH_fctPolymorph extends Quest  

Import Utility
Import Math

SLH_fctBodyShape Property fctBodyShape Auto
SLH_fctColor Property fctColor Auto
SLH_fctUtil Property fctUtil Auto

slaUtilScr Property slaUtil  Auto  
SexLabFramework Property SexLab  Auto  

SLH_QST_HormoneGrowth Property SLH_Control Auto

Quest Property _SLH_QST_Bimbo  Auto  

ReferenceAlias Property BimboAliasRef  Auto  

ObjectReference Property Bimbo Auto
ObjectReference Property PolymorphChest  Auto  

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

function bimboTransformEffectON(actor kActor)
	ObjectReference kActorREF= kActor as ObjectReference
	ActorBase pActorBase = kActor.GetActorBase()

    ; Abort if no gender/bimbo option checked in MCM
    If (GV_allowBimbo.GetValue()==0) && (GV_allowHRT.GetValue()==0) && (GV_allowTG.GetValue()==0)
       Return
    Endif

    isActorMale = fctUtil.isMale(kActor)
    StorageUtil.SetIntValue(none, "_SLH_bimboIsOriginalActorMale", isActorMale as Int)

    ; Abort is sex change is not turned on and actor is Male
    If (isActorMale) && (GV_allowHRT.GetValue()==0) && (GV_allowTG.GetValue()==0)
        Return
    EndIf

    If (!isActorMale) && (GV_allowBimbo.GetValue()==0) 
        Return
    EndIf

    debugTrace("[SLH] Bimbo Transform Init")

    Game.ForceThirdPerson()
 
    If (fctBodyShape.isSchlongSet(kActor )) ; add check for isGenderChangeON
        setSchlong = True
    endif

    _actorPresets = new int[4]
    _actorMorphs = new float[19]
    _bimboPresets = new int[4]
    _bimboMorphs = new float[19]

    fctBodyShape.SaveFaceValues( kActor, _actorPresets,  _actorMorphs )
    fctBodyShape.SaveFaceValues( Bimbo as Actor , _bimboPresets,  _bimboMorphs )

    kActor.UnequipAll()

    ; kActor.RemoveAllItems(LycanStash)

	; get actor's race so we have it permanently for werewolf switch back
	ActorOriginalRace = kActor.GetRace()
; 	debugTrace("CSQ: Storing actor's race as " + ActorOriginalRace)

	if     (ActorOriginalRace == ArgonianRaceVampire)
; 		debugTrace("CSQ: actor was Argonian Vampire; storing as Argonian.")
		ActorOriginalRace = ArgonianRace
	elseif (ActorOriginalRace == BretonRaceVampire)
; 		debugTrace("CSQ: actor was Breton Vampire; storing as Breton.")
		ActorOriginalRace = BretonRace
	elseif (ActorOriginalRace == DarkElfRaceVampire)
; 		debugTrace("CSQ: actor was Dark Elf Vampire; storing as Dark Elf.")
		ActorOriginalRace = DarkElfRace
	elseif (ActorOriginalRace == HighElfRaceVampire)
; 		debugTrace("CSQ: actor was Hiegh Elf Vampire; storing as High Elf.")
		ActorOriginalRace = HighElfRace
	elseif (ActorOriginalRace == ImperialRaceVampire)
; 		debugTrace("CSQ: actor was Imperial Vampire; storing as Imperial.")
		ActorOriginalRace = ImperialRace
	elseif (ActorOriginalRace == KhajiitRaceVampire)
; 		debugTrace("CSQ: actor was Khajiit Vampire; storing as Khajiit.")
		ActorOriginalRace = KhajiitRace
	elseif (ActorOriginalRace == NordRaceVampire)
; 		debugTrace("CSQ: actor was Nord Vampire; storing as Nord.")
		ActorOriginalRace = NordRace
	elseif (ActorOriginalRace == OrcRaceVampire)
; 		debugTrace("CSQ: actor was Orc Vampire; storing as Orc.")
		ActorOriginalRace = OrcRace
	elseif (ActorOriginalRace == RedguardRaceVampire)
; 		debugTrace("CSQ: actor was Redguard Vampire; storing as Redguard.")
		ActorOriginalRace = RedguardRace
	elseif (ActorOriginalRace == WoodElfRaceVampire)
; 		debugTrace("CSQ: actor was Wood Elf Vampire; storing as Wood Elf.")
		ActorOriginalRace = WoodElfRace
	endif

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
   


    if (GV_allowBimbo.GetValue()==1) &&  (pActorBase.GetRace() != PolymorphRace)
        debugTrace("[SLH] Bimbo Transform ON")

        StorageUtil.SetFormValue(none, "_SLH_bimboOriginalActor", kActor)           
        StorageUtil.SetFormValue(none, "_SLH_bimboOriginalRace", ActorOriginalRace)           

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
        debugTrace("[SLH] Bimbo Transform - Change Race")
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

        fctBodyShape.LoadFaceValues( StorageUtil.GetFormValue(none, "_SLH_bimboOriginalActor") as Actor, _bimboPresets,  _bimboMorphs ) 
        SLH_Control.setHormonesStateDefault(kActor)

        ; debug.messagebox("[SLH] Casting long term effect: " + TransformationEffect.GetName())
        ; TransformationEffect.Cast(kActor,kActor)
        ; kActor.DoCombatSpellApply(TransformationEffect, kActor)

        ; SprigganFX.Play( kActor, 30 )
    Endif

    Debug.Messagebox("A heatwave of pure lust suddenly rips through your body, molding your features and turning your skin into liquid fire. The shock leaves you breathless... light headed... panting even.")
    Debug.Messagebox("[Technical note - Once the transformation is complete, you should reset SexLab using the Clean Up option.]")

    If (isActorMale)
        ; Do not switch sex for female -> bimbo
        Utility.Wait(1.0)
        HRTEffectON( kActor)

        Utility.Wait(1.0)
        TGEffectON( kActor)

        StorageUtil.SetFloatValue(kActor, "_SLH_fWeight",  0.0)
        StorageUtil.SetFloatValue(kActor, "_SLH_fBreast",  0.9)
        StorageUtil.SetFloatValue(kActor, "_SLH_fButt",  0.9)
        kActor.SendModEvent("SLHRefresh")
    EndIf

    SLH_Control.playMoan(kActor)

    StorageUtil.SetIntValue(kActor, "_SLH_bimboTransformDate", Game.QueryStat("Days Passed"))
    StorageUtil.SetIntValue(kActor, "_SLH_bimboTransformGameDays", 0)   

    GV_isPolymorphON.SetValue(1)
    StorageUtil.SetIntValue(kActor, "_SLH_isPolymorph", 1)   

    SLH_Control.setBimboState(kActor, TRUE)
    debugTrace("[SLH] Bimbo ON")

    debugTrace("[SLH] Bimbo Curse Start - IsBimbo: " + GV_isBimbo.GetValue() as Int)
    debugTrace("[SLH] Bimbo Curse Start - IsHRT: " + GV_isHRT.GetValue() as Int)
    debugTrace("[SLH] Bimbo Curse Start - IsTG: " + GV_isTG.GetValue() as Int)

endFunction

function bimboTransformEffectOFF(actor kActor)

    ; PolymorphBimboFX.Cast(kActor,kActor) 
    debugTrace("[SLH] Bimbo Curse Shutdown - IsBimbo: " + GV_isBimbo.GetValue() as Int)
    debugTrace("[SLH] Bimbo Curse Shutdown - IsHRT: " + GV_isHRT.GetValue() as Int)
    debugTrace("[SLH] Bimbo Curse Shutdown - IsTG: " + GV_isTG.GetValue() as Int)

    If (GV_allowBimbo.GetValue()==1) && (GV_isBimbo.GetValue()==1)
        ; TransformationEffect.Cast(kActor,kActor)
        debugTrace("[SLH] Bimbo Transform OFF")
  
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
        debugTrace("[SLH] Bimbo - Setting race " + (CompanionsTrackingQuest as CompanionsHousekeepingScript).PlayerOriginalRace + " on " + kActor)

        ; VFX3.Play(kActor, afTime = 3)
        ; VFX1.Stop(kActor)
        ; VFX2.Stop(kActor)
        kActor.DispelSpell(TransformationSpell)
        

        debugTrace("[SLH] Original race - " + ActorOriginalRace)

        ActorOriginalRace = StorageUtil.GetFormValue(none, "_SLH_bimboOriginalRace") as Race
        If (ActorOriginalRace == None)
            ; In case of upgrade while in Bimbo mode
            Debug.MessageBox("[Transformation cannot continue. Try going back to an earlier version of Hormones and update after being cured from the Bimbo curse.]")
            Return
        Endif

        kActor.SetRace(ActorOriginalRace)

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

        _actorPresets = new int[4]
        _actorMorphs = new float[19]
        _bimboPresets = new int[4]
        _bimboMorphs = new float[19]

        fctBodyShape.SaveFaceValues( StorageUtil.GetFormValue(none, "_SLH_bimboOriginalActor") as Actor, _actorPresets,  _actorMorphs )
        fctBodyShape.SaveFaceValues( Bimbo as Actor , _bimboPresets,  _bimboMorphs )

        fctBodyShape.LoadFaceValues( kActor, _actorPresets,  _actorMorphs )  
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
    EndIf

    SLH_Control.playMoan(kActor)

    StorageUtil.SetIntValue(kActor, "_SLH_bimboTransformDate", 0)
    StorageUtil.SetIntValue(kActor, "_SLH_bimboTransformGameDays", 0)   
    GV_isPolymorphON.SetValue(0)
    StorageUtil.SetIntValue(kActor, "_SLH_isPolymorph", 0)   
 
    SLH_Control.setBimboState(kActor, FALSE)
    debugTrace("[SLH] Bimbo OFF")

 	; kActor.RegenerateHead()
 	; kActor.QueueNiNodeUpdate()

endFunction

function HRTEffectON(actor kActor)
    ObjectReference kActorREF= kActor as ObjectReference
    ActorBase pActorBase = kActor.GetActorBase()

    debugTrace("[SLH] HRT Start - IsHRT: " + GV_isHRT.GetValue() as Int)

    If (GV_allowHRT.GetValue()==0) 
        Return
    Endif

    debugTrace("[SLH] SexChange Init")
 
    If (fctBodyShape.isSchlongSet(kActor )) ; add check for isGenderChangeON
        setSchlong = True
    endif

    debugTrace("[SLH] SexChange - Change Gender")
    ConsoleUtil.ExecuteCommand("player.sexchange")

    SLH_Control.playMoan(kActor)

    SLH_Control.setHRTState(kActor, TRUE)
    debugTrace("[SLH] HRT ON")

endFunction

function HRTEffectOFF(actor kActor)

    debugTrace("[SLH] HRT Shutdown - IsHRT: " + GV_isHRT.GetValue() as Int)

    If (GV_allowHRT.GetValue()==0) 
        Return
    Endif

    SexLab.ClearForcedGender(kActor)

    ; MiscUtil.ExecuteBat("SLH_sexchange.bat")
    debugTrace("[SLH] Sexchange")
    ConsoleUtil.ExecuteCommand("player.sexchange")

    SLH_Control.playMoan(kActor)

    debugTrace("[SLH] HRT OFF")
    SLH_Control.setHRTState(kActor, FALSE)
         
endFunction

function TGEffectON(actor kActor)
    ObjectReference kActorREF= kActor as ObjectReference
    ActorBase pActorBase = kActor.GetActorBase()

    If (GV_allowTG.GetValue()==0)
        Return
    Endif

    debugTrace("[SLH] TG Init")

    If (fctBodyShape.isSchlongSet(kActor )) ; add check for isGenderChangeON
        setSchlong = True
    endif

    isActorMale = fctUtil.isMale(kActor)

    If (isActorMale)
        ; Reserved for later - Find a way to add boobs to a male character
           
        ;    kActor.SendModEvent("SLHSetSchlong", "UNP Bimbo")
        ;    SLH_Control.setTGState(kActor, TRUE)
        ;    debugTrace("[SLH] TG ON")

    elseif (!isActorMale) 
        ; Female to Female + Schlong

        kActor.SendModEvent("SLHSetSchlong", "UNP Bimbo")
        StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong", 1.0 ) 
        kActor.SendModEvent("SLHRefresh")

        Sexlab.TreatAsMale(kActor)
        SLH_Control.setTGState(kActor, TRUE)
        debugTrace("[SLH] TG ON")

    endif

    debugTrace("[SLH] TG Start - IsTG: " + GV_isTG.GetValue() as Int)

endFunction

function TGEffectOFF(actor kActor)

    debugTrace("[SLH] TG Shutdown - IsTG: " + GV_isTG.GetValue() as Int)

    If (GV_allowTG.GetValue()==0)
        Return
    Endif

    isActorMale = fctUtil.isMale(kActor)

    If (isActorMale) 
        ; Reserved - Remove boobs from male

        SexLab.ClearForcedGender(kActor)

        debugTrace("[SLH] TG OFF")
        kActor.SendModEvent("SLHSetSchlong", "")
        SLH_Control.setTGState(kActor, FALSE)

        SLH_Control.playMoan(kActor)

    elseif (!isActorMale) 
        ; Female to Female 

        SexLab.ClearForcedGender(kActor)

        kActor.SendModEvent("SLHRemoveSchlong")
        Sexlab.TreatAsFemale(kActor)
        SLH_Control.setTGState(kActor, FALSE)
        debugTrace("[SLH] TG OFF")

        SLH_Control.playMoan(kActor)

    endif                

endFunction

Function debugTrace(string traceMsg)
    if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
        Debug.Trace(traceMsg)
    endif
endFunction
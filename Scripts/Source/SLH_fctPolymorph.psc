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


GlobalVariable      Property GV_isTG                   Auto
GlobalVariable      Property GV_isHRT                   Auto
GlobalVariable      Property GV_isBimbo                 Auto
GlobalVariable      Property GV_allowTG                Auto
GlobalVariable      Property GV_allowHRT                Auto
GlobalVariable      Property GV_allowBimbo              Auto
GlobalVariable      Property GV_isPolymorphON           Auto


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
        kActor.AddItem(ReturnItem, 1 , True)
        Return
    Endif

    debugTrace("[SLH] Bimbo Transform Init")

    _actorPresets = new int[4]
    _actorMorphs = new float[19]
    _bimboPresets = new int[4]
    _bimboMorphs = new float[19]

    Game.ForceThirdPerson()
 
    If (fctBodyShape.isSchlongSet(kActor )) ; add check for isGenderChangeON
        setSchlong = True
    endif

    isActorMale = fctUtil.isMale(kActor)

    ; Abort is sex change is not turned on and actor is Male
    If (isActorMale) && (GV_allowHRT.GetValue()==0) && (GV_allowTG.GetValue()==0)
        kActor.AddItem(ReturnItem, 1 , True)
        Return
    EndIf

    If (!isActorMale) && (GV_allowBimbo.GetValue()==0)
        kActor.AddItem(ReturnItem, 1 , True)
        Return
    EndIf

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
        slaUtil.SetActorExhibitionist(kActor, True)

        if (actorArousalRate < 8.0 )
            slaUtil.SetActorExposureRate(kActor, 8.0)
        Endif
   
        int iTmpAV 
        iTmpAV = kActor.GetActorValue("health") as int
        actorHP = iTmpAV

        iTmpAV = kActor.GetActorValue("magicka") as int
        actorMG = iTmpAV

        iTmpAV = kActor.GetActorValue("stamina") as int
        actorST = iTmpAV

        iTmpAV = kActor.GetActorValue("OneHanded") as int 
        actorOneHanded = iTmpAV 

        iTmpAV = kActor.GetActorValue("TwoHanded") as int 
        actorTwoHanded = iTmpAV  

        iTmpAV = kActor.GetActorValue("Marksman") as int  
        actorMarksman = iTmpAV  

        iTmpAV = kActor.GetActorValue("HeavyArmor") as int   
        actorHeavyArmor = iTmpAV  

        iTmpAV = kActor.GetActorValue("LightArmor") as int  
        actorLightArmor = iTmpAV  

        iTmpAV = kActor.GetActorValue("Pickpocket") as int 
        actorPickpocket = iTmpAV

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

        ; debug.messagebox("[SLH] Casting long term effect: " + TransformationEffect.GetName())
        ; TransformationEffect.Cast(kActor,kActor)
        ; kActor.DoCombatSpellApply(TransformationEffect, kActor)

        ; SprigganFX.Play( kActor, 30 )
    Endif

    Debug.Messagebox("A heatwave of pure lust suddenly rips through your body, molding your features and turning your skin into liquid fire. The shock leaves you breathless... light headed... panting even.")
    Debug.Messagebox("[Technical note - Once the transformation is complete, you should reset SexLab using the Clean Up option.]")

    If (isActorMale) && ((GV_allowHRT.GetValue()==1) || (GV_allowTG.GetValue()==1))
        ; Male to Female if Sex Change is allowed (HRT)  
        debugTrace("[SLH] Bimbo Transform - Change Sex")
        ConsoleUtil.ExecuteCommand("player.sexchange")

        If (GV_allowBimbo.GetValue()==1)
            fctBodyShape.LoadFaceValues( kActor, _bimboPresets,  _bimboMorphs ) 
            SLH_Control.setHormonesStateDefault(kActor)

            SLH_Control.setBimboState(kActor, TRUE)
            debugTrace("[SLH] Bimbo ON")

            StorageUtil.SetIntValue(kActor, "_SD_iSlaveryLevel", 6)
            StorageUtil.SetIntValue( kActor , "_SD_iDom", 0)
            StorageUtil.SetIntValue( kActor , "_SD_iSub", -10)

        else
            SLH_Control.setBimboState(kActor, FALSE)
            debugTrace("[SLH] Bimbo OFF")
        endif

        if (GV_allowTG.GetValue()==1)                
            kActor.SendModEvent("SLHSetSchlong", "UNP Bimbo")
            SLH_Control.setTGState(kActor, TRUE)
            debugTrace("[SLH] TG ON")
        Else
            kActor.SendModEvent("SLHRemoveSchlong")
            Sexlab.TreatAsFemale(kActor)
            SLH_Control.setTGState(kActor, FALSE)
            debugTrace("[SLH] TG OFF")
        endif

        if (GV_allowHRT.GetValue()==1)
            SLH_Control.setHRTState(kActor, TRUE)
            debugTrace("[SLH] HRT ON")
        endif

    elseif (!isActorMale)
        ; Female to Female 

        If (GV_allowBimbo.GetValue()==1)
            fctBodyShape.LoadFaceValues( kActor, _bimboPresets,  _bimboMorphs ) 
            SLH_Control.setBimboState(kActor, TRUE)
            debugTrace("[SLH] Bimbo ON")
        else
            SLH_Control.setBimboState(kActor, FALSE)
            debugTrace("[SLH] Bimbo OFF")
        endif

        if (GV_allowTG.GetValue()==1)
            kActor.SendModEvent("SLHSetSchlong", "UNP Bimbo")
            StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong", StorageUtil.GetFloatValue(kActor, "_SLH_fSchlongMin") ) 
            SendModEvent("SLHRefresh")

            Sexlab.TreatAsMale(kActor)
            SLH_Control.setTGState(kActor, TRUE)
            debugTrace("[SLH] TG ON")
        else
            Sexlab.TreatAsFemale(kActor)
            SLH_Control.setTGState(kActor, FALSE)
            debugTrace("[SLH] TG OFF")
        endif

        SLH_Control.setHRTState(kActor, FALSE)
        debugTrace("[SLH] HRT OFF")

    endif

    StorageUtil.SetIntValue(kActor, "_SLH_bimboTransformDate", Game.QueryStat("Days Passed"))
    StorageUtil.SetIntValue(kActor, "_SLH_bimboTransformGameDays", 0)   

    GV_isPolymorphON.SetValue(1)
    StorageUtil.SetIntValue(kActor, "_SLH_isPolymorph", 1)   

    debugTrace("[SLH] Bimbo Curse Start - IsBimbo: " + GV_isBimbo.GetValue() as Int)
    debugTrace("[SLH] Bimbo Curse Start - IsHRT: " + GV_isHRT.GetValue() as Int)
    debugTrace("[SLH] Bimbo Curse Start - IsTG: " + GV_isTG.GetValue() as Int)

    Game.ShowRaceMenu()

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
            

            debugTrace("[SLH] Original race")
            kActor.SetRace(ActorOriginalRace)

            if (!isActorExhibitionist)
                slaUtil.SetActorExhibitionist(kActor, False)
            EndIf

            slaUtil.SetActorExposureRate(kActor, actorArousalRate)

            kActor.SetActorValue("health", (actorHP))
            kActor.SetActorValue("magicka", (actorMG))
            kActor.SetActorValue("stamina", (actorST))
            kActor.SetActorValue("healrate", 1)
            kActor.RestoreActorValue("health", 999999999999999999999999999)

            kActor.SetActorValue("OneHanded", actorOneHanded)
            kActor.SetActorValue("TwoHanded", actorTwoHanded)
            kActor.SetActorValue("Marksman", actorMarksman)
            kActor.SetActorValue("HeavyArmor", actorHeavyArmor)
            kActor.SetActorValue("LightArmor", actorLightArmor)
            kActor.SetActorValue("Pickpocket", actorPickpocket)
            
            kActor.SetScale (1.0)

            SprigganFX.Play( kActor, 30 )

            BimboAliasRef.ForceRefTo(None)

            Debug.Messagebox("The heatwave returns... hopefully restoring most of your normal self.")

        Endif

        StorageUtil.SetIntValue(kActor, "_SLH_bimboTransformDate", 0)
        StorageUtil.SetIntValue(kActor, "_SLH_bimboTransformGameDays", 0)   
        GV_isPolymorphON.SetValue(0)
        StorageUtil.SetIntValue(kActor, "_SLH_isPolymorph", 0)   

        If (isActorMale) && (GV_allowHRT.GetValue()==1)
            ; MiscUtil.ExecuteBat("SLH_sexchange.bat")
            debugTrace("[SLH] Sexchange")
            ConsoleUtil.ExecuteCommand("player.sexchange")

            If (GV_allowBimbo.GetValue()==1)
                debugTrace("[SLH] Bimbo OFF")
                fctBodyShape.LoadFaceValues( kActor, _actorPresets,  _actorMorphs ) 
                SLH_Control.setBimboState(kActor, FALSE)

                SLH_Control.setHormonesStateDefault(kActor)
            endif

            if (GV_allowTG.GetValue()==1)
                debugTrace("[SLH] TG OFF")
                kActor.SendModEvent("SLHSetSchlong", "")
                SLH_Control.setTGState(kActor, FALSE)

            endif

            debugTrace("[SLH] HRT OFF")
            SLH_Control.setHRTState(kActor, FALSE)


            ; Debug.Messagebox("[Remember to change the sex of your character in the Racemenu or later in the console using 'sexchange' or armors will still show with the female model on your male form].")

            Game.ShowRaceMenu()


        elseif (!isActorMale)
            ; Female to Female 

            If (GV_allowBimbo.GetValue()==1)
                fctBodyShape.LoadFaceValues( kActor, _actorPresets,  _actorMorphs )  
                SLH_Control.setBimboState(kActor, FALSE)

               SLH_Control.setHormonesStateDefault(kActor)
               debugTrace("[SLH] Bimbo OFF")
            endif

            if (GV_allowTG.GetValue()==1)
                kActor.SendModEvent("SLHRemoveSchlong")
                Sexlab.TreatAsFemale(kActor)
                SLH_Control.setTGState(kActor, FALSE)
                debugTrace("[SLH] TG OFF")
            endif

            SLH_Control.setHRTState(kActor, FALSE)
            debugTrace("[SLH] HRT OFF")
 
            Game.ShowRaceMenu()

        endif                


     	; kActor.RegenerateHead()
     	; kActor.QueueNiNodeUpdate()

endFunction


Function debugTrace(string traceMsg)
    if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
        Debug.Trace(traceMsg)
    endif
endFunction
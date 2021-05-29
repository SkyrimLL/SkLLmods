Scriptname SLH_fctPolymorph extends Quest

SLH_fctBodyShape Property fctBodyShape Auto
SLH_fctColor Property fctColor Auto
SLH_fctUtil Property fctUtil Auto

slaUtilScr Property slaUtil Auto
SexLabFramework Property SexLab Auto

SLH_QST_HormoneGrowth Property SLH_Control Auto
SLH_QST_BimboAlias Property SLH_BimboControl Auto

Quest Property _SLH_QST_Bimbo Auto
Quest Property CompanionsTrackingQuest auto

Actor Property Bimbo Auto
ReferenceAlias Property BimboAliasRef Auto
ObjectReference Property BimboDummyRef Auto

GlobalVariable Property GV_isBimboFinal Auto
GlobalVariable Property GV_isBimboLocked Auto

GlobalVariable Property GV_isTG Auto
GlobalVariable Property GV_isHRT Auto
GlobalVariable Property GV_isBimbo Auto
GlobalVariable Property GV_isPolymorphON Auto
GlobalVariable Property GV_allowTG Auto
GlobalVariable Property GV_allowHRT Auto
GlobalVariable Property GV_allowBimbo Auto
GlobalVariable Property GV_allowBimboRace Auto
GlobalVariable Property GV_allowExhibitionist Auto

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

Faction Property actorWerewolfFaction auto
Faction Property MonsterFaction auto

Spell Property TransformationSpell Auto
Spell Property TransformationEffect Auto
Spell Property DiseaseSanguinareVampiris Auto
Spell Property VampireSunDamage01 auto
Spell Property VampireSunDamage02 auto
Spell Property VampireSunDamage03 auto
Spell Property VampireSunDamage04 auto

VisualEffect Property VFX3 Auto
VisualEffect Property SprigganFX Auto

Int Property HP = 50 AutoReadOnly Hidden
Int Property Magicka = 50 AutoReadOnly Hidden
Int Property Stamina = 100 AutoReadOnly Hidden

Bool setSchlong = False
Bool isActorMale = False
Bool isActorExhibitionist = False

Race ActorOriginalRace

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

Bool function bimboTransformEffectON(actor kActor)
    ActorBase pActorBase = kActor.GetActorBase()
 
    Int allowHRT = StorageUtil.GetIntValue(kActor, "_SLH_allowHRT")
    Int allowBimbo = StorageUtil.GetIntValue(kActor, "_SLH_allowBimbo")
    GV_allowTG.SetValue(StorageUtil.GetIntValue(kActor, "_SLH_allowTG"))
    GV_allowHRT.SetValue(allowHRT)
    GV_allowBimbo.SetValue(allowBimbo)

    fctUtil.checkGender(kActor) 
    isActorMale = fctUtil.isMale(kActor)

    ; Abort if no gender/bimbo option checked in MCM
    If allowBimbo == 0
        debugTrace(" Bimbo Transform Aborted - Bimbo curse is OFF")
        Return False
    Endif
    If allowHRT == 0 && isActorMale
        debugTrace(" Bimbo Transform Aborted - Player is male and sex change is OFF")
        Return False
    Endif
    ; Abort if enslaved - to preserve slave related variables
    If StorageUtil.GetIntValue(kActor, "_SD_iEnslaved") == 1
        debugTrace(" Bimbo Transform Aborted - Player is enslaved")
        Return False
    endif

    debugTrace(" Bimbo Transform Init")

    ActorOriginalRace = kActor.GetRace()
    StorageUtil.SetIntValue(none, "_SLH_bimboIsOriginalActorMale", isActorMale as Int)
    StorageUtil.SetFormValue(none, "_SLH_bimboOriginalActor", kActor)
    StorageUtil.SetFormValue(none, "_SLH_bimboOriginalRace", ActorOriginalRace)

    Game.ForceThirdPerson()
    TransformationEffect.Cast(kActor,kActor)

    ; unequip magic
    Spell sEquipped = kActor.GetEquippedSpell(0)
    If sEquipped != None; left
        kActor.UnequipSpell(sEquipped, 0)
    EndIf
    sEquipped = kActor.GetEquippedSpell(1)
    If sEquipped != None; right
        kActor.UnequipSpell(sEquipped, 1)
    EndIf
    sEquipped = kActor.GetEquippedSpell(2)
    If sEquipped != None; lesser power
        kActor.UnequipSpell(sEquipped, 2)
    EndIf
    Shout voice = kActor.GetEquippedShout()
    if voice != None
        kActor.UnequipShout(voice)
    endif

    kActor.SheatheWeapon()
    Utility.Wait(2.0)

    ; unequip weapons
    Weapon wEquipped = kActor.GetEquippedWeapon(true)
    if wEquipped != None; left hand
        kActor.UnequipItem(wEquipped, false, true)
    endif
    wEquipped = kActor.GetEquippedWeapon()
    if wEquipped != None; right hand
        kActor.UnequipItem(wEquipped, false, true)
    endif
   
    if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale") < 50.0)
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemale", 50.0) 			 
    endif

    If isActorMale
        ; Do not switch sex for female -> bimbo
        Utility.Wait(1.0)
        HRTEffectON(kActor)

        Utility.Wait(1.0)
        fctBodyShape.tryTGEvent(kActor, 1)

        StorageUtil.SetFloatValue(kActor, "_SLH_fWeight", 0.0)
        StorageUtil.SetFloatValue(kActor, "_SLH_fBreast", 0.9)
        StorageUtil.SetFloatValue(kActor, "_SLH_fButt", 0.9)
    Else
        If allowBimbo == 0
            ; Allow sex change if bimbo effect is OFF
            Utility.Wait(1.0)
	    fctBodyShape.tryHRTEvent(kActor, 1)
        EndIf

        Utility.Wait(1.0)
        fctBodyShape.tryTGEvent(kActor, 1)
    EndIf

    If GV_allowBimboRace.GetValue() == 1
        _actorPresets = new int[4]
        _actorMorphs = new float[19]
        _bimboPresets = new int[4]
        _bimboMorphs = new float[19]

        fctBodyShape.SaveFaceValues(kActor, _actorPresets,  _actorMorphs)
        fctBodyShape.SaveFaceValues(Bimbo as Actor, _bimboPresets,  _bimboMorphs)

        ; get actor's race so we have it permanently to switch back
        if (ActorOriginalRace == ArgonianRaceVampire)
            ActorOriginalRace = ArgonianRace
        elseif (ActorOriginalRace == BretonRaceVampire)
            ActorOriginalRace = BretonRace
        elseif (ActorOriginalRace == DarkElfRaceVampire)
            ActorOriginalRace = DarkElfRace
        elseif (ActorOriginalRace == HighElfRaceVampire)
            ActorOriginalRace = HighElfRace
        elseif (ActorOriginalRace == ImperialRaceVampire)
            ActorOriginalRace = ImperialRace
        elseif (ActorOriginalRace == KhajiitRaceVampire)
            ActorOriginalRace = KhajiitRace
        elseif (ActorOriginalRace == NordRaceVampire)
            ActorOriginalRace = NordRace
        elseif (ActorOriginalRace == OrcRaceVampire)
            ActorOriginalRace = OrcRace
        elseif (ActorOriginalRace == RedguardRaceVampire)
            ActorOriginalRace = RedguardRace
        elseif (ActorOriginalRace == WoodElfRaceVampire)
            ActorOriginalRace = WoodElfRace
        endif

        ;debugTrace("[SLH_fctPolymorph] Storing Race as " + ActorOriginalRace.GetName())

        if pActorBase.GetRace() != PolymorphRace
            Debug.SetGodMode(true)
            kActor.ResetHealthAndLimbs()

            kActor.RestoreActorValue("magicka", 999999999999)
            kActor.RestoreActorValue("stamina", 999999999999)
            kActor.RestoreActorValue("health", 999999999999)

            kActor.DispelSpell(DiseaseSanguinareVampiris)
            kActor.DispelSpell(VampireSunDamage01)
            kActor.DispelSpell(VampireSunDamage02)
            kActor.DispelSpell(VampireSunDamage03)
            kActor.DispelSpell(VampireSunDamage04)

            ;======= CHANGING RACE HERE
            debugTrace(" Bimbo Transform - Change Race")
            kActor.SetRace(PolymorphRace)
            ;=======

            kActor.SetHeadTracking(false)
            kActor.AddToFaction(MonsterFaction)
        EndIf

        fctBodyShape.LoadFaceValues(StorageUtil.GetFormValue(none, "_SLH_bimboOriginalActor") as Actor, _bimboPresets, _bimboMorphs)
    Else
        ; Using Hormones changes to compensate for lack of Bimbo race
        fctBodyshape.alterBodyByPercent(kActor, "Weight", 5.0)
        fctBodyshape.alterBodyByPercent(kActor, "Breast", 5.0)
    Endif

    Int iBimboHairColor = Math.LeftShift(255, 24) + Math.LeftShift(92, 16) + Math.LeftShift(80, 8) + 80
    StorageUtil.SetIntValue(kActor, "_SLH_iHairColor", iBimboHairColor)

    isActorExhibitionist = slaUtil.IsActorExhibitionist(kActor)
    actorArousalRate = slaUtil.GetActorExposureRate(kActor)

    If GV_allowExhibitionist.GetValue() == 1
        slaUtil.SetActorExhibitionist(kActor, True)
    EndIf

    if actorArousalRate < 8.0
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
    Debug.SetGodMode(false)

    BimboAliasRef.ForceRefTo(kActor as ObjectReference)

    SLH_Control.setHormonesStateDefault(kActor)

    Debug.Messagebox("A heatwave of pure lust suddenly rips through your body, molding your features and turning your skin into liquid fire. The shock leaves you breathless... light headed... panting even.")
    Debug.Messagebox("[Technical note - Once the transformation is complete, you should reset SexLab using the Clean Up option.]")

    SLH_Control.playMoan(kActor)

    GV_isPolymorphON.SetValue(1)
    StorageUtil.SetIntValue(kActor, "_SLH_isPolymorph", 1)

    SLH_Control.setBimboState(kActor, TRUE)
    kActor.SendModEvent("SLHRefresh")

    SLH_BimboControl.initBimbo(isActorMale)

    If StorageUtil.GetIntValue(none, "_SLH_debugTraceON") == 1
        Debug.Trace("[SLH_fctPolymorph] Bimbo ON")
        Debug.Trace("[SLH_fctPolymorph] Bimbo Curse Start - IsBimbo: " + GV_isBimbo.GetValue() as Bool)
        Debug.Trace("[SLH_fctPolymorph] Bimbo Curse Start - IsHRT: " + GV_isHRT.GetValue() as Bool)
        Debug.Trace("[SLH_fctPolymorph] Bimbo Curse Start - IsTG: " + GV_isTG.GetValue() as Bool)
    EndIf

    Return True
endFunction

function bimboTransformEffectOFF(actor kActor)
    Bool allowBimbo = StorageUtil.GetIntValue(kActor, "_SLH_allowBimbo")
    Bool isBimbo = GV_isBimbo.GetValue() as Bool
    GV_allowTG.SetValue(StorageUtil.GetIntValue(kActor, "_SLH_allowTG"))
    GV_allowHRT.SetValue(StorageUtil.GetIntValue(kActor, "_SLH_allowHRT"))
    GV_allowBimbo.SetValue(allowBimbo as Int)

    If StorageUtil.GetIntValue(none, "_SLH_debugTraceON") == 1
        Debug.Trace("[SLH_fctPolymorph] Bimbo Curse Shutdown - IsBimbo: " + isBimbo)
        Debug.Trace("[SLH_fctPolymorph] Bimbo Curse Shutdown - IsHRT: " + GV_isHRT.GetValue() as Bool)
        Debug.Trace("[SLH_fctPolymorph] Bimbo Curse Shutdown - IsTG: " + GV_isTG.GetValue() as Bool)
    EndIf

    If allowBimbo && isBimbo
        TransformationEffect.Cast(kActor,kActor)
        debugTrace(" Bimbo Transform OFF")

        If GV_allowBimboRace.GetValue() == 1
            kActor.RemoveFromFaction(MonsterFaction)

            ; unequip magic
            Spell sEquipped = kActor.GetEquippedSpell(0)
            If sEquipped != None; left
                kActor.UnequipSpell(sEquipped, 0)
            EndIf
            sEquipped = kActor.GetEquippedSpell(1)
            If sEquipped != None; right
                kActor.UnequipSpell(sEquipped, 1)
            EndIf
            ; unequip weapons
            Weapon wEquipped = kActor.GetEquippedWeapon(true)
            if wEquipped != None; left hand
                kActor.UnequipItem(wEquipped, false, true)
            endif
            wEquipped = kActor.GetEquippedWeapon()
            if wEquipped != None; right hand
                kActor.UnequipItem(wEquipped, false, true)
            endif

            Game.EnablePlayerControls()
            Game.SetPlayerReportCrime(true)
            kActor.SetAttackActorOnSight(false)
            kActor.RemoveFromFaction(ActorWerewolfFaction)
            debugTrace(" Bimbo - Setting race " + (CompanionsTrackingQuest as CompanionsHousekeepingScript).PlayerOriginalRace + " on " + kActor)

            kActor.DispelSpell(TransformationSpell)


            ActorOriginalRace = StorageUtil.GetFormValue(none, "_SLH_bimboOriginalRace") as Race
            debugTrace(" Original race - " + ActorOriginalRace)
            If ActorOriginalRace == None
                ; In case of upgrade while in Bimbo mode
                Debug.MessageBox("[Transformation cannot continue. Try going back to an earlier version of Hormones and update after being cured from the Bimbo curse.]")
                Return
            Endif

            kActor.SetRace(ActorOriginalRace)
            _actorPresets = new int[4]
            _actorMorphs = new float[19]
            _bimboPresets = new int[4]
            _bimboMorphs = new float[19]

            fctBodyShape.SaveFaceValues(StorageUtil.GetFormValue(none, "_SLH_bimboOriginalActor") as Actor, _actorPresets,  _actorMorphs )
            fctBodyShape.SaveFaceValues(Bimbo as Actor, _bimboPresets, _bimboMorphs)

            fctBodyShape.LoadFaceValues(kActor, _actorPresets, _actorMorphs)
        EndIf

        if !isActorExhibitionist && GV_allowExhibitionist.GetValue() == 1
            slaUtil.SetActorExhibitionist(kActor, False)
        EndIf

        slaUtil.SetActorExposureRate(kActor, actorArousalRate)

        kActor.SetActorValue("health", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalHP"))
        kActor.SetActorValue("magicka", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalMG"))
        kActor.SetActorValue("stamina", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalST"))
        kActor.SetActorValue("healrate", 1)
        kActor.RestoreActorValue("health", 999999999999999999999999999)

        kActor.SetActorValue("OneHanded", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalOneHanded"))
        kActor.SetActorValue("TwoHanded", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalTwoHanded"))
        kActor.SetActorValue("Marksman", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalMarksman"))
        kActor.SetActorValue("HeavyArmor", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalHeavyArmor"))
        kActor.SetActorValue("LightArmor", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalLightArmor"))
        kActor.SetActorValue("Pickpocket", StorageUtil.GetFloatValue(none, "_SLH_bimboOriginalPickpocket"))

        kActor.SetScale(1.0)

        SprigganFX.Play(kActor, 30)

        BimboAliasRef.ForceRefTo(BimboDummyRef)

        if StorageUtil.GetIntValue(kActor, "_SLH_bimboTransformFinal") == 1
            SendModEvent("yps-EnableSmudgingEvent")
            SendModEvent("yps-UnlockMakeupEvent")
            SendModEvent("yps-NoPermanentMakeupEvent")
        endif

        SLH_Control.setHormonesStateDefault(kActor)

        Debug.Messagebox("The heatwave returns... hopefully restoring most of your normal self.")
    Endif

    Debug.Messagebox("[Technical note - If your face and eyes are messed up in the Race Menu, use the presets for your race to clear that up.]")
    Debug.Messagebox("[Technical note - Once the transformation is complete, you should reset SexLab using the Clean Up option.]")

    If StorageUtil.GetIntValue(none, "_SLH_bimboIsOriginalActorMale")
        ; Race change is enough for Bimbo -> female
        Utility.Wait(1.0)
        HRTEffectOFF(kActor)

        Utility.Wait(1.0)
        TGEffectOFF(kActor)
    Else
    ;    if !allowBimbo
            ; Race change is enough for Bimbo -> female
    ;        Utility.Wait(1.0)
    ;        HRTEffectOFF(kActor)
    ;    EndIf

    ;    Utility.Wait(1.0)
    ;    TGEffectOFF(kActor)
    EndIf

	If StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneBimbo") > 15.0
		StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneBimbo", 15.0)
	EndIf

    SLH_Control.playMoan(kActor)

    GV_isPolymorphON.SetValue(0)
    StorageUtil.SetIntValue(kActor, "_SLH_isPolymorph", 0)
    fctColor.sendSlaveTatModEvent(kActor, "Bimbo", "Feet Nails", bRefresh = True)

    SLH_Control.setBimboState(kActor, FALSE)
    SLH_BimboControl.endBimbo()

    debugTrace(" Bimbo OFF")
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

	fctUtil.checkGender(kActor) 
	if (fctUtil.isMale(kActor))
		if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMale") > 50.0)
			StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMale", 50.0) 			 
		endif
	Else
		if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale") > 50.0)
			StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemale", 50.0) 			 
		endif
	Endif

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

	fctUtil.checkGender(kActor) 
	if (fctUtil.isMale(kActor))
		if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale") < 50.0)
			StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemale", 50.0) 			 
		endif
	Else
		if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMale") < 50.0)
			StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMale", 50.0) 			 
		endif
	Endif

    SexLab.ClearForcedGender(kActor)

    ; MiscUtil.ExecuteBat("SLH_sexchange.bat")
    debugTrace(" Sexchange")
    ConsoleUtil.ExecuteCommand("player.sexchange")

    SLH_Control.playMoan(kActor)
    fctColor.sendSlaveTatModEvent(kActor, "Bimbo","Feet Nails", bRefresh = True )

    SLH_Control.setHRTState(kActor, FALSE)
    debugTrace(" HRT OFF")
         
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

    fctUtil.checkGender(kActor) 
    
    If (fctUtil.isMale(kActor))
        ; Reserved for later - Find a way to add boobs to a male character
           
        ;    kActor.SendModEvent("SLHSetSchlong", "UNP Bimbo")
        ;    SLH_Control.setTGState(kActor, TRUE)
        ;    debugTrace(" TG ON")

        GV_allowHRT.SetValue(1)

        HRTEffectON(kActor)
        
        kActor.SendModEvent("SLHSetSchlong", "UNP Bimbo")
        StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong",0.7 ) 
        kActor.SendModEvent("SLHRefresh")

        Sexlab.TreatAsFemale(kActor)
    else 
        ; Female to Female + Schlong

		if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMale") < 50.0)
			StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMale", 50.0) 			 
		endif
		if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale") > 75.0)
			StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemale", 75.0) 			 
		endif

        kActor.SendModEvent("SLHSetSchlong", "UNP Bimbo")
        StorageUtil.SetFloatValue(kActor, "_SLH_fSchlong",0.7 ) 
        kActor.SendModEvent("SLHRefresh")

        Sexlab.TreatAsMale(kActor)
    endif

	SLH_Control.setTGState(kActor, TRUE)
	debugTrace(" TG ON")

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

    fctUtil.checkGender(kActor) 
    
    If (fctUtil.isMale(kActor)) 
        ; Reserved - Remove boobs from male

		if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale") > 50.0)
			StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemale", 50.0) 			 
		endif

        SexLab.ClearForcedGender(kActor)

        kActor.SendModEvent("SLHSetSchlong", "")
        Sexlab.TreatAsMale(kActor)
        SLH_Control.playMoan(kActor)
    else
        ; Female to Female 

		if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneMale") > 50.0)
			StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneMale", 50.0) 			 
		endif
		if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneFemale") < 50.0)
			StorageUtil.SetFloatValue(kActor, "_SLH_fHormoneFemale", 50.0) 			 
		endif

        SexLab.ClearForcedGender(kActor)

        kActor.SendModEvent("SLHRemoveSchlong")
        Sexlab.TreatAsFemale(kActor)
        SLH_Control.playMoan(kActor)
    endif                

	SLH_Control.setTGState(kActor, FALSE)
	debugTrace(" TG OFF")

endFunction

Function debugTrace(string traceMsg)
    if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
        Debug.Trace("[SLH_fctPolymorph]" + traceMsg)
    endif
endFunction
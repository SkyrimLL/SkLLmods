Scriptname SLP_FaceHuggerScript extends zadequipscript  


; Frameworks
SexLabFramework property SexLab auto
SLP_fcts_parasites Property fctParasites  Auto

; Keywords
Keyword Property zad_DeviousPlug Auto 

; Animations
Idle Property ZazAPCAO104 Auto

Function DeviceMenuExt(Int msgChoice)
; ; Insert Plugs
; 	if msgChoice == 3
;             BeltMenuInsertPlugs()
; ; Remove Plugs
; 	elseif msgChoice == 4
;             BeltMenuRemovePlugs()
; Excrete
	if msgChoice == 3
		BeltMenuExcrete()
; Masturbate
	elseif msgChoice == 4
		BeltMenuMasturbate()
	endif
EndFunction


function DeviceMenuRemoveWithKey()
    if RemoveDeviceWithKey()
	    string msg = ""
	    if Aroused.GetActorExposure(libs.PlayerRef) < libs.ArousalThreshold("Desire")
		    msg = "You poke the critter enough to force it away from you - more due to discomfort than your desire for pleasure."
	    elseif Aroused.GetActorExposure(libs.PlayerRef) < libs.ArousalThreshold("Horny")
		    msg = "You jab the critter in the right spot and let out a sigh of relief as it unwraps his legs from your hips."
	    elseif Aroused.GetActorExposure(libs.PlayerRef) < libs.ArousalThreshold("Desperate")
		    msg = "Unable to resist your carnal desires any longer you anxiously desperately jab the critter until it leaves your hips ."
	    else
		    msg = "After several frenzied attempts your trembling fingers finally manage to somehow pull the squirmy critter away from your throbbing sex."
	    endif
	    libs.Notify(msg, true)
    Endif
EndFunction


string Function DeviceMenuPickLockFail()
	libs.PlayerRef.RemoveItem(Lockpick)
	Aroused.UpdateActorExposure(libs.PlayerRef,1)
	return "In addition, your struggles with the creature have left you aroused. "
EndFunction

string function ReturnMagicAroused()
	Aroused.UpdateActorExposure(libs.PlayerRef,1)
	return "Furthermore, the tingling magical energies so near your groin leave you feeling aroused. "
EndFunction

string Function DeviceMenuDestructionModerate()
	return ReturnMagicAroused()
EndFunction

string Function DeviceMenuAlterationSuccess()
	return ReturnMagicAroused()
EndFunction

string Function DeviceMenuAlterationFail()
	return ReturnMagicAroused()
EndFunction

string Function DeviceMenuRestorationFail()
	return ReturnMagicAroused()
EndFunction
string Function DeviceMenuIllusionFail()
	return ReturnMagicAroused()
EndFunction

string Function DeviceMenuBruteForceFail()
	Aroused.UpdateActorExposure(libs.PlayerRef,2, "Brute force fail")
	return "Your efforts leave you both exhausted, and aroused."
EndFunction

function BeltMenuExcrete()
	libs.DisableControls()
	libs.PlayerRef.PlayIdle(ZazAPCAO104)
	;debug.notification("You answer the call of nature before cleaning yourself around the edges of the belt as much as possible.")
	libs.Notify("A stream of urine escapes your bladder")
	Utility.Wait(6) 				
	Debug.SendAnimationEvent(libs.PlayerRef, "IdleForceDefaultState")
	;libs.PlayerRef.PlayIdle(IdlePlayerStop)
	libs.UpdateControls()
EndFunction



function BeltMenuMasturbate()
	libs.NotifyPlayer("You attempt to seek relief from the burning desire that fills you...")
	sslBaseAnimation[] anims = SexLab.GetAnimationsByTag(1, "Solo", "F", "DeviousDevice", requireAll=true)
	actor[] tmp = new actor[1]
	tmp[0] = libs.PlayerRef
        Aroused.UpdateActorExposure(libs.PlayerRef,3)
	SexLab.StartSex(tmp, anims)
EndFunction



function SetupQuest()
        deviceQuest.SetObjectiveCompleted(00)
	if libs.PlayerRef.WornHasKeyword(zad_DeviousPlug)
		deviceQuest.setStage(20)
		deviceQuest.SetObjectivedisplayed(20)
	else
		deviceQuest.setStage(10)
		deviceQuest.SetObjectivedisplayed(10)
	Endif
EndFunction


Function ResetQuest()
      deviceQuest.SetObjectiveDisplayed(10,false)
      deviceQuest.SetObjectiveCompleted(10,false)
      deviceQuest.SetObjectiveDisplayed(20,false)
      deviceQuest.SetObjectiveCompleted(20,false)
      deviceQuest.SetObjectiveDisplayed(30,false)
      deviceQuest.SetObjectiveCompleted(30,false)
      deviceQuest.SetObjectiveDisplayed(80,false)
      deviceQuest.SetObjectiveCompleted(80,false)
      deviceQuest.SetObjectiveDisplayed(100,false)
      deviceQuest.SetObjectiveCompleted(100,false)
      deviceQuest.Reset()
EndFunction


int Function OnEquippedFilter(actor akActor, bool silent=false)
    ; if akActor==libs.PlayerRef && deviceQuest.getstage() >= 10; && menuDisable==false)

    ; Endif
    return 0
EndFunction


Function OnEquippedPre(actor akActor, bool silent=false)
	libs.StoreExposureRate(akActor)
	string msg = ""
	if akActor == libs.PlayerRef
		; Quest setup
		if deviceQuest.GetStage() >= 10; && menuDisable==false)
			libs.Log("Resetting... (Stage>=10)")
			ResetQuest()
		EndIf
		SetupQuest()
		; Dialogue
		if Aroused.GetActorExposure(akActor) < libs.ArousalThreshold("Desire")
			msg = "Calmly and with confidence you bring the squirming critter closer to your crotch."
		elseif Aroused.GetActorExposure(akActor) < libs.ArousalThreshold("Horny")
			msg = "With more confidence than foresight you press the squirming critter between your legs."
		elseif Aroused.GetActorExposure(akActor) < libs.ArousalThreshold("Desperate")
			msg = "Fighting against the urges inside your body you proceed to coax the squirmy critter to wrap around your waist."
		else
			msg = "In an act that seems like complete madness you rub yoursekf against the squirmy critter as it wraps itself around your waist."
		endif
	Else
		msg = akActor.GetLeveledActorBase().GetName() + " moans as you let the critter wrap itself around her hips."
	EndIf
	if !silent
		libs.NotifyActor(msg, akActor, true)
	EndIf
EndFunction


Function OnEquippedPost(actor akActor)
	float modRate = libs.GetModifiedRate(akActor)
        libs.Log("original exposure rate was " + libs.GetOriginalRate(akActor) + ". Setting to " + modRate + ".")
        Aroused.SetActorExposureRate(akActor, modRate)
	libs.CorsetMagic(akActor)

	fctParasites.applyFaceHugger(akActor )

EndFunction
 
int Function OnContainerChangedFilter(ObjectReference akNewContainer, ObjectReference akOldContainer)
	return 0
EndFunction


Function OnContainerChangedPre(ObjectReference akNewContainer, ObjectReference akOldContainer)
	libs.NotifyPlayer("The critter remains firmly locked around your hips.")
EndFunction


Function OnRemoveDevice(actor akActor)
	if akActor == libs.PlayerRef
		if deviceQuest.GetStage()>=80
			libs.Log("OnRemoveDevice() called when stage >=80")
		Else
			;        deviceQuest.SetObjectiveCompleted(100)
			;        deviceQuest.SetObjectivedisplayed(100)
			if Aroused.GetActorExposure(libs.PlayerRef) >= libs.ArousalThreshold("Desperate") ; && libs.Config.MasturbateOnBeltRemoval
				deviceQuest.SetObjectiveCompleted(10)
				deviceQuest.SetObjectiveFailed(20)
				deviceQuest.setStage(80)
			else
				deviceQuest.SetObjectiveCompleted(10)
				deviceQuest.SetObjectiveCompleted(20)
				deviceQuest.setStage(100)
			EndIf	
		Endif
	EndIf
	RestoreSettings(akActor)
	libs.CorsetMagic(akActor)
EndFunction


Function RestoreSettings(actor akActor)
	float originalExposureRate = libs.GetOriginalRate(akActor)
        libs.Log("Restoring original exposure rate to " + originalExposureRate)
        Aroused.SetActorExposureRate(akActor, originalExposureRate)
	StorageUtil.UnSetFloatValue(akActor, "zad.StoredExposureRate")
EndFunction

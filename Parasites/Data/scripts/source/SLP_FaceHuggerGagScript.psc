Scriptname SLP_FaceHuggerGagScript extends zadequipscript  

SLP_fcts_parasites Property fctParasites  Auto

Message Property callForHelpMsg Auto
Message Property zad_GagPreEquipMsg Auto
Message Property zad_GagEquipMsg Auto
Message Property zad_GagRemovedMsg Auto
Message Property zad_GagPickLockFailMsg Auto
Message Property zad_GagPickLockSuccessMsg Auto
Message Property zad_GagArmsTiedMsg Auto
Message Property zad_GagBruteForceArmsTiedMsg Auto
Message Property zad_GagBruteForceMsg Auto
import MfgConsoleFunc

Function OnEquippedPre(actor akActor, bool silent=false)
	if !silent
		if akActor == libs.PlayerRef
			zad_GagEquipMsg.Show()
		Else
			libs.NotifyActor("The creeper wraps itself into "+GetMessageName(akActor)+" mouth, and locks securely in place behind "+GetMessageName(akActor)+" head.", akActor, true)
		EndIf
	EndIf
	Parent.OnEquippedPre(akActor, silent)
EndFunction

Function DeviceMenuExt(int msgChoice)
	if msgChoice == 3
		libs.Moan(libs.PlayerRef)
		callForHelpMsg.Show()
	EndIf
EndFunction

function DeviceMenuRemoveWithKey()
	libs.PlayerRef.SendModEvent("SLPSexCure","FaceHuggerGag",1)
	if RemoveDeviceWithKey()
	    string msg = ""
	    if Aroused.GetActorExposure(libs.PlayerRef) < libs.ArousalThreshold("Desire")
		    msg = "You poke the critter enough to force it away from you."
	    elseif Aroused.GetActorExposure(libs.PlayerRef) < libs.ArousalThreshold("Horny")
		    msg = "You jab the critter in the right spot and let out a sigh of relief as it unwraps his legs from your face."
	    elseif Aroused.GetActorExposure(libs.PlayerRef) < libs.ArousalThreshold("Desperate")
		    msg = "Unable to resist any longer you anxiously desperately jab the critter until it leaves your face."
	    else
		    msg = "After several frenzied attempts your trembling fingers finally manage to somehow pull the squirmy critter away from your throbbing mouth."
	    endif
	    libs.Notify(msg, true)
    Endif
EndFunction

Function EscapeAttemptLockPick()
	Escape(0)
	DestroyLockPick()
	libs.NotifyPlayer("In addition, your struggles with the creature have left you exhausted.", true)
EndFunction

Function EscapeAttemptStruggle()
	Escape(0)
	libs.NotifyPlayer("Your efforts just leave you exhausted.", true)
EndFunction

string Function DeviceMenuPickLockSuccess()
	RemoveDevice(libs.PlayerRef)
	zad_GagPickLockSuccessMsg.Show()
	return ""
EndFunction
string Function DeviceMenuPickLockModerate()
	return ""
EndFunction
string Function DeviceMenuPickLockFail()
	Actor akActor = libs.PlayerRef as Actor

	if ( Utility.RandomInt(0,120) > Aroused.GetActorArousal(libs.PlayerRef) ) 
		libs.NotifyPlayer("You yank the face hugger with all your strength...", true)
		akActor.SendModEvent("SLPSexCure","FaceHuggerGag",1)
	else
		libs.PlayerRef.RemoveItem(Lockpick)
		zad_GagPickLockFailMsg.Show()
		return ""
	endif
EndFunction

Function DeviceMenuBruteForce()
	if libs.PlayerRef.WornHasKeyword(libs.zad_DeviousArmbinder)
		zad_GagBruteForceArmsTiedMsg.Show()
	Else
		zad_GagBruteForceMsg.show()
	EndIf
EndFunction



Function OnRemoveDevice(actor akActor)
	if !libs.IsAnimating(akActor)
		akActor.ClearExpressionOverride()
		ResetPhonemeModifier(akActor)
	EndIf
EndFunction

Function OnEquippedPost(actor akActor)
	libs.ApplyGagEffect(akActor)

	fctParasites.applyParasiteByString(akActor, "FaceHuggerGag" )

EndFunction

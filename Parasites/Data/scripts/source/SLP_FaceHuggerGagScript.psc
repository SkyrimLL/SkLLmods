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

Function DeviceMenuPickLock()
	if libs.PlayerRef.WornHasKeyword(libs.zad_DeviousArmbinder)
		zad_GagArmsTiedMsg.Show()
		return
	EndIf
	int unlockChance = libs.CheckDeviceEscape(libs.GetUnlockThreshold(), "Lockpicking")
        if (unlockChance == -1)
		DeviceMenuPickLockSuccess()
	else
		DeviceMenuPickLockFail()
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

Scriptname SLP_SpiderEggScript extends zadPlugScript  


Message Property squeezeMsg Auto

string strFailEquip =  "Try as you might, the belt you are wearing prevents you from inserting the slimy eggs inside you."

int Function OnEquippedFilter(actor akActor, bool silent=false)
	; FTM optimization
	if silent && akActor != libs.PlayerRef
		return 0
	EndIf
	if akActor.WornHasKeyword(zad_DeviousBelt)
		if akActor == libs.PlayerRef && !silent
			libs.NotifyActor(strFailEquip, akActor, true)
		ElseIf  !silent
			libs.NotifyActor("The belt " + akActor.GetLeveledActorBase().GetName() + " is wearing prevents you from inserting the slimy eggs.", akActor, true)
		EndIf
		return 2
	Endif
	return 0
EndFunction

Function OnEquippedPre(actor akActor, bool silent=false)
	string msg = ""
	if akActor == libs.PlayerRef
		if Aroused.GetActorExposure(akActor) < libs.ArousalThreshold("Desire")
			msg = "The eggs fits snugly inside your hole, spreading a wave of pleasure deep into your womb."
		elseif Aroused.GetActorExposure(akActor) < libs.ArousalThreshold("Horny")
			msg = "You carefully push the eggs through your pussy lips, your lust growing as they stretch you and slide in."
		elseif Aroused.GetActorExposure(akActor) < libs.ArousalThreshold("Desperate")
			msg = "You eagerly spread your thighs to stretch yourself further as the egg push way deep into your quivering hole, making you moan excitedly."
		else
			msg = "Barely in control of control your own body, you thrust the eggs almost forcefully into your steamy opening."
		endif
	else
		msg = akActor.GetLeveledActorBase().GetName() + " shudders as you push the eggs deep inside her."
	EndIf
	if !silent
		libs.NotifyActor(msg, akActor, true)
	EndIf
EndFunction


Function OnEquippedPost(actor akActor)
	Utility.Wait(5)
	bool legacyPlugs = false
	; Slots 48 and 54 Anal and Vaginal plugs      
	Form analSlot = akActor.GetWornForm(0x00040000)
	Form vagSlot = akActor.GetWornForm(0x01000000)
	if analSlot && vagSlot && analSlot == vagSlot
		legacyPlugs = true
	EndIf
	; if ((!akActor.WornHasKeyword(zad_DeviousBelt))  || (akActor.WornHasKeyword(zad_DeviousBelt) && akActor.WornHasKeyword(libs.zad_PermitAnal) && !legacyPlugs && deviceRendered.HasKeyword(libs.zad_DeviousPlugAnal))) && akActor.WornHasKeyword(zad_DeviousDevice) && !akActor.WornHasKeyword(libs.zad_EffectPossessed) && akActor == libs.PlayerRef && akActor.GetActorBase().GetSex() != 0
	; 	libs.Log("Belt not worn: Removing plugs.")
	; 	RemoveDevice(akActor)
	; 	if akActor == libs.PlayerRef
	; 		libs.NotifyPlayer("Lacking a belt to hold them in, the plugs slide out of you.")
	; 	else
	; 		libs.NotifyNPC("Lacking a belt to hold them in, the plugs slide out of "+akActor.GetLeveledActorBase().GetName()+".")
	; 		akActor.RemoveItem(deviceInventory, 1, true)
	; 		libs.PlayerRef.AddItem(deviceInventory, 1, true)
	; 	EndIf
	; EndIf
EndFunction


int Function OnUnequippedFilter(actor akActor)
	if akActor.WornHasKeyword(zad_DeviousBelt)
		return 1
	EndIf
	return 0
EndFunction


Function DeviceMenu(Int msgChoice = 0)
        msgChoice = zad_DeviceMsg.Show() ; display menu
	if msgChoice==0 ; Not wearing a belt, no plugs
		Debug.Notification("You choose to insert the eggs inside you.")
		libs.EquipDevice(libs.PlayerRef, deviceInventory, deviceRendered, zad_DeviousDevice)
	elseif msgChoice==1 ; Wearing a belt, no plugs
		Debug.MessageBox(strFailEquip)
	elseif msgChoice==2 ; Not wearing a belt, plugs
		string msg = ""
		int iDexterity = 10 + (Game.GetPlayer().GetAV("Pickpocket") as Int) / 10
		Debug.Notification("Dexterity: " + iDexterity )
		; Debug.Notification("Arousal: " + Aroused.GetActorArousal(libs.PlayerRef))
		if ( Aroused.GetActorArousal(libs.PlayerRef) <= 10 ) ; libs.ArousalThreshold("Desire")
			If (Utility.RandomInt(0,100) < iDexterity) 
				msg = "The eggs pop out of your hole one in rapid succession, kept together with foamy and slippery lubrication."
				libs.NotifyPlayer(msg, true)
				RemoveDevice(libs.PlayerRef)
			else
				msg = "Your fingers slip, causing the eggs to burrow deeper inside you and making you slippery in the process. You will have to give it another try when you are not so horny."
				libs.NotifyPlayer(msg, true)
			EndIf
			libs.UpdateExposure(libs.PlayerRef,2)		
		else	
			if ( Aroused.GetActorArousal(libs.PlayerRef) < 40 ) ; libs.ArousalThreshold("Horny")
				msg = "As you gently nudge the first egg, the others cluster together around your finger, blocking your hole and sending waves of pain and pleasure deep inside you."
				libs.UpdateExposure(libs.PlayerRef,2)

			elseif ( Aroused.GetActorArousal(libs.PlayerRef) < 80 ) ; libs.ArousalThreshold("Desperate")
				msg = "As you try scooping the slimy eggs through your tight opening, you can feel them stretch and occupy more of your vagina, making them impossible to remove."
				libs.UpdateExposure(libs.PlayerRef,2)
			else
				msg = "You desperately try to pull the glistening eggs out of your abused hole, only to feel your own womb clenching painfully around it and keeping them deeply buried inside you."
				libs.UpdateExposure(libs.PlayerRef,2)
			endif
			libs.NotifyPlayer(msg, true)

		endif
	elseif msgChoice==3 ; Wearing a belt, plugs
		NoKeyFailMessage(libs.PlayerRef)
	Endif
	DeviceMenuExt(msgChoice)
	SyncInventory()
EndFunction
		

Function NoKeyFailMessage(Actor akActor)
	libs.NotifyPlayer("The eggs are too deep to be removed that easily.", true)

EndFunction

Function DeviceMenuExt(Int msgChoice)
	if msgChoice == 4
		squeezeMsg.show()
		libs.UpdateExposure(libs.PlayerRef,2)
	EndIf
EndFunction

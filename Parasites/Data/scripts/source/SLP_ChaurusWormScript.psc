Scriptname SLP_ChaurusWormScript extends zadPlugScript  

 
Message Property squeezeMsg Auto

string strFailEquip =  "Try as you might, the belt you are wearing prevents you from inserting the slimy worm inside you."

int Function OnEquippedFilter(actor akActor, bool silent=false)
	; FTM optimization
	if silent && akActor != libs.PlayerRef
		return 0
	EndIf
	if akActor.WornHasKeyword(zad_DeviousBelt)
		if akActor == libs.PlayerRef && !silent
			libs.NotifyActor(strFailEquip, akActor, true)
		ElseIf  !silent
			libs.NotifyActor("The belt " + akActor.GetLeveledActorBase().GetName() + " is wearing prevents you from inserting the slimy worm.", akActor, true)
		EndIf
		return 2
	Endif
	return 0
EndFunction

Function OnEquippedPre(actor akActor, bool silent=false)
	string msg = ""
	if akActor == libs.PlayerRef
		if Aroused.GetActorExposure(akActor) < libs.ArousalThreshold("Desire")
			msg = "The worm fits snugly inside your hole, spreading a wave of pleasure deep into your belly."
		elseif Aroused.GetActorExposure(akActor) < libs.ArousalThreshold("Horny")
			msg = "You carefully let the worm crawl its way into your opening, your lust growing with every inch it slides in."
		elseif Aroused.GetActorExposure(akActor) < libs.ArousalThreshold("Desperate")
			msg = "You eagerly spread your lips to let the worm ease its way deep into your quivering hole, making you squeal with delight in the resulting waves of pleasure."
		else
			msg = "Barely in control of control your own body, you thrust the worm almost forcefully into your wet opening."
		endif
	else
		msg = akActor.GetLeveledActorBase().GetName() + " shudders as you let the worm crawl deep inside her."
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
		Debug.Notification("You choose to insert the worm inside you.")
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
				msg = "The worm squirms as it slides out your hole, leaving a slipery trail behind."
				libs.NotifyPlayer(msg, true)
				RemoveDevice(libs.PlayerRef)
			else
				msg = "Your fingers slip, causing the worm to retract deeper and making you wet in the process. You will have to give it another try when you are not so horny."
				libs.NotifyPlayer(msg, true)
			EndIf

			libs.UpdateExposure(libs.PlayerRef,2)
		else	
			if ( Aroused.GetActorArousal(libs.PlayerRef) < 40 ) ; libs.ArousalThreshold("Horny")
				msg = "As you tug at the slimy end of the worm, its teeth sink in deeper into your vaginal walls, feeding on your juices and shooting shards of pain and pleasure deep inside you."
				libs.UpdateExposure(libs.PlayerRef,2)

			elseif ( Aroused.GetActorArousal(libs.PlayerRef) < 80 ) ; libs.ArousalThreshold("Desperate")
				msg = "As you pull at the slimy worm through your now well lubricated opening, you can feel it inflate and occupy your whole vaginaly cavity, making it impossible to remove."
				libs.UpdateExposure(libs.PlayerRef,2)
			else
				msg = "You desperately try to pull the glistening worm out of your hole, only to feel your own vagina clenching around it and keeping it firmly inside you."
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
	libs.NotifyPlayer("The worm is too deep to be removed that easily.", true)

EndFunction

Function DeviceMenuExt(Int msgChoice)
	if msgChoice == 4
		squeezeMsg.show()
		libs.UpdateExposure(libs.PlayerRef,2)
	EndIf
EndFunction
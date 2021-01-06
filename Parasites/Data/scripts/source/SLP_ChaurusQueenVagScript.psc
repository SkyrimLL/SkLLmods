Scriptname SLP_ChaurusQueenVagScript extends zadPlugScript  


Message Property squeezeMsg Auto
SLP_fcts_parasites Property fctParasites  Auto

string strFailEquip =  "You can feel the parasite churn and push inside you, but he belt you are wearing is keeping it deep inside your womb."

int Function OnEquippedFilter(actor akActor, bool silent=false)
	; FTM optimization
	if silent && akActor != libs.PlayerRef
		return 2
	EndIf
	if !silent && akActor != libs.PlayerRef
		libs.NotifyActor("Without the Seed Stone inside them, the parasite rejects " + akActor.GetLeveledActorBase().GetName() + " as a host.", akActor, true)
		return 2
	EndIf
	if akActor.WornHasKeyword(zad_DeviousBelt)
		if akActor == libs.PlayerRef && !silent
			libs.NotifyActor(strFailEquip, akActor, true)
		ElseIf  !silent
			libs.NotifyActor("Without the Seed Stone inside them, the parasite rejects " + akActor.GetLeveledActorBase().GetName() + " as a host.", akActor, true)
		EndIf
		return 2
	Endif
	return 0
EndFunction

Function OnEquippedPre(actor akActor, bool silent=false)
	string msg = ""
	if akActor == libs.PlayerRef
		if Aroused.GetActorExposure(akActor) < libs.ArousalThreshold("Desire")
			msg = "The parasite in your womb stirs and fills your vagina snugly, leaving your lips slightly parted and wet."
		elseif Aroused.GetActorExposure(akActor) < libs.ArousalThreshold("Horny")
			msg = "The parasite in your womb extends past your vagina and keeps your lips spread wide."
		elseif Aroused.GetActorExposure(akActor) < libs.ArousalThreshold("Desperate")
			msg = "The parasite in your womb spreads your vagina wide open."
		else
			msg = "You can feel the parasite in your womb fill your vagina and squirm between your thighs."
		endif
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

	fctParasites.applyChaurusQueenVag(akActor )


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
		Debug.Notification("You stroke yourself with the Seed and coax the parasite out of its confinement.")
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
				msg = "Pushing and prying with your fingers, you manage to push the parasite back inside your womb."
				libs.NotifyPlayer(msg, true)
				RemoveDevice(libs.PlayerRef)
			else
				msg = "Your fingers slip, causing the parasite to extend and throb, and making you wet in the process. "
				libs.NotifyPlayer(msg, true)
			EndIf

			libs.UpdateExposure(libs.PlayerRef,2)
		else	
			if ( Aroused.GetActorArousal(libs.PlayerRef) < 40 ) ; libs.ArousalThreshold("Horny")
				msg = "As you keep pushing and tugging, the parasite keeps slipping away and growing thicker between your lips."
				libs.UpdateExposure(libs.PlayerRef,2)

			elseif ( Aroused.GetActorArousal(libs.PlayerRef) < 80 ) ; libs.ArousalThreshold("Desperate")
				msg = "As you pull at the slimy worm through your now well lubricated opening, you can feel it inflate and occupy your whole vaginal cavity, making it impossible to push on."
				libs.UpdateExposure(libs.PlayerRef,2)
			else
				msg = "You desperately try to pull the glistening worm back inside your hole, only to feel your own vagina clenching around it and keeping it firmly inside you."
				libs.UpdateExposure(libs.PlayerRef,2)
			endif
			libs.NotifyPlayer(msg, true)

		endif
	elseif msgChoice==3 ; Wearing a belt, plugs
		Debug.MessageBox(strFailEquip)
	Endif
	DeviceMenuExt(msgChoice)
	SyncInventory()
EndFunction
		

Function NoKeyFailMessage(Actor akActor)
	if ( Utility.RandomInt(0,120) > Aroused.GetActorArousal(libs.PlayerRef) ) 
		libs.NotifyPlayer("The parasite reluctantly slide back inside you, leaving behind a small appendage similar to the seed stone.", true)
		akActor.SendModEvent("SLPSexCure","ChaurusQueenVag",1)
	else
		libs.NotifyPlayer("The worm is too slippery to be pushed back in that easily.", true)
	endif

EndFunction

Function DeviceMenuExt(Int msgChoice)
	if msgChoice == 4
		squeezeMsg.show()
		libs.UpdateExposure(libs.PlayerRef,2)
	EndIf
EndFunction
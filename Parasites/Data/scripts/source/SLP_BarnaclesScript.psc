Scriptname SLP_BarnaclesScript extends zadPlugScript  


Function OnEquippedPre(actor akActor, bool silent=false)
	if !silent
		if akActor == libs.PlayerRef
			libs.NotifyActor("Glowing spores attach themselves to your skin and start throbbing as they exude sweet fluids.", akActor, true)
		Else
			libs.NotifyActor(GetMessageName(akActor) +" yelps as the glowing spores spread across her body.", akActor, true)
			
		EndIf
	EndIf
EndFunction

int Function OnEquippedFilter(actor akActor, bool silent=false)
	ActorBase 	pActorBase  
	if akActor == none
		akActor == libs.PlayerRef
	EndIf
	pActorBase = akActor.GetActorBase()

	if ! akActor.IsEquipped(deviceRendered)
		if akActor!=libs.PlayerRef && ShouldEquipSilently(akActor)
			libs.Log("Avoiding FTM duplication bug (Harness).")
			return 0
		EndIf
		if akActor.WornHasKeyword(libs.zad_DeviousCorset)
			MultipleItemFailMessage("Corset")
			return 2
		Endif
		if (pActorBase.GetSex()==0)
			libs.NotifyActor("The spores refuse to attach themselves around a male.", akActor, true)
			return 2
		Endif
	Endif
	return 0
EndFunction


Function OnEquippedPost(actor akActor)
	libs.Log("RestraintScript OnEquippedPost BodyHarness")
EndFunction

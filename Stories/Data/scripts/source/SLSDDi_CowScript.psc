Scriptname SLSDDi_CowScript extends zadRestraintScript  

Function OnEquippedPre(actor akActor, bool silent=false)
	if !silent
		if akActor == libs.PlayerRef
			libs.NotifyActor("You step in to the harness, securing it tightly against your body.", akActor, true)
		Else
			libs.NotifyActor(GetMessageName(akActor) +" steps in to the harness, securing it tightly against her body.", akActor, true)
			
		EndIf
	EndIf

	; _SLS_MilkProduced.SetValue(1)
	
	Parent.OnEquippedPre(akActor, silent)
EndFunction

int Function OnEquippedFilter(actor akActor, bool silent=false)
	ActorBase 	pActorBase  

	if akActor == none
		akActor == libs.PlayerRef
	EndIf

	pActorBase = akActor.GetActorBase()

	if !akActor.IsEquipped(deviceRendered)
		if akActor!=libs.PlayerRef && ShouldEquipSilently(akActor)
			libs.Log("Avoiding FTM duplication bug (Harness + Collar).")
			return 0
		EndIf
		if akActor.WornHasKeyword(libs.zad_DeviousCollar)
			MultipleItemFailMessage("Collar")
			return 2
		Endif
		if (pActorBase.GetSex()==0)
			if akActor == libs.PlayerRef
				libs.NotifyActor("The harness is designed for the female form and will not fit you.", akActor, true)
			Else
				libs.NotifyActor(GetMessageName(akActor) +" cannot fit in the harness as it is designed for the female shape.", akActor, true)
				
			EndIf
			return 2
		Endif
	Endif
	return 0
EndFunction


Function OnEquippedPost(actor akActor)
	libs.Log("RestraintScript OnEquippedPost CowHarness")
EndFunction

GlobalVariable Property _SLS_MilkProduced  Auto  
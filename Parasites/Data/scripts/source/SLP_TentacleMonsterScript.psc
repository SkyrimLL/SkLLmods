Scriptname SLP_TentacleMonsterScript extends zadequipscript  

Function OnEquippedPre(actor akActor, bool silent=false)
	if !silent
		if akActor == libs.PlayerRef
			libs.NotifyActor("The slimy tentacles wrap themselves tightly around your body while a throbbing appendage forces its way between your legs.", akActor, true)
		Else
			libs.NotifyActor(GetMessageName(akActor) +" yelps as the tentacles wraps around her body.", akActor, true)
			
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
			libs.NotifyActor("The creature refuses to wrap itself around a male.", akActor, true)
			return 2
		Endif
	Endif
	return 0
EndFunction


Function OnEquippedPost(actor akActor)
	libs.Log("RestraintScript OnEquippedPost BodyHarness")
EndFunction

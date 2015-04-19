Scriptname SLSDDi_MilkBra extends zadBaseEvent  

Bool Function Filter(actor akActor, int chanceMod=0)
	 return (akActor.WornHasKeyword(libs.zad_DeviousBra) && Parent.Filter(akActor, chanceMod))
EndFunction

Function Execute(actor akActor)
	if libs.Aroused.GetActorExposure(akActor) >= libs.ArousalThreshold("Horny")
		libs.NotifyPlayer("Your hard nipples throb painfully inside the suction cups.")
		libs.UpdateExposure(akActor, 0.10)
	else
		libs.NotifyPlayer("The suction cups uncomfortably weighs your chest down.")
	EndIf	
EndFunction
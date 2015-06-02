Scriptname SLSDDi_MilkDrip extends zadBaseEvent  

Bool Function Filter(actor akActor, int chanceMod=0)
	 return (akActor.WornHasKeyword( SLSD_CowHarness   ) && Parent.Filter(akActor, chanceMod))
EndFunction

Function Execute(actor akActor)
	libs.NotifyPlayer("You feel excess drops of milk running down your breasts.")
	;if akActor.WornHasKeyword(zad_DeviousPlug)
	; TODO: Add some sort of animation here. Perhaps a wetness decal.	
EndFunction

Keyword Property SLSD_CowHarness Auto
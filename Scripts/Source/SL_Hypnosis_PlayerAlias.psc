Scriptname SL_Hypnosis_PlayerAlias extends ReferenceAlias  

SL_Hypnosis_Maintenance Property _SLMC_Util Auto

Event OnPlayerLoadGame()
	_SLMC_Util.Maintenance()
EndEvent
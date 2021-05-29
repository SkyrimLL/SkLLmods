Scriptname SLP_SprigganFeetScript extends zadRestraintScript  

SLP_fcts_parasites Property fctParasites  Auto

Function OnEquippedPre(actor akActor, bool silent=false)
	if !silent
	;	libs.NotifyActor("You slip the restraints around "+GetMessageName(akActor)+" legs, and they lock in place with a soft click.", akActor, true)
	EndIf
	Parent.OnEquippedPre(akActor, silent)
EndFunction

Function OnEquippedPost(actor akActor)
	libs.Log("RestraintScript OnEquippedPost Legs")

	fctParasites.applyParasiteByString(akActor, "SprigganRootFeet" )
EndFunction

Scriptname SLP_SprigganArmsScript extends zadRestraintScript  

SLP_fcts_parasites Property fctParasites  Auto

Function OnEquippedPre(actor akActor, bool silent=false)
	if !silent
	;	libs.NotifyActor("You slip the restraints around "+GetMessageName(akActor)+" arms, and they lock in place with a soft click.", akActor, true)
	EndIf
	Parent.OnEquippedPre(akActor, silent)
EndFunction

Function OnEquippedPost(actor akActor)
	libs.Log("RestraintScript OnEquippedPost Arms")

	fctParasites.applyParasiteByString(akActor, "SprigganRootArms" )
EndFunction

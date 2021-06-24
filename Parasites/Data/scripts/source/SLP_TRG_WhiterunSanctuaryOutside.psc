Scriptname SLP_TRG_WhiterunSanctuaryOutside extends ObjectReference  

ObjectReference Property SLP_WhiterunSantuaryOutsideDoorRef Auto

Event OnActivate(ObjectReference akActionRef)
  Debug.Trace("Activated by " + akActionRef)

  if (akActionRef==Game.getPlayer())
  	SLP_WhiterunSantuaryOutsideDoorRef.disable()
  endif
EndEvent
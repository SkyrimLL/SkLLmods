Scriptname SLH_QST_PlayerAlias  extends ReferenceAlias  

SLH_QST_HormoneGrowth Property SLH_Control Auto
SLH_fctUtil Property fctUtil Auto

Keyword Property ArmorOn  Auto  
Keyword Property ClothingOn  Auto  

Event OnPlayerLoadGame()

	  fctUtil.bEstrusChaurus = false
	  fctUtil.bBeeingFemale = false
	  int idx = Game.GetModCount()
	  string modName = ""
	  while idx > 0
	    idx -= 1
	    modName = Game.GetModName(idx)
	    if modName == "EstrusChaurus.esp"
	      fctUtil.bEstrusChaurus = true
	      fctUtil.ChaurusBreeder = Game.GetFormFromFile(0x00019121, modName) as spell
	    elseif modName == "BeeingFemale.esm"
	      fctUtil.bBeeingFemale = true
	      fctUtil.BeeingFemalePregnancy = Game.GetFormFromFile(0x000028A0, modName) as spell
	    endif
	  endWhile

	SLH_Control.Maintenance()

EndEvent
 
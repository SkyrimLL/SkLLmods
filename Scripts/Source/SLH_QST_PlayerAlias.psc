Scriptname SLH_QST_PlayerAlias  extends ReferenceAlias  

SLH_QST_HormoneGrowth Property SLH_Util Auto

Event OnPlayerLoadGame()

	  SLH_Util.bEstrusChaurus = false
	  SLH_Util.bBeeingFemale = false
	  int idx = Game.GetModCount()
	  string modName = ""
	  while idx > 0
	    idx -= 1
	    modName = Game.GetModName(idx)
	    if modName == "EstrusChaurus.esp"
	      SLH_Util.bEstrusChaurus = true
	      SLH_Util.ChaurusBreeder = Game.GetFormFromFile(0x00019121, modName) as spell
	    elseif modName == "BeeingFemale.esm"
	      SLH_Util.bBeeingFemale = true
	      SLH_Util.BeeingFemalePregnancy = Game.GetFormFromFile(0x000028A0, modName) as spell
	    endif
	  endWhile

	SLH_Util.Maintenance()

EndEvent
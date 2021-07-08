Scriptname SLP_fcts_parasites_devious extends Quest  
Import Utility
Import SKSE

zadLibs Property libs Auto



;  http://wiki.tesnexus.com/index.php/Skyrim_bodyparts_number
;
;  This is the list of the body parts used by Bethesda and named in the Creation Kit:
;    30   - head
;    31     - hair
;    32   - body (full)
;    33   - hands
;    34   - forearms
;    35   - amulet
;    36   - ring
;    37   - feet
;    38   - calves
;    39   - shield
;    40   - tail
;    41   - long hair
;    42   - circlet
;    43   - ears
;    50   - decapitated head
;    51   - decapitate
;    61   - FX01
;  
;  Other body parts that exist in vanilla nif models
;    44   - Used in bloodied dragon heads, so it is free for NPCs
;    45   - Used in bloodied dragon wings, so it is free for NPCs
;    47   - Used in bloodied dragon tails, so it is free for NPCs
;    130   - Used in helmetts that conceal the whole head and neck inside
;    131   - Used in open faced helmets\hoods (Also the nightingale hood)
;    141   - Disables Hair Geometry like 131 and 31
;    142   - Used in circlets
;    143   - Disabled Ear geometry to prevent clipping issues?
;    150   - The gore that covers a decapitated head neck
;    230   - Neck, where 130 and this meets is the decapitation point of the neck
;  
;  Free body slots and reference usage
;    44   - face/mouth
;    45   - neck (like a cape, scarf, or shawl, neck-tie etc)
;    46   - chest primary or outergarment
;    47   - back (like a backpack/wings etc)
;    48   - misc/FX (use for anything that doesnt fit in the list)
;    49   - pelvis primary or outergarment
;    52   - pelvis secondary or undergarment
;    53   - leg primary or outergarment or right leg
;    54   - leg secondary or undergarment or leftt leg
;    55   - face alternate or jewelry
;    56   - chest secondary or undergarment
;    57   - shoulder
;    58   - arm secondary or undergarment or left arm
;    59   - arm primary or outergarment or right arm
;    60   - misc/FX (use for anything that doesnt fit in the list)



; Devious Devices 2.9
; Gags: 44
; Collars: 45
; Armbinder: 46
; Plugs (Anal): 48
; Chastity Belts: 49
; Vaginal Piercings: 50
; Nipple Piercings: 51
; Cuffs (Legs): 53
; Blindfold: 55
; Chastity Bra: 56
; Plugs (Vaginal): 57
; Body Harness: 58
; Cuffs (Arms): 59


;---------------------------------------------------
Keyword Function getDeviousDeviceKeywordByString(String deviousKeyword = ""  )
	Keyword thisKeyword = None
 
	if (deviousKeyword == "zad_BlockGeneric")
		thisKeyword = libs.zad_BlockGeneric
		
	elseif (deviousKeyword == "zad_Lockable")
		thisKeyword = libs.zad_Lockable

	elseif (deviousKeyword == "zad_DeviousCollar") || (deviousKeyword == "Collar") 
		thisKeyword = libs.zad_DeviousCollar

	elseif (deviousKeyword == "zad_DeviousArmbinder") || (deviousKeyword == "Armbinder")  || (deviousKeyword == "Armbinders") 
		thisKeyword = libs.zad_DeviousArmbinder

	elseif (deviousKeyword == "zad_DeviousLegCuffs") || (deviousKeyword == "LegCuffs")  || (deviousKeyword == "LegCuff") 
		thisKeyword = libs.zad_DeviousLegCuffs

	elseif (deviousKeyword == "zad_DeviousGag") || (deviousKeyword == "Gag") 
		thisKeyword = libs.zad_DeviousGag

	elseif (deviousKeyword == "zad_DeviousBlindfold") || (deviousKeyword == "Blindfold") 
		thisKeyword = libs.zad_DeviousBlindfold

	elseif (deviousKeyword == "zad_DeviousBelt") || (deviousKeyword == "Belt") 
		thisKeyword = libs.zad_DeviousBelt

	elseif (deviousKeyword == "zad_DeviousPlug") || (deviousKeyword == "Plug") 
		thisKeyword = libs.zad_DeviousPlug

	elseif (deviousKeyword == "zad_DeviousPlugAnal") || (deviousKeyword == "PlugAnal") 
		thisKeyword = libs.zad_DeviousPlugAnal

	elseif (deviousKeyword == "zad_DeviousPlugVaginal") || (deviousKeyword == "PlugVaginal") 
		thisKeyword = libs.zad_DeviousPlugVaginal

	elseif (deviousKeyword == "zad_DeviousBra") || (deviousKeyword == "Bra") 
		thisKeyword = libs.zad_DeviousBra

	elseif (deviousKeyword == "zad_DeviousArmCuffs") || (deviousKeyword == "ArmCuffs")  || (deviousKeyword == "ArmCuff") 
		thisKeyword = libs.zad_DeviousArmCuffs

	elseif (deviousKeyword == "zad_DeviousYoke") || (deviousKeyword == "Yoke") 
		thisKeyword = libs.zad_DeviousYoke

	elseif (deviousKeyword == "zad_DeviousCorset") || (deviousKeyword == "Corset") 
		thisKeyword = libs.zad_DeviousCorset

	elseif (deviousKeyword == "zad_DeviousClamps") || (deviousKeyword == "Clamps") 
		thisKeyword = libs.zad_DeviousClamps

	elseif (deviousKeyword == "zad_DeviousGloves") || (deviousKeyword == "Gloves") 
		thisKeyword = libs.zad_DeviousGloves

	elseif (deviousKeyword == "zad_DeviousHood") || (deviousKeyword == "Hood") 
		thisKeyword = libs.zad_DeviousHood

	elseif (deviousKeyword == "zad_DeviousSuit") || (deviousKeyword == "Suits") 
		thisKeyword = libs.zad_DeviousSuit

	elseif (deviousKeyword == "zad_DeviousGagPanel") || (deviousKeyword == "GagPanel") 
		thisKeyword = libs.zad_DeviousGagPanel

	elseif (deviousKeyword == "zad_DeviousPlug") || (deviousKeyword == "Plug") 
		thisKeyword = libs.zad_DeviousPlug

	elseif (deviousKeyword == "zad_DeviousHarness") || (deviousKeyword == "Harness") 
		thisKeyword = libs.zad_DeviousHarness

	elseif (deviousKeyword == "zad_DeviousBoots") || (deviousKeyword == "Boots") 
		thisKeyword = libs.zad_DeviousBoots

	elseif (deviousKeyword == "zad_DeviousPiercingsNipple") || (deviousKeyword == "PiercingNipple")  || (deviousKeyword == "NipplePiercing")|| (deviousKeyword == "NipplePiercings") 
		thisKeyword = libs.zad_DeviousPiercingsNipple

	elseif (deviousKeyword == "zad_DeviousPiercingsVaginal") || (deviousKeyword == "PiercingVaginal")|| (deviousKeyword == "VaginalPiercing")|| (deviousKeyword == "VaginalPiercings") 
		thisKeyword = libs.zad_DeviousPiercingsVaginal

	else
		; Debug.Notification("[SLP] SLP_fcts_parasites_devious - getDeviousKeywordByString: Unknown generic keyword: " + deviousKeyword)  
		Debug.Trace("[SLP] SLP_fcts_parasites_devious - getDeviousKeywordByString: Unknown generic keyword: " + deviousKeyword)  
	endIf

	return thisKeyword
EndFunction

;---------------------------------------------------
Function equipParasiteNPC ( Actor akActor, String sParasiteString = "", Keyword kwDeviceKeyword, Armor aWornDevice, Armor aRenderedDevice,  bool skipEvents = false, bool skipMutex = false)

	String sGenericDeviceTags = ""
	Form kForm	
	Bool bDeviceEquipSuccess = False

 	if (akActor == none)
 		Return
 	endif

	If (kwDeviceKeyword != None)

		if !akActor.WornHasKeyword(kwDeviceKeyword)
			Debug.Trace("[SLP] equipParasiteByString: " + sParasiteString)  
			Debug.Trace("[SLP]		keyword: " + kwDeviceKeyword)  


			If (aRenderedDevice!=None)
				equipParasiteDD ( akActor, aWornDevice,  aRenderedDevice,  kwDeviceKeyword)
			Else
				Debug.Trace("[SLP]   Can't get worn device")
			endif

 
		else
			Debug.Trace("[SLP] player is already wearing: " + sParasiteString)  
		endIf

	else
		Debug.Trace("[SLP] unknown device to equip " )  

	endif
EndFunction


Function clearParasiteNPC ( Actor akActor, String sParasiteString = "", Keyword kwDeviceKeyword, Armor aWornDevice, bool skipEvents = false, bool skipMutex = false )
	Armor aRenderedDevice = none 
	Form kForm

	; Debug.Trace("[SLP] clearParasiteByString - NO override detected")  
 
	If (kwDeviceKeyword != None)

		if akActor.WornHasKeyword(kwDeviceKeyword)
			; RemoveDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool destroyDevice=false, bool skipEvents=false, bool skipMutex=false)

			Debug.Trace("[SLP] clearing device string: " + sParasiteString)  
			Debug.Trace("[SLP] clearing device keyword: " + kwDeviceKeyword)  
  
			aRenderedDevice = libs.GetRenderedDevice(aWornDevice) as Armor ; getParasiteRenderedByKeyword(kwDeviceKeyword) 

			If (aRenderedDevice!=None)
				clearParasiteDD ( akActor, aWornDevice,  aRenderedDevice,  kwDeviceKeyword)
			Else
				Debug.Trace("[SLP]   Can't get worn device")
			endif
			
			; libs.ManipulateGenericDeviceByKeyword(PlayerActor, kwDeviceKeyword, False, skipEvents,  skipMutex)
  

		else
			Debug.Trace("[SLP] player is not wearing: " + sParasiteString)  
		endIf

	else
		Debug.Trace("[SLP] unknown device to clear " )  

	endif
EndFunction


Bool Function equipParasiteDD ( Actor akActor, Armor ddArmorInventory, Armor ddArmorRendered, Keyword ddArmorKeyword)
	Keyword kwWornKeyword
	Bool bDeviceEquipSuccess = False

	libs.Log("[SLP] equipParasite " )

	if (ddArmorKeyword != None)
		if (!akActor.WornHasKeyword(ddArmorKeyword))

			bDeviceEquipSuccess = libs.equipDevice(akActor, ddArmorInventory , ddArmorRendered , ddArmorKeyword)
			bDeviceEquipSuccess = True
		Else
			libs.Log("[SLP]  	skipped - device already equipped " )
		EndIf
	Else
		Debug.Notification("[SLP] equipParasite - bad keyword " )
	endIf

	return bDeviceEquipSuccess
EndFunction


Bool Function clearParasiteDD ( Actor akActor, Armor ddArmorInventory, Armor ddArmorRendered, Keyword ddArmorKeyword, Bool bDestroy = True) 
	Keyword kwWornKeyword
	Bool bDeviceRemoveSuccess = False

	If (bDestroy)
		libs.Log("[SLP] clearParasite - destroy: " + ddArmorKeyword )
	Else
		libs.Log("[SLP] clearParasite - remove: " + ddArmorKeyword  )
	endIf

	; RemoveDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool destroyDevice=false, bool skipEvents=false, bool skipMutex=false)
	libs.RemoveDevice(akActor, ddArmorInventory , ddArmorRendered , ddArmorKeyword, bDestroy, False, True)
 
	bDeviceRemoveSuccess = True
 
	return bDeviceRemoveSuccess
EndFunction


Bool Function ActorHasKeyword(actor akActor, Keyword kwDeviceKeyword)
	return libs.ActorHasKeyword(akActor, kwDeviceKeyword )
EndFunction

Bool Function ActorHasKeywordByString(actor akActor, String deviousKeyword = "")
	return libs.ActorHasKeyword(akActor, getDeviousDeviceKeywordByString( deviousKeyword ))
EndFunction

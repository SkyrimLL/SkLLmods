Scriptname SLH_fctColor extends Quest  

Import Utility
Import Math
Import ColorComponent 

SLH_fctUtil Property fctUtil Auto

ColorForm Property thisHairColor Auto

; ====================================================
; Deprecated global variables

; GlobalVariable      Property GV_useColors 				Auto
; GlobalVariable      Property GV_useHairColors 			Auto
; GlobalVariable      Property GV_redShiftColor  			Auto
; GlobalVariable      Property GV_redShiftColorMod 		Auto
; GlobalVariable      Property GV_blueShiftColor 			Auto
; GlobalVariable      Property GV_blueShiftColorMod 		Auto
; GlobalVariable      Property GV_enableNiNodeOverride	Auto

; Int iDefaultSkinColor = -1
; Int iBlueSkinColor = -1
; Float fBlueSkinColorMod = 0.0
; Int iRedSkinColor = -1
; Float fRedSkinColorMod = 0.0
; Int iSuccubusBlueSkinColor = 0
; Int iSuccubusRedSkinColor = 0
; Int iOrigSkinColor = 0
; Int iOrigCheeksColor = 0
; Int iOrigLipsColor = 0
; Int iOrigEyelinerColor = 0

; Int iSkinColor 			= 0
; Int iCheeksColor 		= 0
; Int iLipsColor 			= 0
; Int iEyelinerColor 		= 0

; Int iEyesIndexOrig = 0
; Int iHairIndexOrig = 0
; Int iHairColorOrig = 0
; Int iOrigEyesColor = 0
; Int iOrigHairColor = 0
; Int iEyesColor = 0
; Int iHairColor = 0
; Int iHairColorSuccubus = 0
; Int iHairColorBimbo = 0

; SKIN TONE =======================================================

; Types
; 0 - Frekles
; 1 - Lips
; 2 - Cheeks
; 3 - Eyeliner
; 4 - Upper Eyesocket
; 5 - Lower Eyesocket
; 6 - SkinTone
; 7 - Warpaint
; 8 - Frownlines
; 9 - Lower Cheeks
; 10 - Nose
; 11 - Chin
; 12 - Neck
; 13 - Forehead
; 14 - Dirt

; Old code to change color layers - ignored for now because of 'color bleeding' between layers
;
; If (fctUtil.isFemale(kActor))
	; SkinColor only for now - issues with coloring of tattoos and other layers

	; cheeks
	; iCheeksColor = alterTintMaskRelativeRGB(colorBase = iCheeksColor, maskType = 9, maskIndex = 0, aOffset = rgbColorOffset, rOffset = rgbColorOffset, gOffset = 0, bOffset = 0)

	; lips
	; iLipsColor = alterTintMaskRelativeRGB(colorBase = iLipsColor, maskType = 1, maskIndex = 0, aOffset = rgbColorOffset, rOffset = rgbColorOffset * 2, gOffset = 0, bOffset = 0)

	; Eyeliner 
	; iEyelinerColor = alterTintMaskRelativeRGB(colorBase = iEyelinerColor, maskType = 3, maskIndex = 0, aOffset = rgbColorOffset, rOffset = -5, gOffset = -5, bOffset = -5)
; EndIf

function alterColorFromHormone(Actor kActor)				
 	Actor PlayerActor = Game.GetPlayer()

	Float Libido  = StorageUtil.GetFloatValue(kActor, "_SLH_fLibido")
	Float AbsLibido = Math.abs(Libido)

	int iSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_iSuccubus") 
	Int iDaedricInfluence = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneSuccubus" ) as Int
	Int iSexActivityBuffer = StorageUtil.GetIntValue(PlayerActor, "_SLH_iSexActivityBuffer")
	Int iSexActivityThreshold = StorageUtil.GetIntValue(PlayerActor, "_SLH_iSexActivityThreshold")
	Int iSexCountToday = StorageUtil.GetIntValue(kActor, "_SLH_iSexCountToday") 
	Int iGameDateLastSex = StorageUtil.GetIntValue(kActor, "_SLH_iGameDateLastSex") 
	Int iDaysSinceLastSex = (Game.QueryStat("Days Passed") - iGameDateLastSex ) as Int
	StorageUtil.SetIntValue(kActor, "_SLH_iDaysSinceLastSex", iDaysSinceLastSex)

	Float fSwellFactor =  StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneSexDrive") 
	Float fPigmentationFactor = (StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormonePigmentation") / 100.0 ) 
	Int iPigmentationLevel = (StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormoneSexDrive" ) * 255.0 / 200.0) as Int

	Int iOrigSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iDefaultSkinColor")
	Int iSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iSkinColor")

	Int iRedSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iRedShiftColor")
	Float fRedSkinColorMod = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fRedShiftColorMod") * fPigmentationFactor

	Int iBlueSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iBlueShiftColor") 
	Float fBlueSkinColorMod = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBlueShiftColorMod") * fPigmentationFactor

	Int iSuccubusRedSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iRedShiftColor")
	Int iSuccubusBlueSkinColor =  StorageUtil.GetIntValue(PlayerActor, "_SLH_iBlueShiftColor")


	If (StorageUtil.GetIntValue(none, "_SLH_iHormonesSleepInit")==0)
		; Mod Init safety - sleep first
		Return
	Endif

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseColors") == 1)
		; skin
		
		debugTrace("  alterColorFromHormone: iSkinColor BEFORE: " + fctUtil.IntToHex(iSkinColor) )
		debugTrace("     iSkinColor: " + iSkinColor ) 
		debugTrace("     iOrigSkinColor: " + fctUtil.IntToHex(iOrigSkinColor)  )

		debugTrace("     fSwellFactor: " + fSwellFactor  )
		debugTrace("     fPigmentationFactor: " + fPigmentationFactor  )

		; if (iDaysSinceLastSex >= iSexActivityThreshold ) 
		if (Libido < -10)
			; Pale if no sex for more than threshold days
			; skin
			debugTrace("     Pale - no sex for more than threshold days"  )
			debugTrace("     fBlueSkinColorMod: " + fBlueSkinColorMod  )

			If ((iSuccubus == 1) && (iDaedricInfluence>=20))
				debugTrace("  Target color: Blue Succubus - iBlueSkinColor: " + fctUtil.IntToHex(iBlueSkinColor) )
				iSkinColor = alterTintMaskTarget(colorBase =  iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iSuccubusBlueSkinColor, colorMod = 2.0 * fBlueSkinColorMod, alphaLevel = iPigmentationLevel )
			Else
				debugTrace("  Target color: Blue skin - iBlueSkinColor: " + fctUtil.IntToHex(iBlueSkinColor)  )
				iSkinColor = alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iBlueSkinColor, colorMod = fBlueSkinColorMod, alphaLevel = iPigmentationLevel)
			EndIf

		; Elseif ((fSwellFactor >= 40) || (iSexCountToday >= iSexActivityBuffer))
		elseif (Libido > 10) && (iSexCountToday >= iSexActivityBuffer)
			; Red if high sex drive
			; Aroused
			debugTrace("     Red - high sex drive"  )
			debugTrace("     fRedSkinColorMod: " + fRedSkinColorMod  )
			If ((iSuccubus == 1) && (iDaedricInfluence>=20))
				debugTrace("  Target color: Red Succubus - iRedSkinColor: " + fctUtil.IntToHex(iRedSkinColor) )
				iSkinColor = alterTintMaskTarget(colorBase =  iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iSuccubusRedSkinColor, colorMod = 2.0 * fRedSkinColorMod , alphaLevel = iPigmentationLevel)
			Else
				debugTrace("  Target color: Red skin - iRedSkinColor: " + fctUtil.IntToHex(iRedSkinColor)   )
				iSkinColor = alterTintMaskTarget(colorBase =  iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iRedSkinColor, colorMod = fRedSkinColorMod, alphaLevel = iPigmentationLevel)
			EndIf

		Else ; Healthy
			; Coverge back to default skin color
			debugTrace("  Coverge back to default skin color"  )
			debugTrace("  Target color: Origin skin color"  )
			; iSkinColor = alterTintMaskTarget(colorBase =  iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iOrigSkinColor, colorMod = 1.0/3.0, alphaLevel = iPigmentationLevel )
			alterSkinToOrigin(PlayerActor)
 
		EndIf

		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", iSkinColor)
		debugTrace("  alterColorFromHormone: iSkinColor AFTER: " + fctUtil.IntToHex(iSkinColor) )

	EndIf
endfunction

function alterColorAfterRest(Actor kActor)	
	; Deprecated - preserved for upgrade compatiblity			
	alterColorFromHormone( kActor)
endfunction

function alterColorAfterSex(Actor kActor)				
	; Deprecated - preserved for upgrade compatiblity			
	alterColorFromHormone( kActor)
endfunction

function alterSkinToOrigin(Actor kActor = None, float fSwellFactor = 0.125)		
	Actor PlayerActor = Game.GetPlayer()
	Int iPigmentationLevel = (StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormonePigmentation" ) * 255.0 / 100.0) as Int

	Int iOrigSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iDefaultSkinColor")
	Int iSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iSkinColor")

	If (StorageUtil.GetIntValue(none, "_SLH_iHormonesSleepInit")==0)
		; Mod Init safety - sleep first
		Return
	Endif
		
	debugTrace("  alterSkinToOrigin: iSkinColor BEFORE: " + fctUtil.IntToHex(iSkinColor) )

	Int iNewSkinColor = alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iOrigSkinColor, colorMod =  fSwellFactor, alphaLevel = iPigmentationLevel)	
	StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", iNewSkinColor)

	debugTrace("  alterSkinToOrigin: iSkinColor AFTER: " + fctUtil.IntToHex(iNewSkinColor) )

endfunction

function initColorConstants(Actor kActor)
	; Used to reset colors to default
 	Actor PlayerActor = Game.GetPlayer()

	int iHairColorSuccubus = setRGB(255,255,255)  
	int iHairColorBimbo = setRGB(243,236,216)  
 
	int iDefaultSkinColor =  setRGB(255,255,255) 
	int iRedSkinColor =  setRGB(155,118,100)
	int iBlueSkinColor = setRGB(215,234,245)

	StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultSkinColor", iDefaultSkinColor)  

	StorageUtil.SetIntValue(PlayerActor, "_SLH_iRedShiftColor", iRedSkinColor) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fRedShiftColorMod", 1.0)

	StorageUtil.SetIntValue(PlayerActor, "_SLH_iBlueShiftColor", iBlueSkinColor)
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBlueShiftColorMod", 1.0)

	StorageUtil.SetIntValue(PlayerActor, "_SLH_iBimboHairColor", iHairColorBimbo)
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBimboHairColorMod", 1.0)

	StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusHairColor", iHairColorSuccubus)
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSuccubusHairColorMod", 1.0)

endFunction

function initColorState(Actor kActor)
	; Used to initialize Hormones from Player color values
	; Player by default  - kActor ignored 
	Actor PlayerActor = Game.GetPlayer()
	ActorBase pLeveledActorBase = PlayerActor.GetLeveledActorBase()
	Int iOrigSkinColor = Game.GetTintMaskColor(6,0)
	Int iOrigCheeksColor = Game.GetTintMaskColor(9,0)
	Int iOrigLipsColor = Game.GetTintMaskColor(1,0)
	Int iOrigEyelinerColor = Game.GetTintMaskColor(3,0)
	Int iOrigHairColor
	ColorForm color

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseColors") == 1)
		; 
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultSkinColor", getRGBfromRGBA(iOrigSkinColor) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", getRGBfromRGBA(iOrigSkinColor) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultCheeksColor", getRGBfromRGBA(iOrigCheeksColor) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultLipsColor", getRGBfromRGBA(iOrigLipsColor) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultEyelinerColor", getRGBfromRGBA(iOrigEyelinerColor) )

	Endif

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHairColors") == 1)  && (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHair") == 1)
		color = pLeveledActorBase.GetHairColor()
		iOrigHairColor = colorFormtoRGBA (color)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultHairColor", getRGBfromRGBA(iOrigHairColor) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iHairColor", getRGBfromRGBA(iOrigHairColor) )
	Endif

endFunction

function resetColorState(Actor kActor)
	Actor PlayerActor = Game.GetPlayer()
	; Player by default  - kActor ignored

	initColorConstants(kActor)
	initColorState(kActor)

endFunction


function getColorFromSkin(Actor kActor)
	; Override color from skin - in case of external changes to this mod
	Actor PlayerActor = Game.GetPlayer()
	ActorBase pLeveledActorBase = PlayerActor.GetLeveledActorBase()
	Int iOrigSkinColor = Game.GetTintMaskColor(6,0)
	Int iOrigCheeksColor = Game.GetTintMaskColor(9,0)
	Int iOrigLipsColor = Game.GetTintMaskColor(1,0)
	Int iOrigEyelinerColor = Game.GetTintMaskColor(3,0)
	Int iOrigHairColor
	ColorForm color

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseColors") == 1)
		; 
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSkinColor", getRGBfromRGBA(iOrigSkinColor) )
		; StorageUtil.SetIntValue(PlayerActor, "_SLH_iCheeksColor", getRGBfromRGBA(iOrigCheeksColor) )
		; StorageUtil.SetIntValue(PlayerActor, "_SLH_iLipsColor", getRGBfromRGBA(iOrigLipsColor) )
		; StorageUtil.SetIntValue(PlayerActor, "_SLH_iEyelinerColor", getRGBfromRGBA(iOrigEyelinerColor) )

	Endif

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHairColors") == 1)  && (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHair") == 1)
		color = pLeveledActorBase.GetHairColor()
		iOrigHairColor = colorFormtoRGBA (color)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iHairColor", getRGBfromRGBA(iOrigHairColor) )
	Endif

endFunction

function applyColorChanges(Actor kActor)
	Actor PlayerActor = Game.GetPlayer()
	Int iSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iSkinColor")
	int iHairColor

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseColors") == 1)
		; alterColorFromHormone(PlayerActor)

		setTintMaskTarget(colorBase =  iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iSkinColor, alphaLevel = 255)

	 	If (SKSE.GetPluginVersion("NiOverride") >= 1) && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==1)
	 		debugTrace("  Applying NiOverride")
		 	NiOverride.ApplyOverrides(kActor)
	 		NiOverride.ApplyNodeOverrides(kActor)
	 	Endif

	endIf

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHairColors") == 1) && (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHair") == 1)
		Game.UpdateHairColor()
		; debugTrace("  Updating TintMaskColors")
		; Game.UpdateTintMaskColors()

		iHairColor = StorageUtil.GetIntValue(kActor, "_SLH_iHairColor") 
		If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
			; YPS Fashion override if detected
			; See - http://www.loverslab.com/topic/56627-immersive-hair-growth-and-styling-yps-devious-immersive-fashion-v5/

 			If 	(StorageUtil.GetIntValue(kActor, "_SLH_iHairColorDye") ==  1 ) 
	 			debugTrace(" - Sending dye YPS hair color event: " + 	fctUtil.IntToHex(iHairColor) )
				SendModEvent("yps-HairColorDyeEvent", StorageUtil.GetStringValue(kActor, "_SLH_sHairColorName"), iHairColor)  
			else
	 			debugTrace(" - Sending base YPS hair color event: " + 	fctUtil.IntToHex(iHairColor) )
				SendModEvent("yps-HairColorBaseEvent", StorageUtil.GetStringValue(kActor, "_SLH_sHairColorName"), iHairColor)  
			endIf

		Endif
	EndIf

	tryHormonesTats(kActor) 
endFunction


function tryHormonesTats(Actor kActor) 
	Bool bBlueMilk = false

	if (StorageUtil.GetIntValue(kActor, "_SLH_iMilkLevel")> StorageUtil.GetFloatValue( kActor , "_SLH_fLactationThreshold") ) 

		if (StorageUtil.GetIntValue(kActor, "_SLP_iChaurusQueenStage")>=3)
			; Compatibility with Parasites
	 		debug.trace(" tryHormonesTats - Blue Milk - Compatibility with Parasites" )
			bBlueMilk = True 

		elseif (StorageUtil.GetIntValue(kActor, "_SLP_toggleChaurusWorm")==1) || (StorageUtil.GetIntValue(kActor, "_SLP_toggleChaurusWormVag")==1)
			; Compatibility with Parasites
	 		debug.trace(" tryHormonesTats - Blue Milk - Compatibility with Parasites" )
			bBlueMilk = True 

		elseif (fctUtil.isPregnantByEstrusChaurus( kActor))
			; Compatibility with Estrus Chaurus pregnancy
	 		debug.trace(" tryHormonesTats - Blue Milk - Compatibility with Estrus Chaurus pregnancy" )
			bBlueMilk = True 

		elseif (StorageUtil.GetIntValue(kActor, "_SD_iEnslaved") == 1)
			; Compatibility with SD+ and Falmer enslavement
			Actor kMaster = StorageUtil.GetFormValue(kActor, "_SD_CurrentOwner") as Actor
			if (StorageUtil.GetIntValue( kMaster, "_SD_bIsSlaverFalmer") == 1)
		 		debug.trace(" tryHormonesTats - Blue Milk - Compatibility with SD+ and Falmer enslavement" )
				bBlueMilk = True 
			endif
		endif

		if (bBlueMilk)
			; debug.notification("Your milk is blue!")
			sendSlaveTatRemoveModEvent(kActor, "milkfarm","Milk Drip", bRefresh = False )
			sendSlaveTatRemoveModEvent(kActor, "hormones","Milk Drip", bRefresh = False )
			sendSlaveTatModEvent(kActor, "hormones","Blue Milk Drip", iColor = 0x99184f6b, bRefresh = True )
		else
			sendSlaveTatModEvent(kActor, "hormones","Milk Drip", bRefresh = True )
		endif
	else
		sendSlaveTatRemoveModEvent(kActor, "hormones","Milk Drip", bRefresh = True )
	endif

	if (StorageUtil.GetFloatValue(kActor, "_SLH_fHormoneLactation")>80.0)
		sendSlaveTatModEvent(kActor, "hormones","Milk Veins", iColor = 0x99184f6b, bRefresh = True )
	else
		sendSlaveTatRemoveModEvent(kActor, "hormones","Milk Veins", bRefresh = True )
	endif

endFunction

;-------------
; Requires SlaveTats Event Bridge
;-------------

; STRemoveAllSectionTattoo(Form _form, String _section, bool _ignoreLock, bool _silent): remove all tattoos from determined section (ie, the folder name on disk, like "Bimbo")

; STAddTattoo(Form _form, String _section, String _name, int _color, bool _last, bool _silent, int _glowColor, bool _gloss, bool _lock): add a tattoo with more parameters, including glow, gloss (use it to apply makeup, looks much better) and locked tattoos.

function sendSlaveTatModEvent(actor akActor, string sType, string sTatooName, int iColor = 0x99000000, bool bRefresh = False)
	; SlaveTats.simple_add_tattoo(bimbo, "Bimbo", "Tramp Stamp", last = false, silent = true)
  	int STevent = ModEvent.Create("STSimpleAddTattoo")  

  	if (STevent) 
  		debugTrace(" Applying slavetat: " + sTatooName)
  		debugTrace(" 	Applying actor: " + akActor)
        ModEvent.PushForm(STevent, akActor)      	; Form - actor
        ModEvent.PushString(STevent, sType)    		; String - type of tattoo?
        ModEvent.PushString(STevent, sTatooName)  	; String - name of tattoo
        ModEvent.PushInt(STevent, iColor)  			; Int - color
        ModEvent.PushBool(STevent, bRefresh)        ; Bool - last = false
        ModEvent.PushBool(STevent, true)         	; Bool - silent = true

        ModEvent.Send(STevent)
  	else
  		debugTrace(" Applying slavetat failed: " + sTatooName)
  		debugTrace(" Send slave tat event failed.")
	endIf
endfunction

function sendSlaveTatRemoveModEvent(actor akActor, string sType, string sTatooName, int iColor = 0x99000000, bool bRefresh = False)
	; akSlave.RemoveFromFaction( slaveFaction as Faction )
	int STevent = ModEvent.Create("STSimpleRemoveTattoo") 
	if (STevent)
  		debugTrace(" Clearing slavetat: " + sTatooName)
  		debugTrace(" 	Clearing actor: " + akActor)
	    ModEvent.PushForm(STevent, akActor)        ; Form - actor
	    ModEvent.PushString(STevent, sType)     	; String - tattoo section (the folder name)
	    ModEvent.PushString(STevent, sTatooName)    ; String - name of tattoo
	    ModEvent.PushBool(STevent, true)            ; Bool - last = false (the tattoos are only removed when last = true, use it on batches)
	    ModEvent.PushBool(STevent, true)            ; Bool - silent = true (do not show a message)
	    ModEvent.Send(STevent)
  	else
  		debugTrace(" Clearing slavetat failed: " + sTatooName)
  		debugTrace(" Send slave tat remove event failed.")
	endif
endfunction


function alterHairColor(Actor kActor, int rgbacolor, HeadPart thisHair)
	Actor kPlayer = Game.GetPlayer()
	ActorBase pActorBase = kActor.GetActorBase()
	ActorBase pLeveledActorBase = kActor.GetLeveledActorBase()

	If (StorageUtil.GetIntValue(none, "_SLH_iHormonesSleepInit")==0)
		; Mod Init safety - sleep first
		Return
	Endif

	if (StorageUtil.GetIntValue(kPlayer, "_SLH_iUseHairColors") == 1) && (StorageUtil.GetIntValue(kPlayer, "_SLH_iUseHair") == 1)

		kActor.ChangeHeadPart(thisHair)

		thisHairColor.SetColor(rgbacolor)
		pLeveledActorBase.SetHairColor(thisHairColor)
	Endif

EndFunction

function alterEyesColor(Actor kActor, int rgbacolor, HeadPart thisEyes)
 
	; Find out how to change eyes color

	If (StorageUtil.GetIntValue(none, "_SLH_iHormonesSleepInit")==0)
		; Mod Init safety - sleep first
		Return
	Endif

	kActor.ChangeHeadPart(thisEyes)

EndFunction

Int function setTintMaskTarget(int colorBase, int maskType = 6, int maskIndex = 0, int colorTarget, int alphaLevel = 255)
	; color input assumed to be RBG only
	; alpha level provided separately in parameters
	int rOffset = 0
	int gOffset = 0
	int bOffset = 0

 	; int colorBase = Game.GetTintMaskColor(maskType, maskIndex)
	int rBase = GetRed(colorBase) ; Math.LogicalAnd( Math.RightShift( colorBase, 16), 0x00FF) 
	int gBase = GetGreen(colorBase) ; Math.LogicalAnd( Math.RightShift( colorBase, 8), 0x0000FF) 
	int bBase = GetBlue(colorBase) ; Math.LogicalAnd( colorBase, 0x000000FF) 

	int rNew = GetRed(colorTarget) ; Math.LogicalAnd( Math.RightShift( colorTarget, 16), 0x00FF) 
	int gNew = GetGreen(colorTarget) ; Math.LogicalAnd( Math.RightShift( colorTarget, 8), 0x0000FF) 
	int bNew = GetBlue(colorTarget) ; Math.LogicalAnd( colorTarget, 0x000000FF) 

	; alphaLevel = 255 ; 2019-12-13 - forcing 255 alpha until a good mix of color levels is found

	debugTrace("setTintMaskTarget:  New color - A: " + alphaLevel + " - R:" + rNew + " - G:" + gNew + " - B:" + bNew  )
    alterTintMask(type = maskType, alpha = alphaLevel, red = rNew, green = gNew, blue = bNew)

    ; int color = Math.LeftShift(aNew, 24) + Math.LeftShift(rNew, 16) + Math.LeftShift(gNew, 8) + bNew
    int color = setRGB ( rNew, gNew, bNew)
    return color
EndFunction

Int function alterTintMaskTarget(int colorBase, int maskType = 6, int maskIndex = 0, int colorTarget, float colorMod = 0.5, int alphaLevel = 255)
	; color input assumed to be RBG only
	; alpha level provided separately in parameters
	int rOffset = 0
	int gOffset = 0
	int bOffset = 0

 	; int colorBase = Game.GetTintMaskColor(maskType, maskIndex)
	int rBase = GetRed(colorBase) ; Math.LogicalAnd( Math.RightShift( colorBase, 16), 0x00FF) 
	int gBase = GetGreen(colorBase) ; Math.LogicalAnd( Math.RightShift( colorBase, 8), 0x0000FF) 
	int bBase = GetBlue(colorBase) ; Math.LogicalAnd( colorBase, 0x000000FF) 

	int rTarget = GetRed(colorTarget) ; Math.LogicalAnd( Math.RightShift( colorTarget, 16), 0x00FF) 
	int gTarget = GetGreen(colorTarget) ; Math.LogicalAnd( Math.RightShift( colorTarget, 8), 0x0000FF) 
	int bTarget = GetBlue(colorTarget) ; Math.LogicalAnd( colorTarget, 0x000000FF) 

	rOffset = -1 * ((( (rBase - rTarget) as Float) * colorMod) as Int)
	gOffset = -1 * ((( (gBase - gTarget) as Float) * colorMod) as Int)
	bOffset = -1 * ((( (bBase - bTarget) as Float) * colorMod) as Int)

	debugTrace( ":::: SexLab Hormones: Alter tint mask to color target - " +  maskType )
	debugTrace("  ColorMod - " + colorMod )
	debugTrace("  Orig color - R:" + rBase + " - G:" + gBase + " - B:" + bBase  )
	debugTrace("  Offsets - R:" + rOffset + " - G:" + gOffset + " - B:" + bOffset  )
	debugTrace("  Target color - R:" + rTarget + " - G:" + gTarget + " - B:" + bTarget  )

	int rNew = fctUtil.iMin(fctUtil.iMax(rBase + rOffset, 0), 255)
	int gNew = fctUtil.iMin(fctUtil.iMax(gBase + gOffset, 0), 255)
	int bNew = fctUtil.iMin(fctUtil.iMax(bBase + bOffset, 0), 255)

	; alphaLevel = 255 ; 2019-12-13 - forcing 255 alpha until a good mix of color levels is found

	debugTrace("alterTintMaskTarget:  New color - A: " + alphaLevel + " - R:" + rNew + " - G:" + gNew + " - B:" + bNew  )
    alterTintMask(type = maskType, alpha = alphaLevel, red = rNew, green = gNew, blue = bNew)

    ; int color = Math.LeftShift(aNew, 24) + Math.LeftShift(rNew, 16) + Math.LeftShift(gNew, 8) + bNew
    int color = setRGB ( rNew, gNew, bNew)
    return color
EndFunction

function alterTintMask(int type = 6, int alpha = 0, int red = 125, int green = 90, int blue = 70, int setIndex = 0, Bool setAll = False)

	; Sets the tintMask color for the particular type and index
	; r,g,b,a: 0-255 range

	; Types
	; 0 - Frekles
	; 1 - Lips
	; 2 - Cheeks
	; 3 - Eyeliner
	; 4 - Upper Eyesocket
	; 5 - Lower Eyesocket
	; 6 - SkinTone
	; 7 - Warpaint
	; 8 - Frownlines
	; 9 - Lower Cheeks
	; 10 - Nose
	; 11 - Chin
	; 12 - Neck
	; 13 - Forehead
	; 14 - Dirt

	; int color = Math.LeftShift(alpha, 24) + Math.LeftShift(red, 16) + Math.LeftShift(green, 8) + blue
	; int color = Math.LogicalOr(Math.LogicalAnd(rgb, 0xFFFFFF), Math.LeftShift((alpha * 255) as Int, 24))
	Int color = setRGBA(alpha, red, green, blue)

	setTintMask(itype = type, irgbacolor = color, isetIndex = setIndex, bsetAll = setAll)

EndFunction

function setTintMask(int itype = 6, int irgbacolor = 0, int isetIndex = 0, Bool bsetAll = False)
  	Int slotMask
  	Actor kPlayer = Game.GetPlayer()
	; Sets the tintMask color for the particular type and index
	; r,g,b,a: 0-255 range

	If (StorageUtil.GetIntValue(none, "_SLH_iHormonesSleepInit")==0)
		; Mod Init safety - sleep first
		Return
	Endif

	if (StorageUtil.GetIntValue(kPlayer, "_SLH_iUseColors") == 1)

		; int color = Math.LeftShift(alpha, 24) + Math.LeftShift(red, 16) + Math.LeftShift(green, 8) + blue
		; int color = Math.LogicalOr(Math.LogicalAnd(rgb, 0xFFFFFF), Math.LeftShift((alpha * 255) as Int, 24))

		if (itype == 6) ; Skin
			; Function AddSkinOverrideInt(ObjectReference ref, bool isFemale, bool firstPerson, int slotMask, int key, int index, int value, bool persist) native global

			NiOverride.AddSkinOverrideInt(kPlayer as ObjectReference, fctUtil.isFemale(kPlayer), True, 0, 0, 7, irgbacolor, True)
			NiOverride.AddSkinOverrideInt(kPlayer as ObjectReference, fctUtil.isFemale(kPlayer), True, 0, 0, 8, irgbacolor, True)
			NiOverride.AddSkinOverrideInt(kPlayer as ObjectReference, fctUtil.isFemale(kPlayer), True, 0, 0, 9, irgbacolor, True)
			NiOverride.AddSkinOverrideInt(kPlayer as ObjectReference, fctUtil.isFemale(kPlayer), True, 0, 0, 10, irgbacolor, True)
			
			; 2019-12-13 - troubleshoot use of NiOverride.AddSkinOverrideInt - doesn't seem to be working
			; 				reverting back to Game.SetTintMaskColor for now.
			Game.SetTintMaskColor(irgbacolor, 6, 0)
		else

			setTintMaskColor(itype , irgbacolor , isetIndex , bsetAll )
		endif

	Endif

EndFunction

function setTintMaskColor(int itype = 6, int irgbacolor = 0, int isetIndex = 0, Bool bsetAll = False)
	Actor kPlayer = Game.GetPlayer()
 	int index_count = Game.GetNumTintsByType(itype)

	If (StorageUtil.GetIntValue(none, "_SLH_iHormonesSleepInit")==0)
		; Mod Init safety - sleep first
		Return
	Endif

	if (StorageUtil.GetIntValue(kPlayer, "_SLH_iUseColors") == 1)
	 	debugTrace("  		NumTintsByType: " + index_count  + " - type: " + itype)
	 	debugTrace("  		Layer to change: " + isetIndex + " - setAll: " + bsetAll )

	 	int index = 0
	 	while(index < index_count)
	 		if (index == isetIndex) || (bsetAll)
	 			debugTrace("  		    Layer : " + index  )
	 			debugTrace("       		Color : " + fctUtil.IntToHex(irgbacolor) )
	 			Game.SetTintMaskColor(irgbacolor, itype, index)
	 		EndIf
	 		index = index + 1
	 	EndWhile
	 Endif

EndFunction

Int function alterTintMaskRelativeRGB(int colorBase, int maskType = 6, int maskIndex = 0, int aOffset = 0, int rOffset = 0, int gOffset = 0, int bOffset = 0)
 	; int colorBase = Game.GetTintMaskColor(maskType, maskIndex)
	int aBase = GetAlpha(colorBase) ; Math.RightShift( colorBase, 24)
	int rBase = GetRed(colorBase) ; Math.LogicalAnd( Math.RightShift( colorBase, 16), 0x00FF) 
	int gBase = GetGreen(colorBase) ; Math.LogicalAnd( Math.RightShift( colorBase, 8), 0x0000FF) 
	int bBase = GetBlue(colorBase) ; Math.LogicalAnd( colorBase, 0x000000FF) 

	debugTrace( ":::: SexLab Hormones: Updating tint mask RGB - " +  maskType )
	debugTrace("  Base RGB - " + aBase + " - " + rBase + " - " + gBase + " - " + bBase  )
	debugTrace("  Offsets - " + aOffset + " - " + rOffset + " - " + gOffset + " - " + bOffset  )

	int aNew = fctUtil.iMin(fctUtil.iMax(aBase + aOffset, 0), 255)
	int rNew = fctUtil.iMin(fctUtil.iMax(rBase + rOffset, 0), 255)
	int gNew = fctUtil.iMin(fctUtil.iMax(gBase + gOffset, 0), 255)
	int bNew = fctUtil.iMin(fctUtil.iMax(bBase + bOffset, 0), 255)

	debugTrace("  New color - " + aNew + " - " + rNew + " - " + gNew + " - " + bNew  )
    alterTintMask(type = maskType, alpha = aNew, red = rNew, green = gNew, blue = bNew)

    int color = Math.LeftShift(aNew, 24) + Math.LeftShift(rNew, 16) + Math.LeftShift(gNew, 8) + bNew
    return color

EndFunction

Int function alterTintMaskRelativeHSL(int colorOrig, int colorBase, int maskType = 6, int maskIndex = 0, int aOffset = 0, float hOffset = 0.0, float sOffset = 0.0, float lOffset = 0.0)

 	; int colorOrig = iOrigSkinColor
	int aOrig = GetAlpha(colorOrig) ; Math.RightShift( colorOrig, 24)
	int rOrig = GetRed(colorOrig) ; Math.LogicalAnd( Math.RightShift( colorOrig, 16), 0x00FF) 
	int gOrig = GetGreen(colorOrig) ; Math.LogicalAnd( Math.RightShift( colorOrig, 8), 0x0000FF) 
	int bOrig = GetBlue(colorOrig) ; Math.LogicalAnd( colorOrig, 0x000000FF) 

 	; int colorBase = Game.GetTintMaskColor(maskType, maskIndex)
	int aBase = GetAlpha(colorBase) ; Math.RightShift( colorBase, 24)
	int rBase = GetRed(colorBase) ; Math.LogicalAnd( Math.RightShift( colorBase, 16), 0x00FF) 
	int gBase = GetGreen(colorBase) ; Math.LogicalAnd( Math.RightShift( colorBase, 8), 0x0000FF) 
	int bBase = GetBlue(colorBase) ; Math.LogicalAnd( colorBase, 0x000000FF) 

	float[] hslBase  = new float[3]
	float[] hslNew  = new float[3]
	float[] hslOrig  = new float[3]
	int[] rgbNew  = new int[3]

	debugTrace( ":::: SexLab Hormones: Updating tint mask HSL - " +  maskType )
	; debugTrace("  Orig RGB - " + aOrig + " - " + rOrig + " - " + gOrig + " - " + bOrig  )
	debugTrace("  Base RGB - " + aBase + " - " + rBase + " - " + gBase + " - " + bBase  )
	debugTrace("  Offsets - " + aOffset + " - " + hOffset + " - " + sOffset + " - " + lOffset  )

	hslOrig = RGBtoHSL(rOrig, gOrig, bOrig)
	hslBase = RGBtoHSL(rBase, gBase, bBase)

	; debugTrace("  Orig HSL - " + hslOrig[0] + " - " + hslOrig[1] + " - " + hslOrig[2])
	; debugTrace("  Base HSL - " + hslBase[0] + " - " + hslBase[1] + " - " + hslBase[2])

	hslNew[0] = fctUtil.fRange( hslBase[0] + hOffset, 0.0, 1.0)
	hslNew[1] = fctUtil.fRange( hslBase[1] + sOffset, 0.0, 1.0)
	hslNew[2] = fctUtil.fRange( hslBase[2] + lOffset, 0.0, 1.0)

	; Prevent skin from becoming too dark 
	hslNew[2] = fctUtil.fRange( hslNew[2], hslOrig[2]/2.0, 1.0)

	; debugTrace("  HSL - " + hslNew[0] + " - " + hslNew[1] + " - " + hslNew[2]   )

	rgbNew = HSLtoRGB(hslNew[0], hslNew[1], hslNew[2])

	; debugTrace("  RGB - " + rgbNew[0] + " - " + rgbNew[1] + " - " + rgbNew[2]   )

	int aNew = fctUtil.iMin(fctUtil.iMax(aBase + aOffset, 0), 255)
	int rNew = fctUtil.iMin(fctUtil.iMax(rgbNew[0], 0), 255)
	int gNew = fctUtil.iMin(fctUtil.iMax(rgbNew[1], 0), 255)
	int bNew = fctUtil.iMin(fctUtil.iMax(rgbNew[2], 0), 255)

	debugTrace("  New color - " + aNew + " - " + rNew + " - " + gNew + " - " + bNew  )
    alterTintMask(type = maskType, alpha = aNew, red = rNew, green = gNew, blue = bNew)

    ; int color = Math.LeftShift(aNew, 24) + Math.LeftShift(rNew, 16) + Math.LeftShift(gNew, 8) + bNew
    int color = setRGBA ( aNew, rNew, gNew, bNew)

    return color
EndFunction

Int function setRGB(Int iRed, Int iGreen, Int iBlue)
	; https://www.creationkit.com/index.php?title=ColorComponent_Script
	Int iColor
	; The value to set the alpha component to, should only be set to a value in between 0 and 255
	iColor = SetRed(iColor, iRed)
	iColor = SetGreen(iColor, iGreen)
	iColor = SetBlue(iColor, iBlue)
	Return iColor
EndFunction

Int function setRGBA(Int iAlpha, Int iRed, Int iGreen, Int iBlue)
	; https://www.creationkit.com/index.php?title=ColorComponent_Script
	Int iColor
	; The value to set the alpha component to, should only be set to a value in between 0 and 255
	iColor = SetAlpha(iColor, iAlpha)
	iColor = SetRed(iColor, iRed)
	iColor = SetGreen(iColor, iGreen)
	iColor = SetBlue(iColor, iBlue)
	Return iColor
EndFunction

Int function setAHLS(Int iAlpha, Int iHue, Int iSaturation, Int iValue)
	; https://www.creationkit.com/index.php?title=ColorComponent_Script
	Int iColor
	; The value to set the alpha component to, should only be set to a value in between 0 and 255
	iColor = SetAlpha(iColor, iAlpha)
	; The value to set the hue to, should be within the range of 0.0 to 360.0 (inclusive).
	iColor = SetHue(iColor, iHue)
	; The value to set the saturation to, with 0.0 being greyscale and 1.0 being saturated.
	iColor = SetSaturation(iColor, iSaturation)
	; The value to set value to, with 0.0 representing black and 1.0 representing white.
	iColor = SetValue(iColor, iValue)
	Return iColor
EndFunction

Int function getRGBfromRGBA(Int iRGBAColor)
	int aColor = GetAlpha(iRGBAColor) ; Math.LogicalAnd( Math.RightShift( colorBase, 24), 0x00FF) 
	int rColor = GetRed(iRGBAColor) ; Math.LogicalAnd( Math.RightShift( colorBase, 16), 0x00FF) 
	int gColor = GetGreen(iRGBAColor) ; Math.LogicalAnd( Math.RightShift( colorBase, 8), 0x0000FF) 
	int bColor = GetBlue(iRGBAColor) ; Math.LogicalAnd( colorBase, 0x000000FF)
    return setRGB ( rColor, gColor, bColor) 
endFunction

Int function colorFormtoRGBA (ColorForm color)
	int red = color.GetRed() 
	int green = color.GetGreen() 
	int blue = color.GetBlue() 
    int iColor = setRGBA(255, red, green, blue)
    return iColor

endFunction


; HSL to RGB conversion - see: http://stackoverflow.com/questions/2353211/hsl-to-rgb-color-conversion

int[] function HSLtoRGB(float H, float S, float L)

    int[] rgb   = new int[3]

    if(S == 0.0) ; achromatic
        rgb[0] = (255.0 * L ) as Int	; r
        rgb[1] = (255.0 * L ) as Int	; g
        rgb[2] = (255.0 * L ) as Int	; b
    else
        float q 
        float p

        if (L < 0.5)
        	q = L * (1.0 + S) 
        Else
       		q = L + S - L * S
    	EndIf

        p = 2.0 * L - q

        rgb[0] = (255.0 * hue2RGB(p, q, H + 1.0/3.0) ) as Int	; r
        rgb[1] = (255.0 * hue2RGB(p, q, H) ) as Int			; g
        rgb[2] = (255.0 * hue2RGB(p, q, H - 1.0/3.0) ) as Int	; b
    EndIf

    return rgb
EndFunction

float function hue2RGB(float p, float q, float t)
    if (t < 0) 
    	t = t + 1.0
    EndIf
    if (t > 1.0) 
    	t = t - 1.0
    EndIf
    if (t < 1.0/6.0) 
    	return p + (q - p) * 6.0 * t
    EndIf
    if (t < 1.0/2.0) 
    	return q
    EndIf
 	if (t < 2.0/3.0) 
    	return p + (q - p) * (2.0/3.0 - t) * 6.0
    EndIf
    return p
EndFunction


float[] function RGBtoHSL(int r, int g, int b)
    float fR = (r as float) / 255.0
    float fG = (g as float) / 255.0
    float fB = (b as float) / 255.0
    float[] hsl   = new float[3]
    float offset = 0.0

    float max = fctUtil.fMax( fctUtil.fMax(fR, fG), fB)
    float min = fctUtil.fMin( fctUtil.fMin(fR, fG), fB)

   	hsl[0] = (max + min) / 2.0 ; H
   	hsl[1] = (max + min) / 2.0 ; S
   	hsl[2] = (max + min) / 2.0 ; L

    if(max == min) ;  achromatic
        hsl[0] = 0.0
        hsl[1] = 0.0
    else
        float d = max - min

        if (hsl[2] > 0.5)
        	hsl[1] =  d / (2.0 - max - min) 
        Else
        	hsl[1] =  d / (max + min)
        endIf

        if ( max == fR)
        	if (fG < fB) 
        		offset = 6.0
        	EndIf
        	hsl[0] = (fG - fB) / d + offset
        elseIf ( max == fG)
            hsl[0] = (fB - fR) / d + 2.0
        else
            hsl[0] = (fR - fG) / d + 4.0
        EndIf
        hsl[0] = hsl[0] / 6.0;
    EndIf

    return hsl
EndFunction


Function debugTrace(string traceMsg)
	if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
		Debug.Trace("[SLH_fctColor]" + traceMsg)
	endif
endFunction
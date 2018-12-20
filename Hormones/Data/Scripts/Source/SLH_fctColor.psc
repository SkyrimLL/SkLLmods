Scriptname SLH_fctColor extends Quest  

Import Utility
Import Math
Import ColorComponent 

SLH_fctUtil Property fctUtil Auto

Int iDefaultSkinColor = -1
Int iBlueSkinColor = -1
Float fBlueSkinColorMod = 0.0
Int iRedSkinColor = -1
Float fRedSkinColorMod = 0.0
Int iSuccubusBlueSkinColor = 0
Int iSuccubusRedSkinColor = 0
Int iOrigSkinColor = 0
Int iOrigCheeksColor = 0
Int iOrigLipsColor = 0
Int iOrigEyelinerColor = 0

Int iSkinColor 			= 0
Int iCheeksColor 		= 0
Int iLipsColor 			= 0
Int iEyelinerColor 		= 0

Int iEyesIndexOrig = 0
Int iHairIndexOrig = 0
Int iHairColorOrig = 0
Int iOrigEyesColor = 0
Int iOrigHairColor = 0
Int iEyesColor = 0
Int iHairColor = 0
Int iHairColorSuccubus = 0
Int iHairColorBimbo = 0

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
	int iSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_iSuccubus") 
	int iDaedricInfluence = StorageUtil.GetIntValue(kActor, "_SLH_iDaedricInfluence") 

	Float fSwellFactor =  StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormonePigmentationMod") 
	Float fPigmentationFactor = (StorageUtil.GetFloatValue(PlayerActor, "_SLH_fHormonePigmentation") / 100.0 ) * 255.0

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseColors") == 1)
		debugTrace("  Set color from hormone"  )

		debugTrace("  fPigmentationFactor: " + (fPigmentationFactor as Int) )

		; skin
		iOrigSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iDefaultSkinColor")

		iRedSkinColor = SetAlpha((fPigmentationFactor as Int), StorageUtil.GetIntValue(PlayerActor, "_SLH_iRedShiftColor")) 
		fRedSkinColorMod = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fRedShiftColorMod") * fSwellFactor

		iBlueSkinColor = SetAlpha((fPigmentationFactor as Int), StorageUtil.GetIntValue(PlayerActor, "_SLH_iBlueShiftColor"))  
		fBlueSkinColorMod = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fBlueShiftColorMod") * fSwellFactor

		iSuccubusRedSkinColor = SetAlpha(255, StorageUtil.GetIntValue(PlayerActor, "_SLH_iRedShiftColor"))
		iSuccubusBlueSkinColor =  SetAlpha(255, StorageUtil.GetIntValue(PlayerActor, "_SLH_iBlueShiftColor"))

		if (fSwellFactor > 0) 
			; Aroused
			If ((iSuccubus == 1) && (iDaedricInfluence>=20))
				iSkinColor = alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iSuccubusRedSkinColor, colorMod = 2.0 * fRedSkinColorMod )
			Else
				iSkinColor = alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iRedSkinColor, colorMod = fRedSkinColorMod)
			EndIf

		ElseIf (fSwellFactor == 0) ; Healthy
			; Coverge back to default skin color
			iSkinColor = alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iOrigSkinColor, colorMod = 1.0/3.0 )
		Else ; Pale
			; skin

			If ((iSuccubus == 1) && (iDaedricInfluence>=20))
				iSkinColor = alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iSuccubusBlueSkinColor, colorMod = 2.0 * fBlueSkinColorMod )
			Else
				iSkinColor = alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iBlueSkinColor, colorMod = fBlueSkinColorMod)
			EndIf

		EndIf

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

	iOrigSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iDefaultSkinColor")
	iSkinColor = alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iOrigSkinColor, colorMod =  fSwellFactor)		
endfunction

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
	Int color = setARGB(alpha, red, green, blue)

	setTintMaskColor(itype = type, irgbacolor = color, isetIndex = setIndex, bsetAll = setAll)

EndFunction

function setTintMask(int type = 6, int rgbacolor = 0, int setIndex = 0, Bool setAll = False)
  	Int slotMask
  	Actor kPlayer = Game.GetPlayer()
	; Sets the tintMask color for the particular type and index
	; r,g,b,a: 0-255 range

	if (StorageUtil.GetIntValue(kPlayer, "_SLH_iUseColors") == 1)

		; int color = Math.LeftShift(alpha, 24) + Math.LeftShift(red, 16) + Math.LeftShift(green, 8) + blue
		; int color = Math.LogicalOr(Math.LogicalAnd(rgb, 0xFFFFFF), Math.LeftShift((alpha * 255) as Int, 24))

		if (type == 6) ; Skin
			; Function AddSkinOverrideInt(ObjectReference ref, bool isFemale, bool firstPerson, int slotMask, int key, int index, int value, bool persist) native global

			NiOverride.AddSkinOverrideInt(kPlayer as ObjectReference, fctUtil.isFemale(kPlayer), True, 0, 0, 7, rgbacolor, True)
			NiOverride.AddSkinOverrideInt(kPlayer as ObjectReference, fctUtil.isFemale(kPlayer), True, 0, 0, 8, rgbacolor, True)
			NiOverride.AddSkinOverrideInt(kPlayer as ObjectReference, fctUtil.isFemale(kPlayer), True, 0, 0, 9, rgbacolor, True)
			NiOverride.AddSkinOverrideInt(kPlayer as ObjectReference, fctUtil.isFemale(kPlayer), True, 0, 0, 10, rgbacolor, True)
			; Game.SetTintMaskColor(rgbacolor, 6, 0)
		else

			setTintMaskColor(itype = type, irgbacolor = rgbacolor, isetIndex = setIndex, bsetAll = setAll)
		endif

	Endif

EndFunction

function setTintMaskColor(int itype = 6, int irgbacolor = 0, int isetIndex = 0, Bool bsetAll = False)
	Actor kPlayer = Game.GetPlayer()
 	int index_count = Game.GetNumTintsByType(itype)

	if (StorageUtil.GetIntValue(kPlayer, "_SLH_iUseColors") == 1)
	 	debugTrace("  		NumTintsByType: " + index_count  + " - type: " + itype)
	 	debugTrace("  		Layer to change: " + isetIndex + " - setAll: " + bsetAll )

	 	int index = 0
	 	while(index < index_count)
	 		if (index == isetIndex) || (bsetAll)
	 			debugTrace("  		    Layer : " + index  )
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
    int color = setARGB ( aNew, rNew, gNew, bNew)

    return color
EndFunction


Int function alterTintMaskTarget(int colorBase, int maskType = 6, int maskIndex = 0, int colorTarget, float colorMod = 0.5)
	int aOffset = 0
	int rOffset = 0
	int gOffset = 0
	int bOffset = 0

 	; int colorBase = Game.GetTintMaskColor(maskType, maskIndex)
	int aBase = GetAlpha(colorBase) ; Math.RightShift( colorBase, 24)
	int rBase = GetRed(colorBase) ; Math.LogicalAnd( Math.RightShift( colorBase, 16), 0x00FF) 
	int gBase = GetGreen(colorBase) ; Math.LogicalAnd( Math.RightShift( colorBase, 8), 0x0000FF) 
	int bBase = GetBlue(colorBase) ; Math.LogicalAnd( colorBase, 0x000000FF) 

	int aTarget = GetAlpha(colorTarget) ; Math.RightShift( colorTarget, 24)
	int rTarget = GetRed(colorTarget) ; Math.LogicalAnd( Math.RightShift( colorTarget, 16), 0x00FF) 
	int gTarget = GetGreen(colorTarget) ; Math.LogicalAnd( Math.RightShift( colorTarget, 8), 0x0000FF) 
	int bTarget = GetBlue(colorTarget) ; Math.LogicalAnd( colorTarget, 0x000000FF) 

	aOffset = -1 * ((( (aBase - aTarget) as Float) * colorMod) as Int)
	rOffset = -1 * ((( (rBase - rTarget) as Float) * colorMod) as Int)
	gOffset = -1 * ((( (gBase - gTarget) as Float) * colorMod) as Int)
	bOffset = -1 * ((( (bBase - bTarget) as Float) * colorMod) as Int)

	debugTrace( ":::: SexLab Hormones: Alter tint mask to color target - " +  maskType )
	debugTrace("  ColorMod - " + colorMod )
	debugTrace("  Orig color - " + aBase + " - " + rBase + " - " + gBase + " - " + bBase  )
	debugTrace("  Offsets - " + aOffset + " - " + rOffset + " - " + gOffset + " - " + bOffset  )
	debugTrace("  Target color - " + aTarget + " - " + rTarget + " - " + gTarget + " - " + bTarget  )

	int aNew = fctUtil.iMin(fctUtil.iMax(aBase + aOffset, 0), 255)
	int rNew = fctUtil.iMin(fctUtil.iMax(rBase + rOffset, 0), 255)
	int gNew = fctUtil.iMin(fctUtil.iMax(gBase + gOffset, 0), 255)
	int bNew = fctUtil.iMin(fctUtil.iMax(bBase + bOffset, 0), 255)

	debugTrace("  New color - " + aNew + " - " + rNew + " - " + gNew + " - " + bNew  )
    alterTintMask(type = maskType, alpha = aNew, red = rNew, green = gNew, blue = bNew)

    ; int color = Math.LeftShift(aNew, 24) + Math.LeftShift(rNew, 16) + Math.LeftShift(gNew, 8) + bNew
    int color = setARGB ( aNew, rNew, gNew, bNew)
    return color
EndFunction

Int function alterHairColor(Actor kActor, int rgbacolor, HeadPart thisHair)
	Actor kPlayer = Game.GetPlayer()
	ActorBase pActorBase = kActor.GetActorBase()
	ActorBase pLeveledActorBase = kActor.GetLeveledActorBase()

	if (StorageUtil.GetIntValue(kPlayer, "_SLH_iUseHairColors") == 1)
		kActor.ChangeHeadPart(thisHair)

		thisHairColor.SetColor(rgbacolor)
		pLeveledActorBase.SetHairColor(thisHairColor)
	Endif

EndFunction

Int function alterEyesColor(Actor kActor, int rgbacolor, HeadPart thisEyes)
 
	; Find out how to change eyes color

	kActor.ChangeHeadPart(thisEyes)

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

Int function setARGB(Int iAlpha, Int iRed, Int iGreen, Int iBlue)
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

Int function colorFormtoRGBA (ColorForm color)
	int red = color.GetRed() 
	int green = color.GetGreen() 
	int blue = color.GetBlue() 
    int iColor = setARGB(255, red, green, blue)
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

; STRemoveAllSectionTattoo(Form _form, String _section, bool _ignoreLock, bool _silent): remove all tattoos from determined section (ie, the folder name on disk, like "Bimbo")

; STAddTattoo(Form _form, String _section, String _name, int _color, bool _last, bool _silent, int _glowColor, bool _gloss, bool _lock): add a tattoo with more parameters, including glow, gloss (use it to apply makeup, looks much better) and locked tattoos.

function sendSlaveTatModEvent(actor akActor, string sType, string sTatooName, int iColor = 0x99000000, bool bRefresh = False)
	; SlaveTats.simple_add_tattoo(bimbo, "Bimbo", "Tramp Stamp", last = false, silent = true)
  	int STevent = ModEvent.Create("STSimpleAddTattoo")  

  	if (STevent) 
        ModEvent.PushForm(STevent, akActor)      	; Form - actor
        ModEvent.PushString(STevent, sType)    	; String - type of tattoo?
        ModEvent.PushString(STevent, sTatooName)  	; String - name of tattoo
        ModEvent.PushInt(STevent, iColor)  			; Int - color
        ModEvent.PushBool(STevent, bRefresh)        	; Bool - last = false
        ModEvent.PushBool(STevent, true)         	; Bool - silent = true

        ModEvent.Send(STevent)
  	else
  		debugTrace(" SLH_fctColor: Send slave tat event failed.")
	endIf
endfunction

function initColorConstants(Actor kActor)
 	Actor PlayerActor = Game.GetPlayer()

	iHairColorSuccubus = setRGB(255,255,255)  
	iHairColorBimbo = setRGB(243,236,216)  
 
	iDefaultSkinColor =  setRGB(255,255,255) 
	iRedSkinColor =  setRGB(155,118,100)
	iBlueSkinColor =setRGB(215,234,245)

	; StorageUtil.SetIntValue(PlayerActor, "_SLH_iUseColors", 1)  ; GV_useColors.GetValue()  as Int
	; StorageUtil.SetIntValue(PlayerActor, "_SLH_iUseHairColors", 1) ; GV_useHairColors.GetValue()  as Int

	; catch upgrade path
	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iDefaultSkinColor") == -1)  
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iRedShiftColor", -1) 
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBlueShiftColor", -1)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBimboHairColor", -1)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusHairColor", -1)
	Endif

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iDefaultSkinColor") == -1)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultSkinColor", iDefaultSkinColor)  
	Endif
	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iRedShiftColor") == -1)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iRedShiftColor", iRedSkinColor) 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fRedShiftColorMod", 1.0)
	Endif
	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iBlueShiftColor") == -1)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBlueShiftColor", iBlueSkinColor)
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBlueShiftColorMod", 1.0)
	Endif
	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimboHairColor") == -1)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBimboHairColor", iHairColorBimbo)
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBimboHairColorMod", 1.0)
	Endif
	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubusHairColor") == -1)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusHairColor", iHairColorSuccubus)
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSuccubusHairColorMod", 1.0)
	Endif


	iRedSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iRedShiftColor")
	iBlueSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iBlueShiftColor")
	iSuccubusRedSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iRedShiftColor")
	iSuccubusBlueSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iBlueShiftColor")

endFunction

function initColorState(Actor kActor)
	Actor PlayerActor = Game.GetPlayer()
	; Player by default  - kActor ignored 
	ActorBase pLeveledActorBase = PlayerActor.GetLeveledActorBase()
	ColorForm color

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseColors") == 1)
		; iOrigSkinColor = Game.GetTintMaskColor(6,0)
		iOrigSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iDefaultSkinColor")
		iSkinColor = iOrigSkinColor
		iOrigCheeksColor = Game.GetTintMaskColor(9,0)
		iCheeksColor = iOrigCheeksColor
		iOrigLipsColor = Game.GetTintMaskColor(1,0)
		iLipsColor = iOrigLipsColor
		iOrigEyelinerColor = Game.GetTintMaskColor(3,0)
		iEyelinerColor = iOrigEyelinerColor
	Endif

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHairColors") == 1)
		color = pLeveledActorBase.GetHairColor()
		iOrigHairColor = colorFormtoRGBA (color)
		iHairColor = iOrigHairColor
	Endif

	setColorState(kActor)

endFunction

function setColorStateDefault(Actor kActor)
	Actor PlayerActor = Game.GetPlayer()
	; Player by default  - kActor ignored
	ActorBase pLeveledActorBase = PlayerActor.GetLeveledActorBase()
	ColorForm color

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseColors") == 1)
		; iOrigSkinColor = Game.GetTintMaskColor(6,0)
		iOrigSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iDefaultSkinColor")
		iSkinColor = iOrigSkinColor
		iOrigCheeksColor = Game.GetTintMaskColor(9,0)
		iCheeksColor = iOrigCheeksColor
		iOrigLipsColor = Game.GetTintMaskColor(1,0)
		iLipsColor = iOrigLipsColor
		iOrigEyelinerColor = Game.GetTintMaskColor(3,0)
		iEyelinerColor = iOrigEyelinerColor
	endIf

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHairColors") == 1)
		color = pLeveledActorBase.GetHairColor()
		iOrigHairColor = colorFormtoRGBA (color)
		iHairColor = iOrigHairColor
	endIf

	setColorState(kActor)

endFunction

function resetColorState(Actor kActor)
	Actor PlayerActor = Game.GetPlayer()
	; Player by default  - kActor ignored

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseColors") == 1)
		; iOrigSkinColor = Game.GetTintMaskColor(6,0)
		iOrigSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iDefaultSkinColor")
		iSkinColor = iOrigSkinColor
		; iOrigCheeksColor = Game.GetTintMaskColor(9,0)
		iCheeksColor = iOrigCheeksColor
		; iOrigLipsColor = Game.GetTintMaskColor(1,0)
		iLipsColor = iOrigLipsColor
		; iOrigEyelinerColor = Game.GetTintMaskColor(3,0)
		iEyelinerColor = iOrigEyelinerColor
	Endif

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHairColors") == 1)
		iHairColor = iOrigHairColor

		iHairColorSuccubus = Math.LeftShift(255, 16) + Math.LeftShift(255, 8) + 255
		iHairColorBimbo = Math.LeftShift(243, 16) + Math.LeftShift(236, 8) + 216
	 
		iDefaultSkinColor =  Math.LeftShift(255, 16) + Math.LeftShift(255, 8) + 255
		iRedSkinColor =  Math.LeftShift(200, 16) + Math.LeftShift(0, 8) + 0
		iBlueSkinColor = Math.LeftShift(50, 16) + Math.LeftShift(0, 8) + 255

		; StorageUtil.SetIntValue(PlayerActor, "_SLH_iUseColors", 1)  ; GV_useColors.GetValue()  as Int
		; StorageUtil.SetIntValue(PlayerActor, "_SLH_iUseHairColors", 1) ; GV_useHairColors.GetValue()  as Int

		; catch upgrade path
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultSkinColor", iDefaultSkinColor)  
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iRedShiftColor", iRedSkinColor) 
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBlueShiftColor", iBlueSkinColor)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iBimboHairColor", iHairColorBimbo)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iSuccubusHairColor", iHairColorSuccubus)
	Endif


	setColorState(kActor)

endFunction


function setColorState(Actor kActor)
	Actor PlayerActor = Game.GetPlayer()
	debugTrace("  Writing color state to storage")

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseColors") == 1)
		iOrigSkinColor = StorageUtil.GetIntValue(PlayerActor, "_SLH_iDefaultSkinColor")
		StorageUtil.SetIntValue(kActor, "_SLH_iOrigSkinColor", iOrigSkinColor) 
		StorageUtil.SetIntValue(kActor, "_SLH_iOrigCheeksColor", iOrigCheeksColor) 
		StorageUtil.SetIntValue(kActor, "_SLH_iOrigLipsColor", iOrigLipsColor) 
		StorageUtil.SetIntValue(kActor, "_SLH_iOrigEyelinerColor", iOrigEyelinerColor) 
		StorageUtil.SetIntValue(kActor, "_SLH_iOrigEyesColor", iOrigEyesColor) 
		StorageUtil.SetIntValue(kActor, "_SLH_iSkinColor", iSkinColor) 
		StorageUtil.SetIntValue(kActor, "_SLH_iCheeksColor", iCheeksColor) 
		StorageUtil.SetIntValue(kActor, "_SLH_iLipsColor", iLipsColor) 
		StorageUtil.SetIntValue(kActor, "_SLH_iEyelinerColor", iEyelinerColor) 
		StorageUtil.SetIntValue(kActor, "_SLH_iEyesColor", iEyesColor) 
	endIf

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHairColors") == 1)
		StorageUtil.SetIntValue(kActor, "_SLH_iOrigHairColor", iOrigHairColor) 
		StorageUtil.SetIntValue(kActor, "_SLH_iHairColor", iHairColor) 
	EndIf

endFunction


function getColorState(Actor kActor)
	Actor PlayerActor = Game.GetPlayer()
	debugTrace("  Reading color state from storage")

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseColors") == 1)
		iOrigSkinColor = StorageUtil.GetIntValue(kActor, "_SLH_iOrigSkinColor") 
		iOrigCheeksColor = StorageUtil.GetIntValue(kActor, "_SLH_iOrigCheeksColor") 
		iOrigLipsColor = StorageUtil.GetIntValue(kActor, "_SLH_iOrigLipsColor") 
		iOrigEyelinerColor = StorageUtil.GetIntValue(kActor, "_SLH_iOrigEyelinerColor") 
		iOrigEyesColor = StorageUtil.GetIntValue(kActor, "_SLH_iOrigEyesColor") 
		
		iSkinColor = StorageUtil.GetIntValue(kActor, "_SLH_iSkinColor") 
		iCheeksColor = StorageUtil.GetIntValue(kActor, "_SLH_iCheeksColor") 
		iLipsColor = StorageUtil.GetIntValue(kActor, "_SLH_iLipsColor") 
		iEyelinerColor = StorageUtil.GetIntValue(kActor, "_SLH_iEyelinerColor") 
		iEyesColor = StorageUtil.GetIntValue(kActor, "_SLH_iEyesColor") 
	Endif

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHairColors") == 1)
		iOrigHairColor = StorageUtil.GetIntValue(kActor, "_SLH_iOrigHairColor") 
		iHairColor = StorageUtil.GetIntValue(kActor, "_SLH_iHairColor") 
	Endif


endFunction

function refreshColors(Actor kActor)
	Actor PlayerActor = Game.GetPlayer()
	ActorBase pActorBase = kActor.GetActorBase()
	ActorBase pLeveledActorBase = kActor.GetLeveledActorBase()
 	ColorForm color


 	debugTrace(" Hair Color in storage: " + 	StorageUtil.GetIntValue(kActor, "_SLH_iHairColor") )
 	debugTrace(" - Original Hair Color in storage: " + 	StorageUtil.GetIntValue(kActor, "_SLH_iOrigHairColor") )
 	debugTrace(" - Current Hair Color: " + 	colorFormtoRGBA (pLeveledActorBase.GetHairColor()))

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseColors") == 1)
		getColorState(kActor)

		If (iSkinColor == 0)
			iSkinColor = iOrigSkinColor ; Game.GetTintMaskColor(6,0)
		EndIf
			setTintMask(6,iSkinColor)

		If (iCheeksColor == 0)
			iCheeksColor = iOrigCheeksColor ; Game.GetTintMaskColor(9,0)
		EndIf
		;	setTintMask(9,iCheeksColor)

		If (iLipsColor == 0)
			iLipsColor = iOrigLipsColor ; Game.GetTintMaskColor(1,0)
		EndIf
		;	setTintMask(1,iLipsColor)
 
		If (iEyelinerColor  == 0)
			iEyelinerColor = iOrigEyelinerColor ; Game.GetTintMaskColor(3,0)
		EndIf
		;	setTintMask(3,iEyelinerColor)
	Endif


	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHairColors") == 1)
		if (iHairColor == 0)
			; thisHairColor =  pLeveledActorBase.GetHairColor()
			iHairColor = iOrigHairColor ; colorFormtoRGBA (thisHairColor)
		endIf

		If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
			; YPS Fashion override if detected
			; See - http://www.loverslab.com/topic/56627-immersive-hair-growth-and-styling-yps-devious-immersive-fashion-v5/

 			If 	(StorageUtil.GetIntValue(kActor, "_SLH_iHairColorDye") ==  1 ) 
	 			debugTrace(" - Sending dye YPS hair color event: " + 	iHairColor)
				SendModEvent("yps-HairColorDyeEvent", StorageUtil.GetStringValue(kActor, "_SLH_sHairColorName"), iHairColor)  
			else
	 			debugTrace(" - Sending base YPS hair color event: " + 	iHairColor)
				SendModEvent("yps-HairColorBaseEvent", StorageUtil.GetStringValue(kActor, "_SLH_sHairColorName"), iHairColor)  
			endIf
		else 			
			thisHairColor.SetColor(iHairColor)
			pLeveledActorBase.SetHairColor(thisHairColor)
			iHairColor = colorFormtoRGBA (thisHairColor)
		EndIf
	endif

	setColorState( kActor)


endFunction

function getColorFromSkin(Actor kActor)
	Actor PlayerActor = Game.GetPlayer()
	ActorBase pLeveledActorBase = Game.GetPlayer().GetLeveledActorBase()
	ColorForm color

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseColors") == 1)
		iSkinColor = Game.GetTintMaskColor(6,0)
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iDefaultSkinColor", iSkinColor)
		; setTintMask(6,iSkinColor)

		iCheeksColor = Game.GetTintMaskColor(9,0)
		; setTintMask(9,iCheeksColor)

		iLipsColor = Game.GetTintMaskColor(1,0)
		; setTintMask(1,iLipsColor)

		iEyelinerColor = Game.GetTintMaskColor(3,0)
		; setTintMask(3,iEyelinerColor)
	endIf

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHairColors") == 1)
		color = pLeveledActorBase.GetHairColor()
		iHairColor = colorFormtoRGBA (color)

	EndIf
	
	setColorState( kActor)

endFunction

function applyColorChanges(Actor kActor)
	Actor PlayerActor = Game.GetPlayer()
	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseColors") == 1)
	 	If (SKSE.GetPluginVersion("NiOverride") >= 1) && (StorageUtil.GetIntValue(none, "_SLH_NiNodeOverrideON")==1)
	 		debugTrace("  Applying NiOverride")
		 	NiOverride.ApplyOverrides(kActor)
	 		NiOverride.ApplyNodeOverrides(kActor)
	 	Endif

	 	; Deprecated? Trying NiO functions as alternative for Tint Masks
	 	;	- Issues with tint Mask colors 'bleeding' into other areas (skin color -> hair)
	endIf

	if (StorageUtil.GetIntValue(PlayerActor, "_SLH_iUseHairColors") == 1)
		Game.UpdateHairColor()
		; debugTrace("  Updating TintMaskColors")
		; Game.UpdateTintMaskColors()

		iHairColor = StorageUtil.GetIntValue(kActor, "_SLH_iHairColor") 
		If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
			; YPS Fashion override if detected
			; See - http://www.loverslab.com/topic/56627-immersive-hair-growth-and-styling-yps-devious-immersive-fashion-v5/
			; SendModEvent("yps-OnHaircutEvent", "", 1) ; change hair color not yet implemented 
		Endif
	EndIf
endFunction

Function debugTrace(string traceMsg)
	if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
		Debug.Trace("[SLH_fctColor]" + traceMsg)
	endif
endFunction
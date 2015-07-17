Scriptname SLH_fctColor extends Quest  

Import Utility
Import Math

SLH_fctUtil Property fctUtil Auto

Int iBlueSkinColor = 0
Int iRedSkinColor = 0
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

GlobalVariable      Property GV_useColors 				Auto
GlobalVariable      Property GV_redShiftColor  			Auto
GlobalVariable      Property GV_redShiftColorMod 		Auto
GlobalVariable      Property GV_blueShiftColor 			Auto
GlobalVariable      Property GV_blueShiftColorMod 		Auto

function alterColorsAfterRest(Actor kActor, float fSwellFactor)				
	int iSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_iSuccubus") 
	int iDaedricInfluence = StorageUtil.GetIntValue(kActor, "_SLH_iDaedricInfluence") 

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

	Float fColorOffset = ( fSwellFactor * 0.2 / 100.0 ) ; max 0.2 increments
	Int rgbColorOffset = ( (fSwellFactor as Int) * 10 / 100 ) ; max 10 increments
	debugTrace("[SLH]  fColorOffset: " + fColorOffset )
	debugTrace("[SLH]  rgbColorOffset: " + rgbColorOffset )

	; skin
	; alterTintMask(type = 6, alpha = (255.0 * colorFactor) as Int, red = 236, green =194, blue = 184)
	iRedSkinColor = Math.LeftShift(128, 24) + (GV_redShiftColor.GetValue() as Int)
	iBlueSkinColor = Math.LeftShift(128, 24) + (GV_blueShiftColor.GetValue() as Int)
	iSuccubusRedSkinColor = Math.LeftShift(255, 24) + (GV_redShiftColor.GetValue() as Int)
	iSuccubusBlueSkinColor = Math.LeftShift(255, 24) + (GV_blueShiftColor.GetValue() as Int)

	If ((iSuccubus == 1)  && (iDaedricInfluence>=10))
		fColorOffset = fColorOffset * 5.0
		rgbColorOffset = rgbColorOffset * 2
	EndIf

	if (fSwellFactor > 0) ; Aroused
		; skin
		; alterTintMask(type = 6, alpha = (255.0 * colorFactor) as Int, red = 236, green =194, blue = 184)

		; iSkinColor = alterTintMaskRelativeHSL(colorOrig = iOrigSkinColor, colorBase = iSkinColor, maskType = 6, maskIndex = 0, aOffset = rgbColorOffset, hOffset = 0.0, sOffset = 0.0, lOffset = -1.0 * fColorOffset  )
		iSkinColor = alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iOrigSkinColor, colorMod = 1.0/3.0 )

		If (fctUtil.isFemale(kActor))
			; SkinColor only for now - issues with coloring of tattoos and other layers

			; cheeks
			; iCheeksColor = alterTintMaskRelativeRGB(colorBase = iCheeksColor, maskType = 9, maskIndex = 0, aOffset = rgbColorOffset, rOffset = rgbColorOffset, gOffset = 0, bOffset = 0)

			; lips
			; iLipsColor = alterTintMaskRelativeRGB(colorBase = iLipsColor, maskType = 1, maskIndex = 0, aOffset = rgbColorOffset, rOffset = rgbColorOffset * 2, gOffset = 0, bOffset = 0)

			; Eyeliner 
			; iEyelinerColor = alterTintMaskRelativeRGB(colorBase = iEyelinerColor, maskType = 3, maskIndex = 0, aOffset = rgbColorOffset, rOffset = -5, gOffset = -5, bOffset = -5)
		EndIf

	ElseIf (fSwellFactor == 0) ; Healthy
		; Coverge back to default skin color
		iSkinColor = alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iOrigSkinColor, colorMod = 1.0/3.0 )
	Else ; Pale
		; skin
		; alterTintMask(type = 6, alpha = (-1.0 * 255.0 * colorFactor) as Int, red = 220, green =229, blue = 255)
		; alterTintMaskRelativeHSL(maskType = 6, maskIndex = 0, aOffset = colorOffset as Int, hOffset = 0.0, sOffset = 0.0, lOffset = colorOffset * 0.05 )

		; Coverge back to default skin color
		If ((iSuccubus == 1) && (iDaedricInfluence>=20))
			iSkinColor = alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iSuccubusBlueSkinColor, colorMod = 1.0/4.0 * GV_redShiftColorMod.GetValue() )
		Else
			iSkinColor = alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iBlueSkinColor, colorMod = 1.0/8.0  * GV_redShiftColorMod.GetValue())
		EndIf

		iSkinColor = alterTintMaskRelativeHSL(colorOrig = iOrigSkinColor, colorBase = iSkinColor, maskType = 6, maskIndex = 0, aOffset = rgbColorOffset, hOffset = 0.0, sOffset = 0.0, lOffset = fColorOffset )

		If (fctUtil.isFemale(kActor))
			; cheeks
			; iCheeksColor = alterTintMaskRelativeRGB(colorBase = iCheeksColor, maskType = 9, maskIndex = 0, aOffset = rgbColorOffset, rOffset = 0, gOffset = 0, bOffset = rgbColorOffset)

			; lips
			; iLipsColor = alterTintMaskRelativeRGB(colorBase = iLipsColor, maskType = 1, maskIndex = 0, aOffset = rgbColorOffset, rOffset = 0, gOffset = 0, bOffset = rgbColorOffset  )

			; Eyeliner 
			; iEyelinerColor = alterTintMaskRelativeRGB(colorBase = iEyelinerColor, maskType = 3, maskIndex = 0, aOffset = rgbColorOffset, rOffset = 5, gOffset = 0, bOffset = 0)
		EndIf
	EndIf

endfunction

function alterColorsAfterSex(Actor kActor, float fSwellFactor)				
	int iSuccubus = StorageUtil.GetIntValue(kActor, "_SLH_iSuccubus") 
	int iDaedricInfluence = StorageUtil.GetIntValue(kActor, "_SLH_iDaedricInfluence") 

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


	Float fColorOffset = ( fSwellFactor * 0.4 / 100.0 ) ; max 0.2 increments
	Int rgbColorOffset = ( (fSwellFactor as Int) * 20 / 100 ) ; max 10 increments
	debugTrace("[SLH]  fColorOffset: " + fColorOffset )
	debugTrace("[SLH]  rgbColorOffset: " + rgbColorOffset )

	; skin
	; alterTintMask(type = 6, alpha = (255.0 * colorFactor) as Int, red = 236, green =194, blue = 184)

	iRedSkinColor = Math.LeftShift(128, 24) + (GV_redShiftColor.GetValue() as Int)
	iBlueSkinColor = Math.LeftShift(128, 24) + (GV_blueShiftColor.GetValue() as Int)
	iSuccubusRedSkinColor = Math.LeftShift(255, 24) + (GV_redShiftColor.GetValue() as Int)
	iSuccubusBlueSkinColor = Math.LeftShift(255, 24) + (GV_blueShiftColor.GetValue() as Int)

	If ((iSuccubus == 1) && (iDaedricInfluence>=10))
		fColorOffset = fColorOffset * 2.0
		rgbColorOffset = rgbColorOffset * 2
	EndIf

	
	; Coverge back to default skin color
	If ((iSuccubus == 1) && (iDaedricInfluence>=20))
		iSkinColor = alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iSuccubusRedSkinColor, colorMod = 1.0/4.0 * GV_redShiftColorMod.GetValue() )
	Else
		iSkinColor = alterTintMaskTarget(colorBase = iSkinColor, maskType = 6, maskIndex = 0, colorTarget = iRedSkinColor, colorMod = 1.0/8.0 * GV_redShiftColorMod.GetValue() )
	EndIf

	iSkinColor = alterTintMaskRelativeHSL(colorOrig = iOrigSkinColor, colorBase = iSkinColor, maskType = 6, maskIndex = 0, aOffset = rgbColorOffset, hOffset = 0.0, sOffset = 0.0, lOffset = -1.0 * fColorOffset  )

	If (fctUtil.isFemale(kActor))
		; cheeks
		; iCheeksColor = alterTintMaskRelativeRGB(colorBase = iCheeksColor, maskType = 9, maskIndex = 0, aOffset = rgbColorOffset, rOffset = rgbColorOffset, gOffset = 0, bOffset = 0)

		; lips
		; iLipsColor = alterTintMaskRelativeRGB(colorBase = iLipsColor, maskType = 1, maskIndex = 0, aOffset = rgbColorOffset, rOffset = rgbColorOffset * 2, gOffset = 0, bOffset = 0)

		; Eyeliner 
		; iEyelinerColor = alterTintMaskRelativeRGB(colorBase = iEyelinerColor, maskType = 3, maskIndex = 0, aOffset = rgbColorOffset, rOffset = -5, gOffset = -5, bOffset = -5)
	EndIf

endfunction

function alterSkinToOrigin(Actor kActor = None, float fSwellFactor = 0.125)		

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

	int color = Math.LeftShift(alpha, 24) + Math.LeftShift(red, 16) + Math.LeftShift(green, 8) + blue
	; int color = Math.LogicalOr(Math.LogicalAnd(rgb, 0xFFFFFF), Math.LeftShift((alpha * 255) as Int, 24))

	setTintMaskColor(itype = type, irgbacolor = color, isetIndex = setIndex, bsetAll = setAll)

EndFunction

function setTintMask(int type = 6, int rgbacolor = 0, int setIndex = 0, Bool setAll = False)
 
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
	setTintMaskColor(itype = type, irgbacolor = rgbacolor, isetIndex = setIndex, bsetAll = setAll)

EndFunction

function setTintMaskColor(int itype = 6, int irgbacolor = 0, int isetIndex = 0, Bool bsetAll = False)
 	int index_count = Game.GetNumTintsByType(itype)

 	debugTrace("[SLH]  		NumTintsByType: " + index_count  + " - type: " + itype)
 	debugTrace("[SLH]  		Layer to change: " + isetIndex + " - setAll: " + bsetAll )

 	int index = 0
 	while(index < index_count)
 		if (index == isetIndex) || (bsetAll)
 			debugTrace("[SLH]  		    Layer : " + index  )
 			Game.SetTintMaskColor(irgbacolor, itype, index)
 		EndIf
 		index = index + 1
 	EndWhile

EndFunction

Int function alterHairColor(Actor kActor, int rgbacolor, HeadPart thisHair)
	ActorBase pActorBase = kActor.GetActorBase()
	ActorBase pLeveledActorBase = kActor.GetLeveledActorBase()
	ColorForm thisHairColor 

	kActor.ChangeHeadPart(thisHair)

	thisHairColor.SetColor(rgbacolor)
	pLeveledActorBase.SetHairColor(thisHairColor)

EndFunction

Int function alterEyesColor(Actor kActor, int rgbacolor, HeadPart thisEyes)
 
	; Find out how to change eyes color

	kActor.ChangeHeadPart(thisEyes)

EndFunction

Int function alterHeight(Actor kActor, float fHeight) 
	ObjectReference kActorREF = kActor as ObjectReference

	kActorREF.SetScale(fHeight)
EndFunction

Int function alterTintMaskRelativeRGB(int colorBase, int maskType = 6, int maskIndex = 0, int aOffset = 0, int rOffset = 0, int gOffset = 0, int bOffset = 0)
 	; int colorBase = Game.GetTintMaskColor(maskType, maskIndex)
	int aBase = Math.RightShift( colorBase, 24)
	int rBase = Math.LogicalAnd( Math.RightShift( colorBase, 16), 0x00FF) 
	int gBase = Math.LogicalAnd( Math.RightShift( colorBase, 8), 0x0000FF) 
	int bBase = Math.LogicalAnd( colorBase, 0x000000FF) 

	debugTrace( ":::: SexLab Hormones: Updating tint mask RGB - " +  maskType )
	debugTrace("[SLH]  Base RGB - " + aBase + " - " + rBase + " - " + gBase + " - " + bBase  )
	debugTrace("[SLH]  Offsets - " + aOffset + " - " + rOffset + " - " + gOffset + " - " + bOffset  )

	int aNew = fctUtil.iMin(fctUtil.iMax(aBase + aOffset, 0), 255)
	int rNew = fctUtil.iMin(fctUtil.iMax(rBase + rOffset, 0), 255)
	int gNew = fctUtil.iMin(fctUtil.iMax(gBase + gOffset, 0), 255)
	int bNew = fctUtil.iMin(fctUtil.iMax(bBase + bOffset, 0), 255)

	debugTrace("[SLH]  New color - " + aNew + " - " + rNew + " - " + gNew + " - " + bNew  )
    alterTintMask(type = maskType, alpha = aNew, red = rNew, green = gNew, blue = bNew)

    int color = Math.LeftShift(aNew, 24) + Math.LeftShift(rNew, 16) + Math.LeftShift(gNew, 8) + bNew
    return color

EndFunction

Int function alterTintMaskRelativeHSL(int colorOrig, int colorBase, int maskType = 6, int maskIndex = 0, int aOffset = 0, float hOffset = 0.0, float sOffset = 0.0, float lOffset = 0.0)

 	; int colorOrig = iOrigSkinColor
	int aOrig = Math.RightShift( colorOrig, 24)
	int rOrig = Math.LogicalAnd( Math.RightShift( colorOrig, 16), 0x00FF) 
	int gOrig = Math.LogicalAnd( Math.RightShift( colorOrig, 8), 0x0000FF) 
	int bOrig = Math.LogicalAnd( colorOrig, 0x000000FF) 

 	; int colorBase = Game.GetTintMaskColor(maskType, maskIndex)
	int aBase = Math.RightShift( colorBase, 24)
	int rBase = Math.LogicalAnd( Math.RightShift( colorBase, 16), 0x00FF) 
	int gBase = Math.LogicalAnd( Math.RightShift( colorBase, 8), 0x0000FF) 
	int bBase = Math.LogicalAnd( colorBase, 0x000000FF) 

	float[] hslBase  = new float[3]
	float[] hslNew  = new float[3]
	float[] hslOrig  = new float[3]
	int[] rgbNew  = new int[3]

	debugTrace( ":::: SexLab Hormones: Updating tint mask HSL - " +  maskType )
	; debugTrace("[SLH]  Orig RGB - " + aOrig + " - " + rOrig + " - " + gOrig + " - " + bOrig  )
	debugTrace("[SLH]  Base RGB - " + aBase + " - " + rBase + " - " + gBase + " - " + bBase  )
	debugTrace("[SLH]  Offsets - " + aOffset + " - " + hOffset + " - " + sOffset + " - " + lOffset  )

	hslOrig = RGBtoHSL(rOrig, gOrig, bOrig)
	hslBase = RGBtoHSL(rBase, gBase, bBase)

	; debugTrace("[SLH]  Orig HSL - " + hslOrig[0] + " - " + hslOrig[1] + " - " + hslOrig[2])
	; debugTrace("[SLH]  Base HSL - " + hslBase[0] + " - " + hslBase[1] + " - " + hslBase[2])

	hslNew[0] = fctUtil.fRange( hslBase[0] + hOffset, 0.0, 1.0)
	hslNew[1] = fctUtil.fRange( hslBase[1] + sOffset, 0.0, 1.0)
	hslNew[2] = fctUtil.fRange( hslBase[2] + lOffset, 0.0, 1.0)

	; Prevent skin from becoming too dark 
	hslNew[2] = fctUtil.fRange( hslNew[2], hslOrig[2]/2.0, 1.0)

	; debugTrace("[SLH]  HSL - " + hslNew[0] + " - " + hslNew[1] + " - " + hslNew[2]   )



	rgbNew = HSLtoRGB(hslNew[0], hslNew[1], hslNew[2])

	; debugTrace("[SLH]  RGB - " + rgbNew[0] + " - " + rgbNew[1] + " - " + rgbNew[2]   )

	int aNew = fctUtil.iMin(fctUtil.iMax(aBase + aOffset, 0), 255)
	int rNew = fctUtil.iMin(fctUtil.iMax(rgbNew[0], 0), 255)
	int gNew = fctUtil.iMin(fctUtil.iMax(rgbNew[1], 0), 255)
	int bNew = fctUtil.iMin(fctUtil.iMax(rgbNew[2], 0), 255)

	debugTrace("[SLH]  New color - " + aNew + " - " + rNew + " - " + gNew + " - " + bNew  )
    alterTintMask(type = maskType, alpha = aNew, red = rNew, green = gNew, blue = bNew)

    int color = Math.LeftShift(aNew, 24) + Math.LeftShift(rNew, 16) + Math.LeftShift(gNew, 8) + bNew
    return color
EndFunction


Int function alterTintMaskTarget(int colorBase, int maskType = 6, int maskIndex = 0, int colorTarget, float colorMod = 0.5)
	int aOffset = 0
	int rOffset = 0
	int gOffset = 0
	int bOffset = 0

 	; int colorBase = Game.GetTintMaskColor(maskType, maskIndex)
	int aBase = Math.RightShift( colorBase, 24)
	int rBase = Math.LogicalAnd( Math.RightShift( colorBase, 16), 0x00FF) 
	int gBase = Math.LogicalAnd( Math.RightShift( colorBase, 8), 0x0000FF) 
	int bBase = Math.LogicalAnd( colorBase, 0x000000FF) 

	int aTarget = Math.RightShift( colorTarget, 24)
	int rTarget = Math.LogicalAnd( Math.RightShift( colorTarget, 16), 0x00FF) 
	int gTarget = Math.LogicalAnd( Math.RightShift( colorTarget, 8), 0x0000FF) 
	int bTarget = Math.LogicalAnd( colorTarget, 0x000000FF) 

	aOffset = -1 * ((( (aBase - aTarget) as Float) * colorMod) as Int)
	rOffset = -1 * ((( (rBase - rTarget) as Float) * colorMod) as Int)
	gOffset = -1 * ((( (gBase - gTarget) as Float) * colorMod) as Int)
	bOffset = -1 * ((( (bBase - bTarget) as Float) * colorMod) as Int)

	debugTrace( ":::: SexLab Hormones: Sync tint mask - " +  maskType )
	debugTrace("[SLH]  Orig color - " + aBase + " - " + rBase + " - " + gBase + " - " + bBase  )
	debugTrace("[SLH]  Target color - " + aTarget + " - " + rTarget + " - " + gTarget + " - " + bTarget  )
	debugTrace("[SLH]  Offsets - " + aOffset + " - " + rOffset + " - " + gOffset + " - " + bOffset  )
	debugTrace("[SLH]  ColorMod - " + colorMod )

	int aNew = fctUtil.iMin(fctUtil.iMax(aBase + aOffset, 0), 255)
	int rNew = fctUtil.iMin(fctUtil.iMax(rBase + rOffset, 0), 255)
	int gNew = fctUtil.iMin(fctUtil.iMax(gBase + gOffset, 0), 255)
	int bNew = fctUtil.iMin(fctUtil.iMax(bBase + bOffset, 0), 255)

	debugTrace("[SLH]  New color - " + aNew + " - " + rNew + " - " + gNew + " - " + bNew  )
    alterTintMask(type = maskType, alpha = aNew, red = rNew, green = gNew, blue = bNew)

    int color = Math.LeftShift(aNew, 24) + Math.LeftShift(rNew, 16) + Math.LeftShift(gNew, 8) + bNew
    return color
EndFunction

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

function sendSlaveTatModEvent(actor akActor, string sType, string sTatooName, int iColor = 0x99000000)
	; SlaveTats.simple_add_tattoo(bimbo, "Bimbo", "Tramp Stamp", last = false, silent = true)
  	int STevent = ModEvent.Create("STSimpleAddTattoo")  

  	if (STevent) 
        ModEvent.PushForm(STevent, akActor)      	; Form - actor
        ModEvent.PushString(STevent, sType)    	; String - type of tattoo?
        ModEvent.PushString(STevent, sTatooName)  	; String - name of tattoo
        ModEvent.PushInt(STevent, iColor)  			; Int - color
        ModEvent.PushBool(STevent, false)        	; Bool - last = false
        ModEvent.PushBool(STevent, true)         	; Bool - silent = true

        ModEvent.Send(STevent)
  	else
  		Debug.Trace("[SLH] SLH_fctColor: Send slave tat event failed.")
	endIf
endfunction

function initColorConstants(Actor kActor)
 
	iHairColorSuccubus = Math.LeftShift(255, 24) + Math.LeftShift(0, 16) + Math.LeftShift(0, 8) + 0
	iHairColorBimbo = Math.LeftShift(255, 24) + Math.LeftShift(251, 16) + Math.LeftShift(198, 8) + 248

	; iHairColorOrig = pLeveledActorBase.GetHairColor()
	; pLeveledActorBase.SetHairColor(iHairColorSuccubus)

	iRedSkinColor = Math.LeftShift(128, 24) + Math.LeftShift(200, 16) + Math.LeftShift(0, 8) + 0
	iBlueSkinColor = Math.LeftShift(128, 24) + Math.LeftShift(50, 16) + Math.LeftShift(0, 8) + 255

	if (GV_redShiftColor.GetValue() == 0)
		GV_redShiftColor.SetValue( Math.LeftShift(200, 16) + Math.LeftShift(0, 8) + 0 )
	Else
		iRedSkinColor = Math.LeftShift(128, 24) + (GV_redShiftColor.GetValue() as Int)
	EndIf

	if (GV_blueShiftColor.GetValue() == 0)
		GV_blueShiftColor.SetValue( Math.LeftShift(50, 16) + Math.LeftShift(0, 8) + 255 )
	Else
		iBlueSkinColor =  Math.LeftShift(128, 24) + (GV_blueShiftColor.GetValue() as Int)
	EndIf

	iSuccubusRedSkinColor = iRedSkinColor
	iSuccubusBlueSkinColor = iBlueSkinColor


endFunction

function initColorState(Actor kActor)
	; Player by default  - kActor ignored

	iOrigSkinColor = Game.GetTintMaskColor(6,0)
	iSkinColor = iOrigSkinColor
	iOrigCheeksColor = Game.GetTintMaskColor(9,0)
	iCheeksColor = iOrigCheeksColor
	iOrigLipsColor = Game.GetTintMaskColor(1,0)
	iLipsColor = iOrigLipsColor
	iOrigEyelinerColor = Game.GetTintMaskColor(3,0)
	iEyelinerColor = iOrigEyelinerColor

endFunction

function setColorStateDefault(Actor kActor)
	; Player by default  - kActor ignored

	iOrigSkinColor = Game.GetTintMaskColor(6,0)
	iSkinColor = iOrigSkinColor
	iOrigCheeksColor = Game.GetTintMaskColor(9,0)
	iCheeksColor = iOrigCheeksColor
	iOrigLipsColor = Game.GetTintMaskColor(1,0)
	iLipsColor = iOrigLipsColor
	iOrigEyelinerColor = Game.GetTintMaskColor(3,0)
	iEyelinerColor = iOrigEyelinerColor

	setColorState(kActor)

endFunction

function resetColorState(Actor kActor)
	; Player by default  - kActor ignored

	; iOrigSkinColor = Game.GetTintMaskColor(6,0)
	iSkinColor = iOrigSkinColor
	; iOrigCheeksColor = Game.GetTintMaskColor(9,0)
	iCheeksColor = iOrigCheeksColor
	; iOrigLipsColor = Game.GetTintMaskColor(1,0)
	iLipsColor = iOrigLipsColor
	; iOrigEyelinerColor = Game.GetTintMaskColor(3,0)
	iEyelinerColor = iOrigEyelinerColor

	setColorState(kActor)

endFunction


function setColorState(Actor kActor)
	debugTrace("[SLH]  Writing color state to storage")

	StorageUtil.SetIntValue(kActor, "_SLH_iOrigSkinColor", iOrigSkinColor) 
	StorageUtil.SetIntValue(kActor, "_SLH_iOrigCheeksColor", iOrigCheeksColor) 
	StorageUtil.SetIntValue(kActor, "_SLH_iOrigLipsColor", iOrigLipsColor) 
	StorageUtil.SetIntValue(kActor, "_SLH_iOrigEyelinerColor", iOrigEyelinerColor) 
	StorageUtil.SetIntValue(kActor, "_SLH_iOrigEyesColor", iOrigEyesColor) 
	StorageUtil.SetIntValue(kActor, "_SLH_iOrigHairColor", iOrigHairColor) 

	StorageUtil.SetIntValue(kActor, "_SLH_iSkinColor", iSkinColor) 
	StorageUtil.SetIntValue(kActor, "_SLH_iCheeksColor", iCheeksColor) 
	StorageUtil.SetIntValue(kActor, "_SLH_iLipsColor", iLipsColor) 
	StorageUtil.SetIntValue(kActor, "_SLH_iEyelinerColor", iEyelinerColor) 
	StorageUtil.SetIntValue(kActor, "_SLH_iEyesColor", iEyesColor) 
	StorageUtil.SetIntValue(kActor, "_SLH_iHairColor", iHairColor) 

endFunction


function getColorState(Actor kActor)
	debugTrace("[SLH]  Reading color state from storage")

	iOrigSkinColor = StorageUtil.GetIntValue(kActor, "_SLH_iOrigSkinColor") 
	iOrigCheeksColor = StorageUtil.GetIntValue(kActor, "_SLH_iOrigCheeksColor") 
	iOrigLipsColor = StorageUtil.GetIntValue(kActor, "_SLH_iOrigLipsColor") 
	iOrigEyelinerColor = StorageUtil.GetIntValue(kActor, "_SLH_iOrigEyelinerColor") 
	iOrigEyesColor = StorageUtil.GetIntValue(kActor, "_SLH_iOrigEyesColor") 
	iOrigHairColor = StorageUtil.GetIntValue(kActor, "_SLH_iOrigHairColor") 
	
	iSkinColor = StorageUtil.GetIntValue(kActor, "_SLH_iSkinColor") 
	iCheeksColor = StorageUtil.GetIntValue(kActor, "_SLH_iCheeksColor") 
	iLipsColor = StorageUtil.GetIntValue(kActor, "_SLH_iLipsColor") 
	iEyelinerColor = StorageUtil.GetIntValue(kActor, "_SLH_iEyelinerColor") 
	iEyesColor = StorageUtil.GetIntValue(kActor, "_SLH_iEyesColor") 
	iHairColor = StorageUtil.GetIntValue(kActor, "_SLH_iHairColor") 


endFunction


function refreshColors(Actor kActor)

	if (GV_useColors.GetValue() == 1)
		If (iSkinColor == 0)
			iSkinColor = Game.GetTintMaskColor(6,0)
		Else
			setTintMask(6,iSkinColor)
		EndIf

		If (iCheeksColor == 0)
			iCheeksColor = Game.GetTintMaskColor(9,0)
		Else
			setTintMask(9,iCheeksColor)
		EndIf

		If (iLipsColor == 0)
			iLipsColor = Game.GetTintMaskColor(1,0)
		Else
			setTintMask(1,iLipsColor)
		EndIf

		If (iEyelinerColor  == 0)
			iEyelinerColor = Game.GetTintMaskColor(3,0)
		Else
			setTintMask(3,iEyelinerColor)
		EndIf

	EndIf
endFunction

Function debugTrace(string traceMsg)
	if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
		Debug.Trace(traceMsg)
	endif
endFunction
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ENBSeries effect file
// Visit http://enbdev.com for updates
// Copyright (c) 2007-2013 Boris Vorontsov
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Editing by Matso (SVI Series), 2013
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//+++++++++++++++++++++++++++++
// Internal parameters, can be modified
//+++++++++++++++++++++++++++++

// Anamorphic flare parameters
#define USE_ANAMFLARE				// comment it to disable anamorphic lens flare (ALF)
#define fFlareAxis	0				// blur axis


float	fFlareBlur
<
	string UIName="ALF: Size of the flare";
	string UIWidget="Spinner";
	float UIMin=10.0;
	float UIMax=1000.0;
> = {200.0};

float	fFlareIntensityInterior
<
	string UIName="ALF: Flare intensity interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.04};

float	fFlareIntensityDay
<
	string UIName="ALF: Flare intensity day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.04};

float	fFlareIntensityNight
<
	string UIName="ALF: Flare intensity night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.04};

float	fFlareLuminanceInterior
<
	string UIName="ALF: Flare luminance interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {0.25};

float	fFlareLuminanceDay
<
	string UIName="ALF: Flare luminance day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {0.25};

float	fFlareLuminanceNight
<
	string UIName="ALF: Flare luminance night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {0.25};

float3	fFlareTint
<
	string UIName="ALF: Flare tint";
	string UIWidget="Color";
> = {0.0, 0.0, 1.0};

//-/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Lens dirt parameters
float	fLensDirtAmountDay
<
	string UIName="DRT: Lens dirt amount day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=20.0;
> = {3.5};

float	fLensBloomAmountDay
<
	string UIName="DRT: Lens bloom amount day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.1};

float	fLensDirtAmountNight
<
	string UIName="DRT: Lens dirt amount night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=20.0;
> = {3.5};

float	fLensBloomAmountNight
<
	string UIName="DRT: Lens bloom amount night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.1};

float	fLensDirtAmountInterior
<
	string UIName="DRT: Lens dirt amount interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=20.0;
> = {3.5};

float	fLensBloomAmountInterior
<
	string UIName="DRT: Lens bloom amount interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.1};

float3	fLensDirtTint
<
	string UIName="DRT: Lens dirt tint";
	string UIWidget="Color";
> = {1.0, 1.0, 1.0};

//+++++++++++++++++++++++++++++
// External parameters, do not modify
//+++++++++++++++++++++++++++++
//keyboard controlled temporary variables (in some versions exists in the config file). Press and hold key 1,2,3...8 together with PageUp or PageDown to modify. By default all set to 1.0
float4	tempF1; //0,1,2,3
float4	tempF2; //5,6,7,8
float4	tempF3; //9,0
//x=Width, y=1/Width, z=ScreenScaleY, w=1/ScreenScaleY
float4	ScreenSize;
//changes in range 0..1, 0 means that night time, 1 - day time
float	ENightDayFactor;
//changes 0 or 1. 0 means that exterior, 1 - interior
float	EInteriorFactor;
//x=generic timer in range 0..1, period of 16777216 ms (4.6 hours), w=frame time elapsed (in seconds)
float4	Timer;
//additional info for computations
float4	TempParameters; 
//x=reflection intensity, y=reflection power, z=dirt intensity, w=dirt power
float4	LensParameters;
//fov in degrees
float	FieldOfView;

texture2D texColor;
texture2D texMask;//enblensmask texture
texture2D texBloom1;
texture2D texBloom2;
texture2D texBloom3;
texture2D texBloom4;
texture2D texBloom5;
texture2D texBloom6;
texture2D texBloom7;
texture2D texBloom8;

sampler2D SamplerColor = sampler_state
{
	Texture   = <texColor>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};

sampler2D SamplerMask = sampler_state
{
	Texture   = <texMask>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};

sampler2D SamplerBloom1 = sampler_state
{
	Texture   = <texBloom1>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};

sampler2D SamplerBloom2 = sampler_state
{
	Texture   = <texBloom2>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};

sampler2D SamplerBloom3 = sampler_state
{
	Texture   = <texBloom3>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};

sampler2D SamplerBloom4 = sampler_state
{
	Texture   = <texBloom4>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};

sampler2D SamplerBloom5 = sampler_state
{
	Texture   = <texBloom5>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};

sampler2D SamplerBloom6 = sampler_state
{
	Texture   = <texBloom6>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};

sampler2D SamplerBloom7 = sampler_state
{
	Texture   = <texBloom7>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};

sampler2D SamplerBloom8 = sampler_state
{
	Texture   = <texBloom8>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};

struct VS_OUTPUT_POST
{
	float4 vpos  	: POSITION;
	float2 txcoord0 : TEXCOORD0;
};
struct VS_INPUT_POST
{
	float3 pos  	: POSITION;
	float2 txcoord0 : TEXCOORD0;
};

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Functions
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/**
 * Bright pass - rescales sampled pixel to emboss bright enough value.
 */
float3 BrightPass(float2 tex)
{
    float fFlareLuminance = lerp(lerp(fFlareLuminanceNight, fFlareLuminanceDay, ENightDayFactor), fFlareLuminanceInterior, EInteriorFactor);
	float3 c = tex2D(SamplerBloom2, tex).rgb;
    float3 bC = max(c - float3(fFlareLuminance, fFlareLuminance, fFlareLuminance), 0.0);
    return lerp(0.0, c, smoothstep(0.0, 0.5, dot(bC, 1.0)));
}

/**
 * Anamorphic sampling function - scales pixel coordinate
 * to stratch the image along one of the axels.
 * (http://en.wikipedia.org/wiki/Anamorphosis)
 */
float3 AnamorphicSample(int axis, float2 tex, float blur)
{
	tex = 2.0 * tex - 1.0;
	if (!axis) tex.x /= -blur;
	else tex.y /= -blur;
	tex = 0.5 * tex + 0.5;
	return BrightPass(tex);
}

/**
 * Pseudo-random number generator - returns a number generated according to the provided vector.
 */
float Random(float2 co)
{
    return frac(sin(dot(co.xy, float2(12.9898, 78.233))) * 43758.5453);
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Shaders
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST VS_Draw(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;

	OUT.vpos = float4(IN.pos.x, IN.pos.y, IN.pos.z, 1.0);
	OUT.txcoord0.xy = IN.txcoord0.xy + TempParameters.xy;

	return OUT;
}

// Lens flares pixels shader, by Boris Vorontsov.
float4 PS_Draw(VS_OUTPUT_POST In) : COLOR
{
	float4 res = 0.0;
	float2 coord;
	
	// Shape parameters - deepness, curvature and inverse size.
	const float3 offset[4]=
	{
		float3(1.6, 4.0, 1.0),
		float3(0.7, 0.25, 2.0),
		float3(0.3, 1.5, 0.5),
		float3(-0.5, 1.0, 1.0)
	};
	// Color filter per reflection.
	const float3 factors[4]=
	{
		float3(0.3, 0.4, 0.4),
		float3(0.2, 0.4, 0.5),
		float3(0.5, 0.3, 0.7),
		float3(0.1, 0.2, 0.7)
	};

	// Do the lens sampling for 4 flares.
	for (int i = 0; i < 4; i++)
	{
		// Sample position praparation.
		float2 distfact = (In.txcoord0.xy - 0.5);
		coord.xy = offset[i].x * distfact;
		coord.xy *= pow(2.0 * length(float2(distfact.x * ScreenSize.z, distfact.y)), offset[i].y);
		coord.xy *= offset[i].z;
		coord.xy = 0.5 - coord.xy;
		
		// Sampling the color from the bloom textures.
		float3 templens = tex2D(SamplerBloom2, coord.xy);
		templens = templens * factors[i];
		distfact = (coord.xy - 0.5);
		distfact *= 2.0;
		templens *= saturate(1.0 - dot(distfact, distfact));//limit by uv 0..1
		
		// Final adjustment of flare color.
		float maxlens = max(templens.r, max(templens.g, templens.b));
		float tempnor = (maxlens / (1.0 + maxlens));
		tempnor = pow(tempnor, LensParameters.y);
		templens.rgb *= tempnor;

		// Accumulation of the result.
		res.rgb += templens;
	}
	res.rgb *= 0.25 * LensParameters.x;
	
	// Add mask effect.
	float fLensDirtAmount = lerp(lerp(fLensDirtAmountNight, fLensDirtAmountDay, ENightDayFactor), fLensDirtAmountInterior, EInteriorFactor);
	float fLensBloomAmount = lerp(lerp(fLensBloomAmountNight, fLensBloomAmountDay, ENightDayFactor), fLensBloomAmountInterior, EInteriorFactor);
	
	float3 templens = fLensDirtAmount * res.rgb + tex2D(SamplerBloom6, In.txcoord0.xy) * fLensBloomAmount;
	float maxlens = max(templens.x, max(templens.y, templens.z));
	float tempnor = (maxlens / (1.0 + maxlens));
	float4 mask = tex2D(SamplerMask, In.txcoord0.xy);
	
	tempnor = pow(tempnor, LensParameters.w);
	templens.rgb *= tempnor * LensParameters.z;
	res.rgb += mask.rgb * templens.rgb;
	res.rgb *= fLensDirtTint;

	return res;
}

float4 PS_LensPostPass(VS_OUTPUT_POST In) : COLOR
{
	float4 res = 0.0;
	res = tex2D(SamplerColor, In.txcoord0.xy);
	res.rgb = min(res.rgb, 32768.0);
	res.rgb = max(res.rgb, 0.0);

	return res;
}

// Anamorphic lens flare pixel shader (Matso code)
float4 PS_AnamorphicFlare(VS_OUTPUT_POST IN, float2 vPos : VPOS, uniform int axis) : COLOR

{
    float fFlareIntensity = lerp(lerp(fFlareIntensityNight, fFlareIntensityDay, ENightDayFactor), fFlareIntensityInterior, EInteriorFactor);
	float4 res = 0.0;
	float3 anamFlare = AnamorphicSample(axis, IN.txcoord0.xy, fFlareBlur) * fFlareTint;
	
	res.rgb = anamFlare * fFlareIntensity;
	
	return res;
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Techniques
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Actual computation, draw all effects to small texture.
technique Draw
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Draw();
		PixelShader  = compile ps_3_0 PS_Draw();

		ColorWriteEnable=ALPHA|RED|GREEN|BLUE;
		CullMode=NONE;
		AlphaBlendEnable=FALSE;
		AlphaTestEnable=FALSE;
		SeparateAlphaBlendEnable=FALSE;
		SRGBWriteEnable=FALSE;
	}
}

// Final pass, output to screen with additive blending and no alpha.
technique LensPostPass
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Draw();
		PixelShader  = compile ps_3_0 PS_LensPostPass();

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;
		ColorWriteEnable=RED|GREEN|BLUE;//warning, no alpha output!
		CullMode=NONE;
		AlphaTestEnable=FALSE;
		SeparateAlphaBlendEnable=FALSE;
		SRGBWriteEnable=FALSE;
	}

#ifdef USE_ANAMFLARE
	pass p1
	{
		PixelShader = compile ps_3_0 PS_AnamorphicFlare(fFlareAxis);
	}
#endif
}

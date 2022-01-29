///////////////////////////////////////////////
// Filename: ENBSeries Bloom fx              //
// http://enbdev.com                         //
// Copyright (c) 2007-2014 Boris Vorontsov   //
// Modified by Carlos for CR Enb 264 Version //
// Ultimate mutiple BloomLayer effects       //
// Mimic Next generation game bloom effect   //
///////////////////////////////////////////////

// NOTE: This file is formatted to be viewed in Courier New font.

/////////////////////////
// DEFINES AND ENABLES //
/////////////////////////

// NOTE: To activate a feature, remove the two slashes in front of the #define. To deactivate it, add two slashes.

#define ENABLE_BLOOM            	// Enable Bloom. See Bloom settings.
#define USE_BLOOM_AVG           	// Use average of active bloom layers. If this is disabled, it will add them together.

#define ENABLE_LENZ_REFLECTION  	// Enable Lenz Reflection. Only use one lenz below.
#define USE_LENZ_SHARP          	// Use sharp reflections in lenz.
#define USE_LENZ_FUZZY          	// Use fuzzy reflections in lenz. 
#define USE_LENZ_BLURRY         	// Use blurry reflections in lenz.
#define USE_LENZ_FILTER         	// Use filter colors for reflections, rather than simply tinting the lens reflection.

//////////////////////////
// GLOBALS AND SETTINGS //
//////////////////////////

// Bloom settings
// NOTE: High bloom curves can cause a posterized look to bloom with multiple blur layers active.

float fBloomCurve < string UIName="BloomCurve"; string UIWidget="Spinner"; float UIMin=0.1; float UIMax=2.0; > = 0.4;		       	
// Controls spread of brighter parts of bloom. Higher = Wider. Range is 0.1-2.

float fBloomDistance < string UIName="BloomDistance"; string UIWidget="Spinner"; float UIMin=1.0; float UIMax=10.0; > = 6;						
// Controls initial spread of bloom samples (in pixels). Range is 1.0+.

float fBloomMult1 < string UIName="Amount"; string UIWidget="Spinner"; float UIMin=0; float UIMax=1.0; > = 0.0;        	 	
// Controls the amount of original image in bloom. Range is 0-1.

float fBloomMult2 < string UIName="Initial Blur"; string UIWidget="Spinner"; float UIMin=0; float UIMax=1.0; > = 1.0;         		
// Controls the amount of the initial blur spread in bloom. Range is 0-1.

float fBloomMult3 < string UIName="10px Blur"; string UIWidget="Spinner"; float UIMin=0; float UIMax=1.0; > = 0.86;         	
// Controls the amount of 10px blur. Range is 0-1.

float fBloomMult4 < string UIName="20px Blur"; string UIWidget="Spinner"; float UIMin=0; float UIMax=1.0; > = 0.64;         	
// Controls the amount of 20px blur. Range is 0-1.

float fBloomMult5 < string UIName="40px Blur"; string UIWidget="Spinner"; float UIMin=0; float UIMax=1.0; > = 0.32;         	
// Controls the amount of 40px blur. Range is 0-1.

float fBloomMult6 < string UIName="80px Blur"; string UIWidget="Spinner"; float UIMin=0; float UIMax=1.0; > = 0.16;         	
// Controls the amount of 80px blur. Range is 0-1.

float fBloomMult7 < string UIName="160px Blur"; string UIWidget="Spinner"; float UIMin=0; float UIMax=1.0; > = 0.08;         	
// Controls the amount of 160px blur. Range is 0-1.

float fBloomMult8 < string UIName="320px Blur"; string UIWidget="Spinner"; float UIMin=0; float UIMax=1.0; > = 0.04;         	
// Controls the amount of 320px blur. Range is 0-1.



// Lenz settings

float LenzScalar < string UIName="LenzScalar"; string UIWidget="Spinner"; float UIMin=0; float UIMax=10.0; > = 2.0;         	
// Controls overall Lenz reflection intensity.
const float3 LenzOffset[4]={    	// Controls the deepness, curvature, inverse size of the four lens reflections.
	float3(1.6, 4.0, 1.0),
	float3(0.7, 0.25, 2.0),
	float3(0.3, 1.5, 0.5),
	float3(-0.5, 1.0, 1.0)};
const float3 LenzColors[4]={    	// Controls the color of the four lens reflection filter colors.
	float3(0.3, 0.4, 0.4),
	float3(0.2, 0.4, 0.5),
	float3(0.5, 0.3, 0.7),
	float3(0.1, 0.2, 0.7)};
const float3 LenzTint[4]={      	// Controls the color of the four lens reflection tints.
	float3(0.0, 0.2, 0.2),
	float3(0.1, 0.2, 0.0),
	float3(0.25, 0.15, 0.0),
	float3(0.05, 0.0, 0.35)};
//////////////////////////////////////////////
// DO NOT MODIFY ANYTHING BELOW THIS LINE,  //
// UNLESS YOU KNOW HLSL SHADER PROGRAMMING. //
//////////////////////////////////////////////

// Temporary variables. Press and hold key 1,2,3...8 together with PageUp or PageDown to modify them in-game. By default all set to 1.0.
float4	tempF1;         	//0,1,2,3
float4	tempF2;         	//5,6,7,8
float4	tempF3;         	//9,0
float4	ScreenSize;     	//x=Width, y=1/Width, z=ScreenScaleY, w=1/ScreenScaleY
float4	Timer;          	//x=timer, range 0..1, period of 16777216 ms (4.6 hours), w=frame time elapsed (in seconds)
float4	TempParameters; 	//additional info for computations
float4	LenzParameters; 	//Lenz reflection intensity, lenz reflection power
float4	BloomParameters;	//BloomRadius1, BloomRadius2, BloomBlueShiftAmount, BloomContrast

//////////////
// TEXTURES //
//////////////
texture2D texBloom1;
texture2D texBloom2;
texture2D texBloom3;
texture2D texBloom4;
texture2D texBloom5;
texture2D texBloom6;
texture2D texBloom7;
texture2D texBloom8;

sampler2D SamplerBloom1 = sampler_state
{
    Texture   = <texBloom1>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerBloom2 = sampler_state
{
    Texture   = <texBloom2>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerBloom3 = sampler_state
{
    Texture   = <texBloom3>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerBloom4 = sampler_state
{
    Texture   = <texBloom4>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerBloom5 = sampler_state
{
    Texture   = <texBloom5>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerBloom6 = sampler_state
{
    Texture   = <texBloom6>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerBloom7 = sampler_state
{
    Texture   = <texBloom7>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerBloom8 = sampler_state
{
    Texture   = <texBloom8>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

///////////////
// FUNCTIONS //
///////////////

float Luminance( float3 Color )
{
	return dot( Color, float3( 0.2125, 0.7154, 0.0721 ) );
}

/////////////
// SHADERS //
/////////////

struct VS_OUTPUT_POST
{
	float4 vpos  : POSITION;
	float2 txcoord0 : TEXCOORD0;
};
struct VS_INPUT_POST
{
	float3 pos  : POSITION;
	float2 txcoord0 : TEXCOORD0;
};

VS_OUTPUT_POST VS_Bloom(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	OUT.vpos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord0.xy=IN.txcoord0.xy+TempParameters.xy;
	return OUT;
}

// Bloom Pass 0. Averages colors from original image pixels in a square pattern.
float4 PS_BloomPrePass(VS_OUTPUT_POST In) : COLOR
{
	float4 BloomTexCoord = float4( In.txcoord0.x, In.txcoord0.y, 0.0, 1.0 );
	float4 BloomColor = 0.0;
	const float2 TexCoordOffset[9] =
	{
		float2(-0.7, -0.7),
		float2(-1.0, 0.0),
		float2(-0.7, 0.7),
		float2(0.0, -1.0),
		float2(0.0, 0.0),
		float2(0.0, 1.0),
		float2(0.7, -0.7),
		float2(1.0, 0.0),
		float2(0.7, 0.7)
	};
	// NOTE: I've no idea what TempParameter is, but it's in Boris's original code. Oh well.
	float2 ScreenFactor = float2( ScreenSize.y, ScreenSize.y * ScreenSize.z );
	float ScreenFactorMultiplier = fBloomDistance;
	ScreenFactor.xy *= ScreenFactorMultiplier;
	float BloomWeight = 0.00001;
	for( int i = 0; i < 9; i++)
	{
		BloomTexCoord.xy = In.txcoord0.xy + ( ScreenFactor.xy * TexCoordOffset[i] );
		// Weight the bloom based on the Bloom Curve.
		float4 TempBloomColor = tex2D(SamplerBloom1, BloomTexCoord.xy);
		float TempBloomLuminance = ( TempBloomColor.r + TempBloomColor.g + TempBloomColor.b ) * 0.3333;
		float TempBloomWeight = pow( TempBloomLuminance, fBloomCurve );
		BloomWeight += TempBloomWeight;
		BloomColor += TempBloomColor * TempBloomWeight;
	}
	BloomColor /= BloomWeight;
	BloomColor.rgb = clamp( BloomColor.rgb, 0.0, 32767.0 );
	BloomColor.a = 1.0;
	return BloomColor;
}

// Bloom Pass 1. Averages colors from input textures in adjacent pixels, based on which pass it is.
float4 PS_BloomTexture1(VS_OUTPUT_POST In) : COLOR
{

	float4 BloomTexCoord = float4( In.txcoord0.x, In.txcoord0.y, 0.0, 1.0 );
	float4 BloomColor = 0.0;
	const float2 TexCoordOffset[9] =
	{
		float2(-0.7, -0.7),
		float2(-1.0, 0.0),
		float2(-0.7, 0.7),
		float2(0.0, -1.0),
		float2(0.0, 0.0),
		float2(0.0, 1.0),
		float2(0.7, -0.7),
		float2(1.0, 0.0),
		float2(0.7, 0.7)
	};
	// NOTE: I've no idea what TempParameter is, but it's in Boris's original code. Oh well.
	// float2 ScreenFactor = float2( ScreenSize.y, ScreenSize.y * ScreenSize.z );
	float2 ScreenFactor = float2( TempParameters.z, TempParameters.z * ScreenSize.z );
	float ScreenFactorMultiplier = BloomParameters.x;
	ScreenFactor.xy *= ScreenFactorMultiplier;
	float BloomWeight = 0.00001;
	for( int i = 0; i < 9; i++)
	{
		BloomTexCoord.xy = In.txcoord0.xy + ( ScreenFactor.xy * TexCoordOffset[i] );
		// Weight the bloom based on the Bloom Curve.
		float4 TempBloomColor = tex2D(SamplerBloom1, BloomTexCoord.xy);
		float TempBloomLuminance = ( TempBloomColor.r + TempBloomColor.g + TempBloomColor.b ) * 0.3333;
		float TempBloomWeight = pow( TempBloomLuminance, fBloomCurve );
		BloomWeight += TempBloomWeight;
		BloomColor += TempBloomColor * TempBloomWeight;
	}
	BloomColor /= BloomWeight;
	BloomColor.rgb = clamp( BloomColor.rgb, 0.0, 32767.0 );
	BloomColor.a = 1.0;
	return BloomColor;
}

// Bloom Pass 2. Averages colors from input textures in a rotated adjacent pattern, based on which pass it is.
float4 PS_BloomTexture2(VS_OUTPUT_POST In) : COLOR
{
	float4 BloomTexCoord = float4( In.txcoord0.x, In.txcoord0.y, 0.0, 1.0 );
	float4 BloomColor = 0.0;
	const float2 TexCoordOffset[9]=
	{
		float2(-0.7, -0.7),
		float2(-1.0, 0.0),
		float2(-0.7, 0.7),
		float2(0.0, -1.0),
		float2(0.0, 0.0),
		float2(0.0, 1.0),
		float2(0.7, -0.7),
		float2(1.0, 0.0),
		float2(0.7, 0.7)
	};
	// NOTE: I've no idea what TempParameter is, but it's in Boris's original code. Oh well.
	// float2 ScreenFactor = float2( ScreenSize.y, ScreenSize.y * ScreenSize.z );
	float2 ScreenFactor = float2( TempParameters.z, TempParameters.z * ScreenSize.z );
	float ScreenFactorMultiplier = BloomParameters.y;
	ScreenFactor.xy *= ScreenFactorMultiplier;
	float BloomWeight = 0.00001;
	for( int i = 0; i < 9; i++ )
	{
		// Rotate the original vectors from Bloom Pass 1.
		const float PI = 3.14159265359;
		float Rotation = PI / 6.0;
		float2 OriginalVector = TexCoordOffset[i];
		float2 RotatedVector = 0.0;
		RotatedVector.x = ( OriginalVector.x * cos( Rotation ) ) - ( OriginalVector.y * sin( Rotation ) );
		RotatedVector.y = ( OriginalVector.y * cos( Rotation ) ) + ( OriginalVector.x * sin( Rotation ) );
		BloomTexCoord.xy = In.txcoord0.xy + ( ScreenFactor.xy * RotatedVector );
		// Weight the bloom based on the Bloom Curve.
		float4 TempBloomColor = tex2D(SamplerBloom1, BloomTexCoord.xy);
		float TempBloomLuminance = ( TempBloomColor.r + TempBloomColor.g + TempBloomColor.b ) * 0.3333;
		float TempBloomWeight = pow( TempBloomLuminance, fBloomCurve );
		BloomWeight += TempBloomWeight;
		BloomColor += TempBloomColor * TempBloomWeight;
	}
	BloomColor /= BloomWeight;
	BloomColor.rgb = clamp( BloomColor.rgb, 0.0, 32767.0 );
	BloomColor.a = 1.0;
	return BloomColor;
}

float4 PS_BloomPostPass(VS_OUTPUT_POST In) : COLOR
{
	float4 BloomColor = 0.0;
	float4 BloomTexCoord = float4( In.txcoord0.x, In.txcoord0.y, 0.0, 1.0 );
	#ifdef ENABLE_BLOOM
	BloomColor += tex2D(SamplerBloom6, BloomTexCoord.xy) * fBloomMult1;
	BloomColor += tex2D(SamplerBloom5, BloomTexCoord.xy) * fBloomMult2;
	BloomColor += tex2D(SamplerBloom1, BloomTexCoord.xy) * fBloomMult3;
	BloomColor += tex2D(SamplerBloom2, BloomTexCoord.xy) * fBloomMult4;
	BloomColor += tex2D(SamplerBloom3, BloomTexCoord.xy) * fBloomMult5;
	BloomColor += tex2D(SamplerBloom4, BloomTexCoord.xy) * fBloomMult6;
	BloomColor += tex2D(SamplerBloom7, BloomTexCoord.xy) * fBloomMult7;
	BloomColor += tex2D(SamplerBloom8, BloomTexCoord.xy) * fBloomMult8;
	#ifdef USE_BLOOM_AVG
	float TotalBloom = fBloomMult1 + fBloomMult2 + fBloomMult3 + fBloomMult4 + fBloomMult5 + fBloomMult6 + fBloomMult7 + fBloomMult8;
	BloomColor /= max( 1.0, TotalBloom );
	#endif
	#endif
	#ifndef ENABLE_BLOOM
	BloomColor = float4( 0.01, 0.01, 0.01, 1.0 ); 
	#endif
	BloomColor.rgb = clamp( BloomColor.rgb, 0.0, 32767.0 );
	
	#ifdef ENABLE_LENZ_REFLECTION
	float3 LenzColor = 0.0;
	float4 LenzTexCoord = float4( In.txcoord0.x, In.txcoord0.y, 0.0, 1.0 );
	if( LenzParameters.x > 0.0001 )
	{
		for( int i = 0; i < 4; i++ )
		{
			float2 distfact = ( In.txcoord0.xy - 0.5 );
			LenzTexCoord.xy = LenzOffset[i].x * distfact;
			LenzTexCoord.xy *= pow( 2.0 * length( float2( distfact.x*ScreenSize.z,distfact.y ) ), LenzOffset[i].y );
			LenzTexCoord.xy *= LenzOffset[i].z;
			LenzTexCoord.xy = 0.5-LenzTexCoord.xy;
			float3 TempLenzColor = 0.0;
			#ifdef USE_LENZ_SHARP
			TempLenzColor = tex2D( SamplerBloom5, LenzTexCoord.xy );
			#endif
			#ifdef USE_LENZ_FUZZY
			TempLenzColor = tex2D( SamplerBloom1, LenzTexCoord.xy );
			#endif
			#ifdef USE_LENZ_BLURRY
			TempLenzColor = tex2D( SamplerBloom2, LenzTexCoord.xy );
			#endif
			#ifdef USE_LENZ_FILTER
			TempLenzColor = TempLenzColor * LenzColors[i];
			distfact = ( LenzTexCoord.xy - 0.5 );
			distfact *= 2.0;
			TempLenzColor *= saturate( 1.0 - dot( distfact, distfact ) );
			float maxlenz = max( TempLenzColor.x, max( TempLenzColor.y, TempLenzColor.z ) );
			float tempnor = (maxlenz/(1.0+maxlenz))  * LenzScalar;
			tempnor=pow(tempnor, LenzParameters.y);
			TempLenzColor.rgb *= tempnor;
			LenzColor += TempLenzColor;
			#endif
			#ifndef USE_LENZ_FILTER
			TempLenzColor = ( 0.5 * TempLenzColor ) + LenzTint[i];
			distfact = ( LenzTexCoord.xy - 0.5 );
			distfact *= 2.0;
			TempLenzColor *= saturate( 1.0 - dot( distfact, distfact ) );
			float maxlenz = max( TempLenzColor.x, max( TempLenzColor.y, TempLenzColor.z ) );
			float tempnor = (maxlenz/(1.0+maxlenz))  * LenzScalar;
			tempnor=pow(tempnor, LenzParameters.y);
			TempLenzColor.rgb *= tempnor;
			LenzColor += TempLenzColor;
			#endif
		}
		LenzColor.rgb *= min( 1.0, max( 0.0, LenzParameters.x ) );
		BloomColor.rgb += LenzColor.rgb;
	}
	#endif
	BloomColor.a = 1.0;
	return BloomColor;
}

////////////////
// TECHNIQUES //
////////////////
technique BloomPrePass
{
    pass p0
    {
		VertexShader = compile vs_3_0 VS_Bloom();
		PixelShader  = compile ps_3_0 PS_BloomPrePass();

		ColorWriteEnable=ALPHA|RED|GREEN|BLUE;
		CullMode=NONE;
		AlphaBlendEnable=FALSE;
		AlphaTestEnable=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}

technique BloomTexture1
{
    pass p0
    {
		VertexShader = compile vs_3_0 VS_Bloom();
		PixelShader  = compile ps_3_0 PS_BloomTexture1();

		ColorWriteEnable=ALPHA|RED|GREEN|BLUE;
		CullMode=NONE;
		AlphaBlendEnable=FALSE;
		AlphaTestEnable=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}

technique BloomTexture2
{
    pass p0
    {
		VertexShader = compile vs_3_0 VS_Bloom();
		PixelShader  = compile ps_3_0 PS_BloomTexture2();

		ColorWriteEnable=ALPHA|RED|GREEN|BLUE;
		CullMode=NONE;
		AlphaBlendEnable=FALSE;
		AlphaTestEnable=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}

technique BloomPostPass
{
    pass p0
    {
		VertexShader = compile vs_3_0 VS_Bloom();
		PixelShader  = compile ps_3_0 PS_BloomPostPass();

		ColorWriteEnable=ALPHA|RED|GREEN|BLUE;
		CullMode=NONE;
		AlphaBlendEnable=FALSE;
		AlphaTestEnable=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}
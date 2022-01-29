//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ENBSeries effect file
// visit http://enbdev.com for updates
// Copyright (c) 2007-2013 Boris Vorontsov
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//This file is just an example for modders how to create own lenz fx


//+++++++++++++++++++++++++++++
//internal parameters, can be modified
//+++++++++++++++++++++++++++++
float	ELenzIntensity
<
	string UIName="Lenz flare intensity";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=100.0;
> = {0.25};



//+++++++++++++++++++++++++++++
//external parameters, do not modify
//+++++++++++++++++++++++++++++
//keyboard controlled temporary variables (in some versions exists in the config file). Press and hold key 1,2,3...8 together with PageUp or PageDown to modify. By default all set to 1.0
float4	tempF1; //0,1,2,3
float4	tempF2; //5,6,7,8
float4	tempF3; //9,0
// xy = cursor position in range 0..1 of screen;
// z = is shader editor window active;
// w = mouse buttons with values 0..7 as follows:
//    0 = none
//    1 = left
//    2 = right
//    3 = left+right
//    4 = middle
//    5 = left+middle
//    6 = right+middle
//    7 = left+right+middle (or rather cat is sitting on your mouse)
float4	tempInfo1;
// xy = cursor position of previous left mouse button click
// zw = cursor position of previous right mouse button click
float4	tempInfo2;
//x=Width, y=1/Width, z=ScreenScaleY, w=1/ScreenScaleY
float4	ScreenSize;
//x=generic timer in range 0..1, period of 16777216 ms (4.6 hours), w=frame time elapsed (in seconds)
float4	Timer;
//x = dawn, y = sunrise, z = day, w = sunset. Interpolators range from 0..1
float4	TimeOfDay1;
//x = dusk, y = night. Interpolators range from 0..1
float4	TimeOfDay2;
//changes in range 0..1, 0 means full quality, 1 lowest dynamic quality (0.33, 0.66 are limits for quality levels)
float	EAdaptiveQualityFactor;
//xy=sun position on screen, w=visibility
float4	LightParameters;
//fov in degrees
float	FieldOfView;



//textures
texture2D texColor;//enbsunsprite.bmp/tga/png image file
texture2D texMask;//hdr color of sun masked by clouds or objects

sampler2D SamplerColor = sampler_state
{
	Texture   = <texColor>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerMask = sampler_state
{
	Texture   = <texMask>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};



struct VS_OUTPUT_POST
{
	float4 vpos  : POSITION;
	float2 txcoord : TEXCOORD0;
};

struct VS_INPUT_POST
{
	float3 pos  : POSITION;
	float2 txcoord : TEXCOORD0;
};


/*
//BEGIN example 1. Basic effect with sprite drawed at sun position only
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST VS_Draw(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;

	float4 pos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	pos.y*=ScreenSize.z;
	pos.xy*=0.25;

	pos.xy+=LightParameters.xy;
	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;

	return OUT;
}



float4 PS_Draw(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;

	//read sun visibility as amount of effect
	float sunmask=tex2D(SamplerMask, float2(0.5, 0.5)).x;
	sunmask=pow(sunmask, 3.0);//more contrast to clouds
	clip(sunmask-0.02);//early exit if too low

	float4 origcolor=tex2D(SamplerColor, coord.xy);
	sunmask*=LightParameters.w * ELenzIntensity;
	res.xyz=origcolor * sunmask;

	float clipper=dot(res.xyz, 0.333);
	clip(clipper-0.0003);//skip draw if black

	res.w=1.0;
	return res;
}



technique Draw
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_Draw();
		PixelShader  = compile ps_3_0 PS_Draw();

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}
//END of example 1
*/


/*
//BEGIN example 2. Several sprites moving similar to lenz effect, but
//they are drawed to single fullscreen quad, not separately
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST VS_Draw(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;

	float4 pos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
//	pos.y*=ScreenSize.z;
//	pos.xy*=0.25;

	pos.xy+=LightParameters.xy;
	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;

	return OUT;
}



float4 PS_Draw(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;

	//read sun visibility as amount of effect
	float sunmask=tex2D(SamplerMask, float2(0.5, 0.5)).x;
	sunmask=pow(sunmask, 3.0);//more contrast to clouds
	clip(sunmask-0.02);//early exit if too low


	float2 sunpos=LightParameters.xy;
	sunpos.y=-sunpos.y;
	sunpos+=0.5;

	//copy-paste from enbbloom.fx with minor changes. If amount of
	//passes too high, then better to draw sprites separately and
	//transform quads in vertex shader
	float3 lenz=0;
	float2 lenzuv=0.0;
	//deepness, curvature, inverse size
	const float3 offset[4]=
	{
		float3(3.6, 4.0, 1.0),
		float3(1.5, 0.25, 2.0),
		float3(-4.5, 1.5, 0.5),
		float3(-1.4, 1.0, 1.0)
	};
	//color filter per reflection
	const float3 factors[4]=
	{
		float3(0.3, 0.4, 0.4),
		float3(0.2, 0.4, 0.5),
		float3(0.5, 0.3, 0.7),
		float3(0.1, 0.2, 0.7)
	};
	for (int i=0; i<4; i++)
	{
		float2 distfact=(IN.txcoord.xy-0.5);
		lenzuv.xy=offset[i].x*distfact;
		lenzuv.x*=ScreenSize.z;
		lenzuv.xy=sunpos.xy-lenzuv.xy;
		float3 templenz=tex2D(SamplerColor, lenzuv.xy);
		templenz=templenz*factors[i];
		lenz+=templenz;
	}
	res.xyz=lenz.xyz*0.25;

	//amount of fx
	sunmask*=LightParameters.w * ELenzIntensity;
	res.xyz=res * sunmask;

	float clipper=dot(res.xyz, 0.333);
	clip(clipper-0.0003);//skip draw if black

	res.w=1.0;
	return res;
}



technique Draw
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_Draw();
		PixelShader  = compile ps_3_0 PS_Draw();

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}
//END of example 2
*/



//BEGIN example 3. Several sprites moving similar to lenz effect,
//they are transformed in vertex shader and drawed separately for
//better performance. Offset is set in passes of technique
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST VS_Draw(VS_INPUT_POST IN, uniform float offset, uniform float scale)
{
	VS_OUTPUT_POST OUT;

	float4 pos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	pos.y*=ScreenSize.z;

	//create own parameters instead of this, including uv offsets
	float2 shift=LightParameters.xy * offset;
	pos.xy=pos.xy * scale - shift;


	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;

	return OUT;
}



float4 PS_Draw(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;

	//read sun visibility as amount of effect
	float sunmask=tex2D(SamplerMask, float2(0.5, 0.5)).x;
	sunmask=pow(sunmask, 3.0);//more contrast to clouds
	sunmask*=ELenzIntensity;
	clip(sunmask-0.008);//early exit if too low

	float4 origcolor=tex2D(SamplerColor, coord.xy);
	sunmask*=LightParameters.w;
	res.xyz=origcolor * sunmask;

	float clipper=dot(res.xyz, 0.333);
	clip(clipper-0.0003);//skip draw if black

	res.w=1.0;
	return res;
}



technique Draw
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_Draw(-0.5, 0.07);//offset, scale
		PixelShader  = compile ps_3_0 PS_Draw();

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P1
	{

		VertexShader = compile vs_3_0 VS_Draw(0.3, 0.15);//offset, scale
		PixelShader  = compile ps_3_0 PS_Draw();

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P2
	{

		VertexShader = compile vs_3_0 VS_Draw(1.4, 0.1);//offset, scale
		PixelShader  = compile ps_3_0 PS_Draw();

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P3
	{

		VertexShader = compile vs_3_0 VS_Draw(2.0, 0.3);//offset, scale
		PixelShader  = compile ps_3_0 PS_Draw();

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}
//END of example 3


//++++++++++++++++++++++++++++++++++++++++++++
// ENBSeries effect file
// visit http://enbdev.com for updates
// Copyright (c) 2007-2019 Boris Vorontsov
//++++++++++++++++++++++++++++++++++++++++++++


//+++++++++++++++++++++++++++++
//internal parameters, can be modified
//+++++++++++++++++++++++++++++
texture2D TextureNoise
<
	string UIName = "Blurred noise texture";
	string ResourceName = "enbunderwaternoise.bmp";
>;

sampler2D SamplerNoise = sampler_state
{
	Texture   = <TextureNoise>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

float	EBlurAmount
<
	string UIName="Blur:: amount";
	string UIWidget="spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	EBlurRange
<
	string UIName="Blur:: range";
	string UIWidget="spinner";
	float UIMin=0.0;
	float UIMax=1.5;
> = {1.0};

float	ESurfaceLineBluriness
<
	string UIName="Water surface line:: bluriness";
	string UIWidget="spinner";
	float UIMin=0.5;
	float UIMax=2.0;
> = {1.0};



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
//x=generic timer in range 0..1, period of 16777216 ms (4.6 hours), w=frame time elapsed (in seconds)
float4	Timer;
//x=Width, y=1/Width, z=ScreenScaleY, w=1/ScreenScaleY
float4	ScreenSize;

float4	TintColor;


//textures
texture2D	TextureOriginal;
texture2D	TextureColor;
texture2D	TextureDepth;
texture2D	TextureMask; //mask of underwater area of screen

sampler2D SamplerOriginal = sampler_state
{
	Texture   = <TextureOriginal>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerColor = sampler_state
{
	Texture   = <TextureColor>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerDepth = sampler_state
{
	Texture   = <TextureDepth>;
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
	Texture   = <TextureMask>;
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



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST VS_PostProcess(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;

	float4 pos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);

	float2	pixeloffset = ScreenSize.y;
	pixeloffset.y *= ScreenSize.z;
	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy + pixeloffset.xy*0.5;

	return OUT;
}



float4	PS_ProcessBlur(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float4	res;
	float4	color;

	color = tex2D(SamplerColor, IN.txcoord.xy);

	res.xyz = color;
	res.w = 1.0;
	return res;
}



float4	PS_MaskBlur1(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float	offsets[5]=
	{
		-3.5,
		-1.5,
		0.0,
		1.5,
		3.5,
	};

	float4	res;
	float	color;
	float4	centercolor;
	float2	pixeloffset = ScreenSize.y * ESurfaceLineBluriness;
	pixeloffset.y *= ScreenSize.z;

	color = 0.0;
	for (int i=0; i<5; i++)
	{
		float2	coord = offsets[i] * pixeloffset.xy + IN.txcoord.xy;
		color += tex2D(SamplerMask, coord.xy).x;
	}
	color*=0.2;

	res = color; //to alpha
	return res;
}



float4	PS_MaskBlur2(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float	offsets[5]=
	{
		-3.5,
		-1.5,
		0.0,
		1.5,
		3.5,
	};

	float4	res;
	float	color;
	float4	centercolor;
	float2	pixeloffset = ScreenSize.y * ESurfaceLineBluriness;
	pixeloffset.y *= ScreenSize.z;

	color = 0.0;
	for (int i=0; i<5; i++)
	{
		float2	coord = offsets[i] * pixeloffset.xy + IN.txcoord.xy;
		color += tex2D(SamplerColor, coord.xy).w;
	}
	color*=0.2;

	res = color; //to alpha
	res.xyz = tex2D(SamplerOriginal, IN.txcoord.xy);
	return res;
}



float4	PS_Blur(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2	offsets[4]=
	{
		float2(-1.0,-1.0),
		float2(-1.0, 1.0),
		float2( 1.0,-1.0),
		float2( 1.0, 1.0),
	};

	float4	res;
	float4	color;
	float4	centercolor;
	float	depth;
	float	weight;
	float	centerweight;
	float	nearweight;
	float2	pixeloffset = ScreenSize.y * EBlurRange;
	pixeloffset.y *= ScreenSize.z;

	centercolor = tex2D(SamplerColor, IN.txcoord.xy);
	depth = tex2D(SamplerDepth, IN.txcoord.xy).x;

	centerweight = saturate(depth * depth);
	centerweight = 1.000001 - centerweight * centerweight;

	color = centercolor * centerweight;
	weight = centerweight;
	for (int i=0; i<4; i++)
	{
		float	tempdepth;
		float	tempweight;
		float	tempnearweight;
		float2	coord = offsets[i].xy * pixeloffset.xy + IN.txcoord.xy;
		tempdepth = tex2D(SamplerDepth, coord.xy).x;

		tempweight = saturate(tempdepth * tempdepth);
		tempweight = tempweight * tempweight;

		color.xyz += tex2D(SamplerColor, coord.xy) * tempweight;
		weight += tempweight;
	}
	color.xyz /= weight;

	res.xyz = lerp(centercolor.xyz, color.xyz, EBlurAmount);

	res.w = centercolor.w;
	return res;
}



float4	PS_Draw(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float4	res;
	float3	originalcolor;
	float3	color;
	float	mask;
	float2	coord;
	float2	pixeloffset = ScreenSize.y;
	pixeloffset.y *= ScreenSize.z;

	float	blurredmask = tex2D(SamplerColor, IN.txcoord.xy).w;
//	mask = tex2D(SamplerMask, IN.txcoord.xy).x;
	mask = blurredmask;
	coord = IN.txcoord.xy;
	coord.y = frac(Timer.x*1677.7216 * 2.0);
	float	anim = tex2D(SamplerNoise, coord.xy).x;
	anim = anim * 2.0 - 1.0;
	coord = IN.txcoord.xy;
	coord.y -= (1.0-blurredmask) * anim * 0.05;

	originalcolor = tex2D(SamplerOriginal, IN.txcoord.xy);
	color = tex2D(SamplerColor, coord.xy);

	blurredmask = 1.0 - abs(blurredmask * 2.0 - 1.0);

	res.xyz = lerp(originalcolor, color, saturate(blurredmask));
	res.xyz = lerp(res, color, saturate(mask));

	res.w = 1.0;
	return res;
}



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
technique Draw
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_MaskBlur1();
	}
}


technique Draw2
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_MaskBlur2();
	}
}


technique Draw3
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_Blur();
	}
}


technique Draw4
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_Blur();
	}
}


technique Draw5
{
	pass P0
	{
		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_Draw();
	}
}


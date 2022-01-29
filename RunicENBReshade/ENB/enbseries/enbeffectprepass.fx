//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ENBSeries effect file
// visit http://enbdev.com for updates
// Copyright (c) 2007-2011 Boris Vorontsov
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// 0915v2
// edited by gp65cj04
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


//+++++++++++++++++++++++++++++
//internal parameters, can be modified
//+++++++++++++++++++++++++++++

//#define	NOT_BLURRING_SKY_MODE

#define	DEPTH_OF_FIELD_QULITY 1
#define	AUTO_FOCUS
#define TILT_SHIFT
//#define POLYGONAL_BOKEH
//#define	POLYGON_NUM 5

// for auto focus
float2	FocusPoint=float2(0.5, 0.5);
float	FocusSampleRange=1.00;
float	NearBlurCurve=10.00;
float	FarBlurCurve=2.00;
float	DepthClip=10000.0;

// for static dof
float	FocalPlaneDepth=0.0;
float	FarBlurDepth=150.00;

// for tilt shift
float	TiltShiftAngle=30.0;

// common
float	BokehBias=0.00;
float	BokehBiasCurve=0.75;
float	BokehBrightnessThreshold=1.00;
float	BokehBrightnessMultipiler=0.00;
float	RadiusSacleMultipiler=2.50;

// noise grain
float	NoiseAmount=0.0;
float	NoiseCurve=0.0;

float	ChromaticAberrationAmount=0.25;


//+++++++++++++++++++++++++++++
//external parameters, do not modify
//+++++++++++++++++++++++++++++
//keyboard controlled temporary variables (in some versions exists in the config file). Press and hold key 1,2,3...8 together with PageUp or PageDown to modify. By default all set to 1.0
float4 tempF1; //0,1,2,3
float4 tempF2; //5,6,7,8
float4 tempF3; //9,0
//x=Width, y=1/Width, z=ScreenScaleY, w=1/ScreenScaleY
float4 ScreenSize;
//x=generic timer in range 0..1, period of 16777216 ms (4.6 hours), w=frame time elapsed (in seconds)
float4 Timer;
//adaptation delta time for focusing
float FadeFactor;



//textures
texture2D texColor;
texture2D texDepth;
texture2D texNoise;
texture2D texPalette;
texture2D texFocus; //computed focusing depth
texture2D texCurr; //4*4 texture for focusing
texture2D texPrev; //4*4 texture for focusing

sampler2D SamplerColor = sampler_state
{
	Texture   = <texColor>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerDepth = sampler_state
{
	Texture   = <texDepth>;
	MinFilter = POINT;
	MagFilter = POINT;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerNoise = sampler_state
{
	Texture   = <texNoise>;
	MinFilter = POINT;
	MagFilter = POINT;
	MipFilter = NONE;//NONE;
	AddressU  = Wrap;
	AddressV  = Wrap;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerPalette = sampler_state
{
	Texture   = <texPalette>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

//for focus computation
sampler2D SamplerCurr = sampler_state
{
	Texture   = <texCurr>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

//for focus computation
sampler2D SamplerPrev = sampler_state
{
	Texture   = <texPrev>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};
//for dof only in PostProcess techniques
sampler2D SamplerFocus = sampler_state
{
	Texture   = <texFocus>;
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



////////////////////////////////////////////////////////////////////
//begin focusing code
////////////////////////////////////////////////////////////////////
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST VS_Focus(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;

	float4 pos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);

	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;

	return OUT;
}


float linearlizeDepth(float nonlinearDepth)
{
	float2 dofProj=float2(0.0509804, 3098.0392);
	float2 dofDist=float2(0.0, 0.0509804);
		
	float4 depth=nonlinearDepth;
	
	
	depth.y=-dofProj.x + dofProj.y;
	depth.y=1.0/depth.y;
	depth.z=depth.y * dofProj.y; 
	depth.z=depth.z * -dofProj.x; 
	depth.x=dofProj.y * -depth.y + depth.x;
	depth.x=1.0/depth.x;

	depth.y=depth.z * depth.x;

	depth.x=depth.z * depth.x - dofDist.y; 
	depth.x+=dofDist.x * -0.5;

	depth.x=max(depth.x, 0.0);
		
	return depth.x;
}


//SRCpass1X=ScreenWidth;
//SRCpass1Y=ScreenHeight;
//DESTpass2X=4;
//DESTpass2Y=4;
float4 PS_ReadFocus(VS_OUTPUT_POST IN) : COLOR
{

	float2 uvsrc=FocusPoint;

	float2 pixelSize=ScreenSize.y;
	pixelSize.y*=ScreenSize.z;
	
	const float2 offset[4]=
	{
		float2(0.0, 1.0),
		float2(0.0, -1.0),
		float2(1.0, 0.0),
		float2(-1.0, 0.0)
	};

	float res=linearlizeDepth(tex2D(SamplerDepth, uvsrc.xy).x);
	for (int i=0; i<4; i++)
	{
		uvsrc.xy=uvsrc.xy;
		uvsrc.xy+=offset[i] * pixelSize.xy * FocusSampleRange;
		#ifdef NOT_BLURRING_SKY_MODE
			res+=linearlizeDepth(tex2D(SamplerDepth, uvsrc).x);
		#else
			res+=min(linearlizeDepth(tex2D(SamplerDepth, uvsrc).x), DepthClip);
		#endif
	}
	res*=0.2;


	

	return res;
}



//SRCpass1X=4;
//SRCpass1Y=4;
//DESTpass2X=4;
//DESTpass2Y=4;
float4 PS_WriteFocus(VS_OUTPUT_POST IN) : COLOR
{

	float2 uvsrc=FocusPoint;

	float res=0.0;
	float curr=tex2D(SamplerCurr, uvsrc.xy).x;
	float prev=tex2D(SamplerPrev, uvsrc.xy).x;

	
	res=lerp(prev, curr, saturate(FadeFactor));//time elapsed factor

	return res;
}



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


technique ReadFocus
{
	pass P0
	{
		VertexShader = compile vs_3_0 VS_Focus();
		PixelShader  = compile ps_3_0 PS_ReadFocus();

		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}



technique WriteFocus
{
	pass P0
	{
		VertexShader = compile vs_3_0 VS_Focus();
		PixelShader  = compile ps_3_0 PS_WriteFocus();

		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}


////////////////////////////////////////////////////////////////////
//end focusing code
////////////////////////////////////////////////////////////////////



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST VS_PostProcess(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;

	float4 pos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);

	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;

	return OUT;
}



float4 PS_ProcessPass1(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;

	float4 origcolor=tex2D(SamplerColor, coord.xy);
	float scenedepth=tex2D(SamplerDepth, IN.txcoord.xy).x;
	float scenefocus=tex2D(SamplerFocus, 0.5).x;
	res.xyz=origcolor.xyz;

	float depth=linearlizeDepth(scenedepth);


	#ifdef AUTO_FOCUS
		float focalPlaneDepth=scenefocus;
		float farBlurDepth=scenefocus*pow(4.0, FarBlurCurve);
	#else
		float focalPlaneDepth=FocalPlaneDepth;
		float farBlurDepth=FarBlurDepth;
	#endif
	
	#ifdef TILT_SHIFT
		float shiftAngle=(frac(TiltShiftAngle / 90.0) == 0) ? 0.0 : TiltShiftAngle;
		float depthShift=1.0 + (0.5 - coord.x)*tan(-shiftAngle * 0.017453292);
		focalPlaneDepth*=depthShift;
		farBlurDepth*=depthShift;
	#endif
	
	
	if(depth < focalPlaneDepth)
		res.w=(depth - focalPlaneDepth)/focalPlaneDepth;
	else
	{
		res.w=(depth - focalPlaneDepth)/(farBlurDepth - focalPlaneDepth);
		res.w=saturate(res.w);
	}

	res.w=res.w * 0.5 + 0.5;
	
	#ifdef NOT_BLURRING_SKY_MODE
		#define	DEPTH_OF_FIELD_QULITY 0
		res.w=(depth > 1000.0) ? 0.5 : res.w;
	#endif

	
	return res;
}

float4 PS_ProcessPass2(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float4 res;
	
	float2 coord=IN.txcoord.xy;

	float4 origcolor=tex2D(SamplerColor, coord.xy);
	
	float centerDepth=origcolor.w;

	
	float2 pixelSize=ScreenSize.y;
	pixelSize.y*=ScreenSize.z;
	
	float blurAmount=abs(centerDepth * 2.0 - 1.0);
	float discRadius=blurAmount * float(DEPTH_OF_FIELD_QULITY);
	discRadius*=RadiusSacleMultipiler;
	
	#ifdef AUTO_FOCUS
		discRadius*=(centerDepth < 0.5) ? (1.0 / max(NearBlurCurve, 1.0)) : 1.0;
	#endif
	
	
	res.xyz=origcolor.xyz;
	res.w=dot(res.xyz, 0.3333);
	res.w=max((res.w - BokehBrightnessThreshold) * BokehBrightnessMultipiler, 0.0);
	res.xyz*=1.0 + res.w*blurAmount;
	
	res.w=1.0;
	
	int sampleCycle=0;
	int sampleCycleCounter=0;
	int sampleCounterInCycle=0;
	
	#ifdef POLYGONAL_BOKEH
		float basedAngle=360.0 / POLYGON_NUM;
		float2 currentVertex;
		float2 nextVertex;
	
		int	dofTaps=DEPTH_OF_FIELD_QULITY * (DEPTH_OF_FIELD_QULITY + 1) * POLYGON_NUM / 2.0;
	#else
		int	dofTaps=DEPTH_OF_FIELD_QULITY * (DEPTH_OF_FIELD_QULITY + 1) * 4;
	#endif
		
	
	for(int i=0; i < dofTaps; i++)
	{
		if(sampleCounterInCycle % sampleCycle == 0) 
		{
			sampleCounterInCycle=0;
			sampleCycleCounter++;
		
			#ifdef POLYGONAL_BOKEH
				sampleCycle+=POLYGON_NUM;
				currentVertex.xy=float2(1.0 , 0.0);
				sincos(basedAngle* 0.017453292, nextVertex.y, nextVertex.x);	
			#else	
				sampleCycle+=8;
			#endif
		}
		sampleCounterInCycle++;
		
		#ifdef POLYGONAL_BOKEH
			float sampleAngle=basedAngle / float(sampleCycleCounter) * sampleCounterInCycle;
			float remainAngle=frac(sampleAngle / basedAngle) * basedAngle;
		
			if(remainAngle == 0)
			{
				currentVertex=nextVertex;
				sincos((sampleAngle +  basedAngle) * 0.017453292, nextVertex.y, nextVertex.x);
			}

			float2 sampleOffset=lerp(currentVertex.xy, nextVertex.xy, remainAngle / basedAngle);
		#else
			float sampleAngle=0.78539816 / float(sampleCycleCounter) * sampleCounterInCycle;
			float2 sampleOffset;
			sincos(sampleAngle, sampleOffset.y, sampleOffset.x);
		#endif
		
		sampleOffset*=sampleCycleCounter / float(DEPTH_OF_FIELD_QULITY);
		float2  coordLow=coord.xy + (pixelSize.xy * sampleOffset.xy * discRadius);
		float4 tap=tex2D(SamplerColor, coordLow.xy);
		
		float weight=(tap.w >= centerDepth) ? 1.0 : abs(tap.w * 2.0 - 1.0);
		
		float luma=dot(tap.xyz, 0.3333);
		float brightMultipiler=max((luma - BokehBrightnessThreshold) * BokehBrightnessMultipiler, 0.0);
		tap.xyz*=1.0 + brightMultipiler*abs(tap.w*2.0 - 1.0);
		
		tap.xyz*=1.0 + BokehBias * pow(float(sampleCycleCounter)/float(DEPTH_OF_FIELD_QULITY), BokehBiasCurve);
		
	    res.xyz+=tap.xyz * weight;
	    res.w+=weight;
	}

	res.xyz /= res.w;
		
	res.w=centerDepth;


	return res;
}


float4 PS_ProcessPass3(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{	
	float2 coord=IN.txcoord.xy;
	
	float2 pixelSize=ScreenSize.y;
	pixelSize.y*=ScreenSize.z;
	
	float4 origcolor=tex2D(SamplerColor, coord.xy);
	float depth=origcolor.w;
	float blurAmount=abs(depth * 2.0 - 1.0);
	float discRadius=blurAmount * float(DEPTH_OF_FIELD_QULITY) * RadiusSacleMultipiler;
	
	#ifdef AUTO_FOCUS
		discRadius*=(depth < 0.5) ? (1.0 / max(NearBlurCurve, 1.0)) : 1.0;
	#endif
	
	float4 res=origcolor;
	
	float3 distortion=float3(-1.0, 0.0, 1.0);
	distortion*=ChromaticAberrationAmount*discRadius;

	origcolor=tex2D(SamplerColor, coord.xy + pixelSize.xy*distortion.x);
	origcolor.w=smoothstep(0.0, depth, origcolor.w);
	res.x=lerp(res.x, origcolor.x, origcolor.w);
	
	origcolor=tex2D(SamplerColor, coord.xy + pixelSize.xy*distortion.z);
	origcolor.w=smoothstep(0.0, depth, origcolor.w);
	res.z=lerp(res.z, origcolor.z, origcolor.w);

	return res;
}

float4 PS_ProcessPass4(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord=IN.txcoord.xy;
	
	float2 pixelSize=ScreenSize.y;
	pixelSize.y*=ScreenSize.z;
	
	float4 origcolor=tex2D(SamplerColor, coord.xy);
	float depth=origcolor.w;
	float blurAmount=abs(depth*2.0 - 1.0);
	
	#if (DEPTH_OF_FIELD_QULITY > 0)
		#ifdef AUTO_FOCUS
			blurAmount*=(depth < 0.5) ? (1.0 / max(NearBlurCurve, 1.0)) : 1.0;
		#endif
		blurAmount=smoothstep(0.15, 1.0, blurAmount);
	#endif
	
	float weight[5] = {0.2270270270, 0.1945945946, 0.1216216216, 0.0540540541, 
		0.0162162162};
	
	float4 res=origcolor * weight[0];
	
	for(int i=1; i < 5; i++)
	{
		res+=tex2D(SamplerColor, coord.xy + float2(i*pixelSize.x*blurAmount, 0)) * weight[i];
		res+=tex2D(SamplerColor, coord.xy - float2(i*pixelSize.x*blurAmount, 0)) * weight[i];
	}
	
	
	res.w=depth;
	
	return res;
}

float4 PS_ProcessPass5(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord=IN.txcoord.xy;
	
	float2 pixelSize=ScreenSize.y;
	pixelSize.y*=ScreenSize.z;
	
	
	float4 origcolor=tex2D(SamplerColor, coord.xy);
	float depth=origcolor.w;
	float blurAmount=abs(depth*2.0 - 1.0);
	
	#if (DEPTH_OF_FIELD_QULITY > 0)
		#ifdef AUTO_FOCUS
			blurAmount*=(depth < 0.5) ? (1.0 / max(NearBlurCurve, 1.0)) : 1.0;
		#endif
		blurAmount=smoothstep(0.15, 1.0, blurAmount);
	#endif
	
	float weight[5] = {0.2270270270, 0.1945945946, 0.1216216216, 0.0540540541, 
		0.0162162162};
	float4 res=origcolor * weight[0];

	for(int i=1; i < 5; i++)
	{
		res+=tex2D(SamplerColor, coord.xy + float2(0, i*pixelSize.y*blurAmount)) * weight[i];
		res+=tex2D(SamplerColor, coord.xy - float2(0, i*pixelSize.y*blurAmount)) * weight[i];
	}
	
	
	float origgray=dot(res.xyz, 0.3333);
	origgray/=origgray + 1.0;
	coord.xy=IN.txcoord.xy*16.0 + origgray;
	float4 cnoi=tex2D(SamplerNoise, coord);
	float noiseAmount=NoiseAmount*pow(blurAmount, NoiseCurve);
	res=lerp(res, (cnoi.x+0.5)*res, noiseAmount*saturate(1.0-origgray*1.8));
	
	res.w=depth;
	
	
	return res;
}


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
technique PostProcess
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass1();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}


technique PostProcess2
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass2();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}


technique PostProcess3
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass3();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}


technique PostProcess4
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass4();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}

technique PostProcess5
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass5();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}













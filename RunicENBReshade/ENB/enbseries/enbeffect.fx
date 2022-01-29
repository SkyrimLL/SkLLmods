//++++++++++++++++++++++++++++++++++++++++++++
// ENBSeries effect file
// visit http://enbdev.com for updates
// Copyright (c) 2007-2013 Boris Vorontsov
// Nighteye code by scegielski http://www.nexusmods.com/skyrim/mods/50731/?
//++++++++++++++++++++++++++++++++++++++++++++



//+++++++++++++++++++++++++++++
//internal parameters, can be modified
//+++++++++++++++++++++++++++++

//float fLetterboxOffset = 8.0;                      // size of screen to be blacken (in %)
float2 fvTexelSize = float2(1.0 / 1920.0, 1.0 / 1080.0); // Enter you're display resolution here.
//float2 fvTexelSize = float2(1.0 / 3840.0, 1.0 / 2160.0); // Enter you're display resolution here.
 

//////////////////////////////////////////////////////////////////////


bool Section_CF <
   string UIName =  "------Color Filter----------";
> = {false};
bool use_colorhuefx <
   string UIName="Enable Color Filter";
   //Enable - Disable effect
> = {true};
bool use_colorsaturation <
   string UIName="Color Filter: Use Orig. Saturation";
   //The above will use original color saturation as an added limiter to the strength of the effect
> = {false};
float hueMid <
   string UIName="Color Filter: Hue Middle";
   //Set the middle Hue value, which is the most intense represented
   string UIWidget="Spinner";
   float UIMin=0.0;
   float UIMax=1.0;
   float UIStep=0.001;
> = {0.5};
float hueRange <
   string UIName="Color Filter: Hue Range";
   //Set the range to which the Hue should extend in either direction
   string UIWidget="Spinner";
   float UIMin=0.0;
   float UIMax=1.0;
   float UIStep=0.001;
> = {0.2};
float satLimit <
   string UIName="Color Filter: Saturation Limit";
   //Limit the resulting color saturation
   string UIWidget="Spinner";
   float UIMin=0.0;
   float UIMax=1.0;
   float UIStep=0.001;
> = {1.0};
float fxcolorMix <
   string UIName="Color Filter: Effect Strength";
   //Interpolation between the original and the effect
   string UIWidget="Spinner";
   float UIMin=0.0;
   float UIMax=1.0;
   float UIStep=0.001;
> = {1.0};

//////////////////////////////////////////////////////////////////////



bool LetterboxEnable <
	string UIName = "Letterbox Enable (set resolution in enbeffect.fx)";
> = {false};

float	fLetterboxOffset
<
	string UIName="Letterbox Size";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=100.0;
> = {8.0};

// Interior controls

float	AdaptationMinInterior
<
	string UIName="I: Adaptation Min Interior";
	string UIWidget="Spinner";
	float UIMin=0.000;
	float UIMax=1.0;
> = {0.003};

float	AdaptationMaxInterior
<
	string UIName="I: Adaptation Max Interior";
	string UIWidget="Spinner";
	float UIMin=0.000;
	float UIMax=1.0;
> = {0.004};

float	GammaInterior
<
	string UIName="I: Gamma Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=5.0;
> = {1.1};

float	RedFilterInterior
<
	string UIName="I: Filter R Interior";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	GreenFilterInterior
<
	string UIName="I: Filter G Interior";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	BlueFilterInterior
<
	string UIName="I: Filter B Interior";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	DesatRInterior
<
	string UIName="I: Desat R Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	DesatGInterior
<
	string UIName="I: Desat G Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.2};

float	DesatBInterior
<
	string UIName="I: Desat B Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.6};

float	IntensityContrastInterior
<
	string UIName="I: Intensity Contrast Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.3};

float	SaturationInterior
<
	string UIName="I: Saturation Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.3};

float	ToneMappingCurveInterior
<
	string UIName="I: ToneMapping Curve Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.8};

float	ToneMappingOversaturationInterior
<
	string UIName="I: ToneMapping Oversaturation Interior";
	string UIWidget="Spinner";
	float UIMin=0.1;
	float UIMax=999.0;
> = {20.0};

float	BrightnessInterior
<
	string UIName="I: Brightness Interior";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=5.0;
> = {0.15};

//--------------------------------------------------
// Exterior controls
// Day

float	AdaptationMinDay
<
	string UIName="D: Adaptation Min Day";
	string UIWidget="Spinner";
	float UIMin=0.000;
	float UIMax=1.0;
	float UIStep=0.00001;
> = {0.00038};

float	AdaptationMaxDay
<
	string UIName="D: Adaptation Max Day";
	string UIWidget="Spinner";
	float UIStep=0.0001;
	float UIMin=0.000;
	float UIMax=1.0;
> = {0.042};

float	GammaDay
<
	string UIName="D: Gamma Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=5.0;
> = {1.38};

float	RedFilterDay
<
	string UIName="D: Filter R Day";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	GreenFilterDay
<
	string UIName="D: Filter G Day";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	BlueFilterDay
<
	string UIName="D: Filter B Day";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	DesatRDay
<
	string UIName="D: Desat R Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	DesatGDay
<
	string UIName="D: Desat G Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.1};

float	DesatBDay
<
	string UIName="D: Desat B Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.6};

float	IntensityContrastDay
<
	string UIName="D: Intensity Contrast Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.3};

float	SaturationDay
<
	string UIName="D: Saturation Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.7};

float	ToneMappingCurveDay
<
	string UIName="D: ToneMapping Curve Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {2.0};

float	ToneMappingOversaturationDay
<
	string UIName="D: ToneMapping Oversaturation Day";
	string UIWidget="Spinner";
	float UIMin=0.1;
	float UIMax=999.0;
> = {120.0};

float	BrightnessDay
<
	string UIName="D: Brightness Day";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=5.0;
> = {0.15};

//--------------------------------------------------
// Night

float	AdaptationMinNight
<
	string UIName="N: Adaptation Min Night";
	string UIWidget="Spinner";
	float UIStep=0.0001;
	float UIMin=0.000;
	float UIMax=1.0;
> = {0.0016};

float	AdaptationMaxNight
<
	string UIName="N: Adaptation Max Night";
	string UIWidget="Spinner";
	float UIStep=0.0001;
	float UIMin=0.000;
	float UIMax=1.0;
> = {0.0026};

float	GammaNight
<
	string UIName="N: Gamma Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=5.0;
> = {1.25};

float	RedFilterNight
<
	string UIName="N: Filter R Night";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	GreenFilterNight
<
	string UIName="N: Filter G Night";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	BlueFilterNight
<
	string UIName="N: Filter B Night";
	string UIWidget="Spinner";
	float UIStep=0.001;
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	DesatRNight
<
	string UIName="N: Desat R Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {1.0};

float	DesatGNight
<
	string UIName="N: Desat G Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.2};

float	DesatBNight
<
	string UIName="N: Desat B Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=1.0;
> = {0.8};

float	IntensityContrastNight
<
	string UIName="N: Intensity Contrast Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.3};

float	SaturationNight
<
	string UIName="N: Saturation Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {1.3};

float	ToneMappingCurveNight
<
	string UIName="N: ToneMapping Curve Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=10.0;
> = {2.0};

float	ToneMappingOversaturationNight
<
	string UIName="N: ToneMapping Oversaturation Night";
	string UIWidget="Spinner";
	float UIMin=0.1;
	float UIMax=999.0;
> = {12.0};

float	BrightnessNight
<
	string UIName="N: Brightness Night";
	string UIWidget="Spinner";
	float UIMin=0.0;
	float UIMax=5.0;
> = {0.15};



//+++++++++++++++++++++++++++++
//external parameters, do not modify
//+++++++++++++++++++++++++++++
//keyboard controlled temporary variables (in some versions exists in the config file). Press and hold key 1,2,3...8 together with PageUp or PageDown to modify. By default all set to 1.0
float4	tempF1; //0,1,2,3
float4	tempF2; //5,6,7,8
float4	tempF3; //9,0
//x=generic timer in range 0..1, period of 16777216 ms (4.6 hours), w=frame time elapsed (in seconds)
float4	Timer;
//x=Width, y=1/Width, z=ScreenScaleY, w=1/ScreenScaleY
float4	ScreenSize;
//changes in range 0..1, 0 means that night time, 1 - day time
float	ENightDayFactor;
//changes 0 or 1. 0 means that exterior, 1 - interior
float	EInteriorFactor;
//changes in range 0..1, 0 means full quality, 1 lowest dynamic quality (0.33, 0.66 are limits for quality levels)
float	EAdaptiveQualityFactor;
//.x - current weather index, .y - outgoing weather index, .z - weather transition, .w - time of the day in 24 standart hours. Weather index is value from _weatherlist.ini, for example WEATHER002 means index==2, but index==0 means that weather not captured.
float4	WeatherAndTime;
//enb version of bloom applied, ignored if original post processing used
float	EBloomAmount;



texture2D texs0;//color
texture2D texs1;//bloom skyrim
texture2D texs2;//adaptation skyrim
texture2D texs3;//bloom enb
texture2D texs4;//adaptation enb
texture2D texs7;//palette enb

sampler2D _s0 = sampler_state
{
	Texture   = <texs0>;
	MinFilter = POINT;//
	MagFilter = POINT;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s1 = sampler_state
{
	Texture   = <texs1>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s2 = sampler_state
{
	Texture   = <texs2>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s3 = sampler_state
{
	Texture   = <texs3>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s4 = sampler_state
{
	Texture   = <texs4>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s7 = sampler_state
{
	Texture   = <texs7>;
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
	float2 txcoord0 : TEXCOORD0;
};
struct VS_INPUT_POST
{
	float3 pos  : POSITION;
	float2 txcoord0 : TEXCOORD0;
};

//////////////////////////////////////////			
		
	float grayValue(float3 gv)
{
   return dot( gv, float3(0.2125, 0.7154, 0.0721) );
}

float smootherstep(float edge0, float edge1, float x)
{
   x = clamp((x - edge0)/(edge1 - edge0), 0.0, 1.0);
   return x*x*x*(x*(x*6 - 15) + 10);
}

float Hue(float3 color)
{
   float hue = 0.0f;
   float fmin = min(min(color.r, color.g), color.b);
   float fmax = max(max(color.r, color.g), color.b);
   float delta = fmax - fmin;
   
   if (delta == 0.0)
      hue = 0.0;
   else
   {         
      float deltaR = (((fmax - color.r) / 6.0) + (delta / 2.0)) / delta;
      float deltaG = (((fmax - color.g) / 6.0) + (delta / 2.0)) / delta;
      float deltaB = (((fmax - color.b) / 6.0) + (delta / 2.0)) / delta;

      if (color.r == fmax )
         hue = deltaB - deltaG;
      else if (color.g == fmax)
         hue = (1.0 / 3.0) + deltaR - deltaB;
      else if (color.b == fmax)
         hue = (2.0 / 3.0) + deltaG - deltaR;
   }
      
   if (hue < 0.0)
      hue += 1.0f;
   else if (hue > 1.0)
      hue -= 1.0f;
   return hue;
}
////////////////////////////////////////////


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST VS_Quad(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;

	OUT.vpos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);

	OUT.txcoord0.xy=IN.txcoord0.xy;

	return OUT;
}


//skyrim shader specific externals, do not modify
float4	_c1 : register(c1);
float4	_c2 : register(c2);
float4	_c3 : register(c3);
float4	_c4 : register(c4);
float4	_c5 : register(c5);

float4 PS_D6EC7DD1(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float4 _oC0=0.0; //output

	float4 _c6=float4(0, 0, 0, 0);
	float4 _c7=float4(0.212500006, 0.715399981, 0.0720999986, 1.0);

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	float4 r6;
	float4 r7;
	float4 r8;
	float4 r9;
	float4 r10;
	float4 r11;


	float4 _v0=0.0;

	_v0.xy=IN.txcoord0.xy;

	
	
	
		
	


	r1=tex2D(_s0, _v0.xy); //color

	//apply bloom
	float4	xcolorbloom=tex2D(_s3, _v0.xy);

	xcolorbloom.xyz=xcolorbloom-r1;
	xcolorbloom.xyz=max(xcolorbloom, 0.0);
	r1.xyz+=xcolorbloom*EBloomAmount;

	r11=r1; //my bypass
	_oC0.xyz=r1.xyz; //for future use without game color corrections

#ifdef APPLYGAMECOLORCORRECTION
	//apply original
    r0.x=1.0/_c2.y;
    r1=tex2D(_s2, _v0);
    r0.yz=r1.xy * _c1.y;
    r0.w=1.0/r0.y;
    r0.z=r0.w * r0.z;
    r1=tex2D(_s0, _v0);
    r1.xyz=r1 * _c1.y;
    r0.w=dot(_c7.xyz, r1.xyz);
    r1.w=r0.w * r0.z;
    r0.z=r0.z * r0.w + _c7.w;
    r0.z=1.0/r0.z;
    r0.x=r1.w * r0.x + _c7.w;
    r0.x=r0.x * r1.w;
    r0.x=r0.z * r0.x;
    if (r0.w<0) r0.x=_c6.x;
    r0.z=1.0/r0.w;
    r0.z=r0.z * r0.x;
    r0.x=saturate(-r0.x + _c2.x);
//    r2=tex2D(_s3, _v0);//enb bloom
    r2=tex2D(_s1, _v0);//skyrim bloom
    r2.xyz=r2 * _c1.y;
    r2.xyz=r0.x * r2;
    r1.xyz=r1 * r0.z + r2;
    r0.x=dot(r1.xyz, _c7.xyz);
    r1.w=_c7.w;
    r2=lerp(r0.x, r1, _c3.x);
    r1=r0.x * _c4 - r2;
    r1=_c4.w * r1 + r2;
    r1=_c3.w * r1 - r0.y; //khajiit night vision _c3.w
    r0=_c3.z * r1 + r0.y;
    r1=-r0 + _c5;
    _oC0=_c5.w * r1 + r0;

#endif //APPLYGAMECOLORCORRECTION

/*
#ifndef APPLYGAMECOLORCORRECTION
//temporary fix for khajiit night vision, but it also degrade colors.
//	r1=tex2D(_s2, _v0);
//	r0.y=r1.xy * _c1.y;
	r1=_oC0;
	r1.xyz=r1 * _c1.y;
	r0.x=dot(r1.xyz, _c7.xyz);
	r2=lerp(r0.x, r1, _c3.x);
	r1=r0.x * _c4 - r2;
	r1=_c4.w * r1 + r2;
	r1=_c3.w * r1;// - r0.y;
	r0=_c3.z * r1;// + r0.y;
	r1=-r0 + _c5;
	_oC0=_c5.w * r1 + r0;
#endif //!APPLYGAMECOLORCORRECTION
*/

	

	float4 color=_oC0;	

    //adaptation in time
	float4	Adaptation=tex2D(_s4, 0.5);
	float	grayadaptation=max(max(Adaptation.x, Adaptation.y), Adaptation.z);

    float Gamma=lerp(lerp(GammaNight, GammaDay, ENightDayFactor), GammaInterior, EInteriorFactor);
    float RedFilter=lerp(lerp(RedFilterNight, RedFilterDay, ENightDayFactor), RedFilterInterior, EInteriorFactor);
    float GreenFilter=lerp(lerp(GreenFilterNight, GreenFilterDay, ENightDayFactor), GreenFilterInterior, EInteriorFactor);
    float BlueFilter=lerp(lerp(BlueFilterNight, BlueFilterDay, ENightDayFactor), BlueFilterInterior, EInteriorFactor);
	
	float DesatR=lerp(lerp(DesatRNight, DesatRDay, ENightDayFactor), DesatRInterior, EInteriorFactor);
	float DesatG=lerp(lerp(DesatGNight, DesatGDay, ENightDayFactor), DesatGInterior, EInteriorFactor);
	float DesatB=lerp(lerp(DesatBNight, DesatBDay, ENightDayFactor), DesatBInterior, EInteriorFactor);
	
	float AdaptationMin=lerp(lerp(AdaptationMinNight, AdaptationMinDay, ENightDayFactor), AdaptationMinInterior, EInteriorFactor);
	float AdaptationMax=lerp(lerp(AdaptationMaxNight, AdaptationMaxDay, ENightDayFactor), AdaptationMaxInterior, EInteriorFactor);
	
    float Saturation=lerp(lerp(SaturationNight, SaturationDay, ENightDayFactor), SaturationInterior, EInteriorFactor);
	float ToneMappingCurve=lerp(lerp(ToneMappingCurveNight, ToneMappingCurveDay, ENightDayFactor), ToneMappingCurveInterior, EInteriorFactor);
	float ToneMappingOversaturation=lerp(lerp(ToneMappingOversaturationNight, ToneMappingOversaturationDay, ENightDayFactor), ToneMappingOversaturationInterior, EInteriorFactor);
	float IntensityContrast=lerp(lerp(IntensityContrastNight, IntensityContrastDay, ENightDayFactor), IntensityContrastInterior, EInteriorFactor);
	float Brightness=lerp(lerp(BrightnessNight, BrightnessDay, ENightDayFactor), BrightnessInterior, EInteriorFactor);
	
	
	float greyscale = dot(color.xyz, float3(0.3, 0.59, 0.11));
    color.r = lerp(greyscale, color.r, DesatR);
    color.g = lerp(greyscale, color.g, DesatG);
    color.b = lerp(greyscale, color.b, DesatB);	
    	
	color = pow(color, Gamma);
	
	color.r = pow(color.r, RedFilter);
	color.g = pow(color.g, GreenFilter);
	color.b = pow(color.b, BlueFilter);
   
	grayadaptation=max(grayadaptation, 0.0); //0.0
	grayadaptation=min(grayadaptation, 50.0); //50.0
	color.xyz=color.xyz/(grayadaptation*AdaptationMax+AdaptationMin);//*tempF1.x

	color.xyz*=Brightness;
	color.xyz+=0.000001;
	float3 xncol=normalize(color.xyz);
	float3 scl=color.xyz/xncol.xyz;
	scl=pow(scl, IntensityContrast);
	xncol.xyz=pow(xncol.xyz, Saturation);
	color.xyz=scl*xncol.xyz;

	float	lumamax=ToneMappingOversaturation;
	color.xyz=(color.xyz * (1.0 + color.xyz/lumamax))/(color.xyz + ToneMappingCurve);
	
    float Y = dot(color.xyz, float3(0.299, 0.587, 0.114)); //0.299 * R + 0.587 * G + 0.114 * B;
	float U = dot(color.xyz, float3(-0.14713, -0.28886, 0.436)); //-0.14713 * R - 0.28886 * G + 0.436 * B;
	float V = dot(color.xyz, float3(0.615, -0.51499, -0.10001)); //0.615 * R - 0.51499 * G - 0.10001 * B;	
	
	//Y=pow(Y, BrightnessCurve);
	//Y=Y*BrightnessMultiplier;
	//Y=Y/(Y+BrightnessToneMappingCurve);
	//float	desaturatefact=saturate(Y*Y*Y*1.7);
	//U=lerp(U, 0.0, desaturatefact);
	//V=lerp(V, 0.0, desaturatefact);
	//color.xyz=V * float3(1.13983, -0.58060, 0.0) + U * float3(0.0, -0.39465, 2.03211) + Y;
	
	// ADVANCED COLOR FILTER

if ( use_colorhuefx == true )
{
   float3 fxcolor = saturate( color.xyz );
   float greyVal = grayValue( fxcolor.xyz );
   float colorHue = Hue( fxcolor.xyz );
   
   float colorSat = 0.0f;
   float minColor = min( min ( fxcolor.x, fxcolor.y ), fxcolor.z );
   float maxColor = max( max ( fxcolor.x, fxcolor.y ), fxcolor.z );
   float colorDelta = maxColor - minColor;
   float colorInt = ( maxColor + minColor ) * 0.5f;
   
   if ( colorDelta != 0.0f )
   {
      if ( colorInt < 0.5f )
         colorSat = colorDelta / ( maxColor + minColor );
      else
         colorSat = colorDelta / ( 2.0f - maxColor - minColor );
   }
   
   //When color intensity not based on original saturation level
   if ( use_colorsaturation == false )
      colorSat = 1.0f;
   
   float hueMin_1 = 0.0f;
   float hueMin_2 = 0.0f;
   float hueMax_1 = 0.0f;
   float hueMax_2 = 0.0f;
   
   if ( hueRange > hueMid )
   {
      hueMin_1 = hueMid - hueRange;
      hueMin_2 = 1.0f + hueMid - hueRange;
      hueMax_1 = hueMid + hueRange;
      hueMax_2 = 1.0f + hueMid;
   
      if ( colorHue >= hueMin_1 && colorHue <= hueMid )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, smootherstep( hueMin_1, hueMid, colorHue ) * ( colorSat * satLimit ));
      else if ( colorHue > hueMid && colorHue <= hueMax_1 )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, ( 1.0f - smootherstep( hueMid, hueMax_1, colorHue )) * ( colorSat * satLimit ));
      else if ( colorHue >= hueMin_2 && colorHue <= hueMax_2 )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, smootherstep( hueMin_2, hueMax_2, colorHue ) * ( colorSat * satLimit ));
      else
         fxcolor.xyz = greyVal.xxx;
   
   }
   else if ( hueMid + hueRange > 1.0f )
   {
      hueMin_1 = hueMid - hueRange;
      hueMin_2 = 0.0f - ( 1.0f - hueMid );
      hueMax_1 = hueMid + hueRange;
      hueMax_2 = hueMid + hueRange - 1.0f;
   
      if ( colorHue >= hueMin_1 && colorHue <= hueMid )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, smootherstep( hueMin_1, hueMid, colorHue ) * ( colorSat * satLimit ));
      else if ( colorHue > hueMid && colorHue <= hueMax_1 )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, ( 1.0f - smootherstep( hueMid, hueMax_1, colorHue )) * ( colorSat * satLimit ));
      else if ( colorHue >= hueMin_2 && colorHue <= hueMax_2 )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, smootherstep( hueMin_2, hueMax_2, colorHue) * ( colorSat * satLimit ));
      else
         fxcolor.xyz = greyVal.xxx;
      
   }
   else
   {
      hueMin_1 = hueMid - hueRange;
      hueMax_1 = hueMid + hueRange;
      
      if ( colorHue >= hueMin_1 && colorHue <= hueMid )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, smootherstep( hueMin_1, hueMid, colorHue ) * ( colorSat * satLimit ));
      else if ( colorHue > hueMid && colorHue <= hueMax_1 )
         fxcolor.xyz = lerp( greyVal.xxx, fxcolor.xyz, ( 1.0f - smootherstep( hueMid, hueMax_1, colorHue )) * ( colorSat * satLimit ));
      else
         fxcolor.xyz = greyVal.xxx;
   
   }
   color.xyz = lerp( color.xyz, fxcolor.xyz, fxcolorMix );
}
		

	//color.xyz=max(color.xyz, 0.0);
	//color.xyz=color.xyz/(color.xyz+newEBrightnessToneMappingCurveV2);


//color.xyz=tex2D(_s0, _v0.xy) + xcolorbloom.xyz*float3(0.7, 0.6, 1.0)*0.5;
//color.xyz=tex2D(_s0, _v0.xy) + xcolorbloom.xyz*float3(0.7, 0.6, 1.0)*0.5;
//color.xyz*=0.7;


	//pallete texture (0.082+ version feature)
#ifdef E_CC_PALETTE   
	color.rgb=saturate(color.rgb);
	float3	brightness=Adaptation.xyz;//tex2D(_s4, 0.5);//adaptation luminance
//	brightness=saturate(brightness);//old version from ldr games
	brightness=(brightness/(brightness+1.0));//new version
	brightness=max(brightness.x, max(brightness.y, brightness.z));//new version
	float3	palette;
	float4	uvsrc=0.0;
	uvsrc.y=brightness.r;
	uvsrc.x=color.r;
	palette.r=tex2Dlod(_s7, uvsrc).r;
	uvsrc.x=color.g;
	uvsrc.y=brightness.g;
	palette.g=tex2Dlod(_s7, uvsrc).g;
	uvsrc.x=color.b;
	uvsrc.y=brightness.b;
	palette.b=tex2Dlod(_s7, uvsrc).b;
	color.rgb=palette.rgb;
#endif //E_CC_PALETTE



#ifdef E_CC_PROCEDURAL
	float	tempgray;
	float4	tempvar;
	float3	tempcolor;
/*
	//these replaced by "levels"
	//+++ gamma
	if (ECCGamma!=1.0)
	color=pow(color, 1.0/ECCGamma);

	//+++ brightness like in photoshop
	color=color+ECCAditiveBrightness;

	//+++ lightness
	tempvar.x=saturate(ELightness);
	tempvar.y=saturate(1.0+ECCLightness);
	color=tempvar.x*(1.0-color) + (tempvar.y*color);
*/
	//+++ levels like in photoshop, including gamma, lightness, additive brightness
	color=max(color-ECCInBlack, 0.0) / max(ECCInWhite-ECCInBlack, 0.0001);
	if (ECCGamma!=1.0) color=pow(color, ECCGamma);
	color=color*(ECCOutWhite-ECCOutBlack) + ECCOutBlack;

	//+++ brightness
	color=color*ECCBrightness;

	//+++ contrast
	color=(color-ECCContrastGrayLevel) * ECCContrast + ECCContrastGrayLevel;

	//+++ saturation
	tempgray=dot(color, 0.3333);
	color=lerp(tempgray, color, ECCSaturation);

	//+++ desaturate shadows
	tempgray=dot(color, 0.3333);
	tempvar.x=saturate(1.0-tempgray);
	tempvar.x*=tempvar.x;
	tempvar.x*=tempvar.x;
	color=lerp(color, tempgray, ECCDesaturateShadows*tempvar.x);

	//+++ color balance
	color=saturate(color);
	tempgray=dot(color, 0.3333);
	float2	shadow_highlight=float2(1.0-tempgray, tempgray);
	shadow_highlight*=shadow_highlight;
	color.rgb+=(ECCColorBalanceHighlights*2.0-1.0)*color * shadow_highlight.x;
	color.rgb+=(ECCColorBalanceShadows*2.0-1.0)*(1.0-color) * shadow_highlight.y;

	//+++ channel mixer
	tempcolor=color;
	color.r=dot(tempcolor, ECCChannelMixerR);
	color.g=dot(tempcolor, ECCChannelMixerG);
	color.b=dot(tempcolor, ECCChannelMixerB);
#endif //E_CC_PROCEDURAL

		


	_oC0.w=1.0;
	_oC0.xyz=color.xyz;
	
if (LetterboxEnable)
 {
   float offset = fLetterboxOffset * 0.01;
   float2 sspos = fvTexelSize * vPos;
   if (sspos.y <= offset || sspos.y >= (1.0 - offset)) _oC0.rgb = 0.0;
 }

	return _oC0;	
}



//switch between vanilla and mine post processing
technique Shader_D6EC7DD1 <string UIName="ENBSeries";>
{
	pass p0
	{
		VertexShader  = compile vs_3_0 VS_Quad();
		PixelShader  = compile ps_3_0 PS_D6EC7DD1();

		ColorWriteEnable=ALPHA|RED|GREEN|BLUE;
		ZEnable=FALSE;
		ZWriteEnable=FALSE;
		CullMode=NONE;
		AlphaTestEnable=FALSE;
		AlphaBlendEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}



//original shader of post processing
technique Shader_ORIGINALPOSTPROCESS <string UIName="Vanilla";>
{
	pass p0
	{
		VertexShader  = compile vs_3_0 VS_Quad();
		PixelShader=
	asm
	{
// Parameters:
//   sampler2D Avg;
//   sampler2D Blend;
//   float4 Cinematic;
//   float4 ColorRange;
//   float4 Fade;
//   sampler2D Image;
//   float4 Param;
//   float4 Tint;
// Registers:
//   Name         Reg   Size
//   ------------ ----- ----
//   ColorRange   c1       1
//   Param        c2       1
//   Cinematic    c3       1
//   Tint         c4       1
//   Fade         c5       1
//   Image        s0       1
//   Blend        s1       1
//   Avg          s2       1
//s0 bloom result
//s1 color
//s2 is average color

    ps_3_0
    def c6, 0, 0, 0, 0
    //was c0 originally
    def c7, 0.212500006, 0.715399981, 0.0720999986, 1
    dcl_texcoord v0.xy
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    rcp r0.x, c2.y
    texld r1, v0, s2
    mul r0.yz, r1.xxyw, c1.y
    rcp r0.w, r0.y
    mul r0.z, r0.w, r0.z
    texld r1, v0, s1
    mul r1.xyz, r1, c1.y
    dp3 r0.w, c7, r1
    mul r1.w, r0.w, r0.z
    mad r0.z, r0.z, r0.w, c7.w
    rcp r0.z, r0.z
    mad r0.x, r1.w, r0.x, c7.w
    mul r0.x, r0.x, r1.w
    mul r0.x, r0.z, r0.x
    cmp r0.x, -r0.w, c6.x, r0.x
    rcp r0.z, r0.w
    mul r0.z, r0.z, r0.x
    add_sat r0.x, -r0.x, c2.x
    texld r2, v0, s0
    mul r2.xyz, r2, c1.y
    mul r2.xyz, r0.x, r2
    mad r1.xyz, r1, r0.z, r2
    dp3 r0.x, r1, c7
    mov r1.w, c7.w
    lrp r2, c3.x, r1, r0.x
    mad r1, r0.x, c4, -r2
    mad r1, c4.w, r1, r2
    mad r1, c3.w, r1, -r0.y
    mad r0, c3.z, r1, r0.y
    add r1, -r0, c5
    mad oC0, c5.w, r1, r0
	};
		ColorWriteEnable=ALPHA|RED|GREEN|BLUE;
		ZEnable=FALSE;
		ZWriteEnable=FALSE;
		CullMode=NONE;
		AlphaTestEnable=FALSE;
		AlphaBlendEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
    }
}


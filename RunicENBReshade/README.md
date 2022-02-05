This is my personal set up for [ENB](http://enbdev.com/download_mod_tesskyrim.htm) and [ReShade](https://reshade.me/) for Skyrim.

I put it on GitHub more as a backup than to share it, but if anyone wants to use it, go ahead.
It hasn't been really tested yet so I can't promise it will work, but I am happy with the results so far.

I have been developing it to give Skyrim a rougher, grimier look. The atmosphere I have in mind is that of **Hellblade**, **Vikings**, **Heilung** and nicely summarized by [this unofficial video](https://www.youtube.com/watch?v=y6Yahh_I7IE&ab_channel=LITVINOV) .

I started with a combination of these two ENB setups as a base, but I deviated enough from either of them to start calling this setup my own.
It provides a fast Depth of Field effect for distant landscapes, a weather based configuration on top of global settings, and a good balance between a desaturated atmosphere in rainy weather and a colorful one in sunny weather.

- [VandB ENB Nature](https://href.li/?https://www.nexusmods.com/skyrim/mods/65584?tab=posts)
- [Rudy ENB](https://href.li/?https://www.nexusmods.com/skyrim/mods/41482)

The ReShade layer is there to add touches I wasn't able to accomplish with the ENB layer (tilt shift effect on the edges, a better HDR glow, a more balanced saturation control and sharpness effect, and a cinematic color grading).

## Q: How to set up both ENB and ReShade with Skyrim

A: ReShade and ENB have a tendency to overwrite each other's libraries, so you have to install them in waves.

1. Install ReShade first and rename d3d9.dll to something else, like: dxgreshade.dll

2. Install ENB. It will come with its own version of d3d9.dll

3. Edit this configuration in enblocal.ini to tell ENB to use a secondary graphic layer.

   ```
   [PROXY]
   EnableProxyLibrary=true
   InitProxyFunctions=false
   ProxyLibrary=dxgreshade.dll
   ```

   That's it. Now you should be the proud owner of both an ENB and ReShade layers.



## Q: Configuration

A: The base ENB configuration I used (VandB ENB Nature) doesn't have a built-in slider for the cinematic bars. You have to configure them in the enbeffect.fx file based on your screen resolution.

```
float2 fvTexelSize = float2(1.0 / 3840.0, 1.0 / 2160.0); // Enter you're display resolution here.
```

I suppose you can set it to 0.0 to get rid of the bars if you don't want them.

I left the Bloom effect from ENB turned off because the HDR Bloom effect from ReShade is so much better.

Same with AntiAliasing.. I used a filter in ReShade that gave me better results.

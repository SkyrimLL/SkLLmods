Scriptname FT_fctSeasons extends Quest  

Weather Property LightRain Auto
Weather Property HeavyRain Auto
Weather Property Cloudy Auto
Weather Property CloudyDark Auto
Weather Property CloudyFall Auto
Weather Property TundraSun Auto
Weather Property TundraCloudy Auto
Weather Property Fog Auto
Weather Property HeavyFog Auto
Weather Property SnowFall Auto
Weather Property SnowStorm Auto

;/
:: For each season, pick a preferred weather type and add a chance of transition to that weather with OnLocationChange
Spring -  LightRain / HeavyRain / Cloudy
Summer -  TundraSun
Fall - HeavyFog / LightRain / HeavyRain / Cloudy
Winter - SnowFall / SnowStorm / Fog
https://www.creationkit.com/index.php?search=weather&title=Special%3ASearch&fulltext=Search

Reference - https://girlplaysgame.com/2015/08/12/skyrim-ultimate-weather-guide-and-console-commands/
/;

Function updateWeather(Int iSeason, Int iPercentSeason)
	Int iRandomNum = utility.RandomInt(0,100)
	; Weather currentWeather = Weather.GetCurrentWeather()

	if (iSeason == 0)
		; Spring -  LightRain / HeavyRain / Cloudy
		if (iRandomNum>60) && ( (iPercentSeason<=25) || (iPercentSeason>=75))
			debug.notification("(Spring Overcast)")
			Cloudy.SetActive(true)
		elseif (iRandomNum>80)
			debug.notification("(Spring Heavy Rain)")
			HeavyRain.SetActive(true)
		elseif (iRandomNum>60)
			debug.notification("(Spring Light Rain)")
			LightRain.SetActive(true)
		else
			debug.notification("(Spring Showers)")
			CloudyDark.SetActive(true)
		endif

	elseif (iSeason == 1)
		; Summer -  TundraSun
		if (iRandomNum>60) && ( (iPercentSeason<=25) || (iPercentSeason>=75))
			debug.notification("(Summer Overcast)")
			Cloudy.SetActive(true)
		elseif (iRandomNum>80)
			debug.notification("(Summer Cloudy)")
			TundraCloudy.SetActive(true)
		else
			debug.notification("(Summer Tundra Sun)")
			TundraSun.SetActive(true)
		endif

	elseif (iSeason == 2)
		; Fall - HeavyFog / LightRain / HeavyRain / Cloudy
		if (iRandomNum>60) && ( (iPercentSeason<=25) || (iPercentSeason>=75))
			debug.notification("(Fall Overcast)")
			Cloudy.SetActive(true)
		elseif (iRandomNum>80)
			debug.notification("(Fall Heavy Rain)")
			HeavyRain.SetActive(true)
		elseif (iRandomNum>60)
			debug.notification("(Fall Light Rain)")
			LightRain.SetActive(true)
		elseif (iRandomNum>40)
			debug.notification("(Fall Heavy Fog)")
			HeavyFog.SetActive(true)
		else
			debug.notification("(Fall Cloudy)")
			CloudyFall.SetActive(true)
		endif

	elseif (iSeason == 3)
		; Winter - SnowFall / SnowStorm / Fog
		if (iRandomNum>60) && ( (iPercentSeason<=25) || (iPercentSeason>=75))
			debug.notification("(Winter Overcast)")
			Cloudy.SetActive(true)
		elseif (iRandomNum>80)
			debug.notification("(Winter Snow Storm)")
			SnowStorm.SetActive(true)
		elseif (iRandomNum>60)
			debug.notification("(Winter Snow Fall)")
			SnowFall.SetActive(true)
		else
			debug.notification("(Winter Fog)")
			Fog.SetActive(true)
		endif
	endif

	; BadWeather.SetActive(true)

EndFunction
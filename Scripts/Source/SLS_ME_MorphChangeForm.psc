Scriptname SLS_ME_MorphChangeForm extends activemagiceffect  

SLS_QST_PolyMorph Property polymorphQuest auto

actor crea
GlobalVariable Property ismorph  Auto  
actor caster
ReferenceAlias Property morph  Auto  
Explosion Property e  Auto  
ImageSpaceModifier Property im  Auto
Faction Property PlayerFaction  Auto  
Perk Property aaanofalldamage  Auto  
Perk Property aaanodetection  Auto  

event OnEffectStart(Actor t, Actor c)
	im.Apply()

	if ismorph.getvalue() == 0
		c.SetPlayerControls(false)
		c.setunconscious(true)
		utility.SetInibool("bDisableHeadTracking:HeadTracking",true)
		caster = c
		Game.disableplayercontrols(false,false,false,false,false,true,true,false,0)

		if (morphType  == 0)
			crea = c.PlaceAtMe(polymorphQuest.abMorph) as actor
		elseif (morphType  == 1)
			crea = c.PlaceAtMe(polymorphQuest.abBimbo) as actor
		elseif (morphType  == 2)
			crea = c.PlaceAtMe(polymorphQuest.abRedguardF) as actor
		elseif (morphType  == 3)
			crea = c.PlaceAtMe(polymorphQuest.abRedguardM) as actor
		endif

		crea.SetPlayerTeammate()
		crea.SetAlpha(0)	
		if c.IsSneaking()
		else
			crea.SetAV("Aggression", 1)
			crea.SetAV("Confidence", 4)
			crea.SetAV("Assistance", 2)
		endif
		crea.modAV("health", c.getAV("health"))
		crea.SetPlayerControls(true)
		c.setunconscious(false)
		;utility.wait(1)
		crea.moveto(c)
		Game.SetCameraTarget(crea)
		RegisterForUpdate(1)
		morph.ForceRefTo(crea)
		crea.PlaceAtMe(e)
		c.SetAlpha(0)
		crea.SetAlpha(1)
		crea.EnableAI()
		ismorph.setvalue(1)
		utility.SetIniBool("bDisablePlayerCollision:Havok",true)
		caster.TranslateTo(crea.GetPositionx(), crea.GetPositiony(), crea.GetPositionZ()+4000, crea.getanglex(),crea.getangley(),crea.getanglez(), 100000, 0)
		if c.IsSneaking()
			crea.SetPlayerTeammate(false)
		endif
		c.addperk(aaanofalldamage)
		c.addperk(aaanodetection)
		utility.wait(9)
		utility.SetInibool("bDisableHeadTracking:HeadTracking",false)
	else
		Game.disableplayercontrols(true,false,false,false,false,true,true,false,0)
		crea = morph.GetActorReference()
		c.SetPlayerControls(true)
		ismorph.setvalue(0)
		;utility.wait(1)
		c.setangle(crea.getanglex(),crea.getangley(),crea.getanglez())
		crea.PlaceAtMe(e)
		crea.SetAlpha(0)
		c.TranslateToRef(crea, 1000000, 0)
		Game.SetCameraTarget(c)
		c.SetAlpha(1)
		c.EnableAI()
		utility.SetIniBool("bDisablePlayerCollision:Havok",false)
		Game.enableplayercontrols()
		c.removeperk(aaanofalldamage)
		c.removeperk(aaanodetection)
		;utility.wait(1)
		crea.disable()
		crea.delete()
	endif
endevent

Event OnUpdate()
	float do
	caster.TranslateTo(crea.GetPositionx(), crea.GetPositiony(), crea.GetPositionZ()+4000, crea.getanglex(),crea.getangley(),crea.getanglez(), 100000, 0)
	if crea.isdead() 
		caster.TranslateToRef(crea, 1000000, 0)
		caster.SetPlayerControls(true)
		utility.SetIniBool("bDisablePlayerCollision:Havok",false)
		Game.enableplayercontrols()
		caster.EnableAI()
		utility.wait(3)
		caster.kill(caster)
	endif
EndEvent  

Int Property morphType  Auto  

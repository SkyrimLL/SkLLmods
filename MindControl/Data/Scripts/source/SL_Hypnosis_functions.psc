Scriptname SL_Hypnosis_functions extends Quest  

SexLabFramework Property SexLab  Auto  
Faction Property undressedFaction Auto
Outfit Property nakedOutfit Auto

function Undress(Actor target)
	Debug.Trace("[SLhypno] Undressing NPC")
	if(!target)
		return
	endif

	; if(!IsDressed(target))
	;	Debug.Trace("[SLhypno] NPC already undressed")
	;	return
	; endif

	Debug.Trace("[SLhypno] Removing NPC clothes")
	target.AddToFaction(undressedFaction)
	SexLab.ActorLib.StripActor(target, Doanimate = false)
endfunction

function UndressClear(Actor target)
	if(!target)
		return
	endif
	target.SetOutfit(nakedOutfit)
endfunction

function Dress(Actor target)
	if(!target || target.IsDisabled() || target.IsDead())
		return
	endif

	if(target.IsInFaction(undressedFaction))
		target.RemoveFromFaction(undressedFaction)
	endif

	int wearMask = 0
	int i = 0
	while(i < 32)
		int j = Math.LeftShift(1, i)
		if(target.GetWornForm(j))
			wearMask = Math.LogicalOr(wearMask, j)
		endif
		i += 1
	endwhile
	int itemCount = target.GetNumItems()
	i = itemCount - 1
	Weapon bestWeapon = none
	int bestDamage = 0
	while(i >= 0)
		Form curItem = target.GetNthForm(i)
		if(curItem)
			Armor curArmor = curItem as Armor
			if(curArmor)
				int slotMask = curArmor.GetSlotMask()
				if(Math.LogicalAnd(wearMask, slotMask) == 0)
					wearMask = Math.LogicalOr(wearMask, slotMask)
					target.EquipItem(curItem)
				endif
			else
				Weapon curWeapon = curItem as Weapon
				if(curWeapon)
					int dmg = curWeapon.GetBaseDamage()
					if(dmg > bestDamage)
						bestWeapon = curWeapon
						bestDamage = dmg
					endif
				endif
			endif
		endif
		i -= 1
	endwhile

	if(bestWeapon)
		target.EquipItem(bestWeapon)
	endif
endfunction

bool function IsDressed(Actor target)
	if(!target)
		return true
	endif

	return !target.IsInFaction(undressedFaction)
endfunction
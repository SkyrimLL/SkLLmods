;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Hypnosis_TIF_GiftDom Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int randomNum = Utility.RandomInt(0,100)

If (randomNum > 95)

	Actor _bandit = akSpeaker
	Actor _target = SexLab.PlayerRef 
	int   itemCount
	int   idx
	int   stolenCnt
	int   itemType
	int   cnt
	int   ii
	int   goldVal
	Float itemWeight
	Form  nthItem = None
	Bool  canSteal
	
	itemCount = _target.getNumItems()
	stolenCnt = 0
	while idx < itemCount && stolenCnt < 1
		nthItem = _target.getNthForm(idx)
		if !nthItem
			; _notify("SLU: Null item")
			Return
		endif
	
		canSteal = False
			
		itemType = nthItem.GetType()
		if (itemType == 45) || (itemType == 26) || \
		   (itemType == 41) || (itemType == 30) || \
		   (itemType == 46) || (itemType == 27) || \
		   (itemType == 42) || (itemType == 32)
			canSteal = True
		EndIf
		
		if canSteal && _bandit != SexLab.PlayerRef  && (nthItem.HasKeywordString("VendorNoSale") || nthItem.HasKeywordString("MagicDisallowEnchanting"))
			canSteal = False
			; _notify("Pick: !Q " + nthItem.GetName())
		endif
		
		if canSteal
			cnt = _target.GetItemCount(nthItem)
			goldVal = nthItem.GetGoldValue()
			itemWeight = nthItem.GetWeight()
			
			if (goldVal >= 0)
				if cnt > 1 && goldVal > 0
					ii = Math.Floor(100 / goldVal)
					if ii < cnt
						cnt = ii
					endif
				endif
				
				if cnt > 0
					; Debug.Notification("Pick: " + actorName(_bandit) + " " + actorName(_target))
					Debug.Notification("I like this! [Takes " + cnt + "x " + nthItem.GetName() + " ]")
					_target.RemoveItem(nthItem, cnt, true, _bandit)
					stolenCnt += 1
				endif
			endif
		endif
		
		idx += 1
	endWhile

	Debug.Notification("You don't need that much money either.")
	cnt = _target.GetItemCount(Gold001)
	_target.RemoveItem(Gold001, cnt/2, true, _bandit)

ElseIf (randomNum > 20)
      Debug.Notification( "Here.. indulge yourself." )

	LoveInterest.GiveGold()
; ElseIf (randomNum > 15)
      ; Debug.Notification( "I found this and saved it for you." )

	; Game.GetPlayer().AddItem(RareLoot)
Else
	Debug.Notification( "Here... I prepared this just for you." )

	Game.GetPlayer().AddItem(DruggedDrink)
	Game.GetPlayer().EquipItem(Skooma)
	; Debug.Notification( "[Looks at you and shrugs]" )

EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

LeveledItem Property DruggedDrink  Auto  

Potion Property Skooma  Auto  

SL_Hypnosis_VictimAlias Property LoveInterest  Auto  

MiscObject Property Gold001  Auto  

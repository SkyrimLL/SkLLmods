Scriptname SLS_DoomStoneAlias extends ReferenceAlias  

; //which stone are we
BOOL PROPERTY bApprentice AUTO
BOOL PROPERTY bAtronach AUTO
BOOL PROPERTY bLady AUTO
BOOL PROPERTY bLord AUTO
BOOL PROPERTY bLover AUTO
BOOL PROPERTY bMage AUTO
BOOL PROPERTY bRitual AUTO
BOOL PROPERTY bSerpent AUTO
BOOL PROPERTY bShadow AUTO
BOOL PROPERTY bSteed AUTO
BOOL PROPERTY bThief AUTO
BOOL PROPERTY bTower AUTO
BOOL PROPERTY bWarrior AUTO

;  0- No fetish
;  1- The Apprentice Stone - Craft / Hitting / Dom
;  2- The Atronach Stone - Killing monsters
;  3- The Lady Stone - Wearing Jewelry
;  4- The Lord Stone - Wearing Armor
;  5- The Lover Stone - Being Nude / Sex
;  6- The Mage Stone - Using magic
;  7- The Ritual Stone - Specific NPC / spouse
;  8- The Serpent Stone - Killing animals
;  9- The Shadow Stone - Killing humans
; 10- The Steed Stone - Bestiality
; 11- The Thief Stone - Stealing
; 12- The Tower Stone - Wearing leather / being hit / sub
; 13- The Warrior Stone - Using weapons

Event OnActivate(ObjectReference akActionRef)
	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()

	if (StorageUtil.GetIntValue(akActor, "_SLS_toggleFetish" ) == 0)
		Return
	Endif

	;  0- No fetish
	int currentFetishID = _SLS_FetishID.GetValue() as Int

	if ( bApprentice)
		;  1- The Apprentice Stone
		If (_SLS_FetishID.GetValue() == 1)
			_SLS_FetishID.SetValue(0)
		Else
  			_SLS_FetishID.SetValue(1)
  		EndIf

	ElseIf ( bAtronach)
		;  2- The Atronach Stone
		If (_SLS_FetishID.GetValue() == 2)
			_SLS_FetishID.SetValue(0)
		Else
  			_SLS_FetishID.SetValue(2)
  		EndIf
	ElseIf ( bLady)
		;  3- The Lady Stone
		If (_SLS_FetishID.GetValue() == 3)
			_SLS_FetishID.SetValue(0)
		Else
  			_SLS_FetishID.SetValue(3)
  		EndIf

	ElseIf ( bLord)
		;  4- The Lord Stone
		If (_SLS_FetishID.GetValue() == 4)
			_SLS_FetishID.SetValue(0)
		Else
  			_SLS_FetishID.SetValue(4)
  		EndIf

	ElseIf ( bLover)
		;  5- The Lover Stone
		If (_SLS_FetishID.GetValue() == 5)
			_SLS_FetishID.SetValue(0)
		Else
  			_SLS_FetishID.SetValue(5)
  		EndIf
	ElseIf ( bMage)
		;  6- The Mage Stone
		If (_SLS_FetishID.GetValue() == 6)
			_SLS_FetishID.SetValue(0)
		Else
  			_SLS_FetishID.SetValue(6)
  		EndIf
	ElseIf ( bRitual)
		;  7- The Ritual Stone
		If (_SLS_FetishID.GetValue() == 7)
			_SLS_FetishID.SetValue(0)
		Else
  			_SLS_FetishID.SetValue(7)
  		EndIf
	ElseIf ( bSerpent)
		;  8- The Serpent Stone
		If (_SLS_FetishID.GetValue() == 8)
			_SLS_FetishID.SetValue(0)
		Else
  			_SLS_FetishID.SetValue(8)
  		EndIf
	ElseIf ( bShadow )
		;  9- The Shadow Stone
 		If (_SLS_FetishID.GetValue() == 9)
			_SLS_FetishID.SetValue(0)
		Else
  			_SLS_FetishID.SetValue(9)
  		EndIf

	ElseIf ( bSteed)
		; 10- The Steed Stone
		If (_SLS_FetishID.GetValue() == 10)
			_SLS_FetishID.SetValue(0)
		Else
  			_SLS_FetishID.SetValue(10)
  		EndIf
	ElseIf ( bThief)
		; 11- The Thief Stone
		If (_SLS_FetishID.GetValue() == 11)
			_SLS_FetishID.SetValue(0)
		Else
  			_SLS_FetishID.SetValue(11)
  		EndIf
	ElseIf ( bTower)
		; 12- The Tower Stone
		If (_SLS_FetishID.GetValue() == 12)
			_SLS_FetishID.SetValue(0)
		Else
  			_SLS_FetishID.SetValue(12)
  		EndIf
	ElseIf ( bWarrior)
		; 13- The Warrior Stone
		If (_SLS_FetishID.GetValue() == 13)
			_SLS_FetishID.SetValue(0)
		Else
  			_SLS_FetishID.SetValue(13)
  		EndIf
	EndIf

	_SLS_doomStoneFetish.SetObjectiveDisplayed(_SLS_FetishID.GetValue() as Int, True, True) 
	StorageUtil.SetIntValue(akActor, "_SLS_fetishID", _SLS_FetishID.GetValue() as Int )
  	Debug.Trace("New fetish: " + _SLS_FetishID.GetValue() )

	If (_SLS_FetishID.GetValue() > 0)
		_SLS_doomStoneFetish.SetObjectiveDisplayed(_SLS_FetishID.GetValue() as Int, False, True) 
	ElseIf (_SLS_FetishID.GetValue() == 0)
		_SLS_doomStoneFetish.SetObjectiveDisplayed(_SLS_FetishID.GetValue() as Int, False, False) 
	EndIf

EndEvent

GlobalVariable Property _SLS_FetishID  Auto  
Quest Property _SLS_doomStoneFetish Auto

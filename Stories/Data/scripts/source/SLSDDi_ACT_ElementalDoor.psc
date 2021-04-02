Scriptname SLSDDi_ACT_ElementalDoor extends ObjectReference  

import Utility

EffectShader Property FrostIceFormFXShader02  Auto  
keyword property magicDamageFire auto
explosion property crExplosionFrostSM auto

Quest Property _SLSDDi_QST_DivineCheese Auto

EVENT onLoad()
	FrostIceFormFXShader02.play(self)
	gotostate("active")
endEVENT

STATE active
	EVENT OnTrigger(ObjectReference akCaster)
		if (_SLSDDi_QST_DivineCheese.GetStageDone(528)==1)
			gotoState("inactive")
			wait(0.1)
			placeAtMe(crExplosionFrostSM)
			getLinkedRef().disable(true)
			wait(0.15)
			FrostIceFormFXShader02.stop(self)	
			playAnimation("Open")
		endif
	endEVENT
endSTATE

STATE inactive
	;  nothing here
endSTATE

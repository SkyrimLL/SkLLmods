Scriptname SLH_ME_Undress extends activemagiceffect  

SexLabFramework Property SexLab  Auto  

Event OnEffectStart(Actor akTarget, Actor akCaster)

	If  (SexLab.ValidateActor( SexLab.PlayerRef) > 0) 
		Debug.Notification( "You peel off your clothes excitedly..." )
    		bool[] strip = new bool[33]
   		 ; // Strip body
    	;	strip[2] = true 
    		; // Strip feet
    	;	strip[7] = true

    		; // Strip our actor of their shirt and shoes
    	 ;	form[] ActorEquipment = SexLab.StripSlots(Game.GetPlayer(), strip)

		 ; SexLab.StripActor(Game.GetPlayer())
		SexLab.ActorLib.StripActor(Game.GetPlayer(), DoAnimate= false)
	EndIf

EndEvent
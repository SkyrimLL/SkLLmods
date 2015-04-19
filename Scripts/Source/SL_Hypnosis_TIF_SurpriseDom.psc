;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Hypnosis_TIF_SurpriseDom Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int randomNum = Utility.RandomInt(0,100)
Int daysSinceEnslavement = (Game.QueryStat("Days Passed") - VictimGameDateEnslaved.GetValue() ) as Int
VictimGameDayEnslaved.SetValue(daysSinceEnslavement)

If (randomNum > 90)
	Debug.Notification( "[Grin] Now this is a better place for you..." )
	mcfunct.Undress(SexLab.PlayerRef )

	; Lock Player actions

	if (Game.IsSneakingControlsEnabled())
		Debug.MessageBox( "You are quickly stripped, hands bound behind your back." )

	  	Game.DisablePlayerControls( abMovement = false, abFighting = true, abCamSwitch = false, abLooking = false, abSneaking = true, abMenu = false, abActivate = false, abJournalTabs = false)

		Debug.SendAnimationEvent( SexLab.PlayerREF, "ZazAPC053")
	EndIf
ElseIf (randomNum > 80)
	Debug.Notification( "[Disgusted] I don't like how you look." )

	mcfunct.Undress(SexLab.PlayerRef )

	Int IButton = _SLMC_racemenu.Show()

	If IButton == 0  ; Show the thing.
		Game.ShowLimitedRaceMenu()
	EndIf

	Utility.Wait(1.0)

ElseIf (randomNum > 70)
	If  (SexLab.ValidateActor( SexLab.PlayerRef ) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		Debug.Notification( "[Grin] Don't move..." )

		SexLab.QuickStart(SexLab.PlayerRef, akSpeaker,  AnimationTags = "Aggressive")

	EndIf
ElseIf (randomNum > 65)
	If  (SexLab.ValidateActor(SexLab.PlayerRef) > 0) 
		Debug.Notification( "[Licks her lips] I want to watch you" )
		Actor akActor = SexLab.PlayerRef
		
		sslThreadModel Thread = SexLab.NewThread()
		Thread.AddActor(akActor, true) ; // IsVictim = true

		If (akActor.GetActorBase().getSex() == 1)
			Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F","Estrus,Dwemer"))
		Else
			Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,M","Estrus,Dwemer"))
		EndIf

		Thread.StartThread()
	EndIf
ElseIf (randomNum > 55) && (daysSinceEnslavement>1)
     Debug.Notification( "You did good." )
     Debug.Notification( "Mmmm.... look how wet you are making me." )

     SexLab.ApplyCum(akSpeaker, 1)
Else
	
	If (daysSinceEnslavement>5)
      Debug.Notification( "[Kisses your feet and glares at you]" )
    ElseIf (daysSinceEnslavement>2)
       Debug.Notification( "[Blushes reluctantly]" )
   ElseIf (daysSinceEnslavement>1)
      Debug.Notification( "Am I supposed to be impressed?" )
    EndIf

	if (!Game.IsSneakingControlsEnabled())
	  	; Debug.Trace("Player can use the menu!")
	  	; Release player

	  	Game.DisablePlayerControls( abMovement = false, abFighting = false, abCamSwitch = false, abLooking = false, abSneaking = false, abMenu = false, abActivate = false, abJournalTabs = false)

		Debug.SendAnimationEvent(SexLab.PlayerREF, "IdleForceDefaultState")
	endIf	

EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

LeveledItem Property DruggedDrink  Auto  

Potion Property Skooma  Auto  

SL_Hypnosis_functions Property mcfunct  Auto  

Message Property _SLMC_racemenu  Auto  

GlobalVariable Property VictimGameDayEnslaved  Auto  

GlobalVariable Property VictimGameDateEnslaved  Auto  

;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Hypnosis_TIF_SurpriseSub Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int randomNum = Utility.RandomInt(0,100)
Int daysSinceEnslavement = (Game.QueryStat("Days Passed") - VictimGameDateEnslaved.GetValue() ) as Int
VictimGameDayEnslaved.SetValue(daysSinceEnslavement)

If (IsKneeling.Getvalue() == 1)
      Debug.SendAnimationEvent(akSpeaker as ObjectReference, "IdleForceDefaultState")
	IsKneeling.Setvalue(0) 
EndIf

If (randomNum > 85)
		Debug.Notification( "Do you still like me?" )
    		mcfunct.Undress(akSpeaker)

ElseIf (randomNum > 80) && (daysSinceEnslavement>1)
	If  (SexLab.ValidateActor( SexLab.PlayerRef ) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		Debug.Notification( "[Smiles] I know just the thing..." )

		SexLab.QuickStart(SexLab.PlayerRef, akSpeaker,  AnimationTags = "Oral")

	EndIf
ElseIf (randomNum > 75)
	If  (SexLab.ValidateActor(akSpeaker) > 0) 
		Debug.Notification( "[Moans] I'm sorry... I can't stand it anymore!" )
		
		sslThreadModel Thread = SexLab.NewThread()
		Thread.AddActor(akSpeaker, true) ; // IsVictim = true

		If (akSpeaker.GetActorBase().getSex() == 1)
			Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,F","Estrus,Dwemer"))
		Else
			Thread.SetAnimations(SexLab.GetAnimationsByTags(1, "Solo,M","Estrus,Dwemer"))
		EndIf

		Thread.StartThread()
	EndIf
ElseIf (randomNum > 70) && (daysSinceEnslavement>1)
     Debug.Notification( "Mmmm.... look how wet you are making me." )

    mcfunct.Undress(akSpeaker)
     SexLab.ApplyCum(akSpeaker, 1)
ElseIf (randomNum > 40)
      Debug.Notification( "[Kneels down] I will be good.... I promise." )

      Debug.SendAnimationEvent(akSpeakerRef, "ZazAPC058")
	  IsKneeling.Setvalue(1)
Else

	If (daysSinceEnslavement>5)
      Debug.Notification( "[Kisses your feet] Anything for you my Dear." )
    ElseIf (daysSinceEnslavement>2)
       Debug.Notification( "[Blushes gratefully]" )
   ElseIf (daysSinceEnslavement>1)
      Debug.Notification( "[Kisses your hand and sighs]" )
    EndIf
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

SL_Hypnosis_VictimAlias  Property LoveInterest  Auto  

Potion Property FoodMarriageMeal  Auto  

GlobalVariable Property isKneeling  Auto  

LeveledItem Property RareLoot  Auto  

GlobalVariable Property VictimGameDayEnslaved  Auto  

GlobalVariable Property VictimGameDateEnslaved  Auto  

SL_Hypnosis_functions Property mcfunct  Auto  

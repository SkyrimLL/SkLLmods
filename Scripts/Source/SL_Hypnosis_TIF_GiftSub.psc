;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Hypnosis_TIF_GiftSub Extends TopicInfo Hidden

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

If (randomNum > 90)
	Debug.Notification( "Here is a gift.. take what you want." )
	akspeaker.OpenInventory(true)
ElseIf (randomNum > 50) && (daysSinceEnslavement>2)
     Debug.Notification( "I saved this for you. Did I do well?" )

	LoveInterest.GiveGold()
ElseIf (randomNum > 15) && (daysSinceEnslavement>5)
     Debug.Notification( "I found this and saved it for you." )

	Game.GetPlayer().AddItem(RareLoot)
ElseIf  (daysSinceEnslavement>=0)
	Debug.Notification( "Here... I prepared this just for you." )

	Game.GetPlayer().AddItem(FoodMarriageMeal)

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

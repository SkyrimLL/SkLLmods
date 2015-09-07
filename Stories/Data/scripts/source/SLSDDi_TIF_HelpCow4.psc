;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLSDDi_TIF_HelpCow4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.Notification( "The cow moans with relief..." )

If  (SexLab.ValidateActor( SexLab.PlayerRef ) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
	actor[] sexActors = new actor[2]
	sexActors[0] = akSpeaker
	sexActors[1] = Game.GetPlayer()

	sslBaseAnimation[] anims
	anims = new sslBaseAnimation[1]
	Int rnum = Utility.RandomInt(0,100)

	if (rnum > 50)
		anims[0] = SexLab.GetAnimationByName("3J Straight Breastfeeding")
	else
		anims[0] = SexLab.GetAnimationByName("3J Lesbian Breastfeeding")
	endif

	if (anims[0] ==None)
		anims = SexLab.GetAnimationsByTags(2, "Breast","Estrus,Dwemer")
	endif

	SexLab.StartSex(sexActors, anims)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

Potion Property Milk  Auto  

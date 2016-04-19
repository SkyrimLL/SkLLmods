;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname SLS_TIF_CowSlaveMilk Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.Notification( "CeeCee moans with anticipation..." )

If  (SexLab.ValidateActor(Game.GetPlayer() ) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
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

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
pFDS.Persuade(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

FavorDialogueScript Property pFDS   Auto  
SexLabFrameWork Property SexLab Auto

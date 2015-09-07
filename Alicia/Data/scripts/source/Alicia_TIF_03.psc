;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname Alicia_TIF_03 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
AliciaKeepClothesOn.SetValue(0)

If (Utility.RandomInt(0,100)>90) 
	If  (SexLab.ValidateActor( SexLab.PlayerRef ) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
    	Debug.Notification( "Alicia smiles and pulls you to her..." )

		SexLab.QuickStart(SexLab.PlayerRef, akSpeaker, AnimationTags = "Sex")
	EndIf
Else
	Debug.Notification( "Alicia sighs with relief..." )
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

GlobalVariable Property AliciaKeepClothesOn  Auto  

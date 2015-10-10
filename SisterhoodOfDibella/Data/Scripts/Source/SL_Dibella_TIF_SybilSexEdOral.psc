;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_SybilSexEdOral Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
InitiationLevelBuffer.SetValue( InitiationLevelBuffer.GetValue() + 1)

If (InitiationLevelBuffer.GetValue() >= 10)
	SybilLevel.SetValue( SybilLevel.GetValue() + 1)
	if ( SybilLevel.GetValue() > 5 ) 
		SybilLevel.SetValue( 5 )
	EndIf

	InitiationLevelBuffer.SetValue(0)
EndIf

	If  (SexLab.ValidateActor( SexLab.PlayerREF) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		Debug.Notification( "Fjotra licks her lips..." + SexLab.GetGender(SexLab.PlayerREF ))
		actor[] sexActors = new actor[2]
		sexActors[0] = akSpeaker
		sexActors[1] =  SexLab.PlayerREF
		sslBaseAnimation[] animations 

		If (SexLab.GetGender(SexLab.PlayerREF ) == 0 )
			animations = SexLab.GetAnimationsByTag(2, "Lesbian", "Oral", tagSuppress="Aggressive")
		ElseIf (SybilLevel.GetValue() ==2)
			animations = SexLab.GetAnimationsByTag(2, "Oral", tagSuppress="Aggressive")
		EndIf

		SexLab.StartSex(sexActors, animations)
	EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

GlobalVariable Property InitiationLevelBuffer  Auto  

GlobalVariable Property SybilLevel  Auto  

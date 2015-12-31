;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_QST_TempleDebauchery Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
ObjectReference HamalREF = HamalAlias.GetReference()
ObjectReference SybilREF = SybilAlias.GetReference()
Int sexTrigger = (SybilLevel.GetValue() as Int)*10+20

	If UI.IsMenuOpen("Console") || UI.IsMenuOpen("Main Menu") || UI.IsMenuOpen("Loading Menu") || UI.IsMenuOpen("MessageBoxMenu")
		return
	EndIf
	
	; If (Utility.RandomInt(0,100)<sexTrigger )  
		; 3d will not be loaded in some situations, such as werewolf transformations.
		; Skip body update if 3d not loaded.
		If ( !(HamalREF as Actor).Is3DLoaded() ) || ( !(SybilREF as Actor).Is3DLoaded() ) || ( !(SanguineAgentM as Actor).Is3DLoaded() ) || ( !(SanguineAgentF as Actor).Is3DLoaded() )
			return
		EndIf

		If  (SexLab.ValidateActor( HamalREF  as Actor) > 0) &&  (SexLab.ValidateActor(SybilREF as Actor) > 0) 
			Debug.Notification( "Hamal brings her pupil to her lap..." )
			InitiationDate.SetValue(Game.QueryStat("Days Passed") ) 
			InitiationLessonCount.SetValue(InitiationLessonCount.GetValue()+1 ) 
			StorageUtil.SetIntValue( SybilREF, "_SLSD_iInitiationLessonCount", InitiationLessonCount.GetValue() as Int )

	             fNext = GameDaysPassed.GetValue() + fNextAllowed + Utility.RandomFloat( 0.02, 0.05 ) ; + Utility.RandomFloat( 0.125, 0.25 )
                    LessonNextTime.SetValue(fNext)

			actor[] sexActors = new actor[3]
			sexActors[0] = SybilREF as actor
			If (Utility.RandomInt(0,100)> 50)
				sexActors[1] = SanguineAgentM  as actor
			Else
				sexActors[1] = SanguineAgentF  as actor
			EndIf
			sexActors[2] = HamalREF as actor
 
			sslBaseAnimation[] anims
			anims = SexLab.GetAnimationsByTags(3,"Orgy" )
 
			SexLab.StartSex(sexActors, anims )

 		Else
			Debug.Notification( "Hamal smiles at her pupil.." )

		EndIf
	; Else
	;	Debug.Notification( "Hamal smiles at her pupil.." )
	; EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


SexLabFramework Property SexLab  Auto  

ReferenceAlias Property HamalAlias  Auto  
ReferenceAlias Property SybilAlias  Auto  
ObjectReference Property SanguineAgentM Auto
ObjectReference Property SanguineAgentF Auto

GlobalVariable Property SybilLevel  Auto  
GlobalVariable Property InitiationDate  Auto  
GlobalVariable Property InitiationLessonCount  Auto  

float fNext = 0.0
float fNextAllowed = 0.02

GlobalVariable Property GameDaysPassed  Auto  

GlobalVariable Property LessonNextTime  Auto  

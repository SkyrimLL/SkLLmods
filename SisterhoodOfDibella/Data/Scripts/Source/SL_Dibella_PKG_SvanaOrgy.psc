;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SL_Dibella_PKG_SvanaOrgy Extends Package Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(Actor akActor)
;BEGIN CODE
If ( !( SvanaCorrupted  as Actor).Is3DLoaded()  ||  !(Drunk01  as Actor).Is3DLoaded() ||  !(Drunk02  as Actor).Is3DLoaded()  || !(SlaveM  as Actor).Is3DLoaded() )
			return
		EndIf

		If  (SexLab.ValidateActor( SvanaCorrupted  as Actor) > 0) &&  (SexLab.ValidateActor( Drunk01  as Actor) > 0)  &&  (SexLab.ValidateActor( Drunk02  as Actor) > 0) 
			Debug.Notification( "Moans echo in the damp hallways." )

	             ; fNext = GameDaysPassed.GetValue() + fNextAllowed + Utility.RandomFloat( 0.02, 0.05 ) ; + Utility.RandomFloat( 0.125, 0.25 )
                   ;  LessonNextTime.SetValue(fNext)

			actor[] sexActors = new actor[3]
			sexActors[0] = SvanaCorrupted  as actor
			If (Utility.RandomInt(0,100)> 50)
				sexActors[1] = Drunk01  as actor
			Else
				sexActors[1] = SlaveM  as actor
			EndIf
			sexActors[2] = Drunk02  as actor
 
			sslBaseAnimation[] anims
			anims = SexLab.GetAnimationsByTags(3,"Orgy" )
 
			SexLab.StartSex(sexActors, anims )

 		Else
			Debug.Notification( "[Debug] Svana orgy failed" )

		EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment



SexLabFramework Property SexLab  Auto  

ObjectReference Property SvanaCorrupted  Auto  
ObjectReference Property Drunk01  Auto  
ObjectReference Property Drunk02  Auto  
ObjectReference Property SlaveM  Auto  
ObjectReference Property SlaveF  Auto  


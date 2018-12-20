;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_InitiationTask02b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()

kPlayer.RemoveItem(Gold, 100, true, akSpeaker)

Self.GetOwningQuest().SetObjectiveDisplayed(8, abDisplayed = False)
Self.GetOwningQuest().SetStage(8)

 If (DibellaPathQuest.GetStage()==0)
	DibellaPathQuest.Start()
EndIf

DibellaPathQuest.SetStage(20)

if ( SybilLevel.GetValue() < 2 ) 
	SybilLevel.SetValue( 2 )
	StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iDibellaSybilLevel" , 2)

	InitiationLevelBuffer.SetValue( 0 )
EndIf
 

InitiationLessonCount.SetValue(InitiationLessonCount.GetValue()+1 ) 
StorageUtil.SetIntValue( akSpeaker, "_SLSD_iInitiationLessonCount", InitiationLessonCount.GetValue() as Int )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

GlobalVariable Property InitiationLevelBuffer  Auto  

GlobalVariable Property SybilLevel  Auto  

GlobalVariable Property InitiationLessonCount  Auto  

GlobalVariable Property TempleCorruption Auto

Quest Property DibellaPathQuest  Auto  
MiscObject Property Gold  Auto  


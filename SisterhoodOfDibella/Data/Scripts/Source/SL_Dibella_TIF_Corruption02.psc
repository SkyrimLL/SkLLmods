;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SL_Dibella_TIF_Corruption02 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().SetStage(6)

; Corruption inits

if ( SybilLevel.GetValue() < 5 ) 
	SybilLevel.SetValue( 5 )
	StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iDibellaSybilLevel" , 5)

EndIf

SanguineRedLightRef.Enable()

(SennaRef as Actor).SendModEvent("SLSDEquipOutfit","SisterCorrupted")

(AnwenRef as Actor).SetOutfit(SisterBound)
AnwenRef.AddItem(AnwenKey, 1)
(AnwenRef as Actor).EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property SanguineRedLightRef  Auto  

ObjectReference Property AnwenRef  Auto  

ObjectReference Property SennaRef  Auto  

Key Property AnwenKey  Auto  

Outfit Property SisterBound  Auto  

GlobalVariable Property SybilLevel  Auto  

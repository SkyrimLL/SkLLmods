;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SL_Dibella_TIF_Corruption50 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()
Self.GetOwningQuest().SetStage(59)

StorageUtil.SetIntValue( kPlayer , "_SLSD_iDibellaTempleCorruption", 5)
StorageUtil.SetIntValue( kPlayer , "_SLSD_iDibellaSybilLevel" ,6)
(FjotraRef as Actor).SendModEvent("SLSDEquipOutfit","FjotraCorrupted")

ObjectReference arPortal = (_SLSD_Sanguine as ObjectReference).PlaceAtMe(Game.GetFormFromFile(0x0007CD55, "Skyrim.ESM")) 
; SummonEffect.Cast( akSpeaker, akSpeaker )
Utility.wait( 3.0 )


MUSCombatBoss.Add()

akSpeaker.SendModEvent("PCSubEntertain", "Gangbang")

_SLSD_NPC_HamalCorrupted.Enable()   

HamalFX.Play( HamalRef, 5)
Utility.Wait(6.0)

HamalRef.Disable() 

(FjotraRef as Actor).PathToReference(DibellaTempleBed, 0.5)
(_SLSD_Sanguine as Actor).PathToReference(DibellaTempleBed, 0.5)

If  (SexLab.ValidateActor( FjotraRef as Actor ) > 0) &&  (SexLab.ValidateActor(_SLSD_Sanguine  as Actor ) > 0) 
    SexLab.QuickStart(FjotraRef as Actor ,  _SLSD_Sanguine as Actor  ,  Victim = FjotraRef as Actor , AnimationTags = "Aggressive")

	actor[] sexActors = new actor[2]
	sexActors[0] = FjotraRef as Actor
	sexActors[1] = _SLSD_Sanguine as Actor

	sslBaseAnimation[] anims
	anims = new sslBaseAnimation[1]

	anims = SexLab.GetAnimationsByTags(2, "Rough","Estrus,Dwemer")

	SexLab.StartSex(Positions = sexActors, Anims = anims, Victim = FjotraRef as Actor, CenterOn = AltarBedRef, AllowBed = true)

EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
_SLSD_Sanguine.Enable() 
SanguineFX.Play( _SLSD_Sanguine, 15)
Utility.Wait(2.0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property _SLSD_NPC_HamalCorrupted  Auto  

ObjectReference Property HamalRef  Auto  

ObjectReference Property _SLSD_Sanguine  Auto  

ObjectReference Property FjotraREF  Auto  

SexLabFramework Property SexLab  Auto  

VisualEffect Property HamalFX  Auto  

VisualEffect Property SanguineFX  Auto  

ObjectReference Property AltarBedRef  Auto  

MusicType Property MUSCombatBoss  Auto  
ObjectReference Property DibellaTempleBed Auto

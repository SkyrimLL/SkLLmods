;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 80
Scriptname SLP_QST_QueenOfChaurus Extends Quest Hidden

;BEGIN ALIAS PROPERTY _SLP_LastelleRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLP_LastelleRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLP_DanicaSanctuaryFollower
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLP_DanicaSanctuaryFollower Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLP_ChaurusStudLastelle
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLP_ChaurusStudLastelle Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLP_QOF_PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLP_QOF_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLP_ChaurusStudPlayer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLP_ChaurusStudPlayer Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY _SLP_SpiderFollower
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__SLP_SpiderFollower Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_36
Function Fragment_36()
;BEGIN CODE
SetObjectiveDisplayed(220, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42()
;BEGIN CODE
; Scene in Sanctuary is complete
SetObjectiveDisplayed(250, false)
SetObjectiveDisplayed(252, false)
SetObjectiveDisplayed(255, false)
SetObjectiveDisplayed(260)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
SetObjectiveDisplayed(120, false)
SetObjectiveDisplayed(130)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_38
Function Fragment_38()
;BEGIN CODE
SetObjectiveDisplayed(220, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_63
Function Fragment_63()
;BEGIN CODE
ShroudedGroveMapMarker.AddToMap()

SetObjectiveDisplayed(355, false)
SetObjectiveDisplayed(360)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
EggSackOutsideMarker.enable()
SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
SetObjectiveDisplayed(252, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_53
Function Fragment_53()
;BEGIN CODE
SetObjectiveDisplayed(280, false)
SetObjectiveDisplayed(285)

SLP_WhiterunSanctuaryFollower.ForceRefTo(DanicaRef)
DanicaSanctuaryAltar.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
SetObjectiveDisplayed(100, false)
SetObjectiveDisplayed(110)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_73
Function Fragment_73()
;BEGIN CODE
SetObjectiveDisplayed(62)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_51
Function Fragment_51()
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()

SetObjectiveDisplayed(285, false)
SetObjectiveDisplayed(289)

StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenVag", 100.0 )
StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenGag", 100.0 )
StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenSkin", 100.0 )
StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenArmor", 100.0 )
StorageUtil.SetFloatValue(kPlayer, "_SLP_chanceChaurusQueenBody", 100.0 )

StorageUtil.SetIntValue(kPlayer, "_SLP_iChaurusQueenStage",  1)
StorageUtil.SetIntValue(kPlayer, "_SLP_iChaurusQueenDate", Game.QueryStat("Days Passed"))
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
; ObjectReference LastelleRef = Alias__SLP_LastelleRef.GetReference()

; LastelleRef.moveto(EggSackOutsideMarker)

SetObjectiveDisplayed(50,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
; stage moved to 71 for backward compatilibty
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(10)
SetObjectiveDisplayed(11)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
SetObjectiveDisplayed(30,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_35
Function Fragment_35()
;BEGIN CODE
SetObjectiveDisplayed(240, false)
SetObjectiveDisplayed(250)
SetObjectiveDisplayed(252)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_47
Function Fragment_47()
;BEGIN CODE
SetObjectiveDisplayed(276)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
Actor kLastelle = Alias__SLP_LastelleRef.GetReference() as Actor
ObjectReference LastelleRef = Alias__SLP_LastelleRef.GetReference()


; fctParasites.infectTentacleMonster( kLastelle ) 
fctParasites.infectParasiteByString(kLastelle, "ChaurusEggSilent")

EggSackOutsideMarker.disable()
EggSackInsideMarker.enable()
_SLP_BroodCaveEntranceMarker.disable()

LastelleRef.moveto(EggSackInsideMarker)

SetObjectiveDisplayed(60, false)
SetObjectiveDisplayed(62, false)
SetObjectiveDisplayed(65)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_66
Function Fragment_66()
;BEGIN CODE
SetObjectiveDisplayed(370, false)
SetObjectiveDisplayed(380)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
SetObjectiveDisplayed(5,false)
SetObjectiveDisplayed(10,false)
SetObjectiveDisplayed(11,false)
SetObjectiveDisplayed(15)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_62
Function Fragment_62()
;BEGIN CODE
SetObjectiveDisplayed(350, false)
SetObjectiveDisplayed(355)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_69
Function Fragment_69()
;BEGIN CODE
SetObjectiveDisplayed(15,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_44
Function Fragment_44()
;BEGIN CODE
; Sanctuary is restored
SetObjectiveDisplayed(250, false)
SetObjectiveDisplayed(252, false)
SetObjectiveDisplayed(255)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN CODE
SetObjectiveDisplayed(15,false)
SetObjectiveDisplayed(45)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
SetObjectiveDisplayed(70,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
SetObjectiveDisplayed(40,false)
SetObjectiveDisplayed(45,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_68
Function Fragment_68()
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()
ObjectReference kPlayerRef = kPlayer as ObjectReference
	
ChaurusQueenRift.disable()
DimensionalRiftRef.disable()

kPlayer.AddSpell(ChaurusBody)

fctParasites.getRandomChaurusEggs(kPlayer, 6, 10)

ChaurusBody.cast(kPlayerRef, kPlayerRef)

SetObjectiveDisplayed(390, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28()
;BEGIN CODE
ObjectReference kPlayerRef = Game.GetPlayer()
Actor akPlayer = kPlayerRef  as Actor

if (kPlayerRef.GetItemCount(_SLP_MotherSeed) == 0)
  akPlayer.additem(_SLP_MotherSeed, 1)
  Debug.Messagebox("As you pick up the notebook, you notice a strange star shaped stone is bound to the cover with a thin strip of leather.")
Endif

SetObjectiveDisplayed(140, false)
SetObjectiveDisplayed(150)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_59
Function Fragment_59()
;BEGIN CODE
SetObjectiveDisplayed(320, false)
SetObjectiveDisplayed(330)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_60
Function Fragment_60()
;BEGIN CODE
SetObjectiveDisplayed(330, false)
SetObjectiveDisplayed(340)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveDisplayed(5,false)
SetObjectiveDisplayed(6,false)
SetObjectiveDisplayed(15,false)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
SetObjectiveDisplayed(110, false)
SetObjectiveDisplayed(120)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_71
Function Fragment_71()
;BEGIN CODE
ChaurusQueenRift.disable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_64
Function Fragment_64()
;BEGIN CODE
FrostflowAbyssMapMarker.AddToMap()

SetObjectiveDisplayed(360, false)
SetObjectiveDisplayed(370)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
SetObjectiveDisplayed(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_55
Function Fragment_55()
;BEGIN CODE
SetObjectiveDisplayed(290, false)
SetObjectiveDisplayed(300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
SetObjectiveDisplayed(65,false)
SetObjectiveDisplayed(20,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
SetObjectiveDisplayed(60)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_54
Function Fragment_54()
;BEGIN CODE
SetObjectiveDisplayed(289, false)
SetObjectiveDisplayed(290)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
SetObjectiveDisplayed(130, false)
SetObjectiveDisplayed(140)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
; Actor akPlayer = Game.GetPlayer()
; akPlayer.removeitem(_SLP_MotherSeed, 1)

SightlessPitMapMarker.AddToMap()

SetObjectiveDisplayed(150, false)
SetObjectiveDisplayed(200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_33
Function Fragment_33()
;BEGIN CODE
SetObjectiveDisplayed(230, false)
SetObjectiveDisplayed(240)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_49
Function Fragment_49()
;BEGIN CODE
SetObjectiveDisplayed(270, false)
SetObjectiveDisplayed(276, false)
SetObjectiveDisplayed(280)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
SetObjectiveDisplayed(15,false)
SetObjectiveDisplayed(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_56
Function Fragment_56()
;BEGIN CODE
SetObjectiveDisplayed(300, false)
SetObjectiveDisplayed(310)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30()
;BEGIN CODE
ObjectReference LastelleRef = Alias__SLP_LastelleRef.GetReference()
Actor kLastelleAlt = LastelleAltRef as Actor
ActorBase akActorBase = kLastelleAlt.GetActorBase()

_SLP_LastelleDeadMarker.enable()
; kLastelleAlt.SetOutfit(BarnaclesOutfit)
; akActorBase.SetSkin(SkinBarnaclesArmor)

LastelleRef.disable()
kLastelleAlt.kill()

SetObjectiveDisplayed(200, false)
SetObjectiveDisplayed(210)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
SetObjectiveDisplayed(25,false)
SetObjectiveDisplayed(70)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_46
Function Fragment_46()
;BEGIN CODE
SetObjectiveDisplayed(260, false)
SetObjectiveDisplayed(270)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_61
Function Fragment_61()
;BEGIN CODE
SetObjectiveDisplayed(340, false)
SetObjectiveDisplayed(350)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveDisplayed(10,false)
SetObjectiveDisplayed(19,false)
SetObjectiveDisplayed(20,false)
SetObjectiveDisplayed(25)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_70
Function Fragment_70()
;BEGIN CODE
SetObjectiveDisplayed(15,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_67
Function Fragment_67()
;BEGIN CODE
SetObjectiveDisplayed(380, false)
SetObjectiveDisplayed(390)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_77
Function Fragment_77()
;BEGIN CODE
; backup stage to skip sanctuary

Actor kDanica = DanicaRef as Actor
kDanica.SendModEvent("SLPCureFaceHuggerGag")
WhiterunSancturaryCorruptionMarker.disable()
SanctuaryRustedSawRef.disable()

Setstage(255)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_57
Function Fragment_57()
;BEGIN CODE
SetObjectiveDisplayed(310, false)
SetObjectiveDisplayed(320)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN CODE
SetObjectiveDisplayed(220, false)
SetObjectiveDisplayed(230)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_31
Function Fragment_31()
;BEGIN CODE
SetObjectiveDisplayed(15,false)
SetObjectiveDisplayed(70, false)
SetObjectiveDisplayed(210, false)
SetObjectiveDisplayed(220)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property EggSackOutsideMarker  Auto  

ObjectReference Property EggSackInsideMarker  Auto  

ObjectReference Property _SLP_BroodCaveEntranceMarker  Auto  
SLP_fcts_parasites Property fctParasites  Auto

MiscObject Property _SLP_MotherSeed  Auto  

ObjectReference Property SightlessPitMapMarker  Auto  

ObjectReference Property _SLP_LastelleDeadMarker  Auto  

ObjectReference Property LastelleAltRef  Auto  

Outfit Property BarnaclesOutfit  Auto  

Armor Property SkinBarnaclesArmor  Auto  

ObjectReference Property ShroudedGroveMapMarker  Auto  

ObjectReference Property FrostflowAbyssMapMarker  Auto  

SPELL Property ChaurusBody Auto 

ObjectReference Property DimensionalRiftRef Auto

ObjectReference Property ChaurusQueenRift  Auto  

ReferenceAlias Property SLP_WhiterunSanctuaryFollower  Auto  

Scene Property DanicaSanctuaryAltar  Auto  

ObjectReference Property DanicaRef  Auto  

ObjectReference Property SanctuaryRustedSawRef  Auto  

ObjectReference Property WhiterunSancturaryCorruptionMarker  Auto  

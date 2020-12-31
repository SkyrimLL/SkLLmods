;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_KyneBlessing289 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor akPlayer = Game.GetPlayer()
akPlayer.removeitem(_SLP_MotherSeed, 1)
akPlayer.removeitem(NirnrootRed, 1)
akPlayer.removeitem(GlowingMushroom, 1)

SLP_WhiterunSanctuaryFollower.ForceRefTo(akSpeaker as ObjectReference)

self.getowningquest().setstage(289)

DanicaSanctuaryAltar.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property DanicaSanctuaryAltar  Auto  

MiscObject Property _SLP_MotherSeed  Auto  
Ingredient Property NirnrootRed  Auto  
Ingredient Property GlowingMushroom  Auto  
ReferenceAlias Property SLP_WhiterunSanctuaryFollower  Auto  

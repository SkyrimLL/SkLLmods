;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_KyneAltar02 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer=game.Getplayer()

if (fctParasites.isInfectedByString(kPlayer, "SprigganRoot"  ))

   Sound.SetInstanceVolume(KyneFX.Play(kPlayer), 1.0)

   BlizzardEffect.Cast(kPlayer  as ObjectReference, kPlayer  as ObjectReference)

   kPlayer.SendModEvent("SLPCureSprigganRoot", "All")

endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property KynesBlessingQuest  Auto 
SPELL Property BlizzardEffect  Auto  
Sound Property KyneFX  Auto
SLP_fcts_parasites Property fctParasites  Auto

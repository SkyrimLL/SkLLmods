;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_TGWonder04a Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int iRandomNum = Utility.RandomInt(0,100)
Actor kPlayer = Game.GetPlayer()

_SLS_PCSexWithTG.Mod(1)
_SLS_PCPaidForTG.SetValue(0)

If ( Utility.RandomInt(0,100) > 70 )

	Game.AddPerkPoints(1)
	RedeemPerkFX.Cast(kPlayer,kPlayer)

EndIf

SendModEvent("SLHModHormoneRandom","Succubus", 1.0)

If ( Utility.RandomInt(0,100) > 95 )
	kPlayer.SendModEvent("SLHCastBimboCurse", "Dremora")
Endif


If ( Utility.RandomInt(0,100) > 50)
	SexLab.TreatAsMale( akSpeaker )
Else
	SexLab.TreatAsFemale( akSpeaker )
EndIf
		
If (iRandomNum < 30 )
	SexLab.QuickStart(kPlayer,  akSpeaker, AnimationTags = "Foreplay")
ElseIf (iRandomNum < 60 )
	SexLab.QuickStart(kPlayer,  akSpeaker, AnimationTags = "Loving")
ElseIf (iRandomNum < 80 )
	SexLab.QuickStart(kPlayer,  akSpeaker, AnimationTags = "Sex")
Else
	SexLab.QuickStart(kPlayer,  akSpeaker, AnimationTags = "Rough")
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SPELL Property RedeemPerkFX  Auto  

SexLabFramework Property SexLab  Auto  

MiscObject Property Gold  Auto  

GlobalVariable Property _SLS_PCSexWithTG  Auto  

GlobalVariable Property _SLS_PCPaidForTG  Auto  

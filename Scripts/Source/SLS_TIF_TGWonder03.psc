;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_TGWonder03 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int iRandomNum = Utility.RandomInt(0,100)

_SLS_PCSexWithTG.Mod(1)
_SLS_PCPaidForTG.SetValue(0)

If ( Utility.RandomInt(0,100) > 80)

	Game.AddPerkPoints(1)
	RedeemFX.Cast(Game.GetPlayer(),Game.GetPlayer())

EndIf

If ( Utility.RandomInt(0,100) > 50)
	SexLab.TreatAsMale( akSpeaker )
Else
	SexLab.TreatAsFemale( akSpeaker )
EndIf
		
If (iRandomNum < 30 )
	SexLab.QuickStart(SexLab.PlayerRef,  akSpeaker, AnimationTags = "Foreplay")
ElseIf (iRandomNum < 60 )
	SexLab.QuickStart(SexLab.PlayerRef,  akSpeaker, AnimationTags = "Loving")
ElseIf (iRandomNum < 80 )
	SexLab.QuickStart(SexLab.PlayerRef,  akSpeaker, AnimationTags = "Sex")
Else
	SexLab.QuickStart(SexLab.PlayerRef,  akSpeaker, AnimationTags = "Rough")
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

SPELL Property RedeemFX  Auto  

GlobalVariable Property _SLS_PCSexWithTG  Auto  

GlobalVariable Property _SLS_PCPaidForTG  Auto  

;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_SexBotParts Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ObjectReference SexBotREF= _SLS_SexBotAlias.GetReference()
Actor SexBotActor= _SLS_SexBotAlias.GetReference() as Actor
ActorBase pSexBotActorBase = SexBotActor.GetActorBase()
Outfit newSexBotOutfit

int bodyPartsCount = Game.GetPlayer().GetItemCount( _SLS_ImbuedFlesh ) 
int outfitID

if (bodyPartsCount > 0)
	Game.GetPlayer().RemoveItem(_SLS_ImbuedFlesh, bodyPartsCount )

	_SLS_SexBotRepairLevel.SetValue( _SLS_SexBotRepairLevel.GetValue() + bodyPartsCount   )


	if ( _SLS_SexBotRepairLevel.GetValue() >= 6)
		_SLS_SexBotRepairLevel.SetValue( 6 )

		if (Self.GetOwningQuest().GetStage() != 30)

			Self.GetOwningQuest().SetObjectiveDisplayed(20,0)
			Self.GetOwningQuest().SetStage(30)

		EndIf
	EndIf

      outfitID = _SLS_SexBotRepairLevel.GetValue() as Int
	
	newSexBotOutfit  = _SLS_SexBotRepairStates[outfitID - 1]

	Debug.Notification("SexBot: index = " + _SLS_SexBotRepairLevel.GetValue() as Int + " - Outfit: " + outfitID )

	SexBotActor.SetOutfit( newSexBotOutfit )
	SexBotActor.SetOutfit( newSexBotOutfit, True )
	_SLS_SexBotUpgradeFX.Cast( SexBotActor )
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion   Property _SLS_ImbuedFlesh  Auto  

GlobalVariable Property _SLS_SexBotRepairLevel  Auto  

Outfit[] Property _SLS_SexBotRepairStates  Auto  

ReferenceAlias Property _SLS_SexBotAlias  Auto  

SPELL Property _SLS_SexBotUpgradeFX  Auto  

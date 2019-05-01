;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 17
Scriptname SL_Dibella_QST_SybilInitiation Extends Quest Hidden

;BEGIN ALIAS PROPERTY HamalREF
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HamalREF Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SybilREF
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SybilREF Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
SetObjectiveDisplayed(0)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
Alias_SybilREF.GetActorRef().SetOutfit( SybilInitiateOutfit)
SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
Alias_SybilREF.GetActorRef().SetOutfit( SybilAccolyteOutfit)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
Actor kActor = Alias_SybilREF.GetActorRef()

if (StorageUtil.GetIntValue(none, "_SD_iSanguine")==1)
;    kActor.SendModEvent("SDClearDevice",   "Blindfold")
    kActor.SendModEvent("SDClearDevice",   "WristRestraint")
    kActor.SendModEvent("SDClearDevice",   "PlugVaginal")
    kActor.SendModEvent("SDClearDevice",   "PlugAnal")
    kActor.SendModEvent("SDClearDevice",   "Belt") 
    kActor.SendModEvent("SDClearDevice",   "Gag")
    kActor.SendModEvent("SDClearDevice",   "Collar")
endif

Alias_SybilREF.GetActorRef().SetOutfit( SybilNoviceOutfit)
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
Alias_SybilREF.GetActorRef().SetOutfit( SybilMotherOutfit)
SetObjectiveDisplayed(60)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Outfit Property SybilNoviceOutfit  Auto  
Outfit Property SybilAccolyteOutfit  Auto  
Outfit Property SybilInitiateOutfit  Auto  
Outfit Property SybilMotherOutfit  Auto  

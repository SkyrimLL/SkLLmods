;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_LastelleTasks59b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ObjectReference ChaurusPlayerRef = ChaurusFollowerAlias.GetRef() as ObjectReference
ObjectReference ChaurusLastelleRef = ChaurusFollowerLastelleAlias.GetRef() as ObjectReference
Actor kPlayer = Game.Getplayer()
ObjectReference kActorRef = kPlayer as ObjectReference
Actor kChaurusSpawn
ObjectReference ChaurusSpawnRef 
ActorBase ChaurusSpawnActorBase
Actor kChaurus 

kPlayer.RemoveItem(ChaurusPheromonePotion, 1)

ChaurusSpawnActorBase = EncChaurusSpawnActor.GetBaseObject() as ActorBase
kChaurusSpawn = SLP_ChaurusPheromoneLastelleMarker.PlaceActorAtMe(ChaurusSpawnActorBase, 3)
ChaurusSpawnRef = kChaurusSpawn as ObjectReference

ChaurusFollowerLastelleAlias.ForceRefTo(ChaurusSpawnRef)
ChaurusFollowerAlias.clear()

ChaurusSpawnRef.MoveTo(akSpeaker as ObjectReference)

kChaurus =  ChaurusFollowerLastelleAlias.GetRef() as Actor
self.GetOwningQuest().setstage(59)

SLP_ChaurusStudWithLastelle.SetValue(1)
kChaurus .EvaluatePackage()

fctParasites.infectParasiteByString(akSpeaker, "ChaurusWorm")

fctParasites.ParasiteSex(akSpeaker,kChaurus )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


SLP_fcts_parasites Property fctParasites  Auto
ReferenceAlias Property ChaurusFollowerAlias  Auto 
ReferenceAlias Property ChaurusFollowerLastelleAlias  Auto 
GlobalVariable Property SLP_ChaurusStudWithLastelle  Auto  
Actor Property EncChaurusSpawnActor Auto 

Potion Property ChaurusPheromonePotion  Auto  

ObjectReference Property SLP_ChaurusPheromoneLastelleMarker  Auto  

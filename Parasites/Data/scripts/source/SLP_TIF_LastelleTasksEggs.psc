;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLP_TIF_LastelleTasksEggs Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kPlayer = Game.GetPlayer()
int eggsCount = kPlayer.GetItemCount(ChaurusEgg) 
int eggsCountLastelle = SLP_GV_NumChaurusEggsLastelle.GetValue() as Int

if (eggsCountLastelle==0)
    ; to account for first batch of eggs collected earlier
    eggsCountLastelle = 15
endif 

if (eggsCount > 0)
   kPlayer.RemoveItem(ChaurusEgg, eggsCount )
EndIf
   
SLP_GV_NumChaurusEggsLastelle.SetValue(eggsCountLastelle + eggsCount)

debug.notification("Eggs count: " + SLP_GV_NumChaurusEggsLastelle.GetValue() as Int )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Ingredient Property ChaurusEgg  Auto  

GlobalVariable Property SLP_GV_NumChaurusEggsLastelle  Auto  

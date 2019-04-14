Scriptname Alicia_QST_PortalNote extends ObjectReference  

Event OnRead()
; 	Debug.Trace("Player reading Eridor's journal.")

PrisonPortalDoor.Enable()
PortalOpenFX.Cast(Game.GetPlayer())
; PrisonPortaFX.Enable()
PrisonPortaColumn.Enable()

SanguinePortalDoor.Enable()
; SanguinePortaFX.Enable()
SanguinePortaColumn.Enable()

BackStoryQuest.SetStage(50)

MUSdrama.Add()

EndEvent

ObjectReference Property PrisonPortalDoor  Auto  
ObjectReference Property PrisonPortaFX  Auto  
ObjectReference Property PrisonPortaColumn  Auto  
ObjectReference Property SanguinePortalDoor  Auto  
ObjectReference Property SanguinePortaFX  Auto  
ObjectReference Property SanguinePortaColumn  Auto  

Quest Property BackStoryQuest  Auto  

SPELL Property PortalOpenFX  Auto  

MusicType Property MUSdrama  Auto  
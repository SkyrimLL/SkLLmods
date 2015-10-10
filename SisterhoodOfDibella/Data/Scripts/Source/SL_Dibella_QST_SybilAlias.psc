Scriptname SL_Dibella_QST_SybilAlias extends ReferenceAlias  

SexLabFramework Property SexLab  Auto  
ReferenceAlias Property SybilAlias  Auto  

LeveledItem Property TortureDevice  Auto  
LeveledItem Property BondageItem  Auto  

Event OnInit()
	ObjectReference SybilREF= SybilAlias.GetReference()
	Actor SybilActor= SybilAlias.GetReference() as Actor

	; Debug.Notification("Sybil is initialized:" + SybilREF)

	RegisterForSleep()
EndEvent
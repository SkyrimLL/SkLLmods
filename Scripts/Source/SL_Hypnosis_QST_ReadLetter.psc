Scriptname SL_Hypnosis_QST_ReadLetter extends ObjectReference  

Event OnRead()
; 	Debug.Trace("Player reading Yisra's letter.")
	YisraMapMarker.Enable()
	YisraMapMarker.AddToMap()

EndEvent

ObjectReference Property YisraMapMarker  Auto  

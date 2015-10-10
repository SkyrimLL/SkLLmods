;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 19
Scriptname SL_Dibella_QST_DibellaPath Extends Quest Hidden

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
; Debug.Notification("Dibella's temple is serving a new master.")

_SLD_DibellaTempleCorruption.SetValue(3)
StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption", _SLD_DibellaTempleCorruption.GetValue() as Int )

_SLD_DibellaCorrupt0.Disable()
_SLD_DibellaCorrupt1.Disable()     
_SLD_DibellaCorrupt2.Disable()  
_SLD_DibellaCorrupt3.Enable()    
_SLD_DibellaCorrupt4.Disable()  
_SLD_DibellaCorrupt5.Disable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
; Debug.Notification("Dibella's temple is corrupted.")

_SLD_DibellaTempleCorruption.SetValue(2)
StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption", _SLD_DibellaTempleCorruption.GetValue() as Int )

_SLD_DibellaCorrupt0.Disable()
_SLD_DibellaCorrupt1.Disable()    
_SLD_DibellaCorrupt2.Enable()  
_SLD_DibellaCorrupt3.Disable()    
_SLD_DibellaCorrupt4.Disable()  
_SLD_DibellaCorrupt5.Disable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
; Debug.Notification("Dibella's temple is lost to Sanguine.")

_SLD_DibellaTempleCorruption.SetValue(5)
StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption", _SLD_DibellaTempleCorruption.GetValue() as Int )

_SLD_DibellaCorrupt0.Disable()
_SLD_DibellaCorrupt1.Disable()   
_SLD_DibellaCorrupt2.Disable()  
_SLD_DibellaCorrupt3.Disable()    
_SLD_DibellaCorrupt5.Disable()  
_SLD_DibellaCorrupt4.Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
; Debug.Notification("Dibella's temple is purified")

_SLD_DibellaTempleCorruption.SetValue(0)
StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption", _SLD_DibellaTempleCorruption.GetValue() as Int )

_SLD_DibellaCorrupt0.Enable()  
_SLD_DibellaCorrupt1.Disable()  
_SLD_DibellaCorrupt2.Disable()  
_SLD_DibellaCorrupt3.Disable()    
_SLD_DibellaCorrupt4.Disable()  
_SLD_DibellaCorrupt5.Disable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
; Debug.Notification("Dibella's temple is embracing Sanguine.")

_SLD_DibellaTempleCorruption.SetValue(4)
StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption", _SLD_DibellaTempleCorruption.GetValue() as Int )

_SLD_DibellaCorrupt0.Disable()
_SLD_DibellaCorrupt1.Disable() 
_SLD_DibellaCorrupt2.Disable()  
_SLD_DibellaCorrupt3.Disable()    
_SLD_DibellaCorrupt5.Enable()     
_SLD_DibellaCorrupt4.Disable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
; Debug.Notification("Dibella's temple is tainted.")

_SLD_DibellaTempleCorruption.SetValue(1)
StorageUtil.SetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption", _SLD_DibellaTempleCorruption.GetValue() as Int )

_SLD_DibellaCorrupt0.Disable()
_SLD_DibellaCorrupt1.Enable()    
_SLD_DibellaCorrupt2.Disable()  
_SLD_DibellaCorrupt3.Disable()    
_SLD_DibellaCorrupt4.Disable()  
_SLD_DibellaCorrupt5.Disable()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property _SLD_DibellaCorrupt0  Auto  
ObjectReference Property _SLD_DibellaCorrupt1  Auto  
ObjectReference Property _SLD_DibellaCorrupt2  Auto  
ObjectReference Property _SLD_DibellaCorrupt3  Auto  
ObjectReference Property _SLD_DibellaCorrupt4  Auto  
ObjectReference Property _SLD_DibellaCorrupt5  Auto  

GlobalVariable Property _SLD_DibellaTempleCorruption  Auto  

Scriptname SLS_TRG_HrokiBimbo extends ObjectReference  


ObjectReference Property HrokiRef  Auto  
; Outfit Property _SLS_HrokiOutfit Auto
; Armor Property _SLS_HrokiGloves Auto
; Armor Property _SLS_HrokiBoots Auto
; Armor Property _SLS_HrokiRobe Auto

; String                   Property NINODE_SCHLONG	 	= "NPC Genitals01 [Gen01]" AutoReadOnly
string                   Property SLS_KEY               = "sexlab-stories.esp" AutoReadOnly
String                   Property NINODE_SCHLONG	 	= "NPC GenitalsBase [GenBase]" AutoReadOnly
String                   Property NINODE_LEFT_BREAST    = "NPC L Breast" AutoReadOnly
String                   Property NINODE_LEFT_BREAST01  = "NPC L Breast01" AutoReadOnly
String                   Property NINODE_LEFT_BUTT      = "NPC L Butt" AutoReadOnly
String                   Property NINODE_RIGHT_BREAST   = "NPC R Breast" AutoReadOnly
String                   Property NINODE_RIGHT_BREAST01 = "NPC R Breast01" AutoReadOnly
String                   Property NINODE_RIGHT_BUTT     = "NPC R Butt" AutoReadOnly
String                   Property NINODE_SKIRT02        = "SkirtBBone02" AutoReadOnly
String                   Property NINODE_SKIRT03        = "SkirtBBone03" AutoReadOnly
String                   Property NINODE_BELLY          = "NPC Belly" AutoReadOnly
Float                    Property NINODE_MAX_SCALE      = 4.0 AutoReadOnly
Float                    Property NINODE_MIN_SCALE      = 0.1 AutoReadOnly

; NiOverride version data
int                      Property NIOVERRIDE_VERSION    = 4 AutoReadOnly
int                      Property NIOVERRIDE_SCRIPT_VERSION = 4 AutoReadOnly

; XPMSE version data
float                    Property XPMSE_VERSION         = 3.0 AutoReadOnly
float                    Property XPMSELIB_VERSION      = 3.0 AutoReadOnly

Event OnTriggerEnter(ObjectReference akActionRef)
	Actor akActor = akActionRef as Actor
	Actor kHroki = HrokiRef as Actor
 
	If ( !(akActionRef as Actor).Is3DLoaded() )
		return
	EndIf
 
	If (akActor == HrokiRef) || (akActor == game.GetPlayer())
		Float fBreast  = 0.0 
		Bool bEnableBreast  = NetImmerse.HasNode(kHroki, "NPC L Breast", false)
		Bool bEnableSchlong     = NetImmerse.HasNode(kHroki, "NPC GenitalsBase [GenBase]", false)

		Bool bBreastEnabled     = ( bEnableBreast as bool ) 
		Bool isNiOInstalled = CheckXPMSERequirements(kHroki, true)

		; kHroki.SetOutfit(_SLS_HrokiOutfit)
		; kHroki.AddItem(_SLS_HrokiGloves, 1)
		; kHroki.AddItem(_SLS_HrokiBoots, 1)
		; kHroki.AddItem(_SLS_HrokiRobe, 1)

		StorageUtil.SetIntValue(kHroki, "_SD_iRelationshipType" , 10 )

		if ( bBreastEnabled && isNiOInstalled  ) 
			fBreast  = 2.0

			XPMSELib.SetNodeScale(kHroki, true, NINODE_LEFT_BREAST, fBreast, SLS_KEY)
			XPMSELib.SetNodeScale(kHroki, true, NINODE_RIGHT_BREAST, fBreast, SLS_KEY)
 		
		EndIf 
	EndIf
EndEvent

bool Function CheckXPMSERequirements(Actor akActor, bool isFemale)
	return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction
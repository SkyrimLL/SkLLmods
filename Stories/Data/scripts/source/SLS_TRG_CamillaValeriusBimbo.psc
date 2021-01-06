Scriptname SLS_TRG_CamillaValeriusBimbo extends ObjectReference  



ObjectReference Property CamillaValeriusRef  Auto  
; Outfit Property _SLS_CamillaValeriusOutfit Auto
; Armor Property _SLS_CamillaValeriusGloves Auto
; Armor Property _SLS_CamillaValeriusBoots Auto
; Armor Property _SLS_CamillaValeriusRobe Auto

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
	Actor kCamillaValerius = CamillaValeriusRef as Actor
 
	If ( !(akActionRef as Actor).Is3DLoaded() )
		return
	EndIf
 
	If (akActor == CamillaValeriusRef) || (akActor == game.GetPlayer())
		Float fBreast  = 0.0 
		Bool bEnableBreast  = NetImmerse.HasNode(kCamillaValerius, "NPC L Breast", false)
		Bool bEnableSchlong     = NetImmerse.HasNode(kCamillaValerius, "NPC GenitalsBase [GenBase]", false)

		Bool bBreastEnabled     = ( bEnableBreast as bool ) 
		Bool isNiOInstalled = CheckXPMSERequirements(kCamillaValerius, true)

		; kCamillaValerius.SetOutfit(_SLS_CamillaValeriusOutfit)
		; kCamillaValerius.AddItem(_SLS_CamillaValeriusGloves, 1)
		; kCamillaValerius.AddItem(_SLS_CamillaValeriusBoots, 1)
		; kCamillaValerius.AddItem(_SLS_CamillaValeriusRobe, 1)

		StorageUtil.SetIntValue(kCamillaValerius, "_SD_iRelationshipType" , 10 )

		if ( bBreastEnabled && isNiOInstalled  ) 
			fBreast  = 3.0

			XPMSELib.SetNodeScale(kCamillaValerius, true, NINODE_LEFT_BREAST, fBreast, SLS_KEY)
			XPMSELib.SetNodeScale(kCamillaValerius, true, NINODE_RIGHT_BREAST, fBreast, SLS_KEY)
 		
		EndIf 
	EndIf
EndEvent

bool Function CheckXPMSERequirements(Actor akActor, bool isFemale)
	return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction
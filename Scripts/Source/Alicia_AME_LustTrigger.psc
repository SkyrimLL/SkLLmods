Scriptname Alicia_AME_LustTrigger extends activemagiceffect  

GlobalVariable Property AliciaLustLevel  Auto  

Event OnInit()
	AliciaLustLevel.Setvalue(10000)

EndEvent

Event OnEffectStart(Actor akTarget, Actor akCaster)
  	; Debug.Trace("Magic effect was started on " + akTarget)
	; StorageUtil.SetIntValue(Game.GetPlayer(), "Puppet_SpellON", 1)
	StorageUtil.SetIntValue(Game.GetPlayer(), "Puppet_CastTarget", 1)
	StorageUtil.SetFormValue(Game.GetPlayer(), "Puppet_NewTarget", akTarget)
endEvent
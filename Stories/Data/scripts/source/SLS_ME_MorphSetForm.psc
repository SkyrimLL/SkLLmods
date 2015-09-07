Scriptname SLS_ME_MorphSetForm extends activemagiceffect  

SLS_QST_PolyMorph Property polymorphQuest auto

event OnEffectStart(Actor t, Actor c)
	polymorphQuest.abMorph = t.GetActorBase()
endevent
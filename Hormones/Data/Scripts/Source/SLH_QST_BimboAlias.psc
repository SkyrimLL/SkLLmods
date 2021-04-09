Scriptname SLH_QST_BimboAlias extends ReferenceAlias  

SLH_fctHormonesLevels Property fctHormones Auto
SLH_fctPolymorph Property fctPolymorph Auto
SLH_fctBodyshape Property fctBodyshape Auto
SLH_fctUtil Property fctUtil Auto
SLH_fctColor Property fctColor Auto
SLH_QST_HormoneGrowth Property SLH_Control Auto

slaUtilScr Property slaUtil  Auto  
SexLabFramework Property SexLab  Auto  

Quest Property _SLH_QST_Bimbo  Auto  

Keyword Property ClothingOn Auto
Keyword Property ArmorOn Auto

Bool bArmorOn = false
Bool bClothingOn = false

GlobalVariable      Property GV_isTG                   Auto
GlobalVariable      Property GV_isHRT                   Auto
GlobalVariable      Property GV_isBimbo                 Auto

GlobalVariable      Property GV_isBimboFinal                 Auto
GlobalVariable      Property GV_isBimboLocked                 Auto

GlobalVariable      Property GV_allowTG                Auto
GlobalVariable      Property GV_allowHRT                Auto
GlobalVariable      Property GV_allowBimbo              Auto
GlobalVariable      Property GV_hornyBegArousal              Auto

GlobalVariable      Property GV_bimboClumsinessMod              Auto
GlobalVariable      Property GV_bimboClumsinessDrop    	Auto

Weapon Property ReturnItem Auto

ReferenceAlias Property BimboAliasRef  Auto  
Actor BimboActor 

Int ibimboTransformDate = -1
int iGameDateLastCheck
int daysSinceEnslavement
int iDaysSinceLastCheck
int iDaysPassed

Bool isUpdating = False
Int iCommentThrottle = 0

Bool isMaleToBimbo
Float fSchlongMin
Float fSchlongMax

;===========================================================================
;mod variables
Race Property _SLH_BimboRace Auto
Int bimboClumsyBuffer = 0
Bool isBimboClumsyLegs = false
Bool isBimboClumsyHands = false
Bool isBimboFrailBody = false
Bool isBimboPermanent = false
Bool isClumsyHandsRegistered = False
Bool isClumsyLegsRegistered = False
;===========================================================================

;===========================================================================
;Hack! Recover lost saves where the tf was done on day zero
;===========================================================================
Event OnPlayerLoadGame()
	Actor kPlayer = Game.GetPlayer()
	; if (!isUpdating)
		debugTrace(" game loaded, registering for update")
		if (StorageUtil.GetIntValue(kPlayer, "_SLH_iBimbo")==0) && StorageUtil.GetIntValue(kPlayer, "_SLH_bimboTransformDate") == 0
			StorageUtil.SetIntValue(kPlayer, "_SLH_bimboTransformDate", -1)
			debugTrace(" poor bimbo, are you lost?")
		endif

		isMaleToBimbo =  StorageUtil.GetIntValue(none, "_SLH_bimboIsOriginalActorMale") as Bool

		BimboActor= BimboAliasRef.GetReference() as Actor
		debugTrace(" BimboActor: " + BimboActor)
		debugTrace(" Bimbo Transform date: " + StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") )
		debugTrace(" Player is bimbo: " + StorageUtil.GetIntValue(kPlayer, "_SLH_iBimbo"))

		SLH_Control._updatePlayerState()
		; debug.Notification(" Clumsy mod: " + StorageUtil.GetFloatValue(kPlayer, "_SLH_fBimboClumsyMod" ))

    	RegisterForSingleUpdate( 10 )
    ; else
	; 	debugTrace(" game loaded, is already updating (is it?)")
    ; endif
EndEvent

Function initBimbo()
	Actor kPlayer = Game.GetPlayer()
	isMaleToBimbo =  StorageUtil.GetIntValue(none, "_SLH_bimboIsOriginalActorMale") as Bool

	BimboActor= BimboAliasRef.GetReference() as Actor
	debugTrace(" Init BimboActor: " + BimboActor)
	debugTrace(" Bimbo Transform date: " + StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") )
	debugTrace(" Player is bimbo: " + StorageUtil.GetIntValue(kPlayer, "_SLH_iBimbo"))

	debug.notification("(Giggle)")
	
	RegisterForSingleUpdate( 10 )
EndFunction

;===========================================================================
;[mod] stumbling happens here
;===========================================================================
Event OnUpdateGameTime()
	; Safeguard - Exit if alias not set
	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_iBimbo")==0) || (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == -1)
		Return
	Endif

	updateClumsyBimbo() ;[mod] clumsy bimbo

	; Compatiblity with Parasites - prevent update when full body armor is worn
	if (StorageUtil.GetIntValue(BimboActor, "_SLP_toggleChaurusQueenSkin") == 1)\
	|| (StorageUtil.GetIntValue(BimboActor, "_SLP_toggleChaurusQueenArmor") == 1)\
	|| (StorageUtil.GetIntValue(BimboActor, "_SLP_toggleChaurusQueenBody") == 1)\
	|| (StorageUtil.GetIntValue(BimboActor, "_SLP_toggleLivingArmor") == 1)\
	|| (StorageUtil.GetIntValue(BimboActor, "_SLP_toggleTentacleMonster") == 1)
		RegisterForSingleUpdateGameTime(6)
		Return
	endif
	If BimboActor.IsDead()\
	|| BimboActor.IsOnMount()\
	|| BimboActor.IsBleedingOut()\
	|| BimboActor.IsInCombat()\
	|| BimboActor.IsTrespassing()\
	|| BimboActor.IsFlying()\
	|| BimboActor.IsUnconscious()\
	|| SexLab.IsActorActive(BimboActor)\
	|| !Game.IsMovementControlsEnabled()\
	|| !Game.IsActivateControlsEnabled()
		; try again in 15 minutes
		RegisterForSingleUpdateGameTime(0.25)
		Return
	EndIf

	iDaysPassed = Game.QueryStat("Days Passed")
	daysSinceEnslavement = iDaysPassed - ibimboTransformDate
	iDaysSinceLastCheck = iDaysPassed - iGameDateLastCheck

	StorageUtil.SetIntValue(BimboActor, "_SLH_bimboTransformGameDays", daysSinceEnslavement)
	StorageUtil.SetIntValue(BimboActor, "_SLH_iAllowBimboThoughts", 1)

	If iDaysSinceLastCheck >= 1
		Debug.Trace( "[SLH] Bimbo status update - Days transformed: " + daysSinceEnslavement )

		bimboDailyProgressiveTransformation(BimboActor, GV_isTG.GetValue() == 1)

		If daysSinceEnslavement < 16
			if (StorageUtil.GetIntValue(BimboActor, "_SLH_allowBimboRace")==0)
				fctBodyshape.alterBodyByPercent(BimboActor, "Weight", 6.0)
				fctBodyshape.alterBodyByPercent(BimboActor, "Breast", 6.0)
			else
				fctBodyshape.alterBodyByPercent(BimboActor, "Weight", 3.0)
				fctBodyshape.alterBodyByPercent(BimboActor, "Breast", 3.0)
			endif

			If isMaleToBimbo
				If (Utility.RandomInt(0,100) <= (StorageUtil.GetFloatValue(BimboActor, "_SLH_fHormoneBimbo") as Int)) || (StorageUtil.GetIntValue(none, "_SLH_iBimboPlusON") == 1)
					; First person thought
					; Male to female bimbo
					if (daysSinceEnslavement==1)
						SLH_Control.playChuckle(BimboActor)
						debug.messagebox("My lips feel swollen, and are somehow a bit redder than before. They also feel quite tingly and pleasant when I brush my fingers against them - accidentally of course! Maybe they're bruised somehow? I wonder if I should be worried...  ")
					elseif (daysSinceEnslavement==2)
						SLH_Control.playChuckle(BimboActor)
						debug.messagebox("This is definitely getting weirder! My eyelids felt a bit numb and tingly, and I can feel them coverd with a dark eye shadow that has so far managed to thwart all my removal attempts. Oh Gods... what is happening to me? How am I supposed command respect when I look like this?!")
					elseif (daysSinceEnslavement==3)
						SLH_Control.playChuckle(BimboActor)
						debug.messagebox("This is ridiculous! My hair has lightened overnight into a shade of tacky, platinum blonde that, of course, couldn't be washed off, and seems to remain bright and shiny regardless of how dirty it gets. Worse still, I think my cock is shrinking, and getting more sensitive every day. Squeezing my legs and rubbing it frequently only provides temporary relief. I got to find a way to stop this!")
					elseif (daysSinceEnslavement==4)
						SLH_Control.playGiggle(BimboActor)
						debug.messagebox("Nonononono... Why is this happening to me?! It's not enough that I wake up to find my slutty makeup perfectly re-applied without a smudge, I now find myself with gaudy, pink fingernails that feel tougher than any armor - not that I've had much use for armors lately, what with my slutty looks and all. Everything now looks so confusing and difficult, maybe I should find a smart, tough m..ma..companion to fight for me...")
					elseif (daysSinceEnslavement==5)
						SLH_Control.playGiggle(BimboActor)
						debug.messagebox("I wake up to find my toenails the same shade of glittery, girly pink that just HAPPEN to perfectly match my fingers. *sigh*... what's another thing on top of everything else... I still haven't been able to figure out what's happening to my body, and my cock is definitely shrinking, though I guess it's not such a bad thing, since it's becoming so much more pleasurable to play with, I can almost cum instantly when I pinch and squeeze my little cli..cock with those slutty nails - not that I've ever tried, Gods no!")
					elseif (daysSinceEnslavement==6)
						SLH_Control.playGiggle(BimboActor)
						debug.messagebox("This curse is definitely doing something to my strength. The weapons I used to wield with ease now seem so big and cumbersome. *pout* Why can't blacksmiths make smaller, daintier weapons? It's not like everyone can swing a giant claymore like those Companions... Melee combat is sooo icky anyways, all that blood and gore are going to ruin my clothes!")
					elseif (daysSinceEnslavement==7)
						SLH_Control.playMoan(BimboActor)
						debug.messagebox("I woke up to a sharp, stabbing pain in my ears. In my groggy state, I discovered two shiny, golden studs piercing my earlobes. I mean, earrings aren't so bad, right? Lots of strong, burly men have pierced ears, though admittedly nothing so feminine and dainty as mine. B-but I think these earrings are made of solid gold, that's something, right? Like, I can totally pull off the look if I wanted to.")
					elseif (daysSinceEnslavement==8)
						SLH_Control.playMoan(BimboActor)
						debug.messagebox("Ouchie! I just felt a series of unpleasant, rapid pinpricks on my lower back, like I'm being stabbed by a bunch of MEAN needles. Since I can't see my behind *giggle*, I guess this minor inconvenience is the price I pay to look pretty. Speaking of pretty, my cock looks so soft and adorable now that those UGLY balls have melted into my crotch. Gods, I'm getting horny thinking about the naughty things I want to do to my cute little cock. Maybe I should tease it again tonight *giggle*")
					elseif (daysSinceEnslavement==9)
						SLH_Control.playMoan(BimboActor)
						debug.messagebox("Owww... I just felt more pinpricks on my lower back, I guess my old tattoo isn't slutty enough? Boooo... I wish getting a tattoo isn't so uncomfortable! Until my new tattoos heal, I'll have to lie on my side when I sleep, and my breasts keep getting in the way. Maybe I should ask a girl for advice? ")
					elseif (daysSinceEnslavement==10)
						SLH_Control.playMoan(BimboActor)
						debug.messagebox("I happen to be on my back *giggle* when I felt the familiar pinpricks on my tummy, so I moved my boobies to the side to see how the slutty tattoo is applied. So, umm... the ink like, just appeared on my skin like magic! Maybe it's con...conju-something magic? *sigh* If only I was smart enough to join the College.  Gosh, thinking is making my head hurt. I guess the men are right, I should think less, and suck more (good girls always swallow! <3). To that end, I now have a suuuper slutty BIMBO FUCKTOY tattoo right above my boy clit! Yay!")
					elseif (daysSinceEnslavement==11)
						SLH_Control.playRandomSound(BimboActor)
						debug.messagebox("Ooouchie! Another stab, this time right above my navel! Why can't getting a piercing be more pleasant? I mean, I'm not complaining, since my new navel stud looks suuuper hawt, oh wait, I think I just did, I'm such a silly girl sometimes *giggle*. Ohhh, I think my boy clit likes it too. Mhmmm, clit. I can't believe I used to like having a big, dangly thing between my legs, this soft and cute clit is so much better - it throbs like crazy too, especially when big, strong men pinch and squeeze it. *giggle* I think I'm getting turned on again. I love how my boy clit stays nice and soft no matter what...")
					elseif (daysSinceEnslavement==12)
						SLH_Control.playRandomSound(BimboActor)
						debug.messagebox("Yay! My boy clit has shrunk so much that a warm, inviting slit has appeared underneath it. Ohhh, I know! I man once told me that sluts have clitties and titties, so I'm going to call her clitty *giggle*. Now I just need to find a real man to help me pop my cherry *giggle*. As I tried to stand, my silly, clumsy feet refuse to cooperate and I fell onto my butt like the ditzy bimbo that I am. As I look down, I realize my feet are actually stuck in a high-heeled position, and they refuse to flex, like, at all. *giggle* I guess it's only slutty heels for me from now on, not that I mind, since men seem to love it when I strut around in heels, and stilettos make my bubble butt look AMAZING.")
					elseif (daysSinceEnslavement==13)
						SLH_Control.playRandomSound(BimboActor)
						debug.messagebox("Ouchie! Those meanie tattoo needles are back again, this time right above my smooth, slutty slit. *pout* I guess I still don't look slutty enough? The new tattoo looks like a...a...mountain? Oh, *giggle* I'm so dumb, I'm like, reading it upside down. I think it says umm...IN-INS...INS-E.R..T COCK, with umm, an arrow? Whatever that means. Ohhh!! I think it's, like, umm, a secret message for the, um, super smart men who use my pussy? *giggle* I'll let the men figure it out, my job is to spread my legs and look pretty. Actually, I should probably, like, let everyone cum in my pussy anyways since, umm...umm...a good bimbo always begs men to cum inside her. That's like, a rule!")
					elseif (daysSinceEnslavement==14)
						SLH_Control.playRandomSound(BimboActor)
						debug.messagebox("Ouuuchie! The evil piercing needle is back! I think I totally caught a glimpse of it when it pierced my swollen nipples. Ohhh, those golden barbells are sooo slutty, they are, like, totally the perfect accessory for my bimbo nips. Not that I've had any trouble keeping them hard, but these would definitely make sure my slutty nips stay hard *giggle* all the time. Besides, I should't complain since it's helping me make my body more fuckable. Men are so strong and dominant when they fuck me, like I'm some fucktoy to be used for THEIR pleasure. I can't believe I used to fantasize about fucking women, being fucked is so much better! *giggle*")
					elseif (daysSinceEnslavement==15)
						SLH_Control.playRandomSound(BimboActor)
						debug.messagebox("Yay! Mr. Needle is back! I came this time when the thick *giggle* needle slowly pierced my clitty. It was, like, sooooo sensitive, I think I umm, lost count of my orgasms and passed out? When I woke up, I found a SUUUPER shiny and slutty barbell in my clitty. It's solid gold too! Nothing but the best for my slutty nub! The weight of the barbell also pulls my little clitty out of its hood, so men can see the extent of my modified body! This piercing is like, perfect for showing off my new clitty, and the golden barbell is so slutty and umm, fu-func...functions good! It, like, totally matches my other lewd piercings. Thank you Mr. Needle, for making my body more slutty and fuckable! <3")				
					endif
				else
					; Third person thought
					; Male to female bimbo
					if (daysSinceEnslavement==1)
						debug.messagebox("Your boobs are growing larger every day. You find it more and more difficult to resist cupping them and feeling their weight in your hand. If they grow any larger, they will make using bows and armors a lot more difficult. That's alright though.. bimbos don't need to fight. They get others to fight for the right to use them.")
					elseif (daysSinceEnslavement==2)
						debug.messagebox("Your lips are full and feel parched if they are not frequently coated with semen. Who knew semen tasted so good. A good bimbo doesn't let a drop go to waste. It has to land on her or better, deep inside.")
					elseif (daysSinceEnslavement==3)
						debug.messagebox("Your cock is shrinking and getting more sensitive every day. Squeezing your legs and rubbing it frequently only provide temporary relief and wets your expanding vagina. Don't worry about your cock little bimbo... you will get plenty of cocks to squeeze.")
					elseif (daysSinceEnslavement==4)
						debug.messagebox("Everything around you looks so confusing and difficult. Except for sex. Sex is easy and fun. Being horny makes your hand shake and your legs weak with anticipation. Being a slut is one of the many perks of being a bimbo.")
					endif
				endIf
			Else
				If (Utility.RandomInt(0,100) <= (StorageUtil.GetFloatValue(BimboActor, "_SLH_fHormoneBimbo") as Int)) || (StorageUtil.GetIntValue(none, "_SLH_iBimboPlusON") == 1)
					; First person thought
					SLH_Control.playGiggle(BimboActor)
					; Female to female bimbo
					if (daysSinceEnslavement==1)
						SLH_Control.playChuckle(BimboActor)
						debug.messagebox("My lips feel swollen, and are somehow a bit redder than before. They also feel quite tingly and pleasant when I brush my fingers against them - accidentally of course! Maybe they're bruised somehow? I wonder if I should be worried...  ")
					elseif (daysSinceEnslavement==2)
						SLH_Control.playChuckle(BimboActor)
						debug.messagebox("This is definitely getting weirder! My eyelids felt a bit numb and tingly.. and sticky too, like I'm sporting dark, slutty eyeshadow that has so far managed to thwart all my removal attempts. Oh Gods... what are the others going to think? How am I supposed command respect when I look like this?!")
					elseif (daysSinceEnslavement==3)
						SLH_Control.playChuckle(BimboActor)
						debug.messagebox("This is ridiculous! My hair has lightened overnight into a shade of tacky, shimmering, platinum blonde that, of course, couldn't be washed off, and seems to remain bright and shiny regardless of how dirty it gets. Worse, I think my vagina is becoming really sensitive, especially my clitoris, which seems to become more sensitive with each passing day. My breeches feel too rough and restrictive, and squeezing my thighs only provides temporary reprieve to this maddening sensation. I got to find a way to stop this!")
					elseif (daysSinceEnslavement==4)
						SLH_Control.playGiggle(BimboActor)
						debug.messagebox("Nonononono... Why is this happening to me?! It's not enough that I wake up every morning to find my slutty makeup perfectly re-applied without a smudge, I now find myself with gaudy, pink fingernails that seem tougher than any armor - not that I've had much use for armors lately, what with my slutty looks and all. Everything now looks so confusing and difficult, maybe I should find a smart, tough m..ma..companion to fight for me...")
					elseif (daysSinceEnslavement==5)
						SLH_Control.playGiggle(BimboActor)
						debug.messagebox("I wake up to find my toenails the same shade of glittery pink that just HAPPEN to perfectly match my fingers. *sigh*... what's another change on top of everything else... I still haven't been able to figure out what's happening to my body, and my clit is definitely far more sensitive than before, though I guess it's not such a bad thing, since my clit's becoming so much more pleasurable to play with; I can almost cum instantly when I pinch and squeeze the little nub - not that I've tried! ")
					elseif (daysSinceEnslavement==6)
						SLH_Control.playGiggle(BimboActor)
						debug.messagebox("This curse is definitely doing something to my strength. The weapons I used to wield with ease now seem so big and cumbersome. *pout* Why can't blacksmiths make smaller, daintier weapons? It's not like everyone has the strength to wield a giant sword... While I'm on the subject, why are armors so heavy and bulky? I can barely lift my weapons as-is. I have, however, found a solution to all the distracting rubbings against my ever sensitive clit: I made a small, round cutout on my breeches to completely expose my swollen clit, and that seems to remove most pressures on the poor nub. ")
					elseif (daysSinceEnslavement==7)
						SLH_Control.playMoan(BimboActor)
						debug.messagebox("I woke up to sharp, stabbing pain in my ears. In my groggy state, I was a bandit I could suck, but when I felt around my ears, I discovered two shiny, golden studs piercing my earlobes. I mean, earrings aren't so bad, right? Lots of people have pierced ears, even some men these days wear earrings, though admittedly nothing as dainty or glittery as mine. B-but I think these earrings are made of solid gold, that's something, right? Like, I can totally pull off the look if I wanted to. ")
					elseif (daysSinceEnslavement==8)
						SLH_Control.playMoan(BimboActor)
						debug.messagebox("Ouchie! I just felt a series of unpleasant, rapid pinpricks on my lower back, like I'm being stabbed by a bunch of MEAN needles. Hmm, so I guess that's what getting a tattoo felt like, and above my plump butt too. So, the ink umm, just, kind of appeared on my skin like magic! Maybe it's con..comju...cumju-something magic? I'm probably too dumb to understand how it works.")
					elseif (daysSinceEnslavement==9)
						SLH_Control.playMoan(BimboActor)
						debug.messagebox("Owww, I just felt more pinpricks on my lower back, I guess my old tattoo isn't slutty enough? *pout* I wish getting a tattoo isn't so uncomfortable! Sleeping on my back is completely out of the question until my new tattoos heal, so now I have to lie on my side when I rest, and my boobies keep getting in the way. Who knew having big boobies would be such a hassle, but I guess that's the price I pay to look pretty. Speaking of pretty, my clit looks so adorable all swollen and exposed like this, I wonder why I ever bothered with breeches, since they only hinder a man's access to my clit. For some reason, men seem to HATE it when I hinder their access to my clit in any way. Maybe I should let them tease it again tonight *giggle*")
					elseif (daysSinceEnslavement==10)
						SLH_Control.playMoan(BimboActor)
						debug.messagebox("I happened to be on my back *giggle* when I felt the familiar pinpricks on my tummyI had to pull my boobies to the side so I can see how the slutty tattoo is applied. I should think less, and suck more (good girls always swallow! <3). Men are so nice to me when I smile and let them play with my big boobies. Oh and I now have a suuuper slutty BIMBO FUCKTOY tattoo on my tummy to show off to all the cute boys! Yay!")
					elseif (daysSinceEnslavement==11)
						SLH_Control.playRandomSound(BimboActor)
						debug.messagebox("Ooouchie! Another stab, this time right above my navel! Why can't getting a piercing be more pleasant? I mean, I'm not complaining, since my new navel stud looks suuuper hawt, oh wait, I think I just did, I'm such a silly bimbo sometimes *giggle*. Yay! The piercing even glitters, this will definitely help me attract more boys. Ohhh, I think my clit likes it too. Mhmmm, clit. I think a nice man once told me that sluts don't have clits, they have clitties, which rhymes with boobies, wait... no, not boobies, titties. I have a clitty and two titties. I'm like, super smart!")
					elseif (daysSinceEnslavement==12)
						SLH_Control.playRandomSound(BimboActor)
						debug.messagebox("I can't believe I used to hate having random men touch my clitty, they are so kind and gentle when they pinch and squeeze my exposed nub, and I always get the BEST orgasms when someone else plays with my body! My cute, pea sized clitty is sooo sensitive, I can't even breathe on it without shuddering all over! As I tried to stand, my silly, clumsy feet refuse to cooperate and I fell onto my butt like the ditzy bimbo that I am. *giggle* As I look down, I realize my feet are actually stuck in a slutty high-heeled position! They seem to refuse to flex, like, at all. *giggle* I guess it's only super slutty heels for me from now on. Not that I mind, since I get so many compliments when I wear stilettos, and they make my bubble butt look AMAZING and super fuckable.")
					elseif (daysSinceEnslavement==13)
						SLH_Control.playRandomSound(BimboActor)
						debug.messagebox("Ouchie! Those mean tattoo needles are back again, this time right above my smooth, slutty slit. *pout* I guess I still don't look slutty enough? The new tattoo looks like a...mountain? Oh, *giggle* I'm so dumb, I'm like, reading it upside down. I think it says umm...IN-INS...INS-E.R..T COCK, with umm, an arrow? Whatever that means. Ohhh!! I think it's, like, umm, a secret message for the, um, super smart men who use my pussy? I'll let the men figure it out, my job is to spread my legs and look pretty. Like, the first one to figure it out gets to cum in my pussy! Actually, I should probably, like, let everyone cum in my pussy anyways since, umm...umm...a good bimbo always begs men to cum inside her. That's like, a rule!")
					elseif (daysSinceEnslavement==14)
						SLH_Control.playRandomSound(BimboActor)
						debug.messagebox("Ouuuchie! The evil piercing needle is back! I think I totally caught a glimpse of it when it pierced my swollen nipples. Ohhh, those golden barbells are sooo slutty, they are, like, totally the perfect accessory for my bimbo titties. Not that I've been having trouble keeping my nipples hard, *giggle* but these would definitely make sure my slutty nips stay hard *giggle* all the time. Besides, I should't complain since it's helping me make my body more fuckable. Like what my men kept telling me, I should always accept modifications that make my body more enjoyable to fuck. *giggle* Men are so nice when they are fucking me. <3")
					elseif (daysSinceEnslavement==15)
						SLH_Control.playRandomSound(BimboActor)
						debug.messagebox("Yay! Mr. Needle is back! I totally felt it this time when the thick *giggle* needle slowly pierced my red, swollen clitty. My clitty was, like, sooooo sensitive, I totally came over and over on the needle like a dirty slut in heat, and I think I umm, lost count and passed out? When I woke up, I found a SUUUPER shiny and slutty barbell in my clitty. It's solid gold too! The weight of the barbell also pulls my little clitty out of its hood, so men don't have to make me to peel back my hood when they abuse my clitty! I'm no good at it anyways since my bimbo nails always get in the way. This piercing is like, so slutty and umm, fu-func...functions good!")				
					endif
				Else
					; Third person thought
					if (daysSinceEnslavement==1)
						debug.messagebox("Your boobs are growing larger every day and your hair is definitely blonde now. Forget about wearing armor and using bows, you will soon have to rely on your charms to get a strong warrior to fight for you... maybe he will give you a good fuck too.")
					elseif (daysSinceEnslavement==2)
						debug.messagebox("The constant tingle in your tits is only relieved after they have been sucked on for a long time, or tweaked.. or pinched with your long pink nails. Damn.. just thinking about it made them tingle again.")
					elseif (daysSinceEnslavement==3)
						debug.messagebox("Forget about using swords as well. You constantly crave only one kind of sword now... the hard and throbbing kind. There is nothing a good bimbo wouldn't do for a good cock in her hand.. or lips.. or lodged deep inside her.")
					elseif (daysSinceEnslavement==4)
						debug.messagebox("Sex is all you can think about now.. you crave it.. your tits crave it.. you lips crave it. Being horny makes your hand shake and your legs weak with anticipation. Being a slut is one of the many perks of being a bimbo.")
					endif
				Endif
			EndIf
		endif

		if GV_isTG.GetValue() == 1
			If isMaleToBimbo
				If (StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlong") >= StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlongMin") ) && ( daysSinceEnslavement < 11 )
					fctBodyshape.alterBodyByPercent(BimboActor, "Schlong", -10.0)
					BimboActor.SendModEvent("SLHRefresh")
				elseIf (daysSinceEnslavement >= 12)
					BimboActor.SendModEvent("SLHRemoveSchlong")
					Sexlab.TreatAsFemale(BimboActor)
					_SLH_QST_Bimbo.SetStage(18)
					SLH_Control.setTGState(BimboActor, FALSE)
				endif
			Else
				If (StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlong") <= StorageUtil.GetFloatValue(BimboActor, "_SLH_fSchlongMax") ) && ( daysSinceEnslavement < 15 )
					fctBodyshape.alterBodyByPercent(BimboActor, "Schlong", 10.0)
					BimboActor.SendModEvent("SLHRefresh")
				elseif (daysSinceEnslavement >= 16)
					_SLH_QST_Bimbo.SetStage(16)
					SLH_Control.setTGState(BimboActor, FALSE)
				endif
			EndIf
		endif

		iGameDateLastCheck = iDaysPassed

		RegisterForSingleUpdateGameTime(24)
	Endif
EndEvent

Event OnActorAction(int actionType, Actor akActor, Form source, int slot)
	; Safeguard - Exit if alias not set
	if (StorageUtil.GetIntValue(Game.GetPlayer(), "_SLH_iBimbo")==0)
		;debugTrace(" bimbo OnActorAction, None")
		Return
	Endif

	BimboActor= BimboAliasRef.GetReference() as Actor

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == -1)
		Return
	Endif

	if (akActor == BimboActor)
		clumsyBimboHands(actionType, akActor, source, slot)
	EndIf
EndEvent

Event OnUpdate()
	; Safeguard - Exit if alias not set
	if (StorageUtil.GetIntValue(Game.GetPlayer(), "_SLH_iBimbo")==0)
		; Debug.Notification( "[SLH] Bimbo status update: " + StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") as Int )
		Debug.Trace( "[SLH] Bimbo alias is None: " )
		; try again later
		RegisterForSingleUpdate( 10 )
		Return
	Endif

	Utility.Wait(0.1) ;To prevent Update on Menu Mode

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == -1)
		; debugTrace(" bimbo OnUpdate, No TF Date")
		RegisterForSingleUpdate( 10 )
		Return
	Endif

	If (StorageUtil.GetIntValue(BimboActor, "_SD_iSlaveryExposure") <= 150)
		StorageUtil.SetIntValue(BimboActor, "_SD_iSlaveryExposure", 150)
	EndIf

	StorageUtil.SetIntValue(BimboActor, "_SD_iSlaveryLevel", 6)
	If (StorageUtil.GetIntValue(BimboActor, "_SD_iDom") > 0)
		Debug.Messagebox("A wave of submissiveness washes over you. A bimbo doesn't need to think, she needs only to server her master as a perfect slave. Remember your place little slut.")
		StorageUtil.SetIntValue(BimboActor, "_SD_iDom", 0)
	EndIf
	If (StorageUtil.GetIntValue(BimboActor, "_SD_iSub") < 0)
		StorageUtil.SetIntValue(BimboActor, "_SD_iSub", 0)
	EndIf

	if (isBimboClumsyLegs)
		clumsyBimboLegs(BimboActor)
	endif

	RegisterForSingleUpdate(5.4)
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	; Safeguard - Exit if alias not set
	if (StorageUtil.GetIntValue(Game.GetPlayer(), "_SLH_iBimbo")==0)
		Return
	Endif

	Actor kPlayer = Game.GetPlayer()
	Float fClumsyMod = StorageUtil.GetFloatValue(kPlayer, "_SLH_fBimboClumsyMod" ) 
	BimboActor= BimboAliasRef.GetReference() as Actor

	; Safeguard - Evaluate the rest only when transformation happened
	if (StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformDate") == -1)
		Return
	Endif
	
	If (akAggressor == BimboActor)
		;
		; If (BimboActor.IsUnconscious())
		;	BimboActor.SetUnconscious(false)
		; EndIf	


	ElseIf (akAggressor != None && isBimboFrailBody) ;[mod] check if is a weak bimbo
		;  Debug.Trace("We were hit by " + akAggressor)
		; debug.Notification("[SLH] Bimbo is hit")
      	;If ((randomNum>90) && (BimboActor.GetActorValuePercentage("health")<0.3)) ; && (!(akAggressor as Actor).IsInFaction(pCreatureFaction)))

		float bimboArousal = slaUtil.GetActorArousal(BimboActor) as float
		float dropchance = 1.0 + (bimboArousal / 30.0 ) * (GV_bimboClumsinessMod.GetValue() as Float) * fClumsyMod
		; debugTrace(" bimbo beeing hit, drop chance: " + dropchance)
      	If (Utility.RandomInt(0,100) <= dropchance) &&  (GV_bimboClumsinessMod.GetValue()!=0); && (!(akAggressor as Actor).IsInFaction(pCreatureFaction)))
			
			if BimboActor.IsWeaponDrawn() 
				If BimboActor.GetEquippedItemType(1) > 1 && BimboActor.GetEquippedItemType(1) != 9 && BimboActor.GetEquippedItemType(1) != 7
					Debug.Notification("The enemy made you lose your grip!")
					dropWeapons(BimboActor, 1) ;only the weapon
				elseIf BimboActor.GetEquippedItemType(0) > 1 && BimboActor.GetEquippedItemType(0) != 9
					Debug.Notification("The enemy made you lose your grip!")
					dropWeapons(BimboActor, 0) ;only the weapon
				endIf
			endIf
				;

			Debug.Notification("They are so mean hitting you like that!")
			; dropWeapons(BimboActor, both = false, chanceMult = 1.0) ;only the weapon
		    ;if(BimboActor.IsWeaponDrawn())
		    ;    BimboActor.SheatheWeapon()
		    ;    Utility.Wait(2.0)
		    ;endif

		    ; unequip weapons
		    ;Weapon wleft = BimboActor.GetEquippedWeapon(0)
		    ;Weapon wright = BimboActor.GetEquippedWeapon(1)
		    ;if (wleft != None)
		    ;    BimboActor.UnequipItem(wleft, 0)
		    ;endif
		    ;if (wright != None)
		    ;    BimboActor.UnequipItem(wright, 1)
		    ;endif

		EndIf



	EndIf

EndEvent


;===========================================================================
;should really drop the weapons or just unequip it?
;move this to a mcm option
;===========================================================================
Function DropOrUnequip(Actor akActor, Form akObject, bool drop = true)
	If drop && (GV_bimboClumsinessDrop.GetValue() == 1)
		akActor.UnequipItem(akObject, False, True)
		objectreference TempRef = akObject as objectreference
		if !TempRef && TempRef == none ; To prevent drop Quest objects and hopefully Bound Weapons
			akActor.DropObject(akObject)
		;	TempRef = akActor.DropObject(akObject)
		;	if TempRef != none && TempRef.GetActorOwner() == none
		;		TempRef.SetActorOwner(akActor.GetActorBase())
		;	endIf
		endIf
	else
		akActor.UnequipItem(akObject, false, true)
	EndIf
EndFunction

;===========================================================================
;This makes the actor drop his weapons, with a chance based on his stamina
;credit: copied from devious hepless, with some changes
;parameters:
;Actor pl = actor who will drop the weapons
;bool both = should drop both weapons
;float chanceMult = increase the chance to drop
;===========================================================================
int[] function dropWeapons(Actor pl, int Slot = -1, float chanceMult = 1.0)
	; By default, drops only stuff on left hand, if both == true, also right hand
	; returns an array of dropped item counts, weapon & shield at 0, spells at 1
	; debugTrace(" dropWeapons(both = "+both+", chanceMult = "+chanceMult+")")
	
	Utility.Wait(0.1) ;To prevent Update on Menu Mode

	; Calculate the drop chance
	float spellDropChance = ( 101.0 - ( pl.GetAvPercentage("Stamina") * 100.0 ) ) ; inverse of stamina percentage
	;int arousal = 0
	;if (pl != None)
	;	arousal = slaUtil.GetActorArousal(pl)
	;else
	;	Debug.Trace("[sla] null player on dropWeapons")
	;endif
	;if arousal >= 30 ; If arousal is over 30, increase the drop chance
	;	arousal = ( arousal - 30 ) / 2 ; 0 - 35% extra
	;	spellDropChance = spellDropChance + arousal
	;endIf
	
	spellDropChance *= chanceMult
	
	if spellDropChance > 100
		spellDropChance = 100
	elseif spellDropChance < 0
		spellDropChance = 0
	endif

	; debugTrace(" weapon drop chance: " + spellDropChance)
	
	int[] drops = new int[2]
	drops[0] = 0
	drops[1] = 0
		
	float chance = Utility.RandomInt(0, 99)
	
	; int i = 2
	bool drop = true
	if Slot < 0 || Slot > 1
		int i = 2
		While i > 0 && pl.IsWeaponDrawn()
			i -= 1
			if Utility.IsInMenuMode() ; Recalculate if open menu to drink stamina potion
				Utility.Wait(0.1)
				spellDropChance = ( 101.0 - ( pl.GetAvPercentage("Stamina") * 100.0 ) ) ; inverse of stamina percentage
				spellDropChance *= chanceMult
				
				if spellDropChance > 100
					spellDropChance = 100
				elseif spellDropChance < 0
					spellDropChance = 0
				endif
				
				; debugTrace(" weapon drop chance: " + spellDropChance)
			EndIf
			if i == 0
				Utility.Wait(1.0) ; Equipping the secondary set takes a while...
			EndIf
			Form Equipped = pl.GetEquippedObject(i)
			int Type = 0
			Float Weight
			if Equipped
				Type = pl.GetEquippedItemType(i)
				Weight = Equipped.GetWeight()
			EndIf
			
			If Type == 9 ; Magic spell
				if chance < spellDropChance
					if i == 1 && pl.GetEquippedItemType(0) == Type
						pl.SheatheWeapon()
					else
						pl.UnequipSpell(Equipped as spell, i)
					endIf
					drops[1] = drops[1] + 1
				endIf
			ElseIf pl.IsOnMount() && (Type > 4 && Type < 7) ; Two-handed Weapon
				if chance < ((spellDropChance + Weight) * 2) ; Are heavy and handed with just one hand when mounting so the chance of drop it is even bigger
					DropOrUnequip(pl, Equipped, drop)
					drops[0] = drops[0] + 1
					drop = false
				endIf
			ElseIf Type == 10 || (Type > 4 && Type < 7) ; Two-handed Weapon and Shield
				if chance < ((spellDropChance + Weight) * 0.75) ; Are heavy but well handed so the chance of drop it is not too high
					DropOrUnequip(pl, Equipped, drop)
					drops[0] = drops[0] + 1
					drop = false
				endIf
			ElseIf Type == 2 ; One-handed Dagger
				if chance < ((spellDropChance + Weight) * 0.5)
					DropOrUnequip(pl, Equipped, drop)
					drops[0] = drops[0] + 1
				endIf
			ElseIf Type > 0 
				if chance < ((spellDropChance + Weight) * 1.25)
					DropOrUnequip(pl, Equipped, drop)
					drops[0] = drops[0] + 1
				endIf
			endIf
	
			If drops[0] > 0
			; Some weapons are dropped already, make sure to unequip any spells on the second iteration as well
				spellDropChance = 100
			EndIf
		EndWhile
	else
		Form Equipped = pl.GetEquippedObject(Slot)
		int Type = 0
		Float Weight
		if Equipped
			Type = pl.GetEquippedItemType(Slot)
			Weight = Equipped.GetWeight()
		EndIf
		
		If Type == 9 ; Magic spell
			if chance < spellDropChance
				pl.UnequipSpell(Equipped as spell, Slot)
				drops[1] = drops[1] + 1
			endIf
		ElseIf Type == 7 && Slot == 1 ; Bow Rigth Hand
			if chance < spellDropChance ; Is the hand of the line so the chance of drop the Bow is low
				DropOrUnequip(pl, Equipped, drop)
				drops[0] = drops[0] + 1
			endIf
		ElseIf pl.IsOnMount() && (Type > 4 && Type < 7) ; Two-handed Weapon and Shield
			if chance < ((spellDropChance + Weight) * 2) ; Are heavy and handed with just one hand when mounting so the chance of drop it is even bigger
				DropOrUnequip(pl, Equipped, drop)
				drops[0] = drops[0] + 1
			endIf
		ElseIf Type == 10 || (Type > 4 && Type < 7) ; Two-handed Weapon and Shield
			if chance < ((spellDropChance + Weight) * 0.75) ; Are heavy but well handed so the chance of drop it is not too high
				DropOrUnequip(pl, Equipped, drop)
				drops[0] = drops[0] + 1
			endIf
		ElseIf Type == 2 ; One-handed Dagger
			if chance < ((spellDropChance + Weight) * 0.5)
				DropOrUnequip(pl, Equipped, drop)
				drops[0] = drops[0] + 1
			endIf
		ElseIf Type > 0 
			if chance < ((spellDropChance + Weight) * 1.25)
				DropOrUnequip(pl, Equipped, drop)
				drops[0] = drops[0] + 1
			endIf
		endIf
	endIf
	return drops
endFunction

;===========================================================================
;called to start the clumsiness
;===========================================================================
function updateClumsyBimbo()
	int rollFirstPerson  = Utility.RandomInt(0,100)
	BimboActor= BimboAliasRef.GetReference() as Actor
	If (rollFirstPerson <= (StorageUtil.GetFloatValue(Game.GetPlayer(), "_SLH_fHormoneBimbo") as Int))
		; First person thought
	    if (isBimboClumsyHands && !isClumsyHandsRegistered)
	    	isClumsyHandsRegistered = True
			RegisterForActorAction(0) ; Weapon Swing
			RegisterForActorAction(5) ; Bow Draw
			SLH_Control.playMoan(BimboActor)
			Debug.Notification("I'm so horny I can't carry a thing.")
		endif

		if (isBimboClumsyLegs && !isClumsyLegsRegistered)
	    	isClumsyLegsRegistered = True
	    	RegisterForSingleUpdate(2.7) ;walking
			SLH_Control.playRandomSound(BimboActor)
			Debug.Notification("I need to fuck. Now!")
	    endif
	else
		; Third person thought
	    if (isBimboClumsyHands && !isClumsyHandsRegistered)
	    	isClumsyHandsRegistered = True
			RegisterForActorAction(0) ; Weapon Swing
			RegisterForActorAction(5) ; Bow Draw
			Debug.Notification("Your hands feel weak, trembling with arousal.")
		endif

		if (isBimboClumsyLegs && !isClumsyLegsRegistered)
	    	isClumsyLegsRegistered = True
	    	RegisterForSingleUpdate(2.7) ;walking
			Debug.Notification("You feel clumsy, your hips swaying without control.")
	    endif
	endIf
endfunction

;===========================================================================
; messages shown when the player drop his weapons trying to attack
; TOOD change this messages, was just a quick thing
;===========================================================================
string Function randomBimboHandsMessage(float bimboArousal, int actionType)
	int chance = Utility.RandomInt(0, 5)
	int rollFirstPerson  = Utility.RandomInt(0,100)
	String handMessage
	BimboActor= BimboAliasRef.GetReference() as Actor

	If (rollFirstPerson <= (StorageUtil.GetFloatValue(Game.GetPlayer(), "_SLH_fHormoneBimbo") as Int))
		; First person thought
		SLH_Control.playRandomSound(BimboActor)
		if bimboArousal > 40
			if chance < 1
				handMessage = "My tits feel so full and soft."
			elseif chance < 2
				handMessage = "I could use cock like.. right now."
			elseif chance < 3
				handMessage = "Mmm..  my pussy feel so wet."
			elseif chance < 4
				handMessage = "My tits are tingly!"
			else
				handMessage = "A cock in my mouth would feel so good."
			endif
		elseif chance < 1
			handMessage = "I need a male companion with a big fat dick."
		elseif chance < 2
			handMessage = "I haven't had two dicks at once in like .. forever."
		elseif chance < 3
			handMessage = "I need to find someone to carry all my stuff."
		elseif chance < 4
			handMessage = "Running makes me feel so horny."
		elseif chance < 5
			handMessage = "I can't use weapons or I will chip a nail."
		endif
	else
		; Third person thought
		if bimboArousal > 40
			if chance < 1
				handMessage = "You fantasize about caressing your tits."
			elseif chance < 2
				handMessage = "You fantasize about holding dicks all around."
			elseif chance < 3
				handMessage = "For a moment you try to finger your pussy."
			elseif chance < 4
				handMessage = "Your tight nipples beg for attention."
			else
				handMessage = "You need to feel a cock in your hand..now!"
			endif
		elseif chance < 1
			handMessage = "You daydream about holding a fat dick."
		elseif chance < 2
			handMessage = "You fantasize about holding a dick with each hand."
		elseif chance < 3
			handMessage = "Your dainty hands feel so weak and tingly."
		elseif chance < 4
			handMessage = "You feel lightheaded and breathless."
		elseif chance < 5
			handMessage = "You worry about chipping your nails."
		endif
	endIf

	return handMessage
EndFunction

;===========================================================================
; clumsy hands, called with every player attack or bow draw
; - the chances should be tweaked
; - TODO i've saw this beeing called without the player doing attacks. Why??
;===========================================================================
function clumsyBimboHands(int actionType, Actor bimbo, Form source, int slot)
	;debug: checking why this is beeing called without doing an attack
	BimboActor= BimboAliasRef.GetReference() as Actor
	if (bimbo != BimboActor)
		; debugTrace(" bimbo clumsy hands, not the bimbo")
		return
	endif

	;not clumsy anymore? stop it!
	if !isBimboClumsyHands
		UnregisterForActorAction(0)
		UnregisterForActorAction(5)
		isClumsyHandsRegistered = false
		return
	endif

	Utility.Wait(0.1) ;To prevent Update on Menu Mode

	Actor kPlayer = Game.GetPlayer()
	float bimboArousal = slaUtil.GetActorArousal(bimbo) as float
	float dropchance = 1.0 + (bimboArousal / 10 )
	Float fClumsyMod = StorageUtil.GetFloatValue(kPlayer, "_SLH_fBimboClumsyMod" ) 
	string handMessage
	int[] drops

	;...but bow draw chances are bigger (using both hands)
	if actionType == 5
		dropchance *= 3.0 * (GV_bimboClumsinessMod.GetValue() as Float)
	endif

	dropchance *= fClumsyMod

	;TODO check long nails (equipped at the bad end), dropchance *= 2 
	int roll = Utility.RandomInt(0,100)
	; debugTrace(" bimbo clumsy hands, drop chance/roll = " + dropchance + "/" + roll)
	if (roll <= (dropchance) as int) && (GV_bimboClumsinessMod.GetValue() != 0)

		; Debug.Notification("[SLH] dropchance: " + dropchance)
		; Debug.Notification("[SLH] fClumsyMod: " + fClumsyMod)

		handMessage = randomBimboHandsMessage(bimboArousal, actionType)
		if actionType == 5
			; bow fumble
			Input.TapKey(Input.GetMappedKey("Ready Weapon"))
			roll = Utility.RandomInt()
			dropchance = dropchance * 0.33
			if roll <= (dropchance as int)
				drops = dropWeapons(bimbo, 0) ;may drop the bow too
			endif
		elseIf actionType < 10 ; If already Sheathed don't drop it
			drops = dropWeapons(bimbo, slot)
		endif
		if drops.length > 0 && drops[0] > 0 ;dropped weapons
			handMessage = handMessage + "... and lose grip. Oopsy!"
		endif

		If (StorageUtil.GetIntValue(bimbo, "_SLH_iShowStatus")!=0)
			Debug.Notification(handMessage)
		Endif
		SLH_Control.playRandomSound(bimbo)
		bimbo.CreateDetectionEvent(bimbo, 10)
	endif


	;TODO stop it for a while, register again on another update after some time
	;UnregisterForActorAction(0)
	;UnregisterForActorAction(5)
	;RegisterForSingleUpdate( fRFSU )
endfunction

;===========================================================================
;this makes the bimbo stumble when running/sprinting/sneaking
;called with OnUpdate
; - the stumbling chances should be tweaked
;===========================================================================
function clumsyBimboLegs(Actor bimbo)
	Actor kPlayer = Game.GetPlayer()
	string bimboTripMessage = ""
	Float fClumsyMod = StorageUtil.GetFloatValue(kPlayer, "_SLH_fBimboClumsyMod" ) 

	;not clumsy anymore?
	if !isBimboClumsyLegs
		isClumsyLegsRegistered = false
		return
	endif
	
	Utility.Wait(0.1) ;To prevent Update on Menu Mode

	bArmorOn = kPlayer.WornHasKeyword(ArmorOn)
	bClothingOn = kPlayer.WornHasKeyword(ClothingOn)

	;is pressing the movement keys?
	if Input.IsKeyPressed(Input.GetMappedKey("Forward")) || Input.IsKeyPressed(Input.GetMappedKey("Back")) || Input.IsKeyPressed(Input.GetMappedKey("Strafe Left")) || Input.IsKeyPressed(Input.GetMappedKey("Strafe Right"))
		;isn't on the menu?
		bool IsMenuOpen = Utility.IsInMenuMode() || UI.IsMenuOpen("Dialogue Menu")
		if !IsMenuOpen && !bimbo.IsFlying() && !bimbo.IsOnMount() && !bimbo.IsSwimming() && (StorageUtil.GetIntValue(kPlayer,"DCUR_SceneRunning") == 0)
			SendModEvent("dhlp-Suspend")
		    float tumbleForce = 0.001
			float bimboArousal = 0.0
			if bimbo != None
				bimboArousal = slaUtil.GetActorArousal(bimbo) as float
				; debugTrace(" ---- is aroused: " + bimboArousal)
			else
				; Debug.Trace("[sla+] null player on clumsyBimboLegs")
			endif
		    float tumbleChance = 1.0 + (bimboArousal / 20.0)

			;ok, lets check what is the bimbo doing and increase the chances
			;TODO is using HDT heels and the tf ended, decrease the chances (a good bimbo always use heels)

			; force scaling
			tumbleForce = (bimbo.GetAnimationVariableFloat("Speed") / 100) * 0.05
			
			if bimbo.IsSneaking()
				tumbleChance *= 0.5
			endif
			
			if tumbleForce >= 0.25
				tumbleChance *= 4.00 
			elseif tumbleForce >= 0.1
				tumbleChance *= 2.00 
			elseif tumbleForce >= 0.05
				tumbleChance *= 0.33 
			elseif tumbleForce > 0.01
				tumbleChance *= 0.15
			else
				tumbleChance = 0
			endif

			tumbleChance *= fClumsyMod

			int roll = Utility.RandomInt(0,100)
			Int rollFirstPerson = Utility.RandomInt(0,100)
			; debugTrace(" ------- stumble [" + roll + " < " + tumbleChance + "]?")
			if (roll < (tumbleChance as Int)) && (GV_bimboClumsinessMod.GetValue()!=0)
				If (bimboClumsyBuffer < ( 7 - (GV_bimboClumsinessMod.GetValue() as Int) * 6) )
					bimboClumsyBuffer = bimboClumsyBuffer + 1
				else
					bimboClumsyBuffer = 0
					Game.ForceThirdPerson()
					If bimbo.IsSneaking()
						bimbo.StartSneaking()
					EndIf

					int rollMessage = Utility.RandomInt(0,100)

					if ((bArmorOn && (rollMessage >30)) || (bClothingOn && (rollMessage >90)))
						bimbo.PushActorAway(bimbo, tumbleForce) ;how to push only to the bimbo movement direction?
						debugTrace(" BimboActor: "+BimboActor+" TumbleForce:"+tumbleForce)
						Utility.Wait(1.0)
						Debug.Notification("You tripped! Clumsy bimbo!") ;temp messages
					endIf

					int[] drop = dropWeapons(bimbo, -1, chanceMult = 0.1)
					if drop[0] > 0 ;if dropped anything, play a moan sound
						SLH_Control.playRandomSound(bimbo)
						bimbo.CreateDetectionEvent(bimbo, 10)
					endif

					;wait a little to show the messages, because on ragdoll the hud is hidden
					Utility.Wait(2.0)

					rollMessage = Utility.RandomInt(0,100)

					If (rollFirstPerson <= (StorageUtil.GetFloatValue(bimbo, "_SLH_fHormoneBimbo") as Int))
						; First person thought
						SLH_Control.playMoan(bimbo)
						bimbo.CreateDetectionEvent(bimbo, 10)
						if (rollMessage >= 80)
							bimboTripMessage = "Oh My Gods.. is that a chipped nail?!"
						elseif (rollMessage >= 60)
							bimboTripMessage = "I need a hard pounding so bad!"
						elseif (rollMessage >= 40)
							bimboTripMessage = "I need to taste cum soon."
						elseif (rollMessage >= 20)
							bimboTripMessage = "I haven't had cock inside me in like.. forever."
						else 
							bimboTripMessage = "My clitty needs to be licked.. like right now!"
						endIf
					else
						; Third person thought
						if (rollMessage >= 80)
							bimboTripMessage = "You notice a chipped nail and skip a step."
						elseif (rollMessage >= 60)
							bimboTripMessage = "You know what you need? a hard pounding.."
						elseif (rollMessage >= 40)
							bimboTripMessage = "Semen coating your lips. That's what you need right now."
						elseif (rollMessage >= 20)
							bimboTripMessage = "Oh.. What you would give to have all your holes filled..."
						else 
							bimboTripMessage = "Your clit demands to be licked.. right now!"
						endIf
					endif

					if drop[0] > 0
						If (rollFirstPerson <= (StorageUtil.GetFloatValue(bimbo, "_SLH_fHormoneBimbo") as Int))
							Debug.Notification("Oopsies... that weapon is so heavy.") ;temp messages
							SLH_Control.playGiggle(bimbo)
							bimbo.CreateDetectionEvent(bimbo, 20)
						Else
							Debug.Notification("You got distracted and dropped your weapons!") ;temp messages
						Endif
					endif
					
					Debug.Notification(bimboTripMessage) ;temp messages

					;alternative to the ragdoll: trigger the bleedout animation for 2 seconds
					;Debug.SendAnimationEvent(bimbo, "BleedOutStart")
					;if util.config.dropWeapons
					;	util.dropWeapons(chanceMult = 2.0)
					;endif
					;Utility.Wait(2.0)
					;Debug.SendAnimationEvent(bimbo, "BleedOutStop")
				endIf

			elseif bimboArousal > 90 && roll <= 20 ;warn the player
				If (rollFirstPerson <= (StorageUtil.GetFloatValue(bimbo, "_SLH_fHormoneBimbo") as Int))
					; First person thought
					SLH_Control.playMoan(bimbo)
					bimbo.CreateDetectionEvent(bimbo, 10)
					Debug.Notification("I'm so horny.")
				else
					Debug.Notification("You squeeze your legs with arousal.")
				endif

			endif

			SendModEvent("dhlp-Resume")

		endif
	endif
endfunction

;===========================================================================
;===========================================================================
;===========================================================================
;==========================SLAVETATS SCRIPT=================================
;===========================================================================
;===========================================================================
;===========================================================================
;Basically (read: 100%) lifted wholesale from slavetats events bridge, all credits to weird


Function BimboTattoo(Form _form, String _section, String _name, bool _last, bool _silent, bool _lock)
	if !_form as Actor
		debug.Trace("[SLH] ERROR: called BimboTattoo on a not-actor")
		return
	endIf

	; Call mod event from Hormones Bimbo Add-on
EndFunction


Function RemoveBimboTattoo(Form _form, String _section, bool _ignoreLock, bool _silent)
	if !_form as Actor
		debug.Trace("[SLH] ERROR: called RemoveBimboTattoo on a not-actor")
		return
	endIf

	; Call mod event from Hormones Bimbo Add-on

EndFunction

;===========================================================================
;===========================================================================
;===========================================================================
;===========================================================================
;[mod] progressive transformation here, called every day
;TODO move all the stuff here, each thing with its own trigger
;
;
;===========================================================================
function bimboDailyProgressiveTransformation(actor bimbo, bool isTG)
	int transformationDays = StorageUtil.GetIntValue(bimbo, "_SLH_bimboTransformGameDays")
	int transformationCycle = transformationDays/16
	int transformationLevel

	if (StorageUtil.GetIntValue(bimbo, "_SLH_bimboTransformLevel")<16)
		transformationLevel= transformationDays - (transformationCycle * 16)
		StorageUtil.SetIntValue(bimbo, "_SLH_bimboTransformLevel",transformationLevel)
	else
		transformationLevel= StorageUtil.GetIntValue(bimbo, "_SLH_bimboTransformLevel")
	endif

	StorageUtil.SetIntValue(bimbo, "_SLH_bimboTransformCycle",transformationCycle)

	int hairLength = StorageUtil.GetIntValue(none, "YpsCurrentHairLengthStage")
	isBimboPermanent = StorageUtil.GetIntValue(bimbo, "_SLH_bimboTransformLocked") as Bool

	debugTrace(" bimbo transformation days: " + transformationDays)
	debugTrace(" bimbo transformation level: " + transformationLevel)
	debugTrace(" bimbo transformation cycle: " + transformationCycle)
	debugTrace(" bimbo hair length: " + hairLength)

	;no tg = always female, never has a schlong
	;tg:
	; - female + tg = schlong enlarges every day, permanent on day 5
	; - male + tg = schlong shrinks every day, lost on day 5

	; Int iBimboHairColor = Math.LeftShift(255, 24) + Math.LeftShift(92, 16) + Math.LeftShift(80, 8) + 80
	Int iBimboHairColor = StorageUtil.GetIntValue(BimboActor, "_SLH_iBimboHairColor") ; Math.LeftShift(92, 16) + Math.LeftShift(80, 8) + 80

	if (StorageUtil.GetIntValue(BimboActor, "_SD_iAliciaHair")== 1 )  
		iBimboHairColor = StorageUtil.GetIntValue(BimboActor, "_SLH_iSuccubusHairColor") ; Math.LeftShift(247, 16) + Math.LeftShift(163, 8) + 240  ; Pink
		StorageUtil.SetStringValue(BimboActor, "_SLH_sHairColorName", "Pink" ) 
	else
		StorageUtil.SetStringValue(BimboActor, "_SLH_sHairColorName", "Platinum Blonde" ) 
	EndIf

	StorageUtil.SetIntValue(BimboActor, "_SLH_iHairColor", iBimboHairColor )
	debugTrace(" 	bimbo hair color: " + iBimboHairColor)

	fctHormones.modHormoneLevel(BimboActor, "Growth", 5.0 ) ; make breasts and butt larger
	fctHormones.modHormoneLevel(BimboActor, "Bimbo", 5.0 ) ; make breasts and butt larger
	fctHormones.modHormoneLevel(BimboActor, "Metabolism", -5.0 ) ; make breasts and butt larger

	If isBimboPermanent
		Debug.Notification("I need more cocks! *giggle*")
		SLH_Control.playMoan(bimbo)
		SendModEvent("yps-HairColorBaseEvent", "Platinum Blonde", 0xCABFB1)
	ElseIf StorageUtil.GetIntValue(BimboActor, "_SLH_bimboTransformFinal") == 1
		RemoveBimboTattoo(bimbo, "Bimbo", true, true)
		BimboTattoo(bimbo,"Bimbo","Tramp Stamp",false,true,true)
		BimboTattoo(bimbo,"Bimbo","Belly",false,true,true)
		BimboTattoo(bimbo,"Bimbo","Tramp Stamp Upper",false,true,true)
		BimboTattoo(bimbo,"Bimbo","Pubic Tattoo",false,true,true)
		BimboTattoo(bimbo,"Bimbo","Permanent Bimbo",true,true,true)

		SendModEvent("yps-LipstickEvent", "Bimbo", -1)  ; SendModEvent("yps-LipstickEvent", "Red", 0xFF0000)  
		SendModEvent("yps-EyeshadowEvent", "Bimbo", -1) ; SendModEvent("yps-EyeshadowEvent", "Black", 0x000000)   
		SendModEvent("yps-DisableSmudgingEvent")
		SendModEvent("yps-LockMakeupEvent")
		SendModEvent("yps-PermanentMakeupEvent")
		SendModEvent("yps-HairColorBaseEvent", "Platinum Blonde", 0xCABFB1)
		SendModEvent("yps-FingerNailsEvent", "", 29)
		SendModEvent("yps-ToeNailsEvent", "", 29)
		SendModEvent("yps-DisableHairgrowthEvent")
		SendModEvent("yps-DisableHairmakeoverEvent")
		SetHairLength(13)

		if (StorageUtil.GetIntValue(none, "ypsPubicHairEnabled") == 1)
			SendModEvent("yps-SetPubicHairLengthEvent", "", 0)
		Endif
		if (StorageUtil.GetIntValue(none, "ypsArmpitHairEnabled")==1)
			SendModEvent("yps-SetArmpitsHairLengthEvent", "", 0)
		endif

		isBimboPermanent = true
		fctPolymorph.bimboLockedON(bimbo)

		Debug.Messagebox("Somewhere in the back of your foggy, lust-addled mind you register the finality of your unfortunate predicament. What little remains of your lucid psyche screams in horror as the curse weaves into every fibre of your perversely modified body, its silhouette bearing little resemblance to your former self. The new you is completely tailor made for the singular purpose of pleasuring men. You moan in ecstacy as your bright gaudy makeup, your slutty erotic tattoos, and your lewd glittering piercings all tingle, then bind to your flesh, becoming permanent fixtures to your bimbo form, irrevocably marking your body as that of a modified, carnal, and peversely erotic masturbatory aid.")
		Debug.Messagebox("The magical tattoo needles, which you've become so familiar with during your metamorphosis, return one final time to commemorate the permanence of your transformation. You writhe and moan in pleasure as the needles buzz over your smooth, hairless mound and permanently deposit pigments that form your final, obscene modification. Then, just as swiftly, the needles disappear, leaving behind a bright, pink tattoo that seems to shimmer above your soft, slick folds, irrevocably marking you as a PERMANENT BIMBO FUCKTOY, and advertising both your availability and eagerness to service your next sexual partner.")
	ElseIf transformationLevel < 16
		;level 1: lipstick
		if (transformationLevel == 1)
			Debug.Notification("You feel a little tingle on your lips.")
			SLH_Control.playChuckle(bimbo)

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SendModEvent("yps-LipstickEvent", "Bimbo", -1)  ; SendModEvent("yps-LipstickEvent", "Red", 0xFF0000)  
				SetHairLength(5)
			else
				fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Lipstick", iColor = 0x66FF0984)
			Endif

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.3)
		;level 2: eyeshadow
		Elseif (transformationLevel == 2)
			Debug.Notification("You feel a little tingle on your eyelids.")
			SLH_Control.playChuckle(bimbo)

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SendModEvent("yps-EyeshadowEvent", "Bimbo", -1) ; SendModEvent("yps-EyeshadowEvent", "Black", 0x000000)   
				SetHairLength(5)
			else
				fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Eye Shadow", iColor = 0x99000000, bRefresh = True)
			Endif

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.3)
		;level 3: hair
		Elseif (transformationLevel == 3)
			Debug.Notification("You feel a little tingle on your scalp.")
			SLH_Control.playChuckle(bimbo)

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SendModEvent("yps-HairColorBaseEvent", "Platinum Blonde", 0xCABFB1)
				SetHairLength(6)
			Endif

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.3)
		;level 4, fingernails
		Elseif (transformationLevel == 4)
			Debug.Notification("Your nails are turning into a slutty shade of pink")
			SLH_Control.playGiggle(bimbo)

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SendModEvent("yps-FingerNailsEvent", "", 29)
				SetHairLength(6)
			else
				fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Hand Nails", iColor = 0x00FF0984, bRefresh = True )
			Endif

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.3)
		;level 5, toenails
		Elseif (transformationLevel == 5)
			Debug.Notification("Your toenails are turning into glimmery shade of pink")
			SLH_Control.playGiggle(bimbo)

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SendModEvent("yps-ToeNailsEvent",  "", 29)
				SetHairLength(7)
			else
				fctColor.sendSlaveTatModEvent(bimbo, "Bimbo","Feet Nails", iColor = 0x00FF0984 )
			Endif

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.3)
		;level 6, weak body (can drop weapons when hit)
		Elseif (transformationLevel == 6)
			Debug.Notification("Your body feels weak and your chest feels tight.")
			SLH_Control.playGiggle(bimbo)

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SetHairLength(7)
			Endif

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.3)
			isBimboClumsyHands = true
		;level 7: earrings
		Elseif (transformationLevel == 7)
			Debug.Notification("You yelp in pain as your ears are suddenly pierced")
			SLH_Control.playMoan(bimbo)

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SendModEvent("yps-PiercingEvent", "Mr Needle", 1)
				SetHairLength(8)
			Endif

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.3)
		;level 8: back tattoo
		Elseif (transformationLevel == 8)
			Debug.Notification("You writhe in discomfort as invisible tattoo needles ink your back.")
			BimboTattoo(bimbo,"Bimbo","Tramp Stamp",true,true,false)
			SLH_Control.playMoan(bimbo)

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SetHairLength(8)
			Endif

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.3)
		;level 9: upper back tattoo
		Elseif (transformationLevel == 9)
			Debug.Notification("You writhe in discomfort as invisible tattoo needles continue inking your back.")
			BimboTattoo(bimbo,"Bimbo","Tramp Stamp Upper",true,true,false)
			SLH_Control.playMoan(bimbo)

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SetHairLength(9)
			Endif

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.3)
		;level 10: belly tattoo
		Elseif (transformationLevel == 10)
			Debug.Notification("You shudder in pained pleasure as the invisible tattoo needles mark your belly.")
			BimboTattoo(bimbo,"Bimbo","Belly",true,true,false)
			SLH_Control.playMoan(bimbo)

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SetHairLength(9)
			Endif

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.3)
		;level 11: navel ring, bigger butt
		Elseif (transformationLevel == 11)
			Debug.Notification("You yelp in pain as an invisible needle pierces your navel.")
			SLH_Control.playMoan(bimbo)

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SendModEvent("yps-PiercingEvent", "Mr Needle", 9)
				SetHairLength(10)
			EndIf

			IncreaseButtSize()

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.3)
		;level 12: bigger butt, heel hubbled
		Elseif (transformationLevel == 12)
			Debug.Notification("Your feet tingle and deform into a slutty high-heeled arch")
			SLH_Control.playMoan(bimbo)

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SendModEvent("yps-ArchedFeetEvent")
				SetHairLength(11)
			EndIf

			IncreaseButtSize()

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.3)
			isBimboClumsyLegs = true
		;level 13: pubic tattoo, bigger butt
		Elseif (transformationLevel == 13)
			if !fctUtil.isMale(BimboActor) ;no schlong on the way
				Debug.Notification("You moan in surprise as the invisible tattoo needles work their way down your smooth mound.")
				BimboTattoo(bimbo,"Bimbo","Pubic Tattoo",true,true,false)
				SLH_Control.playMoan(bimbo)
			endif

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SetHairLength(12)
			EndIf

			IncreaseButtSize()

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.3)
		;level 14: nipple piercings
		Elseif (transformationLevel == 14)
			Debug.Notification("You moan in pained pleasure as thick, invisible needles pierce your swollen nipples.")
			SLH_Control.playMoan(bimbo)

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SendModEvent("yps-PiercingEvent", "Mr Needle", 10)
				SetHairLength(13)
			EndIf

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.3)
		;level 15: clit piercing
		Elseif (transformationLevel == 15)
			Debug.Notification("You writhe and spasm uncontrollably as a thick, invisible needle slowly pierces your vulnerable clit.")
			SLH_Control.playMoan(bimbo)

			If (StorageUtil.GetIntValue(none, "ypsHairControlEnabled") == 1)
				SendModEvent("yps-PiercingEvent", "Mr Needle", 11)
				SetHairLength(13)
			EndIf

			fctBodyshape.alterBodyByPercent(bimbo, "Breast", 0.5)
			isBimboFrailBody = true
			fctPolymorph.bimboFinalON(bimbo)
		endif
	EndIf
	;IDEAS
	;- some kind of sex need? or leave it for other mods?
	;- the bad end should be better: an fx should play, trigger as masturbation too
	;- move the clumsiness to the nails (enchantment)?
	;- or move it all to spells, each curse should be a spell
	;
	;FINAL EXPANSION - turning this into a new mod: curses of skyrim - items with curses on them and move this into a plugin, using sl_hormones api and the new mod api
	;- move everything to a second quest caused by the player choices:
	;  ask Honey if she has a better solution after talking with the dremora (her ideas of "solution" are not the same as yours) 
	;  then she will randomly seek the player and give (force equip) him surprise cursed gifts every day (maybe she only visits the player after sleep, or during sex so he cant avoid her):
	;  - permanent makeup and a haircut = causes random thoughts of sex
	;  - long nails = clumsy hands
	;  - hoops earrings = block helmets
	;  - bracelets = block forearm armor
	;  - an anal dildo = butt growth until removed, can only be removed after a day (she could do it on the next visit)
	;  - vaginal dildo = start the player tripping on equip, then after removed the player will stumble less but will forever do it (same, she removes it on the next visit)
	;  - nipple piercings = boob expansion, increases arousal each minute
	;  - more piercings? navel, clit?
	;  - as a parting gift some kind of outfit (heels, skirt and a tube top, or something like that), all enchanted. These can be removed, but causes the player to be conditioned to use heels (stumble a lot more if not)
	;  - this quest will not have a good end, only makes the curse worse
	;
	;BUG CHECK
	;check if the cure is still possible
	;check why, WHY, WHYYYY the honey hello dialog disappears when i save the esp!!
	;check what happens after the player is cured
endfunction

;Separated for convenience
Function SetHairLength(Int hairLength)
	If StorageUtil.GetIntValue(BimboActor, "_SLH_iUseHair") == 1
		if StorageUtil.GetIntValue(none, "YpsCurrentHairLengthStage") < hairLength
			SendModEvent("yps-SetHaircutEvent", "", hairLength)
		endif
	EndIf
EndFunction

;Separated for convenience
Function IncreaseButtSize()
	Float fButtMin = StorageUtil.GetFloatValue(BimboActor, "_SLH_fButtMin")
	Float fButtMax = StorageUtil.GetFloatValue(BimboActor, "_SLH_fButtMax")
	Float fButtActual = StorageUtil.GetFloatValue(BimboActor, "_SLH_fButt")
	if (fButtActual < fButtMax)
		Debug.SendAnimationEvent(BimboActor, "BleedOutStart")
		SLH_Control.playRandomSound(BimboActor)

		fButtActual = 0.1 + fButtActual * 1.15 ;now with 15% more butt!
		if fButtActual > fButtMax
			fButtActual = fButtMax
		endif
		StorageUtil.SetFloatValue(BimboActor, "_SLH_fButt", fButtActual)
		BimboActor.SendModEvent("SLHRefresh")

		Utility.Wait(1.0)
		Debug.SendAnimationEvent(BimboActor, "BleedOutStop")
	endif
EndFunction

Function debugTrace(string traceMsg)
	if (StorageUtil.GetIntValue(none, "_SLH_debugTraceON")==1)
		Debug.Trace("[SLH_QST_BimboAlias]" + traceMsg)
	endif
endFunction

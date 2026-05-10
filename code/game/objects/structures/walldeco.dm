
/obj/structure/fluff/walldeco
	name = ""
	desc = ""
	icon = 'icons/roguetown/misc/decoration.dmi'
	anchored = TRUE
	density = FALSE
	max_integrity = 0
	layer = ABOVE_MOB_LAYER+0.1

/obj/structure/fluff/walldeco/OnCrafted(dirin, user)
	pixel_x = 0
	pixel_y = 0
	switch(dirin)
		if(NORTH)
			pixel_y = 32
		if(SOUTH)
			pixel_y = -32
		if(EAST)
			pixel_x = 32
		if(WEST)
			pixel_x = -32
	. = ..()

/obj/structure/fluff/walldeco/proc/get_attached_wall()
	return

/obj/structure/fluff/walldeco/wantedposter
	name = "bandit notice"
	desc = "A place for posters displaying the faces of roving bandits. Let's see if there are any this week..."
	icon_state = "wanted1"
	layer = BELOW_MOB_LAYER
	pixel_y = 32

/obj/structure/fluff/walldeco/wantedposter/r
	pixel_y = 0
	pixel_x = 32
/obj/structure/fluff/walldeco/wantedposter/l
	pixel_y = 0
	pixel_x = -32

/obj/structure/fluff/walldeco/wantedposter/Initialize()
	. = ..()
	icon_state = "wanted[rand(1,3)]"
	dir = pick(GLOB.cardinals)

/obj/structure/fluff/walldeco/wantedposter/examine(mob/user)
	. = ..()
	if(user.Adjacent(src))
		if(SSrole_class_handler.bandits_in_round)
			. += span_bold("I see that bandits are active in the region.")
			user.playsound_local(user, 'sound/misc/notice (2).ogg', 100, FALSE)
		else
			. += span_bold("There doesn't seem to be any reports of bandit activity.")

/obj/structure/fluff/walldeco/innsign
	name = "sign"
	desc = ""
	icon_state = "bar"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/steward
	name = "sign"
	desc = ""
	icon_state = "steward"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/bsmith
	name = "sign"
	desc = ""
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "bsmith"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/goblet
	name = "sign"
	desc = ""
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "goblet"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/flower
	name = "sign"
	desc = ""
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "flower"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/barbersign
	name = "sign"
	desc = "The iconic swirl of the barber surgeon."
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "barbersign"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/barbersignreverse
	name = "sign"
	desc = "The iconic swirl of the barber surgeon."
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "barbersignflip"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/sparrowflag
	name = "sparrow flag"
	desc = ""
	icon_state = "sparrow"

/obj/structure/fluff/walldeco/xavo
	name = "PERSERDUN"
	desc = "Your glorious flag."
	icon_state = "xavo"

/obj/structure/fluff/walldeco/serpflag
	name = "serpent flag"
	desc = ""
	icon_state = "serpent"

/obj/structure/fluff/walldeco/artificerflag
	name = "Artificer's Guild"
	desc = ""
	icon_state = "artificer"

/obj/structure/fluff/walldeco/maidendrape
	name = "black drape"
	desc = "A drape of fabric."
	icon_state = "black_drape"
	dir = SOUTH
	pixel_y = 32

/obj/structure/fluff/walldeco/wallshield
	name = ""
	desc = ""
	icon_state = "wallshield"

/obj/structure/fluff/walldeco/sign/merchantsign
	name = "merchant shop sign"
	icon_state = "shopsign_merchant_right"
	plane = -1
	pixel_y = 16

/obj/structure/fluff/walldeco/sign/merchantsign/left
	icon_state = "shopsign_merchant_left"

/obj/structure/fluff/walldeco/psybanner
	name = "banner"
	icon_state = "Psybanner-PURPLE"

/obj/structure/fluff/walldeco/psybanner/red
	icon_state = "Psybanner-RED"

/obj/structure/fluff/walldeco/stone
	name = ""
	desc = ""
	icon_state = "walldec1"
	mouse_opacity = 0

/obj/structure/fluff/walldeco/stone/bronze
	color = "#ff9c1a"

/obj/structure/fluff/walldeco/church/line
	name = ""
	desc = ""
	icon_state = "churchslate"
	mouse_opacity = 0
	layer = BELOW_MOB_LAYER+0.1

/obj/structure/fluff/walldeco/stone/Initialize()
	icon_state = "walldec[rand(1,6)]"
	..()

/obj/structure/fluff/walldeco/maidensigil
	name = "stone sigil"
	desc = ""
	icon_state = "maidensigil"
	mouse_opacity = 0
	dir = SOUTH
	pixel_y = 32

/obj/structure/fluff/walldeco/maidensigil/r
	dir = WEST
	pixel_x = 16

/obj/structure/fluff/walldeco/bigpainting
	name = "painting"
	icon = 'icons/roguetown/misc/64x64.dmi'
	icon_state = "sherwoods"
	pixel_y = 32
	pixel_x = -16

/obj/structure/fluff/walldeco/bigpainting/lake
	icon_state = "lake"

/obj/structure/fluff/walldeco/mona
	name = "painting"
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "mona"
	pixel_y = 32

/obj/structure/fluff/walldeco/chains
	name = "hanging chains"
	alpha = 180
	layer = 4.26
	icon_state = "chains1"
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	can_buckle = 1
	buckle_lying = 0
	breakoutextra = 5 MINUTES
	buckleverb = "tie"

/obj/structure/fluff/walldeco/chains/Initialize()
	icon_state = "chains[rand(1,8)]"
	..()

/obj/structure/fluff/walldeco/customflag
	name = "Azure Peak flag"
	desc = "A banner flutters in the breeze in the proud heraldic colors of the Duchy."
	icon_state = "wallflag"

/obj/structure/fluff/walldeco/customflag/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	GLOB.lordcolor += src

/obj/structure/fluff/walldeco/customflag/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/structure/fluff/walldeco/customflag/lordcolor(primary,secondary)
	if(!primary || !secondary)
		return
	var/mutable_appearance/M = mutable_appearance(icon, "wallflag_primary", -(layer+0.1))
	M.color = primary
	add_overlay(M)
	M = mutable_appearance(icon, "wallflag_secondary", -(layer+0.1))
	M.color = secondary
	add_overlay(M)

/obj/structure/fluff/walldeco/moon
	name = "banner"
	icon_state = "moon"

/obj/structure/fluff/walldeco/rpainting
	name = "painting"
	icon_state = "painting_1"

/obj/structure/fluff/walldeco/rpainting/forest
	icon_state = "painting_2"

/obj/structure/fluff/walldeco/rpainting/crown
	icon_state = "painting_3"

/obj/structure/fluff/walldeco/med
	name = "diagram"
	icon_state = "medposter"

/obj/structure/fluff/walldeco/med2
	name = "diagram"
	icon_state = "medposter2"

/obj/structure/fluff/walldeco/med3
	name = "diagram"
	icon_state = "medposter3"

/obj/structure/fluff/walldeco/med4
	name = "diagram"
	icon_state = "medposter4"

/obj/structure/fluff/walldeco/med5
	name = "diagram"
	icon_state = "medposter5"

/obj/structure/fluff/walldeco/med6
	name = "diagram"
	icon_state = "medposter6"

/obj/structure/fluff/walldeco/alarm
	name = "le réveil murmure"
	icon_state = "alarm"
	desc = "This est un wall-mounted système d'alarme, designed dans les ."
	pixel_y = 32
	var/next_yap = 0
	var/onoff = 1 //Init on

/obj/structure/fluff/walldeco/alarm/attack_hand(mob/living/user)

	user.changeNext_move(CLICK_CD_MELEE)

	if(!(HAS_TRAIT(user, TRAIT_NOBLE)))
		playsound(src, 'sound/misc/machineno.ogg', 100, TRUE, -1)
		say("REMOVE THINE HAND FROM THE ALARM, CREATURE!")
		return

	playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)
	if(onoff == 0)
		onoff = 1
		icon_state = "alarm"
		say("Bonjour, le sentinelle est active.")
		next_yap = 0 //They won't believe us unless we yap again
		return
	if(onoff == 1)
		onoff = 0
		icon_state = "face"
		say("A moment's rest, merci! Bonne nuit.")
		return
	else //failsafe
		onoff = 1
		icon_state = "alarm"

/obj/structure/fluff/walldeco/alarm/Crossed(mob/living/user)

	if(onoff == 0)
		return

	if(next_yap > world.time) //Yap cooldown
		return

	if(ishuman(user)) //are we a person?
		var/mob/living/carbon/human/HU = user

		if(HU.anti_magic_check()) //are we shielded?
			return

		if(!(HU in SStreasury.bank_accounts)) //first off- do we not have an account? we'll ALWAYS scream if that's the case
			playsound(loc, 'sound/misc/gold_license.ogg', 100, TRUE, -1)
			say("UNKNOWN PERSON IN SECURE AREA- ARRETZ-VOUZ!!")
			next_yap = world.time + 6 SECONDS
			return

		if(HAS_TRAIT(user, TRAIT_NOBLE))
			say("Salut, [user.real_name] de Sommet. Thirty-breths silence period active por votre grace.")
			playsound(loc, 'sound/misc/gold_menu.ogg', 100, TRUE, -1)
			next_yap = world.time + 30 SECONDS
			return

		if((HU in SStreasury.bank_accounts)) //do we not have an account?
			playsound(loc, 'sound/misc/gold_menu.ogg', 100, TRUE, -1)
			say("Yeoman [user.real_name] logged entering zone securisee.")
			return

		else //?????
			playsound(loc, 'sound/misc/gold_license.ogg', 100, TRUE, -1)
			say("UNAUTHORIZED PERSON IN SECURE AREA- ARRETZ-VOUZ!!")
			next_yap = world.time + 6 SECONDS

	else
		playsound(loc, 'sound/misc/gold_license.ogg', 100, TRUE, -1)
		say("UNKNOWN CREATURE IN SECURE AREA- ARRETZ-VOUS!!")
		next_yap = world.time + 6 SECONDS

/obj/structure/fluff/walldeco/freud
	name = "odd man"
	desc = "You have to fuck your mum."
	icon_state = "freud"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/terdun
	name = "patriotism"
	desc = "Terdun - shorthand for Perserdun. Glory to the Great Empire!"
	icon_state = "terdun"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/murder
	name = "valor"
	desc = "An image depicting a Risvonian Oficiro digging into some poor insurrectionist."
	icon_state = "murder"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/pray
	name = "hands"
	desc = "A poster depicting proper form when praying to Venerable-Master Rab."
	icon_state = "poster_pray"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/compromise
	name = "hate"
	desc = "Peace is never an option."
	icon_state = "poster_compromise"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/weird
	name = "yuri"
	desc = "What does this even mean?"
	icon_state = "poster_triangle"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/ugly
	name = "human"
	desc = "Rab, that's an ugly skull."
	icon_state = "ugly"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/commandant
	name = "trenchman"
	desc = "A depiction of your beloved Commandant."
	icon_state = "inq1"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/grandmaster
	name = "greatman"
	desc = "A depiction of your glorious Grandmaster."
	icon_state = "inq"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/sad
	name = "joy"
	desc = "That's her."
	icon_state = "sad"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/happy
	name = "mania"
	desc = "That's him."
	icon_state = "happiness"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/spoiler
	name = "?????"
	desc = "What the fuck is this?"
	icon_state = "colony"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/blindfolds
	name = "love"
	desc = "I miss her."
	icon_state = "blindfolds"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/spoiler2
	name = "?????"
	desc = "It looks like a colored picture. Why is it so bright?"
	icon_state = "knowledge"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/ubk
	name = "signia"
	desc = "The Mark of the Dictate."
	icon_state = "ubk"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/doom
	name = "skull"
	desc = "The text reads: 'SHITHOLE.'"
	icon_state = "doom"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/hands
	name = "hands"
	desc = "A pale man brings his open palms to the sky."
	icon_state = "poster1"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/spirit
	name = "spirit"
	desc = "Tragedy."
	icon_state = "poster2"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/soyjack
	name = "screamer"
	desc = "TERROR!"
	icon_state = "poster3"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/shreds
	name = "shreds"
	desc = "The destruction of information."
	icon_state = "idk"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/spoiler3
	name = "???"
	desc = "A bullet shooting through the sky."
	icon_state = "spoiler3"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/spoiler4
	name = "???"
	desc = "A helmet in a red desert."
	icon_state = "spoiler4"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/kingsrow
	name = "KING'S ROW"
	desc = "The replacement for the old, quadrant-based flag."
	icon_state = "kingsrow"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/leibware
	name = "leibware"
	desc = "I think that's a brain."
	icon_state = "leibware"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/ench
	name = "Lord Ankhefensekhmet of Djet"
	desc = "A politician. Candidate to become the next Lifreer."
	icon_state = "ench"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/merchie
	name = "gilded"
	desc = "Come get your guns."
	icon_state = "merchie"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/beware
	name = "beware"
	desc = "An imposing caricature of a Black Beast."
	icon_state = "beware"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/progress
	name = "report"
	desc = "A progress report detailing information about Perserdunian and Risvonian forces. It looks like King's Row isn't first contact between the two factions."
	icon_state = "progress"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/rush
	name = "rush"
	desc = "Over the top, Imperials."
	icon_state = "rush"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/spoiler5
	name = "???"
	desc = "123 26 53 51 312 132 15 34 312 41 26 34 312 132 15 61 123 53 313 52 121 313 34. There's something white and tall - shining light onto an incredible amount of bodies."
	icon_state = "spoiler5"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/desert
	name = "desert"
	desc = "A skull."
	icon_state = "desert"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/kingofnil
	name = "king"
	desc = "A photo. The boney crown makes you feel weird."
	icon_state = "bpic0"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/vent
	name = "vent"
	desc = "The air's still."
	icon_state = "vent"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/vent/vent2
	icon_state = "vent2"

/obj/structure/fluff/walldeco/vent/vent3
	desc = "It's broken."
	icon_state = "vent3"

/obj/structure/fluff/walldeco/rivbattleflag
	desc = "The unit insignia of the Fourth Forward Battalion in King's Row. A grinning maw of steel stares back at you."
	icon_state = "rivbattleflag"
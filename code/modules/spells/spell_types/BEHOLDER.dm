/obj/effect/proc_holder/spell/self/conjure_beholder_magi
	name = "Conjure BEHOLDER"
	desc = "Conjure a BEHOLDER unit by unknown and unexplainable means, and transfer your consciousness into it."
	releasedrain = 0
	chargetime = 1 SECONDS
	recharge_time = 30 SECONDS

/obj/effect/proc_holder/spell/self/conjure_beholder_magi/cast(list/targets, mob/living/user)
	if(!user || !user.client)
		return FALSE
	var/turf/T = get_turf(user)
	if(!T)
		return FALSE
	var/mob/living/simple_animal/hostile/rogue/robot/beholder/B = new(T)
	if(!B)
		return FALSE
	B.scom_faction_net = SCOMNET_EMPIRE
	B.original_body = user
	B.ckey = user.ckey
	return TRUE

/obj/effect/proc_holder/spell/self/conjure_beholder_doc
	name = "Conjure BEHOLDER"
	desc = "Conjure a BEHOLDER unit by unknown and unexplainable means, and transfer your consciousness into it."
	releasedrain = 0
	chargetime = 1 SECONDS
	recharge_time = 30 SECONDS

/obj/effect/proc_holder/spell/self/conjure_beholder_doc/cast(list/targets, mob/living/user)
	if(!user || !user.client)
		return FALSE
	var/turf/T = get_turf(user)
	if(!T)
		return FALSE
	var/mob/living/simple_animal/hostile/rogue/robot/beholder/B = new(T)
	if(!B)
		return FALSE
	B.scom_faction_net = SCOMNET_ZIGS
	B.original_body = user
	B.ckey = user.ckey
	return TRUE

/mob/living/simple_animal/hostile/rogue/robot/beholder/proc/receive_scom(message, tcolor, message_language)
	if(!scom_faction_net || !message)
		return
	if(tcolor)
		voicecolor_override = tcolor
	say(message, language = message_language)
	voicecolor_override = null

/mob/living/simple_animal/hostile/rogue/robot/beholder
	name = "BEHOLDER"
	desc = "A strange mechanical observation unit. Its delicate frame appears incapable of surviving any meaningful impact. The way it moves and speaks. It's almost as if it is housing a soul within..."
	icon = 'icons/roguetown/mob/robots/mech_beholder.dmi'
	icon_state = "beholder"
	icon_living = "beholder_live"
	icon_dead = "beholder_dead"
	speak_emote = list("beeps")
	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	robust_searching = FALSE
	move_to_delay = 1
	speed = -0.75
	footstep_type = null
	movement_type = FLYING
	pass_flags = PASSTABLE
	see_in_dark = 10
	del_on_death = TRUE
	loot = list(/obj/item/natural/stone, /obj/item/natural/stone, /obj/item/natural/stone)
	// Time required to change Z-levels.
	var/fly_time = 5
	var/mob/living/original_body
	var/scom_faction_net

/mob/living/simple_animal/hostile/rogue/robot/beholder/Initialize()
	. = ..()
	can_have_ai = FALSE
	AIStatus = AI_OFF
	ai_controller = null
	verbs += list(/mob/living/simple_animal/hostile/rogue/robot/beholder/proc/fly_up, /mob/living/simple_animal/hostile/rogue/robot/beholder/proc/fly_down)
	AddSpell(new /obj/effect/proc_holder/spell/self/beholder/comms)
	AddSpell(new /obj/effect/proc_holder/spell/self/beholder/chronoshift)
	AddSpell(new /obj/effect/proc_holder/spell/invoked/beholder/analyze_organic)
	AddSpell(new /obj/effect/proc_holder/spell/invoked/beholder/analyze_terrain)
	AddSpell(new /obj/effect/proc_holder/spell/self/beholder/explode)
	AddSpell(new /obj/effect/proc_holder/spell/self/beholder/shutdown)
	ADD_TRAIT(src, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_SLEEPIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_STUNIMMUNE, TRAIT_GENERIC)
	src.update_sight()

/mob/living/simple_animal/hostile/rogue/robot/beholder/death(gibbed)
	var/turf/T = get_turf(src)
	if(T)
		var/datum/effect_system/explosion/E = new
		E.set_up(1, T)
		E.start()
		playsound(T, 'sound/misc/explode/explosion.ogg', 100, TRUE)
	var/client/return_client = client
	if(original_body && return_client)
		original_body.ckey = return_client.ckey
	return ..()

/mob/living/simple_animal/hostile/rogue/robot/beholder/proc/fly_up()
	set category = "Hover Mode"
	set name = "Fly Up"
	if(src.stat >= UNCONSCIOUS)
		return
	if(src.pulledby != null)
		to_chat(src, span_notice("I can't ascend while being grabbed!"))
		return
	src.visible_message(span_notice("[src] begins to ascend!"), span_notice("You begin to ascend..."))
	if(do_after(src, fly_time, src))
		if(src.pulledby == null)
			src.zMove(UP, TRUE)
			to_chat(src, span_notice("I ascend."))
		else
			to_chat(src, span_notice("I can't ascend while being grabbed!"))

/mob/living/simple_animal/hostile/rogue/robot/beholder/proc/fly_down()
	set category = "Hover Mode"
	set name = "Fly Down"
	if(src.stat >= UNCONSCIOUS)
		return
	if(src.pulledby != null)
		to_chat(src, span_notice("I can't descend while being grabbed!"))
		return
	src.visible_message(span_notice("[src] begins to descend!"), span_notice("You begin to descend..."))
	if(do_after(src, fly_time, src))
		if(src.pulledby == null)
			src.zMove(DOWN, TRUE)
			to_chat(src, span_notice("I descend."))
		else
			to_chat(src, span_notice("I can't descend while being grabbed!"))

/obj/effect/proc_holder/spell/invoked/beholder/analyze_organic
	name = "COMMAND: Analyze Organic"
	desc = "Perform a comprehensive analysis of a nearby organic entity."
	releasedrain = 0
	chargetime = 0
	recharge_time = 5 SECONDS
	range = 4
	selection_type = "range"

/obj/effect/proc_holder/spell/invoked/beholder/analyze_organic/cast(list/targets, mob/living/user)
	var/mob/living/carbon/human/human_target = targets[1]
	if(!user || user.stat == DEAD || !human_target || human_target == user || !ishuman(human_target))
		return FALSE
	human_target.check_for_injuries(user)
	var/bleed_rate = human_target.get_bleed_rate()
	var/bleed_percent = max(0.1, round((bleed_rate / BLOOD_VOLUME_NORMAL) * 100, 0.1))
	var/blood_percent = round((human_target.blood_volume / BLOOD_VOLUME_NORMAL) * 100)
	to_chat(user, span_blue("<i>Suffocation: [human_target.oxyloss]%</i>"))
	to_chat(user, span_necrosis("<i>Toxicity: [human_target.toxloss]%</i>"))
	to_chat(user, span_bloody("<i>Blood volume: [human_target.blood_volume]u ([blood_percent]%)</i>"))
	if(bleed_rate)
		to_chat(user, span_bloody("<i>Bleeding rate: [bleed_rate]u/sec ([bleed_percent]%/sec)</i>"))
	else
		to_chat(user, span_boldgreen("<i>Bleeding rate: 0u/sec</i>"))
	var/has_incision = FALSE
	var/has_cheele = FALSE
	var/has_hemostat = FALSE
	for(var/obj/item/bodypart/BP in human_target.bodyparts)
		for(var/datum/wound/W in BP.wounds)
			if(istype(W, /datum/wound/slash/incision))
				has_incision = TRUE
		for(var/obj/item/I in BP.embedded_objects)
			if(istype(I, /obj/item/natural/worms/leech))
				has_cheele = TRUE
			if(istype(I, /obj/item/rogueweapon/surgery/hemostat))
				has_hemostat = TRUE
	if(human_target.reagents.has_reagent(/datum/reagent/infection/major))
		to_chat(user, span_boldred("Severe infection detected."))
	else if(human_target.reagents.has_reagent(/datum/reagent/infection))
		to_chat(user, span_warning("Active infection detected."))
	else if(human_target.reagents.has_reagent(/datum/reagent/infection/minor))
		to_chat(user, span_warning("Minor infection detected."))
	else
		to_chat(user, span_boldgreen("No infection detected."))
	var/list/names = list()
	var/list/names_with_amounts = list()
	for(var/datum/reagent/R in human_target.reagents.reagent_list)
		if(R.volume > 0 && R.type != /datum/reagent/water && R.type != /datum/reagent/consumable/nutriment)
			names += R.name
			names_with_amounts += "[R.name] ([round(R.volume, 0.1)]u)"
	if(names.len)
		to_chat(user, span_necrosis("<b><i>Foreign substances detected in bloodstream: [english_list(names_with_amounts)].</i></b>"))
	else
		to_chat(user, span_boldgreen("<i>No foreign substances detected in bloodstream.</i>"))
	if(has_cheele)
		to_chat(user, span_boldwarning("WARNING: Parasitic blood-feeding organism detected within the subject."))
	if(has_incision)
		to_chat(user, span_boldwarning("WARNING: Surgical incision detected."))
	if(has_hemostat)
		to_chat(user, span_boldwarning("WARNING: Surgical hemostatic instrument detected."))
	if(human_target.stat >= DEAD)
		to_chat(user, span_purple("<b>STATUS: DECEASED.</b>"))
	else if(human_target.health <= 0)
		to_chat(user, span_boldred("<b>STATUS: CRITICAL.</b>"))
	else if(human_target.health < human_target.maxHealth * 0.5)
		to_chat(user, span_boldwarning("<b>STATUS: SEVERELY DAMAGED.</b>"))
	else if(human_target.health < human_target.maxHealth)
		to_chat(user, span_warning("<b>STATUS: DAMAGED.</b>"))
	else
		to_chat(user, span_boldgreen("<b>STATUS: NOMINAL.</b>"))
	return TRUE

/obj/effect/proc_holder/spell/invoked/beholder/analyze_terrain
	name = "COMMAND: Analyze Terrain"
	desc = "Analyze the terrain's coordinates, and search for nearby mines if any."
	player_lock = FALSE
	releasedrain = 0
	chargetime = 0
	recharge_time = 5 SECONDS

/obj/effect/proc_holder/spell/invoked/beholder/analyze_terrain/cast(list/targets, mob/living/simple_animal/hostile/rogue/robot/beholder/user)
	if(!user || user.stat == DEAD)
		return FALSE
	var/turf/T = get_turf(targets[1])
	if(!T)
		return FALSE
	if(!do_after(user, 0.5 SECONDS))
		return FALSE
	to_chat(user, span_blue("TERRAIN COORDINATES: X=[T.x] Y=[T.y] Z=[T.z]."))
	var/mine_count = 0
	for(var/obj/effect/frogmine/M in view(12, T))
		mine_count++
		found_ping_global(get_turf(M), "hooked_tile")
	if(mine_count)
		to_chat(user, span_danger("There are [mine_count] mines around."))
	else
		to_chat(user, span_notice("No mines detected in visual range."))
	return TRUE

/proc/found_ping_global(atom/A, state)
	if(!A || !state)
		return
	var/image/I = image(icon = 'icons/effects/effects.dmi', loc = A, icon_state = state, layer = 18)
	if(!I)
		return
	I.layer = 18
	I.plane = 18
	I.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/list/clients = list()
	for(var/mob/M in GLOB.player_list)
		if(M.client)
			clients += M.client
	flick_overlay(I, clients, 30)

/obj/effect/proc_holder/spell/self/beholder/explode
	name = "COMMAND: Self-Destruct"
	desc = "Destroy the BEHOLDER in a catastrophic explosion, returning your consciousness to your body."
	player_lock = FALSE
	releasedrain = 0
	chargetime = 0
	recharge_time = 15 SECONDS

/obj/effect/proc_holder/spell/self/beholder/explode/cast(list/targets, mob/living/simple_animal/hostile/rogue/robot/beholder/user)
	if(!user || user.stat == DEAD)
		return FALSE
	if(!do_after(user, 5 SECONDS))
		return FALSE
	var/turf/T = get_turf(user)
	if(!T)
		return FALSE
	explosion(T, 1, 2, 3, 4)
	user.death()
	return TRUE

/obj/effect/proc_holder/spell/self/beholder/comms
	name = "COMMAND: Interface"
	desc = "Transmit a message through your assigned communications network."
	releasedrain = 0
	chargetime = 0
	recharge_time = 3 SECONDS
	player_lock = FALSE

/obj/effect/proc_holder/spell/self/beholder/comms/cast(list/targets, mob/living/simple_animal/hostile/rogue/robot/beholder/user)
	if(!user || user.stat == DEAD || !user.scom_faction_net)
		return FALSE
	var/input_text = input(user, "Enter your message:", "SCOM") as null|text
	if(!input_text)
		revert_cast()
		return FALSE
	if(length(input_text) > 100)
		input_text = "<small>[input_text]</small>"
	for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
		if(S.faction_net == user.scom_faction_net)
			S.repeat_message(input_text, user, CMO_SCOM_COLOR, user.get_default_language())
	return TRUE

/obj/effect/proc_holder/spell/self/beholder/chronoshift
	name = "COMMAND: Chronoshift"
	desc = "Shift through time and space, teleporting several tiles ahead."
	player_lock = FALSE
	releasedrain = 0
	chargetime = 0
	recharge_time = 10 SECONDS

/obj/effect/proc_holder/spell/self/beholder/chronoshift/cast(list/targets, mob/living/simple_animal/hostile/rogue/robot/beholder/user)
	if(!user || user.stat == DEAD)
		return FALSE
	var/turf/destination = get_step(user, user.dir)
	if(!destination)
		return FALSE
	var/turf/check = destination
	for(var/i in 1 to 2)
		check = get_step(check, user.dir)
		if(!check)
			return FALSE
	destination = check
	if(destination.density)
		to_chat(user, span_warning("CHRONOSHIFT ABORTED: Destination obstructed."))
		return FALSE
	if(!do_after(user, 4 SECONDS, user))
		return FALSE
	if(destination.density)
		to_chat(user, span_warning("CHRONOSHIFT ABORTED: Destination obstructed."))
		return FALSE
	do_teleport(user, destination, channel = TELEPORT_CHANNEL_FREE)
	return TRUE

/obj/effect/proc_holder/spell/self/beholder/locate_casualty
	name = "COMMAND: Locate Casualty"
	desc = "Locate the nearest deceased personnel whose consciousness remains anchored to this timeline."
	player_lock = FALSE
	releasedrain = 0
	chargetime = 0
	recharge_time = 5 SECONDS

/obj/effect/proc_holder/spell/self/beholder/locate_casualty/cast(list/targets, mob/living/simple_animal/hostile/rogue/robot/beholder/user)
	if(!user || user.stat == DEAD)
		return FALSE
	var/mob/living/closest
	var/closest_distance = INFINITY
	for(var/mob/living/person in GLOB.mob_list)
		if(person == user)
			continue
		if(person.stat != DEAD)
			continue
		if(!person.ckey)
			continue
		var/distance = get_dist(user, person)
		if(distance < closest_distance)
			closest = person
			closest_distance = distance
	if(!closest)
		to_chat(user, span_warning("CASUALTY SEARCH: No deceased personnel with an anchored consciousness detected."))
		return TRUE
	var/direction = dir2text(get_dir(user, closest))
	to_chat(user, span_blue("<b>CASUALTY LOCATED: <b>DISTANCE:</b> [closest_distance] paces<br> <b>DIRECTION:</b> [uppertext(direction)]"))
	return TRUE

/obj/effect/proc_holder/spell/self/beholder/shutdown
	name = "COMMAND: Shutdown"
	desc = "Immediately shut down the BEHOLDER, returning your consciousness to your body."
	player_lock = FALSE
	releasedrain = 0
	chargetime = 0
	recharge_time = 15 SECONDS

/obj/effect/proc_holder/spell/self/beholder/shutdown/cast(list/targets, mob/living/simple_animal/hostile/rogue/robot/beholder/user)
	if(!user || user.stat == DEAD)
		return FALSE
	user.death()
	return TRUE

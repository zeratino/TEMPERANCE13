#define GARRISON_SCOM_COLOR "#FF4242"
#define LEADER_SCOM_COLOR "#fffc61"
#define CMO_SCOM_COLOR "#85fbff"
#define RADIO_SOUNDS
#define SCOMNET_EMPIRE "empire"
#define SCOMNET_ZIGS "zigs"
#define SCOMNET_KINGS "kings"
#define SCOMNET_HUNTERS "hunters"

/obj/structure/roguemachine/scomm/empire
	faction_net = SCOMNET_EMPIRE

/obj/structure/roguemachine/scomm
	name = "SCOM"
	desc = "The Supernatural Communication Optical Machine is a wonder of magic and technology."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "scomm1"
	density = FALSE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	pixel_y = 32
	anchored = TRUE
	var/next_decree = 0
	var/listening = TRUE
	var/speaking = TRUE
	var/dictating = FALSE
	var/scom_number
	var/obj/structure/roguemachine/scomm/calling = null
	var/obj/structure/roguemachine/scomm/called_by = null
	var/spawned_rat = FALSE
	var/garrisonline = FALSE
	var/faction_net = SCOMNET_ZIGS

/obj/structure/roguemachine/scomm/Initialize()
	. = ..()
	become_hearing_sensitive()

/obj/structure/roguemachine/scomm/Destroy()
	lose_hearing_sensitivity()
	return ..()

/proc/scom_send_to_beholders(message, faction_net)
	for(var/mob/living/simple_animal/hostile/rogue/robot/beholder/B in GLOB.mob_list)
		if(B.scom_faction_net == faction_net)
			to_chat(B, span_robot("<b>RADIO:</b> [message]"))

/obj/structure/roguemachine/scomm/OnCrafted(dirin, mob/user)
	. = ..()
	loc = user.loc
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

/obj/structure/roguemachine/scomm/r
	pixel_y = 0
	pixel_x = 32

/obj/structure/roguemachine/scomm/l
	pixel_y = 0
	pixel_x = -32

/obj/structure/roguemachine/scomm/examine(mob/user)
	. = ..()
	if(scom_number)
		. += "Its designation is #[scom_number]."
	if(user.loc == loc)
		. += "<b>THE LAWS OF THE LAND:</b>"
		if(!length(GLOB.laws_of_the_land))
			. += span_danger("The land has no laws! <b>We are doomed!</b>")
			return
		if(!user.is_literate())
			. += span_warning("Uhhh... I can't read them...")
			return
		for(var/i in 1 to length(GLOB.laws_of_the_land))
			. += span_small("[i]. [GLOB.laws_of_the_land[i]]")

/obj/structure/roguemachine/scomm/process()
	if(world.time <= next_decree)
		return
	next_decree = world.time + rand(3 MINUTES, 8 MINUTES)
	if(!GLOB.lord_decrees.len)
		return
	if(!speaking)
		return
	say("The [SSticker.rulertype] Decrees: [pick(GLOB.lord_decrees)]", spans = list("info"))

/obj/structure/roguemachine/scomm/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	if(called_by && !calling)
		calling = called_by
		calling.say("Jabberline fused.", spans = list("info"))
		say("Jabberline fused.", spans = list("info"))
		update_icon()
		return
	if(calling)
		listening = !listening
		to_chat(user, span_info("I [listening ? "unmute" : "mute"] the input on the SCOM."))
		return
	listening = !listening
	speaking = listening
	to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the SCOM."))
	update_icon()

/obj/structure/roguemachine/scomm/attack_right(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	if(called_by && !calling)
		called_by.say("Jabberline refused.", spans = list("info"))
		say("Jabberline refused.", spans = list("info"))
		called_by.calling = null
		called_by = null
		return
	if(calling)
		speaking = !speaking
		to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the output on the SCOM."))
		return
	var/canread = user.can_read(src, TRUE)
	var/contents
	if(SSticker.rulertype == "Grand Duke")
		contents += "<center>GRAND DUKE'S DECREES<BR>"
	else
		contents += "<center>GRAND DUCHESS' DECREES<BR>"
	contents += "-----------<BR><BR></center>"
	for(var/i = GLOB.lord_decrees.len to 1 step -1)
		contents += "[i]. <span class='info'>[GLOB.lord_decrees[i]]</span><BR>"
	if(!canread)
		contents = stars(contents)
	var/datum/browser/popup = new(user, "VENDORTHING", "", 370, 220)
	popup.set_content(contents)
	popup.open()

/obj/structure/roguemachine/scomm/MiddleClick(mob/living/carbon/human/user)
	if(.)
		return
	if((HAS_TRAIT(user, TRAIT_GUARDSMAN) || (user.job == "Warden") || (user.job == "Squire") || (user.job == "Marshal") || (user.job == "Grand Duke") || (user.job == "Knight Captain") || (user.job == "Grand Duchess")))
		if(alert("Would you like to swap lines or connect to a jabberline?",, "swap", "jabberline") != "jabberline")
			garrisonline = !garrisonline
			to_chat(user, span_info("I [garrisonline ? "connect to the garrison SCOMline" : "connect to the general SCOMLINE"]"))
			playsound(loc, 'sound/misc/garrisonscom.ogg', 100, FALSE, -1)
			update_icon()
			return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	if(calling)
		calling.say("Jabberline severed.", spans = list("info"))
		if(calling.calling == src)
			var/obj/structure/roguemachine/scomm/old_calling = calling
			old_calling.called_by = null
			old_calling.calling = null
			old_calling.speaking = old_calling.listening
			old_calling.update_icon()
		calling = null
		called_by = null
		speaking = listening
		to_chat(user, span_info("I cut the jabberline."))
		say("Jabberline severed.", spans = list("info"))
		update_icon()
	else
		say("Input SCOM designation.", spans = list("info"))
		var/nightcall = input(user, "Input the number you have been provided with.", "INTERFACING") as null|num
		if(!nightcall)
			return
		if(nightcall == scom_number)
			to_chat(user, span_warning("Nothing but rats squeaking back at you."))
			playsound(src, 'sound/vo/mobs/rat/rat_life.ogg', 100, TRUE, -1)
			return
		if(SSroguemachine.scomm_machines.len < nightcall)
			say("There are no rats running this jabberline.", spans = list("info"))
			return
		var/obj/structure/roguemachine/scomm/S = SSroguemachine.scomm_machines[nightcall]
		if(!S)
			to_chat(user, span_warning("Nothing but rats squeaking back at you."))
			playsound(src, 'sound/vo/mobs/rat/rat_life.ogg', 100, TRUE, -1)
			return
		if(S.calling || S.called_by)
			say("This jabberline's rats are occupied.", spans = list("info"))
			return
		if(!S.speaking)
			say("This jabberline's rats have been gagged.", spans = list("info"))
			return
		calling = S
		S.called_by = src
		update_icon()

		for(var/i in 1 to 10)
			if(!calling)
				update_icon()
				return
			if(calling.calling == src)
				return
			calling.ring_ring()
			ring_ring()
			sleep(30)
		say("This jabberline's rats are exhausted.", spans = list("info"))
		calling.called_by = null
		calling = null
		update_icon()

/obj/structure/roguemachine/scomm/obj_break(damage_flag)
	..()
	calling?.say("Jabberline severed.", spans = list("info"))
	calling?.speaking = calling?.listening
	calling?.called_by = null
	calling?.calling = null
	called_by = null
	calling = null
	speaking = FALSE
	listening = FALSE
	update_icon()
	icon_state = "[icon_state]-br"

/obj/structure/roguemachine/scomm/Initialize()
	. = ..()
//	icon_state = "scomm[rand(1,2)]"
	START_PROCESSING(SSroguemachine, src)
	update_icon()
	SSroguemachine.scomm_machines += src
	scom_number = SSroguemachine.scomm_machines.len

/obj/structure/roguemachine/scomm/update_icon()
	if(obj_broken)
		set_light(0)
		return
	if(garrisonline)
		icon_state = "scomm2"
		return
	if(calling)
		icon_state = "scomm2"
	else if(listening)
		icon_state = "scomm1"
	else
		icon_state = "scomm0"

/obj/structure/roguemachine/scomm/Destroy()
	SSroguemachine.scomm_machines -= src
	STOP_PROCESSING(SSroguemachine, src)
	set_light(0)
	return ..()

/obj/structure/roguemachine/scomm/proc/ring_ring()
	playsound(src, 'sound/vo/mobs/rat/rat_life.ogg', 100, TRUE, -1)
	var/oldx = pixel_x
	animate(src, pixel_x = oldx+1, time = 0.5)
	animate(pixel_x = oldx-1, time = 0.5)
	animate(pixel_x = oldx, time = 0.5)

/obj/structure/roguemachine/scomm/proc/repeat_message(message, atom/A, tcolor, message_language)
	if(A == src)
		return
	if(tcolor)
		voicecolor_override = tcolor
	if(speaking && message)
		playsound(loc, 'sound/vo/mobs/rat/rat_life.ogg', 100, TRUE, -1)
		say(message, language = message_language)
	voicecolor_override = null

/obj/structure/roguemachine/scomm/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, original_message)
	if(speaker.loc != loc && !calling)
		return
	if(!ishuman(speaker))
		return
	if(!listening)
		return
	var/mob/living/carbon/human/H = speaker
	var/usedcolor = H.voice_color
	if(H.voicecolor_override)
		usedcolor = H.voicecolor_override
	if(raw_message)
		if(calling)
			if(calling.calling == src)
				calling.repeat_message(raw_message, src, usedcolor, message_language)
			return
		if(length(raw_message) > 100) //When these people talk too much, put that shit in slow motion, yeah
			/*if(length(raw_message) > 200)
				if(!spawned_rat)
					visible_message(span_warning("An angered rous emerges from the SCOMlines!"))
					new /mob/living/simple_animal/hostile/retaliate/rogue/bigrat(get_turf(src))
					spawned_rat = TRUE
				return*/
			raw_message = "<small>[raw_message]</small>"
		if(garrisonline)
			raw_message = "<span style='color: [GARRISON_SCOM_COLOR]'>[raw_message]</span>" //Prettying up for Garrison line
			for(var/obj/item/scomstone/bad/garrison/S in SSroguemachine.scomm_machines)
				S.repeat_message(raw_message, src, usedcolor, message_language)
			for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
				if(S.garrisonline)
					S.repeat_message(raw_message, src, usedcolor, message_language)
			SSroguemachine.crown?.repeat_message(raw_message, src, usedcolor, message_language)
			scom_send_to_beholders(raw_message, faction_net)
			return
		for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
			if(!S.calling)
				S.repeat_message(raw_message, src, usedcolor, message_language)
		for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
			S.repeat_message(raw_message, src, usedcolor, message_language)
		for(var/obj/item/listenstone/S in SSroguemachine.scomm_machines)
			S.repeat_message(raw_message, src, usedcolor, message_language)//make the listenstone hear scom
		scom_send_to_beholders(raw_message, faction_net)
		SSroguemachine.crown?.repeat_message(raw_message, src, usedcolor, message_language)

/obj/structure/roguemachine/scomm/proc/dictate_laws()
	if(dictating)
		return
	dictating = TRUE
	repeat_message("THE LAWS OF THE LAND ARE...", tcolor = COLOR_RED)
	INVOKE_ASYNC(src, PROC_REF(dictation))

/obj/structure/roguemachine/scomm/proc/dictation()
	if(!length(GLOB.laws_of_the_land))
		sleep(2)
		repeat_message("THE LAND HAS NO LAWS!", tcolor = COLOR_RED)
		dictating = FALSE
		return
	for(var/i in 1 to length(GLOB.laws_of_the_land))
		sleep(2)
		repeat_message("[i]. [GLOB.laws_of_the_land[i]]", tcolor = COLOR_RED)
	dictating = FALSE

/proc/scom_announce(message)
	for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
		if(S.speaking)
			S.say(message, spans = list("info"))



//SCOMSTONE                 SCOMSTONE

/obj/item/scomstone
	name = "communication piece"
	icon_state = "scomstone1"
	desc = "A wrist-mounted communication device far ahead of its time, deeply affixed to its wearer. Removing it against its will is an arduous and laborious task."
	gripped_intents = null
	dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 10
	slot_flags = ITEM_SLOT_WRISTS
	obj_flags = null
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	experimental_inhand = FALSE
	muteinmouth = TRUE
	strip_delay = STRIP_DELAY_LOCKED
	var/listening = TRUE
	var/speaking = TRUE
	var/messagereceivedsound = 'sound/misc/ris_radio.ogg'
	var/hearrange = 0 // change to 0 if you want your special scomstone to be only hearable by wearer
	var/faction_net = SCOMNET_ZIGS
	drop_sound = 'sound/foley/coinphy (1).ogg'
	sellprice = 100
	grid_width = 32
	grid_height = 32
//wip
/obj/item/scomstone/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_INTENTCAP)
	visible_message(span_notice ("[user] presses their radio against their mouth."))
	var/input_text = input(user, "Enter your message:", "Message")
	if(!input_text)
		return
	var/usedcolor = user.voice_color
	if(user.voicecolor_override)
		usedcolor = user.voicecolor_override
	user.whisper(input_text)
	if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
		input_text = "<small>[input_text]</small>"
	for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
		if(S.faction_net == faction_net)
			S.repeat_message(input_text, src, usedcolor)
	scom_send_to_beholders(input_text, faction_net)

/obj/item/scomstone/MiddleClick(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/radiomute.ogg', 100, FALSE, -1)
	listening = !listening
	speaking = !speaking
	to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the communication device."))
	update_icon()

/obj/item/scomstone/Destroy()
	SSroguemachine.scomm_machines -= src
	lose_hearing_sensitivity()
	return ..()

/obj/item/scomstone/Initialize()
	. = ..()
	become_hearing_sensitive()
	update_icon()
	SSroguemachine.scomm_machines += src

/obj/item/scomstone/proc/repeat_message(message, atom/A, tcolor, message_language)
	if(A == src)
		return
	if(!ismob(loc))
		return
	if(tcolor)
		voicecolor_override = tcolor
	if(speaking && message)
		playsound(loc, messagereceivedsound, 100, TRUE, -1)
		say(message, language = message_language)
	voicecolor_override = null


/obj/item/scomstone/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!can_speak())
		return
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_default_language()
	if(istype(loc, /obj/item))
		var/obj/item/I = loc
		I.send_speech(message, hearrange, I, , spans, message_language=language)
	else
		send_speech(message, hearrange, src, , spans, message_language=language)

/obj/item/scomstone/bad
	name = "serfstone"
	desc = "A rusty shoddily-made metal ring. The gem embedded within is barely holding on."
	icon_state = "ring_serfscom"
	listening = FALSE
	sellprice = 20

/obj/item/scomstone/bad/attack_right(mob/user)
	return

/obj/item/scomstone/empire

	icon_state = "scomstoner1"
	desc = "A wrist-mounted communication device far ahead of its time, deeply affixed to its wearer. Removing it against its will is an arduous and laborious task."
	faction_net = SCOMNET_EMPIRE

//needs testing
/obj/item/scomstone/empire/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_INTENTCAP)
	visible_message(span_notice ("[user] presses their radio against their mouth."))
	var/input_text = input(user, "Enter your message:", "Message")
	if(!input_text)
		return
	var/usedcolor = user.voice_color
	if(user.voicecolor_override)
		usedcolor = user.voicecolor_override
	user.whisper(input_text)
	if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
		input_text = "<small>[input_text]</small>"
	for(var/obj/item/scomstone/empire/S in SSroguemachine.scomm_machines)//make the listenstone hear scomstone
		S.repeat_message(input_text, src, usedcolor)
	scom_send_to_beholders(input_text, faction_net)

//LISTENSTONE		LISTENSTONE
/obj/item/listenstone
	name = "emerald choker"
	icon_state = "listenstone"
	desc = "An iron and gold choker with an emerald gem."
	gripped_intents = null
	//dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	//force = 10
	//throwforce = 10
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP|ITEM_SLOT_NECK|ITEM_SLOT_WRISTS
	obj_flags = null
	icon = 'icons/roguetown/clothing/neck.dmi'
	w_class = WEIGHT_CLASS_SMALL
	experimental_inhand = FALSE
	muteinmouth = TRUE
	var/listening = TRUE
	var/speaking = TRUE
	sellprice = 200
	grid_width = 32
	grid_height = 32

/obj/item/listenstone/MiddleClick(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	listening = !listening
	speaking = !speaking
	to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the scomstone."))
	update_icon()
	if(listening)
		icon_state = "listenstone"
	else
		icon_state = "listenstone_act"

/obj/item/listenstone/Initialize()
	. = ..()
	update_icon()
	SSroguemachine.scomm_machines += src//dont know what this is for


/obj/item/listenstone/proc/repeat_message(message, atom/A, tcolor, message_language)
	if(A == src)
		return
	if(tcolor)
		voicecolor_override = tcolor
	if(speaking && message)
		playsound(loc, 'sound/vo/mobs/rat/rat_life.ogg', 100, TRUE, -1)
		say(message, language = message_language)
	voicecolor_override = null

/obj/item/listenstone/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!can_speak())
		return
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_default_language()
	if(istype(loc, /obj/item))
		var/obj/item/I = loc
		I.send_speech(message, 1, I, , spans, message_language=language)
	else
		send_speech(message, 1, src, , spans, message_language=language)

	return


// this currently isnt used in the game
/obj/item/mattcoin
	name = "communication device"
	icon_state = "scomstoner1"
	desc = "A wrist-mounted communication device far ahead of its time, deeply affixed to its wearer. Removing it against its will is an arduous and laborious task."
	gripped_intents = null
	dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 10
	slot_flags = ITEM_SLOT_WRISTS
	obj_flags = null
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	experimental_inhand = FALSE
	muteinmouth = TRUE
	var/listening = TRUE
	var/speaking = TRUE
	var/messagereceivedsound = 'sound/misc/per_radio.ogg'
	var/hearrange = 0 
	sellprice = 0
	grid_width = 32
	grid_height = 32


/obj/item/mattcoin/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_INTENTCAP)
	visible_message(span_notice ("[user] presses their radio against their mouth."))
	var/input_text = input(user, "Enter your message:", "Message")
	if(!input_text)
		return
	if(input_text)
		var/usedcolor = user.voice_color
		if(user.voicecolor_override)
			usedcolor = user.voicecolor_override
		user.whisper(input_text)
		if(length(input_text) > 100)
			input_text = "<small>[input_text]</small>"
		for(var/obj/item/mattcoin/S in SSroguemachine.scomm_machines)
			S.repeat_message(input_text, src, usedcolor)

/obj/item/mattcoin/MiddleClick(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/radiomute.ogg', 100, FALSE, -1)
	listening = !listening
	speaking = !speaking
	to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the communication device."))
	update_icon()

/obj/item/mattcoin/Destroy()
	lose_hearing_sensitivity()
	SSroguemachine.scomm_machines -= src
	return ..()

/obj/item/mattcoin/proc/repeat_message(message, atom/A, tcolor, message_language)
	if(A == src)
		return
	if(!ismob(loc))
		return
	if(tcolor)
		voicecolor_override = tcolor
	if(speaking && message)
		playsound(loc, messagereceivedsound, 20, TRUE, -1)
		say(message, language = message_language)
	voicecolor_override = null


/obj/item/mattcoin/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!can_speak())
		return
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_default_language()
	if(istype(loc, /obj/item))
		var/obj/item/I = loc
		I.send_speech(message, 0, I, , spans, message_language=language)
	else
		send_speech(message, 0, src, , spans, message_language=language)


// INQUISITORIAL LISTENERS AND RECEIVER


/obj/item/speakerinq
	name = "secret whisperer"
	desc = "Sweet secrets whispered so freely."
	var/speaking = TRUE
	sellprice = 20
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "scomite_active"
	gripped_intents = null
	dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 10
	w_class = WEIGHT_CLASS_SMALL
	experimental_inhand = FALSE
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP|ITEM_SLOT_NECK|ITEM_SLOT_RING
	possible_item_intents = list(INTENT_GENERIC)
	grid_width = 32
	grid_height = 32

/obj/item/speakerinq/proc/repeat_message(message, atom/A, tcolor, message_language)
	if(A == src)
		return
	if(!ismob(loc))
		return
	if(tcolor)
		voicecolor_override = tcolor
	if(speaking && message)
		playsound(loc, 'sound/vo/mobs/rat/rat_life.ogg', 20, TRUE, -1)
		say(message, language = message_language)
	voicecolor_override = null

/obj/item/speakerinq/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!can_speak())
		return
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_default_language()
	if(istype(loc, /obj/item))
		var/obj/item/I = loc
		I.send_speech(message, 0, I, , spans, message_language=language)
	else
		send_speech(message, 0, src, , spans, message_language=language)

/obj/item/speakerinq/Destroy()
	SSroguemachine.scomm_machines -= src
	return ..()

/obj/item/speakerinq/Initialize()
	. = ..()
	update_icon()
	SSroguemachine.scomm_machines += src

/obj/item/speakerinq/MiddleClick(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	speaking = !speaking
	to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the listener."))
	update_icon()

/obj/item/listeningdevice
	name = "listener"
	desc = "An ever-attentive ear"
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "listenstone"
	dropshrink = 0.75
	gripped_intents = null
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 10
	w_class = WEIGHT_CLASS_SMALL
	experimental_inhand = FALSE
	grid_width = 32
	grid_height = 32

/obj/item/listeningdevice/attack_self(mob/living/user)
	var/turf/step_turf = get_step(get_turf(user), user.dir)
	to_chat(user, span_tinynotice("I begin planting the listen-stone..."))
	if(!do_after(user, 30, src))
		return
	new /obj/structure/listeningdeviceactive(step_turf)
	message_admins("[usr.key] has planted a listening device")
	qdel(src)


/obj/structure/listeningdeviceactive
	name = "listener"
	desc = "An ever attentive ear. A red light blinks upon it..."
	icon_state = "listenstone_active"
	icon = 'icons/roguetown/items/misc.dmi'
	var/listening = TRUE
	density = FALSE
	anchored = TRUE
	alpha = 0
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER

/obj/structure/listeningdeviceactive/Initialize()
	. = ..()
	become_hearing_sensitive()

/obj/structure/listeningdeviceactive/Destroy()
	lose_hearing_sensitivity()
	return ..()

/obj/structure/listeningdeviceactive/attack_right(mob/user)
	to_chat(user, span_info("I begin dismounting the listen-stone..."))
	if(!do_after(user, 30, src))
		return
	new /obj/item/listeningdevice(loc)
	qdel(src)

/obj/structure/listeningdeviceactive/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, original_message)
	if(!ishuman(speaker))
		return
	if(!listening)
		return
	var/mob/living/carbon/human/H = speaker
	var/usedcolor = H.voice_color
	if(H.voicecolor_override)
		usedcolor = H.voicecolor_override
	if(!raw_message)
		return
	if(length(raw_message) > 100)
		raw_message = "<small>[raw_message]</small>"
	for(var/obj/item/speakerinq/S in SSroguemachine.scomm_machines)
		S.repeat_message(raw_message, src, usedcolor, message_language)

// garrison scoms/listenstones

/obj/item/scomstone/garrison
	name = "communications device"
	icon_state = "scomstoner1"
	desc = "A wrist-mounted communication device far ahead of its time, deeply affixed to its wearer. Removing it against its will is an arduous and laborious task."
	var/garrisonline = TRUE
	messagereceivedsound = 'sound/misc/per_radio.ogg'
	hearrange = 0
	sellprice = 100
	faction_net = SCOMNET_EMPIRE

/obj/item/scomstone/garrison/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_INTENTCAP)
	visible_message(span_notice ("[user] moves their wrist by their mouth."))
	var/input_text = input(user, "Enter your message:", "Message")
	if(!input_text)
		return
	var/usedcolor = user.voice_color
	if(user.voicecolor_override)
		usedcolor = user.voicecolor_override
	user.whisper(input_text)
	if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
		input_text = "<small>[input_text]</small>"
	if(garrisonline)
		for(var/obj/item/scomstone/bad/garrison/S in SSroguemachine.scomm_machines)
			S.repeat_message(input_text, src, usedcolor)
		for(var/obj/item/scomstone/garrison/S in SSroguemachine.scomm_machines)
			S.repeat_message(input_text, src, usedcolor)
		for(var/obj/item/scomstone/perlead/D in SSroguemachine.scomm_machines)
			if(D.faction_net == faction_net)
				D.repeat_message(input_text, src, usedcolor)
		return

/obj/item/scomstone/bad/garrison
	name = "houndstone"
	desc = "A basic metal ring. It has a well-cut, dismal gem embedded - bearing the mark of the Crown."
	icon_state = "ring_houndscom"
	listening = FALSE
	sellprice = 20
	messagereceivedsound = 'sound/misc/garrisonscom.ogg'
	hearrange = 0


/obj/item/scomstone/kingsrow
	name = "communication piece"
	icon_state = "scomstone"
	desc = "A wrist-mounted communication device far ahead of its time, deeply affixed to its wearer. Removing it against its will is an arduous and laborious task."
	faction_net = SCOMNET_KINGS
	drop_sound = 'sound/foley/coinphy (1).ogg'

/obj/item/scomstone/rislead
	name = "communication piece"
	icon_state = "scomstone1"
	desc = "A wrist-mounted communication device far ahead of its time, deeply affixed to its wearer. Removing it against its will is an arduous and laborious task."
	gripped_intents = null
	dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 10
	slot_flags = ITEM_SLOT_WRISTS
	obj_flags = null
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	experimental_inhand = FALSE
	muteinmouth = TRUE
	listening = TRUE
	speaking = TRUE
	messagereceivedsound = 'sound/misc/ris_radio.ogg'
	hearrange = 0 // change to 0 if you want your special scomstone to be only hearable by wearer
	faction_net = SCOMNET_ZIGS
	drop_sound = 'sound/foley/coinphy (1).ogg'
	sellprice = 100
	grid_width = 32
	grid_height = 32

/obj/item/scomstone/rislead/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_INTENTCAP)
	visible_message(span_notice ("[user] moves their wrist by their mouth."))
	var/input_text = input(user, "Enter your message:", "Message")
	if(!input_text)
		return
	var/usedcolor = user.voice_color
	if(user.voicecolor_override)
		usedcolor = user.voicecolor_override
	user.whisper(input_text)
	if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
		input_text = "<small>[input_text]</small>"
	for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
		if(S.faction_net == faction_net)
			input_text = "<span style='color: [LEADER_SCOM_COLOR]'>[input_text]</span>"
			S.repeat_message(input_text, src, usedcolor)

/obj/item/scomstone/rislead/lesser

/obj/item/scomstone/rislead/lesser/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_INTENTCAP)
	visible_message(span_notice ("[user] moves their wrist by their mouth."))
	var/input_text = input(user, "Enter your message:", "Message")
	if(!input_text)
		return
	var/usedcolor = user.voice_color
	if(user.voicecolor_override)
		usedcolor = user.voicecolor_override
	user.whisper(input_text)
	if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
		input_text = "<small>[input_text]</small>"
	for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
		if(S.faction_net == faction_net)
			input_text = "<span style='color: [GARRISON_SCOM_COLOR]'>[input_text]</span>"
			S.repeat_message(input_text, src, usedcolor)

/obj/item/scomstone/rislead/cmo

/obj/item/scomstone/rislead/cmo/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_INTENTCAP)
	visible_message(span_notice ("[user] moves their wrist by their mouth."))
	var/input_text = input(user, "Enter your message:", "Message")
	if(!input_text)
		return
	var/usedcolor = user.voice_color
	if(user.voicecolor_override)
		usedcolor = user.voicecolor_override
	user.whisper(input_text)
	if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
		input_text = "<small>[input_text]</small>"
	for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
		if(S.faction_net == faction_net)
			input_text = "<span style='color: [CMO_SCOM_COLOR]'>[input_text]</span>"
			S.repeat_message(input_text, src, usedcolor)

/obj/item/scomstone/perlead/lesser

/obj/item/scomstone/perlead/lesser/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_INTENTCAP)
	visible_message(span_notice ("[user] moves their wrist by their mouth."))
	var/input_text = input(user, "Enter your message:", "Message")
	if(!input_text)
		return
	var/usedcolor = user.voice_color
	if(user.voicecolor_override)
		usedcolor = user.voicecolor_override
	user.whisper(input_text)
	if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
		input_text = "<small>[input_text]</small>"
	for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
		if(S.faction_net == faction_net)
			input_text = "<span style='color: [GARRISON_SCOM_COLOR]'>[input_text]</span>"
			S.repeat_message(input_text, src, usedcolor)

/obj/item/scomstone/perlead/cmo

/obj/item/scomstone/perlead/cmo/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_INTENTCAP)
	visible_message(span_notice ("[user] moves their wrist by their mouth."))
	var/input_text = input(user, "Enter your message:", "Message")
	if(!input_text)
		return
	var/usedcolor = user.voice_color
	if(user.voicecolor_override)
		usedcolor = user.voicecolor_override
	user.whisper(input_text)
	if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
		input_text = "<small>[input_text]</small>"
	for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
		if(S.faction_net == faction_net)
			input_text = "<span style='color: [CMO_SCOM_COLOR]'>[input_text]</span>"
			S.repeat_message(input_text, src, usedcolor)

/obj/item/scomstone/perlead
	name = "communications device"
	icon_state = "scomstoner1"
	desc = "A wrist-mounted communication device far ahead of its time, deeply affixed to its wearer. Removing it against its will is an arduous and laborious task."
	messagereceivedsound = 'sound/misc/per_radio.ogg'
	hearrange = 0
	sellprice = 100
	faction_net = SCOMNET_EMPIRE

/obj/item/scomstone/perlead/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_INTENTCAP)
	visible_message(span_notice ("[user] moves their wrist by their mouth."))
	var/input_text = input(user, "Enter your message:", "Message")
	if(!input_text)
		return
	var/usedcolor = user.voice_color
	if(user.voicecolor_override)
		usedcolor = user.voicecolor_override
	user.whisper(input_text)
	if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
		input_text = "<small>[input_text]</small>"
	for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
		if(S.faction_net == faction_net)
			input_text = "<span style='color: [LEADER_SCOM_COLOR]'>[input_text]</span>"
			S.repeat_message(input_text, src, usedcolor)

/obj/item/scomstone/hunter
	name = "communications device"
	icon_state = "scomstoner1"
	desc = "A wrist-mounted communication device far ahead of its time, deeply affixed to its wearer. Removing it against its will is an arduous and laborious task."
	var/garrisonline = TRUE
	hearrange = 0
	sellprice = 100
	faction_net = SCOMNET_HUNTERS

/obj/item/scomstone/hunter/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_INTENTCAP)
	visible_message(span_notice ("[user] moves their wrist by their mouth."))
	var/input_text = input(user, "Enter your message:", "Message")
	if(!input_text)
		return
	var/usedcolor = user.voice_color
	if(user.voicecolor_override)
		usedcolor = user.voicecolor_override
	user.whisper(input_text)
	if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
		input_text = "<small>[input_text]</small>"
	if(garrisonline)
		for(var/obj/item/scomstone/bad/garrison/S in SSroguemachine.scomm_machines)
			S.repeat_message(input_text, src, usedcolor)
		for(var/obj/item/scomstone/garrison/S in SSroguemachine.scomm_machines)
			S.repeat_message(input_text, src, usedcolor)
		for(var/obj/item/scomstone/perlead/D in SSroguemachine.scomm_machines)
			if(D.faction_net == faction_net)
				D.repeat_message(input_text, src, usedcolor)
		return

/obj/item/scomstone/huntlead
	name = "communications device"
	icon_state = "scomstoner1"
	desc = "A wrist-mounted communication device far ahead of its time, deeply affixed to its wearer. Removing it against its will is an arduous and laborious task."
	hearrange = 0
	sellprice = 100
	faction_net = SCOMNET_HUNTERS

/obj/item/scomstone/huntlead/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_INTENTCAP)
	visible_message(span_notice ("[user] moves their wrist by their mouth."))
	var/input_text = input(user, "Enter your message:", "Message")
	if(!input_text)
		return
	var/usedcolor = user.voice_color
	if(user.voicecolor_override)
		usedcolor = user.voicecolor_override
	user.whisper(input_text)
	if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
		input_text = "<small>[input_text]</small>"
	for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
		if(S.faction_net == faction_net)
			input_text = "<span style='color: [LEADER_SCOM_COLOR]'>[input_text]</span>"
			S.repeat_message(input_text, src, usedcolor)

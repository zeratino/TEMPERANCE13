/obj/effect/proc_holder/spell/invoked/holding/rebel
	name = "Hold Ranks"
	desc = "Order those around to to bundle together, increasing durability for a while."
	cost = 3
	xp_gain = FALSE
	chargetime = 10
	recharge_time = 60 SECONDS
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/blank
	associated_skill = /datum/skill/magic/arcane
	req_items = list(/obj/item/scomstone/kingsrow)
	overlay_state = "repulse"
	spell_tier = 2
	invocation = "THERE IS NOTHING TO LOSE BUT YOUR CHAINS!!"
	invocation_type = "shout"
	gesture_required = TRUE
	antimagic_allowed = TRUE

/obj/effect/proc_holder/spell/invoked/holding/rebel/cast(list/targets,mob/user = usr)
	. = ..()
	for(var/mob/living/carbon/human/orderedguy in (get_hearers_in_view(order_range, user) - user))
		if(isliving(orderedguy))
			if(orderedguy.job in GLOB.rebel_positions)
				orderedguy.apply_status_effect(/datum/status_effect/buff/order/hold)
			else
				return
	return TRUE

/obj/effect/proc_holder/spell/invoked/aim/rebel
	name = "Take Aim"
	desc = "Order those around to focus on hitting their shots."
	cost = 3
	xp_gain = FALSE
	chargetime = 10
	recharge_time = 60 SECONDS
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/blank
	associated_skill = /datum/skill/magic/arcane
	req_items = list(/obj/item/scomstone/kingsrow)
	overlay_state = "repulse"
	spell_tier = 2
	invocation = "TAKE AIM!"
	invocation_type = "shout"
	gesture_required = TRUE
	antimagic_allowed = TRUE

/obj/effect/proc_holder/spell/invoked/aim/rebel/cast(list/targets,mob/user = usr)
	. = ..()
	for(var/mob/living/carbon/human/orderedguy in (get_hearers_in_view(order_range, user) - user))
		if(isliving(orderedguy))
			if(orderedguy.job in GLOB.rebel_positions)
				orderedguy.apply_status_effect(/datum/status_effect/buff/order/takeaim)
			else
				return
	return TRUE

/obj/effect/proc_holder/spell/invoked/charge/rebel
	name = "CHARGE!"
	desc = "ORDER THOSE AROUND TO CHARGE FORWARD!"
	cost = 3
	xp_gain = FALSE
	chargetime = 10
	recharge_time = 60 SECONDS
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/blank
	associated_skill = /datum/skill/magic/arcane
	req_items = list(/obj/item/scomstone/kingsrow)
	overlay_state = "repulse"
	spell_tier = 2
	invocation = "FOR THE REVOLUTION, CHAAAAAAAAARGE!!"
	invocation_type = "shout"
	gesture_required = TRUE
	antimagic_allowed = TRUE

/obj/effect/proc_holder/spell/invoked/charge/rebel/cast(list/targets,mob/user = usr)
	. = ..()
	var/list/chargeline = list("VIVA ARDERLA!!", "FOR THE REVOLUTION!!", "CHAAAAAAAAARGE!!!")
	for(var/mob/living/carbon/human/orderedguy in (get_hearers_in_view(order_range, user) - user))
		if(isliving(orderedguy))
			if(orderedguy.job in GLOB.rebel_positions)
				orderedguy.apply_status_effect(/datum/status_effect/buff/order/movemovemove)
				orderedguy.say(pick(chargeline))
				orderedguy.emote("warcry", forced = TRUE)
			else
				return
	return TRUE

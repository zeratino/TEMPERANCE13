/datum/sex_action/miscellaneous/stockjob
	name = "Grind stock against them"
	check_same_tile = FALSE
	intensity = 2
	debug_erp_panel_verb = FALSE

/datum/sex_action/miscellaneous/stockjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	var/obj/item/held_item = user.get_active_held_item()
	if(!held_item || !istype(held_item, /obj/item/gun/ballistic/rifle, /obj/item/gun/ballistic/shotgun))
		return FALSE
	return TRUE

/datum/sex_action/miscellaneous/stockjob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return FALSE
	if(user == target)
		return FALSE
	var/obj/item/held_item = user.get_active_held_item()
	if(!held_item || !istype(held_item, /obj/item/gun/ballistic/rifle, /obj/item/gun/ballistic/shotgun))
		return FALSE
	return TRUE

/datum/sex_action/stockjob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
		user.visible_message(span_warning"[user] begins grinding the stock of [user.p_their()] [user.get_active_held_item()] into [target]'s groin..."")

/datum/sex_action/stockjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] grinds their [user.get_active_held_item()] against [target]'s groin."))
	user.sexcon.generic_sex_noise()

	user.sexcon.perform_sex_action(target, 2, 4, TRUE)
    target.sexcon.handle_passive_ejaculation(user)

/datum/sex_action/stockjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops grinding their [user.get_active_held_item()] against [target]."))

/datum/sex_action/stockjob/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE

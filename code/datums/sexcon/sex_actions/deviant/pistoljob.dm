/datum/sex_action/miscellaneous/pistoljob
	name = "Prod mouth with pistol"
	check_same_tile = FALSE
	category = SEX_CATEGORY_PENETRATE
	user_sex_part = SEX_PART_JAWS

/datum/sex_action/miscellaneous/pistoljob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	var/obj/item/held_item = user.get_active_held_item()
	if(!held_item || !istype(held_item, /obj/item/gun/ballistic/revolver))
		return FALSE
	return TRUE

/datum/sex_action/miscellaneous/pistoljob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return FALSE
	if(user == target)
		return FALSE
	if(!check_location_accessible(user, user, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	var/obj/item/held_item = user.get_active_held_item()
	if(!held_item || !istype(held_item, /obj/item/gun/ballistic/revolver))
		return FALSE
	return TRUE

/datum/sex_action/pistoljob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
		user.visible_message(span_warning"[user] places the barrel of [user.p_their()] pistol into [target]'s mouth...")

/datum/sex_action/pistoljob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] forces the pistol into [target]."))
	user.sexcon.oralcourse_noise(user)
	

	user.sexcon.perform_sex_action(target, 0.5, 0, TRUE)
	target.sexcon.handle_passive_ejaculation()
	if(!target.sexcon.considered_limp())
		user.sexcon.perform_deepthroat_oxyloss(user, 1.3)
	
/datum/sex_action/pistoljob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops pistol-fucking [target]."))

  /datum/sex_action/pistoljob/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE

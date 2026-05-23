/datum/sex_action/miscellaneous/masturbate_gunfrot
	name = "Frot with weapon"
	check_same_tile = FALSE
	category = SEX_CATEGORY_HANDS
	user_sex_part = SEX_PART_COCK

/datum/sex_action/miscellaneous/masturbate_gunfrot/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	var/obj/item/held_item = user.get_active_held_item()
	if(!held_item || !istype(held_item, /obj/item/gun/ballistic/revolver, /obj/item/gun/ballistic/rifle, /obj/item/gun/ballistic/shotgun))
		return FALSE
	return TRUE

/datum/sex_action/masturbate_gunfrot/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] shoves their cock against their [user.get_active_held_item()]..."))

/datum/sex_action/masturbate_gunfrot/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/chosen_verb = pick(list("pleasures themself against the [user.get_active_held_item()]", "grinds against \the [user.get_active_held_item()]"))

	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] [chosen_verb]."))

	user.sexcon.generic_sex_noise()

	user.sexcon.perform_sex_action(user, 2, 6, TRUE)

	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/masturbate_gunfrot/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops frotting with their weapon."))

/datum/sex_action/masturbate_gunfrot/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
/datum/sex_action/bootjob
	name = "Hump their boots"
	check_same_tile = FALSE

/datum/sex_action/bootjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS, ORGAN_SLOT_VAGINA))
		return FALSE
	return TRUE

/datum/sex_action/bootjob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS, ORGAN_SLOT_VAGINA))
		return FALSE
	return TRUE

/datum/sex_action/bootjob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] straddles [target]'s boots and begins to grind against them!"))

/datum/sex_action/bootjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] humps into [target]'s boot."))
	user.sexcon.outercourse_noise(target)

	user.sexcon.perform_sex_action(user, 2, 0.5, TRUE)
	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/bootjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] pulls themselves off of [target]'s boot."))

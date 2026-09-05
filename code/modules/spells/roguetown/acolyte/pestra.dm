// Diagnose
/obj/effect/proc_holder/spell/invoked/diagnose
	name = "Diagnose"
	desc = "Call upon the MACHINE's medical wisdom to read the body's humors and hidden ailments at a distance. Reveals a target's condition with perfect clarity. To perceive one's blood content, all you'll need is but an incision."
	overlay_state = "diagnose"
	releasedrain = 10
	range = 4
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/diagnose.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 3 SECONDS
	miracle = TRUE
	devotion_cost = 0

/obj/effect/proc_holder/spell/invoked/diagnose/cast(list/targets, mob/living/user)
	var/skill_level = user.get_skill_level(src.associated_skill)
	var/atom/target = targets[1]
	if(!target || !ishuman(user) || !ishuman(target))
		revert_cast()
		return FALSE
	var/mob/living/carbon/human/human_target = target
	var/is_mid_tier = (skill_level >= SKILL_LEVEL_JOURNEYMAN && skill_level <= SKILL_LEVEL_EXPERT)
	var/is_high_tier = (skill_level >= SKILL_LEVEL_MASTER)
	var/bleed_rate = human_target.get_bleed_rate()
	if(miracle)
		is_high_tier = TRUE
	human_target.check_for_injuries(user)
	if(is_high_tier)
		to_chat(user, span_blue("<i>Suffocation: [human_target.oxyloss]%</i>"))
	else
		if(human_target.stat >= DEAD)
			to_chat(user, span_purple("No breath passes through their lips; MACHINE rest their soul."))
		else
			switch(human_target.oxyloss)
				if(0 to 1)
					to_chat(user, span_notice("Their breath flows true and untroubled."))
				if(1 to 50)
					to_chat(user, span_boldwarning("Their breathing is somewhat impeded; the chest labors lightly."))
				if(50 to 100)
					to_chat(user, span_boldred("They are openly suffocating to death; air is desperately needed!"))
				if(100 to INFINITY)
					to_chat(user, span_purple("No breath passes through their lips; MACHINE rest their soul.")) // im a fool, this is better
	if(!(is_mid_tier || is_high_tier || miracle))
		switch(human_target.toxloss)
			if(60 to INFINITY)
				to_chat(user, span_necrosis("Cold sweat, pallid skin, and a failing breath... Signs of poisoning."))
	if(is_mid_tier)
		switch(human_target.toxloss)
			if(0 to 1)
				to_chat(user, span_notice("Their humors seem well-balanced; no oddities of note."))
			if(1 to 50)
				to_chat(user, span_boldwarning("A faint pallor and sweat are seen, the body is burdened with mild toxicity."))
			if(50 to 100)
				to_chat(user, span_boldred("Multiple subtle physical distress are seen, the body is crumbling under heavy toxicity."))
			if(100 to INFINITY)
				to_chat(user, span_necrosis("Their body is ravaged under the weight of fatal toxicity; MACHINE rest their soul."))
		if(bleed_rate > 10)
			to_chat(user, span_bloody("They are bleeding worryingly faster than the body can recover!"))
		if (human_target.reagents.has_reagent(/datum/reagent/infection/major))
			to_chat(user, span_boldwarning("Pronounced redness and swelling are visible, with signs of discharge suggesting a severe infection of the humors."))
		else if (human_target.reagents.has_reagent(/datum/reagent/infection))
			to_chat(user, span_warning("Localized redness and warmth are present, consistent with an active infection of the humors."))
		else if (human_target.reagents.has_reagent(/datum/reagent/infection/minor))
			to_chat(user, span_warning("Slight redness and irritation are visible, possibly an early-stage infection of the humors."))
	if(is_high_tier) // from here on, it's master and legendary only and raw data, the miracle starts from here too, those cheaters
		var/bleed_percent = max(0.1, round((bleed_rate / BLOOD_VOLUME_NORMAL) * 100, 0.1))
		var/blood_percent = round((human_target.blood_volume / BLOOD_VOLUME_NORMAL) * 100)
		to_chat(user, span_necrosis("<i>Toxicity: [human_target.toxloss]%</i>"))
		to_chat(user, span_bloody("<i>Blood volume: [human_target.blood_volume]u ([blood_percent]%)</i>"))
		if(bleed_rate)
			to_chat(user, span_bloody("<i>Bleeding rate: [bleed_rate]u/sec ([bleed_percent]%/sec)</i>"))
		if (human_target.reagents.has_reagent(/datum/reagent/infection/major))
			to_chat(user, span_boldwarning("A severe infection taints their humors."))
		else if (human_target.reagents.has_reagent(/datum/reagent/infection))
			to_chat(user, span_warning("A notable infection taints their humors."))
		else if (human_target.reagents.has_reagent(/datum/reagent/infection/minor))
			to_chat(user, span_warning("A minor infection taints their humors."))
	var/has_cheele = FALSE
	var/has_incision = FALSE
	var/has_hemostat = FALSE
	for(var/obj/item/bodypart/BP in human_target.bodyparts)
		for(var/datum/wound/W in BP.wounds)
			if(istype(W, /datum/wound/slash/incision))
				has_incision = TRUE
				break
		for(var/obj/item/I in BP.embedded_objects)
			if(istype(I, /obj/item/natural/worms/leech))
				has_cheele = TRUE
			if(istype(I, /obj/item/rogueweapon/surgery/hemostat))
				has_hemostat = TRUE
		if(has_cheele && has_incision && has_hemostat)
			break
	var/list/names = list()
	var/list/names_with_amounts = list()
	var/datum/reagent/top_reagent = null
	var/top_volume = 0
	var/more_than_one = names.len > 1
	for(var/datum/reagent/R in human_target.reagents.reagent_list)
		if(R.volume > 0 && R.type != /datum/reagent/water && R.type != /datum/reagent/consumable/nutriment)
			names += R.name
			names_with_amounts += "[R.name] ([round(R.volume, 0.1)]u)"
			if(R.volume > top_volume)
				top_volume = R.volume
				top_reagent = R
	if(has_cheele)
		if(names.len)
			to_chat(user, span_red("The blood-sucking creecher stirs uncomfortably... a foreign substance may be in their blood."))
		else if(more_than_one)
			to_chat(user, span_red("The blood-sucking creecher stirs very uncomfortably... more than one foreign substances may be in their blood."))
		else
			to_chat(user, span_blue("The blood-sucking creecher seems unbothered and content; hinting a clean blood."))
	if(names.len)
		if(miracle && has_incision)
			to_chat(user, span_necrosis("<b><i>With the MACHINE's wisdom, I perceive their blood in full detail, revealing [english_list(names_with_amounts)] within.</b></i>"))

		else if(is_high_tier && has_hemostat && !miracle)
			to_chat(user, span_boldwarning("<i>Studying the blood drawn upon the instrument, I easily discern [english_list(names)] within.</i>"))

		else if(is_mid_tier && has_hemostat && top_reagent && !miracle)
			to_chat(user, span_boldwarning("<i>Studying the blood drawn upon the instrument, I can only see heavy traces of [top_reagent.name] within.</i>"))

		else if(is_mid_tier && has_hemostat && more_than_one && !miracle)
			to_chat(user, span_boldwarning("<i>Studying the blood drawn upon the instrument, I can only see heavy traces of [top_reagent.name], though other substances may be present.</i>"))
	else
		if(miracle && has_incision)
			to_chat(user, span_boldgreen("<i>Even with divine insight, I perceive no foreign substances within their blood.</i>"))
		else if((is_mid_tier || is_high_tier) && has_hemostat && !miracle)
			to_chat(user, span_boldgreen("<i>From the blood drawn upon the instrument, I find no clear trace of any substances in their blood.</i>"))
	return TRUE

/obj/effect/proc_holder/spell/invoked/diagnose/secular
	name = "Secular Diagnosis"
	overlay_state = "diagnose"
	desc = "A practiced reading of the body's humors and hidden ailments. Reveals a target's condition, with greater skill granting deeper detail. By embedding a Forceps on your patient, you may even identify substances within the blood; but even the most unskilled physicker can tell from a Cheele or Leech's reactions."
	associated_skill = /datum/skill/misc/medicine
	miracle = FALSE

// Limb or organ attachment
/obj/effect/proc_holder/spell/invoked/attach_bodypart
	name = "Bodypart Miracle"
	desc = "Attach all limbs and organs you or your target is holding, and near your target."
	overlay_state = "limb_attach"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/gore/flesh_eat_03.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 60 SECONDS //attaching a limb is pretty intense
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/invoked/attach_bodypart/proc/get_organs(mob/living/target, mob/living/user)
	var/list/missing_organs = list(
		ORGAN_SLOT_EARS,
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_TONGUE,
		ORGAN_SLOT_HEART,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_STOMACH,
		ORGAN_SLOT_APPENDIX,
	)
	for(var/missing_organ_slot in missing_organs)
		if(!target.getorganslot(missing_organ_slot))
			continue
		missing_organs -= missing_organ_slot
	if(!length(missing_organs))
		return
	var/list/organs = list()
	//try to get from user's hands first
	for(var/obj/item/organ/potential_organ in user?.held_items)
		if(potential_organ.owner || !(potential_organ.slot in missing_organs))
			continue
		organs += potential_organ
	//then target's hands
	for(var/obj/item/organ/dismembered in target.held_items)
		if(dismembered.owner || !(dismembered.slot in missing_organs))
			continue
		organs += dismembered
	//then finally, 1 tile range around target
	for(var/obj/item/organ/dismembered in range(1, target))
		if(dismembered.owner || !(dismembered.slot in missing_organs))
			continue
		organs += dismembered
	return organs

/obj/effect/proc_holder/spell/invoked/attach_bodypart/proc/get_limbs(mob/living/target, mob/living/user)
	var/list/missing_limbs = target.get_missing_limbs()
	if(!length(missing_limbs))
		return
	var/list/limbs = list()
	//try to get from user's hands first
	for(var/obj/item/bodypart/potential_limb in user?.held_items)
		if(potential_limb.owner || !(potential_limb.body_zone in missing_limbs))
			continue
		limbs += potential_limb
	//then target's hands
	for(var/obj/item/bodypart/dismembered in target.held_items)
		if(dismembered.owner || !(dismembered.body_zone in missing_limbs))
			continue
		limbs += dismembered
	//then finally, 1 tile range around target
	for(var/obj/item/bodypart/dismembered in range(1, target))
		if(dismembered.owner || !(dismembered.body_zone in missing_limbs))
			continue
		limbs += dismembered
	return limbs

// consider adding functionality to regrow one entire organ or limb per casting?
/obj/effect/proc_holder/spell/invoked/attach_bodypart/cast(list/targets, mob/living/user)
	if(ishuman(targets[1]))
		var/mob/living/carbon/human/human_target = targets[1]
		var/same_owner = FALSE
		if(human_target.has_status_effect(/datum/status_effect/buff/necras_vow))
			same_owner = TRUE
			to_chat(user, span_warning("This one has pledged a vow to Necra. Only their own limbs will be accepted."))
		for(var/obj/item/bodypart/limb as anything in get_limbs(human_target, user))
			if(!human_target.get_bodypart(limb.body_zone) && same_owner)
				if(limb.original_owner != human_target)
					continue
			if(human_target.get_bodypart(limb.body_zone) || !limb.attach_limb(human_target))
				continue
			human_target.visible_message(span_info("\The [limb] attaches itself to [human_target]!"), \
								span_notice("\The [limb] attaches itself to me!"))
		for(var/obj/item/organ/organ as anything in get_organs(human_target, user))
			if(human_target.getorganslot(organ.slot) || !organ.Insert(human_target))
				continue
			human_target.visible_message(span_info("\The [organ] attaches itself to [human_target]!"), \
								span_notice("\The [organ] attaches itself to me!"))
		if(!(human_target.mob_biotypes & MOB_UNDEAD))
			for(var/obj/item/bodypart/limb as anything in human_target.bodyparts)
				limb.rotted = FALSE
				limb.skeletonized = FALSE
		human_target.update_body()
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/infestation
	name = "Infestation"
	desc = "Causes a swarm of bugs to surround your target, bites them and causes sickness."
	overlay_state = "null" //sprite later
	releasedrain = 50
	chargetime = 10
	recharge_time = 20 SECONDS
	range = 8
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	devotion_cost = 50 // attack miracle
	req_items = list(/obj/item/clothing/neck/roguetown/psicross/pestra)
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/fliesloop
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	miracle = TRUE

	invocation = "Rot, take them!"
	invocation_type = "shout" //can be none, whisper, emote and shout


/obj/effect/proc_holder/spell/invoked/infestation/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.visible_message(span_warning("[target] is surrounded by a cloud of pestilent vermin!"), span_notice("You surround [target] in a cloud of pestilent vermin!"))
		target.apply_status_effect(/datum/status_effect/buff/infestation/) //apply debuff
		return TRUE
	return FALSE

/datum/status_effect/buff/infestation
	id = "infestation"
	alert_type = /atom/movable/screen/alert/status_effect/buff/infestation
	duration = 10 SECONDS
	effectedstats = list("constitution" = -2)
	var/static/mutable_appearance/rotten = mutable_appearance('icons/roguetown/mob/rotten.dmi', "rotten")

/datum/status_effect/buff/infestation/on_apply()
	. = ..()
	var/mob/living/target = owner
	to_chat(owner, span_danger("I am suddenly surrounded by a cloud of bugs!"))
	target.Jitter(20)
	target.add_overlay(rotten)
	target.update_vision_cone()

/datum/status_effect/buff/infestation/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(rotten)
	target.update_vision_cone()
	. = ..()

/datum/status_effect/buff/infestation/tick()
	var/mob/living/target = owner
	var/mob/living/carbon/M = target
	target.adjustToxLoss(2)
	target.adjustBruteLoss(1)
	var/prompt = pick(1,2,3)
	var/message = pick(
		"Ticks on my skin start to engorge with blood!",
		"Flies are laying eggs in my open wounds!",
		"Something crawled in my ear!",
		"There are too many bugs to count!",
		"They're trying to get under my skin!",
		"Make it stop!",
		"Millipede legs tickle the back of my ear!",
		"Fire ants bite at my feet!",
		"A wasp sting right on the nose!",
		"Cockroaches scurry across my neck!",
		"Maggots slimily wriggle along my body!",
		"Beetles crawl over my mouth!",
		"Fleas bite my ankles!",
		"Gnats buzz around my face!",
		"Lice suck my blood!",
		"Crickets chirp in my ears!",
		"Earwigs crawl into my ears!")
	if(prompt == 1 && iscarbon(M))
		M.add_nausea(pick(10,20))
		to_chat(target, span_warning(message))

/atom/movable/screen/alert/status_effect/buff/infestation
	name = "Infestation"
	desc = "Pestilent vermin bite and chew at my skin."
	icon_state = "debuff"

// Cure rot
/obj/effect/proc_holder/spell/invoked/cure_rot
	name = "Cure Rot"
	desc = "Invoke Pestras will though a Psycross to cast out rot from people or regrow their flesh."
	overlay_state = "cure_rot"
	releasedrain = 90
	chargedrain = 0
	chargetime = 50
	range = 1
	warnie = "sydwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokeholy
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/revive.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 2 MINUTES
	miracle = TRUE
	devotion_cost = 30
	/// Amount of PQ gained for curing zombos
	var/unzombification_pq = PQ_GAIN_UNZOMBIFY
	var/is_lethal = TRUE

/obj/effect/proc_holder/spell/invoked/cure_rot/priest
	desc = "Burn out the rot by Astratas will."
	is_lethal = FALSE

/obj/effect/proc_holder/spell/invoked/cure_rot/cast(list/targets, mob/living/user)
	var/stinky = FALSE
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE

		if(GLOB.tod == "night")
			to_chat(user, span_warning("Let there be light."))
		for(var/obj/structure/fluff/psycross/S in oview(5, user))
			S.AOE_flash(user, range = 8)

		var/datum/antagonist/zombie/was_zombie = target.mind?.has_antag_datum(/datum/antagonist/zombie)
		if(target.stat == DEAD || was_zombie)	//Checks if the target is a dead rotted corpse.
			var/datum/component/rot/rot = target.GetComponent(/datum/component/rot)
			if(rot && rot.amount && rot.amount >= 5 MINUTES)	//Fail-safe to make sure the dead person has at least rotted for ~5 min.
				stinky = TRUE

		if(remove_rot(target = target, user = user, method = "prayer",
			success_message = "The rot leaves [target]'s body!",
			fail_message = "Nothing happens.", lethal = is_lethal))
			target.visible_message(span_notice("The rot leaves [target]'s body!"), span_green("I feel the rot leave my body!"))
			target.remove_status_effect(/datum/status_effect/debuff/rotted_zombie)	//Removes the rotted-zombie debuff if they have it.
			if(stinky)
				target.apply_status_effect(/datum/status_effect/debuff/rotted)	//Perma debuff, needs cure
			return TRUE
		else //Attempt failed, no rot
			target.visible_message(span_warning("The rot fails to leave [target]'s body!"), span_warning("I feel no different..."))
			return FALSE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/cure_rot/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		return FALSE
	var/found = null
	for(var/obj/structure/fluff/psycross/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, span_warning("I need a holy cross."))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/invoked/pestra_leech
	name = "Leeching Purge"
	desc = "Manifest leeches inside of target, causing them to puke them out while restoring some blood and curing minor poisoning."
	overlay_state = "leech_purge"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	range = 4
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/gore/flesh_eat_03.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 60 SECONDS
	miracle = TRUE
	devotion_cost = 30

/obj/effect/proc_holder/spell/invoked/pestra_leech/cast(list/targets, mob/living/user)
	if(iscarbon(targets[1]))
		var/mob/living/carbon/C = targets[1]
		if(C.cmode)
			to_chat(user, span_warning("They're too tense for the delicate arts!"))
			revert_cast()
			return FALSE
		C.vomit()
		C.adjustToxLoss(-30)
		if(C.blood_volume < BLOOD_VOLUME_NORMAL)
			C.blood_volume = min(C.blood_volume+30, BLOOD_VOLUME_NORMAL)
		C.visible_message(span_warning("[C] expels some leeches out of them!"), span_warning("Something roils within me!"))
		new /obj/item/natural/worms/leech(get_turf(C))
		if(prob( (user.get_skill_level(/datum/skill/magic/holy) * 10) ))
			new /obj/item/natural/worms/leech(get_turf(C))
		return TRUE
	revert_cast()
	return FALSE

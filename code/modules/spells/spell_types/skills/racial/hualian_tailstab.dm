/obj/effect/proc_holder/spell/invoked/tail_stab
	name = "Tail Stab"
	desc = "Strike a target with your tail."
	overlay_state = "stab"
	releasedrain = 10
	chargetime = 0
	recharge_time = 45 SECONDS
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = TRUE
	chargedloop = null
	cost = 0
	spell_tier = 1
	miracle = FALSE
	invocation_type = "none"
	range = 2

/obj/effect/proc_holder/spell/invoked/tail_stab/cast(list/targets, mob/living/user)
	var/mob/living/target = targets[1]
	if(!istype(target) || target == user || get_dist(user, target) > 2)
		revert_cast()
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_TAIL))
		revert_cast()
		return FALSE
	user.do_attack_animation(target, ATTACK_EFFECT_DISARM)
	return TRUE

/obj/effect/proc_holder/spell/invoked/tail_stab/drain
	name = "Tail Drain"
	desc = "Strike a target with your tail and drain their blood. This will slowly heal you, restore your Vitae and your blood volume, but it will slow you down.<br><br>(45s CD)"

/obj/effect/proc_holder/spell/invoked/tail_stab/drain/cast(list/targets, mob/living/user)
	if(!..())
		return FALSE
	if(user.has_status_effect(/datum/status_effect/tail_drain))
		to_chat(user, span_warning("You are already digesting some blood through your tail!"))
		return TRUE
	var/mob/living/target = targets[1]
	if(!ishuman(target))
		to_chat(user, span_warning("There is no compatible blood for your tail to drink!"))
		return TRUE
	var/mob/living/carbon/human/H = target
	var/hasnoblood = H.dna?.species && (NOBLOOD in H.dna.species.species_traits)
	if(H.blood_volume <= 0 || hasnoblood)
		to_chat(user, span_warning("[target] has no blood to drain!"))
		return TRUE
	var/blood_amount = H.blood_volume * 0.10
	H.blood_volume = max(H.blood_volume - blood_amount, 0)
	H.handle_blood()
	user.visible_message(
		span_danger("[user]'s tail quickly pierces [target], drawing their blood!"),
		span_notice("My tail pierces [target], drawing their blood into me."),
		span_userdanger("You hear the noise of an organic puncture on flesh!")
	)
	if(HAS_TRAIT(target, TRAIT_WYVERNTOUCHED))
		to_chat(user, span_necrosis("--THEIR BLOOD IS TOXIC! HISS!"))
		user.apply_status_effect(/datum/status_effect/wyverntouched_venom)
	else if(HAS_TRAIT(target, TRAIT_BLOODFIEND))
		to_chat(user, span_warning("This blood is as repulsive as drinking saltwater to quench thirst! It's only making my bloodthirst worse!"))
		user.adjust_vitae(-100)
	else
		user.apply_status_effect(/datum/status_effect/tail_drain, blood_amount)
	return TRUE

/obj/effect/proc_holder/spell/invoked/tail_stab/tox
	name = "Tail Stab"
	desc = "Strike a target with your tail and inject them with your poisonous blood.<br><br>(45s CD)"

/obj/effect/proc_holder/spell/invoked/tail_stab/tox/cast(list/targets, mob/living/user)
	if(!..())
		return FALSE
	var/mob/living/target = targets[1]
	var/blood_cost = user.blood_volume * 0.10
	if(blood_cost <= 0)
		to_chat(user, span_warning("I have no blood to convert into venom!"))
		return TRUE
	user.blood_volume = max(user.blood_volume - blood_cost, 0)
	target.apply_status_effect(/datum/status_effect/wyverntouched_venom)
	user.visible_message(
		span_danger("[user]'s tail quickly pierces [target], pumping venom into their veins!"),
		span_warning("My tail pierces [target], pumping venom into their veins."),
		span_userdanger("You hear the noise of an organic puncture on flesh!")
	)
	return TRUE

/datum/status_effect/tail_drain
	id = "tail_drain"
	duration = 30 SECONDS
	tick_interval = 3 SECONDS
	examine_text = "<span class='artery'>SUBJECTPRONOUN's movements are a little sluggish, but they look healthier.</span>"
	effectedstats = list("speed" = -3, "constitution" = 3)
	var/blood_amount

/datum/status_effect/tail_drain/on_apply(blood)
	. = ..()
	blood_amount = blood
	to_chat(owner, span_notice("The stolen blood begins restoring your body, slowing you down."))

/datum/status_effect/tail_drain/tick()
	if(!owner)
		return
	var/mob/living/carbon/C = owner
	var/restore = blood_amount * 0.1
	C.blood_volume = min(C.blood_volume + restore, BLOOD_VOLUME_NORMAL)
	C.adjust_vitae(restore * 0.4)
	C.adjust_nutrition(restore * 0.3)
	C.adjust_hydration(restore * 0.3)
	C.adjustBruteLoss(restore * 0.5)
	C.adjustFireLoss(restore * 0.3)
	C.adjustToxLoss(restore * 0.7)

/datum/status_effect/wyverntouched_venom
	id = "wyverntouched_venom"
	duration = 30 SECONDS
	examine_text = "<span class='necrosis'>SUBJECTPRONOUN seems sluggish and sickly!</span>"
	tick_interval = 3 SECONDS
	effectedstats = list("speed" = -2)

/datum/status_effect/wyverntouched_venom/on_apply()
	. = ..()
	to_chat(owner, span_necrosis("You suddenly feel sick, as something nasty spreads through your system!"))

/datum/status_effect/wyverntouched_venom/tick()
	if(!owner)
		return
	if(isliving(owner) && !iscarbon(owner))
		var/mob/living/simple_animal/A = owner
		A.adjustBruteLoss(15)
		A.adjustToxLoss(15)
		return
	var/mob/living/carbon/C = owner
	var/toxdmg = rand(1,12)
	C.adjustToxLoss(toxdmg)
	C.Jitter(5)
	if(prob(15))
		switch(rand(1,10))
			if(1)
				C.vomit()
			if(2,3)
				C.dizziness += 10
			if(4,5)
				C.confused += 10
				C.blur_eyes(10)
			if(6 to 9)
				C.stuttering += 30
			if(10)
				C.vomit(blood = TRUE)

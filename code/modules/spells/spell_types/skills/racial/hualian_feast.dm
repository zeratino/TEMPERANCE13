/obj/effect/proc_holder/spell/self/feast
	name = "Feast"
	desc = "Devour a nearby fresh corpse until nothing but bones remain, restoring your hunger, thirst, and vitae."
	releasedrain = 0
	chargetime = 0
	recharge_time = 15 SECONDS
	range = 1
	player_lock = TRUE

/obj/effect/proc_holder/spell/self/feast/cast(list/targets, mob/living/user)
	if(!user || user.stat >= UNCONSCIOUS)
		return FALSE
	var/mob/living/carbon/human/corpse
	for(var/mob/living/carbon/human/H in view(1, user))
		if(H == user)
			continue
		if(H.stat != DEAD)
			continue
		corpse = H
		break

	if(!corpse)
		to_chat(user, span_warning("There is no fresh corpse nearby to feast upon."))
		return FALSE

	user.face_atom(corpse)

	if(corpse.ckey)
		var/list/limbs = list()
		for(var/obj/item/bodypart/BP in corpse.bodyparts)
			if(BP.body_part != BODY_ZONE_HEAD)
				limbs += BP
		if(!length(limbs))
			user.emote("scrunches their nose, finding nothing appetizing.")
			return FALSE

	for(var/i in 1 to 4)
		if(!corpse || QDELETED(corpse) || corpse.stat != DEAD)
			return FALSE
		if(get_dist(user, corpse) > 1)
			return FALSE
		user.face_atom(corpse)
		if(!do_after(user, 1.5 SECONDS, corpse))
			return FALSE
		if(corpse.ckey)
			var/obj/item/bodypart/BP
			for(var/obj/item/bodypart/limb in corpse.bodyparts)
				if(limb.body_part != BODY_ZONE_HEAD)
					BP = limb
					break
			if(BP)
				BP.drop_limb(TRUE)
				user.visible_message(span_artery("[user] tears a chunk from [corpse] and devours it!"), span_artery("You tear a chunk from [corpse] and devour it."))
			else
				user.emote("scrunches their nose, finding nothing appetizing.")
				return FALSE
		else
			user.visible_message(span_artery("[user] tears a chunk from [corpse] and devours it!"), span_artery("You tear a chunk from [corpse] and devour it."))

	if(!corpse || QDELETED(corpse))
		return TRUE

	var/turf/T = get_turf(corpse)
	if(!T)
		return TRUE

	user.visible_message(span_artery("[user] devours the last of [corpse], leaving nothing but bones!"), span_artery("You devour the last of [corpse], leaving nothing but bones."))
	new /obj/effect/decal/remains/human(T)

	user.nutrition = NUTRITION_LEVEL_FULL
	user.hydration = HYDRATION_LEVEL_FULL
	user.bloodpool = VITAE_LEVEL_FULL
	corpse.gib(TRUE, TRUE, TRUE)
	return TRUE

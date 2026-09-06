/obj/effect/proc_holder/spell/self/devil_trigger
	name = "Devil Trigger"
	desc = "Your humanity is the only thing keeping the devil within from taking control. You've been taught never to surrender it, unless directly ordered to.<br><br>Burn dry your fragile Vitae, and sell what remains of your soul to the creature within, becoming unstoppable a short time.<br><br>Has a very long cooldown, and if you don't sate your blood-thirst in 45 seconds, you'll outright die."
	recharge_time = 30 MINUTES
	invocation = list(
		"TEAR ME OPEN! TEAR THEM OPEN! I WANT TO SEE THE BLOOD!!",
		"BREAK THEIR BONES! SPLIT THEIR FLESH! LET ME FEED!!",
		"AAAAAAGH! THEIR HEARTS! THEIR BLOOD! THEIR MEAT! GIVE IT ALL TO ME!!",
		"NO GOD! NO SOUL! NO MERCY! JUST BLOOD! JUST BLOOD! JUST BLOOOOOOD!!",
		"METEMPSYCHOSIS! SHATTER MY FUCKING BINDS!!",
	)
	invocation_type = "shout"
	var/crashout_duration = 45 SECONDS
	var/casting = FALSE

/obj/effect/proc_holder/spell/self/devil_trigger/cast(mob/living/user)
	if(casting)
		return
	casting = TRUE
	if(alert(user, "Are you sure?", "DEVIL TRIGGER", "Yes", "No") != "Yes")
		casting = FALSE
		revert_cast()
		return FALSE
	if(alert(user, "LAST WARNING! YOU'LL DIE IF YOU USE THIS!", "DEVIL TRIGGER", "RIP AND TEAR!", "Nevermind") != "RIP AND TEAR!")
		casting = FALSE
		revert_cast()
		return FALSE
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.bloodpool = 0
		H.devil_trigger_resist()
	user.emote("rage")
	user.add_movespeed_modifier("devil_trigger", update=TRUE, priority=100, multiplicative_slowdown=-0.8, blacklisted_movetypes=(FLYING|FLOATING))
	ADD_TRAIT(user, TRAIT_UNSTOPPABLE, "devil_trigger")
	ADD_TRAIT(user, TRAIT_CRITICAL_RESISTANCE, "devil_trigger")
	ADD_TRAIT(user, TRAIT_GRABIMMUNE, "devil_trigger")
	ADD_TRAIT(user, TRAIT_BLOODLOSS_IMMUNE, "devil_trigger")
	addtimer(CALLBACK(src, PROC_REF(imminent_death), user), (crashout_duration / 2))
	addtimer(CALLBACK(src, PROC_REF(end_crashout), user), crashout_duration)
	casting = FALSE
	return TRUE

/obj/effect/proc_holder/spell/self/devil_trigger/proc/imminent_death(mob/living/user)
	user.emote("paincrit")
	to_chat(user, span_userdanger("YES! YES--YE---YEES?!-NO--NO!!-OH--HEART--MY HEART...! I NEED-- I CAN STILL STOP-- I--! NEED... BLOOD! I DON'T WANT TO DIE!"))
	user.visible_message(span_danger("[user] begins foaming from their mouth like a rabid creature!"))
	user.remove_movespeed_modifier("devil_trigger")
	user.add_movespeed_modifier("devil_trigger_waning", update=TRUE, priority=100, multiplicative_slowdown=-0.4, blacklisted_movetypes=(FLYING|FLOATING))

/obj/effect/proc_holder/spell/self/devil_trigger/proc/end_crashout(mob/living/user)
	if(!user)
		return
	user.remove_movespeed_modifier("devil_trigger_waning")
	REMOVE_TRAIT(user, TRAIT_UNSTOPPABLE, "devil_trigger")
	REMOVE_TRAIT(user, TRAIT_CRITICAL_RESISTANCE, "devil_trigger")
	REMOVE_TRAIT(user, TRAIT_GRABIMMUNE, "devil_trigger")
	REMOVE_TRAIT(user, TRAIT_BLOODLOSS_IMMUNE, "devil_trigger")
	addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/living/carbon, vomit), 0, TRUE), 1 SECONDS)
	if(user.has_status_effect(/datum/status_effect/debuff/vthirstt3))
		user.emote("agony")
		to_chat(user, span_userdanger("OOHHHH MY HEART!! IT CAN'T! I CAN'T! I'M--"))
		user.visible_message(span_danger("[user] suddenly clutches their chest and collapses, their body convulsing as bloody foam spills from their mouth!"))
		user.death()
	else
		user.emote("agony")
		to_chat(user, span_userdanger("OOHHHH MY HEART!! IT CAN'T! I CAN'T! I'M--"))
		user.visible_message(span_danger("[user] suddenly clutches their chest and collapses, their body convulsing as bloody foam spills from their mouth!"))
		for(var/datum/wound/W as anything in user.get_wounds())
			if(W?.bleed_rate > 0)
				W.bleed_rate = 0
		if(user.blood_volume < BLOOD_VOLUME_SURVIVE)
			user.blood_volume = BLOOD_VOLUME_SURVIVE + 2
		user.Unconscious(600)


/obj/effect/proc_holder/spell/self/devil_trigger/invocation(mob/user)
	if(!length(invocation))
		return
	user.say(pick(invocation), forced = "spell")

/mob/living/carbon/proc/devil_trigger_resist()
	if(handcuffed)
		cuff_resist(handcuffed, 0, TRUE)
	if(legcuffed)
		cuff_resist(legcuffed, 0, TRUE)
	if(pulledby)
		resist_grab()
	if(buckled)
		resist_buckle()
	if(isobj(loc))
		var/obj/C = loc
		C.container_resist(src)
	resting = FALSE
	wallpressed = FALSE

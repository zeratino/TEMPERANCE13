/obj/effect/mine
	name = "dummy mine"
	desc = ""
	density = FALSE
	anchored = TRUE
	icon = 'icons/roguetown/misc/traps.dmi'
	icon_state = "uglymine"
	var/triggered = 0

/obj/effect/mine/proc/mineEffect(mob/victim)
	to_chat(victim, span_danger("*click*"))

/obj/effect/mine/Crossed(AM as mob|obj)
	if(isturf(loc))
		if(ismob(AM))
			var/mob/MM = AM
			if(!(MM.movement_type & FLYING))
				triggermine(AM)
		else
			triggermine(AM)

/obj/effect/mine/proc/triggermine(mob/victim)
	if(triggered)
		return
	visible_message(span_danger("[victim] sets off the [src]!"))
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	mineEffect(victim)
	triggered = 1
	qdel(src)


/obj/effect/mine/explosive
	name = "landmine"
	desc = "Don't step on me. I'm armed."
	icon = 'icons/roguetown/misc/traps.dmi'
	icon_state = "mine"

/obj/effect/mine/explosive/Initialize()
	var/mutable_appearance/mine_light = mutable_appearance(icon, "mine_glow")
	mine_light.plane = 19
	mine_light.layer = 19
	add_overlay(mine_light)
	.=..()

/obj/effect/mine/explosive/mineEffect(mob/victim)
	explosion(src, devastation_range = 1, heavy_impact_range = 1, light_impact_range = 1, flash_range = 0, smoke = FALSE, soundin = pick('sound/misc/explode/arty1.ogg','sound/misc/explode/arty2.ogg','sound/misc/explode/arty3.ogg','sound/misc/explode/arty4.ogg','sound/misc/explode/arty5.ogg','sound/misc/explode/arty6.ogg'))
	play_positional_sound(
		get_turf(src),
		list('sound/misc/explode/explosionclose (1).ogg','sound/misc/explode/explosionclose (2).ogg','sound/misc/explode/explosionclose (3).ogg'),
		list('sound/misc/explode/explosionfar (1).ogg','sound/misc/explode/explosionfar (2).ogg','sound/misc/explode/explosionfar (3).ogg'),
		range = 90,
		close_range = 30
		)

/obj/effect/mine/stun
	name = "stun mine"
	var/stun_time = 80

/obj/effect/mine/stun/mineEffect(mob/living/victim)
	if(isliving(victim))
		victim.Paralyze(stun_time)

/obj/effect/mine/kickmine
	name = "kick mine"

/obj/effect/mine/kickmine/mineEffect(mob/victim)
	if(isliving(victim) && victim.client)
		to_chat(victim, span_danger("I have been kicked FOR NO REISIN!"))
		qdel(victim.client)


/obj/effect/mine/gas
	name = "oxygen mine"
	var/gas_amount = 360
	var/gas_type = "o2"

/obj/effect/mine/gas/plasma
	name = "plasma mine"
	gas_type = "plasma"


/obj/effect/mine/gas/n2o
	name = "\improper N2O mine"
	gas_type = "n2o"


/obj/effect/mine/sound
	name = "honkblaster 1000"
	var/sound = 'sound/blank.ogg'

/obj/effect/mine/sound/mineEffect(mob/victim)
	playsound(loc, sound, 100, TRUE)


/obj/effect/mine/sound/bwoink
	name = "bwoink mine"
	sound = 'sound/blank.ogg'

/obj/effect/mine/pickup
	name = "pickup"
	desc = ""
	icon = 'icons/effects/effects.dmi'
	icon_state = "electricity2"
	density = FALSE
	var/duration = 0

/obj/effect/mine/pickup/Initialize()
	. = ..()
	animate(src, pixel_y = 4, time = 20, loop = -1)

/obj/effect/mine/pickup/triggermine(mob/victim)
	if(triggered)
		return
	triggered = 1
	invisibility = INVISIBILITY_ABSTRACT
	mineEffect(victim)
	qdel(src)

/obj/effect/mine/pickup/healing
	name = "Blue Orb"
	desc = ""
	color = "#0000FF"

/obj/effect/mine/pickup/healing/mineEffect(mob/living/carbon/victim)
	if(!victim.client || !istype(victim))
		return
	to_chat(victim, span_notice("I feel great!"))
	victim.revive(full_heal = TRUE, admin_revive = TRUE)

/obj/effect/mine/pickup/speed
	name = "Yellow Orb"
	desc = ""
	color = "#FFFF00"
	duration = 300

/obj/effect/mine/pickup/speed/mineEffect(mob/living/carbon/victim)
	if(!victim.client || !istype(victim))
		return
	to_chat(victim, span_notice("I feel fast!"))
	victim.add_movespeed_modifier(MOVESPEED_ID_YELLOW_ORB, update=TRUE, priority=100, multiplicative_slowdown=-2, blacklisted_movetypes=(FLYING|FLOATING))
	sleep(duration)
	victim.remove_movespeed_modifier(MOVESPEED_ID_YELLOW_ORB)
	to_chat(victim, span_notice("I slow down."))

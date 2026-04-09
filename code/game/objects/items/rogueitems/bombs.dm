
/obj/item/bomb
	name = "bottle bomb"
	desc = "A fiery explosion waiting to be coaxed from its glass prison."
	icon_state = "bbomb"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	//dropshrink = 0
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	var/fuze = null //randomized on init
	var/lit = FALSE
	var/prob2fail = 5
	grid_width = 32
	grid_height = 64

/obj/item/bomb/Initialize()
	. = ..()
	fuze = rand(40,60)

/obj/item/bomb/spark_act()
	light()

/obj/item/bomb/fire_act()
	light()

/obj/item/bomb/ex_act()
	if(!QDELETED(src))
		lit = TRUE
		explode(TRUE)

/obj/item/bomb/proc/light()
	if(!lit)
		START_PROCESSING(SSfastprocess, src)
		icon_state = "bbomb-lit"
		lit = TRUE
		playsound(src.loc, 'sound/items/firelight.ogg', 100)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/bomb/extinguish()
	snuff()

/obj/item/bomb/proc/snuff()
	if(lit)
		lit = FALSE
		STOP_PROCESSING(SSfastprocess, src)
		playsound(src.loc, 'sound/items/firesnuff.ogg', 100)
		icon_state = "bbomb"
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/bomb/proc/explode(skipprob)
	STOP_PROCESSING(SSfastprocess, src)
	var/turf/T = get_turf(src)
	if(T)
		if(lit)
			if(!skipprob && prob(prob2fail))
				snuff()
			else
				explosion(T, light_impact_range = 1, flame_range = 2, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
		else
			if(prob(prob2fail))
				snuff()
			else
				playsound(T, 'sound/items/firesnuff.ogg', 100)
				new /obj/item/natural/glass_shard (T)
	qdel(src)

/obj/item/bomb/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	explode()

/obj/item/bomb/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)

/obj/item/smokebomb
	name = "smoke bomb"
	desc = "A soft sphere with an alchemical mixture and a dispersion mechanism hidden inside. Any pressure will detonate it."
	icon_state = "smokebomb"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	//dropshrink = 0
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	grid_width = 32
	grid_height = 64

/obj/item/smokebomb/attack_self(mob/user)
    ..()
    explode()

/obj/item/smokebomb/ex_act()
	if(!QDELETED(src))
		..()
	explode()

/obj/item/smokebomb/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	explode()

/obj/item/smokebomb/proc/explode()
    STOP_PROCESSING(SSfastprocess, src)
    var/turf/T = get_turf(src)
    if (!T) return
    playsound(src.loc, 'sound/items/smokebomb.ogg', 50)
    var/radius = 3
    var/datum/effect_system/smoke_spread/bad/S = new /datum/effect_system/smoke_spread/bad
    S.set_up(radius, T)
    S.start()
    new /obj/item/ash(T)
    qdel(src)

/obj/item/grenade
	name = "'Molon Labe' HE grenade"
	desc = "Five seconds. Throw at a wall."
	icon_state = "pineapple-nade"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	//dropshrink = 0
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	grid_width = 32
	grid_height = 64
	w_class = WEIGHT_CLASS_NORMAL
	var/fuze = 50
	var/armed = FALSE
	grid_width = 32
	grid_height = 64

/obj/item/grenade/attack_self(mob/user)
    ..()
    arm()

/obj/item/grenade/ex_act()
	if(!QDELETED(src))
		armed = TRUE
		explode(TRUE)

/obj/item/grenade/proc/arm()
	if(!armed)
		START_PROCESSING(SSfastprocess, src)
		icon_state = "pineapple-nade_active"
		armed = TRUE
		playsound(src.loc, list('sound/misc/pin1.ogg','sound/misc/pin2.ogg'), 100)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/grenade/proc/explode()
	STOP_PROCESSING(SSfastprocess, src)
	var/turf/T = get_turf(src)
	if(T)
		if(armed)
			explosion(T, devastation_range = 2, heavy_impact_range = 3, light_impact_range = 4, smoke = FALSE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
	qdel(src)

/obj/item/grenade/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)

/obj/item/smokegrenade
	name = "Mk.7 'Laconic' smoke grenade"
	desc = "Two seconds. Vision-obscuring smoke."
	icon_state = "stick-nade"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	//dropshrink = 0
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	grid_width = 32
	grid_height = 64
	var/fuze = 20
	var/armed = FALSE

/obj/item/smokegrenade/attack_self(mob/user)
    ..()
    arm()

/obj/item/smokegrenade/ex_act()
	if(!QDELETED(src))
		armed = TRUE
		explode(TRUE)

/obj/item/smokegrenade/proc/arm()
	if(!armed)
		START_PROCESSING(SSfastprocess, src)
		icon_state = "stick-nade_active"
		armed = TRUE
		playsound(src.loc, list('sound/misc/pin1.ogg','sound/misc/pin2.ogg'), 100)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/smokegrenade/proc/explode()
    STOP_PROCESSING(SSfastprocess, src)
    var/turf/T = get_turf(src)
    if (!T) return
    playsound(src.loc, 'sound/items/smokebomb.ogg', 50)
    var/radius = 3
    var/datum/effect_system/smoke_spread/bad/S = new /datum/effect_system/smoke_spread/bad
    S.set_up(radius, T)
    S.start()
    new /obj/item/ash(T)
    qdel(src)

/obj/item/smokegrenade/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)

/obj/item/gasgrenade
	name = "Mk.7 'Laconic' gas grenade"
	desc = "Five seconds. Lung-destroying smoke. Marked with a green stripe."
	icon_state = "gas-nade"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	//dropshrink = 0
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	grid_width = 32
	grid_height = 64
	var/fuze = 20
	var/armed = FALSE

/obj/item/gasgrenade/attack_self(mob/user)
    ..()
    arm()

/obj/item/gasgrenade/ex_act()
	if(!QDELETED(src))
		armed = TRUE
		explode(TRUE)

/obj/item/gasgrenade/proc/arm()
	if(!armed)
		START_PROCESSING(SSfastprocess, src)
		icon_state = "gas-nade_active"
		armed = TRUE
		playsound(src.loc, list('sound/misc/pin1.ogg','sound/misc/pin2.ogg'), 100)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/gasgrenade/proc/explode()
    STOP_PROCESSING(SSfastprocess, src)
    var/turf/T = get_turf(src)
    if (!T) return
    playsound(src.loc, 'sound/items/smokebomb.ogg', 50)
    var/radius = 3
    var/datum/effect_system/smoke_spread/poison_gas/S = new /datum/effect_system/smoke_spread/poison_gas
    S.set_up(radius, T)
    S.start()
    qdel(src)

/obj/item/gasgrenade/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)

/obj/item/grenade
	// Pretty sure this is a test item of some kind. We shouldn't ever make reference to this. Ever.
	name = "Grenade"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	//dropshrink = 0
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	var/fuze = 40
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
		icon_state = "[initial(icon_state)]_active"
		armed = TRUE
		playsound(src.loc, list('sound/misc/pin1.ogg','sound/misc/pin2.ogg'), 100)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/grenade/proc/explode()
//handled per type

/obj/item/grenade/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)

//gas

/obj/item/grenade/gas
	name = "gasgrenade"
	icon = 'icons/roguetown/items/misc.dmi'
	var/gas_type = /datum/effect_system/smoke_spread //for instance, /datum/effect_system/smoke_spread/bad


//gas grenade explosion
/obj/item/grenade/gas/explode() 
	STOP_PROCESSING(SSfastprocess, src)
	var/turf/T = get_turf(src)
	if(!T)
		return
	playsound(src.loc, 'sound/items/smokebomb.ogg', 50)
	puff()
	new /obj/item/ash(T)
	qdel(src)

/obj/item/grenade/gas/proc/puff()
//this sucks but its better than what was there before 
/obj/item/grenade/gas/smoke/puff()
	var/turf/T = get_turf(src)
	var/radius = 3 
	var/datum/effect_system/smoke_spread/bad/S = new /datum/effect_system/smoke_spread/bad
	S.set_up(radius, T)
	S.start()

/obj/item/grenade/gas/poison/puff()
	var/turf/T = get_turf(src)
	var/radius = 3 
	var/datum/effect_system/smoke_spread/poison_gas/S = new /datum/effect_system/smoke_spread/poison_gas
	S.set_up(radius, T)
	S.start()

//actual gas grenades
/obj/item/grenade/gas/smoke
	name = "Mk.7 'Laconic' smoke grenade"
	desc = "Two seconds. Vision-obscuring smoke."
	icon_state = "stick-nade"
	fuze = 20
	gas_type = /datum/effect_system/smoke_spread/bad

/obj/item/grenade/gas/poison
	name = "Mk.7 'Laconic' gas grenade"
	desc = "Five seconds. Lung-destroying smoke. Marked with a green stripe."
	icon_state = "gas-nade"
	fuze = 50
	gas_type = /datum/effect_system/smoke_spread/poison_gas


//frag grenade

/obj/item/grenade/frag
	name = "'Molon Labe' fragmentation grenade"
	desc = "Four seconds. A lumpy shaped shrapnel shitter. Take care not to hit yourself."
	icon_state = "pineapple-nade"
	fuze = 25
	var/fradius = 6

//frag explode
/obj/item/grenade/frag/explode()
	visible_message(span_danger("[src] explodes!"))
	var/obj/effect/shrapnel/uwu
	uwu = new /obj/effect/shrapnel()
	var/target = get_turf(src)
	uwu.projectile_type = /obj/projectile/bullet/shrapnel
	uwu.radius = fradius
	uwu.do_shrapnel(src, target)
	explosion(src, devastation_range = 0, heavy_impact_range = 1, light_impact_range = 1, flash_range = 0, smoke = FALSE, soundin = pick('sound/misc/explode/arty1.ogg','sound/misc/explode/arty2.ogg','sound/misc/explode/arty3.ogg','sound/misc/explode/arty4.ogg','sound/misc/explode/arty5.ogg','sound/misc/explode/arty6.ogg'))
	play_positional_sound(
		get_turf(src),
		list('sound/misc/explode/explosionclose (1).ogg','sound/misc/explode/explosionclose (2).ogg','sound/misc/explode/explosionclose (3).ogg'),
		list('sound/misc/explode/explosionfar (1).ogg','sound/misc/explode/explosionfar (2).ogg','sound/misc/explode/explosionfar (3).ogg'),
		range = 60,
		close_range = 30
		)
	qdel(src)

/*
	var/obj/effect/shrapnel/uwu //it's my code and i get to name the variables what i want
	uwu = new /obj/effect/shrapnel()
	var target = get_turf(src)
	uwu.projectile_type = /obj/projectile/bullet/shrapnel/frogmine
	uwu.radius = 5
	uwu.override_projectile_range = 10	
	uwu.do_shrapnel(src, target)
*/

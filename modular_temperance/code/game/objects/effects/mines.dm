
//Snowflake-ass code because I can't figure out how to make this work with normal mine code
//Idk man I'm new to this 'actually coding my own ideas' shit

//TODO: 
//Fix planting recipe (must be plantable in grass and dirt)
//Fix placeholder in-hand
//Decide on size

/obj/effect/frogmine
	name = "frogmine"
	desc = "Once you step on it, be VERY careful stepping off."
	icon = 'icons/roguetown/misc/traps.dmi'
	icon_state = "frogmine"
	var/triggered = 0
	var/primed = 0
	var/mine_pressure = 0
	var/mine_delay = 5

/obj/effect/frogmine/Crossed(AM as obj|mob)
	if(isturf(loc))
		if(ismob(AM))
			var/mob/MM = AM
			if(!(MM.movement_type & FLYING))
				mine_pressure += 16
				check_primefrogmine(AM)
		if(isitem(AM))
			var/obj/item/HH = AM
			if (HH.w_class > WEIGHT_CLASS_TINY)
				var/WC = HH.w_class
				WC = WC*4
				mine_pressure += WC
				check_primefrogmine(AM)

/obj/effect/frogmine/Uncrossed(AM as obj|mob)
	if(isturf(loc))
		if(ismob(AM))
			var/mob/MM = AM
			if(!(MM.movement_type & FLYING)) //Now in truth you could probably exploit this to find a way to leave it primed without setting it off by flying away; but also we don't have flight here. Future me problems
				mine_pressure -= 16
				check_primefrogmine(AM)
		if(isitem(AM))
			var/obj/item/HH = AM
			if (HH.w_class > WEIGHT_CLASS_TINY)
				var/WC = HH.w_class
				WC = WC*4
				mine_pressure -= WC
				check_primefrogmine(AM)

/obj/effect/frogmine/proc/check_primefrogmine(AM)
	if (!primed || !triggered)
		if(mine_pressure < 0)
			mine_pressure = 0
		if(mine_pressure >= 12)
			primefrogmine(AM)
	if (primed && !triggered)
		if(mine_pressure < 12)
			explodefrogmine()

/obj/effect/frogmine/proc/primefrogmine(mob/victim)
	if(primed || triggered)
		return
	visible_message(span_danger("*click*"))
	playsound(get_turf(src), 'modular_temperance/sounds/misc/frogmine_click.ogg', 60, FALSE)
	primed = 1

/obj/effect/frogmine/proc/explodefrogmine()
	triggered = 1
	visible_message(span_danger("[src] leaps into the air..."))
	icon_state = "frogmine_leap"
	update_icon() //removed animate(src) here, if it breaks the animation add it back
	playsound(get_turf(src), 'modular_temperance/sounds/misc/frogmine_leap.ogg', 60, FALSE)
	sleep(mine_delay)
	visible_message(span_danger("[src] explodes!"))
	var/obj/effect/shrapnel/uwu //it's my code and i get to name the variables what i want
	uwu = new /obj/effect/shrapnel()
	var target = get_turf(src)
	uwu.projectile_type = /obj/projectile/bullet/shrapnel/frogmine
	uwu.radius = 5
	uwu.override_projectile_range = 10	
	uwu.do_shrapnel(src, target)
	explosion(src, devastation_range = 0, heavy_impact_range = 1, light_impact_range = 1, flash_range = 0, smoke = TRUE, soundin = pick('sound/misc/explode/arty1.ogg','sound/misc/explode/arty2.ogg','sound/misc/explode/arty3.ogg','sound/misc/explode/arty4.ogg','sound/misc/explode/arty5.ogg','sound/misc/explode/arty6.ogg'))
	play_positional_sound(
		get_turf(src),
		list('sound/misc/explode/explosionclose (1).ogg','sound/misc/explode/explosionclose (2).ogg','sound/misc/explode/explosionclose (3).ogg'),
		list('sound/misc/explode/explosionfar (1).ogg','sound/misc/explode/explosionfar (2).ogg','sound/misc/explode/explosionfar (3).ogg'),
		range = 60,
		close_range = 30
		)
	qdel(src)

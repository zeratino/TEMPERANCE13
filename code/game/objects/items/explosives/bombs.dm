//sound define
#define BIGBOOM list('sound/misc/explode/arty1.ogg','sound/misc/explode/arty2.ogg','sound/misc/explode/arty3.ogg','sound/misc/explode/arty4.ogg','sound/misc/explode/arty5.ogg','sound/misc/explode/arty6.ogg')
#define WETBOOM list('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg')

//for lit bombs such as satchels and dynamite
/obj/item/bomb //not intended for use
	name = "Bombo"
	desc = "It's the bombo! lol lol ahelpbtw"
	icon_state = "bbomb"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	//dropshrink = 0
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	var/fuze = null //rand on init
	var/lit = FALSE
	var/prob2fail = 3 //3% chance to dud because its funny
	var/impact = FALSE //explode on impact?
	var/shatter = FALSE //shatter on impact?
	var/devastation_r = null
	var/heavy_r = null
	var/light_r = null
	var/flame_r = null
	var/smoker = FALSE 
	var/snuffable = FALSE //can be snuffed inhand after lighting?
	var/explosion_sound = null
	var/datum/looping_sound/fuseloop/soundloop
	var/fused = TRUE //play fuseloop on light?
	grid_width = 32
	grid_height = 64

/obj/item/bomb/Initialize()
	soundloop = new(src, FALSE)
	. = ..()

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
		icon_state = "[initial(icon_state)]-lit"
		lit = TRUE
		if(fused)
			soundloop.start()
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
		icon_state = "[initial(icon_state)]"
		soundloop.stop()
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
				explosion(T, devastation_r, heavy_r, light_r, flame_range = flame_r, smoke = smoker, soundin = pick(explosion_sound))
				qdel(src)
		else if(shatter)
			if(prob(prob2fail))
				snuff() 
			else
				playsound(T, 'sound/items/firesnuff.ogg', 100)
				new /obj/item/natural/glass_shard (T)
				qdel(src)

/obj/item/bomb/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	if(impact)
		explode()

/obj/item/bomb/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)

/obj/item/bomb/attack_self(mob/user)
	if(snuffable)
		snuff()

///////////////////////
/////actual bombs//////
///////////////////////

/obj/item/bomb/molotov
	name = "Kalarian Cocktail"
	desc = "An ingenious Kalarian design; simply light and throw."
	light_r = 2
	flame_r = 2
	impact = TRUE
	fuze = 60
	explosion_sound = WETBOOM
	fused = FALSE

/obj/item/bomb/dynamite
	name = "dynamite"
	desc = "A curious concotion of explosive powders packed into a tight container. Has a wide variety of uses when considering the destructive capability, though it's pretty easy to avoid on it's own."
	icon_state = "tnt_stick"
	devastation_r = 1
	heavy_r = 2
	light_r = 2
	explosion_sound = BIGBOOM

/obj/item/bomb/dynamite/Initialize()
	fuze = rand(60,80)
	. = ..()

/obj/item/bomb/satchel
	name = "satchel charge"
	desc = "A heavy bag of explosives. Stay very far away from this thing. Seriously."
	icon_state = "satchel_bomb"
	w_class = WEIGHT_CLASS_NORMAL
	devastation_r = 4
	heavy_r = 5
	light_r = 5
	throw_range = 3
	snuffable = TRUE
	explosion_sound = BIGBOOM

/obj/item/bomb/satchel/Initialize()
	fuze = rand(80, 160)
	. = ..()

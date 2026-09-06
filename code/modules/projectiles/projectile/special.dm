/obj/projectile/bullet/flamer
	name = "flamer napalm"
	icon_state = "flame"
	damage = 40
	armor_penetration = 30
	hitscan = FALSE
	ignore_source_check = TRUE
	woundclass = BCLASS_BURN
	spread = 15
	damage_type = BURN

/obj/projectile/bullet/flamer/on_hit(target)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(!istype(H.wear_armor, /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/flamer))
			H.adjust_fire_stacks(5)
			H.IgniteMob()
			H.emote("agony", forced = TRUE)
		new /obj/flamer_fire(get_turf(src))

/obj/flamer_fire
	name = "fire"
	desc = "AHHHHHHH!!!"
	anchored = 1
	mouse_opacity = 0
	icon = 'icons/effects/fire.dmi'
	icon_state = "red_2"
	var/firelevel = 12 //Tracks how much "fire" there is. Basically the timer of how long the fire burns
	var/burnlevel = 10 //Tracks how HOT the fire is. This is basically the heat level of the fire and determines the temperature.
	var/flame_color = "red"

/obj/flamer_fire/New(loc, fire_lvl, burn_lvl, f_color, fire_spread_amount)
	..()
	var/turf/T = loc
	if(!istype(T)) //Is it a valid turf? Has to be on a floor
		qdel(src)
		return

	updateicon()

	if(!firelevel)
		qdel(src)
		return
	if(istype(loc, /turf/open/water))//No catching the water on fire.
		qdel(src)
	playsound(src, pick(FLAMECOMBUST), 50)
	if (f_color)
		flame_color = f_color

	icon_state = "[flame_color]_2"
	if(fire_lvl) firelevel = fire_lvl
	if(burn_lvl) burnlevel = burn_lvl
	START_PROCESSING(SSobj,src)

	if(fire_spread_amount > 0)
		var/turf/Turf
		for(var/dirn in GLOB.cardinals)
			Turf = get_step(loc, dirn)
			if(istype(Turf,/turf/open/water)) continue//Do not light the water on fire please.
			if(locate(/obj/flamer_fire) in Turf) continue //No stacking
			var/new_spread_amt = Turf.density ? 0 : fire_spread_amount - 1 //walls stop the spread
			if(new_spread_amt)
				for(var/obj/O in Turf)
					if(!O.CanPass(src, loc))
						new_spread_amt = 0
						break
			spawn(0) //delay so the newer flame don't block the spread of older flames
				new /obj/flamer_fire(Turf, fire_lvl, burn_lvl, f_color, new_spread_amt)


/obj/flamer_fire/Destroy()
	//for(var/obj/o in particles)
	//	qdel(o)
	set_light(0)
	STOP_PROCESSING(SSobj,src)
	. = ..()


/obj/flamer_fire/Crossed(mob/living/M) //Only way to get it to reliable do it when you walk into it.
	if(istype(M))
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(istype(H.wear_armor, /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/flamer))
				return
		M.adjust_fire_stacks(burnlevel) //Make it possible to light them on fire later.
		if (prob(firelevel + 2*M.fire_stacks)) //the more soaked in fire you are, the likelier to be ignited
			M.IgniteMob()

		M.adjustFireLoss(round(burnlevel*0.5)) //This makes fire stronk.
		M.emote("agony", forced = TRUE)

/obj/flamer_fire/proc/updateicon()
	if(burnlevel < 15)
		color = "#dfdfdf" //make it darker to make show its weaker.
		alpha = 195
	switch(firelevel)
		if(1 to 9)
			icon_state = "[flame_color]_1"
			set_light(l_color = rgb(LERP(250,150,1),LERP(160,150,1),LERP(25,150,1)))
		if(10 to 25)
			icon_state = "[flame_color]_2"
			set_light(l_color = rgb(LERP(250,150,1),LERP(160,150,1),LERP(25,150,1)))
		if(25 to INFINITY) //Change the icons and luminosity based on the fire's intensity
			icon_state = "[flame_color]_3"
			set_light(l_color = rgb(LERP(250,150,1),LERP(160,150,1),LERP(25,150,1)))


/obj/flamer_fire/process()

	firelevel = max(0, firelevel)

	updateicon()

	if(!firelevel)
		qdel(src)
		return
	update_icon()
	var/j = 0
	for(var/i in loc)
		if(++j >= 11) break
		if(isliving(i))
			var/mob/living/I = i
			if(istype(I,/mob/living/carbon/human))
				var/mob/living/carbon/human/M = I
				if(istype(M.wear_armor, /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/flamer))
					continue
			I.adjust_fire_stacks(burnlevel) //If i stand in the fire i deserve all of this. Also Napalm stacks quickly.
			I.IgniteMob()

	//This has been made a simple loop, for the most part flamer_fire_act() just does return, but for specific items it'll cause other effects.
	firelevel -= 2 //reduce the intensity by 2 per tick
	return

//40MM GRENADES
/obj/projectile/bullet/flare
	name = "flare"
	damage = 0
	armor_penetration = 0
	hitscan = FALSE
	spread = 0
	speed = 0.2

/obj/projectile/bullet/flare/on_hit(target)
	..()
	new /obj/item/flashlight/flare/flaregun(get_turf(src))

/obj/item/flashlight/flare/flaregun
	name = "lit flare"
	icon = 'icons/roguetown/items/lighting.dmi'
	icon_state = "fgunlow"
	desc = "A burning flare! Looks bright. Far too hot to touch while it's burning."
	light_outer_range = 14
	on = TRUE
	slot_flags = ITEM_SLOT_HIP
	obj_flags = CAN_BE_HIT
	force = 1
	on_damage = 5
	fuel = 460
	grid_width = 32
	grid_height = 64
	extinguishable = TRUE
	weather_resistant = TRUE
	anchored = TRUE
	sellprice = 2

/obj/item/flashlight/flare/flaregun/Initialize()
	..()
	START_PROCESSING(SSobj, src)


/obj/item/flashlight/flare/flaregun/turn_off()
	..()
	name = "burned out flare"
	desc = "A burned out flare. Sometimes, you feel like you can sympathize with it." //this is not a cry for help btw
	anchored = FALSE

/obj/item/flashlight/flare/flaregun/high
	name = "illumination flare"
	desc = "An illumination flare is in the air overhead."
	light_power = 60
	light_inner_range = null
	light_outer_range = 60
//	light_falloff_curve = 0.2
	icon_state = "fgunhigh"
	extinguishable = FALSE
	on = TRUE
	fuel = 180
	sellprice = 3

/obj/effect/illumination_flare_spawner
	name = "illumination flare spawner"
	desc = "Something broke! Uh oh."

/obj/effect/illumination_flare_spawner/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(ignite_flare)), 30)


/obj/effect/illumination_flare_spawner/proc/ignite_flare()
	new /obj/item/flashlight/flare/flaregun/high(src.loc)
	for(var/mob/living/carbon/human/uwu in range(60, src.loc))
		var/distance = get_dist(src.loc, uwu.loc)
		var/volumetoplay = 100 - distance*2
		if(volumetoplay < 20)
			volumetoplay = 20
		uwu.playsound_local(get_turf(uwu), 'sound/misc/flaregun_high_ignite.ogg', volumetoplay, FALSE)
	loud_message("You hear a flare ignite in the air", hearing_distance = 60) //This really should be based on solely range and having sight, not hearing, but these flares are already driving me mad. Fix it later
	qdel(src)

/obj/projectile/bullet/a40mmhe
	name = "40mm grenade"
	damage = 0
	armor_penetration = 0
	hitscan = FALSE
	spread = 0
	speed = 0.2

/obj/projectile/bullet/a40mmhe/on_hit(target)
	..()
	explosion(src, devastation_range = 0, heavy_impact_range = 2, light_impact_range = 2, flash_range = 1, smoke = FALSE, soundin = pick('sound/misc/explode/arty1.ogg','sound/misc/explode/arty2.ogg','sound/misc/explode/arty3.ogg','sound/misc/explode/arty4.ogg','sound/misc/explode/arty5.ogg','sound/misc/explode/arty6.ogg'))

/obj/projectile/bullet/a40mmsmoke
	name = "40mm grenade"
	damage = 0
	armor_penetration = 0
	hitscan = FALSE
	spread = 0
	speed = 0.2

/obj/projectile/bullet/a40mmsmoke/on_hit(target)
	..()
	var/datum/effect_system/smoke_spread/S = new /datum/effect_system/smoke_spread/bad
	var/turf/T = src.loc
	S.set_up(3, T)
	S.start()
	playsound(src, 'sound/misc/explode/smokeexplosion.ogg', 100, FALSE, 0)

/obj/projectile/bullet/a40mmgas
	name = "40mm grenade"
	damage = 0
	armor_penetration = 0
	hitscan = FALSE
	spread = 0
	speed = 0.2

/obj/projectile/bullet/a40mmgas/on_hit(target)
	..()
	var/datum/effect_system/smoke_spread/poison_gas/bad/S = new /datum/effect_system/smoke_spread/poison_gas/bad
	var/turf/T = src.loc
	S.set_up(3, T)
	S.start()
	playsound(src, 'sound/misc/explode/smokeexplosion.ogg', 100, FALSE, 0)

/obj/projectile/bullet/a40mmfrag
	name = "40mm grenade"
	damage = 0
	armor_penetration = 0
	hitscan = FALSE
	spread = 0
	speed = 0.2

/obj/projectile/bullet/a40mmfrag/on_hit(target)
	..()
	var/obj/effect/shrapnel/uwu //it's my code and i get to name the variables what i want
	uwu = new /obj/effect/shrapnel()
	var turftarget = get_turf(src)
	uwu.projectile_type = /obj/projectile/bullet/shrapnel
	uwu.radius = 5
	uwu.override_projectile_range = 6
	uwu.do_shrapnel(src, turftarget)
	explosion(src, devastation_range = 0, heavy_impact_range = 0, light_impact_range = 2, flash_range = 0, smoke = FALSE, soundin = pick('sound/misc/explode/arty1.ogg','sound/misc/explode/arty2.ogg','sound/misc/explode/arty3.ogg','sound/misc/explode/arty4.ogg','sound/misc/explode/arty5.ogg','sound/misc/explode/arty6.ogg'))

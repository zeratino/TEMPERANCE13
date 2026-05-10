
/obj/structure/machine/spawner
	name = "MACHINE"
	desc = "An orifice of the local WAR machine. If I wait patiently, something might happen."
	icon = 'icons/obj/structures/bigmachine.dmi'
	max_integrity = 999999
	resistance_flags = INDESTRUCTIBLE
	layer = MOB_LAYER + 0.01
	icon_state = "furnace"
	var/delay = FALSE
	var/timer = 0
	var/active = FALSE
	var/datum/looping_sound/machineloop/soundloop
	var/list/turfsy = list()
	var/list/blockers = list()

/obj/structure/machine/spawner/delay
	delay = TRUE

/obj/mblock
	name = ""
	desc = ""
	icon = null
	density = TRUE
	mouse_opacity = 0
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/machine/spawner/Initialize()
	soundloop = new(src, FALSE)
	. = ..()
	var/turf/T = src.loc
	turfsy += T
	T = get_step(T, EAST)
	turfsy += T
	T = get_step(T, NORTH)
	turfsy += T
	T = get_step(T, WEST)
	turfsy += T
	for(var/turf/blocker_tile in turfsy)
		var/G = new /obj/mblock(blocker_tile) 
		blockers += G
	START_PROCESSING(SSprocessing, src)

/obj/structure/machine/spawner/proc/reset()
	timer = 0
	START_PROCESSING(SSprocessing, src)

/obj/structure/machine/spawner/proc/checkdelay()
	if(delay)
		sleep(1 HOURS)
		delay = FALSE

/obj/structure/machine/spawner/proc/spawnitem()
	STOP_PROCESSING(SSprocessing, src)
	playsound(src, 'sound/misc/loops/machinedone.ogg', 100)
	var/obj/new_type 
	if(prob(90))
		new_type = pick(
			/obj/effect/spawner/lootdrop/machine/rifleammo,
			/obj/effect/spawner/lootdrop/machine/ammo,
			/obj/effect/spawner/lootdrop/machine/leverrifle,
			/obj/effect/spawner/lootdrop/machine/pistol,
			/obj/effect/spawner/lootdrop/machine/explosives)
	else 
		new_type = pick(
			/obj/effect/spawner/lootdrop/machine/reaper,
			/obj/effect/spawner/lootdrop/machine/eternal,
			/obj/effect/spawner/lootdrop/machine/patience)
	new new_type(get_step(src, SOUTH))
	reset()

/obj/structure/machine/spawner/proc/update_effect()
	if(active)
		icon_state = "[initial(icon_state)]_on"
		soundloop.start()
	if(!active)
		icon_state = "[initial(icon_state)]"
		soundloop.stop()

/obj/structure/machine/spawner/process()
	checkdelay()
	timer++
	if(timer == 780)//13 minutes
		active = TRUE
		update_effect()
	if(timer >= 900) //15 minutes
		active = FALSE
		update_effect()
		spawnitem()

/obj/effect/spawner/lootdrop/machine
	name = "machine spawner"
	fan_out_items = TRUE

/obj/effect/spawner/lootdrop/machine/Initialize(mapload)
	if(loot)
		for(var/path in loot)
			var/number = loot[path]
			if(!isnum(number)) 
				number = 1
			for(var/i in 1 to number)
				new path(get_turf(src))
	else
		. = ..()
	return INITIALIZE_HINT_QDEL
/*
/obj/effect/spawner/lootdrop/machine/do_spawn() //so. it kinda just spits out a lot of random bullshit. whatever
	for(var/path in loot)
		var/number = loot[path]
		if(!isnum(number)) 
			number = 1
		for(var/i in 1 to number)
			new path(get_turf(src))s
*/

/obj/effect/spawner/lootdrop/machine/rifleammo 
	loot = list(
		/obj/item/ammo_box/handfuls/rifle = 10
	)
/obj/effect/spawner/lootdrop/machine/ammo
	loot = list(
	/obj/item/ammo_box/handfuls/leveraction = 2,
	/obj/item/ammo_box/clip/pistol = 4,
	/obj/item/ammo_box/handfuls/rifle = 4,
	/obj/item/ammo_box/handfuls/shotgun = 2,
	/obj/item/ammo_box/handfuls/shotgun/buckshot = 2,
	/obj/item/ammo_box/handfuls/rattlesnake = 2
	)
/obj/effect/spawner/lootdrop/machine/leverrifle
	loot = list(
		/obj/item/gun/ballistic/rifle/repeater/leveraction = 2,
		/obj/item/ammo_box/handfuls/leveraction = 4
	)
/obj/effect/spawner/lootdrop/machine/pistol
	loot = list(
		/obj/item/gun/ballistic/rifle/repeater/jackal = 2,
		/obj/item/ammo_box/magazine/jackal = 4
	)
/obj/effect/spawner/lootdrop/machine/explosives
	loot = list(
		/obj/item/bomb/satchel = 1,
		/obj/item/grenade/frag = 3
	)
/obj/effect/spawner/lootdrop/machine/reaper
	loot = list(
		/obj/item/gun/ballistic/rifle/reaper = 1,
		/obj/item/ammo_box/clip/reaper = 4
	)
/obj/effect/spawner/lootdrop/machine/eternal
	loot = list(
		/obj/item/gun/ballistic/shotgun/eternal = 1,
		/obj/item/ammo_box/handfuls/shotgun = 4
	)
/obj/effect/spawner/lootdrop/machine/patience
	loot = list(
		/obj/item/gun/ballistic/rifle/repeater/patience = 1,
		/obj/item/ammo_box/boxes/amr = 2
	)

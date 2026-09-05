GLOBAL_LIST_EMPTY(machine_bellows)


/obj/structure/machine/spawner
	name = "FURNACE"
	desc = "An orifice of the local WAR machine. I'll need friends holding the nearby BELLOWs for it to work."
	icon = 'icons/obj/structures/bigmachine.dmi'
	max_integrity = 999999
	resistance_flags = INDESTRUCTIBLE
	layer = MOB_LAYER + 0.01
	icon_state = "furnace"
	var/timer = 0
	var/active = 0 //0 for off, 1 for on, 2 for malfunctioning
	var/datum/looping_sound/machineloop/soundloop
	var/list/turfsy = list()
	var/list/blockers = list()
	var/list/bellows = list()
	var/bellow_id //used to sync which furnace connects to which bellows, mappers should set this
	var/malfunction_timer_1
	var/malfunction_timer_2
	var/bakelength = 180//how long the furnace takes to finish

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

/obj/structure/machine/spawner/proc/spawnitem()
	var/obj/new_type
	if(prob(90))
		new_type = pick(
			/obj/effect/spawner/lootdrop/machine/rifleammo,
			/obj/effect/spawner/lootdrop/machine/ammo,
			/obj/effect/spawner/lootdrop/machine/leverrifle,
			/obj/effect/spawner/lootdrop/machine/pistol,
			/obj/effect/spawner/lootdrop/machine/explosives,
			/obj/effect/spawner/lootdrop/medicines,
			/obj/effect/spawner/lootdrop/machine/revivers,
			/obj/effect/spawner/lootdrop/machine/levershotgun,
			/obj/effect/spawner/lootdrop/machine/fortification,
			/obj/effect/spawner/lootdrop/machine/mines)
	else 
		new_type = pick(
			/obj/effect/spawner/lootdrop/machine/reaper,
			/obj/effect/spawner/lootdrop/machine/eternal,
			/obj/effect/spawner/lootdrop/machine/patience)
	new new_type(get_step(src, SOUTH))

/obj/structure/machine/spawner/proc/update_effect()
	if(active == 1)
		icon_state = "[initial(icon_state)]_on"
		soundloop.start()
	if(active == 0)
		icon_state = "[initial(icon_state)]"
		soundloop.stop()

/obj/structure/machine/spawner/proc/failed()
	STOP_PROCESSING(SSprocessing, src)
	visible_message("<span class='boldwarning'>The FURNACE shuts down unexpectedly. It looks as though a BELLOW failed.</span>")
	active = 0
	update_effect()
	timer = 0
	for(var/obj/structure/machine/bellow/deadtainer in bellows)
		if(deadtainer.status != 0)
			deadtainer.turnofffailed()


/obj/structure/machine/spawner/process()
	timer++
	if(timer == 10) //early malfunction guaranteed, so people HAVE to have someone already at a bellow (or get there very fast)
		var/obj/structure/machine/bellow/malfbellow = pick(bellows)
		malfbellow.malfunction()
	if(timer == malfunction_timer_1)
		var/obj/structure/machine/bellow/malfbellow = pick(bellows)//technically i could write a whole function here for "if this is already breaking, add it to a list and pick another that isn't and make it start breaking"
		malfbellow.malfunction()//im just not gonna lol
	if(timer == malfunction_timer_2)
		var/obj/structure/machine/bellow/malfbellow = pick(bellows)
		malfbellow.malfunction()
	if(timer >= bakelength) //easily adjustable
		active = FALSE
		update_effect()
		playsound(src, 'sound/misc/loops/machinedone.ogg', 100)
		spawnitem()
		spawnitem()
		visible_message("<span class='notice'>The FURNACE goes quiet, its work done.</span>")
		for(var/obj/structure/machine/bellow/worker in bellows)
			if(worker.status != 0)
				worker.turnoff()
		timer = 0
		STOP_PROCESSING(SSprocessing, src)

/obj/structure/machine/spawner/attack_hand(mob/user)
	if(active)
		return
	if(!active)
		user.visible_message("<span class='warning'>[user] prepares to start the FURNACE...</span>", "<span class='warning'>I prepare to start the FURNACE...</span>")
		if(do_after(user, 7 SECONDS, TRUE, src))
			active = TRUE
			update_effect()
			for(var/obj/structure/machine/bellow/matcher in GLOB.machine_bellows)
				if(matcher.bellow_id == src.bellow_id)
					if(matcher.status == 0)
						matcher.callingfurnace = src
						matcher.turnon()
						bellows.Add(matcher)
			if(!length(bellows))
				message_admins("[user] tried to start a FURNACE with no BELLOWs! Tell a dev. Or a mapper.")
				visible_message("The FURNACE fails to start. Strange. (Tell a dev/mapper, this isn't working right now!)")
				return
			malfunction_timer_1 = rand(20, bakelength-31) //needs to be 31 less than the maximum bake length as otherwise baking could finish before a malfunction event does
			malfunction_timer_2 = rand(20, bakelength-31)
			user.visible_message("<span class='warning'>[user] starts the FURNACE!</span>", "<span class='warning'>I start the FURNACE! Hopefully someone is watching the BELLOWs...</span>")
			START_PROCESSING(SSprocessing, src)

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

/obj/effect/spawner/lootdrop/machine/levershotgun
	loot = list(
		/obj/item/gun/ballistic/shotgun/levershotgun = 1,
	/obj/item/ammo_box/handfuls/shotgun = 2,
	/obj/item/ammo_box/handfuls/shotgun/buckshot = 2,
	)

/obj/effect/spawner/lootdrop/machine/revivers
	loot = list(
		/obj/item/reagent_containers/lux = 2,
	)

/obj/effect/spawner/lootdrop/machine/fortification
	loot = list(
		/obj/item/sandbag = 6,
		/obj/item/barbedwire = 4,
	)

/obj/effect/spawner/lootdrop/machine/mines
	loot = list(
		/obj/item/landmine = 2,
		/obj/item/frogmine = 2,
	)

/obj/structure/machine/bellow
	name = "BELLOW"
	desc = "An maintenance mechanism of the local WAR machine. It connects to the nearby FURNACE."
	icon = 'icons/obj/structures/bigmachine.dmi'
	max_integrity = 999999
	resistance_flags = INDESTRUCTIBLE
	layer = MOB_LAYER + 0.01
	icon_state = "tesla"
	var/bellow_id //used to decide what bellow is attached to what furnace, designed for each bellow to be attached to 1 furnace but idk why you couldn't attach it to several
	var/status = 0 //0 equals nothing on, 1 equals attached furnace on, 2 equals needs attention
	var/datum/looping_sound/streetlamp1/soundloopon
	var/datum/looping_sound/streetlamp3/soundloopbreaking
	var/timer = 0
	var/obj/structure/machine/spawner/callingfurnace
	var/list/turfsy = list()
	var/list/blockers = list()

/obj/structure/machine/bellow/Initialize()
	soundloopon = new(src, FALSE)
	soundloopbreaking = new(src, FALSE)
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
	GLOB.machine_bellows += src

/obj/structure/machine/bellow/proc/turnon()
	visible_message("<span class='notice'>The BELLOW whirrs to life!</span>")
	status = 1
	update_effect()

/obj/structure/machine/bellow/proc/turnoff()
	visible_message("<span class='notice'>The BELLOW goes quiet, its work done successfully.</span>")
	status = 0
	update_effect()
	timer = 0
	STOP_PROCESSING(SSprocessing, src)

/obj/structure/machine/bellow/proc/turnofffailed()
	visible_message("<span class='warning'>The BELLOW goes quiet, as a different BELLOW fails to function.</span>")
	status = 0
	update_effect()
	timer = 0
	STOP_PROCESSING(SSprocessing, src)

/obj/structure/machine/bellow/proc/malfunction()
	if(status == 2)
		return FALSE 
	visible_message("<span class='boldwarning'>The BELLOW begins to beep- it needs attention!</span>")
	status = 2
	update_effect()
	START_PROCESSING(SSprocessing, src)
	return TRUE //could be used in the future to have it make another bellow break if this one is already breaking but im on a deadline here bub

/obj/structure/machine/bellow/process()
	timer++
	if(timer == 15)
		visible_message("<span class='boldwarning'>The BELLOW looks like it's about to break! It needs attention!</span>")
	if(timer >= 30)
		visible_message("<span class='warning'>The BELLOW goes quiet, as it fails to function.</span>")
		timer = 0
		status = 0
		update_effect()
		callingfurnace.failed()
		STOP_PROCESSING(SSprocessing, src)

/obj/structure/machine/bellow/proc/update_effect()
	if(status == 0)
		icon_state = "[initial(icon_state)]"
		soundloopbreaking.stop()
		soundloopon.stop()
	if(status == 1)
		icon_state = "[initial(icon_state)]_on"
		soundloopbreaking.stop()
		soundloopon.start()
	if(status == 2)
		icon_state = "[initial(icon_state)]_error"
		soundloopon.stop()
		soundloopbreaking.start()

/obj/structure/machine/bellow/attack_hand(mob/user)
	if(status == 2)
		user.visible_message("<span class='notice'>[user] starts to fix the BELLOW...", "<span class='notice'>I grab the lever...</span>")
		if(do_after(user, 1 SECONDS, TRUE, src))
			user.visible_message("<span class='notice'>[user] fixes the BELLOW.", "<span class='notice'>I pull it! It looks fine, now.</span>")
			STOP_PROCESSING(SSprocessing, src)
			timer = 0
			status = 1
			update_effect()
	else
		to_chat(user, "<span class='warning'>I can't do anything with this, it isn't broken.</span>")

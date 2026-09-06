/obj/structure/machine/astrarium/Topic(href, href_list)
	. = ..()

	if(.)
		return

	if(!usr)
		return

	var/datum/job/user_job = get_user_job(usr)

	if(!user_job || !user_job.department_flag)
		to_chat(usr, span_warning("The MACHINE does not recognize your credentials."))
		return

	switch(href_list["action"])

		if("main")
			open_interface(usr)

		if("sitrep")
			sitrep_interface(usr)

		if("translocation")
			translocation_interface(usr)

		if("missions")
			missions_interface(usr)

		if("mission_kill")
			mission_kill(usr)

		if("mission_raid")
			mission_raid(usr)

		if("mission_retrieve")
			mission_retrieve(usr)

		if("mission_export")
			mission_export(usr)

		if("send_export")
			var/datum/astrarium_quest/export/E = locate(href_list["quest"])
			if(!E || !(E in active_quests))
				missions_interface(usr)
				return
			send_export(usr, E)
			return

		if("mission_status")
			var/datum/astrarium_quest/Q = locate(href_list["quest"])
			if(!Q || !(Q in active_quests))
				missions_interface(usr)
				return
			mission_status_interface(usr, Q)
			return

		if("compile_mission")
			var/datum/astrarium_quest/Q = locate(href_list["quest"])
			compile_mission(usr, Q)
			return

		if("cancel_mission")
			var/datum/astrarium_quest/Q = locate(href_list["quest"])
			cancel_mission(usr, Q)
			return

		if("begin_translocation")
			var/x_coord = input(usr, "ENTER DESTINATION X COORDINATE", "ASTRARIUM") as num|null
			if(isnull(x_coord))
				open_interface(usr)
				return
			var/y_coord = input(usr, "ENTER DESTINATION Y COORDINATE", "ASTRARIUM") as num|null
			if(isnull(y_coord))
				open_interface(usr)
				return
			var/z_coord = input(usr, "ENTER DESTINATION Z COORDINATE", "ASTRARIUM") as num|null
			if(isnull(z_coord))
				open_interface(usr)
				return
			var/turf/target = locate(x_coord, y_coord, z_coord)
			if(!target)
				say("CANNOT LOCATE THE SPECIFIED COORDINATES.")
				open_interface(usr)
				return
			translocate(usr, target, user_job.department_flag)

/obj/structure/machine/astrarium/proc/missions_interface(mob/user)
	var/html = {"
		<html>
		<head>
			<style>
				body {
					background:#101010;
					color:#c8c8c8;
					font-family:Courier;
					font-size:13px;
					margin:15px;
				}

				h1 {
					color:#d0b36b;
					font-size:20px;
					border-bottom:1px solid #555;
					padding-bottom:8px;
					margin-bottom:10px;
				}

				h2 {
					color:#b9a16b;
					font-size:14px;
					margin-top:20px;
				}

				.description {
					color:#777;
					font-size:11px;
					line-height:1.4;
				}

				.status {
					color:#c8c8c8;
					padding:8px;
					border:1px solid #292929;
					background:#181818;
					margin-bottom:8px;
				}

				.active {
					color:#c4ad68;
					font-weight:bold;
				}

				.complete {
					color:#83bd72;
					font-weight:bold;
				}

				.failed {
					color:#bd6666;
					font-weight:bold;
				}

				.button {
					background:#3a3324;
					color:#d8c68f;
					border:1px solid #74633b;
					padding:10px;
					margin-top:8px;
					text-decoration:none;
					display:block;
					text-align:center;
				}

				.button:hover {
					background:#4b422e;
				}
			</style>
		</head>

		<body>
			<h1>CHRONOLOGICAL CORRECTION TASK MODULE</h1>
	"}

	if(active_quests && active_quests.len)
		html += {"
			<div class=description>
				The MACHINE is currently maintaining multiple chronological
				correction protocols. Additional tasks may be initialized
				independently of existing protocols.
			</div>

			<h2>ACTIVE TASKS</h2>
		"}

		for(var/datum/astrarium_quest/Q in active_quests)
			if(!Q)
				continue

			html += {"
				<div class=status>
					<b>[Q.name]</b>
					<br><br>
					[Q.get_description()]
					<br><br>
					STATUS:
					<span class=[Q.get_status_class()]>
						[Q.get_status()]
					</span>
					<br><br>
					[Q.get_location_info()]
				</div>

				<a class=button href=byond://?src=\ref[src];action=mission_status;quest=\ref[Q]>
					CROSS-REFERENCE MISSION
				</a>
			"}
	else
		html += {"
			<div class=description>
				No chronological correction protocols are currently active.
				The MACHINE is awaiting task parameters.
			</div>
		"}

	html += {"
			<h2>AVAILABLE TASKS</h2>

			<a class=button href=byond://?src=\ref[src];action=mission_kill>
				INITIATE PURGE MISSION
			</a>

			<a class=button href=byond://?src=\ref[src];action=mission_raid>
				INITIATE RAID MISSION
			</a>

			<a class=button href=byond://?src=\ref[src];action=mission_retrieve>
				INITIATE RETRIEVAL MISSION
			</a>

			<a class=button href=byond://?src=\ref[src];action=mission_export>
				INITIATE EXPORT MISSION
			</a>

			<br>

			<a class=button href=byond://?src=\ref[src];action=main>
				RETURN TO PRIMARY SYSTEMS
			</a>

		</body>
		</html>
	"}

	user << browse(html, "window=astrarium;size=500x600")

/obj/structure/machine/astrarium/proc/mission_status_interface(mob/user, datum/astrarium_quest/quest)
	if(!quest || !(quest in active_quests))
		missions_interface(user)
		return

	var/html = {"
		<html>
		<head>
			<style>
				body {
					background:#101010;
					color:#c8c8c8;
					font-family:Courier;
					font-size:13px;
					margin:15px;
				}

				h1 {
					color:#d0b36b;
					font-size:20px;
					border-bottom:1px solid #555;
					padding-bottom:8px;
					margin-bottom:10px;
				}

				h2 {
					color:#b9a16b;
					font-size:14px;
					margin-top:20px;
				}

				.description {
					color:#777;
					font-size:11px;
					line-height:1.4;
				}

				.status {
					padding:10px;
					border:1px solid #292929;
					background:#181818;
					line-height:1.5;
				}

				.active {
					color:#c4ad68;
					font-weight:bold;
				}

				.complete {
					color:#83bd72;
					font-weight:bold;
				}

				.failed {
					color:#bd6666;
					font-weight:bold;
				}

				.button {
					background:#3a3324;
					color:#d8c68f;
					border:1px solid #74633b;
					padding:10px;
					margin-top:8px;
					text-decoration:none;
					display:block;
					text-align:center;
				}

				.button:hover {
					background:#4b422e;
				}

				.compile {
					background:#3a4a32;
					color:#a9d18e;
					border:1px solid #60794f;
				}

				.compile:hover {
					background:#465b3c;
				}

				.cancel {
					background:#4a302f;
					color:#d99a96;
					border:1px solid #794d49;
				}

				.cancel:hover {
					background:#5a3836;
				}
			</style>
		</head>

		<body>
			<h1>MISSION CROSS-REFERENCE</h1>

			<div class=description>
				The MACHINE is cross-referencing the selected chronological
				correction protocol against the local timeline.
			</div>

			<h2>MISSION PARAMETERS</h2>

			<div class=status>
				<b>[quest.name]</b>
				<br><br>

				[quest.description]

				<br><br>

				STATUS:
				<span class=[quest.get_status_class()]>
					[quest.get_status()]
				</span>

				<br><br>

				[quest.get_location_info()]
			</div>
	"}

	if(quest.completed)
		html += {"
			<h2>TIMELINE RESULTS</h2>

			<div class=description>
				The mission parameters have been satisfied.
				The chronological correction has been successfully verified.
				The resulting timeline data may now be compiled.
			</div>

			<a class='button compile' href=byond://?src=\ref[src];action=compile_mission;quest=\ref[quest]>
				COMPILE TIMELINE RESULTS
			</a>
		"}

	else if(istype(quest, /datum/astrarium_quest/export))
		var/datum/astrarium_quest/export/E = quest

		E.check_export()

		html += {"
			<h2>EXPORT PARAMETERS</h2>

			<div class=description>
				REQUESTED MATERIAL:
				<b>[E.get_export_name()]</b>
				<br><br>

				REQUIRED:
				<b>[E.required_amount]</b>
				<br>

				CURRENT:
				<b>[E.current_amount]</b>
				<br><br>

				Place the requested materials inside a crate and bring
				the crate within [E.export_range] tiles of the ASTRARIUM.
			</div>
		"}

		if(E.export_completed)
			html += {"
				<a class='button compile' href=byond://?src=\ref[src];action=send_export;quest=\ref[quest]>
					SEND EXPORT
				</a>
			"}

		html += {"
			<a class='button cancel' href=byond://?src=\ref[src];action=cancel_mission;quest=\ref[quest]>
				EMERGENCY PARADOX CANCEL
			</a>
		"}

	else
		html += {"
			<h2>MISSION CONTROL</h2>

			<div class=description>
				This mission is still active.
				An emergency paradox cancellation will terminate the mission,
				remove all associated mission entities, and discard its timeline data.
			</div>

			<a class='button cancel' href=byond://?src=\ref[src];action=cancel_mission;quest=\ref[quest]>
				EMERGENCY PARADOX CANCEL
			</a>
		"}

	html += {"
			<br>

			<a class=button href=byond://?src=\ref[src];action=missions>
				RETURN TO TASK MODULE
			</a>

		</body>
		</html>
	"}

	user << browse(html, "window=astrarium;size=500x600")

/obj/structure/machine/astrarium/proc/mission_kill(mob/user)
	if(!kill_quest_pool || !kill_quest_pool.len)
		to_chat(user, span_warning("ASTRARIUM: No purge protocols are currently available."))
		missions_interface(user)
		return
	var/quest_type = pick(kill_quest_pool)
	var/datum/astrarium_quest/kill/Q = new quest_type(src)
	if(!start_quest(Q))
		to_chat(user, span_warning("ASTRARIUM: Unable to initialize the purge mission."))
		missions_interface(user)
		return
	to_chat(user, span_notice("ASTRARIUM: [Q.name] INITIALIZED."))
	missions_interface(user)

/obj/structure/machine/astrarium/proc/mission_raid(mob/user)
	if(!raid_quest_pool || !raid_quest_pool.len)
		to_chat(user, span_warning("ASTRARIUM: No raid protocols are currently available."))
		missions_interface(user)
		return
	var/quest_type = pick(raid_quest_pool)
	var/datum/astrarium_quest/raid/Q = new quest_type(src)
	if(!start_quest(Q))
		to_chat(user, span_warning("ASTRARIUM: Unable to initialize the raid mission."))
		missions_interface(user)
		return
	to_chat(user, span_notice("ASTRARIUM: [Q.name] INITIALIZED."))
	missions_interface(user)

/obj/structure/machine/astrarium/proc/mission_retrieve(mob/user)
	say("RETRIEVAL PROTOCOL SELECTED.")
	say("Mission parameters are currently unavailable.")
	missions_interface(user)

/obj/structure/machine/astrarium/proc/mission_export(mob/user)
	var/datum/astrarium_quest/export/Q = new(src)

	if(!start_quest(Q))
		to_chat(user, span_warning("ASTRARIUM: Unable to initialize the export mission."))
		missions_interface(user)
		return

	to_chat(user, span_notice("ASTRARIUM: [Q.get_export_name()] EXPORT PROTOCOL INITIALIZED."))
	to_chat(user, span_notice("ASTRARIUM: REQUIRED QUANTITY: [Q.required_amount]."))
	missions_interface(user)

/obj/structure/machine/astrarium/proc/start_quest(datum/astrarium_quest/quest)
	if(!quest)
		return FALSE
	if(!active_quests)
		active_quests = list()
	active_quests += quest
	if(!quest.start())
		active_quests -= quest
		qdel(quest)
		return FALSE
	return TRUE

/obj/structure/machine/astrarium/proc/quest_completed(datum/astrarium_quest/quest)
	if(!quest || !(quest in active_quests))
		return
	say("MISSION PARAMETERS SATISFIED. CHRONOLOGICAL CORRECTION ACHIEVED.")
	playsound(src, 'sound/ding.ogg', 100)

/obj/structure/machine/astrarium/proc/quest_failed(datum/astrarium_quest/quest)
	if(!quest || !(quest in active_quests))
		return
	say("MISSION PARAMETERS INVALIDATED.")

/obj/structure/machine/astrarium/proc/compile_mission(mob/user, datum/astrarium_quest/quest)
	if(!quest || !(quest in active_quests))
		to_chat(user, span_warning("That mission no longer exists."))
		missions_interface(user)
		return
	if(!quest.completed)
		to_chat(user, span_warning("The mission has not been completed."))
		mission_status_interface(user, quest)
		return
	say("Compiling chronological correction data.")
	var/turf/reward_turf = get_turf(user)
	active_quests -= quest
	qdel(quest)
	if(reward_turf)
		new /obj/item/reagent_containers/food/snacks/rogue/handpie/berry(reward_turf)
	playsound(src, 'sound/ding.ogg', 100)
	to_chat(user, span_notice("ASTRARIUM: TIMELINE RESULTS COMPILED SUCCESSFULLY."))
	to_chat(user, span_notice("ASTRARIUM: CHRONOLOGICAL CORRECTION REWARD DISPENSED."))
	missions_interface(user)

/obj/structure/machine/astrarium/proc/cancel_mission(mob/user, datum/astrarium_quest/quest)
	if(!quest || !(quest in active_quests))
		to_chat(user, span_warning("That mission no longer exists."))
		missions_interface(user)
		return
	if(quest.completed)
		to_chat(user, span_warning("Completed missions cannot be paradox-cancelled."))
		mission_status_interface(user, quest)
		return
	say("EMERGENCY PARADOX CANCEL INITIATED.")
	say("PURGING MISSION PARAMETERS AND ASSOCIATED ANOMALIES.")
	active_quests -= quest
	qdel(quest)
	playsound(src, 'sound/ding.ogg', 100)
	to_chat(user, span_warning("ASTRARIUM: MISSION CANCELLED. TIMELINE DATA PURGED."))
	missions_interface(user)

/obj/structure/machine/astrarium/Destroy()
	if(active_quests)
		for(var/datum/astrarium_quest/Q in active_quests)
			if(Q)
				qdel(Q)
		active_quests.Cut()
	return ..()

/datum/astrarium_quest
	var/obj/structure/machine/astrarium/astrarium
	var/name = "Unknown Mission"
	var/description = "No mission description available."
	var/completed = FALSE
	var/failed = FALSE
	var/obj/item/temporal_compass/compass
	var/compass_inserted = FALSE

/datum/astrarium_quest/proc/get_description()
	return description
	
/datum/astrarium_quest/New(obj/structure/machine/astrarium/A)
	astrarium = A
	return ..()

/datum/astrarium_quest/Destroy()
	if(compass)
		qdel(compass)
		compass = null
	astrarium = null
	return ..()

/datum/astrarium_quest/proc/start()
	return TRUE

/datum/astrarium_quest/proc/check_completion()
	return FALSE

/datum/astrarium_quest/proc/complete()
	if(completed || failed)
		return FALSE
	completed = TRUE
	if(astrarium)
		astrarium.quest_completed(src)
	return TRUE

/datum/astrarium_quest/proc/fail()
	if(completed || failed)
		return FALSE
	failed = TRUE
	if(astrarium)
		astrarium.quest_failed(src)
	return TRUE

/datum/astrarium_quest/proc/get_status()
	if(completed)
		return "COMPLETED"
	if(failed)
		return "FAILED"
	return "ACTIVE"

/datum/astrarium_quest/proc/get_status_class()
	if(completed)
		return "complete"
	if(failed)
		return "failed"
	return "active"

/datum/astrarium_quest/proc/get_location_info()
	return "LOCATION DATA: UNAVAILABLE"

/datum/astrarium_quest/proc/get_target()
	return null

/datum/astrarium_quest/kill
	name = "PURGE TARGET"
	description = "Locate and eliminate the designated hostile entity."
	var/mob/living/target
	var/target_type
	var/turf/target_location
	var/spawn_range = 10
	var/activation_range = 12
	var/target_spawned = FALSE

/datum/astrarium_quest/kill/New(obj/structure/machine/astrarium/A, target_type_path)
	..(A)
	target_type = target_type_path

/datum/astrarium_quest/kill/proc/select_target_location()
	if(!astrarium)
		return FALSE
	var/turf/origin = get_turf(astrarium)
	if(!origin)
		return FALSE
	var/list/valid_turfs = list()
	for(var/turf/T in range(spawn_range, origin))
		if(T.density)
			continue
		var/blocked = FALSE
		for(var/mob/living/M in T)
			if(M.stat != DEAD)
				blocked = TRUE
				break
		if(blocked)
			continue
		valid_turfs += T
	if(!valid_turfs.len)
		return FALSE
	target_location = pick(valid_turfs)
	return TRUE

/datum/astrarium_quest/kill/start()
	if(!select_target_location())
		return FALSE
	compass = new /obj/item/temporal_compass(get_turf(astrarium))
	if(!compass)
		target_location = null
		return FALSE
	compass.quest = src
	return TRUE

/datum/astrarium_quest/kill/proc/get_target_location()
	return target_location

/datum/astrarium_quest/kill/proc/spawn_target()
	if(target_spawned || target || !target_type || !target_location)
		return FALSE
	target = new target_type(target_location)
	if(!target)
		return FALSE
	target_spawned = TRUE
	RegisterSignal(target, COMSIG_LIVING_DEATH, PROC_REF(on_target_death))
	if(astrarium)
		astrarium.say("TARGET ANOMALY MATERIALIZED. PURGE PROTOCOL NOW ACTIVE.")
	return TRUE

/datum/astrarium_quest/kill/proc/check_target_activation()
	if(target_spawned || !compass || !compass.owner || !target_location)
		return
	var/turf/owner_turf = get_turf(compass.owner)
	if(!owner_turf)
		return
	if(get_dist(owner_turf, target_location) > activation_range)
		return
	spawn_target()

/datum/astrarium_quest/kill/get_location_info()
	if(!target_location)
		return "TARGET LOCATION: UNKNOWN"
	return "TARGET LOCATION: [target_location.x], [target_location.y], [target_location.z]"

/datum/astrarium_quest/kill/proc/on_target_death(mob/living/dead_target, gibbed)
	SIGNAL_HANDLER
	if(dead_target != target)
		return
	UnregisterSignal(target, COMSIG_LIVING_DEATH)
	if(!compass || !compass.owner)
		fail()
		return
	var/turf/target_turf = get_turf(target)
	var/turf/owner_turf = get_turf(compass.owner)
	if(!target_turf || !owner_turf)
		fail()
		spawn_paradox_guards(compass.owner)
		return
	if(get_dist(target_turf, owner_turf) <= 12)
		complete()
		return
	fail()
	spawn_paradox_guards(compass.owner)

/datum/astrarium_quest/kill/Destroy()
	if(target)
		UnregisterSignal(target, COMSIG_LIVING_DEATH)
		qdel(target)
		target = null
	target_location = null
	target_spawned = FALSE
	return ..()

/datum/astrarium_quest/kill/proc/spawn_paradox_guards(mob/living/holder)
	if(!holder)
		return
	var/turf/origin = get_turf(holder)
	if(!origin)
		return
	var/list/valid_turfs = list()
	for(var/turf/T in range(8, origin))
		if(T.density)
			continue
		var/blocked = FALSE
		for(var/mob/living/M in T)
			if(M.stat != DEAD)
				blocked = TRUE
				break
		if(blocked)
			continue
		valid_turfs += T
	for(var/i in 1 to 5)
		if(!valid_turfs.len)
			break
		var/turf/spawn_turf = pick(valid_turfs)
		valid_turfs -= spawn_turf
		new /mob/living/simple_animal/hostile/rogue/robot/gunner(spawn_turf)

/datum/astrarium_quest/raid
	parent_type = /datum/astrarium_quest/kill
	var/list/targets = list()
	var/min_targets = 6
	var/max_targets = 12

/datum/astrarium_quest/raid/spawn_target()
	if(target_spawned || !target_type || !target_location)
		return FALSE
	targets = list()
	var/amount = rand(min_targets, max_targets)
	for(var/i in 1 to amount)
		var/mob/living/M = new target_type(target_location)
		if(!M)
			continue
		targets += M
		RegisterSignal(M, COMSIG_LIVING_DEATH, PROC_REF(on_raid_target_death))
	if(!targets.len)
		return FALSE
	target_spawned = TRUE
	if(astrarium)
		astrarium.say("[targets.len] TARGET ANOMALIES MATERIALIZED. RAID PROTOCOL NOW ACTIVE.")
	return TRUE

/datum/astrarium_quest/raid/proc/on_raid_target_death(mob/living/dead_target, gibbed)
	SIGNAL_HANDLER
	if(!targets || !(dead_target in targets))
		return
	UnregisterSignal(dead_target, COMSIG_LIVING_DEATH)
	targets -= dead_target
	if(targets.len)
		return
	if(!compass || !compass.owner)
		fail()
		return
	var/turf/owner_turf = get_turf(compass.owner)
	var/turf/target_turf = target_location
	if(!owner_turf || !target_turf)
		fail()
		return
	if(get_dist(owner_turf, target_turf) <= activation_range)
		complete()
		return
	fail()
	spawn_paradox_guards(compass.owner)

/datum/astrarium_quest/raid/Destroy()
	if(targets)
		for(var/mob/living/M in targets)
			if(M)
				UnregisterSignal(M, COMSIG_LIVING_DEATH)
				qdel(M)
		targets.Cut()
	return ..()

/datum/astrarium_quest/export
	name = "MATERIAL EXPORT"
	var/export_type
	var/required_amount
	var/current_amount = 0
	var/export_range = 5
	var/export_completed = FALSE
	var/obj/structure/closet/crate/export_crate

/datum/astrarium_quest/export/get_description()
	return "A shipment of [required_amount] units of [get_export_name()] is requested by the main base. Bring a crate with it for remote transportation."

/datum/astrarium_quest/export/New(obj/structure/machine/astrarium/A)
	..(A)
	var/list/export_pool = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/steak,
		/obj/item/natural/stone,
		/obj/item/natural/fibers,
		/obj/item/natural/cloth,
		/obj/item/grown/log/tree/small,
		/obj/item/ingot,
		/obj/item/ammo_casing,
		/obj/item/ammo_box
	)
	var/randomize = rand(1, 100)
	export_type = pick(export_pool)
	if(export_type == /obj/item/ingot)
		randomize /= 2
	if(export_type == /obj/item/reagent_containers/food/snacks/rogue/meat/steak)
		randomize /= 4
	required_amount = round(randomize)

/datum/astrarium_quest/export/proc/is_export_item(obj/item/I)
	if(!I)
		return FALSE
	if(export_type == /obj/item/natural/fibers)
		return istype(I, /obj/item/natural/fibers) || istype(I, /obj/item/natural/bundle/fibers)
	if(export_type == /obj/item/natural/cloth)
		return istype(I, /obj/item/natural/cloth) || istype(I, /obj/item/natural/bundle/cloth)
	return istype(I, export_type)

/datum/astrarium_quest/export/proc/get_export_amount(obj/structure/closet/crate/C)
	if(!C)
		return 0
	var/amount = 0
	for(var/obj/item/I in C.contents)
		if(export_type == /obj/item/natural/fibers)
			if(istype(I, /obj/item/natural/bundle/fibers))
				var/obj/item/natural/bundle/B = I
				amount += B.amount
			else if(istype(I, /obj/item/natural/fibers))
				amount++
		else if(export_type == /obj/item/natural/cloth)
			if(istype(I, /obj/item/natural/bundle/cloth))
				var/obj/item/natural/bundle/B = I
				amount += B.amount
			else if(istype(I, /obj/item/natural/cloth))
				amount++
		else if(istype(I, export_type))
			amount++
	return amount

/datum/astrarium_quest/export/proc/check_export()
	export_completed = FALSE
	export_crate = null
	current_amount = 0
	if(!astrarium)
		return FALSE
	var/turf/origin = get_turf(astrarium)
	if(!origin)
		return FALSE
	for(var/obj/structure/closet/crate/C in range(export_range, origin))
		var/amount = get_export_amount(C)
		if(amount < required_amount)
			continue
		current_amount = amount
		export_crate = C
		export_completed = TRUE
		return TRUE
	return FALSE

/datum/astrarium_quest/export/proc/get_export_name()
	if(export_type == /obj/item/natural/stone)
		return "STONE"
	if(export_type == /obj/item/natural/fibers)
		return "FIBERS"
	if(export_type == /obj/item/natural/cloth)
		return "CLOTH"
	if(export_type == /obj/item/grown/log/tree/small)
		return "WOOD"
	if(export_type == /obj/item/ingot)
		return "REFINED INGOTS"
	if(export_type == /obj/item/ammo_casing)
		return "AMMUNITION CASINGS"
	if(export_type == /obj/item/ammo_box)
		return "AMMUNITION BOXES"
	return "UNKNOWN MATERIAL"

/obj/structure/machine/astrarium/proc/send_export(mob/user, datum/astrarium_quest/export/E)
	if(!E || !(E in active_quests))
		say("That export mission no longer exists.")
		missions_interface(user)
		return
	if(!E.check_export())
		say("No valid export cargo is within range.")
		mission_status_interface(user, E)
		return
	var/obj/structure/closet/crate/C = E.export_crate
	if(!C)
		mission_status_interface(user, E)
		return
	var/remaining = E.required_amount
	for(var/obj/item/I in C.contents)
		if(remaining <= 0)
			break
		if(!E.is_export_item(I))
			continue
		if(E.export_type == /obj/item/natural/fibers && istype(I, /obj/item/natural/bundle/fibers))
			var/obj/item/natural/bundle/B = I
			if(B.amount <= remaining)
				remaining -= B.amount
				qdel(B)
			else
				B.amount -= remaining
				B.update_bundle()
				remaining = 0
		else if(E.export_type == /obj/item/natural/cloth && istype(I, /obj/item/natural/bundle/cloth))
			var/obj/item/natural/bundle/B = I
			if(B.amount <= remaining)
				remaining -= B.amount
				qdel(B)
			else
				B.amount -= remaining
				B.update_bundle()
				remaining = 0
		else
			remaining--
			qdel(I)
	if(remaining > 0)
		mission_status_interface(user, E)
		return
	var/export_name = E.get_export_name()
	var/required = E.required_amount
	E.complete()
	active_quests -= E
	qdel(E)
	qdel(C)
	say("EXPORT CARGO ACCEPTED. MATERIAL TRANSFER COMPLETE.")
	playsound(src, 'sound/ding.ogg', 100)
	to_chat(user, span_notice("ASTRARIUM: EXPORT ACCEPTED."))
	to_chat(user, span_notice("ASTRARIUM: [required] UNITS OF [export_name] SUCCESSFULLY TRANSFERRED TO THE MAIN BASE."))
	missions_interface(user)

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
					[Q.description]
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
	var/datum/astrarium_quest/kill/wolf/Q = new(src)

	if(!start_quest(Q))
		to_chat(user, span_warning("ASTRARIUM: Unable to initialize the purge mission."))
		missions_interface(user)
		return

	to_chat(user, span_notice("ASTRARIUM: PURGE MISSION INITIALIZED."))
	missions_interface(user)


/obj/structure/machine/astrarium/proc/mission_raid(mob/user)
	say("RAID PROTOCOL SELECTED.")
	say("Mission parameters are currently unavailable.")
	missions_interface(user)


/obj/structure/machine/astrarium/proc/mission_retrieve(mob/user)
	say("RETRIEVAL PROTOCOL SELECTED.")
	say("Mission parameters are currently unavailable.")
	missions_interface(user)


/obj/structure/machine/astrarium/proc/mission_export(mob/user)
	say("EXPORT PROTOCOL SELECTED.")
	say("Mission parameters are currently unavailable.")
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


/datum/astrarium_quest/New(obj/structure/machine/astrarium/A)
	astrarium = A
	return ..()


/datum/astrarium_quest/Destroy()
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


/datum/astrarium_quest/kill
	name = "PURGE TARGET"
	description = "Locate and eliminate the designated hostile entity."
	var/mob/living/target
	var/target_type
	var/spawn_range = 10


/datum/astrarium_quest/kill/wolf
	name = "WOLF PURGE"
	description = "A hostile wolf anomaly has been detected within the operational perimeter. Eliminate it."


/datum/astrarium_quest/kill/wolf/New(obj/structure/machine/astrarium/A)
	..(A, /mob/living/simple_animal/hostile/retaliate/rogue/wolf)


/datum/astrarium_quest/kill/New(obj/structure/machine/astrarium/A, target_type_path)
	..(A)
	target_type = target_type_path


/datum/astrarium_quest/kill/start()
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

	var/turf/spawn_turf = pick(valid_turfs)

	target = new target_type(spawn_turf)

	if(!target)
		return FALSE

	RegisterSignal(target, COMSIG_LIVING_DEATH, PROC_REF(on_target_death))

	return TRUE


/datum/astrarium_quest/kill/proc/on_target_death(mob/living/dead_target, gibbed)
	SIGNAL_HANDLER

	if(dead_target != target)
		return

	UnregisterSignal(target, COMSIG_LIVING_DEATH)
	complete()


/datum/astrarium_quest/kill/get_location_info()
	if(!target)
		return "TARGET LOCATION: UNKNOWN"

	var/turf/T = get_turf(target)

	if(!T)
		return "TARGET LOCATION: UNKNOWN"

	return "TARGET LOCATION: [T.x], [T.y], [T.z]"


/datum/astrarium_quest/kill/Destroy()
	if(target)
		UnregisterSignal(target, COMSIG_LIVING_DEATH)
		qdel(target)
		target = null
	return ..()

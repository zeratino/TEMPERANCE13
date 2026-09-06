/obj/structure/machine/astrarium
	name = "ASTRARIUM"
	desc = "An anomalous MACHINE prophetized by the Enginseer through a time-space alterating rituos. This is capable of calling mass from distant coordinates and monitoring the condition of allied personnel. Its anomalous properties force it to be constantly calibrated by synchronizing its dilated time with other MACHINES every few uses."
	icon = 'icons/obj/structures/bigmachine.dmi'
	icon_state = "astrarium"
	max_integrity = 999999
	resistance_flags = INDESTRUCTIBLE
	density = TRUE
	layer = MOB_LAYER + 0.01
	var/list/active_quests = list()
	var/active = FALSE

/obj/structure/machine/astrarium/proc/get_department_name(department_flag)
	switch(department_flag)
		if(PERSERDUN)
			return "PERSERDUN"
		if(RISVON)
			return "RISVON"
		if(KINGSROW)
			return "KINGSROW"
		if(HUNTERS)
			return "HUNTERS"
		else
			return "ERROR! REPORT THIS TO TIME-SPACE ENFORCERS!"

/obj/structure/machine/astrarium/attack_hand(mob/user)
	. = ..()
	if(!user)
		return
	open_interface(user)

/obj/structure/machine/astrarium/proc/get_user_job(mob/user)
	if(!user)
		return
	if(!user.mind)
		return
	if(!user.mind.assigned_role)
		return
	return SSjob.GetJob(user.mind.assigned_role)

/obj/structure/machine/astrarium/proc/is_soul_departed(mob/living/person)
	if(!person)
		return FALSE
	if(person.key)
		return FALSE
	if(person.get_ghost(FALSE, TRUE))
		return FALSE
	return TRUE

/obj/structure/machine/astrarium/proc/open_interface(mob/user)
	var/datum/job/user_job = get_user_job(user)

	if(!user_job)
		say("You are irrelevant to this timeline matrix.")
		return

	if(!user_job.department_flag)
		say("You are incoherent to this timeline matrix.")
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
					font-size:22px;
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

				.authorized {
					color:#d0b36b;
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

				.warning {
					color:#bd6666;
				}
			</style>
		</head>

		<body>
			<h1>ASTRARIUM</h1>

			<div class=description>
				MACHINE spatial observation and translocation apparatus.
				<br><br>
				Authorized Faction:
				<span class=authorized>[get_department_name(user_job.department_flag)]</span>
			</div>

			<h2>PRIMARY SYSTEMS</h2>

			<a class=button href=byond://?src=\ref[src];action=sitrep>
				CROSS-REFERENCE TIME-SPACE SIGNATURE
			</a>

			<a class=button href=byond://?src=\ref[src];action=translocation>
				INITIATE REALITY-MARBLE TRANSLOCATION PROTOCOL
			</a>

			<a class=button href=byond://?src=\ref[src];action=missions>
				CHRONOLOGICAL CORRECTION TASK MODULE
			</a>

			<br>

			<div class=description>
				All translocation operations are restricted to personnel belonging
				to the authorized faction.
			</div>
		</body>
		</html>
	"}

	user << browse(html, "window=astrarium;size=500x500")


/obj/structure/machine/astrarium/proc/sitrep_interface(mob/user)
	var/datum/job/user_job = get_user_job(user)

	if(!user_job || !user_job.department_flag)
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
				}

				table {
					width:100%;
					border-collapse:collapse;
				}

				th {
					background:#222;
					color:#999;
					text-align:left;
					padding:6px;
				}

				td {
					padding:6px;
					border-bottom:1px solid #292929;
				}

				.alive {
					color:#83bd72;
					font-weight:bold;
				}

				.unconscious {
					color:#c4ad68;
					font-weight:bold;
				}

				.dead {
					color:#bd6666;
					font-weight:bold;
				}

				.unknown {
					color:#777;
				}

				.button {
					background:#3a3324;
					color:#d8c68f;
					border:1px solid #74633b;
					padding:8px 16px;
					text-decoration:none;
					display:inline-block;
				}
			</style>
		</head>

		<body>
			<h1>TIME-SPACE SIGNATURE CROSS-REFERENCE</h1>

			<div>
				Authorized Faction:
				<span class=alive>[get_department_name(user_job.department_flag)]</span>
			</div>

			<br>

			[generate_sitrep(user_job)]

			<br>

			<a class=button href=byond://?src=\ref[src];action=main>
				RETURN TO PRIMARY SYSTEMS
			</a>
		</body>
		</html>
	"}

	user << browse(html, "window=astrarium;size=500x600")

/obj/structure/machine/astrarium/proc/generate_sitrep(datum/job/user_job)
	var/list/personnel = list()

	for(var/mob/living/person in GLOB.mob_list)
		var/datum/job/person_job = get_user_job(person)

		if(!person_job)
			continue

		if(!person_job.department_flag)
			continue

		if(person_job.department_flag != user_job.department_flag)
			continue

		personnel += person

	if(!length(personnel))
		return "<span class=unknown>NO ALLIED PERSONNEL DETECTED</span>"

	var/html = {"
		<table>
			<tr>
				<th>NAME</th>
				<th>POSITION</th>
				<th>STATUS</th>
			</tr>
	"}

	for(var/mob/living/person in personnel)
		var/datum/job/person_job = get_user_job(person)

		if(!person_job)
			continue

		var/status
		var/status_class

		if(person.stat == DEAD)
			if(is_soul_departed(person))
				status = "K.I.A.<br>(TIMELINE OVER)"
				status_class = "dead"
			else
				status = "DEAD<br>(TIMELINE INCOMPLETE)"
				status_class = "dead"
		else if(person.stat == UNCONSCIOUS)
			status = "UNCONSCIOUS"
			status_class = "unconscious"
		else if(person.stat == SOFT_CRIT)
			status = "CRITICAL"
			status_class = "unconscious"
		else
			status = "ALIVE"
			status_class = "alive"

		html += {"
			<tr>
				<td>[person.real_name]</td>
				<td>[person_job.title]</td>
				<td class=[status_class]>[status]</td>
			</tr>
		"}

	html += "</table>"

	return html

/obj/structure/machine/astrarium/proc/translocation_interface(mob/user)
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
				}

				.button {
					background:#3a3324;
					color:#d8c68f;
					border:1px solid #74633b;
					padding:8px 16px;
					text-decoration:none;
					display:inline-block;
				}
			</style>
		</head>

		<body>
			<h1>REALITY-MARBLE TRANSLOCATION</h1>

			<p>
				The MACHINE awaits a spatial destination.
			</p>

			<p>
				Three-dimensional coordinates must be supplied.
			</p>

			<br>

			<a class=button href=byond://?src=\ref[src];action=begin_translocation>
				BEGIN COORDINATE INPUT
			</a>

			<br><br>

			<a class=button href=byond://?src=\ref[src];action=main>
				CANCEL
			</a>
		</body>
		</html>
	"}

	user << browse(html, "window=astrarium;size=400x350")

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

		if("mission_status")
			mission_status_interface(usr)

		if("mission_kill")
			mission_kill(usr)

		if("mission_raid")
			mission_raid(usr)

		if("mission_retrieve")
			mission_retrieve(usr)

		if("mission_export")
			mission_export(usr)

		if("compile_mission")
			compile_mission(usr)

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

/obj/structure/machine/astrarium/proc/translocate(mob/user, turf/target, department_flag)
	if(active)
		to_chat(user, span_warning("The ASTRARIUM is already synchronizing its temporal field."))
		return

	active = TRUE

	say("Synchronizing with the specified coordinates. User's chrono-anchor state in time is being used. Please stand still.")

	if(!do_after(user, 10 SECONDS, user))
		active = FALSE
		say("Critical error in the chrono-anchor state data! The temporal synchronization is interrupted.")
		return

	if(!target)
		active = FALSE
		say("Cannot establish the specified coordinates.")
		return

	target.visible_message(span_warning("A strange space-time anomaly rips open, closing as fast as it appears!"))
	found_ping_global(get_turf(target), "anom")

	var/turf/destination = locate(src.x + 2, src.y, src.z)

	if(!destination)
		active = FALSE
		say("Critical error! Cannot establish a receiving point.")
		return

	var/list/personnel = list()

	for(var/mob/living/person in GLOB.mob_list)
		if(get_turf(person) != target)
			continue
		personnel += person

	for(var/mob/living/person in personnel)
		astrarium_strip_inventory(person)
		person.forceMove(destination)

		if(person.stat != DEAD)
			person.visible_message(span_artery("[person] spasms as countless versions of their body overlap, flesh splitting and bones cracking as the conflicting timelines violently collapse into one!"))
			person.emote("agony")
			spawn(1)
				person.gib_limbs(TRUE, TRUE, FALSE)

	playsound(src, 'sound/misc/loops/machinedone.ogg', 100)

	active = FALSE

	open_interface(user)


/obj/structure/machine/astrarium/proc/astrarium_strip_inventory(mob/living/corpse)
	var/list/items = list()

	items |= corpse.get_equipped_items(TRUE)

	for(var/obj/item/I in items)
		if(istype(I, /obj/item/clothing/cloak))
			continue

		if(istype(I, /obj/item/roguekey))
			continue

		if(istype(I, /obj/item/scomstone))
			continue

		corpse.dropItemToGround(I, TRUE)

	for(var/obj/item/I in corpse.held_items)
		if(!I)
			continue

		if(istype(I, /obj/item/clothing/cloak))
			continue

		if(istype(I, /obj/item/roguekey))
			continue

		if(istype(I, /obj/item/scomstone))
			continue

		corpse.dropItemToGround(I, TRUE)

/obj/effect/proc_holder/spell/invoked/conjure_astrarium
	name = "Conjure ASTRARIUM"
	desc = "Manifest an ASTRARIUM through unknown and unexplainable means."
	releasedrain = 0
	chargetime = 1 SECONDS
	recharge_time = 0
	range = 4

/obj/effect/proc_holder/spell/invoked/conjure_astrarium/proc/delete_self()
	qdel(src)

/obj/effect/proc_holder/spell/invoked/conjure_astrarium/cast(list/targets, mob/living/user)
	if(!user)
		return FALSE
	var/turf/T = get_turf(user)
	if(!T)
		return FALSE
	var/obj/structure/machine/astrarium/A = new(T)
	if(!A)
		return FALSE
	addtimer(CALLBACK(src, PROC_REF(delete_self)), 2)
	return TRUE

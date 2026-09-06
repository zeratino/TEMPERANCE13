/obj/effect/proc_holder/spell/invoked/projectile/acidsplash
	name = "Underbarrel Acid Sprayer"
	desc = "Spray globs of acid that sprays over an area upon impact."
	range = 8
	projectile_type = /obj/projectile/magic/acidsplash
	overlay_state = "acid_splash"
	sound = list('sound/combat/Ranged/flame1.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 1
	recharge_time = 5 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE //can you use it if you are antimagicked?
	spell_tier = 5
	invocation = "HAHAHAHAHA!!"
	invocation_type = "shout"
	glow_color = null
	glow_intensity = null
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/blank
	associated_skill = /datum/skill/combat/revolvers
	cost = 3
	req_items = list(/obj/item/gun/ballistic/revolver/purifier)
	xp_gain = TRUE
	miracle = FALSE

/obj/effect/proc_holder/spell/self/acidsplash/cast(mob/user = usr)
	var/mob/living/target = user
	target.visible_message(span_warning("[target] hurls a caustic bubble!"), span_notice("You hurl a caustic bubble!"))
	. = ..()

/obj/projectile/magic/acidsplash //port. todo: the sounds these came with aren't good and drink_blood sounds like ur slurpin pintle
	name = "acid spray"
	icon_state = "neurotoxin"
	damage = 20
	damage_type = BURN
	flag = "magic"
	range = 15
	speed = 1 //higher is slower
	var/aoe_range = 1

/obj/projectile/magic/acidsplash/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/turf/T = get_turf(src)
	playsound(src, 'sound/misc/drink_blood.ogg', 100)

	for(var/mob/living/L in range(aoe_range, get_turf(src))) //apply damage over time to mobs
		if(!L.anti_magic_check())
			var/mob/living/carbon/M = L
			M.apply_status_effect(/datum/status_effect/buff/acidsplash)
			new /obj/effect/temp_visual/acidsplash(get_turf(M))
	for(var/turf/turfs_in_range in range(aoe_range+1, T)) //make a splash
		new /obj/effect/temp_visual/acidsplash(T)

/datum/status_effect/buff/acidsplash
	id = "acid splash"
	alert_type = /atom/movable/screen/alert/status_effect/buff/acidsplash
	duration = 20 SECONDS

/datum/status_effect/buff/acidsplash/on_apply()
	. = ..()
	owner.playsound_local(get_turf(owner), 'sound/misc/lava_death.ogg', 35, FALSE, pressure_affected = FALSE)
	owner.visible_message(span_warning("[owner] is covered in acid!"), span_danger("I am covered in acid!"))
	owner.emote("scream")

/datum/status_effect/buff/acidsplash/tick()
	var/mob/living/target = owner
	target.adjustFireLoss(5)

/atom/movable/screen/alert/status_effect/buff/acidsplash
	name = "Acid Burn"
	desc = "My skin is burning!"
	icon_state = "debuff"

/obj/effect/temp_visual/acidsplash
	icon = 'icons/effects/effects.dmi'
	icon_state = "acid"
	name = "horrible acrid brine"
	desc = "Best not touch this."
	randomdir = TRUE
	duration = 1 SECONDS
	layer = ABOVE_ALL_MOB_LAYER

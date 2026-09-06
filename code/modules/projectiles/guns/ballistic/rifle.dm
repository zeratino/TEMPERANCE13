/obj/item/gun/ballistic/rifle

	name = "rifle template"
	desc = "Should not exist"
	icon = 'icons/roguetown/weapons/32guns.dmi'
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	icon_state = "shotgun"
	item_state = "shotgun"
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	dist_fire_sound = DISTANTMEDIUM
	slowdown = 0.5
	spread = 0
	force = 15
	flags_1 =  CONDUCT_1
	casing_ejector = FALSE
	var/recentpump = 0 // to prevent spammage
	spawnwithmagazine = TRUE
	var/pump_sound = 'sound/blank.ogg'
	fire_sound = RIFLESHOT
	var/pump_stam_cost = 2
	experimental_onhip = FALSE
	experimental_onback = FALSE
	possible_item_intents = list(
		/datum/intent/shoot/rifle,
		INTENT_GENERIC,
		)
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/
	var/needs_pump = FALSE
	can_parry = TRUE
	verbage = "load"
	cartridge_wording = "bullet"
	load_sound = 'sound/foley/nockarrow.ogg'
	obj_flags = UNIQUE_RENAME
	experimental_inhand = FALSE
	internal_magazine = TRUE 
	semi_auto = FALSE
	dry_fire_sound = 'sound/combat/ranged/gun_empty.ogg'
	longarm = TRUE

/obj/item/gun/ballistic/rifle/process_chamber(mob/living/user, empty_chamber = 0)
	return ..() //changed argument value

/obj/item/gun/ballistic/rifle/can_shoot()
	if(needs_pump)
		return FALSE
	return !!chambered?.BB

/obj/item/gun/ballistic/rifle/process_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	if(!semi_auto && from_firing)
		return
	if(semi_auto && chambered)
		chambered.forceMove(drop_location())//Eject casing
		chambered.bounce_away()
		chambered = null
		update_icon()
		if (chamber_next_round && (magazine?.max_ammo > 1))
			chamber_round()
			update_icon()

/obj/item/gun/ballistic/rifle/attack_self(mob/living/user)
	if(recentpump > world.time)
		return
	pump(user, TRUE)
	if(HAS_TRAIT(user, TRAIT_FIREARMS_EXPERT)) //unused as of rn
		recentpump = world.time + 2
	else
		recentpump = world.time + 8
	if(!slamfire)
		user.changeNext_move(CLICK_CD_FAST)

/obj/item/gun/ballistic/rifle/proc/pump(mob/M, visible = TRUE)
	if(visible)
		M.visible_message("<span class='warning'>[M] racks [src].</span>", "<span class='warning'>You rack [src].</span>")
	playsound(M, pump_sound, 60, 1)
	pump_unload(M)
	pump_reload(M)
	update_icon()	//I.E. fix the desc
	return 1

/obj/item/gun/ballistic/rifle/proc/pump_unload(mob/M)
	if(chambered)//We have a shell in the chamber
		chambered.forceMove(drop_location())//Eject casing
		chambered.bounce_away()
		chambered = null

/obj/item/gun/ballistic/rifle/proc/pump_reload(mob/M)
	if(!magazine.ammo_count())
		return 0
	var/obj/item/ammo_casing/AC = magazine.get_round() //load next casing.
	needs_pump = FALSE
	chambered = AC

/obj/item/gun/ballistic/rifle/examine(mob/user)
	. = ..()
	if (chambered)
		. += "A [chambered.BB ? "live" : "spent"] one is in the chamber."

/datum/intent/shoot/rifle
	chargedrain = 0
	no_early_release = FALSE

/datum/intent/shoot/rifle/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = 0
		newtime = ((newtime + 10) - (mastermob.get_skill_level(/datum/skill/combat/rifles) * 2.3 * GUN_AIM_SKILL_INFLUENCE))
		if(strength_check == TRUE)
			newtime = ((newtime + 10) - (mastermob.STASTR / 2))
		newtime = ((newtime + 20) - (mastermob.STAPER * GUN_AIM_PER_INFLUENCE))
		return max(GUN_AIM_FLOOR_RIFLE, newtime) * GUN_AIM_TIME_MULT * GUN_AIM_TIME_MULT_RIFLE
	else
		return chargetime * GUN_AIM_TIME_MULT * GUN_AIM_TIME_MULT_RIFLE

/datum/intent/arc/rifle
	chargetime = 1
	chargedrain = 0
	no_early_release = TRUE

/datum/intent/arc/rifle/can_charge()
	if(mastermob)
		if(mastermob.get_num_arms(FALSE) < 2)
			return FALSE
		if(mastermob.get_inactive_held_item())
			return FALSE
	return TRUE

/datum/intent/arc/rifle/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = 0
		newtime = ((newtime + 10) - (mastermob.get_skill_level(/datum/skill/combat/rifles) * (2)))
		if(strength_check == TRUE)
			newtime = ((newtime + 10) - (mastermob.STASTR / 2))
		else
			newtime = newtime 
		newtime = ((newtime + 20) - (mastermob.STAPER))
		if(newtime > 3)
			return newtime
		else
			return 3
	else
		return chargetime

/obj/item/gun/ballistic/rifle/repeater/postfire_empty_checks(last_shot_succeeded)
    if(last_shot_succeeded && !semi_auto)
        needs_pump = TRUE
    ..()
///////////////////
//BOLT ACTION RIFLES//
///////////////////


/obj/item/gun/ballistic/rifle/repeater
	name = "repeater template"
	desc = "should not exist"
	slowdown = 0.2
	pump_sound = 'sound/combat/ranged/riflecock.ogg'
	bolt_type = BOLT_TYPE_LOCKING
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/back_l.dmi'
	experimental_inhand = FALSE
	empty_indicator = TRUE
	wdefense = 10

/obj/item/gun/ballistic/rifle/repeater/perserdun
	name = "SKT 'Order'"
	desc = "A piece of shit reproduction rifle, trying to replicate those spat out by the WAR MACHINE. Made by Perserdunian forces and chambered in 7.62mmR."
	defense
	icon_state = "karabiner"
	item_state = "karabiner"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/perserdun
	slowdown = 0.15
	spread = 0.5
	pump_sound = 'sound/combat/ranged/riflecock.ogg'
	fire_sound = RIFLESHOT
	load_sound = 'sound/combat/ranged/rifleload.ogg'
	recoil = 0.15
	sellprice = 20

/obj/item/gun/ballistic/rifle/repeater/leveraction
	name = "'Ark' Kaye XLVII"
	desc = "A genuine lever action, produced by a WAR MACHINE's outlet. Chambered in .44."
	icon_state = "leverchester"
	item_state = "leverchester"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/leverchester
	slowdown = 0.15
	spread = 0.5
	slamfire = TRUE
	pump_sound = 'sound/combat/ranged/leveractioncock.ogg'
	fire_sound = LEVERSHOT
	load_sound = 'sound/combat/ranged/leveractioninsert.ogg'
	recoil = 0.15
	sellprice = 42

/obj/item/gun/ballistic/rifle/repeater/leverleg
	name = "'Mare' Baye VII"
	desc = "A genuine lever action, produced by a WAR MACHINE's outlet, cut down. Chambered in .44."
	icon_state = "sawn-leverchester"
	item_state = "sawn-leverchester"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/leverleg
	slowdown = 0.05
	spread = 0.5
	slamfire = TRUE
	pump_sound = 'sound/combat/ranged/leveractioncock.ogg'
	fire_sound = LEVERSHOT
	load_sound = 'sound/combat/ranged/leveractioninsert.ogg'
	recoil = 0.15
	sellprice = 26

/obj/item/gun/ballistic/rifle/repeater/rattlesnake
	name = "BRH 'Rattlesnake'"
	desc = "A one-shot, breech-loaded rifle. Comes with a cloth, tucked in the RIGHT SIDE of the stock. Chambered in .577 Blackout."
	icon = 'icons/roguetown/weapons/64guns.dmi'
	icon_state = "rattlesnake"
	item_state = "rattlesnake"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/rattlesnake
	slowdown = 0.15
	spread = 0.5
	pump_sound = 'sound/combat/ranged/bolt-work.ogg'
	fire_sound = RATTLESHOT
	load_sound = 'sound/combat/ranged/rattleload.ogg'
	recoil = 2
	possible_item_intents = list(
		/datum/intent/shoot/rifle,
		/datum/intent/stab/militia,
		INTENT_GENERIC,
		)
	sellprice = 65

/obj/item/gun/ballistic/rifle/repeater/rattlesnake/rmb_self(mob/user)
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(user, "clothwipe", 100, TRUE)
	SEND_SIGNAL(src, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_STRONG)
	user.visible_message(span_warning("[user] wipes [src] down with its cloth."),span_notice("I wipe [src] down with its cloth."))
	return

/obj/item/gun/ballistic/rifle/repeater/mondragon
	name = "YKA 'Dragoon'"
	desc = "A weak, semi-automatic rifle. High capacity, low powder - comes suppressed. Chambered in LP 7.62mm."
	icon = 'icons/roguetown/weapons/48guns.dmi'
	icon_state = "dragoon"
	item_state = "dragoon"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/mondragon
	slowdown = 0.15
	spread = 0.5
	pump_sound = 'sound/combat/ranged/riflecock.ogg'
	fire_sound = 'sound/combat/ranged/suppressed_fire.ogg'
	load_sound = 'sound/combat/ranged/rifleload.ogg'
	recoil = 0.15
	semi_auto = TRUE
	sellprice = 40

/obj/item/gun/ballistic/rifle/repeater/springfield
	name = "MFG 'Springer'"
	desc = "A straight-bolt action rifle. Posed to replace the Harland, eventually. Chambered in 7.62mmR."
	icon_state = "springfield"
	item_state = "springfield"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/perserdun
	slowdown = 0.15
	spread = 0.5
	pump_sound = 'sound/combat/ranged/riflecock.ogg'
	fire_sound = RIFLESHOT
	load_sound = 'sound/combat/ranged/rifleload.ogg'
	recoil = 0.15
	sellprice = 20

/obj/item/gun/ballistic/rifle/repeater/enfield
	name = "FKZ 'Flicker'"
	desc = "Something similar to the Dragoon - though this one comes unsuppressed. Chambered in LP 7.62mm."
	icon_state = "enfield"
	item_state = "enfield"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/mondragon
	slowdown = 0.15
	spread = 0.5
	pump_sound = 'sound/combat/ranged/riflecock.ogg'
	fire_sound = 'sound/combat/ranged/enfieldfire.ogg'
	load_sound = 'sound/combat/ranged/rifleload.ogg'
	recoil = 0.15
	sellprice = 52

/obj/item/gun/ballistic/rifle/repeater/lebel
	name = "SOG 'Regal'"
	desc = "A Kalarian bolt action rifle, Hold more rounds in the internal magazine, but it's still an utter pain to load. Chambered in 7.62mmR."
	icon = 'icons/roguetown/weapons/64guns.dmi'
	icon_state = "lebeler"
	item_state = "lebeler"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/lebel
	slowdown = 0.15
	spread = 0.5
	pump_sound = 'sound/combat/ranged/riflecock.ogg'
	fire_sound = 'sound/combat/ranged/enfieldfire.ogg'
	load_sound = 'sound/combat/ranged/rifleload.ogg'
	recoil = 0.25
	sellprice = 26

/obj/item/gun/ballistic/rifle/repeater/lewis
	name = "KR 'Leonard'"
	desc = "One of the only light machine guns produced the by WAR machine. Chambered in .30 - There is a tally mark for each man who's held it before you. It's at XII."
	icon = 'icons/roguetown/weapons/64guns.dmi'
	icon_state = "lewisgun"
	item_state = "lewisgun"
	item_flags = SLOWS_WHILE_IN_HAND
	armor = ARMOR_SHIELD
	possible_item_intents = list(SHIELD_SMASH)
	mag_type = /obj/item/ammo_box/magazine/lewis
	slowdown = 2 //I'M THE JUGGAHNAUT BAYBEE
	force = 40 //if someone hits you with a fucking lewis gun, you're gonna have a bad time
	spread = 3
	pump_sound = 'sound/combat/ranged/riflecock.ogg'
	fire_sound = LEWISSHOT
	load_sound = 'sound/combat/ranged/rifleload.ogg'
	recoil = 0.15
	semi_auto = TRUE
	burst = 3
	var/coverage = 50
	armor = ARMOR_SHIELD
	can_parry = TRUE
	wdefense = 11
	max_integrity = 150
	possible_item_intents = list(
		/datum/intent/shoot/rifle,
		/datum/intent/shield/smash,
		INTENT_GENERIC,
		)
	sellprice = 240

/obj/item/gun/ballistic/rifle/repeater/dp47
	name = "RSV 'Redeemer'"
	desc = "A light machine gun, produced by the WAR MACHINE. Fires rifle rounds at a high rate of fire, with a dinner plate on top of it. It's one of a kind. Chambered in 7.62 LP."
	icon = 'icons/roguetown/weapons/64guns.dmi'
	icon_state = "dp47"
	item_state = "dp47"
	mag_type = /obj/item/ammo_box/magazine/dp47
	item_flags = SLOWS_WHILE_IN_HAND
	slowdown = 0.7
	force = 40
	spread = 2
	pump_sound = 'sound/combat/ranged/riflecock.ogg'
	fire_sound = DP47SHOT
	load_sound = 'sound/combat/ranged/rifleload.ogg'
	recoil = 0.15
	semi_auto = TRUE
	burst = 2
	sellprice = 240

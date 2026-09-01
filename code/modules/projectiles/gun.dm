
#define DUALWIELD_PENALTY_EXTRA_MULTIPLIER 1.4


// This determines the inherent inaccuracy of guns at 0 charge
#define GUN_MAX_INACCURACY_DEG 40

// Final get_chargetime() = max(<floor>, computed) * GUN_AIM_TIME_MULT * <per-weapon mult>
// Lower numbers = faster aim.
// the floor determines the absolute minimum it can go to, good for balancing high skill/perception
// so u can tweak these numbers as you wish in order to achieve whatever vision u desire

#define GUN_AIM_TIME_MULT 0.2
#define GUN_AIM_FLOOR_RIFLE     0.5
#define GUN_AIM_FLOOR_PISTOL    0.5
#define GUN_AIM_FLOOR_REVOLVER  0.1
#define GUN_AIM_FLOOR_SHOTGUN   3

#define GUN_AIM_TIME_MULT_RIFLE     0.66
#define GUN_AIM_TIME_MULT_PISTOL    1.25
#define GUN_AIM_TIME_MULT_REVOLVER  0.1
#define GUN_AIM_TIME_MULT_SHOTGUN   1

// How much weapon skill reduces aim time. 0 = skill irrelevant, 1 = current, 2 = double effect.
#define GUN_AIM_SKILL_INFLUENCE 0
// How much perception reduces aim time. 0 = perception irrelevant, 1 = current, 2 = double effect.
#define GUN_AIM_PER_INFLUENCE   0

/obj/item/gun
	name = "gun"
	desc = ""
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "detective"
	item_state = "gun"
	flags_1 =  CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	possible_item_intents = list(INTENT_GENERIC, RANGED_FIRE)
	throwforce = 5
	throw_speed = 1
	throw_range = 5
	force = 5
	item_flags = NEEDS_PERMIT
	attack_verb = list("struck", "hit", "bashed")

	var/list/fire_sound = list('sound/blank.ogg')
	var/list/dist_fire_sound = list('sound/blank.ogg') //DISTANTLIGHT,DISTANTMEDIUM,DISTANTHEAVY
	var/fire_sound_volume = 50
	var/far_volume = 50 // base volume of distant sounds, should not be higher than 60
	var/dry_fire_sound = 'sound/blank.ogg'
	var/recoil = 0						//boom boom shake the room
	var/clumsy_check = TRUE
	var/obj/item/ammo_casing/chambered = null
	trigger_guard = TRIGGER_GUARD_NORMAL	//trigger guard on the weapon, hulks can't fire them with their big meaty fingers

	var/spread = 0						//Spread induced by the gun itself.
	var/randomspread = 1				//Set to 0 for shotguns. This is used for weapons that don't fire all their bullets at once.

	var/ammo_x_offset = 0 //used for positioning ammo count overlay on sprite
	var/ammo_y_offset = 0
	var/flight_x_offset = 0
	var/flight_y_offset = 0

	var/automatic = 0 //nonfunctional, would be deciseconds between each shot
	var/burst = 1 //amount of boolets to fire, ALSO SET SEMIAUTO PLS
	var/burst_delay = 2 //amount of deciseconds between each shot if bursting
	var/pb_knockback = 0

	var/longarm = FALSE//used to determine if you can shoot it one-handed


/obj/item/gun/Destroy()
	if(chambered) //Not all guns are chambered (EMP'ed energy guns etc)
		QDEL_NULL(chambered)
	return ..()

/obj/item/gun/handle_atom_del(atom/A)
	if(A == chambered)
		chambered = null
		update_icon()
	return ..()

//called after the gun has successfully fired its chambered ammo.
/obj/item/gun/proc/process_chamber()
	return FALSE

//check if there's enough ammo/energy/whatever to shoot one time
//i.e if clicking would make it shoot
/obj/item/gun/proc/can_shoot()
	return TRUE

/obj/item/gun/proc/shoot_with_empty_chamber(mob/living/user as mob|obj)
	to_chat(user, "<span class='danger'>*FUCK!*</span>")
	playsound(src, dry_fire_sound, 30, TRUE)

/obj/item/gun/proc/play_fire_sound(var/mob/user, var/obj/projectile/P)
	var/turf/epicenter = get_turf(user)

	var/frequency = get_rand_frequency()
	for(var/mob/living/M in range(60))
		// Double check for client
		if(M && M.client)
			var/turf/M_turf = get_turf(M)
			if(M_turf && M_turf.z == epicenter.z)
				var/dist = get_dist(M_turf, epicenter)
				var/distant_fire_sound = sound(pick(dist_fire_sound))
				var/dir = get_dir(M_turf, epicenter)
				var/turf/plrsfx = get_ranged_target_turf(M_turf, dir, 6) // DIRECTIONAL SOUND
				if(dist <= 60 && dist >= 7)
					if(dist <= 30)
						far_volume += 40 //if within 30 tiles, make sound louder
					M.playsound_local(plrsfx, null, far_volume, 1, frequency, falloff = 45, S = distant_fire_sound)
	playsound(user, pick(fire_sound), fire_sound_volume)

/obj/item/gun/proc/shoot_live_shot(mob/living/user as mob|obj, pointblank = 0, mob/pbtarget = null, message = 1)
	if(recoil)
		shake_camera(user, recoil + 1, recoil)

	play_fire_sound(user)
	if(message)
		user.visible_message("<span class='danger'>[user] shoots [src]!</span>", \
						"<span class='danger'>I shoot [src]!</span>", \
						COMBAT_MESSAGE_RANGE)

/obj/item/gun/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		for(var/obj/O in contents)
			O.emp_act(severity)

/obj/item/gun/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	testing("gun attack")
	if(!target)
		testing("no target")
		return
	if(!(user.using_object))
		if(!user?.used_intent.tranged) //melee attack
			return
	if(flag) //It's adjacent, is the user, or is on the user's person
		if(target in user.contents) //can't shoot stuff inside us.
			return
		if(!ismob(target)) //melee attack
			testing("gun with melee attack selected")
			return
		if(target == user && user.zone_selected != BODY_ZONE_PRECISE_MOUTH) //so we can't shoot ourselves (unless mouth selected)
			return

	if(istype(user))//Check if the user can use the gun, if the user isn't alive(turrets) assume it can.
		var/mob/living/L = user
		if(!can_trigger_gun(L))
			return

//	if(flag)
//		if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
//			handle_suicide(user, target, params)
//			return

	if(!can_shoot()) //Just because you can pull the trigger doesn't mean it can shoot.
		shoot_with_empty_chamber(user)
		return
	if(longarm == TRUE)
		if(user.get_inactive_held_item() != null)
			to_chat(user, "<span class='warning'>I can't fire [src] one-handed!</span>")
			return	
		

	if(user?.used_intent.arc_check() && target.z != user.z) //temporary fix for openspace arrow dupe
		target = get_turf(locate(target.x, target.y, user.z))

	return process_fire(target, user, TRUE, params, null, 0)


/obj/item/gun/proc/recharge_newshot()
	return


/obj/item/gun/proc/get_effective_spread(mob/living/user)
	var/charge_penalty = 0
	if(user?.client)
		var/prog = clamp(user.client.chargedprog, 0, 100)
		charge_penalty = ((100 - prog) / 100) * GUN_MAX_INACCURACY_DEG
	return max(0, spread + charge_penalty)

/obj/item/gun/proc/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	add_fingerprint(user)

	var/sprd = 0
	var/randomized_gun_spread = 0
	var/eff_spread = get_effective_spread(user)
	if(eff_spread)
		randomized_gun_spread = rand(0, eff_spread)
	var/randomized_bonus_spread = rand(0, bonus_spread)

	if(chambered)
		if(HAS_TRAIT(user, TRAIT_PACIFISM)) // If the user has the pacifist trait, then they won't be able to fire [src] if the round chambered inside of [src] is lethal.
			if(chambered.harmful) // Is the bullet chambered harmful?
				to_chat(user, "<span class='warning'>[src] is lethally chambered! You don't want to risk harming anyone...</span>")
				return
		sprd = round((rand() - 0.5) * DUALWIELD_PENALTY_EXTRA_MULTIPLIER * (randomized_gun_spread + randomized_bonus_spread))
		before_firing(target,user)
		for(var/i in 1 to burst)
			if(!chambered.fire_casing(target, user, params, , FALSE, zone_override, sprd, src))
				shoot_with_empty_chamber(user)
			else
				shoot_live_shot(user, 0, target, message)
			if(i < burst)
				process_chamber()
				sleep(burst_delay)
	else
		shoot_with_empty_chamber(user)
		return
	process_chamber()
	update_icon()

	if(user)
		user.update_inv_hands()
	SSblackbox.record_feedback("tally", "gun_fired", 1, type)
	return TRUE


/obj/item/gun/attackby(obj/item/I, mob/user, params)
	if(!user.used_intent.tranged)
		return ..()
	else
		return ..()

/obj/item/gun/proc/handle_suicide(mob/living/carbon/human/user, mob/living/carbon/human/target, params, bypass_timer)
	if(!ishuman(user) || !ishuman(target))
		return

	if(user == target)
		target.visible_message("<span class='warning'>[user] sticks [src] in [user.p_their()] mouth, ready to pull the trigger...</span>", \
			"<span class='danger'>I stick [src] in your mouth, ready to pull the trigger...</span>")
	else
		target.visible_message("<span class='warning'>[user] points [src] at [target]'s head, ready to pull the trigger...</span>", \
			"<span class='danger'>[user] points [src] at your head, ready to pull the trigger...</span>")

	if(!bypass_timer && (!do_mob(user, target, 120) || user.zone_selected != BODY_ZONE_PRECISE_MOUTH))
		if(user)
			if(user == target)
				user.visible_message("<span class='notice'>[user] decided not to shoot.</span>")
			else if(target && target.Adjacent(user))
				target.visible_message("<span class='notice'>[user] has decided to spare [target]</span>", "<span class='notice'>[user] has decided to spare your life!</span>")
		return

	target.visible_message("<span class='warning'>[user] pulls the trigger!</span>", "<span class='danger'>[(user == target) ? "You pull" : "[user] pulls"] the trigger!</span>")

	if(chambered && chambered.BB)
		chambered.BB.damage *= 5

	process_fire(target, user, TRUE, params, BODY_ZONE_HEAD)

//Happens before the actual projectile creation
/obj/item/gun/proc/before_firing(atom/target,mob/user)
	return


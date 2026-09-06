//KEEP IN MIND: These are different from gun/grenadelauncher. These are designed to shoot premade rocket and grenade projectiles, not flashbangs or chemistry casings etc.
//Put handheld rocket launchers here if someone ever decides to make something so hilarious ~Paprika

/obj/item/gun/ballistic/revolver/grenadelauncher//this is only used for underbarrel grenade launchers at the moment, but admins can still spawn it if they feel like being assholes
	desc = ""
	name = "grenade launcher"
	icon_state = "dshotgun_sawn"
	item_state = "gun"
	fire_sound = 'sound/blank.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	bolt_type = BOLT_TYPE_NO_BOLT
	istrainable = TRUE // For the moment I'll allow these to be traineable until a proper way to level up bows and crossbows is coded. - Foxtrot
	var/damfactor = 1 // Multiplier for projectile damage. Used by bows and crossbows.
	var/accfactor = 1 // Multiplier for projectile accuracy. Used by bows and crossbows.

/obj/item/gun/ballistic/revolver/grenadelauncher/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(istype(A, /obj/item/ammo_box) || istype(A, /obj/item/ammo_casing))
		chamber_round()

/obj/item/gun/ballistic/revolver/flaregun //while under the revolver subtype this IS a launcher and needs a lot of niche code to work
	name = "\improper IFS 40mm grenade launcher"
	desc = "A handheld grenade launcher. Strangely enough, these were found in the LOVE MACHINE, alongside the flares they were made to fire. They can fit 40mm grenades."
	icon = 'icons/roguetown/weapons/32guns.dmi'
	icon_state = "flaregun"
	item_state = "flaregun"
	mag_type = /obj/item/ammo_box/magazine/internal/revolver/flaregun
	slowdown = 0.15
	grid_height = 64
	grid_width = 64
	spread = 0.5
	cartridge_wording = "round"
	fire_sound = GRENADESHOT
	load_sound = 'sound/combat/ranged/hpistol_cock.ogg'
	recoil = 2
	sellprice = 34
	possible_item_intents = list(
		/datum/intent/shoot/revolver,
		/datum/intent/arc/flare,
		INTENT_GENERIC,
		)

/datum/intent/arc/flare
	chargetime = 0.5
	chargedrain = 0
	no_early_release = FALSE

/obj/item/gun/ballistic/revolver/flaregun/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	var/obj/item/ammo_casing/shell = src.magazine.stored_ammo[1]
	if(istype(shell, /obj/item/ammo_casing/a40mm/flareh))
		var/turf/firerlocation = user.loc
		firerlocation.can_see_sky()
		if(firerlocation.can_see_sky != 1)
			to_chat(user, span_warning("I can't fire [src] until I'm outside!"))
			return
		var/turf/aimedturf
		if(isturf(target))
			aimedturf = target
		else
			aimedturf = target.loc
		aimedturf.can_see_sky()
		if(aimedturf.can_see_sky != 1)
			to_chat(user, span_warning("I can't fire [src] at a roof!"))
			return
		if(shell.BB == null)
			to_chat(user, span_warning("I can't fire a spent flare!"))
			return
		playsound(user, 'sound/misc/flaregun_high_fire.ogg', 100)
		shake_camera(user, 2, 1)
		user.visible_message(span_warning("[user] fires [src] into the air!"))
		shell.BB = null
		shell.icon_state += "-spent"
		new /obj/effect/illumination_flare_spawner(aimedturf)  //it's my code and i get to name the variables what i want
	else
		..()

/obj/item/gun/ballistic/revolver/flaregun/process_chamber() //To update to the empty icons
	..()
	var/list/shells = src.magazine.stored_ammo //getting the bullets
	for(var/obj/item/ammo_casing/shell in shells) //should be easy to slap onto other guns. i could probably put this elsewhere but frankly the fact we don't have a way to convert existing shells to spent ones is atrocious enough
		shell.icon_state = "flareh-handful-1-spent" //FYI, if you make this a more general function make sure repacked shells go back to their initial state
		//ALSO YES I NEED SPENT VERSIONS OF ALL THE 40MM SPRITES BEFORE I CAN FIX THIS

/obj/item/gun/ballistic/revolver/purifier //while under the revolver subtype this IS a launcher and needs a lot of niche code to work
	name = "\improper IFS 40mm 'Purifier'"
	desc = "An unholy combination of the MSD Scorcher and the IFS grenade-launcher mechanism. There's an underbarrel acid spraying mechanism, and can fit multiple 40mm grenades. "
	icon = 'icons/roguetown/weapons/32guns.dmi'
	icon_state = "purifier"
	item_state = "purifier"
	mag_type = /obj/item/ammo_box/magazine/internal/revolver/purifier
	slowdown = 0.5
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	longarm = TRUE
	grid_height = 32
	grid_width = 32
	spread = 0.5
	cartridge_wording = "round"
	fire_sound = GRENADESHOT
	load_sound = 'sound/combat/ranged/hpistol_cock.ogg'
	recoil = 2
	sellprice = 34
	experimental_inhand = FALSE
	possible_item_intents = list(
		/datum/intent/shoot/revolver,
		/datum/intent/arc/flare,
		INTENT_GENERIC,
		)

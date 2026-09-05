/datum/job/roguetown/radiotrooper
	title = "Radio Officer"
	flag = RADIOTROOPER
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You're a Radio Officer, typically promoted from Knight Commander. \
				Your main goal is to provide support for the Empire, field-commanding and cooperating with the Grandknight. \
				Your orders give buffs, and your radiopack offers much faster deployment of mortar shells. \
				However, this requires both headset & radiopack in order to function." 

	outfit = /datum/outfit/job/roguetown/radiotrooper
	display_order = JDO_RADIOTROOPER
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_knightcommander.ogg'

/datum/job/roguetown/radiotrooper/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/perserdun))
			var/obj/item/roguekey/perserdun/S = H.wear_ring
			S.set_soldier_name(H)
			for(var/mob/living/carbon/human/P in GLOB.player_list) //Exclusive spawn audio and message for Perserdun and others (IF THEY HAVE THE NAIL OR TAG.)
				if(istype(P.wear_ring, /obj/item/roguekey/))
					var/obj/item/roguekey/R = P.wear_ring
					if(R.type == /obj/item/roguekey/perserdun && P.stat != DEAD)
						to_chat(P, span_notice("You feel an overwhelming sense of duty."))
						playsound(P, 'sound/music/radiospawn.ogg', 100, FALSE)
					if(R.type == /obj/item/roguekey/risvon && P.stat != DEAD)
						to_chat(P, span_warning("You can feel the thump of artillery shake your core."))
						playsound(P, 'sound/music/radiospawn.ogg', 100, FALSE)

/datum/outfit/job/roguetown/radiotrooper/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	beltl = /obj/item/flashlight/flare/torch/lantern
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/radio
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	head = /obj/item/clothing/head/roguetown/paddedcap/radio
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/belt/rogue/pouch/ammobag
	backl = /obj/item/gun/ballistic/rifle/repeater/auto8
	wrists = /obj/item/scomstone/garrison
	id = /obj/item/roguekey/perserdun
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	backr = /obj/item/storage/backpack/rogue/satchel/radiopack
	r_hand = /obj/item/gun/ballistic/revolver/flaregun
	backpack_contents = list(
		/obj/item/ammo_box/handfuls/shotgun/buckshot = 6,
		/obj/item/storage/belt/rogue/pouch/coins/mid,
		/obj/item/ammo_box/handfuls/a40mm/he = 2,
		/obj/item/ammo_box/handfuls/a40mm/frag = 2,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shotguns, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/holding)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/aim)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/charge)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/radiomortar)
	H.change_stat("strength", 1)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 2)
	H.change_stat("perception", 2)
	H.change_stat("speed", 3)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)

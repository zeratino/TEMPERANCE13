/datum/job/roguetown/flamsoldato
	title = "Flamsoldato"
	flag = FLAMSOLDATO
	department_flag = RISVON
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You've walked down the path of Zipra, fully committing yourself to Bloodshed. \
				You're usually transferred from Kaspafisto, or promoted from Bastiono. \
				You're about equal rank to a Kaspafisto.\
				Your main purpose is to kill." 

	outfit = /datum/outfit/job/roguetown/flamsoldato
	display_order = JDO_FLAMSOLDATO
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_flamsoldato.ogg'

/datum/job/roguetown/flamsoldato/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/risvon))
			var/obj/item/roguekey/risvon/S = H.wear_ring
			S.set_soldier_name(H)

/datum/outfit/job/roguetown/flamsoldato/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/flamer
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/flamer
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/flamer
	head = /obj/item/clothing/head/roguetown/helmet/leather/flamer
	mask = /obj/item/clothing/mask/rogue/gasmask/risvonmask
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/belt/rogue/pouch/ammobag/amr/flamer
	wrists = /obj/item/scomstone
	gloves = /obj/item/clothing/gloves/roguetown/leather/flamer
	id = /obj/item/roguekey/risvon
	backr = /obj/item/storage/backpack/rogue/backpack/risvon
	backl = /obj/item/gun/ballistic/rifle/flamer
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/mid,
		/obj/item/ammo_box/magazine/flamer = 3,
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
	H.adjust_skillrank(/datum/skill/combat/rifles, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOFIRE, TRAIT_GENERIC)

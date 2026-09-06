/datum/job/roguetown/grandknight
	title = "Grand Knight"
	flag = GRANDKNIGHT
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You're the right hand man of the Grandmaster. Essentially a combative Lieutenant. \
				Your main goal is to act as a force multiplier for the Perserdunians.\
				You do this by bringing up the rear in charges & dealing with stragglers. \
				Typically, Grand Knights are selected from the few pre-machine noble lineages that remain within the Empire. \
				Grand Knights are unique in that they are a symbolic representation of the pre-machine Empire's strength." 

	outfit = /datum/outfit/job/roguetown/grandknight
	display_order = JDO_GRANDKNIGHT
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_grandknight.ogg'

/datum/job/roguetown/grandknight/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/perserdun))
			var/obj/item/roguekey/perserdun/S = H.wear_ring
			S.set_soldier_name(H)

/datum/outfit/job/roguetown/grandknight/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/grandknight
	beltl = /obj/item/flashlight/flare/torch/lantern
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full/iron
	cloak = /obj/item/clothing/cloak/perserduntabard/grandknight
	pants = /obj/item/clothing/under/roguetown/platelegs/iron
	head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket/iron
	mask = /obj/item/clothing/mask/rogue/gasmask/perserdunmask
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/grenade/gas/poison
	backl = /obj/item/rogueweapon/stoneaxe/oath
	wrists = /obj/item/scomstone/perlead/lesser
	gloves = /obj/item/clothing/gloves/roguetown/plate/iron
	id = /obj/item/roguekey/perserdun
	backr = /obj/item/storage/backpack/rogue/backpack/perserdun
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/rich,
		/obj/item/grenade/gas/poison,
		/obj/item/bomb/dynamite,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE) //test 2 see if it's broken
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.change_stat("strength", 2)
	H.change_stat("constitution", 3)
	H.change_stat("endurance", 3)
	H.change_stat("perception", 2)
	H.change_stat("intelligence", 2)
	H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC) //i swear this isn't as good as it sounds

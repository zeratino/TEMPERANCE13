/datum/job/roguetown/lumberjackrebel
	title = "Rebel Lumberjack"
	flag = LUMBERJACKREBEL
	department_flag = REBELS
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	allowed_races = RACES_CONSCRIPT_NONCOMBATANT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	agevet_req = FALSE

	tutorial = "You cut wood. You chop wood. You sell wood. The swing of an axe is second nature to you. \
				Now? You serve the rebel cause as a frontline fighter, splintering skulls with the same axe you splintered trees. \
				Your robust physique allows you to equip and wear chainmaille and medium plate." 

	outfit = /datum/outfit/job/roguetown/lumberjackrebel
	display_order = JDO_LUMBERJACKREBEL
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_blackoak.ogg'

/datum/outfit/job/roguetown/lumberjackrebel/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE) // AXE MEN! GIVE ME SPLINTERS!
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/lumberjacking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	head = /obj/item/clothing/head/roguetown/articap
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/rogueweapon/stoneaxe/battle
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/scomstone/kingsrow
	beltr = /obj/item/rogueweapon/handsaw
	beltl = /obj/item/rogueweapon/hammer/wood
	backpack_contents = list(
						/obj/item/flint = 1,
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/rogueweapon/huntingknife = 1,
						/obj/item/recipe_book/builder = 1,
						/obj/item/recipe_book/survival = 1,
						)
	armor = /obj/item/clothing/suit/roguetown/armor/leather/trophyfur
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	H.change_stat("strength", 2)
	H.change_stat("endurance", 3)
	H.change_stat("constitution", 2)
	H.change_stat("perception", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

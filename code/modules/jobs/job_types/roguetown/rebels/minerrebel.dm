/datum/job/roguetown/minerrebel
	title = "Rebel Miner"
	flag = MINERREBEL
	department_flag = REBELS
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	allowed_races = RACES_CONSCRIPT_NONCOMBATANT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	agevet_req = FALSE

	tutorial = "Swing the pick. Heave. Swing. Heave. Deep underground where the days lose their meaning, \
				the work is grueling, the tunnels cramped, and the stale air full of coal dust. \
				Finally, you've had enough. Underpaid, underfed, and certainly underappreciated, you've joined a cause that sees you for who you are. \
				Your eyes are adjusted to the dark, and your sturdy build allows you to bear the burden of heavy plate armor with ease."

	outfit = /datum/outfit/job/roguetown/minerrebel
	display_order = JDO_MINERREBEL
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_gronn.ogg'

/datum/outfit/job/roguetown/minerrebel/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/articap
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/pick/steel
	beltr = /obj/item/rogueweapon/huntingknife
	backl = /obj/item/storage/backpack/rogue/backpack
	wrists = /obj/item/scomstone/kingsrow
	armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/artijacket
	backpack_contents = list(
						/obj/item/flint = 1,
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/rogueweapon/chisel = 1, 
						/obj/item/rogueweapon/hammer/wood = 1,
						/obj/item/recipe_book/builder = 1,
						/obj/item/bomb/dynamite = 3,
						/obj/item/bomb/satchel = 2,
						)
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) // Tough. Well fed. The strongest of the strong.
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mining, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/smelting, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.change_stat("strength", 2)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)
	H.change_stat("fortune", 2)
	ADD_TRAIT(H, TRAIT_DARKVISION, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

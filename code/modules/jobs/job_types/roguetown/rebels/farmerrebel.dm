/datum/job/roguetown/farmerrebel
	title = "Rebel Farmer"
	flag = FARMERREBEL
	department_flag = REBELS
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	selection_color = JCOLOR_PEASANT
	display_order = JDO_FARMERREBEL
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	cmode_music = 'sound/music/combat_shaman2.ogg'
	agevet_req = FALSE

	tutorial = "You used to live a simple life. You had a farm, perhaps a loving partner, and plenty of cattle and crops to tend to. But the Empire and their damned wars, taxes, and conscriptions left you with nothing. You are a Rebel Farmer, a simple fellow who has taken up arms to fight back against the Empire. You may not have the training of a soldier, but you have the heart of a fighter. You will use whatever means necessary to defend your home and your people."


	outfit = /datum/outfit/job/roguetown/farmerrebel
	give_bank_account = 17
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/farmerrebel/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/articap
	mask = /obj/item/clothing/head/roguetown/roguehood
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/scomstone/kingsrow
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/storage/keyring/soilson
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/flint = 1,
		)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE) //So they can actually even craft their makeshift weapons
	H.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	if(H.age == AGE_OLD)//So ppl have reason to pick this I guess?
		H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
	H.change_stat("strength", 2)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 2)
	H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

	pants = /obj/item/clothing/under/roguetown/tights/random
	armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/artijacket
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random

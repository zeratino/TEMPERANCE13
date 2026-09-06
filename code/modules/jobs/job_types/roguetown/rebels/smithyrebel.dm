/datum/job/roguetown/smithyrebel
	title = "Rebel Smithy"
	flag = SMITHYREBEL
	department_flag = REBELS
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	selection_color = JCOLOR_PEASANT
	display_order = JDO_SMITHYREBEL
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	cmode_music = 'sound/music/combat_gronn.ogg'
	agevet_req = FALSE

	tutorial = "Your skills once armed the Perserdunian forces with tempered iron - but now, through one grudge or another, you've joined the rebel cause, and now arm them with your crafted weapons and armor."

	outfit = /datum/outfit/job/roguetown/smithyrebel
	give_bank_account = 25
	min_pq = -10
	max_pq = null
	cmode_music = 'sound/music/combat_gronn.ogg'

/datum/outfit/job/roguetown/smithyrebel/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/hatfur
	gloves = /obj/item/clothing/gloves/roguetown/angle/grenzelgloves/blacksmith
	wrists = /obj/item/scomstone/kingsrow
	ADD_TRAIT(H, TRAIT_TRAINED_SMITH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/hatblu
	H.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/blacksmithing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/smelting, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE) // 1 Engineering to allow them to sub for Artificer role occaisonally
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/smelting, 1, TRUE)
	if(should_wear_femme_clothes(H))
		pants = /obj/item/clothing/under/roguetown/trou
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		backr = /obj/item/storage/backpack/rogue/satchel
		backpack_contents = list(
			/obj/item/rogueweapon/hammer/iron = 1,
			/obj/item/rogueweapon/tongs = 1,
			/obj/item/recipe_book/blacksmithing = 1,
			)
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
		cloak = /obj/item/clothing/cloak/apron/blacksmith
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	else if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/trou
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		backr = /obj/item/storage/backpack/rogue/satchel
		backpack_contents = list(
			/obj/item/rogueweapon/hammer/iron = 1,
			/obj/item/rogueweapon/tongs = 1,
			/obj/item/recipe_book/blacksmithing = 1,
			)
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		cloak = /obj/item/clothing/cloak/apron/blacksmith

	H.change_stat("strength", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)

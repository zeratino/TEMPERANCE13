/datum/job/roguetown/cookrebel
	title = "Rebel Cook"
	flag = COOKREBEL
	department_flag = REBELS
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	selection_color = JCOLOR_PEASANT
	display_order = JDO_COOKREBEL
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	cmode_music = 'sound/music/combat_jester.ogg'
	agevet_req = FALSE

	tutorial = "There are many mouths to feed in town, and most look to you for it. Although you once worked for innkeepers and tavern owners, you have now joined the rebel cause, and your culinary skills are needed to keep the rebels fed."
	outfit = /datum/outfit/job/roguetown/cookrebel
	give_bank_account = 25
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/cookrebel/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE) //SS13 CHEF REFERENCE
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
	if(H.age == AGE_MIDDLEAGED)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	cloak = /obj/item/clothing/cloak/apron/cook
	head = /obj/item/clothing/head/roguetown/cookhat
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	wrists = /obj/item/scomstone/kingsrow
	shirt = /obj/item/clothing/suit/roguetown/shirt/officeshirt3
	pants = /obj/item/clothing/under/roguetown/tights/black
	backpack_contents = list(
		/obj/item/reagent_containers/powder/salt = 3,
		/obj/item/reagent_containers/food/snacks/rogue/cheddar = 2,
		/obj/item/natural/cloth = 2,
		/obj/item/book/rogue/yeoldecookingmanual = 1,
		/obj/item/rogueweapon/huntingknife/chefknife = 1,
	)
	H.change_stat("constitution", 2)
	H.change_stat("strength", 2)
	H.change_stat("intelligence", 3) //5 points (weighted)
	ADD_TRAIT(H, TRAIT_CICERONE, TRAIT_GENERIC)

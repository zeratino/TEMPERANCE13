/datum/job/roguetown/hunterrebel
	title = "Rebel Hunter"
	flag = HUNTERREBEL
	department_flag = REBELS
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	selection_color = JCOLOR_PEASANT
	display_order = JDO_HUNTERREBEL
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	cmode_music = 'sound/music/combat_blackoak.ogg'
	agevet_req = FALSE

	tutorial = "You were a hunter, although such a term means little anymore, with the Empire encroaching on every corner of the land. You are a Rebel Hunter, skilled in tracking, trapping, and surviving in the wild. You will use your abilities to fight back against the Empire and protect your home."


	outfit = /datum/outfit/job/roguetown/hunterrebel
	give_bank_account = 17
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/hunterrebel/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	wrists = /obj/item/scomstone/kingsrow
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/quiver/arrows
	beltl = /obj/item/rogueweapon/scabbard/sword
	l_hand = /obj/item/rogueweapon/sword/iron/messer
	r_hand = /obj/item/storage/meatbag
	backpack_contents = list(
						/obj/item/flint = 1,
						/obj/item/bait = 1,
						/obj/item/rogueweapon/huntingknife = 1,
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/flashlight/flare/torch/lantern = 1,
						/obj/item/recipe_book/leatherworking = 1,
						/obj/item/rogueweapon/scabbard/sheath = 1
						)
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
	ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)

	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/rifles, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 3)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 2)
	H.change_stat("speed", 2)

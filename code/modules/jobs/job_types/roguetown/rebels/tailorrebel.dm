/datum/job/roguetown/tailorrebel
	title = "Rebel Tailor"
	flag = TAILORREBEL
	department_flag = REBELS
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	selection_color = JCOLOR_PEASANT
	display_order = JDO_TAILORREBEL
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	agevet_req = FALSE

	tutorial = "You have worked sleepless nights on honing your craft. From sacks, to tapestry and luxurious clothing, there is little you cannot sew into existence. How demeaning, now, that you've been employed by the rebel cause to mend their tattered gambesons."

	outfit = /datum/outfit/job/roguetown/tailorrebel
	give_bank_account = 25
	min_pq = -10
	max_pq = null
	cmode_music = 'sound/music/combat_noble.ogg'

/datum/outfit/job/roguetown/tailorrebel/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	shirt = /obj/item/clothing/suit/roguetown/shirt/officeshirt1
	pants = /obj/item/clothing/under/roguetown/tights
	belt = /obj/item/storage/belt/rogue/leather/cloth
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/rogueweapon/huntingknife/scissors/steel
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	wrists = /obj/item/scomstone/kingsrow
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/needle, 
		/obj/item/dye_brush, 
		/obj/item/recipe_book/sewing, 
		/obj/item/recipe_book/leatherworking
		)
	H.change_stat("intelligence", 3)
	H.change_stat("perception", 3)
	H.change_stat("speed", 2)
	H.change_stat("strength", -1)

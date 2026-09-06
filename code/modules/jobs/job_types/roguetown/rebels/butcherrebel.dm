/datum/job/roguetown/butcherrebel
	title = "Rebel Butcher"
	flag = BUTCHERREBEL
	department_flag = REBELS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	agevet_req = FALSE

	allowed_races = RACES_ALL_KINDS
	allowed_ages = ALL_AGES_LIST
	tutorial = "You are a butcher - a master of butchering, chopping, and preserving animal meat. Although many considered you an odd savant, you've found your calling as a crucial member of the rebel cause - your skills in meat preservation ensures your fellow rebels never go hungry."
	cmode_music = 'sound/music/combat_gronn.ogg'

	outfit = /datum/outfit/job/roguetown/butcherrebel
	display_order = JDO_BUTCHERREBEL
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/butcherrebel/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 5, TRUE)
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/huntingknife/cleaver // old tbutcher had no knife. as a butcher.
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	cloak = /obj/item/clothing/cloak/apron
	wrists = /obj/item/scomstone/kingsrow
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/officeshirt5
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	backpack_contents = list(
						/obj/item/kitchen/spoon,
						/obj/item/reagent_containers/food/snacks/rogue/truffles,
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/recipe_book/survival = 1,
						/obj/item/reagent_containers/food/snacks/fat = 2, // make sausages :)
						)

	H.change_stat("strength", 2)	//Stat spread is decent; not great but decent. 
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

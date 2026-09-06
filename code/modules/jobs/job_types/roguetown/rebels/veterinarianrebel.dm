/datum/job/roguetown/veterinarianrebel
	title = "Rebel Veterinarian"
	flag = VETERINARIANREBEL
	department_flag = REBELS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	selection_color = JCOLOR_PEASANT
	display_order = JDO_VETERINARIANREBEL
	agevet_req = FALSE

	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	tutorial = "You were a Veterinarian - a medical professional who mostly tended to injured cattle. \
		Every other doctor has been coerced into the Perserdunian army as medical personnel. Only you stayed. \
		With the REAL doctors gone, the Rebels seek to you as the closest thing to a doctor, shoving you toward the now-abandoned clinic. \
		You were never meant to treat humans, but you've sworn an oath to do no harm. Get to work."
	outfit = /datum/outfit/job/roguetown/veterinarianrebel

	give_bank_account = 30
	min_pq = -3 
	max_pq = null
	round_contrib_points = 3

	cmode_music = 'sound/music/combat_physician.ogg'

/datum/outfit/job/roguetown/veterinarianrebel/pre_equip(mob/living/carbon/human/H)
	..()
	mask = /obj/item/clothing/mask/rogue/sterilemask
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/freifechter
	gloves = /obj/item/clothing/gloves/roguetown/leather/latex
	pants = /obj/item/clothing/under/roguetown/tights
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	cloak = /obj/item/clothing/cloak/apron/blacksmith
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/belt/rogue/surgery_bag/full/physician
	beltr = /obj/item/storage/belt/rogue/pouch/stim
	wrists = /obj/item/scomstone/kingsrow
	backl = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(
		/obj/item/reagent_containers/pill/patch/syringe/health = 2,
		/obj/item/reagent_containers/pill/patch/syringe/painkiller,
		/obj/item/storage/belt/rogue/pouch/pillbottle,
		/obj/item/natural/worms/leech/cheele = 1, //little buddy
		/obj/item/reagent_containers/glass/bottle/waterskin = 1,
		/obj/item/recipe_book/alchemy = 1,
	)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CICERONE, TRAIT_GENERIC)
	H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE) 
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 6, TRUE)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
	H.change_stat("strength", -1)
	H.change_stat("constitution", -1)
	H.change_stat("intelligence", 4)
	H.change_stat("fortune", 1)
	H.change_stat("endurance", 1)
	if(H.age == AGE_MIDDLEAGED)
		H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE) //small carrot to play old
		H.change_stat("speed", -1)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 1)

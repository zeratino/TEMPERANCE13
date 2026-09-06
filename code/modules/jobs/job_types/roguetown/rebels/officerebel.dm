/datum/job/roguetown/officerebel
	title = "Rebel Office Worker"
	flag = OFFICEREBEL
	department_flag = REBELS
	faction = "Station"
	total_positions = 10
	spawn_positions = 10
	allowed_races = RACES_CONSCRIPT_NONCOMBATANT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	agevet_req = FALSE

	tutorial = "Another disgruntled white-collar nobody - you aren't much of a fighter, but you make up the bulk of the rebellion forces. \
				An officer worker in the Vos Arderla bursar's office, you handled the paperwork for the Empire's war effort, \
				day by day, organizing the projected death tolls, casualty rates, and other grim statistics. \
				Eventually, you reached a breaking point - you could no longer bear the Empire's indifference to the suffering it caused. No more."

	outfit = /datum/outfit/job/roguetown/officerebel
	display_order = JDO_OFFICEREBEL
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/inquisitorcombat.ogg'

/datum/outfit/job/roguetown/officerebel/pre_equip(mob/living/carbon/human/H)
	shoes = /obj/item/clothing/shoes/roguetown/boots/otavan
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
	shirt = /obj/item/clothing/suit/roguetown/shirt/officeshirt4
	head = /obj/item/clothing/head/roguetown/headband
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	wrists = /obj/item/scomstone/kingsrow
	gloves = /obj/item/clothing/gloves/roguetown/otavan
	backr = /obj/item/storage/backpack/rogue/satchel/short
	backpack_contents = list(
		/obj/item/lockpickring/mundane = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/redwine = 2,
		/obj/item/bomb/molotov = 3,
	)
	H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NIGHT_OWL, TRAIT_GENERIC) 
	H.change_stat("intelligence", 4)
	H.change_stat("perception", 3)
	H.change_stat("speed", 3)
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/officeshirt1
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/officeshirt2
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/officeshirt3
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/officeshirt4
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/officeshirt5

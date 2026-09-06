/datum/job/roguetown/rebelleader
	title = "Rebel Leader"
	flag = REBELLEADER
	department_flag = REBELS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_CONSCRIPT_NONCOMBATANT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	agevet_req = FALSE

	tutorial = "You're nobody special - you simply had the charisma to inspire others, and managed to discover a MACHINE compound beneath your home. \
				Arming the others with communication rings, you've found yourself in the position of leading the rebellion of Vos Arderla; \
				Your fellow rebels look up to you for strength, strategy, and leadership. \
				Fashioned with a crimson cloak and a crown of roses, you stand as a symbol of defiance against the Empire."

	outfit = /datum/outfit/job/roguetown/rebelleader
	display_order = JDO_REBELLEADER
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_midsomber.ogg'

/datum/outfit/job/roguetown/rebelleader/pre_equip(mob/living/carbon/human/H)
	shoes = /obj/item/clothing/shoes/roguetown/grenzelhoft/black
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/freifechter/black
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/freifechter
	cloak = /obj/item/clothing/cloak/half/rebel
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan/generic/black
	head = /obj/item/clothing/head/roguetown/inqhat
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/steel
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/rogueweapon/sword/rapier/aliseo
	mask = /obj/item/clothing/mask/rogue/duelmask/red
	wrists = /obj/item/scomstone/kingsrow
	gloves = /obj/item/clothing/gloves/roguetown/angle/grenzelgloves
	backr = /obj/item/storage/backpack/rogue/satchel/short
	backpack_contents = list(
		/obj/item/lockpickring/mundane = 1,
		/obj/item/storage/belt/rogue/pouch/stim = 1,
		/obj/item/bomb/molotov = 3,
	)
	H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/revolvers, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/pistols, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/rifles, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NIGHT_OWL, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/holding/rebel)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/aim/rebel)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/charge/rebel)
	H.change_stat("endurance", 3)
	H.change_stat("constitution", 2)
	H.change_stat("intelligence", 4)
	H.change_stat("perception", 2)
	H.change_stat("speed", 3)

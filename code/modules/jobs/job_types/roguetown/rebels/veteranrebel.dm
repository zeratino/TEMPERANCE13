/datum/job/roguetown/veteranrebel
	title = "Rebel Veteran"
	flag = VETERANREBEL
	department_flag = REBELS
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_races = RACES_CONSCRIPT_NONCOMBATANT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	agevet_req = FALSE

	tutorial = "You did your part in the war, but you were given a medical discharge - a bullet to the knee. Damn Kaspas. \
				Your early retirement meant nothing to the Empire - they left you with nothing but the clothes on your back and a limp knee. \
				Stewing in hate and bitterness at the Empire's abandonment, you join the local resistance. \
				You may be crippled, but you're one of the only rebels around with actual combat experience - the rebels look to you for field leadership." 

	outfit = /datum/outfit/job/roguetown/veteranrebel
	display_order = JDO_VETERANREBEL
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_shaman2.ogg'

/datum/outfit/job/roguetown/veteranrebel/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	cloak = /obj/item/clothing/cloak/stabard
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	mask = /obj/item/clothing/mask/rogue/gasmask/perserdunmask
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
	head = /obj/item/clothing/head/roguetown/helmet/sallet/visored/iron
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/gun/ballistic/revolver/snub
	wrists = /obj/item/scomstone/kingsrow
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	backr = /obj/item/storage/backpack/rogue/backpack/perserdun
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/poor,
		/obj/item/grenade/gas/poison,
		/obj/item/grenade/frag = 3,
		/obj/item/ammo_box/speedloader/snub = 6,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/blacksmithing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/smelting, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/rifles, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/revolvers, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 2)
	H.change_stat("perception", 2)
	H.change_stat("speed", -3)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/holding/rebel)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/aim/rebel)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/charge/rebel)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
